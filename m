From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf uncore behavior
Date: Fri, 01 May 2015 18:40:52 -0700
Message-ID: <87618blpsr.fsf@tassilo.jf.intel.com>
References: <CANFySvewjJTo7Cezq3e1SPAFFmRRRWADTJ50T5rubvcLrAV2xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3045 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbbEBBkx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 1 May 2015 21:40:53 -0400
In-Reply-To: <CANFySvewjJTo7Cezq3e1SPAFFmRRRWADTJ50T5rubvcLrAV2xA@mail.gmail.com>
	(Chris Freehill's message of "Fri, 1 May 2015 15:55:35 -0500")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chris Freehill <cfreehill@utexas.edu>
Cc: linux-perf-users@vger.kernel.org

Chris Freehill <cfreehill@utexas.edu> writes:
>
> Here are some examples:
>
> 1. $ perf stat -a -e "uncore_cbox_0/clockticks/" sleep 1
>
> 2. $ perf stat  -e "uncore_cbox_0/clockticks/" sleep 1
>
> 3. $ perf stat -a -C0 -e "uncore_cbox_0/clockticks/" sleep 1
>
> It appears #2 is not supported. If it was supported, I would take it
> to mean the number of uncore events counted while the process was
> active, regardless of which processor it was running on. Right?  Is
> there any reason it's not implemented (for example it's nonsensical)
> or it just has been tackled yet?

It's non sensical.  Uncore does not support per process measurements.

> Are 1 and 3 effectively the same, since uncore events are not specific
> to a core? I would think they would be the same. If not, what is the
> difference?

1. will sum up events from all sockets/nodes.
3. will only print from the socket/node associated with CPU 0.

-andi

-- 
ak@linux.intel.com -- Speaking for myself only
