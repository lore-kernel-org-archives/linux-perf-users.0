From: Andi Kleen <andi@firstfloor.org>
Subject: Re: First time user, problem with toplev.py levels (-l)
Date: Wed, 25 Sep 2013 17:54:16 +0200
Message-ID: <20130925155416.GJ18242@two.firstfloor.org>
References: <CAA2XHbcy6qSvm_s=XPdp3GuXHgTAQqtiDZ1cgvM5rZMF9f00RQ@mail.gmail.com>
 <87ob7gsz42.fsf@tassilo.jf.intel.com>
 <CAA2XHbfK5qkf6UERFu_zLK5NEA+ZSs3=2QCeZ3MvkSceY9bxqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:46511 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab3IYPyS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Sep 2013 11:54:18 -0400
Content-Disposition: inline
In-Reply-To: <CAA2XHbfK5qkf6UERFu_zLK5NEA+ZSs3=2QCeZ3MvkSceY9bxqg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Luke Gorrie <luke@snabb.co>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Wed, Sep 25, 2013 at 05:29:49PM +0200, Luke Gorrie wrote:
> On 25 September 2013 17:24, Andi Kleen <andi@firstfloor.org> wrote:
> > What CPU do you have (head -n20 /proc/cpuinfo) ?
> 
> $ head -n20 /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 45
> model name      : Intel(R) Xeon(R) CPU E5-2650 0 @ 2.00GHz

toplev doesn't have a detailed model for SandyBridge-E currently,
that is why only level 1 is enabled.

You could force snb in the code for jkt (the table at line 175+), but some
of the estimated latencies would be a bit off and it would not 
support NUMA.

-Andi
