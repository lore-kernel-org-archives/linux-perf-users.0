From: David Ahern <dsahern@gmail.com>
Subject: Re: What is the source of the time field in perf_sample events?
Date: Fri, 06 Apr 2012 11:14:44 -0600
Message-ID: <4F7F2484.2020307@gmail.com>
References: <B76DE0C2-3A2B-4D77-BBA2-9157891B222D@unimelb.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47946 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757020Ab2DFROt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 6 Apr 2012 13:14:49 -0400
Received: by pbcun15 with SMTP id un15so2824790pbc.19
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Apr 2012 10:14:49 -0700 (PDT)
In-Reply-To: <B76DE0C2-3A2B-4D77-BBA2-9157891B222D@unimelb.edu.au>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Bernie Pope <bjpope@unimelb.edu.au>
Cc: linux-perf-users@vger.kernel.org

On 3/18/12 6:08 AM, Bernie Pope wrote:
> Hello,
>
> I'm writing a tool to parse the perf.data output of perf and was wondering about the source of the timestamps found in perf_sample events? Specifically I mean the u64 time field in the perf_sample struct in util/event.h. I believe it is in nanoseconds from a particular event (system start?), but I can't find any documentation about where the time comes from.
>
> I'm also interested in reading from this time source from a userspace program, is that possible?

Did you get a response to this?

Code wise, you'll need to follow perf_clock(). I believe for x86 with a 
stable TSC you end up in native_sched_clock() in arch/x86/kernel/tsc.c.

As for the corresponding userspace call I believe it is 
clock_gettime(CLOCK_MONOTONIC, ...).

David
