From: Vince Weaver <vince@deater.net>
Subject: Re: Mixed group of sw/hw counters are not started if sw counter is
 group leader
Date: Tue, 29 Jan 2013 11:56:01 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1301291153490.538@pianoman.cluster.toy>
References: <CAGz0_-0ti+_3cXQhYUAb_-zKqHBcPVYjFtQ86ZGr8utXF13Rag@mail.gmail.com> <20130129123908.GC8339@krava.brq.redhat.com> <CAGz0_-2O+7a5Bkeu3vgNFYrsGGYJxrqECKQUJJTwSDQZBktLjw@mail.gmail.com> <20130129140110.GF8339@krava.brq.redhat.com>
 <20130129153720.GG8339@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from fbr04.mfg.siteprotect.com ([64.26.60.139]:56017 "EHLO
	fbr04.mfg.siteprotect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab3A2Qxu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Jan 2013 11:53:50 -0500
Received: from smtpauth03.mfg.siteprotect.com (smtpauth03-mf.mfg.chicago.hostway [192.168.33.73])
	by fbr04.mfg.siteprotect.com (Postfix) with ESMTP id 83E039CB99
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jan 2013 10:53:49 -0600 (CST)
In-Reply-To: <20130129153720.GG8339@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andreas Hollmann <hollmann@in.tum.de>, linux-perf-users@vger.kernel.org

On Tue, 29 Jan 2013, Jiri Olsa wrote:

> ok, there's been perf fixies wrt enable events groups, but they
> landed in 3.8-rc1.. until that point all the group members are
> specifically enabled, so that's why your perf is working and
> mine not..
> 
> Anyway, seems like there's bug in kernel code when we have group
> with sw and hw counters.
> 
> Attached path makes your test case working for me. I'll give it some
> more thoughts & testing and send it out soon. If you like to test,
> please go ahead.

I've added a test to my perf_event_test testsuite to look for this bug.
   http://www.eece.maine.edu/~vweaver/projects/perf_events/validation/

In my (minimal) testing so far it looks like this bug does exist in 3.2
but does not in 2.6.35.  Is anyone curious enough to do a bisect to find 
out when it was introduced?

Vince
