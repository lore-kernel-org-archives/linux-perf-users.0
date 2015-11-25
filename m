From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perftool-testsuite was: Re: bogus values of variables in
 userspace probes
Date: Wed, 25 Nov 2015 16:27:24 -0300
Message-ID: <20151125192724.GB2945@kernel.org>
References: <1448363902.24573.18.camel@redhat.com>
 <20151124150819.GD18140@kernel.org>
 <1448389839.24573.21.camel@redhat.com>
 <20151124191641.GK18140@kernel.org>
 <1448457943.24573.79.camel@redhat.com>
 <20151125133343.GA11434@krava.brq.redhat.com>
 <20151125144310.GO18140@kernel.org>
 <1448467097.24573.95.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36691 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbbKYT1a (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Nov 2015 14:27:30 -0500
Content-Disposition: inline
In-Reply-To: <1448467097.24573.95.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, David Ahern <dsahern@gmail.com>, Wang Nan <wangnan0@huawei.com>

Em Wed, Nov 25, 2015 at 04:58:17PM +0100, Michael Petlan escreveu:
> On Wed, 2015-11-25 at 11:43 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Nov 25, 2015 at 02:33:43PM +0100, Jiri Olsa escreveu:
> > Looking at it, but how do you envision the workflow when/if this is
> > merged into the kernel?

> > Nowadays, I have to do:

> >   make -C tools/perf build-test

> > To do build-tests, and also have to run:

> >   perf test

> > Would this be a 3td thing I'd have to do? Or would it be hooked into
> > 'perf test' somehow? It doesn't have to be written in C, but if it could
> > be called without us having to add a 3rd step to this process...

> I think there's no need to have any 3rd thing to do... I would vote for
> calling from the perf's Makefile after building it.

That doesn't work, sometimes patches are just cosmetic, sometimes they
require root priviledges, sometimes it requires some preparation, like
setting some tunable in /proc/sys/kernel/perf_event_paranoid or moving
around the vmlinux file so that it uses kallsyms, or, or, or.

Also the granularity is more like before pushing upstream, or automating
the tests using a script that runs the tests changeset by changeset in
multiple distros before pushing, etc.

I.e. like 'make -C tools/perf build-test' and 'perf test' do now.
 
> Bus same as perf-test, the testsuite does not 100% pass. Some better

Well, it better pass 100% for things it _can_ test, if something is not
available (root perms, vmlinux file, hardware capability (testing Intel
PT on older CPUs), etc) that prevents the test from being performed,
then it just prints Skip and doesn't consider that an error.

> skipping mechanism could be useful. But anyway, it is designed to be
> parametrized, so it can be run in some "quick/smoke testing" mode and in
> case of a need, in a more thoroughful mode. That depends on the configs
> in the common/parametrization.sh file.
> 
> Should the testsuite 100% pass in a basic mode?

I think so. And by basic more I mean the mode that it is run when one
calls:

 perf test command-line

Picking "command-line" to mean what you have now in
'perftool-testsuite'.

Any other option will probably not be tested that frequently by anybody
else than you, perhaps me and a few others.

I really think that the answer to 'Hey, how can I make sure the perf
tools are working? How do I test it?" should be: "run 'perf test'".

Then it becomes muscle memory and one doesn't have to remember any other
name or file to config, etc.

> > What I saw from a very quick walkthru starting from the 'base_probe'
> > one:

> > [root@zoo base_probe]# ./test_advanced.sh 
> > -- [ PASS ] -- perf_probe :: test_advanced :: function argument probing :: add
> > -- [ PASS ] -- perf_probe :: test_advanced :: function argument probing :: record
> > Pattern not found in the proper order: a=2
> > -- [ FAIL ] -- perf_probe :: test_advanced :: function argument probing :: script (output regexp parsing)
> > -- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: add
> > -- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: record
> > -- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: script
> > ## [ FAIL ] ## perf_probe :: test_advanced SUMMARY :: 1 failures found
> > [root@zoo base_probe]#

Re-reading the above, generally we try to remove redundant stuff, like
all that "perf_probe" column, ditto for the "test_advanced", etc.

Reduces eyestrain and, to say something funny I saw on FB about mass
surveilance, "removes hay so that we can find needles" :-)

> > With 'perf test'

> > [root@zoo ~]# perf test bpf llvm
> > 35: Test LLVM searching and compiling                        :
> > 35.1: Basic BPF llvm compiling test                          : Ok
> > 35.2: Test kbuild searching                                  : Ok
> > 35.3: Compile source for BPF prologue generation test        : Ok
> > 37: Test BPF filter                                          :
> > 37.1: Test basic BPF filtering                               : Ok
> > 37.2: Test BPF prologue generation                           : Ok
> > [root@zoo ~]#

> > So just FAIL, Skip or Ok, and if I ask for -v, then it will emit more
> > information.
> 
> Now it prints the PASS/FAIL/SKIP, and in case of FAIL some minimalistic
> footprint of the failure, so I can see whether it is just the old known
> thing or something different. The detailed logs are generated with that,
> but they are usually cleaned up in the cleanup.sh scripts.

I know, that is what I am saying, we have one tool to test the perf
tools and it communicates using a set of messages and has a semantic for
when to tell more than "Ok/FAIl/Skip", while your test suite does the
same thing, but with slight formatting variations, what I am suggesting
is to adopt the one in 'perf test' so that it becomes consistent and can
be plugged directly into 'perf test'.

Of course one could run it as of today, directly, in a standalone
fashion, be it by going to its source directory and running that
test_drive.sh (or whatever other name it ends up having) or from 'perf
test', by using something like:

  [acme@zoo linux]$ perf test clock
  20: Test software clock events have valid period values      : Ok

See? Just one test was run.

If it is run by spanwing a shell from another shell or from 'perf test',
that shouldn't matter, right?

Being able to just do 'perf test' and all tests, be it ones written in C
and part of tools/perf/tests/ or one written in whatever script
language, driven by your test suite, is the goal.
 
> I am still thinking about an ideal way to report failures, since I keep
> in mind another goal:  I would like to have the path from "looking at
> the logs" and "reproducing the thing manually in shell" as short and
> straightforward as possible.
> 
> But using some -v is generally a good idea. I'll try to integrate that
> concept too.

Thanks.
 
> > I think that we should add your suite to be called from 'perf test', and
> > it should follow the same style as 'perf test', see the BPF and LLVM test?
> > they have subtests, perhaps this is the way for this test suite to be
> > integrated.
> > 
> > How can I run all the tests in perftool-testsuite? Checking...
 
> Basically you need to run the ./test_driver.sh from the top directory.
> But nowadays all the subtests (base_SOMETHING) that are run are listed
> in the test_driver.sh per architecture. That concept could (and probably
> also should) be reworked a bit, but now it allows me hot-enabling and
> disabling groups of tests on various archs.

Thanks for the explanations, I had already found the README files and
ran the whole suite using that test_driver.sh file (at first I thought,
what driver is this testing? huh?) but then reading the README I figured
it was the "driver" of tests :-)

- Arnaldo
