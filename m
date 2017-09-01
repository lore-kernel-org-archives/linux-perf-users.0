From: Andi Kleen <andi@firstfloor.org>
Subject: Re: broken cycle counts from perf record in frequency mode [Was: Re: deducing CPU clock rate over time from cycle samples]
Date: Fri, 01 Sep 2017 09:48:20 -0700
Message-ID: <87d17al60b.fsf@firstfloor.org>
References: <2900948.aeNJFYEL58@agathebauer> <6142297.1ke4zlptR7@milian-kdab2>
        <20170828172808.GQ2482@two.firstfloor.org>
        <3838997.nyT3JFTsVA@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15986 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbdIAQsV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Sep 2017 12:48:21 -0400
In-Reply-To: <3838997.nyT3JFTsVA@agathebauer> (Milian Wolff's message of "Fri,
        01 Sep 2017 12:34:36 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, peterz@infradead.org

Milian Wolff <milian.wolff@kdab.com> writes:
>
> do you have any input on this issue? I really wonder why noone else is 
> complaining about the frequency mode being unreliable or right out broken in 
> many situations. Since it's the default mode, I think this urgently needs to 
> be investigated - it makes perf unusable for a large group of users who want 
> to use it but don't know about `-c N` as a workaround...

It's likely related due to the frequency algorithm starting with 0.  So
at the beginning the samples are very fast (like 1 cycle) and likely
something breaks down in perf or your frequency calculation for very
short samples.

Also for inherited events this happens on every fork. If you
trace fork events too you'll likely see it correlated.
If you use -a and disable inheritance (no-inherit=1) it will
also likely be only at the beginning.

However I fail to see what it would actually break. The frequency
just needs to be roughly accurate over the whole measurement
period to get good sampling coverage. But there's nothing
in the profile that uses the actual frequency. It's just a means
to get samples, not a measurement by itself.

-Andi
