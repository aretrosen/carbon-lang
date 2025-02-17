// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

interface I {
  fn F();
}

class C {
  alias F = I.F;
}

fn F(c: C) {
  // CHECK:STDERR: fail_alias_impl_not_found.carbon:[[@LINE+4]]:3: ERROR: Cannot access member of interface I in type C that does not implement that interface.
  // CHECK:STDERR:   C.F();
  // CHECK:STDERR:   ^~~
  // CHECK:STDERR:
  C.F();
  // CHECK:STDERR: fail_alias_impl_not_found.carbon:[[@LINE+3]]:3: ERROR: Cannot access member of interface I in type C that does not implement that interface.
  // CHECK:STDERR:   c.F();
  // CHECK:STDERR:   ^~~
  c.F();
}

// CHECK:STDOUT: --- fail_alias_impl_not_found.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: type = interface_type @I [template]
// CHECK:STDOUT:   %Self: I = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %F.1: type = fn_type @F.1 [template]
// CHECK:STDOUT:   %.2: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: F = struct_value () [template]
// CHECK:STDOUT:   %.3: type = assoc_entity_type @I, F [template]
// CHECK:STDOUT:   %.4: <associated F in I> = assoc_entity element0, @I.%F.decl [template]
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %.5: type = struct_type {} [template]
// CHECK:STDOUT:   %F.2: type = fn_type @F.2 [template]
// CHECK:STDOUT:   %struct.2: F = struct_value () [template]
// CHECK:STDOUT:   %.6: type = ptr_type {} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .I = %I.decl
// CHECK:STDOUT:     .C = %C.decl
// CHECK:STDOUT:     .F = %F.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %I.decl: type = interface_decl @I [template = constants.%.1] {}
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {}
// CHECK:STDOUT:   %F.decl: F = fn_decl @F.2 [template = constants.%struct.2] {
// CHECK:STDOUT:     %C.ref: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %c.loc15_6.1: C = param c
// CHECK:STDOUT:     @F.2.%c: C = bind_name c, %c.loc15_6.1
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @I {
// CHECK:STDOUT:   %Self: I = bind_symbolic_name Self 0 [symbolic = constants.%Self]
// CHECK:STDOUT:   %F.decl: F = fn_decl @F.1 [template = constants.%struct.1] {}
// CHECK:STDOUT:   %.loc8: <associated F in I> = assoc_entity element0, %F.decl [template = constants.%.4]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = %Self
// CHECK:STDOUT:   .F = %.loc8
// CHECK:STDOUT:   witness = (%F.decl)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C {
// CHECK:STDOUT:   %I.ref: type = name_ref I, file.%I.decl [template = constants.%.1]
// CHECK:STDOUT:   %F.ref: <associated F in I> = name_ref F, @I.%.loc8 [template = constants.%.4]
// CHECK:STDOUT:   %F: <associated F in I> = bind_alias F, @I.%.loc8 [template = constants.%.4]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%C
// CHECK:STDOUT:   .F = %F
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F.1();
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F.2(%c: C) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %C.ref: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:   %F.ref.loc20: <associated F in I> = name_ref F, @C.%F [template = constants.%.4]
// CHECK:STDOUT:   %c.ref: C = name_ref c, %c
// CHECK:STDOUT:   %F.ref.loc24: <associated F in I> = name_ref F, @C.%F [template = constants.%.4]
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
