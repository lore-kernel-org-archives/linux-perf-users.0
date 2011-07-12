From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH 3/6] perf: add reference time event
Date: Tue, 12 Jul 2011 10:35:21 -0600
Message-ID: <4E1C77C9.1060005@gmail.com>
References: <1307490806-24548-1-git-send-email-dsahern@gmail.com> <1307490946-24673-1-git-send-email-dsahern@gmail.com> <20110617133230.GC25197@somewhere.redhat.com> <4DFB5F0B.4020903@gmail.com> <20110617141707.GE25197@somewhere.redhat.com> <4E1A7A0D.8000806@gmail.com> <20110712143024.GA9201@somewhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47181 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab1GLQf1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 12 Jul 2011 12:35:27 -0400
In-Reply-To: <20110712143024.GA9201@somewhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@samba.org, tglx@linutronix.de

On 07/12/2011 08:30 AM, Frederic Weisbecker wrote:
> Actually you first have to face a deeper problem. events are not stored
> in order in the flow, but they are sorted from perf_session__process_events().
> 
> The bunch of sorted events is flushed periodically and sent to the consumer.
> 
> See flush_sample_queue().
> 
> And this sorting is made on top of the sample->time timestamps. So events
> are first sorted on sample->time and only afterward you have access to your
> gtod tracepoint samples. But if that gtod sample has been taken after a reboot
> then its sample->time is not consistant with the rest. It is not well sorted
> and thus the reftime won't be updated at the right moment.

I was aware of this function and the buffering /sorting it does; I have
similar code in my local analysis tool (for older perf userspace). I had
not stopped to consider the impacts on the append mode since I never use
that option.

> So the problem is that reftime update already depends on a consistant cpu
> timestamp.
> 
> I can't think about a sane way to work around that. Sorting on gtod + cpu timestamp
> is not a solution because gtod can change.
> 
> I'd rather propose to refuse append mode as long as we have any timestamp. That includes
> gtod but also sample timestamps. They are buggy if we reboot.

I'm fine with restricting append mode if samples have timestamps. In
that case the time of day reference can be added to the header per the
original patch set. The change in behavior does impact a lot of record
use cases (system wide, raw).

David
