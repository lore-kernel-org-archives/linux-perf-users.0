From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: bogus values of variables in userspace probes
Date: Wed, 25 Nov 2015 14:25:43 +0100
Message-ID: <1448457943.24573.79.camel@redhat.com>
References: <1448363902.24573.18.camel@redhat.com>
	 <20151124150819.GD18140@kernel.org> <1448389839.24573.21.camel@redhat.com>
	 <20151124191641.GK18140@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37465 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbbKYNZq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Nov 2015 08:25:46 -0500
In-Reply-To: <20151124191641.GK18140@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, David Ahern <dsahern@gmail.com>, Wang Nan <wangnan0@huawei.com>

On Tue, 2015-11-24 at 16:16 -0300, Arnaldo Carvalho de Melo wrote:
>  
> > I have met this when writing new tests for perf-probe into the testsuite
> > I had been speaking about some time ago [1]. But if needed, I may add it
> > as a perf-test entry as you wish.
> 
> Please :-)
> 

Hi,

after a short discussion with Jiri Olsa I think that perf-test entry is
not an ideal way to add a testcase such as this one. While perf-test
aims on testing internal functions, here you need to use multiple tools
in order to reproduce the issue:

1) build a custom C example
2) add a userspace probe in the example
3) record some perf.data of it
4) analyze the perf.data by perf script

So in order to have this testcase in perf.test we'd need to call all the
mentioned functionality within a C function. That's why I think that
better approach is to use the shell based tests that I am collecting in
my suite for now:


# for running the particular testcase for this issue you just need to:
git clone https://github.com/rfmvh/perftool-testsuite.git
cd perftool-testsuite/base_probe
./setup.sh
./test_advanced.sh


The overall approach of that testsuite is to test the tool as it is. So
both approaches are necessary; both testing of the internal functions by
perf-test and testing the tool as such from the outside by the suite.
I am not against extending perf-test set, but I don't think this is the
right case for it.

> - Arnaldo

Regards,
Michael
