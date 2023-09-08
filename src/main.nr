use dep::std;
use dep::ecrecover;

mod merkle;

fn main(
  pub_key_x: [u8; 32],
  pub_key_y: [u8; 32],
  signature: [u8; 64],
  hashed_message: pub [u8; 32],
  index : Field,
  path : [Field; 1], 
  root : pub Field
){
  let address = ecrecover::ecrecover(pub_key_x, pub_key_y, signature, hashed_message);
  let leaf = std::hash::poseidon::bn254::hash_1([address]);
  let merkle_root = merkle::compute_merkle_root(leaf, index, path);
  assert(merkle_root == root);
}