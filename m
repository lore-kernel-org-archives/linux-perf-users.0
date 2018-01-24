From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] perf/core: Fix installing cgroup event into cpu
Date: Wed, 24 Jan 2018 10:46:36 +0100
Message-ID: <20180124094636.GP2228@hirez.programming.kicks-ass.net>
References: <20180124075010.83296-1-linxiulei@gmail.com>
 <20180124082036.GL2228@hirez.programming.kicks-ass.net>
 <CALPjY3mj7--oAmObtECYDw5GaJ3wLroBVrQ5eQztqmYMCm=8Cw@mail.gmail.com>
 <20180124091456.GN2228@hirez.programming.kicks-ass.net>
 <CALPjY3mZYSs-8Bg0U0kq=jPz+TX8RxfpvBeVs6oxspfwLjOjfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56685 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932606AbeAXJqo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Jan 2018 04:46:44 -0500
Content-Disposition: inline
In-Reply-To: <CALPjY3mZYSs-8Bg0U0kq=jPz+TX8RxfpvBeVs6oxspfwLjOjfA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Lin Xiulei <linxiulei@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, Stephane Eranian <eranian@gmail.com>, torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org, Brendan Gregg <brendan.d.gregg@gmail.com>, yang_oliver@hotmail.com, jinli.zjl@alibaba-inc.com, "leilei.lin" <leilei.lin@alibaba-inc.com>

On Wed, Jan 24, 2018 at 05:19:34PM +0800, Lin Xiulei wrote:
> Sure, and I consider this "OK" works for "What goes wrong if we leave
> it set?". : )

It would be good if you inspect the code for the case of leaving
cpuctx->cgrp set with no cgroup events left -- AND -- put a blurb about
what you found in your new Changelog.

I suspect it works out and something like perf_cgroup_switch() will fix
things up for us later, but double check and test.
