Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116342B2D7
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562497; cv=none; b=cnNAFn1zNv7iLG/MzSAquhrthB+uxKvBR3zO5Y7Bl6p9XpQMsJ32SG6OuDpZUgM3nKTuF0K5ogqoHMoFFMXyUwQH0bQMbQz3nHwNX3dfcb3S26DTQqGo4CQb5FCVRaTlPag4Yjwc25CYyKbA+HHC0ha2rHY2ZYMNbhng4paRAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562497; c=relaxed/simple;
	bh=dIPhWYkL6H4BK76KpX1Z91z6IRGDutIPuqKNMAhDYFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dRs9JY+3TXVyeOxfpwmPInhpkXHjz0AfY3twugI3wOnuWGZPad6DhyFx8wcWNtcjcbyTSSCOoPkN8w1Lly0kq99bW9GQ6+8lUurnQ813ILQ6O0jYwk8p/W0K90i/QHVuvJR2gEPmTUB/26FqR9iMgrpLtvPWVZcBhFt+QKGnaZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAvj+ymj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAvj+ymj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6A41F000E9;
	Mon, 24 Aug 2026 09:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787562495;
	bh=eBBV9gjjVIxf8EJy1CDxdRH1Du/8sheXXLOw7GJj6Dw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BAvj+ymj4lPsU7nn4PNYa4Vk/N/33U95Osyf5OoC+8ABlcrxxzKkQ+KUuQ3C3ug1K
	 BcTj6f8LtrSYGZkIiP87jU2KgKswpv4QR2Eh35siSDVJIrLbtLGquGaJDc3mVQ26Z+
	 TPTTCHHMJyKL9yjtrJf4k/OSSxO7bJ2u1Iswf8vO2txrmn5KBPY3Mzwf+QUix3bKDM
	 xFyeXjAug3YionhVI14hmqgowOZVbSCwVDjVoizqGZtA1WQT5rgS3t8fEjp0xJwvOP
	 Jh0rfisGxb0nBqxctxxUN9C4sXZUF8/bTmc+Sx7S1mUsPnsbMYvXxeXWO1iT9/ubGi
	 Kitqijw1fy41Q==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 23/23] perf/x86/intel: Add sanity check for
 PEBS record/fragment size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-24-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-24-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:08:15 +0000
Message-Id: <20260824090815.AD6A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] setup_arch_pebs_sample_data() parses PEBS fragment payloads based =
on the presence of bit flags without verifying that the implied payload siz=
e fits within header->size or the buffer boundary.
--

--- Patch [23]: [RESEND Patch v10 23/23] perf/x86/intel: Add sanity check f=
or PEBS record/fragment size ---
commit 573a2a9becb54c34e2eef68662afc34b55c514f9
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Add sanity check for PEBS record/fragment size

This patch adds sanity checks for corrupted PEBS records or fragment
sizes to prevent potential infinite loops. If a corrupted fragment is
detected, the entire PEBS record and all subsequent records are dropped.

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 39028de75e4f6..4448144387158 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2657,6 +2657,9 @@ static void setup_arch_pebs_sample_data(struct perf=
_event *event,
> =20
>  again:
>  	header =3D at;
> +	if (!header->size)
> +		return;
> +
>  	next_record =3D at + sizeof(struct arch_pebs_header);
>  	if (header->basic) {

[Severity: High]
This is a pre-existing issue, but since this patch explicitly aims to safely
handle corrupted PEBS records, could a corrupted record have a small
header->size but multiple structural flags set?

In setup_arch_pebs_sample_data(), next_record is advanced based on the
presence of bit flags without checking against header->size or the buffer
boundary:

    if (header->gpr) {
        gprs =3D next_record;
        next_record =3D gprs + 1;
        __setup_pebs_gpr_group(event, regs, ...);

Would this lead to out-of-bounds memory reads if the hardware generates a
corrupted record where the implied payload exceeds header->size? While
intel_pmu_drain_arch_pebs() checks that header->size fits in the buffer,
it doesn't seem to verify if the payload itself fits within header->size.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D23
