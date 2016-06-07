From: "Sebastian, Shiny" <shiny.sebastian@intel.com>
Subject: Perf report --percentage
Date: Tue, 7 Jun 2016 19:21:15 +0000
Message-ID: <6076A35470B38B408600AA0E3B4A31E767471A9E@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59183 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753912AbcFGTW3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 7 Jun 2016 15:22:29 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


Hi,
=A0
I work with Intel and am running perf tool within Linux VMs on Windows =
Hyper-V. =A0With kernel 4.6 and corresponding perf version, percentages=
 of call stacks at deeper levels  do not seem to add up to 100% or pare=
nt value (26.97%): example below. I have tried the -percentage flag wit=
h both 'absolute' and 'relative' values and they don't seem to change t=
he output at all. Is this a bug or something wrong with my perf flags ?

Commands used:
#perf record=A0 -a -g -c 10000 sleep 10
#perf report -i cpu3.data.old -C 1 --no-children

-   27.48%  fio          [kernel.kallsyms]  [k] __softirqentry_text_sta=
rt
     __softirqentry_text_start
   - irq_exit
      - 26.97% smp_call_function_single_interrupt
         - call_function_single_interrupt
            + 4.21% __blk_run_queue
            + 4.09% hv_ringbuffer_write
            + 1.83% 0x99c
            + 1.78% __blockdev_direct_IO
            + 0.96% do_blockdev_direct_IO
            + 0.95% generic_make_request
            + 0.86% blk_queue_bio
            + 0.70% iov_iter_get_pages
            + 0.64% md_make_request
            + 0.55% do_io_submit
              0.51% entry_SYSCALL_64_fastpath
      + 0.51% hyperv_vector_handler


Older version: Perf version 4.2 on kernel 4.2 - seems to normalize them=
 to 100%.=A0
    27.69%  swapper          [kernel.kallsyms]            [k] intel_idl=
e
                    |
                    ---intel_idle
                       |
                       |--99.84%-- cpuidle_enter_state
                       |          cpuidle_enter
                       |          call_cpuidle
                       |          cpu_startup_entry
                       |          |
                       |          |--97.27%-- start_secondary
                       |          |
                       |           --2.73%-- rest_init
                       |                     start_kernel
                       |                     x86_64_start_reservations
                       |                     x86_64_start_kernel
                        --0.16%-- [...]


I am running SLES 12.=20

Thanks,
Shiny
