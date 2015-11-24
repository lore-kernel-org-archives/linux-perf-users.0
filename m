From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: bogus values of variables in userspace probes
Date: Tue, 24 Nov 2015 16:16:41 -0300
Message-ID: <20151124191641.GK18140@kernel.org>
References: <1448363902.24573.18.camel@redhat.com>
 <20151124150819.GD18140@kernel.org>
 <1448389839.24573.21.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60120 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754368AbbKXTQq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Nov 2015 14:16:46 -0500
Content-Disposition: inline
In-Reply-To: <1448389839.24573.21.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, David Ahern <dsahern@gmail.com>, Wang Nan <wangnan0@huawei.com>

Em Tue, Nov 24, 2015 at 07:30:39PM +0100, Michael Petlan escreveu:
> On Tue, 2015-11-24 at 12:08 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 24, 2015 at 12:18:22PM +0100, Michael Petlan escreveu:
> > > I have been playing with perf-probe tool and I found out that some bogus
> > > values of a function argument are obtained by perf-record.
> > > 
> > > How to reproduce:
> > > 
> > > gcc -O0 -g -o dummy dummy.c
> > > perf probe -x ./dummy --add 'isprime a'
> > > perf record -e probe_dummy:isprime ./dummy
> > > perf script
> > > 
> > > The actual output looks like the following:
> > > 
> > > dummy 32476 [000] 3534401.838454: probe_dummy:isprime: (400530) a=32767
> > > dummy 32476 [000] 3534401.838504: probe_dummy:isprime: (400530) a=32714
> > > dummy 32476 [000] 3534401.838513: probe_dummy:isprime: (400530) a=3
> > > dummy 32476 [000] 3534401.838519: probe_dummy:isprime: (400530) a=4
> > > dummy 32476 [000] 3534401.838525: probe_dummy:isprime: (400530) a=5
> > > dummy 32476 [000] 3534401.838531: probe_dummy:isprime: (400530) a=6
> > > dummy 32476 [000] 3534401.838537: probe_dummy:isprime: (400530) a=7
> > > dummy 32476 [000] 3534401.838543: probe_dummy:isprime: (400530) a=13
> > > dummy 32476 [000] 3534401.838561: probe_dummy:isprime: (400530) a=17
> > > 
> > > But if you look into the source, you can see that the function isprime()
> > > is called with the following arguments:
> > > 
> > > int numbers[] = { 2, 3, 4, 5, 6, 7, 13, 17, 19 };
> > > 
> > > So the first and last ones are omitted, there are some bogus numbers instead
> > > of them and all that is shifted somehow.
> > > 
> > > Note that when I probe for %ax register it looks correct.
> > > 
> > > The version of kernel/perf is 4.3.0. The architecture is x86_64.
> > > Am I missing something or is it a bug?
> > 
> > I'm now trying to bisect that register error I found while trying to
> > reproduce the problem reported above, but please consider writing a
> > 'perf test' entry that does exactly what you did, i.e. have a simple
> > program that you build with a known set of compile flags, then run it
> > using perf probe to catch a specific function, its argument, and then
> > check that the values it produces are the ones expected.

> > We would catch bugs in 'perf probe', the DWARF code, etc, much more
> > quickly with something like that in place. :-)
 
> Hi Arnaldo,
 
> thanks for investigating the issue. I do not use fedora kernel, I use

I ended up having to investigate that other issue, and now I have to do
something else, but hopefully Masami will fix both issues, the one I
bisected and the one you reported.

> what I build from git, but of course I am some versions back. So I use
> 4.3.0 and 4.3.0-rc5 and both do the same thing.

Right, I also use custom kernels, but reboot with RHEL or fedora kernels
from time to time to investigate issues like this.
 
> I have met this when writing new tests for perf-probe into the testsuite
> I had been speaking about some time ago [1]. But if needed, I may add it
> as a perf-test entry as you wish.

Please :-)

- Arnaldo
