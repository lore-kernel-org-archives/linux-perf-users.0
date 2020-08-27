From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [perf/core] 16fb162e78:
 WARNING:at_kernel/events/core.c:#list_add_event
Date: Thu, 27 Aug 2020 18:32:44 +0530
Message-ID: <bd699fba-7227-c18f-3d05-919b7876ae6f@linux.ibm.com>
References: <20200827083757.GQ4299@shao2-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200827083757.GQ4299@shao2-debian>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kernel test robot <rong.a.chen@intel.com>
Cc: acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, namhyung@kernel.org, daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com, 0day robot <lkp@intel.com>, lkp@lists.01.org
List-Id: linux-perf-users.vger.kernel.org



On 8/27/20 2:07 PM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 16fb162e7868b8f3c1fc09ef0d683c9554cb6404 ("[RFC] perf/core: Fixes hung issue on perf stat command during cpu hotplug")
> url: https://github.com/0day-ci/linux/commits/Kajol-Jain/perf-core-Fixes-hung-issue-on-perf-stat-command-during-cpu-hotplug/20200826-173643
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 2cb5383b30d47c446ec7d884cd80f93ffcc31817
> 

Hi Rong Chen,
	Thanks for checking. Actually this is old patch, I recently send new updated patch.
Please let me know if in this patch also you are seeing same issue.

Link to the patch: https://lkml.org/lkml/2020/8/27/101

Thanks,
Kajol Jain

> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-------------------------------------------------+------------+------------+
> |                                                 | 2cb5383b30 | 16fb162e78 |
> +-------------------------------------------------+------------+------------+
> | boot_successes                                  | 4          | 0          |
> | boot_failures                                   | 0          | 8          |
> | WARNING:at_kernel/events/core.c:#list_add_event | 0          | 8          |
> | EIP:list_add_event                              | 0          | 8          |
> | kernel_BUG_at_lib/list_debug.c                  | 0          | 8          |
> | invalid_opcode:#[##]                            | 0          | 8          |
> | EIP:__list_add_valid                            | 0          | 8          |
> | Kernel_panic-not_syncing:Fatal_exception        | 0          | 8          |
> +-------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [   97.084211] WARNING: CPU: 0 PID: 593 at kernel/events/core.c:1807 list_add_event+0x29e/0x4b0
> [   97.086779] Modules linked in:
> [   97.087756] CPU: 0 PID: 593 Comm: trinity-main Not tainted 5.9.0-rc1-00012-g16fb162e7868b #1
> [   97.089783] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   97.091980] EIP: list_add_event+0x29e/0x4b0
> [   97.093322] Code: ef c2 c4 01 83 15 44 ef c2 c4 00 8b 43 60 a8 01 0f 84 9a fd ff ff 8d b6 00 00 00 00 83 05 48 ef c2 c4 01 83 15 4c ef c2 c4 00 <0f> 0b 83 05 50 ef c2 c4 01 83 15 54 ef c2 c4 00 e9 71 fd ff ff 8d
> [   97.097789] EAX: 00000007 EBX: eee48000 ECX: 00000001 EDX: ee125280
> [   97.099297] ESI: eeebe200 EDI: 00000001 EBP: eee67dfc ESP: eee67dec
> [   97.101008] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
> [   97.106936] CR0: 80050033 CR2: 08dfc000 CR3: 2e0bb000 CR4: 00040690
> [   97.108599] Call Trace:
> [   97.109457]  __perf_install_in_context+0x286/0x3e0
> [   97.110759]  remote_function+0x79/0x90
> [   97.111897]  generic_exec_single+0xc3/0x190
> [   97.113101]  smp_call_function_single+0x1a3/0x2d0
> [   97.114364]  ? bpf_fd_reuseport_array_update_elem+0x300/0x300
> [   97.115866]  task_function_call+0x87/0xc0
> [   97.117025]  ? __perf_event_enable+0x740/0x740
> [   97.118248]  perf_install_in_context+0x110/0x450
> [   97.119540]  __do_sys_perf_event_open+0x13cb/0x1ed0
> [   97.120833]  __ia32_sys_perf_event_open+0x24/0x40
> [   97.122097]  __do_fast_syscall_32+0x99/0x110
> [   97.123213]  do_fast_syscall_32+0x37/0x130
> [   97.124409]  do_SYSENTER_32+0x23/0x40
> [   97.125470]  entry_SYSENTER_32+0xb0/0x10d
> [   97.126592] EIP: 0xb7f11549
> [   97.127449] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> [   97.131832] EAX: ffffffda EBX: 08e38318 ECX: 00000000 EDX: ffffffff
> [   97.137556] ESI: ffffffff EDI: 00000002 EBP: 6d656d83 ESP: bfa804ec
> [   97.139119] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000286
> [   97.140732] ---[ end trace 57d55e687e8b0e41 ]---
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.9.0-rc1-00012-g16fb162e7868b .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong Chen
> 
