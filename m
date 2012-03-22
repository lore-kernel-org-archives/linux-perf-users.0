From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: Re: perf stat: Doubt about stall cycle support
Date: Wed, 21 Mar 2012 21:17:42 -0400
Message-ID: <alpine.DEB.2.00.1203212112430.16205@cl320.eecs.utk.edu>
References: <loom.20120321T054053-857@post.gmane.org> <4F69E9C4.8060108@gmail.com> <CAB_n8zK5b0jWA=retCX12DGmrb19gMd2UxJGWkn6HD9nFrdiAQ@mail.gmail.com> <4F6A00BC.8070705@gmail.com> <loom.20120322T013621-317@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:59136
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750990Ab2CVBSX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Mar 2012 21:18:23 -0400
In-Reply-To: <loom.20120322T013621-317@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yipeng Huang <yipeng@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Wed, 21 Mar 2012, Yipeng Huang wrote:
> 
> Since I am on a much newer kernel, could it be the case that reading stall
> cycles is not supported by my hardware rather than by the kernel?

What kind of stalls are you looking to measure?

The core2 supports many kind of stall events.  Check out Intel Vol3b 
documentation, or the libpfm4 showevtinfo utility for a list of them all.

perf only directly supports a small subset of "generalized" events, and 
only then if a kernel developer bothers to hook up the proper events in 
the kernel sources.

If you do find a likely event you want to use, you can make perf use it as 
a "raw" event.

Vince
