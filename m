From: Andi Kleen <andi@firstfloor.org>
Subject: Re: broken cycle counts from perf record in frequency mode [Was: Re:
 deducing CPU clock rate over time from cycle samples]
Date: Mon, 4 Sep 2017 20:40:58 -0700
Message-ID: <20170905034058.GV2482@two.firstfloor.org>
References: <2900948.aeNJFYEL58@agathebauer>
 <3838997.nyT3JFTsVA@agathebauer>
 <87d17al60b.fsf@firstfloor.org>
 <1788258.9pJ1GNok8V@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:40454 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753774AbdIEDlA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Sep 2017 23:41:00 -0400
Content-Disposition: inline
In-Reply-To: <1788258.9pJ1GNok8V@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, peterz@infradead.org

> The cycle value gets associated with a sample via it's period value, which is 
> used by `perf report` in the analysis. If I get a single "broken" sample with 

I always thought it just used the number of samples?

> a cycle count of, say 1E14 and then a million other samples, each with "sane" 
> cycle counts of let's say 1E5, then the one broken sample will hold 50% of the 
> total amount of measured cycles. So perf report will show that the function 
> where the broken sample points to will have a cost of 50%.

I don't think I've seen such a situation. Did you?

BTW I'm not arguing against fixing it, but typically I just
recommend to avoid frequency mode. The fast sampling at the beginning
has caused a range of low level PMU bugs and it is hard to reason about
because of its complex behavior. Also it has no protection against
synchronizing with repeated patterns in the execution, which
can cause bad shadowing effects.  If you use the Intel
event aliases they have all sensible periods set by default.

-Andi
