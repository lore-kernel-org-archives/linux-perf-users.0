From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Re: Profiling a program's runtime
Date: Fri, 04 Feb 2011 20:24:27 +0100
Message-ID: <cc0u18-hgq.ln1@homer.bruehl.pontohonk.de>
References: <ukft18-pba.ln1@burns.bruehl.pontohonk.de> <20110204171604.GB1808@nowhere> <6cqt18-1lh.ln1@burns.bruehl.pontohonk.de> <20110204174750.GD1808@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51479 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787Ab1BDTXw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Feb 2011 14:23:52 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1PlRG2-0006D0-6P
	for linux-perf-users@vger.kernel.org; Fri, 04 Feb 2011 20:23:50 +0100
Received: from p3e9bb949.dip.t-dialin.net ([62.155.185.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Feb 2011 20:23:50 +0100
Received: from bartoschek by p3e9bb949.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Feb 2011 20:23:50 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Frederic Weisbecker wrote:

>> For example, if my task waits for network packets in a read() then the
>> time should be added to the read() function. Other profilers I know would
>> not count the time when the process is blocked.
> 
> What do you mean by adding time to read?
> 
> I'm very confused with what you want.

Take for example the following program:

#include <unistd.h>

int compute(int start) {
   for (int i = 0; i < 10000000; ++i) {
      start += i;
   }
   return start;
}

int main(int argc, char **) {
   int ret = 0;
   for (int i = 0; i != 5; ++i) {
      sleep(argc == 1 ? 0 : 1);
      ret += compute(argc);
   }
   return ret;
}

Here is what I get by default:

ponto@homer:~/software/perf> g++ small.C -Wall -W -pedantic
ponto@homer:~/software/perf> time ./a.out 

real    0m0.113s
user    0m0.111s
sys     0m0.001s
ponto@homer:~/software/perf> time perf record -f ./a.out 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.016 MB perf.data (~691 samples) ]

real    0m5.147s
user    0m0.012s
sys     0m0.008s
ponto@homer:~/software/perf> perf report | cat
[kernel.kallsyms] with build id 361b85a57658c9ebfa686878cc821250aaff28e2 not 
found, continuing without symbols
# Samples: 335743554
#
# Overhead  Command      Shared Object  Symbol
# ........  .......  .................  ......
#
    98.20%    a.out  a.out              [.] compute(int)
     1.51%    a.out  [kernel.kallsyms]  [k] page_remove_rmap
     0.25%    a.out  [kernel.kallsyms]  [k] page_fault
     0.03%    a.out  [kernel.kallsyms]  [k] _raw_spin_lock_irq
     0.00%    a.out  [kernel.kallsyms]  [k] intel_pmu_enable_all
     0.00%    a.out  [kernel.kallsyms]  [k] 0xffffffff810123cc

The report is clearly wrong. The program was only 2% in the compute function 
and 98% in the sleep() function.

Christoph
