class read_write_test extends uvm_test;
	
/*******Properties Declaration*******/
  
  // creating a handle of environment & sequence class
  env env_h;
  write_seq write_seq_h;
  read_seq  read_seq_h;

/*******factory registration*******/
  `uvm_component_utils(read_write_test)
	
/*******Methods Prototypes Declaration*******/

  extern function new(string name="read_write_test", uvm_component parent=null);

  extern function void build_phase(uvm_phase phase);

  extern function void end_of_elaboration_phase(uvm_phase phase);

  extern task run_phase(uvm_phase phase);

endclass : read_write_test

/*******Methods Declaration*******/

// function: new
function read_write_test :: new(string name = "read_write_test", uvm_component parent=null);
  // call parent method using super.new
  super.new(name, parent);
endfunction : new

// function: build_phase
function void read_write_test::build_phase(uvm_phase phase);
  // call parent method using super.build_phase
  super.build_phase(phase);
  `uvm_info("TEST","Inside build phase",UVM_NONE);
  // Allocate Memory to environment class 
  env_h       = env    :: type_id :: create("env_h", this);
  write_seq_h = write_seq :: type_id :: create("write_seq_h", this);
  read_seq_h  = read_seq  :: type_id :: create("read_seq_h", this);
endfunction : build_phase   

// function: end_of_elaboration_phase
function void read_write_test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  print();
endfunction : end_of_elaboration_phase

task read_write_test::run_phase(uvm_phase phase);
  repeat(16)
  begin
    phase.raise_objection(this);
    read_seq_h.start(env_h.agent_h.seqr_h);
    phase.drop_objection(this);
  end
  phase.raise_objection(this);
  write_seq_h.start(env_h.agent_h.seqr_h);
  phase.drop_objection(this);
  phase.phase_done.set_drain_time(this,25);
endtask : run_phase
