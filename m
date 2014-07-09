From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Interrupt caused by software events
Date: Wed, 9 Jul 2014 15:54:18 +0200
Message-ID: <20140709135418.GB5767@krava.redhat.com>
References: <20140708144242.GA300@gamayun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11124 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020AbaGINyV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Jul 2014 09:54:21 -0400
Content-Disposition: inline
In-Reply-To: <20140708144242.GA300@gamayun>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, Jul 08, 2014 at 11:42:42AM -0300, Martin Ichilevici de Oliveira wrote:
> Hello,
> 
> I'm learning the perf_events programming interface and I'm not sure if
> what I'm trying to do is possible. I could only find the perf_event_open
> documentation, but unfortunately that's not enough for my needs, as it
> only counts the number of events that happened.
> 
> I'm looking for a way to determine which instruction caused some events:
> something similar to what perf annotate does, but in an online fashion. 
> Ideally, I'd like to have some kind of handler that gets called whenever
> a perf event occurs. Is that even possible? If not, is there any way I 
> could get this information in a real-time way?

hi,
you could use perf_event_create_kernel_counter interface,
check the lockup watchdog in kernel/watchdog.c

jirka
