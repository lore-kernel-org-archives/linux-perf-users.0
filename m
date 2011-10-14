From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf for analyzing userspace contention
Date: Fri, 14 Oct 2011 19:43:14 -0300
Message-ID: <20111014224314.GC19655@ghostprotocols.net>
References: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
 <4E98A8DD.6000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59063 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab1JNWnT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Oct 2011 18:43:19 -0400
Received: by ggnb1 with SMTP id b1so872232ggn.19
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2011 15:43:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E98A8DD.6000201@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Roland Dreier <roland@kernel.org>, linux-perf-users@vger.kernel.org

Em Fri, Oct 14, 2011 at 03:25:49PM -0600, David Ahern escreveu:
> 
> 
> On 10/14/2011 12:36 AM, Roland Dreier wrote:
> > Anyway, suppose I have a multithreaded userspace app that uses a bunch of
> > pthread_mutexes, and I want to figure out which locks are hot and/or heavily
> > contended.  What's the best way to do that?  Is perf the right, or is there
> > something better?  (This seems like such an obvious thing to want that there
> > must be some good way to get this data, I hope)
> 
> You can capture futex entry and exit with:
> 
> perf trace -e syscalls:sys_enter_futex -e syscalls:sys_exit_futex
> 
> add -g to get the callchains. From there perf-script will dump the events.

Right, if userspace was compiled with -fno-omit-frame-pointer, instant
karma :-)

With what we have now in tip/master:

perf top -G

And enjoy it live :-)

- Arnaldo
