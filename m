Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663135F609
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364447; cv=none; b=WukTCI+94C8Kz/AzlcFhQ7R4jZ8cDT7R2XTeyauurTmQChSC8cq/UjzULMhWXiTmst3Acz1F4eNwZpTCAD+mQ4WWnYhHCFpGioA+sQsdbmWUSojg3kQY+ZfQrAoBXVCZo7l65/YxMZMN1cPo0gRaQ/gRybcWnoEfJButuzbBWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364447; c=relaxed/simple;
	bh=sjbWaxLhE59YiQPEVf6MDgBTAlRWbgFwdzARpxNVcEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kfbu11+sovPaa9r7LTecxYHlTh0nZnHawuWr5js/dQperVo8qwlCbKWjiX/KV0f+tQQOs70NdJOLubmCG08UjfAMcst1sOQ1g5EnbRzGiqw0d0bfR3WqkeUxywoF2AZSKre/Q1m9pLhmyFux3inyUuaCVsZ0ViznVxePJGbmN2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0PjvK34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0PjvK34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBFC1F000FF;
	Fri, 25 Sep 2026 19:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364441;
	bh=nGNFSeWwhr/ItXsivPyrySxAfmsrHxz0Qq9Z/np3Srw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0PjvK34zkVzQdrAqh0UHlGp3quX7HWlhoEorskd03aH6njRuCEUW4BWjKKeLOUPF
	 JWXIL1WlT2Fjav9XJGhRCTWiw9KWe0vwYckI0RGN1VhxoThvwARp+SPjHjxduKx5VG
	 r+t5L4s+wHshzAQ+9/lDPIkHVmkdmi2JA3It5pBBqMJesVXOIj2fhhZXM2VnktTdTZ
	 2gnmzIUx/8bs8/YNlThj0rPJ/dMnY9sFEqQWqlk2Rh3/1G1gO7ikuGg0nWLSU1m/ov
	 0DsWj2ihDVzIQ6GExm/fsHnjQS5EgVye/O/bj7kn1zlGyW0zZW92jzr319/+OOrC0M
	 QozuUPGHO/qNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] perf script: Add --lazy-load-symbols for lazy
 symbol loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925-perf-symbol-memory-send-v3-5-3e4e234c363b@uber.com>
References: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com>
 <20260925-perf-symbol-memory-send-v3-5-3e4e234c363b@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:27:20 +0000
Message-Id: <20260925192721.5BBFC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: heap buffer overflow in dso__build_ondemand_index via concur=
rent ELF modification
--

commit d40c3742b741bb2166cbf2426b72bf61c6192a01
Author: Alireza Haghdoost <haghdoost@uber.com>

perf script: Add --lazy-load-symbols for lazy symbol loading

This commit adds the --lazy-load-symbols option to perf script to lazily lo=
ad
eligible symbols from userspace ELF DSOs. It builds a compact sorted index =
per
DSO, resolving sampled addresses via binary search and reading symbol names=
 on
demand to reduce memory and time overhead.

> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
[ ... ]
> +static int dso__build_ondemand_index(struct dso *dso, struct symsrc *sym=
s_ss,
> +				     struct symsrc *runtime_ss,
> +				     int dynsym)
> +{
[ ... ]
> +	for (i =3D 0; i < nr_entries; i++) {
> +		if (!gelf_getsym(syms, i, &sym))
> +			continue;
> +		if (ondemand_sym_ok(elf, secstrs, &sym, shdr.sh_link,
> +				    ehdr.e_machine))
> +			count++;
> +	}
> +
> +	if (!count)
> +		return 0;
> +	if (check_mul_overflow((size_t)count, sizeof(*od->sorted),
> +			       &index_bytes))
> +		return -EOVERFLOW;
[ ... ]
> +	od->sorted =3D zalloc(index_bytes);
> +	if (!od->sorted) {
> +		symbol__unaccount_bytes(index_bytes);
> +		free(od);
> +		return -1;
> +	}
> +	od->nr_alloc =3D count;
> +	name_offsets =3D malloc(count * sizeof(*name_offsets));
> +	if (!name_offsets) {
> +		symbol__unaccount_bytes(index_bytes);
> +		free(od->sorted);
> +		free(od);
> +		return -1;
> +	}
> +
> +	j =3D 0;
> +	for (i =3D 0; i < nr_entries; i++) {
> +		u64 adjusted;
> +		GElf_Phdr phdr;
> +
> +		if (!gelf_getsym(syms, i, &sym))
> +			continue;
> +		if (!ondemand_sym_ok(elf, secstrs, &sym, shdr.sh_link,
> +				     ehdr.e_machine))
> +			continue;
[ ... ]
> +		od->sorted[j].start =3D adjusted;
> +		od->sorted[j].end =3D sym.st_size;
> +		name_offsets[j] =3D sym.st_name;
> +		od->sorted[j].name_off =3D j;
> +		od->sorted[j].binding =3D GELF_ST_BIND(sym.st_info);
> +		od->sorted[j].type =3D GELF_ST_TYPE(sym.st_info);
> +		j++;
> +	}

[Severity: High]
Does this code have a bounds checking issue if the ELF file is modified
concurrently?

The algorithm in dso__build_ondemand_index() performs a two-pass scan on the
ELF file mapped into memory by libelf. The first pass computes the count of
valid symbols and allocates the od->sorted and name_offsets arrays based on
that exact count.

If the underlying ELF file (e.g. symbol table or string table) is modified
while this process is running, the memory-mapped data can change between the
two passes. This could cause the second pass to encounter more valid symbols
than originally counted, resulting in j exceeding count (or od->nr_alloc)
without any bounds checking.

Could this result in a heap buffer overflow when writing to od->sorted[j] a=
nd
name_offsets[j] if an administrator analyzes a dynamically modified,
user-writable ELF binary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-perf-symbo=
l-memory-send-v3-0-3e4e234c363b@uber.com?part=3D5
