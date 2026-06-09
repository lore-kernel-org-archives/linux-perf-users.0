Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC343CA4A8;
	Tue,  9 Jun 2026 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985871; cv=none; b=BBLvEAFi8sn6zA54AqjuOBaa5eM4VAC5e24UV/h2hkEF2jIOZbb7FO8Hgz68vRyBksBmEHq1xlhvVKjcf/YDgdlnC6y7nv/85GUetMH2sW5u/PNFd/w9LJu9A4G8K6eq1EQQdNVmPS26ydFaz4hJ4EqgbiqGOJfoFzglX12qz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985871; c=relaxed/simple;
	bh=iQylMyoSgAmSC+nChoRp6dYgUQsyvzd3I5vl6qiKfs8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k3FGb/d0zCz2tJ6pTVo71uNO55fx3iP98lhbQy0er0B+05Wb7eonBXTUd9iKvZWY6KHcoQj83plZQIq8dkn9TDnKaRwScTA6C+IpzebPeqv1EjOmikyJo0x3PszLJqhmljslzxOFh067HVV+zmwWzPGgU4iwxjdag+hpzgSx2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr+Xi7Ww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr+Xi7Ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBCE1F00893;
	Tue,  9 Jun 2026 06:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780985870;
	bh=AKMmOvRdgjwRIwYmIllBgLahMG0/LUVznvMbBxbQGXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xr+Xi7WwmU7D9LpYmtIcs2iK/FampDZ0a57jiWQUP41Xvbj7KwaxfVrgPhDotKXWO
	 QOV5HwoAbRbX2P2295gkKXcCsGf4IwlKgH9WinyU/UtAinxZOo+JJTD2Sevmva2sa3
	 mCV0wFQalbr8NxM/lM6V1lCj2I3cWnEZQ0Xcb3WOL7JgYbvyf30jF1EJQFgg0sZ+9s
	 zpdmasx29k2RCCQt2j+3hYln9WuTDdbD74iXgn/Pi44Uj1S2yc7IN/hTQhlBUe9su8
	 H3qX9g3Nj/UdSZn8qT+1BnnljXEo/tYbUl0tjMiwr4r+8GtyCivW/kGjQkGPGpn3Fv
	 rSG+76RWczsQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 20/21] TEST(do-not-upstream): fake qemu-virt PMU
 events for cdeleg counter-mask testing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260608-counter_delegation-v6-20-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-20-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:17:49 +0000
Message-Id: <20260609061750.2FBCE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch adds synthetic test events explicitly marked 'TEST(do-=
not-upstream)' to the production RISC-V SBI PMU driver, polluting the UAPI.
--

commit 286ddcbf491d3a026da1733168d9b7d29bcd2fbe
Author: Atish Patra <atishp@meta.com>

TEST(do-not-upstream): fake qemu-virt PMU events for cdeleg counter-mask te=
sting

This commit adds fake performance monitoring events to test counter delegat=
ion
and counter-mask constraints in Qemu. The events use codes that Qemu does n=
ot
model to verify allocation and programming behavior.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 74acac54328e0..3c0829c0a42ab 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> @@ -483,6 +489,9 @@ static struct attribute *qemu_virt_event_group[] =3D {
>  	RVPMU_EVENT_ATTR_PTR(dTLB_load_miss),
>  	RVPMU_EVENT_ATTR_PTR(dTLB_store_miss),
>  	RVPMU_EVENT_ATTR_PTR(iTLB_load_miss),
> +	RVPMU_EVENT_ATTR_PTR(fake_any),
> +	RVPMU_EVENT_ATTR_PTR(fake_ctr3),
> +	RVPMU_EVENT_ATTR_PTR(fake_ctr34),

[Severity: Medium]
Does this code introduce a regression by exposing test functionality?

This patch is explicitly marked "do-not-upstream" and unconditionally adds
synthetic test events to the exposed Qemu platform pmu events array in
qemu_virt_event_group[].

Exposing these fake hardware events (fake-any, fake-ctr3, fake-ctr34)
to userspace pollutes the production sysfs uapi. These will appear in
perf list and could confuse users or automated tools.

>  	NULL,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D20
