(** Copyright 2024, Kostya Oreshin and Nikita Shchutskii *)

(** SPDX-License-Identifier: MIT *)

type binder = int [@@deriving show { with_path = false }]

module VarSet = struct
  include Stdlib.Set.Make (Int)

  let pp ppf s =
    Format.fprintf ppf "[ ";
    iter (Format.fprintf ppf "%d; ") s;
    Format.fprintf ppf "]"
  ;;
end

type binder_set = VarSet.t [@@deriving show { with_path = false }]

type ty =
  | Ty_unit
  | Ty_prim of string
  | Ty_var of binder
  | Ty_arrow of ty * ty
  | Ty_list of ty
  | Ty_tuple of ty list
  | Ty_tree of ty
[@@deriving show { with_path = false }]

type scheme = S of binder_set * ty [@@deriving show { with_path = false }]

type error =
  [ `Occurs_check
  | `No_variable of string
  | `Unification_failed of ty * ty
  ]
