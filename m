Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D36390618;
	Fri, 12 Jun 2026 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260007; cv=none; b=KSvdBAdj1wOTl2yCdmpOE37DHrf4BAxXZ3RR5GW2k1zxP8DnoyUW9L6+XsjtCVYVuXbcOGK58wioJwp82pKKpmVJ95gNIt9xkBd77JVLXtOTR1iFpYIc58zFgorEnkeZaG19eV/iVok51pdFdYK8KkvBd0S6NQbOE/Nt3czAtfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260007; c=relaxed/simple;
	bh=a/OT5roFOpiK8nIUo0+Fcrxk+A5JHYPBdVL90nniiuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jubxXIP86dZ8F6p9zweM2hPx2EO6VfVcXcHU3HneXzHYSujsGylQtvYsQ1xHRabW4IZp2G3NiGFilLAwqyviZkXNKfhjySTfI2ivb5vfgjfjw6yqY9HZnvPen3bKJVJ9UHgu2oiyA/SZRihRLb/ubsgs+ZV5qoq8n3FMLWyoIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNlMLqxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNlMLqxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613251F00A3A;
	Fri, 12 Jun 2026 10:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781260003;
	bh=57aH8BTzDAXOkaQLQ4ByLOpVljdF7x48XY0tX9dvC7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PNlMLqxa2zsxBI54wZnT/AFNYDY4bqUK7u8a3OiMXrOF+Jh1On6LxkHhUIeytsxyL
	 eWIM4kd7tVDj4P3MgegvyQKH3/POVDdLrR4v3Ve2OuFFazWSGCvjDBhbFXYV3PAebE
	 afmyeYgbJ/TiEat6OIJK8n7wf4yez/Ii3+9/Qx7ki6baJw1JXFlmAfCqv7pTK306ev
	 k/2B1pqcFFFPnZbm1E/amQbR+oXbKRZRQHmvq6JywRah0S8PRntFr06cnkbzcP74Hq
	 TLiQRch73i7mUyH9vbz4dTc5Y7z5acS67plBw7cHJ3rK/A8nzniiMx6b721IJTRSEs
	 KdnlvDkeeYH8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf: marvell: Add CN20K LLC-TAD PMU support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geetha sowjanya" <gakula@marvell.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260612095746.19679-3-gakula@marvell.com>
References: <20260612095746.19679-3-gakula@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 10:26:42 +0000
Message-Id: <20260612102643.613251F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inconsistent masking of `event_idx` between validation and execu=
tion allows userspace to induce an aborted hardware programming state or by=
pass MPAM filters.
--

commit 13a14a3d137a1e1e8ddf65c82eb4ff187ff64ca5
Author: Geetha sowjanya <gakula@marvell.com>

perf: marvell: Add CN20K LLC-TAD PMU support

This commit adds support for the LLC Tag-and-Data (TAD) PMU on Marvell
CN20K SoCs. It introduces a new PMU profile, extended event maps, and
specific register base offsets.

> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_=
cn10k_tad_pmu.c
> index af706b890bf17..e43598a52859e 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
[ ... ]
> @@ -85,8 +89,15 @@ static void tad_pmu_start_counter(struct tad_pmu *pmu,
>  	if (use_mpam && event_idx > 0x19 && event_idx < 0x21) {
>  		partid_filter =3D TAD_PRF_MATCH_PARTID | TAD_PRF_PARTID_NS |
>  				((u64)partid << 11);
> +
> +		if (pdata->id =3D=3D TAD_PMU_V3)
> +			partid_filter =3D TAD_PRF_MATCH_PARTID | TAD_PRF_MATCH_MPAMNS |
> +				((u64)partid << 10);
>  	}
> =20
> +	/* CN10K support events 0:24*/
> +	if (pdata->id =3D=3D TAD_PMU_V1 && event_idx >=3D 0x25)
> +		return;

[Severity: Medium]
In tad_pmu_event_init(), the event configuration is validated using a masked
value:

tad_pmu_event_init() {
    ...
    u32 event_idx =3D (u32)(event->attr.config & GENMASK(7, 0));
    ...
}

However, in tad_pmu_start_counter(), event_idx is assigned directly from the
unmasked event->attr.config.

If a user provides an event configuration with upper bits set (e.g., 0x124),
it will pass the masked initialization checks, but won't it fail the unmask=
ed
bounds checks here?

For V1 hardware, an unmasked config like 0x124 would evaluate as >=3D 0x25 =
and
trigger this new early return after clearing the counter but before
programming it, leaving the hardware in an aborted state.

Similarly, for V3 hardware, wouldn't the unmasked event_idx fail the
MPAM filter condition (event_idx > 0x19 && event_idx < 0x21) earlier in this
function, causing the counter to incorrectly bypass the filter and record a=
ll
partition IDs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612095746.1967=
9-1-gakula@marvell.com?part=3D2
