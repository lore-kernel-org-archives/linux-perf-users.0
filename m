Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910876;
	b=Vnu16xDgdvG68IphGNIE8Fm1B9qVawLpbGCscsKb0sd8/h7l9fNZXb0tudrnLeoI2w15
	 Sznim4TqmuxmOg9tQn5pqM9GGum9A07tzp69Q8uUk3MNRekUXWKFe4GYO0Nhs+nbwpQvv
	 PI0VSfF41m0qxk1q6McjePv14kjF+OSEdthJOtL0yoDpAwQokiWWaFqnoat1t0OE0Gb6o
	 DMtk+GRlu34dpaGjBnsM8S9HVK1elj6hVbb7J7Y6j7ofhUEO4n11Pvtrupo869ru3I7Yu
	 Qwl6dplE5AGDYvbu182skSMmcmZ3sePJev97XOGPDHWw7U8bqZYnnJRlsmjsTfAR1nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2LujHc1JCCJPcZRGX2ZE1aJQ7hXrbVFOuJzFDNnODyo=;
	b=CYgxNAhKO+52TzLOXqbmxbFeePHmJ4E6yU5OhdM43pQv/sOermrwuCvOWqx5dtAOALSi
	 pSyOEMLITLhMQgcuM9MoCii8NLNyPenA8aEl68SM6iA42Sp5OZ3JAfn6cuo7ir47bH+w4
	 WvOzzgXnbEyadxEA6SUOsD8DH7PNWR4zZuK2kV07yWUNF/5djLd9wM35gn4dgC0SWRyoG
	 zJOKlPYL/6F4iSdeNuRv/wF9oosu2WlaCyRv/47BL5zfOkHvypwD64DvVEDCPhEGfsNgi
	 PybAiUzUDOB9dMPmTd/GKdjbXMN+GSbeW7YNWJeKKv5AKyVvnYDqW9aUAF5ERDOPxYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YMq2BAQ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD7606A31B
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMq2BAQ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F081F01825;
	Sun, 25 Oct 2026 06:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792910875;
	bh=2LujHc1JCCJPcZRGX2ZE1aJQ7hXrbVFOuJzFDNnODyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMq2BAQ/zEZv6gXCJkfPYujZMIuIuin2TUyfTdxXAYzGGVjz5cqFR2F74p07i7J+F
	 f6WMapx2txN3DEapqQ25x2s+CV1vuyKvc92XjiYPpOz1cB88hia3MGJR+4FdGyOW2g
	 6lJJOTvOq2nx4MdyBLWUmizb2OcmMu+Elh54dlCWVa3FxOUxItaI0DJyZ2eHsaoFmw
	 GBP1Nhty2D6/G2p9e0NecU5EIoNoIKU1QwMKsBw6t9w7OF6EpwsQ9b97yb9216irlt
	 n0kv4OHNApT9fafLkp02aCH33X0MVnq/9UMoyE53Zky3ChkppxFIMe6RfQLxCmdclB
	 buxaA4JWft9Cg==
Message-ID: <sashiko-outbox-184102@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <cd3e622681f7254216b0488f09d2cb2d91a2d8ca.1792907333.git.aaupov@fb.com>
References: <20261012230527.750567-1-aaupov@fb.com>
 <cover.1792907332.git.aaupov@fb.com>
 <cd3e622681f7254216b0488f09d2cb2d91a2d8ca.1792907333.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 06:47:54 +0000
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
- [Low] perf: arm_pmuv3: circular header inclusion in pmuv3_event_implement=
ed()
--

commit fe846ad9d18510169af8401fb7c59990c15ea903
Author: Amir Ayupov <aaupov@fb.com>

perf: arm_pmuv3: Add pmuv3_event_implemented()

This commit adds pmuv3_event_implemented() to include/linux/perf/arm_pmuv3.h
to allow drivers outside the PMU driver to check whether the local CPU's PMU
implements a common event via PMCEID0/1, and moves
ARMV8_PMUV3_EXT_COMMON_EVENT_BASE into include/linux/perf/arm_pmuv3.h.

> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv=
3.h
> index d698efba28a27..965c40b28dd77 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h

[ ... ]

> @@ -315,4 +318,23 @@
> =20
>  #include <asm/arm_pmuv3.h>
> =20
> +/*
> + * Whether this CPU's PMU implements a common event, as reported by
> + * PMCEID{0,1}: events 0x0000-0x003f in bits [31:0], and from PMUv3p1 ev=
ents
> + * 0x4000-0x403f in bits [63:32], which read as zero before PMUv3p1.
> + * Must run on the CPU whose PMU is queried.
> + */
> +static inline bool pmuv3_event_implemented(u16 event)
> +{
> +	bool ext =3D event >=3D ARMV8_PMUV3_EXT_COMMON_EVENT_BASE;
> +	u16 id =3D ext ? event - ARMV8_PMUV3_EXT_COMMON_EVENT_BASE : event;
> +	u64 pmceid;
> +
> +	if (id >=3D 64 || !pmuv3_implemented(read_pmuver()))
> +		return false;
> +
> +	pmceid =3D id < 32 ? read_pmceid0() : read_pmceid1();
> +	return pmceid & BIT_ULL(id % 32 + (ext ? 32 : 0));
> +}

[Severity: Low]
Does defining pmuv3_event_implemented() here break arm64 builds due to a
circular header dependency when a translation unit includes
<asm/arm_pmuv3.h> before <asm/kvm_host.h> or <linux/perf/arm_pmuv3.h>?

For example, arch/arm64/kernel/cpufeature.c includes <asm/arm_pmuv3.h>
first:

    #include <asm/arm_pmuv3.h>
    #include <asm/cpu.h>
    #include <asm/cpufeature.h>
    #include <asm/cpu_ops.h>
    #include <asm/fpsimd.h>
    #include <asm/hwcap.h>
    #include <asm/insn.h>
    #include <asm/kvm_host.h>

In arch/arm64/include/asm/arm_pmuv3.h, the header guard __ASM_PMUV3_H is
defined and <asm/kvm_host.h> is included at the top before read_pmuver(),
read_pmceid0(), read_pmceid1(), and pmuv3_implemented() are defined:

    #ifndef __ASM_PMUV3_H
    #define __ASM_PMUV3_H

    #include <asm/kvm_host.h>

That triggers the inclusion chain:

    arch/arm64/include/asm/arm_pmuv3.h
      -> arch/arm64/include/asm/kvm_host.h
        -> include/kvm/arm_pmu.h
          -> include/linux/perf/arm_pmuv3.h

When include/linux/perf/arm_pmuv3.h reaches #include <asm/arm_pmuv3.h>, it
is skipped because __ASM_PMUV3_H is already defined, so
pmuv3_event_implemented() is compiled before pmuv3_implemented(),
read_pmuver(), read_pmceid0(), and read_pmceid1() have been declared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792907332.gi=
t.aaupov@fb.com?part=3D5
