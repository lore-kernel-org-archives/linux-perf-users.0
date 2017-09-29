From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] perf/core: Fix updating cgroup time with descendants
Date: Fri, 29 Sep 2017 11:25:20 +0200
Message-ID: <20170929092520.v2gb7dmsfrd2nszg@hirez.programming.kicks-ass.net>
References: <CALPjY3mkHiekRkRECzMi9G-bjUQOvOjVBAqxmWkTzc-g+0LwMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbdI2JZa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Sep 2017 05:25:30 -0400
Content-Disposition: inline
In-Reply-To: <CALPjY3mkHiekRkRECzMi9G-bjUQOvOjVBAqxmWkTzc-g+0LwMg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Lin Xiulei <linxiulei@gmail.com>
Cc: yang_oliver@hotmail.com, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, Stephane Eranian <eranian@gmail.com>, torvalds@linux-foundation.org, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, brendan.d.gregg@gmail.com

On Fri, Sep 29, 2017 at 01:54:44PM +0800, Lin Xiulei wrote:
> From: "leilei.lin" <leilei.lin@alibaba-inc.com>
> 
> This fix updating cgroup time when event is being scheduled in
> by descendants
> 
> Signed-off-by: leilei.lin <leilei.lin@alibaba-inc.com>
> Reviewed-and-tested-by: Jiri Olsa <jolsa@kernel.org>

Thanks!
