// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// CHECK:STDERR: fail_todo_param_in_type.carbon:[[@LINE+3]]:24: ERROR: Semantics TODO: `symbolic array bound`.
// CHECK:STDERR: fn F(N:! i32, a: [i32; N]*);
// CHECK:STDERR:                        ^
fn F(N:! i32, a: [i32; N]*);

// CHECK:STDOUT: --- fail_todo_param_in_type.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %N: i32 = bind_symbolic_name N 0 [symbolic]
// CHECK:STDOUT:   %F: type = fn_type @F [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct: F = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .F = %F.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %F.decl: F = fn_decl @F [template = constants.%struct] {
// CHECK:STDOUT:     %N.loc10_6.1: i32 = param N
// CHECK:STDOUT:     @F.%N: i32 = bind_symbolic_name N 0, %N.loc10_6.1 [symbolic = constants.%N]
// CHECK:STDOUT:     %N.ref: i32 = name_ref N, @F.%N [symbolic = constants.%N]
// CHECK:STDOUT:     %.loc10_25: type = array_type %N.ref, i32 [template = <error>]
// CHECK:STDOUT:     %.loc10_26: type = ptr_type <error> [template = <error>]
// CHECK:STDOUT:     %a.loc10_15.1: <error> = param a
// CHECK:STDOUT:     @F.%a: <error> = bind_name a, %a.loc10_15.1
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F(%N: i32, %a: <error>);
// CHECK:STDOUT:
