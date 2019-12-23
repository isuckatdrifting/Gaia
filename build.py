import os
from string import Template
dir_path = os.path.dirname(os.path.abspath(__file__))
output_path = dir_path + '/build/'
if not os.path.exists(output_path):
    os.makedirs(output_path)
template_path = dir_path + '/template/'
template_dict = {   'base_test':    template_path + 'base_test.sv', 
                    'agent':        template_path + 'top_agent.sv',
                    'driver':       template_path + 'top_driver.sv',
                    'env':          template_path + 'top_env.sv',
                    'if':           template_path + 'top_if.sv',
                    'model':        template_path + 'top_model.sv',
                    'monitor':      template_path + 'top_monitor.sv',
                    'scoreboard':   template_path + 'top_scoreboard.sv',
                    'sequence':     template_path + 'top_sequence.sv',
                    'sequencer':    template_path + 'top_sequencer.sv',
                    'tb':           template_path + 'top_tb.sv',
                    'testcase':     template_path + 'top_testcase.sv',
                    'transaction':  template_path + 'top_transaction.sv',
                    'run_tcl':      template_path + 'run_top.tcl',
                    'shm_tcl':      template_path + 'shm.tcl',
                    'filelist':     template_path + 'top_filelist.f'}

output_dict =   {   'base_test':    output_path + 'base_test.sv', 
                    'agent':        output_path + 'top_agent.sv',
                    'driver':       output_path + 'top_driver.sv',
                    'env':          output_path + 'top_env.sv',
                    'if':           output_path + 'top_if.sv',
                    'model':        output_path + 'top_model.sv',
                    'monitor':      output_path + 'top_monitor.sv',
                    'scoreboard':   output_path + 'top_scoreboard.sv',
                    'sequence':     output_path + 'top_sequence.sv',
                    'sequencer':    output_path + 'top_sequencer.sv',
                    'tb':           output_path + 'top_tb.sv',
                    'testcase':     output_path + 'top_testcase.sv',
                    'transaction':  output_path + 'top_transaction.sv',
                    'run_tcl':      output_path + 'run_top.tcl',
                    'shm_tcl':      output_path + 'shm.tcl',
                    'filelist':     output_path + 'top_filelist.f'}

print(output_dict)
print(template_dict)
class BuildSV:

    def init(self):
        
        for key in template_dict:
            print(key)
            template_file = open(template_dict[key], 'r', encoding="utf8")
            output_file = open(output_dict[key],'w')
            tmpl = Template(template_file.read())
            mycode = []
            mycode.append(tmpl.safe_substitute(
                BASE_TEST = 'BASE_TEST',
                base_test = 'base_test',
                TOP_AGENT = 'TOP_AGENT',
                top_agent = 'top_agent',
                TOP_DRIVER = 'TOP_DRIVER',
                top_driver = 'top_driver',
                TOP_ENV = 'TOP_ENV',
                top_env = 'top_env',
                TOP_IF = 'TOP_IF',
                top_if = 'top_if',
                TOP_MODEL = 'TOP_MODEL',
                top_model = 'top_model',
                TOP_MONITOR = 'TOP_MONITOR',
                top_monitor = 'top_monitor',
                TOP_SCOREBOARD = 'TOP_SCOREBOARD',
                top_scoreboard = 'top_scoreboard',
                TOP_SEQUENCE = 'TOP_SEQUENCE',
                top_sequence = 'top_sequence',
                TOP_SEQUENCER = 'TOP_SEQUENCER',
                top_sequencer = 'top_sequencer',
                TOP_TB = 'TOP_TB',
                top_tb = 'top_tb',
                TOP_TESTCASE = 'TOP_TESTCASE',
                top_testcase = 'top_testcase',
                TOP_TRANSACTION = 'TOP_TRANSACTION',
                top_transaction = 'top_transaction',
                TIMEGAP_OF_SEQUENCE = '200000',
                TIMEOUT = '80000000000',
                OUTPUT_PATH = output_path,
                filelist = 'top_filelist'
                ))

            output_file.writelines(mycode)
            output_file.close()
            template_file.close()

        print('ok')

if __name__ == '__main__':
    build = BuildSV()
    build.init()
