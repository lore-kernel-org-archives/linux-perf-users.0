From: Benjamin King <benjaminking@web.de>
Subject: Re: Failure to parallelize
Date: Tue, 23 Aug 2016 08:10:25 +0200
Message-ID: <20160823061025.GA3208@localhost>
References: <20160817135528.GA13652@localhost>
 <21975224.qTVBMiFlMz@milian-kdab2>
 <20160818185048.GA2242@localhost>
 <8737lw1p7j.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:62906 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756613AbcHWGKq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2016 02:10:46 -0400
Content-Disposition: inline
In-Reply-To: <8737lw1p7j.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org

Hi Andi,

On Mon, Aug 22, 2016 at 02:14:08PM -0700, Andi Kleen wrote:
>Benjamin King <benjaminking@web.de> writes:
>> Still, I dabbled a bit with "perf record -s ...; perf report -T", but I find the
>> output a little confusing. To wit:
>
>I would rather use perf report --sort cpu,sym
>This reports all samples separated by CPUs, but sorted in the same view.

Thanks! 'perf record ...; perf report --sort pid,sym'
did the job for me. Here I can clearly see a difference between a function
being called in parallel vs one that is not via the thread id.

With 'perf report --sort cpu,sym' I get '-001' for the CPU number. 'perf
script -Fcpu,ip' tells me that:

Samples for 'cycles:pp' event do not have CPU attribute set. Cannot print 'cpu' field.

This was with perf 4.4.0 on an i7-3537U. I stripped off the ':pp', tried
recording instructions rather than cycles, and also tested with perf 4.2.3 on
an i7-3770, but had no luck with per CPU display.

Cheers,
  Benjamin
