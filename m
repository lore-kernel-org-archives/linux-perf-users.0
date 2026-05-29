Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1F3BD62F
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046516; cv=none; b=uKXlmkO6MUpZUvi+ibYY6y2maUoLCA/iUj2/tuWPpBS6iy50/I3IGjxJVbUj0lpvzYj0vCgPAY2y14fbOAq4Heb/rTRXud3IsPGIQCq/EZXvoCXB+7yvjHKf0izjWeIZ2Myo5SN3VNap/mVn8RCET8ngngrI+LGjvf1zCb3bRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046516; c=relaxed/simple;
	bh=HKdfpz2/Nf3fJy49rP9TMHCQ4OUm8IAo+TZA8B/BYLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MhSybHt463B028Z0DVg9qtElgJa2eudBmmkLILnv31GMLSNvbH20VAI8qG3FZkt7ltrPSNt/csVLiNXyYtGk1UG6ftJJL4F0/JWmIz41X/pY72DyRPqb0NXSXgRAwUUff1pAWXQlutj59kySg3on8gteY/fEt2f3sT2DmNpaVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWBeq+P4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWBeq+P4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266641F00893;
	Fri, 29 May 2026 09:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780046515;
	bh=NMwD3eHc/p6cBIWJgdzZQfJxnxYb8AqqO6Yz+fHrFIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DWBeq+P4QI1ztiyYx8l+MWuSfkzucuFNVsZvGEy6coGqt/LQyVJ7EnR09gI5C3Zzm
	 2P63JFA/HxZ9NncYS58B7qmejI3RbfosZBMuXUxWx53/FYJ7bnhhkeeGuTJaR0LhJD
	 t2hqTBdwPLgd1ykVSri/RBdm2RGoSu+swNGkAPhn0PV0Tk7Wp9W7Ol7558iCaEhNYa
	 ZQyprSgkQkVyPRF2UsRfZqR2uXvVuCHtpG35RfibZqHA5NtHAtBtrlxCZX9G0+MD2x
	 9AZpSZIRaBuZLRQW0sE1KcQSRPmM1Rh9KD1T6VSgKu2dJ4IxIJzE/Hen9p2saIq9IM
	 OzGat+OblzRlA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 16/23] perf/x86: Support OPMASK sampling using
 sample_simd_pred_reg_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-17-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-17-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 09:21:54 +0000
Message-Id: <20260529092155.266641F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The UAPI header `arch/x86/include/uapi/asm/perf_regs.h` uses the `_=
_GENMASK` macro without including `<linux/bits.h>`.
--

commit 105b880ba965bb46db4e0202af5a989492cd6220
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Support OPMASK sampling using sample_simd_pred_reg_* fields

This commit adds support for sampling OPMASK registers via the
sample_simd_pred_reg_* fields. It updates x86_pmu_hw_config to check for
OPMASK capabilities and modifies perf_simd_reg_value and
perf_simd_reg_validate to handle the new registers.

> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uap=
i/asm/perf_regs.h
> index 3aacdd4e2764c..24c981ba8bae2 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h
[ ... ]
> @@ -60,14 +60,19 @@ enum {
>  	PERF_X86_SIMD_YMM_REGS      =3D 16,
>  	PERF_X86_SIMD_ZMM_REGS      =3D 32,
>  	PERF_X86_SIMD_VEC_REGS_MAX  =3D PERF_X86_SIMD_ZMM_REGS,
> +
> +	PERF_X86_SIMD_OPMASK_REGS   =3D 8,
> +	PERF_X86_SIMD_PRED_REGS_MAX =3D PERF_X86_SIMD_OPMASK_REGS,
>  };
> =20
> +#define PERF_X86_SIMD_PRED_MASK	__GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - =
1, 0)

[Severity: Low]
Does this uapi header need to include <linux/bits.h> for the __GENMASK
macro?

Without the include, userspace applications directly including
<asm/perf_regs.h> might fail to compile due to an implicitly defined macro.

>  #define PERF_X86_SIMD_VEC_MASK	__GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX =
- 1, 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D16
