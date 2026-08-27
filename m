Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BA2E736F
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814147; cv=none; b=KSRSLquIeIFwgf5hCH/GCJUah73E0tIJ6xIL8wq515f81jSvgEiNZioqsItQ1nhB/b4sfoez4LM2s4sEZZ3D0oT4Qnb4Q1Rg4AzcLBWAXkinPSBPi3ZcegFfoq4Lj0Pggt697V8pymG3vISXTC0QXeMKJW5RSWj1DCJYfo54nQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814147; c=relaxed/simple;
	bh=aswgl8As09shpT6EMgEBi+yraA+M3r7JUiXGjVxwhk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GYj2f08zzz5qGbb3mOJYEbECPQDW8IjQjbHQ7qK0O9+ro6LTcAp7Ly8FxeZlFSPApy/QuZxObxgZRY3GA8ZbLobWs7N2+BrjA6Kn3w0Doh9bKg0n/e9kd4kGM9nVyS6NipQ8WPACJlGQl49PEHbayqzfyuMPV90D4tWPMjTCrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUVFa03S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUVFa03S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBB41F000E9;
	Thu, 27 Aug 2026 07:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787814146;
	bh=Sao1ZFzS4JMlWrPCSEroBAzTZmR1AqYDVYiPOdEgIVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUVFa03Sr7JAyYXYE2SuKES5WbMbJCkJjeE+A9qTxHRUjBTlLz76qambGU1l6RHI6
	 TFRX/7QETJ5EaC4gIG3mty1cZMOVRc3y2p+Jsgd4vb4hWUDvo0WqtOJagZrS/mWp13
	 YXlfp2DojaIWsb1g41+Y+BL3bXP2GeZiD2XCiRvsMLFTvZWYSVD7clZ9pBAq3jQPcW
	 MdYuqqBMvldNJWJKm9xKZLNJ6VWYaWNI7xiRCrfWo040vVRl96Ywt7SV/8tBqPzvMq
	 RHELraM3AQC9ohIB0HNNYWfCa/KvSunZiRtUG4XHXQazmND3wQSNuzY58A48IbNhJX
	 SpbFRBD5L63Jw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] perf/x86/intel: downgrade alloc_bts_buffer() WARN()
 to pr_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergey Senozhatsky" <senozhatsky@chromium.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260827065529.3835720-1-senozhatsky@chromium.org>
References: <20260827065529.3835720-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 07:02:25 +0000
Message-Id: <20260827070225.EBBB41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Replacing `WARN_ONCE(1, ...)` with `pr_err_once(1, ...)` without re=
moving the condition argument causes a build failure.
--

commit e234f9d8f1cd00344467d9d8095e6f5f291f3900
Author: Sergey Senozhatsky <senozhatsky@chromium.org>

perf/x86/intel: downgrade alloc_bts_buffer() WARN() to pr_err()

This commit downgrades the BTS buffer allocation failure warning from
WARN_ONCE to pr_err_once to prevent triggering fleet monitoring alarms
under memory pressure.

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 91a093d8cf2e7..02ec21ebb7af2 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -918,7 +918,7 @@ static int alloc_bts_buffer(int cpu)
> =20
>  	buffer =3D dsalloc_pages(BTS_BUFFER_SIZE, GFP_KERNEL | __GFP_NOWARN, cp=
u);
>  	if (unlikely(!buffer)) {
> -		WARN_ONCE(1, "%s: BTS buffer allocation failure\n", __func__);
> +		pr_err_once(1, "%s: BTS buffer allocation failure\n", __func__);

[Severity: Low]
Does this cause a build failure? Unlike WARN_ONCE which takes a condition
as its first argument, pr_err_once expects the format string as its first
argument. Leaving the integer 1 here will attempt to concatenate the KERN_E=
RR
macro string literal with an integer during expansion, which usually results
in a compile-time syntax error.

>  		return -ENOMEM;
>  	}
>  	hwev->ds_bts_vaddr =3D buffer;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827065529.3835=
720-1-senozhatsky@chromium.org?part=3D1
