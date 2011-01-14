From: David Ahern <daahern@cisco.com>
Subject: Re: perf timechart broken
Date: Fri, 14 Jan 2011 10:09:05 -0700
Message-ID: <4D308331.6010106@cisco.com>
References: <201101071104.37576.trenn@suse.de> <201101110955.37560.trenn@suse.de> <4D2CA7D6.2070203@cisco.com> <201101141800.18913.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-3.cisco.com ([171.71.176.72]:24205 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab1ANRJH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Jan 2011 12:09:07 -0500
In-Reply-To: <201101141800.18913.trenn@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Ingo Molnar <mingo@elte.hu>, linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>



On 01/14/11 10:00, Thomas Renninger wrote:
>> http://www.mail-archive.com/linux-perf-
> users@vger.kernel.org/msg00057.html
> Looks slightly different, the segfault should happen in:
> process_sample_event
> But looks very much related, possibly it has not been made/make with 
> DEBUG=1
> and -O6 was added and the backtrace is not 100% correct?

perf was built with DEBUG=1; that's how I got the pretty backtrace
versus having the arguments optimized out. The cpu=6291457 is the
garbage causing the segfault (there are only 2 cores in the system).
6291457 = 0x600001. Perhaps a mask is missing?

David

> 
> I still did not have time to send it out, will do so on Mo.
> 
>     Thomas
