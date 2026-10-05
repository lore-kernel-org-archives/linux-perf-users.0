Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAC2D8379
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208598; cv=none; b=ppzPN+0BuxDYLWcOYc7mUz7hiwFMW4oIsN5zkE8+ffzqOWn6IJsNIZy1LkeYwJrs8667HRYOk4uBlr+yjbMCuA9fTQAAkhGzdYbPToKT5dZb6bUirIn3fDOpCfumys39JDmVr6i9X+PXI6yzdYIHYEpi0m9ocbc2w5voZ7XnHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208598; c=relaxed/simple;
	bh=i/S/w0Ng3vDehmgaRkcG2IyC4iCKJF8qjNt9zF8rai8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TemGP2s1AYtqBz33xmfFLIjn9S8Srk2jRi4plEYot4fyWNT6Uqa9zsHFsQ3kzE5FUWeBISRs97mlSQy0nUMTVe7n0RIwuLxlmQH/RLRiLwOGzD9yoPgndd5wCvp9ZFJHAYA8EcWfZN48VjSoK6KVrAq9JAa8QeqqyzcAsdpcxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBFy2zfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBFy2zfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FC31F000FF;
	Mon,  5 Oct 2026 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208597;
	bh=H7A1lEcl0a4k/TZCpxrgUcXmhTmztRQ6p0FCkZ+KstI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iBFy2zfxkD8WbwStE2k3Umb24CylVXh4VrsEbmBpJaIdIWj3NAb5s3SHY2hO8bYuK
	 qPc1MLoYNivcMUgtYLs803xGh6wepfySuLeQG0Nqub8mxyHfGCxNeGcn/QTgR4UNcw
	 gLJNaRnnY+1JWN10L+jDp/uoI0cDfXZXhd1ZvmG8qE7uFtiihPdVTQUe2X/HYgerIl
	 w9b/oWqHLgf5uDKCEdqBNYMQSICQaB5blLT35cLXtVHaviATe4EEEaSXxSo/a3sxHy
	 viIaxxjFQe/S7zkKyWWdoSXIHX3BsMp0JkgzyfySxRlOBrYsXjMlgHTE/0xsuWw/KN
	 wyY5Z7tfBwduw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/arm_cspmu: Add Arm system PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <162173d376d223941b0c8b4e4a1c9ad2ae5c11a3.1791207773.git.robin.murphy@arm.com>
References: <162173d376d223941b0c8b4e4a1c9ad2ae5c11a3.1791207773.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:56:36 +0000
Message-Id: <20261005135637.44FC31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] arm_syspmu: build failure on 32-bit archs due to missing writeq fal=
lback
--

commit ee9850d17fe1852cb671454c79f2ae56292d6550
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm_cspmu: Add Arm system PMU

Arm's latest Compute Subsystems and SoCs are using a common PMU block
in various places which can mostly just be driven as a generic 64-bit
CoreSight PMU, but does have an IMP-DEF register for additional
filtering. The details of event and filter encodings depend on the
particular PMU instance, so are left to the higher level Arm Telemetry
Solution tooling.

> diff --git a/drivers/perf/arm_cspmu/arm_syspmu.c b/drivers/perf/arm_cspmu=
/arm_syspmu.c
> new file mode 100644
> index 0000000000000..ac234768a2f80
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/arm_syspmu.c
> @@ -0,0 +1,67 @@

[ ... ]

> +static void arm_syspmu_set_ev_filter(struct arm_cspmu *cspmu,
> +				     const struct perf_event *event)
> +{
> +	u32 offset =3D 8 * event->hw.idx;
> +
> +	writeq(event->attr.config1, cspmu->base0 + PMEVFILTR + offset);
> +	writeq(event->attr.config2, cspmu->base0 + PMEVFILT2R + offset);
> +	writeq(event->attr.config3, cspmu->base0 + PMEVFILT3R + offset);

[Severity: Low]
Will this driver fail to build on 32-bit architectures?

When compiling with CONFIG_COMPILE_TEST=3Dy on a 32-bit platform like i386 =
or
ARM32, writeq() is not natively defined.

Could we include <linux/io-64-nonatomic-lo-hi.h> to ensure the driver
compiles successfully by providing a writeq() fallback for 32-bit builds?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/162173d376d223941b0=
c8b4e4a1c9ad2ae5c11a3.1791207773.git.robin.murphy@arm.com?part=3D1
