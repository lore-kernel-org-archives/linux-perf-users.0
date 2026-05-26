Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37123409639;
	Tue, 26 May 2026 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816129; cv=none; b=EnqgJBSoQuknaUpGRxjTOpgOGE1a8UOXPp94dI9vhed1HYjmPlMc7hSvfHtSvl0caTU4/Rh1rRTl1rbocp9/bDAZzVRORWUO4CDWYqmhdJYWF1a4hhAa8L25g3+R+ugfPShS0JEkBmhhg/lWisZquH3lHCg2y0x6WEbglaLnzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816129; c=relaxed/simple;
	bh=cftIROrufN5KTHvbTf1Hh1vHNPzf4GvBCrZkNiIfiWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YWe/tCNzc2QgMZUSRgktVElCdU73pgqtJx5Eq9HPJEjdLZwGRprH6GiCJEVirsMjygZiMOHkAGu0X9aoRbqRKxTaGCe01Q6MRfjPm/dy4/LLpAGKzWoydN3P6J4yYWNPoQjdAgdUujWK4/aF0lxwI+t3VbK8o2SbIGmYPGMJpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbQe3kXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbQe3kXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B63D1F000E9;
	Tue, 26 May 2026 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779816127;
	bh=+pb9u8md+1jJKMPsMcJZxTXZuOwvAJj4vCNPcj+GWUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JbQe3kXpvxApoj8V8CpfZ1VWs6W+t+k6ze/7V6QHC8Fytr0K5ZVkSuQRHowIBxVGV
	 40SW0kokfKaCNPMho1OpTV0GrDjtyvy/zyCr9plmUuZADserdo111MRPQUMVmTuinu
	 SFxa0f+/NAT0A1G7ajbUGTR6V3TmBJeJGk4d4EEaUbnWOvifzcQ2ZPvzF8isDBKt9V
	 gd1jvl9mb64pFX3nSUDfRwD4NS/PW9TcN/W3QNfrMuAt3XOjMUgJe5WcYWzMzVMl+8
	 84X9Mgl1ICmhyuw/MceHHMgR8p5dBPUox/3rMsnCqF4hePiQBQ07KhipPFi0rbQ6BY
	 4DkkH/kFp4UhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] perf: marvell: Add CN20K DDR PMU support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geetha sowjanya" <gakula@marvell.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260526164330.23878-3-gakula@marvell.com>
References: <20260526164330.23878-3-gakula@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 17:22:07 +0000
Message-Id: <20260526172207.8B63D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Overlapping switch case ranges cause a compilation error, and brok=
en fallthrough logic prevents Odyssey DFI events from being handled.
- [Medium] New CAS events are exported via sysfs but unhandled in the drive=
r, rendering them unusable.
- [Medium] Incomplete configuration of CN20K ZQ events causes hardware stat=
e leakage and potential enablement failures.

Pre-existing issues:
- [Critical] The error path in `cn10k_ddr_perf_event_add()` leaks a counter=
 allocation and leaves a dangling pointer, leading to a Use-After-Free.
--

commit d7ca37a605c64e38783da21352c22989b06d59ba
Author: Geetha sowjanya <gakula@marvell.com>

perf: marvell: Add CN20K DDR PMU support

This patch adds support for the CN20K DRAM Subsystem PMU, which monitors DDR
traffic. It introduces new events, sysfs attributes, and device match data
for the CN20K variant. The PMU logic is also updated to handle
CN20K-specific event mappings and register offsets.

> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_=
cn10k_ddr_pmu.c
> index 72ac17efd846a..4d8bdd9233bd9 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c

[ ... ]

> @@ -87,6 +117,9 @@
>  #define EVENT_OP_IS_SPEC_REF			41
>  #define EVENT_OP_IS_CRIT_REF			40
>  #define EVENT_OP_IS_REFRESH			39
> +#define EVENT_OP_IS_CAS_WCK_SUS			38
> +#define EVENT_OP_IS_CAS_WS_OFF			37
> +#define EVENT_OP_IS_CAS_WS			36
>  #define EVENT_OP_IS_ENTER_MPSM			35

[ ... ]

> @@ -336,6 +369,80 @@ static struct attribute *odyssey_ddr_perf_events_att=
rs[] =3D {

[ ... ]

> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_cas_ws, EVENT_OP_IS_CAS_WS),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_cas_ws_off, EVENT_OP_IS_CAS_WS_OFF),
> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_cas_wck_sus, EVENT_OP_IS_CAS_WCK_SUS),

[Severity: Medium]
Will these new CAS events return -EINVAL when configured?

The IDs for these events (36, 37, and 38) fall into the gap between
EVENT_WAW_HAZARD (26) and EVENT_OP_IS_REFRESH (39).

Because ddr_perf_get_event_bitmap() was not updated to handle this range:

    case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
    case EVENT_OP_IS_REFRESH ... EVENT_OP_IS_ZQLATCH:
        *event_bitmap =3D (1ULL << (eventid - 1));
        break;

it seems userspace attempts to use these attributes will fall to the default
case and fail.

> +	CN10K_DDR_PMU_EVENT_ATTR(ddr_refresh, EVENT_OP_IS_REFRESH),

[ ... ]

> @@ -411,8 +525,22 @@ static int ddr_perf_get_event_bitmap(int eventid, u6=
4 *event_bitmap,
>  	int err =3D 0;
> =20
>  	switch (eventid) {
> +	case EVENT_PERF_OP_IS_WR32 ... EVENT_PERF_OP_IS_RD16:

[Severity: High]
Does this code introduce overlapping switch case ranges?

EVENT_PERF_OP_IS_WR32 is 58 and EVENT_PERF_OP_IS_RD16 is 61, so this covers
values 58 to 61.

However, the existing code already handles EVENT_DFI_PARITY_POISON to
EVENT_DFI_CMD_IS_RETRY:

    case EVENT_DFI_PARITY_POISON ...EVENT_DFI_CMD_IS_RETRY:

If EVENT_DFI_PARITY_POISON is 56 and EVENT_DFI_CMD_IS_RETRY is 61, these
ranges overlap, which will cause a compiler error.

> +		if (ddr_pmu->p_data->silicon_flags & IS_CN20K) {
> +			*event_bitmap =3D (1ULL << (eventid - 1));
> +			break;
> +		}
> +		/* Same numeric IDs as Odyssey DFI events 58..61 */
> +		fallthrough;

[Severity: High]
Does the fallthrough correctly handle non-CN20K silicon events here?

It falls into the ZQLATCH/ZQSTART block below, which performs an explicit
check for IS_CN20K:

> +	case EVENT_CN20K_OP_IS_ZQLATCH ... EVENT_CN20K_OP_IS_ZQSTART:
> +		if (ddr_pmu->p_data->silicon_flags & IS_CN20K) {
> +			*event_bitmap =3D (1ULL << (eventid - 42));
> +			break;
> +		}
> +		err =3D -EINVAL;
> +		break;

If an Odyssey device processes an event between 58 and 61, it will fail the
IS_CN20K check, hit err =3D -EINVAL, and break. This rejects all valid Odys=
sey
events in this range instead of falling through to the DFI block below.

>  	case EVENT_DFI_PARITY_POISON ...EVENT_DFI_CMD_IS_RETRY:
> -		if (!ddr_pmu->p_data->is_ody) {
> +		if (!(ddr_pmu->p_data->silicon_flags & IS_ODY)) {
>  			err =3D -EINVAL;
>  			break;
>  		}

[ ... ]

> @@ -642,10 +771,15 @@ static int cn10k_ddr_perf_event_add(struct perf_eve=
nt *event, int flags)
>  	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
>  		/* Generic counters, configure event id */
>  		reg_offset =3D DDRC_PERF_CFG(p_data->cfg_base, counter);
> +
>  		ret =3D ddr_perf_get_event_bitmap(config, &val, pmu);
>  		if (ret)
>  			return ret;

[Severity: Critical]
This is a pre-existing issue, but does this error path lead to a
Use-After-Free?

Earlier in cn10k_ddr_perf_event_add(), the driver calls
cn10k_ddr_perf_alloc_counter() which stores the event pointer in pmu->events
via pmu->events[counter] =3D event.

If ddr_perf_get_event_bitmap() fails here and returns early, the counter is
not freed, active_events is not decremented, and the pointer remains in
pmu->events.

When the perf core eventually frees the event, pmu->events[counter] is left
dangling.

The background hrtimer then triggers an overflow, calls
cn10k_ddr_perf_event_update_all(), and dereferences the freed event pointer.

> -
> +		if (silicon_flags & IS_CN20K) {
> +			if (config =3D=3D EVENT_CN20K_OP_IS_ZQSTART ||
> +			    config =3D=3D EVENT_CN20K_OP_IS_ZQLATCH)
> +				reg_offset =3D DDRC_PERF_CFG(p_data->cfg1_base, counter);

[Severity: Medium]
Will this leave hardware state behind and cause enablement failures?

When configuring a CN20K ZQ event, the code writes the event configuration =
to
cfg1_base, but fails to clear the primary configuration register at cfg_bas=
e.

Later, cn10k_ddr_perf_counter_enable() unconditionally uses cfg_base to ena=
ble
the event:

    reg =3D DDRC_PERF_CFG(p_data->cfg_base, counter);
    val =3D readq_relaxed(pmu->base + reg);
    if (enable)
        val |=3D EVENT_ENABLE;

Because PMU counters do not clear cfg_base on event deletion, enabling a new
ZQ event might inadvertently enable a stale event still left over in cfg_ba=
se,
leading to corrupted performance counts.

> +		}
>  		writeq_relaxed(val, pmu->base + reg_offset);
>  	} else {
>  		/* fixed event counter, clear counter value */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526164330.2387=
8-1-gakula@marvell.com?part=3D2
