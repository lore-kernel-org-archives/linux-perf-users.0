Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B803B6BFD
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424272; cv=none; b=Z2LlQ8Yj3APuyLCqg4IamFvwbDotsa6n93PlNQhHvV9zVBmDjQ260yRMAuZREC0kkaIsuQmj9yZQyI774e9rgGjr78BGd4YGY0AXI6offD37WV0z1hqTKclHLEpk0Urjqn2dUdXPne5RNJlXT8jAYsFc/x4Bs2BUmjydfkbMlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424272; c=relaxed/simple;
	bh=bhu1et840yOw5JQwjOWgc7v6YJ0AN1uqQ1Roe4DOw9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GpG0B9k4m+tj890LvvOv/DWCEcE2poq8IlYlox9sXZDD81jSDrN9gUvH6rAeN+tpzgcPWbdWjbVONwnJC/767BZsBt3G9FdO89gqupIplSQ4Z30mbaB0vfHNgE/4gzX593m9nIusgdiOBOyT5qxBMh5IF0BzzY8FPtiIUEmvoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfeXjdaz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfeXjdaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C416F1F000E9;
	Thu,  3 Sep 2026 08:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788424270;
	bh=QiFOI3JsYSUJmqexnLnxyvcnUqCYvfQ5U6/0ZltlGkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DfeXjdazfPgpvAz7R/q2Jzle70tFTKhdSDoVpulAoIDZ6wlKlZH9a/lK6SW1VD2nR
	 ePRquMgr1WBA7vBg+Ovr0msDBsJjUIXfE38ZfBtWy5RgZyfpCxli3ssswlvx5PGVvg
	 35Hez4i3Zl1/RuYttayHaT3+KhFPIqnMiH/GDH1oS/RP2D8WqB3c0QaIGgkgfZgMat
	 m8Ot9MpiqG+/kInHk+6ZWF9kEgtX1rhOIWdMaLBHAV75k2y9s+x5sytEwKyLqufqb5
	 BVC1urmDheEMxvF09HqICA8mjmFdnX0gxrsDZyQXPxcSc8oou5TsQYUn0WgIh8z0wU
	 4DgLbRnpOUChQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf intel-pt: Fix undefined shift in intel_pt_bip()
Reply-To: sashiko-reviews@lists.linux.dev
To: liujing <liujing@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903082128.4972-2-liujing@cmss.chinamobile.com>
References: <20260903082128.4972-1-liujing@cmss.chinamobile.com>
 <20260903082128.4972-2-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:31:10 +0000
Message-Id: <20260903083110.C416F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a build failure by placing a variable declarat=
ion after a statement block, which violates the C90 compilation rules enfor=
ced in the perf tools build system.
--

commit 8a68d39b58963034d86457f673e830e359365de8
Author: Liu Jing <liujing@cmss.chinamobile.com>

perf intel-pt: Fix undefined shift in intel_pt_bip()

This commit aims to fix an undefined shift behavior in intel_pt_bip() by
moving the bounds check before the shift and using an unsigned shift operat=
ion.

> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/=
perf/util/intel-pt-decoder/intel-pt-decoder.c
> index e733f6b1f7ac5..9abadd0d1c108 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> @@ -2060,7 +2060,6 @@ static void intel_pt_bbp(struct intel_pt_decoder *d=
ecoder)
>  static void intel_pt_bip(struct intel_pt_decoder *decoder)
>  {
>  	uint32_t id =3D decoder->packet.count;
> -	uint32_t bit =3D 1 << id;
>  	int pos =3D decoder->blk_type_pos;
> =20
>  	if (pos < 0 || id >=3D INTEL_PT_BLK_ITEM_ID_CNT) {
> @@ -2068,6 +2067,7 @@ static void intel_pt_bip(struct intel_pt_decoder *d=
ecoder)
>  			     id, decoder->blk_type);
>  		return;
>  	}
> +	uint32_t bit =3D 1U << id;

[Severity: Low]
Will this cause a build failure? It looks like the declaration of the bit
variable is now placed after an if statement block within intel_pt_bip().

The perf tools build system enables -Wdeclaration-after-statement and promo=
tes
it to an error. Could this be fixed by separating the declaration and
initialization, like declaring uint32_t bit; at the top of the function and
then assigning it after the bounds check?

> =20
>  	if (decoder->state.items.mask[pos] & bit) {
>  		intel_pt_log("WARNING: Duplicate block item %u type %d\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903082128.4972=
-2-liujing@cmss.chinamobile.com?part=3D1
