Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F1372EDD;
	Tue, 16 Jun 2026 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594581; cv=none; b=cbtp6JdkGOHyYaY1WMfLg7qXa1qchZRC5o9Aw1KNM34oEsh6tbp7pGF0qcYyqqfggu6zGFOhvSSKi36mvku0sA+fjdUeIvIGlNqn1VscMVNFSm1GlkJN+KASebxGfyShPsi+se3tdbKGgs3X4andM6OKqMj9q2FSEr/GRa3RpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594581; c=relaxed/simple;
	bh=9eVdqzc0z7mxiveO9nqoavn+r3UtbNVEDgMxAX0/3qY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UiSeirwmQXo1UYIZCV2v1pnBHwg4sqyePBBtbzyq5a4MHt4jV4MMmJr0AT4o7qcMsXg55UEfQXbIjbkxBtWMbOKnlEUH05ho05KHAVzsFknH+PeNnt1mqA78+MT43825f0tEZavBoBuhoeNfZvYGKkGCyMAqEN7PgaCqlrBzhh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPFVpbpF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPFVpbpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2381F000E9;
	Tue, 16 Jun 2026 07:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781594580;
	bh=re16amGrlda+ctS1l2OJOpLcDPtBWFSeOgyAmqmuq2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EPFVpbpFpCt0sTUsg+VXHMbiv1CoC/yaQ6URxUE+Lx35AV4vEkrXEWJ6636c6gsLr
	 dFd75vI7bCF8nvoKwXpa1HyBu/GvTNJoPJMRhGqlyXToA1iV9pleXHPl1DPlGZan3U
	 1+43u2a1TIqRh47Bk85BeDqsnb2kwaypELHIOl3iBW2VmgmoqnVgF6Us83xBQrTAqs
	 t1Ayj0RhlmLfHzlbha0CXnIC3Ac6xskQKD7CAPKC1T6lqJdGEl4l4o1iKJ8TvVUXFz
	 SbnUvvbJj0mpmA/tIqUjKZstxV//SyOg76VQDzF6njM3RGrvsxt+Kp//qQ6225a4yU
	 JTuLrU0qC0n6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] perf: marvell: Add CN20K LLC-TAD PMU support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geetha sowjanya" <gakula@marvell.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260616071149.12523-3-gakula@marvell.com>
References: <20260616071149.12523-3-gakula@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 07:22:59 +0000
Message-Id: <20260616072300.0D2381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch series reverses the registration order of the PMU and =
CPU hotplug, creating a race window where the PMU is exposed to userspace b=
efore hotplug migration is wired up.
--

commit 71b7ba2b271b1080739c44e37ec7465ecb45ee0e
Author: Geetha sowjanya <gakula@marvell.com>

perf: marvell: Add CN20K LLC-TAD PMU support

Add support for the LLC Tag-and-Data (TAD) PMU present in
Marvell CN20K SoCs.

> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_=
cn10k_tad_pmu.c
> index 69a6648fa6648..cd81bf8ff5690 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c

[ ... ]

> @@ -478,7 +521,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  		.read		=3D tad_pmu_event_counter_read,
>  	};
> =20
> -	if (version =3D=3D TAD_PMU_V1) {
> +	if (version =3D=3D TAD_PMU_V1 || version =3D=3D TAD_PMU_V3) {
>  		tad_pmu->pmu.attr_groups =3D tad_pmu_attr_groups;
>  		tad_pmu->ops		 =3D &tad_pmu_ops;
>  	} else {

[Severity: Medium]
Looking at the remainder of tad_pmu_probe(), the registration order is:

	ret =3D perf_pmu_register(&tad_pmu->pmu, "tad", -1);
	if (ret) {
		dev_err(&pdev->dev, "Error %d registering perf PMU\n", ret);
		return ret;
	}

	ret =3D cpuhp_state_add_instance_nocalls(tad_pmu_cpuhp_state,
					       &tad_pmu->node);

Does this sequence create a race window where the PMU is exposed to
userspace before hotplug migration is wired up?

If userspace immediately creates events assigned to tad_pmu->cpu, and that
CPU goes offline before the hotplug state instance is added, the hotplug
callback wouldn't be invoked to migrate the context. This could leave the
PMU tied to an offline CPU, preventing its events from being scheduled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616071149.1252=
3-1-gakula@marvell.com?part=3D2
