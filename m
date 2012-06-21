From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: Re: measuring L3cache misses
Date: Thu, 21 Jun 2012 08:25:14 -0400
Message-ID: <alpine.LRH.2.00.1206210822340.16450@ig.icl.utk.edu>
References: <loom.20120621T093151-851@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:22697
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759486Ab2FUMZg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 21 Jun 2012 08:25:36 -0400
In-Reply-To: <loom.20120621T093151-851@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hank <hankendi@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, 21 Jun 2012, Hank wrote:

> I'm measuring L1-L2-L3 cache misses on AMD Magnycours server. 
> I'm getting very high numbers for L3-miss numbers in comparison to L2-misses. 
> In some cases L3misses are 30times higher than L2misses. 

> Theoretically L1miss>L2miss>L3miss. 

That's not always true, for a variety of boring computer architecture 
reasons.  

Is your system idle?  L3 cache is a shared resource so you'll be seeing 
L3 misses from all cores running on your CPU.  It's not really possible
to know what's going on without knowing more about your workload.

The other thing you can do is find out what event your kernel is using for 
L3 cache misses, and then look up the event in the appropriate AMD BKDG 
and see what it says about the event.

Vince
