Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EA48167E;
	Wed,  5 Aug 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946989; cv=none; b=mpzqhr0VwzxlTJn6Flizl6HjyKfh7+vedg47rD5OhO8NRGvYsSMa0Y7jgnWzAx9wEvSwChyBKxs05KGubibxA9M2F6sgZXWlahKUuhhzMDDyCfTd1E6Mc3GX0kTP4/wW+iPnXpmqaFsz6swcdSOZCv75PIL7KBMcScv+sHkQDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946989; c=relaxed/simple;
	bh=FbH4KnjmAOKV41m3n5qm3Zth3SCfDDD7V11ruX43Bxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZsF5pTzWj4LmEXxwA56HKIfB/tWohMWSBXoa8FQyyPnqrc2bbfx1l1pFrzB3Evuvj40WCBDKZ1u+vXEhmsLbzv4LG3D+F3nwVWUcWvi5Omb/lM7+Px2tJxYkePD1tppJ65QqSzTo8PfJcIrkCDvrRn9qdMQ0K+FFjcsKbaGPavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G84xkThM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G84xkThM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BED1F00A3F;
	Wed,  5 Aug 2026 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946987;
	bh=VeILfFZLkqo7ycbkrB2oZEqZg3akWbjQWLeJ7Y1AV+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G84xkThMQZ6In8Qhua6rGtUUD0xFPfnDw8J1GnNtPl8WnG9x4PnwKHz075XND0OrK
	 spSH9ZwCIubOgYhsVEcqbfLgojYq9DUfLrgAomUUI2GhqmNjiJ9voUIpJkM2UNUyKN
	 TfwBR7LMSzXmVQX/XhqPewcHwFkQNPTqwhLSIEGRaBU860FAWw1LSC11wAGnkqBxBw
	 fitxzLghfGwe0KjLbwOb+ry/VstPsVbwWZAO3RTZ9MvetnCAFS+GtfCUl11HuY55no
	 x4wOyJy06eDrw8YYSWuhhUFhe2Y3Imcan/Ox+a/UOA70cpWp8bPslb2lI4PFw/uw4B
	 JvfWfs+/Ie/HQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v4 01/11] perf/cxl: Program the requested event
 group on configurable counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260805155911.1304807-2-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
 <20260805155911.1304807-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:23:06 +0000
Message-Id: <20260805162307.B1BED1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing unfreeze of CPMU counters in the IRQ handler causes the PM=
U to permanently stop counting after the first overflow.
- [High] Incorrect wrap-around arithmetic in `__cxl_pmu_read` double-counts=
 events on overflow and triggers undefined behavior.
--

--- Patch [1]: [RESEND PATCH v4 01/11] perf/cxl: Program the requested even=
t group on configurable counters ---
commit eb034a4b2ed07ff56c863ab7711fcb1eb6012a8b
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Program the requested event group on configurable counters

cxl_pmu_get_event_idx() sets *counter_idx for a configurable counter but
never *event_idx. hwc->event_base stays 0, so cxl_pmu_event_start() programs
event group 0 no matter which group the user asked for. This commit fixes t=
he
issue by returning the matched capability's event_idx.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 68a54d97d2a8a..ff01b658e1b45 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -541,7 +544,7 @@ static int cxl_pmu_get_event_idx(struct perf_event *e=
vent, int *counter_idx,
> =20
>  	pmu_ev =3D cxl_pmu_find_config_counter_ev_cap(info, vid, gid, mask);
>  	if (!IS_ERR(pmu_ev)) {
> -		if (!counter_idx)
> +		if (!counter_idx || !event_idx)
>  			return 0;
> =20
>  		bitmap_andnot(configurable_and_free, info->conf_counter_bm,

While reviewing this patch, I noticed a couple of pre-existing issues in
this file:

drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
    ...
	delta =3D (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0);
	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
		delta +=3D (1UL << info->counter_width);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this wrap-around
arithmetic double-count events on overflow and trigger undefined behavior?

Because the wrap-around is already accounted for in delta during the
unsigned subtraction, adding 2^width erroneously double-counts the
overflow, injecting an enormous spurious value into event->count every
time an interrupt fires.

Furthermore, if the hardware specifies a 64-bit counter
(info->counter_width =3D=3D 64), evaluating 1UL << 64 invokes undefined
behavior in C.


drivers/perf/cxl_pmu.c:cxl_pmu_irq() {
    ...
		__cxl_pmu_read(event, true);
	}

	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);

	return IRQ_HANDLED;
}

[Severity: High]
This is a pre-existing issue, but does this interrupt handler need to write=
 0
to CXL_PMU_FREEZE_REG to unfreeze the counters?

In cxl_pmu_event_start(), the configuration sets
CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW. According to the CXL 3.0
specification, when this is set, an overflow causes the hardware to
freeze counters by setting bits in the Freeze Register.

The IRQ handler clears the overflow register (CXL_PMU_OVERFLOW_REG) but
fails to explicitly clear the freeze register (CXL_PMU_FREEZE_REG).
Consequently, the counters remain permanently frozen and stop generating
events after processing the first overflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805155911.1304=
807-1-dave.jiang@intel.com?part=3D1
