Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E219351C22
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306466; cv=none; b=s40wbYUb69CmVJ+4Jj/YkzCm5X2keZcK3zOP+ApoNfIn7le1lAKuk7Ft6PfM1mAnoZgNEQ+v5t37ouVY7Gk6Zh2ezSpIsKrDK5psUr3vGYazpF50p7ENM0uvxhrSNV7uNrLemBIrzveykQE1DDDbkdCucfZTrS3KP5d1o7P3bOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306466; c=relaxed/simple;
	bh=SBiXkBkGgMTTpNvZKAp59qgWjT7fIT97U7+E8a5o4yk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qzieoQnE9xwd9XDQ1O9UnZUICjf7OlqRZLO4bbgpIhlYtKqXnZPrL41DKrn2AWdeYE2cEkNR7YwY+cmySwc/Z6PixL4RG/7+lf5xTFH8Q+AzT4NKjOEhE5ZyNlhgMs2zG1vrSru7sqrylLp3TjLTmc/ls/DE5TW3nFXH/wm3q38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsCn9dPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsCn9dPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60241F000E9;
	Mon,  6 Jul 2026 02:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783306464;
	bh=hqNsl8xcJfrc5hrRGEG0sngUQDzOXtoi9tyKUuJEMYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SsCn9dPBBUtc3bkOgpO0UyiCfoy30uS8vRMYDYA+ngwZgR1TcgU7Gb9JD3f3MSvTR
	 TUq5VNBIdHTRzMZfxTrNY9lsDCuoCRjdjb30pATV2mSoCcAImB6g1HryzecnAnzAIj
	 goKCO/I2uxz4eL7Foivrw4p4WuMTkybSo9X2ImbCyUO8v7Mz9zV/yrvKhxiXej9Mtc
	 a/2+CQj5pThSP3CbOn7c9QOBjUOatDQg0OZ4EFDZ07xU3UKbbH9/i7NU63fyw1ga0w
	 gQDhb/p/ZRmBu+H0rl16xm577jXlUOWvEmiaYmJ/P9608L7KBF7brvjrIzgteR2tAD
	 dxspgNrf/Oywg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 03/10] tools headers: Sync x86 headers with kernel
 sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706023444.3067660-4-dapeng1.mi@linux.intel.com>
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
 <20260706023444.3067660-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:54:23 +0000
Message-Id: <20260706025423.D60241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Modifying a tools header without a corresponding kernel header upda=
te causes a synchronization divergence and triggers build warnings.
--

commit f29e894bc895095793a45b66351922174d49d6a4
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

tools headers: Sync x86 headers with kernel sources

This commit attempts to synchronize the x86 msr-index.h header in the
tools directory with the kernel sources by adding ARCH_PEBS_VECR_xxx
macros.

> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/incl=
ude/asm/msr-index.h
> index eff29645719bc..8cbc4c4997065 100644
> --- a/tools/arch/x86/include/asm/msr-index.h
> +++ b/tools/arch/x86/include/asm/msr-index.h
> @@ -350,6 +350,13 @@
>  #define ARCH_PEBS_LBR_SHIFT		40
>  #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
>  #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
> +#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)

[Severity: Low]
Will this trigger a Kernel ABI header differences warning during the perf b=
uild?

If the corresponding kernel-side macros are not already present in the
arch/x86/include/asm/msr-index.h header of the tree this patch is applied
against, check-headers.sh will flag a synchronization divergence.=20

Are these macros being merged in a separate patch series that needs to be
applied first, or did the kernel counterpart miss getting included in this
series?

> +#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
> +#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706023444.3067=
660-1-dapeng1.mi@linux.intel.com?part=3D3
