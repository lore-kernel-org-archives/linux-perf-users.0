From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: perftool-testsuite was: Re: bogus values of variables in
 userspace probes
Date: Wed, 25 Nov 2015 16:58:17 +0100
Message-ID: <1448467097.24573.95.camel@redhat.com>
References: <1448363902.24573.18.camel@redhat.com>
	 <20151124150819.GD18140@kernel.org> <1448389839.24573.21.camel@redhat.com>
	 <20151124191641.GK18140@kernel.org> <1448457943.24573.79.camel@redhat.com>
	 <20151125133343.GA11434@krava.brq.redhat.com>
	 <20151125144310.GO18140@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38472 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbbKYP6U (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Nov 2015 10:58:20 -0500
In-Reply-To: <20151125144310.GO18140@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, David Ahern <dsahern@gmail.com>, Wang Nan <wangnan0@huawei.com>

On Wed, 2015-11-25 at 11:43 -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 25, 2015 at 02:33:43PM +0100, Jiri Olsa escreveu:
> Looking at it, but how do you envision the workflow when/if this is
> merged into the kernel?
> 
> Nowadays, I have to do:
> 
>   make -C tools/perf build-test
> 
> To do build-tests, and also have to run:
> 
>   perf test
> 
> Would this be a 3td thing I'd have to do? Or would it be hooked into
> 'perf test' somehow? It doesn't have to be written in C, but if it could
> be called without us having to add a 3rd step to this process...

I think there's no need to have any 3rd thing to do... I would vote for
calling from the perf's Makefile after building it.

Bus same as perf-test, the testsuite does not 100% pass. Some better
skipping mechanism could be useful. But anyway, it is designed to be
parametrized, so it can be run in some "quick/smoke testing" mode and in
case of a need, in a more thoroughful mode. That depends on the configs
in the common/parametrization.sh file.

Should the testsuite 100% pass in a basic mode?

> 
> What I saw from a very quick walkthru starting from the 'base_probe'
> one:
> 
> [root@zoo base_probe]# ./test_advanced.sh 
> -- [ PASS ] -- perf_probe :: test_advanced :: function argument probing :: add
> -- [ PASS ] -- perf_probe :: test_advanced :: function argument probing :: record
> Pattern not found in the proper order: a=2
> -- [ FAIL ] -- perf_probe :: test_advanced :: function argument probing :: script (output regexp parsing)
> -- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: add
> -- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: record
> -- [ PASS ] -- perf_probe :: test_advanced :: function retval probing :: script
> ## [ FAIL ] ## perf_probe :: test_advanced SUMMARY :: 1 failures found
> [root@zoo base_probe]#
> 
> With 'perf test'
> 
> [root@zoo ~]# perf test bpf llvm
> 35: Test LLVM searching and compiling                        :
> 35.1: Basic BPF llvm compiling test                          : Ok
> 35.2: Test kbuild searching                                  : Ok
> 35.3: Compile source for BPF prologue generation test        : Ok
> 37: Test BPF filter                                          :
> 37.1: Test basic BPF filtering                               : Ok
> 37.2: Test BPF prologue generation                           : Ok
> [root@zoo ~]#
> 
> So just FAIL, Skip or Ok, and if I ask for -v, then it will emit more
> information.

Now it prints the PASS/FAIL/SKIP, and in case of FAIL some minimalistic
footprint of the failure, so I can see whether it is just the old known
thing or something different. The detailed logs are generated with that,
but they are usually cleaned up in the cleanup.sh scripts.

I am still thinking about an ideal way to report failures, since I keep
in mind another goal:  I would like to have the path from "looking at
the logs" and "reproducing the thing manually in shell" as short and
straightforward as possible.

But using some -v is generally a good idea. I'll try to integrate that
concept too.

> 
> I think that we should add your suite to be called from 'perf test', and
> it should follow the same style as 'perf test', see the BPF and LLVM test?
> they have subtests, perhaps this is the way for this test suite to be
> integrated.
> 
> How can I run all the tests in perftool-testsuite? Checking...
> 

Basically you need to run the ./test_driver.sh from the top directory.
But nowadays all the subtests (base_SOMETHING) that are run are listed
in the test_driver.sh per architecture. That concept could (and probably
also should) be reworked a bit, but now it allows me hot-enabling and
disabling groups of tests on various archs.
