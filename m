From: Christopher Covington <cov@codeaurora.org>
Subject: Re: Signal on PMU event?
Date: Mon, 21 Apr 2014 10:29:36 -0400
Message-ID: <53552B50.7080508@codeaurora.org>
References: <CAA2XHbfJdXBzxF8=FCpBv5pM76XOPBY5av5np0dNkr4CYU0Jrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:45206 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaDUO3i (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Apr 2014 10:29:38 -0400
In-Reply-To: <CAA2XHbfJdXBzxF8=FCpBv5pM76XOPBY5av5np0dNkr4CYU0Jrg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Luke Gorrie <luke@snabb.co>
Cc: linux-perf-users@vger.kernel.org

Hi Luke,

On 04/20/2014 02:45 PM, Luke Gorrie wrote:
> Howdy!
> 
> Is it possible for a self-profiling program to receive a signal (e.g.
> SIGPROF) driven by a chosen PMU event (e.g. cache-misses, etc)?
> 
> I'm using a SIGITIMER-driven profiler (LuaJIT's one) and it would be
> wonderfully convenient to be able to switch the event source while
> keeping the signal-driven flow.

It is possible to receive a SIGIO after a specified number of events. You have
to be careful to set the sample_period, watermark, and wakeup_events or
wakeup_watermark attributes and set the asynchronous flag on the resulting
file descriptor (always setting the owner may be required as well) for it to
work. You can find an example in perf_event_tests [1].

1.
https://github.com/deater/perf_event_tests/blob/master/tests/overflow/wakeup_events_overflow.c

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
