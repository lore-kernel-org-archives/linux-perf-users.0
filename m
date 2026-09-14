Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D828506C
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350902; cv=none; b=lP7yRoT7Cebwt7qYExALfJ3HELUMoQByZ4PlABzGs2/zgOttGPq/K7aBQsgJAyUveUzm3MEneE27S4kxOljqO02M3lS3Qlw5VnX3YEeCqEH9s6739Z3DxP2w/rScBC5wVZV98thV0tkTELhgCBugmI9pTjDR6Kr9VkHn2PGqmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350902; c=relaxed/simple;
	bh=dAPu0GLhdkdHr79HcayGlqLD0ww3D0VtiZp6nacDEvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R5FlvRHz+QTuUHTZLkJeqFny73yKIxWoC4IR8gDwrSU//GbBhvTDFR+ko7gMFD9rVPHf2sdw13ROkn9jXIS/IX8J0Julsq5bMk17jpB5ALvcn3bXppzCTMMfTaEyXH+QcNQWCNfB0gvtuXY/dIsnSarnl3XLZRfOPqoraxzr+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onMyLlsJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onMyLlsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F4E1F000FF;
	Mon, 14 Sep 2026 01:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350901;
	bh=dsuUHhLEii6l4KigjKaxdPyGm4yBQ1kF6VyAo6ZYuEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onMyLlsJkEmbCecRErXrIfIwmmiyCbhK8UqdBibIjFEq7cj3cPAKhtSdl5rTJEEal
	 MuZpnz9eMdoDNQ0dvNSsVn9hCr2ZKxpyVdC1EYs8dczqGajMDOsDH0VgaYpLkqperJ
	 rcmNhVxNurq8q0/c9Yql+oRGRYz3gj4qs5zBBvwg6bYGNEYXqST07xRaahl6r+prRW
	 iu1a/ZrFTbcmBh2A2Bc9Gqv3gPu+bGgZezlBEWfDE0PmYgjOQLgJ3j5yZrk513kIMG
	 yHjQ2qg/PnhraNPbfd2Pa7ER6D0ehSf47gHpSF4/UzulmemjmhGhMp9n8+EvqZJWLs
	 we+2x8QAZLvZA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v11 03/10] tools headers: Sync x86 headers with kernel
 sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914014049.2061519-4-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:55:00 +0000
Message-Id: <20260914015501.53F4E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch adds new `ARCH_PEBS_VECR_xxx` macros exclusively to th=
e tools header without a corresponding update to the core kernel header, br=
eaking header synchronization and indicating a missing prerequisite kernel =
patch.
--

commit 545cb1e6346c71f64b6106d48dfa9367ed61de8d
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

tools headers: Sync x86 headers with kernel sources

This commit adds ARCH_PEBS_VECR_xxx macros into the tools version of the
x86 msr-index.h header. The commit message indicates this is a sync from
the kernel sources.

> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/incl=
ude/asm/msr-index.h
> index 18c4be75e9271..9c26d4075c5f4 100644
> --- a/tools/arch/x86/include/asm/msr-index.h
> +++ b/tools/arch/x86/include/asm/msr-index.h
> @@ -350,6 +350,13 @@
>  #define ARCH_PEBS_LBR_SHIFT		40
>  #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
>  #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
> +#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)

[Severity: Medium]
The commit message mentions syncing newly introduced ARCH_PEBS_VECR_xxx mac=
ros
from the kernel, but is there a missing prerequisite patch?

These macros do not appear to exist in the core kernel's
arch/x86/include/asm/msr-index.h at this commit.

Will adding them exclusively to the tools header without a corresponding
kernel update break header synchronization and trigger warnings from
tools/perf/check-headers.sh when running make -C tools/perf?

> +#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
> +#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
> +#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
> +#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
> +#define ARCH_PEBS_VECR_EXT_SHIFT	49
> +#define ARCH_PEBS_VECR_EXT		(0x7full << ARCH_PEBS_VECR_EXT_SHIFT)
>  #define ARCH_PEBS_GPR			BIT_ULL(61)
>  #define ARCH_PEBS_AUX			BIT_ULL(62)
>  #define ARCH_PEBS_EN			BIT_ULL(63)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914014049.2061=
519-1-dapeng1.mi@linux.intel.com?part=3D3
