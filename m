Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCF46AA6F
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937716; cv=none; b=d2iGvgYgTQssP/AdF/bU0jEeQ3iyxqrLjWkYt0tPq0ttkMil5j/bPNE/jddpxlkArPsRxjw72izgqunCGUae9y1LjbPcxCodmylcQ+N93zPXhq1U5hCKwdXLCEBkDa7Vr0gjtN/ACrPRCx8uScmWxSFpZDJk1lA0VHnquldpJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937716; c=relaxed/simple;
	bh=auK3y4PK1GwSkxNMZBxR9kiq6delt9Z58ic1TFnVbOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gHb4ZozUa1+DHoQbz0Sadl/rMb4qvtaB1Ldvec7kiq3nF2fLMF7z7JVgmsai3EOLigkXIuyvktld6aPFKn9pLyIZXQbtGRaboNNC9tUYoyk7vUeBs52qFnOrnpibAbFa9gMdhQSnhXx0yAcZV63g1ZnI44vho8VfVGHWy4Tw+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChsaGBKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChsaGBKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722471F000FF;
	Fri,  2 Oct 2026 10:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937714;
	bh=kNP9Ngfp5HmoyCu5unhVp+2IpvdnokODUQPRXXw1MNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ChsaGBKLDA0b/IVBbXiTPuFFKU4s9TIABjVULvQjoqWq5g6Ab6tFqxBPczmqrwWzP
	 CgDl1Q0TGb/1/U+eSxfElsyDuUFHEOpEW5s3QXWpJcLxpGTvmt9d41UsSZV8n1Emvb
	 nlabhPisZHn1M43NI/4cavf4P7bg5o+ozQeq1Ga6xBTUCIC9o2BX2nSOv/JbKXcp0i
	 uaPt42TwFk+oosDnPDeIxMT32xG1UnpH+TG89dNc9pv99yrTx4fW9rblE6YUhaEe8W
	 Zo2EQafC08n/cojqp7CiQzNFg3mLMIglNGqE65Ntq8ZOL6Ls3nmdf3hJ2P9ZXOxqOH
	 LhM6tq3hYA0aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA
 Erratum E#030001
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomohiro Misono" <misono.tomohiro@fujitsu.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-monaka-fix-for-upstream-v1-2-4aec0b0cbe34@fujitsu.com>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-2-4aec0b0cbe34@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:41:54 +0000
Message-Id: <20261002104154.722471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: arm64: Nested virtualization bypasses FUJITSU-MONAKA E#030001=
 erratum workaround
--

commit a8becb6b6a9a519a1569cd1fb836fdfcaee436c2
Author: Tomohiro Misono <misono.tomohiro@fujitsu.com>

arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA Erratum E#030001

This commit adds a workaround for FUJITSU-MONAKA erratum E#030001 where
range-based TLBI operations may fail to invalidate 512MB mappings. It
issues additional non-range TLBI instructions for the affected VA or IPA
ranges.

> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/t=
lbflush.h
> index 14a78ac0f8009..0487daec16528 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
[ ... ]
> @@ -518,6 +549,8 @@ static __always_inline void __flush_tlb_range_op(tlbi=
_op lop, tlbi_op rop,
>  		__tlbi_level_asid(lop, addr, level, asid);
>  		addr +=3D stride;
>  	}
> +
> +	fujitsu_erratum_wa(lop, start, end, asid);
>  }

[Severity: High]
Does KVM's nested virtualization bypass this erratum workaround?

Looking at arch/arm64/kvm/hyp/vhe/tlb.c, __kvm_tlbi_s1e2() directly invokes
native range-based TLBI instructions on behalf of a nested guest:

arch/arm64/kvm/hyp/vhe/tlb.c:__kvm_tlbi_s1e2() {
	...
	case OP_TLBI_RVAE2:
	case OP_TLBI_RVAE2IS:
	case OP_TLBI_RVAE2OS:
	case OP_TLBI_RVAE1:
	case OP_TLBI_RVAE1IS:
	case OP_TLBI_RVAE1OS:
	...
		__tlbi(rvae1is, va);
		break;
	...
}

Because the nested guest hypervisor traps into this KVM emulation which
executes raw instructions without decoding the range or applying
fujitsu_erratum_wa(), it appears the workaround is skipped here. Could this
leave stale TLB entries in the guest hypervisor's translation regime if an
untrusted nested guest targets an affected 512MB mapping?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-monaka-fix=
-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com?part=3D2
