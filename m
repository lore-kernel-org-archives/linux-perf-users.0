From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: bogus values of variables in userspace probes
Date: Tue, 24 Nov 2015 13:13:45 -0300
Message-ID: <20151124161345.GH18140@kernel.org>
References: <1448363902.24573.18.camel@redhat.com>
 <20151124145424.GC18140@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45776 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178AbbKXQNv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Nov 2015 11:13:51 -0500
Content-Disposition: inline
In-Reply-To: <20151124145424.GC18140@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Wang Nan <wangnan0@huawei.com>, Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org

Em Tue, Nov 24, 2015 at 11:54:24AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 24, 2015 at 12:18:22PM +0100, Michael Petlan escreveu:
> > I have been playing with perf-probe tool and I found out that some bogus
> > values of a function argument are obtained by perf-record.

> > How to reproduce:

> > gcc -O0 -g -o dummy dummy.c
> > perf probe -x ./dummy --add 'isprime a'
> > perf record -e probe_dummy:isprime ./dummy
> > perf script
 
> Checking this here, but as non root I get:
 
> [acme@zoo ~]$ gcc -O0 -g -o isprime isprime.c
> [acme@zoo ~]$ perf probe -x ./isprime --add 'isprime a'
> Mapping for the register number 4113 missing on this architecture.
> Sorry, we don't support this variable location yet.
>   Error: Failed to add events.
> [acme@zoo ~]$ 

Bisected it down to:

[acme@zoo linux]$ git bisect good 
05c8d802fa52ef17dbcce21c38b72b4a313eb036 is the first bad commit
commit 05c8d802fa52ef17dbcce21c38b72b4a313eb036
Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Date:   Wed Nov 18 15:40:12 2015 +0900

    perf probe: Fix to free temporal Dwarf_Frame
    
    Since dwarf_cfi_addrframe returns malloc'd Dwarf_Frame object, it has to
    be freed after it is used.
    
    Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Link: http://lkml.kernel.org/r/20151118064011.30709.65674.stgit@localhost.localdomain
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

:040000 040000 6438a0b3a7817ecbfc61eb00af9c62e54c405bcb 62ca7f05ff3ec7202d4c47f9cd2e2cb183060725 M	tools
[acme@zoo linux]$

If I just do a:

[acme@zoo linux]$ git revert 05c8d802fa52ef17dbcce21c38b72b4a313eb036
[perf/core 15ef27d95f5c] Revert "perf probe: Fix to free temporal Dwarf_Frame"
 1 file changed, 3 insertions(+), 6 deletions(-)
[acme@zoo linux]$

It works again, i.e. it goes from:

[acme@zoo linux]$ perf probe -x ~/isprime --add 'isprime a'
Mapping for the register number 4113 missing on this architecture.
Sorry, we don't support this variable location yet.
  Error: Failed to add events.
[acme@zoo linux]$ 

To, after the revert:

[acme@zoo linux]$ perf probe -x ~/isprime --add 'isprime a'
Failed to open uprobe_events: Permission denied
  Error: Failed to add events.

And, as root:

[root@zoo acme]# perf probe -x ./isprime --add 'isprime a'
Added new event:
  probe_isprime:isprime (on isprime in /home/acme/isprime with a)

You can now use it in all perf tools, such as:

	perf record -e probe_isprime:isprime -aR sleep 1


[root@zoo acme]# perf record -e probe_isprime:isprime ./isprime
2 is prime
3 is prime
4 is not prime
5 is prime
6 is not prime
7 is prime
13 is prime
17 is prime
19 is prime
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.018 MB perf.data (9 samples) ]
[root@zoo acme]# 

[root@zoo acme]# perf script
         isprime 27687 [003] 184735.650141: probe_isprime:isprime: (400536) a=0
         isprime 27687 [003] 184735.650204: probe_isprime:isprime: (400536) a=32570
         isprime 27687 [003] 184735.650209: probe_isprime:isprime: (400536) a=3
         isprime 27687 [003] 184735.650212: probe_isprime:isprime: (400536) a=4
         isprime 27687 [003] 184735.650215: probe_isprime:isprime: (400536) a=5
         isprime 27687 [003] 184735.650218: probe_isprime:isprime: (400536) a=6
         isprime 27687 [003] 184735.650222: probe_isprime:isprime: (400536) a=7
         isprime 27687 [003] 184735.650225: probe_isprime:isprime: (400536) a=13
         isprime 27687 [003] 184735.650229: probe_isprime:isprime: (400536) a=17
[root@zoo acme]#

I.e. bogus values for some of the samples, as Michael reported.

Ah, using 'perf trace', or 'trace' to type less, we can combine 'record' + 'script',
only to end at the same bogus values for some of the captured 'a' variable contents:

[root@zoo acme]# trace --no-sys --ev probe_isprime:isprime ./isprime
2 is prime
3 is prime
4 is not prime
5 is prime
6 is not prime
7 is prime
13 is prime
17 is prime
19 is prime
     0.264 probe_isprime:isprime:(400536) a=0)
     0.332 probe_isprime:isprime:(400536) a=32562)
     0.363 probe_isprime:isprime:(400536) a=3)
     0.395 probe_isprime:isprime:(400536) a=4)
     0.429 probe_isprime:isprime:(400536) a=5)
     0.463 probe_isprime:isprime:(400536) a=6)
     0.497 probe_isprime:isprime:(400536) a=7)
     0.532 probe_isprime:isprime:(400536) a=13)
     0.566 probe_isprime:isprime:(400536) a=17)
[root@zoo acme]#

- Arnaldo
