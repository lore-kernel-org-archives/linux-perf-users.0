Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622740;
	b=R/kMDLvl1ZBUALZ506xEVjRf67bIFuW6S5eNLJn+UMr542pHC9V4c005paYnjX3sntn2
	 KZVZlZ54Pxts/ncSctTA9ihFbqsS5uOnlM3devpo7jkCKvuX4J2Yo8zI4yg4c1rHFKE7L
	 HY3Z103L5sxCYaRzSgHfequkPjlJBrL5JyfvtT+kICQEOA+TlWhYqvurQBYVKImFLEuld
	 4HvM5KimAWIRltY+htO71lXz7Emq4PTERdVlPe/XWxAXtIMXfAkHkLDSs/owagMvc6JwG
	 1iUvTzC/9yYiJWGwdtGJ0qfo+NXOSF+5/xqrrUC4Bu3iBXLagwprxgqHc/BXevslMXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622740;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=42RgXStPPHirb7hTKxBQJ60hv6wsmXnpsqOsVhH6rtw=;
	b=Cs15o9/yAwEArC/+hRInGP4Mdb+SOE7s6WZIfpQhzfE61NaPB78uCXztRbXDA1746rzR
	 JmNVy+gyD8dPRwWz0VpNRvN5X034W4+BkziTTWQZCbeL/d3+5Gk/a1TKJ8lUnR6i0gWkS
	 FfjsplpEAJikjfU+P65cLwkGGlqpS267ULQilqF+NipfJ6EHtEz2y8xZH6BElvZB0JOEP
	 DXg0H+Zaz7cUJAX94+zTwF6Bz5QnZVL4/PYTb5Tl1WPll/Am80RDxSS38I7o//qV028Xc
	 XGEm4AZpov6XYXaEAA3dAqXkQAnIsmd7uAehQ4Zu41sj1S+8m8yXPsDVfuCG6sLBXrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+MZFPiU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C736606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+MZFPiU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF6B1F000C1;
	Wed, 21 Oct 2026 22:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622739;
	bh=42RgXStPPHirb7hTKxBQJ60hv6wsmXnpsqOsVhH6rtw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H+MZFPiUxfDbhHEs7hF1Ri4gIYz0cjso288dkfuh4bU5CX7/GM5+UG0tnJZSXz83w
	 qGN1bq7ERufalNBSZYYi09FISv1FD/R08u6XJIXEox6W68/rUKW4LqyuipItX4/aih
	 xPE3HqjnLU6Bk7hddPdRjR68kWuXF2C7Vu02S4IUfJvgpK64csbCXuvtvQXV38LTuz
	 N9pqqZnh7ML/DA6si3Es4w396HgB64VHbuO62QGYa23020mPd9rMi/5F1asrtOe3e3
	 UIeCMxzoT+EbcSNUp1+Dhk92HHXkwTL+nMHNmNsGp4Mln1eulnr9tL5wA2JmPq9zzd
	 ETrBfXZHIWmfw==
Message-ID: <sashiko-outbox-180734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/12] tools arch x86: Sync the msr-index.h copy with
 the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-7-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:45:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tools arch x86: msr-index.h sync reverts ARCH_PEBS_VECR_* macros
--

commit 78affd0f60ae68f3b52a636d7f03411361f2bbe0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

tools arch x86: Sync the msr-index.h copy with the kernel sources

This commit synchronizes tools/arch/x86/include/asm/msr-index.h with the
kernel header to pick up thermal interrupt bit definitions from commit
ac5cc691eb4a ("x86/thermal: Add bit definitions for Intel Directed Package
Thermal Interrupt").

> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/incl=
ude/asm/msr-index.h
> index 9c26d4075c5f4..3a8e51a0c9e88 100644
> --- a/tools/arch/x86/include/asm/msr-index.h
> +++ b/tools/arch/x86/include/asm/msr-index.h
> @@ -350,13 +350,6 @@
>  #define ARCH_PEBS_LBR_SHIFT		40
>  #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
>  #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
> -#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)
> -#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
> -#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
> -#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
> -#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
> -#define ARCH_PEBS_VECR_EXT_SHIFT	49
> -#define ARCH_PEBS_VECR_EXT		(0x7full << ARCH_PEBS_VECR_EXT_SHIFT)
>  #define ARCH_PEBS_GPR			BIT_ULL(61)
>  #define ARCH_PEBS_AUX			BIT_ULL(62)
>  #define ARCH_PEBS_EN			BIT_ULL(63)

[Severity: Medium]
Does syncing tools/arch/x86/include/asm/msr-index.h by overwriting it with
arch/x86/include/asm/msr-index.h unintentionally revert commit 7846bf499da3=
fe
("tools headers: Sync x86 headers with kernel sources")?

Commit 7846bf499da3fe added ARCH_PEBS_VECR_YMMH, ARCH_PEBS_VECR_EGPRS,
ARCH_PEBS_VECR_OPMASK, ARCH_PEBS_VECR_ZMMH, ARCH_PEBS_VECR_H16ZMM,
ARCH_PEBS_VECR_EXT_SHIFT, and ARCH_PEBS_VECR_EXT to
tools/arch/x86/include/asm/msr-index.h alongside commit eb89aef367e470 befo=
re
those kernel changes landed in arch/x86/include/asm/msr-index.h in this tre=
e.

In tools/perf/scripts/sync-headers.sh, kernel_matches_previous_tools_state()
checks whether the kernel header's current blob exists in the history of the
tools header:

tools/perf/scripts/sync-headers.sh:kernel_matches_previous_tools_state() {
	local kernel_path=3D"$1"
	local tools_path=3D"$2"
	local kernel_blob

	kernel_blob=3D$(git hash-object "$kernel_path" 2>/dev/null) || return 1
	[[ -n "$(git log --format=3D%h -1 --find-object=3D"$kernel_blob" -- "$tool=
s_path" 2>/dev/null)" ]]
}

Because arch/x86/include/asm/msr-index.h and
tools/arch/x86/include/asm/msr-index.h both diverged with independent commi=
ts
(ac5cc691eb4a and 7846bf499da3fe) since their last common sync point
(369e91bd201d15), kernel_matches_previous_tools_state() returns false and
process_header() overwrites the tools copy with the kernel copy.

While the commit message states this only picks up commit ac5cc691eb4a
("x86/thermal: Add bit definitions for Intel Directed Package Thermal
Interrupt"), should the ARCH_PEBS_VECR_* definitions from commit
7846bf499da3fe be preserved here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D6
