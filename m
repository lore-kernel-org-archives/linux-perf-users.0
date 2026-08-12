Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7B30BF4F
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786495241; cv=none; b=JweWNaMCSaIRuWSZT+E5GHJgR9f7XuLyVlHT3iROpv9QqA+wjtprCeI40o6amqZaPpwUlcQ96etZ9v9GQT0gSecmBUcgwrZCQb/AL7Am3vF1K2BN21j53q2oI+JTp5v7uFxmMINeqd+Pu2fxq3YQ9jecFUwLLYyYeAeJnX51hEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786495241; c=relaxed/simple;
	bh=HsVmwYGY/ZjlfXsAjew/OwfVhQ+NFg5VpkjoUpkv4AQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PAuLlFHhQ3/6DOnmrleKHyRreB3efsQQNfbkfarw9tUqYTvFkFpCmEoKbVg/cZdncq2POIl3+0udrenQcBGigXN3yVXZvCnJ+qwJK2pyin8rPczCX02WTF3CTJsrJrrEgfl+HgJY7FHgmgGAhy/4LplYuHIAJLBjnluEn/XGd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOKn1A1W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOKn1A1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30B01F000E9;
	Wed, 12 Aug 2026 00:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786495240;
	bh=tyk252hptLpCcs/4ogu8JQ8UqneVcXCLXtAayjZpDrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YOKn1A1WtKz+bbV8sV5aOthwof9gMTeQhSLKPeDrG+a3/0wSgPvlxnSz9X9T8cQ1X
	 1JiSz2+vx7bldHpRJS6/0RfCqqnnp00tlt1aMOZiWWMCNWD8Nr5dIiW2kacfWnykcH
	 N1IMRLR9zumxIexA6QcRaCbrjUGHGs5vYCwCPf8fPaRUkD2b8im2E3/23qsmQ8++Cz
	 Yt9IcxiABTBcW116nonNfWQzSZ27Karip3M1RFzY5tr9rrJMwjfn5xtMOwq6nYSb9l
	 pXY6g3a2zkkOYeui5o5kTCY6cYazeLxMXnjGyaLqAo5I6VNfZnpK/VErKiBiWxXh67
	 lAFw+mpfkkoIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260812002728.2283079-3-irogers@google.com>
References: <20260811235112.2267241-1-irogers@google.com>
 <20260812002728.2283079-1-irogers@google.com>
 <20260812002728.2283079-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 00:40:39 +0000
Message-Id: <20260812004039.F30B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Implicit and fragile pointer cast from `struct pmu *` to `struct rp=
i_axi_pmu *` instead of using `container_of`.
--

--- Patch [2]: [PATCH v3 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU su=
pport ---
commit 313acedcd7c09e03b7e84ac26f169991353b78d9
Author: Ian Rogers <irogers@google.com>
Subject: perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

This commit expands the Raspberry Pi AXI PMU driver to support the Broadcom
BCM2712 SoC used in the Raspberry Pi 5. It adds new event definitions,
bus enumerations, and filter aliases specifically for the new architecture.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> index 1923dc34cb3e9..478d58c7e4f41 100644
> --- a/drivers/perf/rpi_axi_pmu.c
> +++ b/drivers/perf/rpi_axi_pmu.c
[ ... ]
> @@ -867,12 +1043,106 @@ static struct attribute *rpi_axi_pmu_events_attrs=
[] =3D {
[ ... ]
> +static umode_t rpi_axi_pmu_events_is_visible(struct kobject *kobj,
> +					      struct attribute *attr, int unused)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct rpi_axi_pmu *pmu =3D dev_get_drvdata(dev);

[Severity: Low]
Since the perf core sets the device's driver data to a struct pmu pointer v=
ia
pmu_dev_alloc(), doesn't dev_get_drvdata(dev) return a struct pmu * here?

While this implicit cast works right now because the pmu member is located =
at
offset 0 in struct rpi_axi_pmu, would it be safer to use the existing
pmu_to_rpi_axi_pmu() helper to avoid potential type confusion and memory
corruption if the struct layout ever changes in the future?

> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr.attr);
> +
> +	if (pmu->chip =3D=3D CHIP_BCM2712) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812002728.2283=
079-1-irogers@google.com?part=3D2
