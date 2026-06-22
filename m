Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6416C3ACEF2
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132812; cv=none; b=o9L2jXG03c85RWyfn1Rf93WcUioIvy/JZ1NGAgdotpwXxZxn+4OgmzRbpVZbwSKfzWCjZY+V6xRqXK+lERg3yA2OV6v0gE/9uKQlYAottlTKRUKQLuRsPp+QKy3ID0WXxUbZXYD2810omOOCYU8geh9xF2MpT5W6iGzACOJQJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132812; c=relaxed/simple;
	bh=1gjbYUKCLXrCMjxiZzQwjuKTjYfrNWU9G0Y0Vu7JiMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lm0EujZRCQdLExsDJHYtrEabxO5UntSar85BnChqM9G4OftFa7V5wk0ywC73G7AZP9RZNLN9VdyDNHoe2nKxwB0sTkhnnRvxIuUPJVk81HSmVv/4/6ugSe0imvCnrTSb4gUgPEf2OBoKxr9uyJgLpk6VM4TBCavAmhnPc6UldtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ2jMYMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ2jMYMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9361F000E9;
	Mon, 22 Jun 2026 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782132811;
	bh=WTrNCLD32S/hgjs4xCzo8jNs+w44MBN7WuhlUxk7y5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJ2jMYMhftj0sZ0zE31hK9xNLrfnSu+99+XdDllzw+61NJWJeA1qd4wV6PA6ZmZ0m
	 jiehK4Wvx4wCK/aTY8gcSkt+1g/ONSr5hDKwR3OzTG9MBdRlo5VwCzHFyBbHvouWTF
	 RSK+LwXDGOX7m2ObKzg7kx4u0T+mvcQ/6qTekS2HjQfQNjJlTQyFToov2ByyDWeyP8
	 UJScZLEKl9Iu88CxmjwXIkR02jDkCPwfzNRQLLy+qsPUNAL1hUCNLifNSCB1fFJQuZ
	 vlcYtC9yMuP3LUfBPxb/krmHuHrsrblAGJIyKCA2MiHCh5AFqxpmZrVhLeZY47oTRA
	 g6XVnZjUOkjiQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC][PATCH] perf: Fix perf_addr_filters_afjust()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260622123245.GS48970@noisy.programming.kicks-ass.net>
References: <20260622123245.GS48970@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 12:53:30 +0000
Message-Id: <20260622125330.EB9361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Incomplete RCU conversion for `child_list`: missing `list_add_tail=
_rcu` in `inherit_event` leads to a data race and potential crashes for con=
current RCU readers.
- [High] The parent event is completely skipped during address filter adjus=
tments, breaking hardware address filtering for the primary task.

Pre-existing issues:
- [Critical] The `event->addr_filter_ranges` array is freed synchronously, =
leading to a Use-After-Free when concurrent RCU readers access it during th=
e RCU grace period.
--

commit a5419e8444b35216c0ba361188f91ecd86875fd1
Author: Peter Zijlstra <peterz@infradead.org>

perf: Fix perf_addr_filters_afjust()

This patch adjusts the locking order for perf_event_addr_filters_apply()
and converts child_list to be RCU-protected to avoid taking child_mutex
under mmap_lock. It updates perf_addr_filters_adjust() to iterate through
child events under RCU.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 00e6dcb931d96..af3c123010407 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -9902,35 +9903,64 @@ static bool perf_addr_filter_vma_adjust(struct pe=
rf_addr_filter *filter,
>  	return true;
>  }
> =20
> -static void __perf_addr_filters_adjust(struct perf_event *event, void *d=
ata)
> +static int perf_child_addr_filters_adjust(struct perf_event *event,
> +					  struct vm_area_struct *vma)
>  {
>  	struct perf_addr_filters_head *ifh =3D perf_event_addr_filters(event);
> -	struct vm_area_struct *vma =3D data;
> -	struct perf_addr_filter *filter;
>  	unsigned int restart =3D 0, count =3D 0;
> -	unsigned long flags;
> -
> -	if (!has_addr_filter(event))
> -		return;
> +	struct perf_addr_filter *filter;
> =20
> -	if (!vma->vm_file)
> -		return;
> +	guard(raw_spinlock)(&ifh->lock);
> =20
> -	raw_spin_lock_irqsave(&ifh->lock, flags);
>  	list_for_each_entry(filter, &ifh->list, entry) {
>  		if (perf_addr_filter_vma_adjust(filter, vma,
>  						&event->addr_filter_ranges[count]))

[Severity: Critical]
This is a pre-existing issue, but could a concurrent RCU reader access an
already freed addr_filter_ranges array here?

When an event's refcount drops to zero, __free_event() frees the array
synchronously:

kernel/events/core.c:__free_event() {
    ...
    kfree(event->addr_filter_ranges);
    ...
}

If a concurrent mmap() traverses the child_list under RCU, could it find the
dying event during the grace period and write to this freed memory?

>  			restart++;
> =20
>  		count++;
> +
>  	}
> =20
>  	if (restart)
>  		event->addr_filters_gen++;
> -	raw_spin_unlock_irqrestore(&ifh->lock, flags);
> =20
> -	if (restart)
> -		perf_event_stop(event, 1);
> +	return restart;
> +}
> +
> +static void __perf_addr_filters_adjust(struct perf_event *event, void *d=
ata)
> +{
> +	struct perf_event *child, *parent =3D event->parent ?: event;
> +	struct vm_area_struct *vma =3D data;
> +
> +	if (!has_addr_filter(event))
> +		return;
> +
> +	if (!vma->vm_file)
> +		return;
> +
> +	list_for_each_entry_rcu(child, &parent->child_list, child_list) {

[Severity: High]
Are the parent event's address filters skipped during adjustments?

Because list_for_each_entry_rcu() only iterates over the list nodes, the
parent event hosting the child_list head won't be included in the iteration.

If a standalone process creates an event and mmaps it, its child_list is
empty. Will this cause the parent's filter ranges to remain unadjusted,
breaking hardware address filtering for the primary task?


[Severity: High]
Since child_list is now RCU-protected, should the addition of child events
use RCU primitives to prevent data races?

In inherit_event(), child events are still added using the non-RCU
list_add_tail():

kernel/events/core.c:inherit_event() {
    ...
    /*
     * Link this into the parent event's child list
     */
    list_add_tail(&child_event->child_list, &parent_event->child_list);
    mutex_unlock(&parent_event->child_mutex);
    ...
}

Because list_add_tail() lacks the memory release barrier provided by
list_add_tail_rcu(), could concurrent lockless RCU readers observe the newly
linked list node before its initialization is visible to the reading CPU?

> +		struct perf_event_context *ctx;
> +		struct task_struct *task;
> +		int restart =3D 0;
> +
> +again:
> +		ctx =3D READ_ONCE(child->ctx);
> +		scoped_guard (raw_spinlock_irqsave, &ctx->lock) {
> +			if (child->ctx !=3D ctx)
> +				goto again;
> +
> +			task =3D ctx->task;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622123245.GS48=
970@noisy.programming.kicks-ass.net?part=3D1
