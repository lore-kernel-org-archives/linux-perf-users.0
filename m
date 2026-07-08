Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1732F37998A
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 23:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555115; cv=none; b=n6kGBYRss7R2Ll6QiO2WafFAK7OoCQObteYu+xWzFupwVjQovbYgLzhk8GCVoziHpmOME3rrzd2BvXdtByKbOIbLb/RgtA5zAIBm6+gp2CLSbvCmS8oqLI2KqdlSgW1yZNGVUkfEMw8vREcuTSuGG10l0+XZkL6QVnnSmAoOUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555115; c=relaxed/simple;
	bh=mg6JIQ4uAKLxJJrtdUmDBOvuSgT/w5bKEnf+EQZBGw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ategO6mcywHHyZc7rTBsMJV0K+Txzh/SXJCRxoMSNRKZvoofHbGfdN3mbhYB7mqjhTgGIV4Q62IijyPy2JcwXU60wQC+TJxLa0TnWECcgt2ezI6hpR0WwYcsUKVU4pukCchFS2QX7Eqj5fWGqqWhr63WhSka8sxcIN4YN0pQROo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU+l1OYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU+l1OYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855D01F000E9;
	Wed,  8 Jul 2026 23:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783555113;
	bh=YSkqvE4Fq2QTPBvKmM5wYPM7OvpEu+OZbcnS7drsbzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RU+l1OYO31Te5NmaMK6OYShzpqzzT8rESQRmaT70OMBGn0gQbWkpYT74oL8fPt8oR
	 dR4I7IOVYbkHn42S07GJuFQyVHcUvFcEKZc1Oh29rDuYWiMsyQNAHhY4TIQigNXTtm
	 c/rRGVHJG4xPqm6PouoQupsvssy4S+1ZuT8/WnVeVF/UTHwCJj+v2vWVV6oOrlc6c+
	 B8ukyi/LOrr+rHU/tZszfTt8TichV/Cl89WdN8A1UAnbliSm/t/Oia/XSAh5UB9V8/
	 PDTiVaPaHaMAqaH1gebXhipt4MPsda8rmjqzmH867Wza6c0xKxsGEhOMkRQHQOTqia
	 8LIwc3xf1rQMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] perf annotate: Be robust to annotating without a
 thread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260708234646.1040003-3-irogers@google.com>
References: <20260708234646.1040003-1-irogers@google.com>
 <20260708234646.1040003-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 23:58:33 +0000
Message-Id: <20260708235833.855D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Architecture-specific disassembly parsers for LoongArch and s390=
 dereference `ms->thread` without checking for NULL, causing segmentation f=
aults when annotating without a thread.
--

--- Patch [3]: [PATCH v1 3/3] perf annotate: Be robust to annotating withou=
t a thread ---
commit 64d4504d663ab9115662531cbaf640b34642de60
Author: Ian Rogers <irogers@google.com>

perf annotate: Be robust to annotating without a thread

If a thread isn't given to thread__get_arch try harder to determine
the arch for disassembly. Do this by passing an entire map_symbol and
using fallback paths such as reading the e_machine from a map's dso. At the
same time ensure some other uses of map_symbol thread don't assume it is
non-NULL to avoid segvs.

[ ... ]

> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 0a1a7e9cf3efe..8cd90a0a0f8ae 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -271,7 +271,7 @@ static int call__parse(const struct arch *arch, struc=
t ins_operands *ops, struct
>  		.addr =3D map__objdump_2mem(map, ops->target.addr),
>  	};
> =20
> -	if (maps__find_ams(thread__maps(ms->thread), &target) =3D=3D 0 &&
> +	if (ms->thread && maps__find_ams(thread__maps(ms->thread), &target) =3D=
=3D 0 &&

[Severity: Medium]
Since ms->thread is now allowed to be NULL, do the architecture-specific
parsers need similar updates?

For example, looking at loongarch_call__parse() in
tools/perf/util/annotate-arch/annotate-loongarch.c:

	if (maps__find_ams(thread__maps(ms->thread), &target) =3D=3D 0 &&
	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.add=
r)) =3D=3D ops->target.addr)

It appears to unconditionally call thread__maps(ms->thread). The same
pattern is also present in loongarch_jump__parse() and s390_call__parse().

Could this regression cause a segmentation fault when running perf annotate
without a thread on LoongArch or s390 binaries?

>  	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.=
addr)) =3D=3D ops->target.addr)
>  		ops->target.sym =3D target.ms.sym;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708234646.1040=
003-1-irogers@google.com?part=3D3
