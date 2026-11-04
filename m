Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820020;
	b=Rxk1KPSQ9XHAgnIxw9LUqlySSNd5dniGvwB5XX+vwXyCEXP9xw4IblVpD10d5UI3ZAeL
	 5exi+ucEJTUGEqS7jW0izG/6TgYFsryBGrpSK91ZyMFrt7HDq+veWqhyHTU1JcrNBEDHw
	 mLkRGDuOoSkTb37J5zhIkttrP0QiLmnzDD86ph6Cipf6sB/lrzr2SePYhI08x6/FRFu2g
	 3i5m9ntMiFdG1qAjGUpzAIYn9L56/bGc3JHc8jKT8OjlsTHK4ht8skzAB/NAEbHov0h8l
	 lO4o9gGfrzDFgQU0101yYptSTFaELOtDzw4gZykbLwO/xJweIgljM6WLasq6+QOc5qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820020;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FNJxIyn3OjQa7qsX7mKnRQCLH8y7rC0XCsj//fWulnc=;
	b=BLDEMZP4qmKvfgRRD/OhdXh7nzyNYj1Dx5JQtUyPYme/Cs1lHlJ7V1vO2UCCaWmha2w0
	 fgjLbgVKqqigebO9hexPf48KKSZ/9pd2ZLSZMhNk0q4Si5VwcZkbE9bcKRbsyfuihqNaU
	 +CY9qZ4VMxPNSO7LvtHne3SuViFNWoOLxMGENe7fZ8k0TlWJ6NPZioe0QmfThGtHStOWF
	 iBwppkwOHuuOZm/QN1Vn8jEob8qK0/x/1T5mo3+TCyuSDPJDmfqOyHhRBBTCegEfEKpTY
	 OQDay6kF6OYaujnYRnbro63fajfihbJQzvItRGcAdjLahLvbImiKCH8Pjf6Rirrq8Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPQUmNmM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1460A6F73
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPQUmNmM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B001F000C1;
	Wed,  4 Nov 2026 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820020;
	bh=FNJxIyn3OjQa7qsX7mKnRQCLH8y7rC0XCsj//fWulnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IPQUmNmM3SMDcESA3k+xbakhVLJwBbwZsjESO/Vp/s5ZaaRyt8/BhrE/hRqCzkhXH
	 6S2vrljuT5P0m1fy11xzdoC4ofzrmaP6LXnuKefD6KQQ/i7+VUqGTDpf6kFweIIxDC
	 1W2F0bb64m0/GfPB/wJcImQ7IO3JZ8NMuOufsgIWK4NJWnzkLb1KZj8ZyfEsiR9so2
	 UP0a8LH0FUEFvQKo1ZZEiT1w5/BbhNKy4RAEhbqWP7O4bV30Fdg/reQihhmID9/xSs
	 cFTuRWeIbRNuf1vdtWUL07G9LUGBSDfLT04UbJT/3zTQhV60kDoqnEGP90VufBNcfG
	 Z6i5nbueIP3pA==
Message-ID: <sashiko-outbox-197938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/13] alpha/perf: implement ProfileMe sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-6-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-6-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:20:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] alpha/perf: out-of-bounds access and counter clobber in alpha_pmu_=
del()
--

commit 121343eeb88cb4425f51a24aa10437522d101e9f
Author: Matt Turner <mattst88@gmail.com>

alpha/perf: implement ProfileMe sampling

This commit implements ProfileMe sampling mode on Alpha EV67 and later
processors, selectable via the profileme config attribute or precise_ip.
It configures PCTR0 and PCTR1 together for ProfileMe events, attributes
samples to the latched PMPC address, and parks stopped ProfileMe counters
away from overflow to avoid PALcode interrupt lockups.

> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index dd7fc4ac1396e..7208d09a32d1f 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c

[ ... ]

> @@ -562,7 +644,10 @@ static void alpha_pmu_del(struct perf_event *event, =
int flags)
>  			alpha_perf_event_update(event, hwc, idx, 0);
>  			perf_event_update_userpage(event);
> =20
> -			cpuc->idx_mask &=3D ~(1UL<<idx);
> +			if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME)
> +				alpha_perf_event_park(hwc);
> +
> +			cpuc->idx_mask &=3D ~alpha_event_idx_mask(hwc, idx);

[Severity: High]
What happens in alpha_pmu_del() if an event is removed during group
scheduling rollback before maybe_change_configuration() has assigned it a
counter index?

When group_sched_in() schedules a group while the PMU is disabled,
event_sched_in() -> alpha_pmu_add() sets cpuc->current_idx[n0] to
PMC_NO_INDEX (-1):

arch/alpha/kernel/perf_event.c:alpha_pmu_add() {
	...
	if (n0 < alpha_pmu->num_pmcs) {
		cpuc->event[n0] =3D event;
		cpuc->evtype[n0] =3D event->hw.event_base;
		cpuc->current_idx[n0] =3D PMC_NO_INDEX;
	...
}

Because the PMU remains disabled across the group transaction,
perf_pmu_enable() does not invoke alpha_pmu_enable() ->
maybe_change_configuration() until the entire group is added.

If a subsequent sibling hardware event in the group fails alpha_pmu_add()
(for instance, if a ProfileMe event was opened with attr.disabled =3D 1 so
collect_events() skipped it while in PERF_EVENT_STATE_OFF when a second
hardware sibling was initialized, and the group is later enabled; or when an
Aggregate group only partially fits alongside an already-active event),
group_sched_in() rolls back the already-added event via event_sched_out() ->
alpha_pmu_del().

In alpha_pmu_del(), idx is read from cpuc->current_idx[j], which is still
PMC_NO_INDEX (-1):

1. alpha_perf_event_update(event, hwc, -1, 0) indexes
   alpha_pmu->pmc_count_shift[-1], alpha_pmu->pmc_count_mask[-1], and
   alpha_pmu->pmc_max_period[-1] out of bounds, corrupting event->count and
   hwc->period_left.

2. If the rolled-back event has ALPHA_PERF_FLAG_PROFILEME set,
   alpha_perf_event_park() writes PCTR0 and zeroes PCTR1 in hardware via
   alpha_write_pmc_profileme() even though the event was never programmed
   onto the PMU, and cpuc->idx_mask &=3D ~alpha_event_idx_mask(hwc, idx) cl=
ears
   EV67_PCTR_0 | EV67_PCTR_1 from cpuc->idx_mask.

3. For a non-ProfileMe event, alpha_event_idx_mask(hwc, -1) evaluates
   1UL << -1.

Should alpha_pmu_del() check that idx !=3D PMC_NO_INDEX before updating the
event count, parking the ProfileMe counter, and clearing the counter bits in
cpuc->idx_mask (and also decrement cpuc->n_added when rolling back an
unassigned event)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D6
