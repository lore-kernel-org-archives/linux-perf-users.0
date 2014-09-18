From: Milian Wolff <mail@milianw.de>
Subject: Perf event for Wall-time based sampling?
Date: Thu, 18 Sep 2014 14:32:10 +0200
Message-ID: <2221771.b2oSN5LR6X@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:47027 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbaIRMcO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Sep 2014 08:32:14 -0400
Received: from milian-kdab2.localnet (unknown [188.111.54.34])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id D257B62809AF
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2014 14:32:11 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Hello,

is it somehow possible to use perf based on some kernel timer? I'd like to get 
an overview of where a userspace application is spending time, both on-CPU as 
well as waiting off-CPU. E.g. something similar to using GDB as a poor-mans 
profiler and regularly interrupting the process and investigating the 
callgraphs. This is quite efficient for a high-level overview when you want to 
figure out where time is spent, unrelated to how it was actually spent (cpu, 
thread locks, io wait, ...).

E.g. what event would I use for a simple application like this:

~~~~~~~~~~~~~~
#include <unistd.h>

int main()
{
  sleep(10);
  return 0;
}
~~~~~~~~~~~~~~

Which perf event would show me that most of the time is spent sleeping? I 
tried something like this to no avail:

$ perf record --call-graph dwarf -e cpu-clock -F 100 ./a.out 
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.007 MB perf.data (~304 samples) ]
perf report --stdio
Error:
The perf.data file has no samples!
# To display the perf.data header info, please use --header/--header-only 
options.

I read https://perf.wiki.kernel.org/index.php/Tutorial#Profiling_sleep_times
and tried it out. The result is odd, as I get the "same" backtrace multiple 
times, all with 100% cost:

~~~~~~~~~~~~~~~~~~~~~~~~~~
   100.00%     0.00%             0    a.out  libc-2.19.so       [.] 
__GI___libc_nanosleep
              |
              --- __GI___libc_nanosleep

   100.00%     0.00%             0    a.out  [kernel.kallsyms]  [k] 
system_call_fastpath 
              |
              --- system_call_fastpath
                  __GI___libc_nanosleep

   100.00%     0.00%             0    a.out  [kernel.kallsyms]  [k] 
sys_nanosleep        
              |
              --- sys_nanosleep
                  system_call_fastpath
                  __GI___libc_nanosleep

   100.00%     0.00%             0    a.out  [kernel.kallsyms]  [k] 
hrtimer_nanosleep    
              |
              --- hrtimer_nanosleep
                  sys_nanosleep
                  system_call_fastpath
                  __GI___libc_nanosleep
~~~~~~~~~~~~~~~~~~~~~~~~~~

And generally, this would *only* profile sleep time and would ignore the on-
CPU time (and maybe thread waits) and so forth.

Is there a technical reason on why it is not possible to use a plain timer as 
a sampling event? If I'm not mistaken, then Intel VTune actually uses a 
similar technique for its simple profiling modes which can already give 
extremely useful data - both to find CPU hotspots as well as locks&waits.

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
