Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044DD42A79F
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619589; cv=none; b=P3JoAMUa/Sr4TCAM0eop3lrdwVPKIkDoLLmN3AYzzN3w4X7SlIXWrhsfo6IJc5v1IxJBM3qxmpfRM5GFk0++GvKaE/GIAejWxsSgPl2REPECC+oZKHuKXHWHSPLbYK9rNSIbHUGafxTs8sLw7fDi6l+ZwqJergBl/xhs3DfTFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619589; c=relaxed/simple;
	bh=FFf0/KHpcBWBfz3SvV3Ku6AnA8nax1KXpSXm7s4/IHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HiceZGBjqt4k/ky41BFga1iYgQK0dBKPuVI4mJg1qGEgR20qO28bBGwkMDLQgCI3zGT6Hmoczs/4lnXoPCH9bmb1LRKi48lOaypioQnsPFKjToN4t8lhmq7QXCH+z23JcGYNUobCzbnKXnVIFGHO04SKfBb7R+CaLa5+jrO4Ktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVQdcZR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVQdcZR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713061F000E9;
	Tue, 21 Jul 2026 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784619587;
	bh=dcVGtBTGFtaYN7RydCzKVdwRu+zP0MuPEAkCP1FsBAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fVQdcZR4+TpF1QulAcnd11M2I5Tu78Pst5pVwZ9+V/THY7L3Cx5wEClbOElIL1CUS
	 nU8R/ZTn0ZurFlbnCuFhu9iviuYYbfyOAAG8UNKV2TnWaaMDWaxmvxpgOfR0cd0cNL
	 cflMfMhvEFgiQyxYePTiXpnq4FqALndrQN6BJORHSCwPX9LIBlNxgTXawchsQIzGtB
	 SuuvtU7D0ptwhZGR8b39dnH+QUCg7qKWTzCPKiltTXX12C8bY2s37yD0ezmoagVlsN
	 oT/VJU1swaXslxeCmx4Ad7s5jZLx05PgOZUg8jDZ4OqPSfbKP4/AT2JJ9ITKZSdVHW
	 qRCzC2GjqS/WQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v10 03/10] tools headers: Sync x86 headers with kernel
 sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721072707.3787848-4-dapeng1.mi@linux.intel.com>
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:39:46 +0000
Message-Id: <20260721073947.713061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Header synchronization mismatch: tools/arch/x86/include/asm/msr-=
index.h introduces macros not present in the core kernel header.
--

--- Patch [3]: [Patch v10 03/10] tools headers: Sync x86 headers with kerne=
l sources ---
commit a80378c4387abdba00fb87b0094f51fec90aa452
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

tools headers: Sync x86 headers with kernel sources

This commit adds ARCH_PEBS_VECR_xxx macros to the tools version of the x86
msr-index.h header to sync with the main kernel sources.

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
> +#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
> +#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
> +#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
> +#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
> +#define ARCH_PEBS_VECR_EXT_SHIFT	49
> +#define ARCH_PEBS_VECR_EXT		(0x7full << ARCH_PEBS_VECR_EXT_SHIFT)

[Severity: Medium]
The commit message states "Sync newly introduced ARCH_PEBS_VECR_xxx macros
from kernel". Are these macros actually present in the main kernel tree?

Looking at the core kernel version of arch/x86/include/asm/msr-index.h, the=
se
definitions do not appear to exist.

If they are missing from the main kernel header, won't this cause a
divergence between the tools header and the core kernel header, resulting
in warnings from tools/perf/check-headers.sh during the perf build?

>  #define ARCH_PEBS_GPR			BIT_ULL(61)
>  #define ARCH_PEBS_AUX			BIT_ULL(62)
>  #define ARCH_PEBS_EN			BIT_ULL(63)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721072707.3787=
848-1-dapeng1.mi@linux.intel.com?part=3D3
