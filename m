Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7352FE3C
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873492; cv=none; b=DBbJ4x9BE3cqRFGAELDyadPNZ+bXt5DJ+ebd59u7tp+R9mcf8NvLzLaM3KMX4dBU6ezz8DVpKfybVqTbAt+gJwd1wi//WnjhYHYCrOkqIkb0C3HURct+FXyKojOW5wjnfqo9tG3SAD2NQNqPgZqq5kmgQTj3aoChXVGsBOa6LmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873492; c=relaxed/simple;
	bh=fXd1zuuS4PlrxOm2+g+hmVGRmFIvaCor9utqxSKcsfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JeSyaCIdjLFK5DRVsH4ql2DqltjPgqI+JUr7ehElFFRWJtekKmVnO6XbhK3S8EDZGKNZnKusQBck247fT1JpsxA3yp4qHc3r6KL7122079YyT7Qb1ZKlEscZ7ceEejYTLhhU5KzVWk12Sf6rCLSbDPZICQ2iBNw/Ne8poRFP3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwVNaxmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwVNaxmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F941F00A3A;
	Tue,  8 Sep 2026 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873484;
	bh=581NMlZ+5/4maBx8jFLWrw7TeQBNO9tvnIDAEDK8nK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RwVNaxmQECmiSbF1FCOeJxyvXGrXlYX6kbncAN13RA0CNcjeZBQY7HNy4PT4X1qmq
	 JW9YcGgdXaYMgJaj2FpVTgVRVBkB64e8HFlHFrkOYubdqQEtigNvXx7OXwZxC+XZUA
	 M1Cd67mgeAY0Mx8lud72cqvPPGsB/TFZDBeg8O36SnVc+Ml1rAyo07zJiJoM1h9Bl8
	 JvBUVxrkFQDJK6YE4D6MQEvXWWoDk+yzEhUCL/CFwgBk9FKIKDeBiMyfcKumZH9oEs
	 1VJlNNbYiWgDofCEWpasq8Ag9jMhJ4MxnEgnWgj5Nf1V/yfUxCn5vEaqLoLAIPqfcb
	 8KCWZex+gxvJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/26] perf capstone: Symbolize address operands to
 match objdump on arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <eb2510f336aace385e4b4ffa99281d61c89c1ad2.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <eb2510f336aace385e4b4ffa99281d61c89c1ad2.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:18:03 +0000
Message-Id: <20260908131804.76F941F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Premature `map__put()` of `found_map` before the caller consumes=
 `sym_name` creates a Use-After-Free vulnerability.
--

commit ff403b9f1717375044e9b6fbb3f09210431e386b
Author: Tengda Wu <wutengda@huaweicloud.com>
perf capstone: Symbolize address operands to match objdump on arm64

This commit extends Capstone disassembly support on arm64 to resolve target
addresses to symbols. It detects instructions with address operands, maps
them to symbols, and formats the output to match objdump's style.

> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 74213daf87862..7f82c33e3464a 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
[ ... ]
> @@ -292,16 +303,44 @@ ssize_t capstone__fprintf_insn_asm(struct machine *=
machine, struct thread *threa
>  	return printed;
>  }
> =20
> +static int resolve_symbol_from_addr(struct map *map, u64 addr,
> +				    const char **sym_name, u64 *sym_offset)
> +{
> +	struct map *found_map =3D NULL;
> +	struct symbol *sym;
> +	u64 al_addr;
> +	u64 ip =3D map__objdump_2mem(map, addr);
> +
> +	if (dso__kernel(map__dso(map))) {
> +		/*
> +		 * The kernel maps can be split into sections, let's
> +		 * find the map first and then search the symbol.
> +		 */
> +		found_map =3D maps__find(map__kmaps(map), ip);
> +		if (found_map =3D=3D NULL)
> +			return -1;
> +		map =3D found_map;
> +	}
> +
> +	/* convert it to map-relative address for search */
> +	al_addr =3D map__map_ip(map, ip);
> +
> +	sym =3D map__find_symbol(map, al_addr);
> +	map__put(found_map);
> +
> +	if (sym =3D=3D NULL)
> +		return -1;
> +
> +	*sym_name =3D sym->name;
> +	*sym_offset =3D al_addr - sym->start;
> +	return 0;
> +}

[Severity: Medium]
Is map__put(found_map) called prematurely here? If the map is concurrently
removed and the refcount drops to zero, the map and its symbols could be
freed. Does this leave sym->name pointing to freed memory when it is assign=
ed
to *sym_name and returned to the caller?

> +
>  static void print_capstone_detail(struct cs_insn *insn, char *buf, size_=
t len,
>  				  struct annotate_args *args, u64 addr)
>  {
[ ... ]
> @@ -320,40 +360,114 @@ static void print_capstone_detail(struct cs_insn *=
insn, char *buf, size_t len,
> =20
>  		/* get the target address */
>  		orig_addr =3D addr + insn->size + op->mem.disp;
> -		addr =3D map__objdump_2mem(map, orig_addr);
> -
> -		if (dso__kernel(map__dso(map))) {
> -			/*
> -			 * The kernel maps can be split into sections, let's
> -			 * find the map first and then search the symbol.
> -			 */
> -			found_map =3D maps__find(map__kmaps(map), addr);
> -			if (found_map =3D=3D NULL)
> -				continue;
> -			map =3D found_map;
> -		}
> -
> -		/* convert it to map-relative address for search */
> -		addr =3D map__map_ip(map, addr);
> -
> -		sym =3D map__find_symbol(map, addr);
> -		if (sym =3D=3D NULL) {
> -			map__put(found_map);
> +		if (resolve_symbol_from_addr(map, orig_addr, &sym_name, &sym_offset))
>  			continue;
> -		}
> =20
> -		if (addr =3D=3D sym->start) {
> +		if (sym_offset =3D=3D 0) {
>  			scnprintf(buf, len, "\t# %"PRIx64" <%s>",
> -				  orig_addr, sym->name);
> +				  orig_addr, sym_name);

[Severity: Medium]
Can this result in a Use-After-Free? If resolve_symbol_from_addr() drops the
map reference too early, sym_name might point to freed memory by the time it
is dereferenced here in scnprintf().

>  		} else {
>  			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
> -				  orig_addr, sym->name, addr - sym->start);
> +				  orig_addr, sym_name, sym_offset);
>  		}
[ ... ]
> +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
> +				       size_t len, struct annotate_args *args)
> +{
> +	struct map *map =3D args->ms->map;
> +	char *last_imm, *endptr;
> +	u64 addr;
> +
> +	print_default_format(insn, buf, len);
> +	/*
> +	 * Adjust instructions to keep the existing behavior with objdump.
> +	 *
> +	 * Example conversion:
> +	 * From: b #0xffff8000800114c8
> +	 * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
> +	 */
> +	if (needs_symbolic_address(insn)) {
> +		const char *sym_name =3D NULL;
> +		u64 sym_offset;
> +
> +		/* Extract last immediate value as address */
> +		last_imm =3D strrchr(buf, '#');
> +		if (!last_imm)
> +			return;
> +
> +		addr =3D strtoull(last_imm + 1, &endptr, 16);
> +		if (endptr =3D=3D last_imm + 1)
> +			return;
> +
> +		if (resolve_symbol_from_addr(map, addr, &sym_name, &sym_offset))
> +			return;
> +
> +		/* Symbolize the resolved address */
> +		len =3D len - (last_imm - buf);
> +		if (sym_offset =3D=3D 0) {
> +			scnprintf(last_imm, len, "%"PRIx64" <%s>",
> +				  addr, sym_name);

[Severity: Medium]
Does this also dereference the potentially dangling sym_name pointer if the
underlying map was freed in resolve_symbol_from_addr()?

> +		} else {
> +			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
> +				  addr, sym_name, sym_offset);
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D1
