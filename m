From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: perftool-testsuite was: Re: bogus values of variables in userspace
 probes
Date: Wed, 25 Nov 2015 11:43:10 -0300
Message-ID: <20151125144310.GO18140@kernel.org>
References: <1448363902.24573.18.camel@redhat.com>
 <20151124150819.GD18140@kernel.org>
 <1448389839.24573.21.camel@redhat.com>
 <20151124191641.GK18140@kernel.org>
 <1448457943.24573.79.camel@redhat.com>
 <20151125133343.GA11434@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41777 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbbKYOnU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Nov 2015 09:43:20 -0500
Content-Disposition: inline
In-Reply-To: <20151125133343.GA11434@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, David Ahern <dsahern@gmail.com>, Wang Nan <wangnan0@huawei.com>

Em Wed, Nov 25, 2015 at 02:33:43PM +0100, Jiri Olsa escreveu:
> On Wed, Nov 25, 2015 at 02:25:43PM +0100, Michael Petlan wrote:
> > On Tue, 2015-11-24 at 16:16 -0300, Arnaldo Carvalho de Melo wrote:
> > >  
> > > > I have met this when writing new tests for perf-probe into the testsuite
> > > > I had been speaking about some time ago [1]. But if needed, I may add it
> > > > as a perf-test entry as you wish.
> > > 
> > > Please :-)
> > > 
> > 
> > Hi,
> > 
> > after a short discussion with Jiri Olsa I think that perf-test entry is
> > not an ideal way to add a testcase such as this one. While perf-test
> > aims on testing internal functions, here you need to use multiple tools
> > in order to reproduce the issue:
> > 
> > 1) build a custom C example
> > 2) add a userspace probe in the example
> > 3) record some perf.data of it
> > 4) analyze the perf.data by perf script
> > 
> > So in order to have this testcase in perf.test we'd need to call all the
> > mentioned functionality within a C function. That's why I think that
> > better approach is to use the shell based tests that I am collecting in
> > my suite for now:
> > 
> > 
> > # for running the particular testcase for this issue you just need to:
> > git clone https://github.com/rfmvh/perftool-testsuite.git
> > cd perftool-testsuite/base_probe
> > ./setup.sh
> > ./test_advanced.sh

Looking at it, but how do you envision the workflow when/if this is
merged into the kernel?

Nowadays, I have to do:

  make -C tools/perf build-test

To do build-tests, and also have to run:

  perf test

Would this be a 3td thing I'd have to do? Or would it be hooked into
'perf test' somehow? It doesn't have to be written in C, but if it could
be called without us having to add a 3rd step to this process...

What I saw from a very quick walkthru starting from the 'base_probe'
one:

[root@zoo base_probe]# ./test_advanced.sh 
-- [ PASS ] -- perf_probe :: test_advanced :: function argument probing :: add
-- [ PASS ] -- perf_probe :: test_advanced :: function argument probing :: record
Pattern not found in the proper order: a=2
-- [ FAIL ] -- perf_probe :: test_advanced :: function argument probing :: script (output regexp parsing)
-- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: add
-- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: record
-- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: script
## [ FAIL ] ## perf_probe :: test_advanced SUMMARY :: 1 failures found
[root@zoo base_probe]#

With 'perf test'

[root@zoo ~]# perf test bpf llvm
35: Test LLVM searching and compiling                        :
35.1: Basic BPF llvm compiling test                          : Ok
35.2: Test kbuild searching                                  : Ok
35.3: Compile source for BPF prologue generation test        : Ok
37: Test BPF filter                                          :
37.1: Test basic BPF filtering                               : Ok
37.2: Test BPF prologue generation                           : Ok
[root@zoo ~]#

So just FAIL, Skip or Ok, and if I ask for -v, then it will emit more
information.

I think that we should add your suite to be called from 'perf test', and
it should follow the same style as 'perf test', see the BPF and LLVM test?
they have subtests, perhaps this is the way for this test suite to be
integrated.

How can I run all the tests in perftool-testsuite? Checking...

> > The overall approach of that testsuite is to test the tool as it is. So
> > both approaches are necessary; both testing of the internal functions by
> > perf-test and testing the tool as such from the outside by the suite.
> > I am not against extending perf-test set, but I don't think this is the
> > right case for it.
> 
> +1 ;-)
> 
> also I remember discussion about having your test suite
> ported somewhere over perf sources.. is this still a plan?
> 
> thanks,
> jirka
