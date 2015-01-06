From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Size of perf data files
Date: Tue, 6 Jan 2015 22:29:19 +0100
Message-ID: <20150106212919.GW2915@two.firstfloor.org>
References: <CALQF7ZygJpx=Lf0Dc70=cRRCheF_8SFos8sv8z0kjiog2Do0Zg@mail.gmail.com>
 <87ppas31sq.fsf@tassilo.jf.intel.com>
 <CALQF7ZzpLB3Ch3=nn5yi23eneqwXnEpFTq6dX4BT7dLYvxcVXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:57730 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311AbbAFV3U (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 6 Jan 2015 16:29:20 -0500
Content-Disposition: inline
In-Reply-To: <CALQF7ZzpLB3Ch3=nn5yi23eneqwXnEpFTq6dX4BT7dLYvxcVXw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yale Zhang <yzhang1985@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Tue, Jan 06, 2015 at 01:02:23PM -0800, Yale Zhang wrote:
> I don't see how lowering the frequency helps. If I lower it, then I'll
> need to run longer to capture the same # samples to achieve a given
> variation.

I don't know what that means.

Normally you have a workload and you measure it a given time.

The sampling rate is related to the accuracy you need. However
the default algorithm has a tendency to go very low, which
results in large files, but it doesn't give you that much
better accuracy.

Not a pre-defined number of samples. 

One trick that perf tools currently don't support well (it is
supported in ther kernel) is to also use multiple events. 
One low frequency event to measure the call graphs and 
other high frequency events to measure whatever else you want.

> I've already tried lowering the size of each sample from 8KiB to 512,
> but that only allows storing 2 or 3 parent function calls, which isn't
> enough for me.
> 
> "don't use dwarf unwinding."
> The main reason I'm trying to switch from Zoom to perf is because it
> supports dwarf unwinding! That's very convenient because otherwise

Frankly, dwarf unwinding for profiling is terrible. Only use it as a last
resort.

> I'll need to compile with frame pointers to do stack traces. This
> isn't the default and can slow down the program. As long as the Dwarf
> unwinding doesn't perturb the profilee  (by doing it at the end), then
> it would be OK.

If you have a Haswell system the next kernel will have LBR call stack
support, which avoids the need for both in common cases.

-Andi
