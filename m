Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D61364038
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207345; cv=none; b=aMcL9jy3dczQdNo1yIdBtmTEgCO+HS9+iTTdXN27yBDlS9S0xmeG1ZQepBFcc3xTZBsIQprNOJxQgIqhRS3CA5gEfXNxadj25xykMrvqcs8uzClurxVm4azxrIFjrjwYg28gIlr4ML/c3IsloWA4ksJjucSf/bx7UtbC9XJ2xgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207345; c=relaxed/simple;
	bh=GZ+3VArkIl084sY5FJM2wYaayBi4bH5j+kXk5X5d70s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RgkwEKfVTrDQJfVipD6UH1lvHwapYT6eWJZIDJwk/PecY8ORL1LUkLUNKkiNZuyRfm6doWj5XP9YKpK+80CL0mulom7jXlHHoH+xFW/Hi9atbsPgD33wSkqf7bdYDZLwJSSqyfeMPkfx7iut6p84MT8pqJfdWW46+x9j3Jl9PR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOrMJi5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOrMJi5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D248D1F000E9;
	Tue, 23 Jun 2026 09:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782207344;
	bh=oRPICHxMBiuVi03zz8D9nZBzhBPxvyS3KhWBAqDC+kQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GOrMJi5zaohPnbHJIipWWB/YTnzl/VphNF6qBnB2lFVOFMgYTuyS68UDRMX0K9MhZ
	 h8bNVgZ5lhbrpmJu1r9+Rg9jjEPb03G7+MLUgPAl0H+NWNiLhnEkRZ2xmbFttAlNJ5
	 NqP8jE5Psda2qLCzC0p+y+ChuyyKuYLhSuXrcaUOAjhWxtKAtCBc0nkhhpXmtTbpsO
	 UaiaR2hwuXGAIjeGZqIFlGaUisFLLyC6CXp9AYNKReo7/o+EvKjgnNHDCIw1QsQVf4
	 xUPqITRA0WVHT2COWwjsmlGuB1ayRv/p+sB7WBvGYILPO9oeBdb5sP2pHEcdBoN6Q5
	 nOGctN8TPTGcQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC][PATCH v2] perf: Fix perf_addr_filters_afjust()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623091426.GF49529@noisy.programming.kicks-ass.net>
References: <20260622123245.GS48970@noisy.programming.kicks-ass.net>
 <20260623091426.GF49529@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:35:43 +0000
Message-Id: <20260623093543.D248D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Synchronous freeing of `event->addr_filter_ranges` leads to Use-Af=
ter-Free during RCU traversal of remote child events.
--

commit 799a469d82e3e73dd73373d7ff11de097bcf39a2
Author: Peter Zijlstra <peterz@infradead.org>

perf: Fix perf_addr_filters_afjust()

Adjusts the lock order and iteration logic for perf_addr_filters_adjust()
to safely handle remote events under RCU. It iterates over the child_list
to find inherited events across threads and uses ctx->lock for
synchronization.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 00e6dcb931d96..1918a301f23f0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -9902,21 +9903,15 @@ static bool perf_addr_filter_vma_adjust(struct pe=
rf_addr_filter *filter,
[ ... ]
> +static int __perf_event_addr_filters_adjust(struct perf_event *event,
> +					    struct vm_area_struct *vma)
>  {
>  	struct perf_addr_filters_head *ifh =3D perf_event_addr_filters(event);
>  	unsigned int restart =3D 0, count =3D 0;
> +	struct perf_addr_filter *filter;
> =20
> +	guard(raw_spinlock)(&ifh->lock);
> =20
>  	list_for_each_entry(filter, &ifh->list, entry) {
>  		if (perf_addr_filter_vma_adjust(filter, vma,
>  						&event->addr_filter_ranges[count]))
>  			restart++;
> =20
>  		count++;
>  	}
[ ... ]
> +static void __perf_addr_filters_adjust(struct perf_event *event, void *d=
ata)
> +{
> +	struct perf_event *child, *parent =3D event->parent ?: event;
> +	struct vm_area_struct *vma =3D data;
[ ... ]
> +	perf_event_addr_filters_adjust(parent, vma);
> +	list_for_each_entry_rcu(child, &parent->child_list, child_list)
> +		perf_event_addr_filters_adjust(child, vma);
> +}

[Severity: High]
This is a pre-existing issue, but does this new RCU traversal of remote chi=
ld
events expose a use-after-free on event->addr_filter_ranges?

If a child event concurrently exits, it is removed from the list in
perf_child_detach() via list_del_rcu(&event->child_list). Its release proce=
ss
ultimately calls __free_event(), which synchronously frees the array:

kernel/events/core.c:__free_event() {
        ...
        kfree(event->addr_filter_ranges);
        ...
}

Because this kfree() happens synchronously before the RCU grace period elap=
ses,
the array memory is immediately returned to the allocator.

Meanwhile, the mmap thread running __perf_addr_filters_adjust() under
guard(rcu)() can still safely find and dereference the child event, but it
proceeds to call __perf_event_addr_filters_adjust() and writes directly into
the already freed event->addr_filter_ranges array.

Could this synchronous kfree() in __free_event() result in memory corruption
when perf_addr_filter_vma_adjust() modifies the array during this RCU walk?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623091426.GF49=
529@noisy.programming.kicks-ass.net?part=3D1
