Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A40266576
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Sep 2026 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616230; cv=none; b=CTXXMKw9zBPc6pLqkfFF08iDuijwN/sUgFdi52bUCQxqebXWyVYW3/ByMkIqPQ/z0w+5nV4jIHQTIJDx4wTpvov4iN8jkFOFSxGx1+8DGEFj09WLaQSaWyY9EqPxRA8luKkt+NVK48WTWYmC2356BHVKP3JjMyFNIFbR3vBTVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616230; c=relaxed/simple;
	bh=5D1IpXz4hzkM1cI0fKhQ2J+YZIIFrd4SC2fn/FZ48aU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k+BF3684rbfpojU9Cr4N8AwOnz1NAujKOE7RhYoVLuDGyJw1ENmJWvkdvJOS1Nie1M9nuuMyy9D0n+wMoVCQtZccwROKkkXaqjxI+EUoBIywLYerSVtIpMPKY520T+6wiiZ7zqk6x+nFdCS6TOJ6QgTdF5Z/tc/5sFuxFkt3y7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnTqrBNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnTqrBNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D951F00A3D;
	Sat,  5 Sep 2026 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788616227;
	bh=qylxOXq+/7UUfrmD3zQHO/LC/MyN8FNcXjfxin0YHEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hnTqrBNICAcyZkunG5Xvub5aM1MJkOrVOUZ0Rgd7mxNGaI1NmBYUmmyJeaHee/ej2
	 14rd7COT9CeGB/L7dyoWMH/ISbiX2hNc7ujlSePFL2Nh35ikHrHwVXNiBPPhF7cUGq
	 K4PBshhTjZCioWxegdZhXwkdT4vWINCMlGcNnDvk5toF62zwhsREB3PohPuXPMSyM+
	 ANxhY7F0RLKRaCK7+PUG6wjuNs+Ixa3lVgEx8oCxgWY1ohCIhmK0QQ0hTWyYRO60XH
	 6NLa3M76nPd9XgeEqc7jXIY0fKZeTqAsZSz3btUDcfYELB9e9iPBc7tbIcERs21NGi
	 6BUH3L2HJUSKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/marvell: cn10k_tad: Publish the OF module alias
Reply-To: sashiko-reviews@lists.linux.dev
To: hpp.iscas <hppiscas@163.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260905134317.67317-1-hppiscas@163.com>
References: <20260905134317.67317-1-hppiscas@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 13:50:27 +0000
Message-Id: <20260905135027.91D951F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying the device's shared memory resource start address in-pla=
ce during probe corrupts it for future probe attempts, leading to a NULL po=
inter dereference.
--

commit bd6b6a4110e1310bd038c78cce7c34d20371595d
Author: hpp.iscas <hppiscas@163.com>

perf/marvell: cn10k_tad: Publish the OF module alias
   =20
The TAD PMU platform driver has ACPI and OF match tables, but only
the ACPI table is published. A Device Tree platform device emits an
OF modalias, so the ACPI alias does not select this module for it.
Publish the OF table inside CONFIG_OF and retain ACPI support.

> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_=
cn10k_tad_pmu.c
> index 54909d0031b77..301be4d92b1bb 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> @@ -424,6 +424,7 @@ static const struct of_device_id tad_pmu_of_match[] =
=3D {
>  	{ .compatible =3D "marvell,cn10k-tad-pmu", .data =3D &tad_pmu_data },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, tad_pmu_of_match);
>  #endif

[Severity: High]
This isn't a bug introduced by this patch, but modifying the device's
shared memory resource start address in-place during probe corrupts it for
future probe attempts:

drivers/perf/marvell_cn10k_tad_pmu.c:tad_pmu_probe() {
	...
	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res) {
		dev_err(&pdev->dev, "Mem resource not found\n");
		return -ENODEV;
	}
	...
	/* ioremap the distributed TAD pmu regions */
	for (i =3D 0; i < tad_cnt && res->start < res->end; i++) {
		regions[i].base =3D devm_ioremap(&pdev->dev,
					       res->start,
					       tad_pmu_page_size);
		if (!regions[i].base) {
			dev_err(&pdev->dev, "TAD%d ioremap fail\n", i);
			return -ENOMEM;
		}
		res->start +=3D tad_page_size;
	}
	...
}

Because platform_get_resource() returns a pointer to the global platform
device resource, advancing res->start permanently alters it.

If the driver is unbound and rebound, the subsequent probe receives the
corrupted resource where res->start is already advanced past res->end. The
loop will not execute, leaving all regions[i].base pointers as NULL.

Any subsequent perf event execution will then call readq() on a NULL pointer
in tad_pmu_event_counter_read(), resulting in a kernel panic.=20

Could we avoid modifying the global resource in-place and use a local
variable for the address calculation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905134317.6731=
7-1-hppiscas@163.com?part=3D1
