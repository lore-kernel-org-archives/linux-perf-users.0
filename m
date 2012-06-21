From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: Re: measuring L3cache misses
Date: Thu, 21 Jun 2012 12:41:24 -0400
Message-ID: <alpine.DEB.2.00.1206211239010.4839@cl320.icl.utk.edu>
References: <loom.20120621T093151-851@post.gmane.org> <alpine.LRH.2.00.1206210822340.16450@ig.icl.utk.edu> <CAMmbtvK-78Xgvby-VOyVHEf7LbRD8=vw5b7ziOvpn2KUrZm+BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:2579 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759847Ab2FUQlc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 21 Jun 2012 12:41:32 -0400
In-Reply-To: <CAMmbtvK-78Xgvby-VOyVHEf7LbRD8=vw5b7ziOvpn2KUrZm+BQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Can Hankendi <hankendi@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, 21 Jun 2012, Can Hankendi wrote:

> i'm running benchmarks from PARSEC suite. The event I'm using is f74e1,
> which basically collects cache misses for any of the 6 cores, although there
> are 12 cores on my system. So, collecting per-core cache-misses doesn't mean
> anything for that specific event?

also, how are you specifying event f74e1?

I assume you know the 4 goes at the top, so that the event you pass to 
perf would look somehing like this:
   r40053f7e1

Vince
