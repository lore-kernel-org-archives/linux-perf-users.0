From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 0/4] perf events: Add realtime clock event and timehist
 option -v2
Date: Mon, 21 Feb 2011 14:41:53 -0700
Message-ID: <4D62DC21.4070407@cisco.com>
References: <1298322150-15505-1-git-send-email-daahern@cisco.com> <20110221213740.GC3583@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:7434 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab1BUVl4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Feb 2011 16:41:56 -0500
In-Reply-To: <20110221213740.GC3583@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de



On 02/21/11 14:37, Frederic Weisbecker wrote:

> The goal is actually to extend perf script to handle more than just raw data.
> So that it can handle the rest of what we can find in an event: time, ip, stacktraces...
> 
> You've added 200 lines in perf report to add the dump support. It wouldn't
> require more to extend perf script to do that. And the result is going to be
> much more powerful.
> 
> Look at struct scripting_ops::process_event().

I actually have a draft of perf-script - essentially duplicating sample
processing done in perf-report. When it got to the point of having to
add a lot of code -- other features essentially -- just to get it to the
point of being ready for this feature I stopped.

David


> 
> What you need is too pass in the whole event instead of only the raw data,
> cpu and so on...
> 
> You don't even need to add the support in the scripts themselves, they can
> just cope with the new parameter layout. You only need to handle the rest of
> the event in the print_event() function (the default scripting_ops::process_event())
> to print ip, time and stacktraces.
> 
> This probably needs some option in perf script to avoid showing ip and other
> new things. Although we probably want to print stacktraces by default
> if there are present.
