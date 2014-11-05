From: Milian Wolff <mail@milianw.de>
Subject: Re: Adding cache misses and references to list of default events for perf stat?
Date: Wed, 05 Nov 2014 12:18:07 +0100
Message-ID: <4264844.1bgz2IYRsf@milian-kdab2>
References: <2902317.tSPbunES6b@milian-kdab2> <87mw86k9gm.fsf@tassilo.jf.intel.com> <87tx2exu03.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:33825 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbaKELSK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Nov 2014 06:18:10 -0500
In-Reply-To: <87tx2exu03.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Wednesday 05 November 2014 11:26:36 Namhyung Kim wrote:
> Hi Andi and Milian,
> 
> On Tue, 04 Nov 2014 12:16:25 -0800, Andi Kleen wrote:
> > Milian Wolff <mail@milianw.de> writes:
> >> Hello all,
> >> 
> >> could we have the cache-references,cache-misses events added to the list
> >> of
> >> default events for perf stat? I think it is a very valuable metric for
> >> all
> >> user-space applications.
> >> 
> >> Currently, I run perf stat twice, once with the default events, and once
> >> with
> >> 
> >> perf stat -e cache-references,cache-misses ...
> >> 
> >> there is no easy way to append two events to the list of default events.
> >> 
> >> So, what do you think?
> > 
> > On most systems with only four counters it'll start multiplexing, which
> > will give much worse results. Defaulting to non multiplexing is much
> > better.
> 
> Anyway it has -d/--detailed option which can be specified up to 3 times.

Thanks, that helps!

Cheers

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
