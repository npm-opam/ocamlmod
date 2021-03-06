(******************************************************************************)
(* ocamlmod: Generate OCaml modules from source files                         *)
(*                                                                            *)
(* Copyright (C) 2011, OCamlCore SARL                                         *)
(* Copyright (C) 2013, Sylvain Le Gall                                        *)
(*                                                                            *)
(* This library is free software; you can redistribute it and/or modify it    *)
(* under the terms of the GNU Lesser General Public License as published by   *)
(* the Free Software Foundation; either version 2.1 of the License, or (at    *)
(* your option) any later version, with the OCaml static compilation          *)
(* exception.                                                                 *)
(*                                                                            *)
(* This library is distributed in the hope that it will be useful, but        *)
(* WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY *)
(* or FITNESS FOR A PARTICULAR PURPOSE. See the file COPYING for more         *)
(* details.                                                                   *)
(*                                                                            *)
(* You should have received a copy of the GNU Lesser General Public License   *)
(* along with this library; if not, write to the Free Software Foundation,    *)
(* Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA              *)
(******************************************************************************)

let ocamlmod_str = "ocamlmod";;
let ocamlmod = A ocamlmod_str;;

rule "ocamlmod: %.mod -> %.ml"
  ~prod:"%.ml"
  ~deps:["%.mod"; ocamlmod_str]
  begin
    fun env build ->
      let modfn =
        env "%.mod"
      in
      let dirname =
        Pathname.dirname modfn
      in
        depends_from_file
          env
          build
          ~fmod:(fun fn -> dirname/fn)
          modfn;
        Cmd(S[ocamlmod;
              P(modfn)])
  end
;;
