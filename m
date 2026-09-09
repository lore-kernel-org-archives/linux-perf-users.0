Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0A312819;
	Wed,  9 Sep 2026 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965348; cv=none; b=bMrlBecKoQMKmdKXtPFYPPEZMxO+gqvRX51dSlICsd6Lbt/o5h0Qdxg/LUgekV52fHyeuxPGVH9yYdGy2zyIdnQmvbJ45r2erg1SN12K1mRP7z3votHpchCaAuKDmBFmoGqPQ0i409jq5bRCVJRKv/e7TdVHAtEWmLDJ7sd2yEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965348; c=relaxed/simple;
	bh=54PdNHjZmvC+ydENa3G1J+G4G1FJGs39VSzshVYd64w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ER7mJp9tLUGZg8BI+eYpAQxjTuSsTpNVq+aMroQEcfz4AHt1VNDPyEGYqvOiwrweZYphB7O3ZvZqQVTC/ij47E1lGzQe1dm4dVMZF9YmWogljGoH+9tYVRGf2+Vf0uI6/kizpzdGI0ucG6CQ8of1HnA4K13prgRvV5MYtNhjOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFu0w4bM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFu0w4bM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646F61F00A3A;
	Wed,  9 Sep 2026 14:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965346;
	bh=+NZaXpk+a7B276g1IyxQfYtoysLHIBQonmOQeX7VOK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nFu0w4bMRqRIEgNxIdOTrqA+ZjSQmkgpnAcFtV2WbjoaJyRn6nKRQyP2OprCt2nZZ
	 uYlyPrcT9CzOLcID/Ku8Wlg2eHB/vlnHkgPdKK82Rx7JOT/9FDFXbg9Y9zf+Dj1P27
	 qUG19a81Cs5d9ji95iKcIgZUHwM5BmQSwTtiqMy9zrz+E+dpqpGRAoGlvJuYPy3/+z
	 IsyGPYWIhkZ+xxYT0JTXVHVxjlCSonvzwz0ajoQanLAdqZeruj6Ly3G66Aufhl4To7
	 EYON7QdNI8il6aYDkGzWLuYpCvttTU1yz25bCYVmqJqBggmpTnuAUMf4YcXkdExWe+
	 mUcpitTaBgmgg==
Date: Wed, 9 Sep 2026 10:49:04 -0400
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 01/26] perf capstone: Symbolize address operands to
 match objdump on arm64
Message-ID: <aqFx4Fia3SWTrVZu@google.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <eb2510f336aace385e4b4ffa99281d61c89c1ad2.1788872630.git.wutengda@huaweicloud.com>
 <20260908131804.76F941F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908131804.76F941F00A3A@smtp.kernel.org>

Hello,

On Tue, Sep 08, 2026 at 01:18:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Premature `map__put()` of `found_map` before the caller consumes `sym_name` creates a Use-After-Free vulnerability.
> --
> 
> commit ff403b9f1717375044e9b6fbb3f09210431e386b
> Author: Tengda Wu <wutengda@huaweicloud.com>
> perf capstone: Symbolize address operands to match objdump on arm64
> 
> This commit extends Capstone disassembly support on arm64 to resolve target
> addresses to symbols. It detects instructions with address operands, maps
> them to symbols, and formats the output to match objdump's style.
> 
> > diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> > index 74213daf87862..7f82c33e3464a 100644
> > --- a/tools/perf/util/capstone.c
> > +++ b/tools/perf/util/capstone.c
> [ ... ]
> > @@ -292,16 +303,44 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine, struct thread *threa
> >  	return printed;
> >  }
> >  
> > +static int resolve_symbol_from_addr(struct map *map, u64 addr,
> > +				    const char **sym_name, u64 *sym_offset)
> > +{
> > +	struct map *found_map = NULL;
> > +	struct symbol *sym;
> > +	u64 al_addr;
> > +	u64 ip = map__objdump_2mem(map, addr);
> > +
> > +	if (dso__kernel(map__dso(map))) {
> > +		/*
> > +		 * The kernel maps can be split into sections, let's
> > +		 * find the map first and then search the symbol.
> > +		 */
> > +		found_map = maps__find(map__kmaps(map), ip);
> > +		if (found_map == NULL)
> > +			return -1;
> > +		map = found_map;
> > +	}
> > +
> > +	/* convert it to map-relative address for search */
> > +	al_addr = map__map_ip(map, ip);
> > +
> > +	sym = map__find_symbol(map, al_addr);
> > +	map__put(found_map);
> > +
> > +	if (sym == NULL)
> > +		return -1;
> > +
> > +	*sym_name = sym->name;
> > +	*sym_offset = al_addr - sym->start;
> > +	return 0;
> > +}
> 
> [Severity: Medium]
> Is map__put(found_map) called prematurely here? If the map is concurrently
> removed and the refcount drops to zero, the map and its symbols could be
> freed. Does this leave sym->name pointing to freed memory when it is assigned
> to *sym_name and returned to the caller?

Right, probably better to return a pointer to symbol instead and make
the found_map as an out parameter.

Thanks,
Namhyung

> 
> > +
> >  static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
> >  				  struct annotate_args *args, u64 addr)
> >  {
> [ ... ]
> > @@ -320,40 +360,114 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
> >  
> >  		/* get the target address */
> >  		orig_addr = addr + insn->size + op->mem.disp;
> > -		addr = map__objdump_2mem(map, orig_addr);
> > -
> > -		if (dso__kernel(map__dso(map))) {
> > -			/*
> > -			 * The kernel maps can be split into sections, let's
> > -			 * find the map first and then search the symbol.
> > -			 */
> > -			found_map = maps__find(map__kmaps(map), addr);
> > -			if (found_map == NULL)
> > -				continue;
> > -			map = found_map;
> > -		}
> > -
> > -		/* convert it to map-relative address for search */
> > -		addr = map__map_ip(map, addr);
> > -
> > -		sym = map__find_symbol(map, addr);
> > -		if (sym == NULL) {
> > -			map__put(found_map);
> > +		if (resolve_symbol_from_addr(map, orig_addr, &sym_name, &sym_offset))
> >  			continue;
> > -		}
> >  
> > -		if (addr == sym->start) {
> > +		if (sym_offset == 0) {
> >  			scnprintf(buf, len, "\t# %"PRIx64" <%s>",
> > -				  orig_addr, sym->name);
> > +				  orig_addr, sym_name);
> 
> [Severity: Medium]
> Can this result in a Use-After-Free? If resolve_symbol_from_addr() drops the
> map reference too early, sym_name might point to freed memory by the time it
> is dereferenced here in scnprintf().
> 
> >  		} else {
> >  			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
> > -				  orig_addr, sym->name, addr - sym->start);
> > +				  orig_addr, sym_name, sym_offset);
> >  		}
> [ ... ]
> > +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
> > +				       size_t len, struct annotate_args *args)
> > +{
> > +	struct map *map = args->ms->map;
> > +	char *last_imm, *endptr;
> > +	u64 addr;
> > +
> > +	print_default_format(insn, buf, len);
> > +	/*
> > +	 * Adjust instructions to keep the existing behavior with objdump.
> > +	 *
> > +	 * Example conversion:
> > +	 * From: b #0xffff8000800114c8
> > +	 * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
> > +	 */
> > +	if (needs_symbolic_address(insn)) {
> > +		const char *sym_name = NULL;
> > +		u64 sym_offset;
> > +
> > +		/* Extract last immediate value as address */
> > +		last_imm = strrchr(buf, '#');
> > +		if (!last_imm)
> > +			return;
> > +
> > +		addr = strtoull(last_imm + 1, &endptr, 16);
> > +		if (endptr == last_imm + 1)
> > +			return;
> > +
> > +		if (resolve_symbol_from_addr(map, addr, &sym_name, &sym_offset))
> > +			return;
> > +
> > +		/* Symbolize the resolved address */
> > +		len = len - (last_imm - buf);
> > +		if (sym_offset == 0) {
> > +			scnprintf(last_imm, len, "%"PRIx64" <%s>",
> > +				  addr, sym_name);
> 
> [Severity: Medium]
> Does this also dereference the potentially dangling sym_name pointer if the
> underlying map was freed in resolve_symbol_from_addr()?
> 
> > +		} else {
> > +			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
> > +				  addr, sym_name, sym_offset);
> > +		}
> > +	}
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1788872630.git.wutengda@huaweicloud.com?part=1
