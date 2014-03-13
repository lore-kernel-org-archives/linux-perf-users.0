From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Some troubles with perf and measuring flops
Date: Thu, 13 Mar 2014 16:17:20 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1403131613550.3849@vincent-weaver-1.um.maine.edu>
References: <5317C76A.4050103@inf.ethz.ch> <alpine.DEB.2.10.1403052036580.22262@vincent-weaver-1.um.maine.edu> <5317D4FF.1030302@inf.ethz.ch> <alpine.DEB.2.10.1403061323200.22334@vincent-weaver-1.um.maine.edu> <5318CF72.20504@inf.ethz.ch>
 <531FA209.4030603@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:45950 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbaCMUOu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 13 Mar 2014 16:14:50 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so1587095qaj.35
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2014 13:14:49 -0700 (PDT)
In-Reply-To: <531FA209.4030603@inf.ethz.ch>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Alen Stojanov <astojanov@inf.ethz.ch>
Cc: linux-perf-users@vger.kernel.org

On Wed, 12 Mar 2014, Alen Stojanov wrote:

> So just to summarize (since I did not get any reply) - the final conclusion is
> that I can not simply obtain proper flop counts with linux perf, because of
> hardware limitations ?

Performance counters are tricky things.  You shouldn't take my word for 
it, you should either run tests or contact people inside Intel.

But yes, "flop count" has always been a tricky quantity to measure (what 
constitutes a flop?  Is a fused multiply-add one flop or two?  etc.)

And in recent Intel processors the floating point events are notriously 
hard to use, and for a while Intel even stopped documenting that they
existed until the HPC community complained enough that Intel has brought 
them back but with a lot of warnings about accuracy.

This doesn't mean you can't get useful results out of the events, it just 
means that it's probably never going to be possible to get "exact flop 
counts", whatever that means.

Vince
