From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: Re: measuring L3cache misses
Date: Thu, 21 Jun 2012 12:12:56 -0400
Message-ID: <alpine.DEB.2.00.1206211208320.4839@cl320.icl.utk.edu>
References: <loom.20120621T093151-851@post.gmane.org> <alpine.LRH.2.00.1206210822340.16450@ig.icl.utk.edu> <CAMmbtvK-78Xgvby-VOyVHEf7LbRD8=vw5b7ziOvpn2KUrZm+BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:47781
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759648Ab2FUQND (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 21 Jun 2012 12:13:03 -0400
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

You should check out the "Revision Guide for AMD Family 10h Processors".
The one that most likely applies is #437:
  L3 Cache Performance Events May Not Reliably Track Processor Core
#387 might be relevant too.

> Can you elaborate on some of those 'boring' computer architecture reasons?

Besides the problem of chip errata, cache events are notoriously bad at 
giving "expected" results.

Caches being include/exclusive can mean that cache levels are skipped when
doing lookups.

Victim caches can also change the results.

Some caches include cache coherency requests in their miss rates even if 
no actual miss happens.

Some events include results from prefetching as hits or misses.  It's not 
always clear from the documentation.

Most companies do not provide detailed enough descriptions of their cache 
infrastructures to generate accurate models of what the expected cache 
behavior should be.

Vince
