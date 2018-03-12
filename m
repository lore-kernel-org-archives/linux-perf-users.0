From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RESEND v5] perf/core: Fix installing arbitrary cgroup
 event into cpu
Date: Mon, 12 Mar 2018 08:53:07 +0100
Message-ID: <20180312075307.iut52znscixqcpag@gmail.com>
References: <20180306093637.28247-1-linxiulei@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180306093637.28247-1-linxiulei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linxiulei@gmail.com
Cc: peterz@infradead.org, jolsa@redhat.com, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, eranian@gmail.com, torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org, brendan.d.gregg@gmail.com, yang_oliver@hotmail.com, "leilei.lin" <leilei.lin@alibaba-inc.com>
List-Id: linux-perf-users.vger.kernel.org


* linxiulei@gmail.com <linxiulei@gmail.com> wrote:

>  	/*
>  	 * Because cgroup events are always per-cpu events,
>  	 * this will always be called from the right CPU.
>  	 */

> +	/*
> +	 * if only the cgroup is running on this cpu
> +	 * and cpuctx->cgrp == NULL (otherwise it would've
> +	 * been set with running cgroup), we put this cgroup
> +	 * into cpu context. Or it would case mismatch in
> +	 * following cgroup events at event_filter_match()
> +	 */

Beyond making sure that what you comment on makes sense, please also follow 
existing comment style, which I quoted above.

There's 3 separate mistakes in that paragraph alone.

Thanks,

	Ingo
