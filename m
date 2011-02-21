From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 0/4] perf events: Add realtime clock event and timehist
 option -v2
Date: Mon, 21 Feb 2011 22:55:35 +0100
Message-ID: <20110221215533.GD3583@nowhere>
References: <1298322150-15505-1-git-send-email-daahern@cisco.com>
 <20110221213740.GC3583@nowhere>
 <4D62DC21.4070407@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53292 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab1BUVzj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Feb 2011 16:55:39 -0500
Content-Disposition: inline
In-Reply-To: <4D62DC21.4070407@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de

On Mon, Feb 21, 2011 at 02:41:53PM -0700, David Ahern wrote:
> 
> 
> On 02/21/11 14:37, Frederic Weisbecker wrote:
> 
> > The goal is actually to extend perf script to handle more than just raw data.
> > So that it can handle the rest of what we can find in an event: time, ip, stacktraces...
> > 
> > You've added 200 lines in perf report to add the dump support. It wouldn't
> > require more to extend perf script to do that. And the result is going to be
> > much more powerful.
> > 
> > Look at struct scripting_ops::process_event().
> 
> I actually have a draft of perf-script - essentially duplicating sample
> processing done in perf-report. When it got to the point of having to
> add a lot of code -- other features essentially -- just to get it to the
> point of being ready for this feature I stopped.


I don't understand why it's harder to extend print_event() rather than
perf report.
