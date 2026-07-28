Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADFB37F00C
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257858; cv=none; b=p/F9B7VP/lVIsgGOEEYw/OTd6T9cjXPAQpK0GkXvtO+I653U+2FB1aKIi918VOHGN+fVo6ASgIYZG4P0kM/EK4mG/qBbuRSL/m00pu9ONcn1aOljkos5/hWvENr8jC7qfK2OK8jXSiVQ5YCMI3SGmotl879aamnuuzVGKHcSmqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257858; c=relaxed/simple;
	bh=+TAcyfa1Psu6qn4X0XB2GFI5ueb3tYwTfqzmhvxa3Iw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r5Qsm3Osq05o2tFcoAqEDWUuIt5F3RXAudjRDvvuQPdQ33PjTpHbIj6ar+ee/tgP7atYD52cg7xD4Ci0UT5al/uFJ2y78JHHNJo/BjvvFnFfpCst3BbnmyK4hiIt0F2tM3U9U/51C8yADorvfvUCNi6B8e6RmPKdovoT7L8CYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcWaZ/5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcWaZ/5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5DA1F000E9;
	Tue, 28 Jul 2026 16:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785257857;
	bh=bOBHUCgCJpN+b3UTMRHkaZFoQhZ25OumoFbMxdZdqbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BcWaZ/5//i/UK5SBdcUfIcGsC9+5Hz1KCown1C6dkBqJrSE0emYP0fg6w+yXl6Zok
	 IFL6yyD/0ovyVboncisBgAxOI9kvoj0ILTeDBgvUSb+KF6SN/pNyyAEQSmQD7jGcaP
	 Qalmpr8NMYkHOWVbgmnxXvpyis9EFau6YmH3+EYRxICf/VC/oX+mA8pAFi00arm2Fi
	 SrxgLERnGHmqgRGzSvy06mQ/aJdLlB97xvbNtVLVKWRp77TZH9NKuDDnjlygz2/NuJ
	 Skr3H5xwQyLenFmJwqxSlF3xlmF9zlHh0AnZcaST59dbhTXGb+DS6nsMTizSXuDZZs
	 geHNMbOv9iIJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] perf/arm-cmn: Support CMN S3 r2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <86b7093bc5de0f2aedc63fc4826ce911cb22d16f.1785252273.git.robin.murphy@arm.com>
References: <cover.1785252273.git.robin.murphy@arm.com>
 <86b7093bc5de0f2aedc63fc4826ce911cb22d16f.1785252273.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:57:36 +0000
Message-Id: <20260728165737.0B5DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The virtual channel count fields (rsp_vc_num, dat_vc_num, snp_vc=
_num, req_vc_num) in struct arm_cmn are defined as 2-bit bitfields. The pat=
ch adds support for CMN-S3 R2, which uses 3-bit values for these counts in =
the hardware registers. When extracting these 3-bit values and assigning th=
em to the 2-bit bitfields, values of 4 or higher are silently truncated. Co=
nsequently, in arm_cmn_event_attr_is_visible(), the truncated value incorre=
ctly evaluates as < 2 (e.g., 4 truncates to 0), falsely hiding valid PMU pe=
rformance events from userspace.

Pre-existing issues:
- [High] In arm_cmn_discover(), the 16-bit field cmn->num_dns accumulates t=
he number of child nodes across all XP nodes using MMIO values (CMN_CI_CHIL=
D_COUNT). Since CMN_CI_CHILD_COUNT is a 16-bit field, accumulating multiple=
 of these can overflow the 16-bit num_dns field. This wrapped value is used=
 to calculate the size of the kernel heap allocation for the dn array (devm=
_kcalloc). During the second pass, the driver re-reads the un-wrapped hardw=
are child counts and linearly writes to the dn array inside the loop, sever=
ely overflowing the undersized heap allocation.
--

--- Patch [5]: [PATCH v2 5/5] perf/arm-cmn: Support CMN S3 r2 ---
commit b19f5d8af33d67287a2dac3c0584d98dc6d08406
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm-cmn: Support CMN S3 r2

This commit adds support for CMN S3 r2. It splits the internal model
abstraction, adds new filters, changes existing events, and provides
a means of working around the isolation feature.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 9d5833f8cff2b..b162de3d9d169 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c

[ ... ]

> @@ -2431,21 +2538,33 @@ static int arm_cmn_discover(struct arm_cmn *cmn, =
unsigned int rgn_offset)

[ ... ]

>  	reg =3D readq_relaxed(cfg_region + CMN_CFGM_INFO_GLOBAL_1);
> -	cmn->snp_vc_num =3D FIELD_GET(CMN_INFO_SNP_VC_NUM, reg);
> -	cmn->req_vc_num =3D FIELD_GET(CMN_INFO_REQ_VC_NUM, reg);
> +	if (model < CMNS3R2) {
> +		cmn->snp_vc_num =3D FIELD_GET(CMN_INFO_SNP_VC_NUM, reg);
> +		cmn->req_vc_num =3D FIELD_GET(CMN_INFO_REQ_VC_NUM, reg);
> +	} else {
> +		cmn->rsp_vc_num =3D FIELD_GET(CMN_S3_R2_RSP_VC_NUM, reg);
> +		cmn->dat_vc_num =3D FIELD_GET(CMN_S3_R2_DAT_VC_NUM, reg);
> +		cmn->snp_vc_num =3D FIELD_GET(CMN_S3_R2_SNP_VC_NUM, reg);
> +		cmn->req_vc_num =3D FIELD_GET(CMN_S3_R2_REQ_VC_NUM, reg);
> +	}

[Severity: Medium]
Does assigning the 3-bit CMN_S3_R2_RSP_VC_NUM value into the 2-bit
rsp_vc_num bitfield in struct arm_cmn cause silent truncation?

Looking at struct arm_cmn, the virtual channel fields are defined as 2 bits:

struct arm_cmn {
    ...
    unsigned int rsp_vc_num : 2;
    unsigned int dat_vc_num : 2;
    unsigned int snp_vc_num : 2;
    unsigned int req_vc_num : 2;
    ...
};

If a hardware value of 4 or 5 is truncated to 0 or 1 here, could it
incorrectly evaluate as < 2 in arm_cmn_event_attr_is_visible() and falsely
hide valid PMU events from userspace?

[ ... ]

>  	reg =3D readq_relaxed(cfg_region + CMN_CHILD_INFO);
>  	child_count =3D FIELD_GET(CMN_CI_CHILD_COUNT, reg);
>=20
> 	cmn->num_xps =3D child_count;
> 	cmn->num_dns =3D cmn->num_xps;
>=20
> 	/* Pass 1: visit the XPs, enumerate their children */
> 	cfg_region +=3D child_poff;
> 	for (i =3D 0; i < cmn->num_xps; i++) {
> 		reg =3D readq_relaxed(cfg_region + i * 8);
> 		xp_region =3D cmn->base + (reg & CMN_CHILD_NODE_ADDR);
>=20
> 		reg =3D readq_relaxed(xp_region + CMN_CHILD_INFO);
> 		cmn->num_dns +=3D FIELD_GET(CMN_CI_CHILD_COUNT, reg);
> 	}

[Severity: High]
This is a pre-existing issue, but can accumulating 16-bit hardware counts
here overflow the 16-bit cmn->num_dns field?

If multiple XP nodes return large values for CMN_CI_CHILD_COUNT, could
cmn->num_dns wrap around, resulting in an undersized devm_kcalloc()
allocation for the dn array?

Later in the second pass, the un-wrapped counts control the loop bounds,
which seems like it could lead to linear out-of-bounds writes into the
undersized array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785252273.gi=
t.robin.murphy@arm.com?part=3D5
