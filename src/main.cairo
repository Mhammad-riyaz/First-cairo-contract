%lang starknet
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import (get_caller_address, get_contract_address)

struct details{
    s_name:felt,
    s_age:felt,
    s_gender:felt,
}
@storage_var
func adminAddress() -> (res: felt) {
}
@storage_var
func student(studentAddress:felt) -> (res:details) {
}



@external
func store_details{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    name: felt, age:felt,gender:felt
) {
    let (caller) = get_caller_address();
    student.write(caller,details(name,age,gender));
    return ();
}

@view
func get_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(s_addres:felt) -> (res: felt) {
    let (detailss) = student.read(s_addres);
    let x = detailss.s_name;
    return (x,);
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
address :felt) {
    adminAddress.write(address);
    return ();
}
