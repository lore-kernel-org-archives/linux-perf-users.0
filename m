Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5026FDAC;
	Sat, 10 Oct 2026 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614829; cv=none; b=TezVIs6iDsRXfJz6RQtQlT/p8Up++a/7nR6WBIt/9FgR+iRaE7YNamRo6YAGH0j4mH8zyNnyr5JPWGH9PLTNvYbhWkdpZUVAYaBU+FfuyLoOyYHly3fKyMzINXvsvcbBsaLFeC4K5PXoeFasifNm12pCJwkSmd+mK/TxKz5Wnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614829; c=relaxed/simple;
	bh=Z26dJEgacCZh5C+cYOXlk7jp3IOYvPh6AFz1amU70iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmEDV+N7IiOmBunyyRUFOLy4srgEBnGUfkTl6lbzUt2oGqytMZmFJOSlJDHBBdiSO8mUFEGV4ly4f8Kui1r7IbYpwDJxAtQO+0EY35DigaGH6LpxgDDCgSQMFDNpVvj5vN+M9VIbGhwgIsHWeTW7NpOxgsXRuWcxvuL4zSwgqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW3BCju2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW3BCju2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4901F000FF;
	Sat, 10 Oct 2026 06:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791614827;
	bh=Oq5yeZFmsoaZzyKGe5IXF1s5uvW/VRQzGlgCdXtID6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nW3BCju2XgglRKpQNa9NToVGj+LrcwyJqaiakX6LZselQNpfv5SOsqTIYKpgJeZ51
	 2MXiGaUIyP72jcP2Bpx0RwBB29BfE4CEedz5nnLUVcr4VtxvHFIS16e7ZX9jcy9bKv
	 xOD/GxnTf2Tb1HByE5OQgbuVkYz/adGSUnKdfUupnHyRmxoazhXFWkUH8t9xi0JpTq
	 qvLq9xzZYcX9x0cXcDEGLsrhsrS6z2vTYFpnXx1L1eTQCCaL2qR8g5nf9HmDUbjjQF
	 vwwoOZ48e5BTdcoo92jgdiPyMkV6td+88tp0XFBxgkYKwyp3m4GYAWBP3QV74wSVPg
	 f9wLrEKcqbDjA==
Date: Fri, 9 Oct 2026 23:47:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 09/10] perf annotate: Simplify symbol__disassemble()
 with dso binary_type
Message-ID: <asnfagqYiBIClmNS@z2>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-10-namhyung@kernel.org>
 <sashiko-outbox-162546@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-162546@kernel.org>

On Wed, Oct 07, 2026 at 12:01:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] perf: string truncation in symbol__disassemble() due to sizeof(pointer)
> - [High] perf: NULL pointer dereference in LLVM disassembly backend for BPF
> - [High] perf annotate: UAF in dso__get_filename due to missing dso__lock
> --
> 
> commit b52fe9a1d630e0d03a547c6ca49efe1679043beb
> Author: Namhyung Kim <namhyung@kernel.org>
> Subject: perf annotate: Simplify symbol__disassemble() with dso binary_type
> 
> Now it should set the binary type of a DSO properly.  No need to figure
> out a filename suitable for disassembly.
> 
> Just call dso__find_binary_type() and dso__get_filename() for that type.
> 
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index 5478c134e7e3b..07a345beb6250 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> [ ... ]
> > @@ -1566,24 +1488,30 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >  	struct annotation_options *options = args->options;
> >  	struct map *map = args->ms->map;
> >  	struct dso *dso = map__dso(map);
> > -	char symfs_filename[PATH_MAX];
> > +	char *symfs_filename;
> >  	bool delete_extract = false;
> >  	struct kcore_extract kce;
> > +	enum dso_binary_type dbt;
> >  	bool decomp = false;
> > -	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
> > +	int err;
> >  
> > -	if (err)
> > -		return err;
> > +	dbt = dso__find_binary_type(dso);
> > +
> > +	if (dbt == DSO_BINARY_TYPE__KALLSYMS)
> > +		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
> > +
> > +	symfs_filename = dso__get_filename(dso, "", &decomp, dbt);
> 
> [Severity: High]
> Does this call to dso__get_filename() need to be protected by dso__lock()?
> 
> The previous code had an explicit mutex_lock(dso__lock(dso)) around the
> access to dso__nsinfo(dso). dso__get_filename() reads and uses
> dso__nsinfo(dso) via dso__filename_with_chroot(), but lacks internal
> locking.
> 
> If another thread concurrently processes an MMAP event and calls
> dso__set_nsinfo(), could the nsinfo pointer be freed between the check and
> its use, leading to a use-after-free?

Ok, will add the lock.

> 
> > +	if (symfs_filename == NULL && dbt != DSO_BINARY_TYPE__BPF_PROG_INFO &&
> > +	    dbt != DSO_BINARY_TYPE__BPF_IMAGE)
> > +		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
> 
> [Severity: High]
> When annotating BPF programs, this explicitly allows symfs_filename to be
> NULL. However, could this NULL pointer be passed down to the LLVM
> disassembly backend?
> 
> In the LLVM backend:
> symbol__disassemble_llvm()
>   llvm_name_for_code(..., filename, ...)
> 
> Inside llvm-c-helpers.cpp, symbolizer->symbolizeCode(dso_name, ...)
> implicitly constructs an llvm::StringRef from the dso_name pointer.
> 
> If the pointer is NULL, won't this perform a strlen(NULL) and cause a
> segmentation fault? Similarly, on PowerPC, could symbol__disassemble_raw()
> invoke pr_debug("%s", filename) or open(filename, ...) with the NULL pointer,
> triggering undefined behavior?

Will handle it properly.

> 
> >  
> >  	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
> > -		 symfs_filename, sym->name, map__unmap_ip(map, sym->start),
> > -		 map__unmap_ip(map, sym->end));
> > +		 symfs_filename ?: dso__long_name(dso), sym->name,
> > +		 map__unmap_ip(map, sym->start), map__unmap_ip(map, sym->end));
> >  
> >  	pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_name(dso), sym, sym->name);
> >  
> > -	if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
> > -		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
> > -	} else if (dso__is_kcore(dso)) {
> > +	if (dso__is_kcore(dso)) {
> >  		kce.addr = map__rip_2objdump(map, sym->start);
> >  		kce.kcore_filename = symfs_filename;
> >  		kce.len = sym->end - sym->start;
> > @@ -1593,17 +1521,6 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >  			delete_extract = true;
> >  			strlcpy(symfs_filename, kce.extract_filename, sizeof(symfs_filename));
> 
> [Severity: High]
> Since symfs_filename is now a char * pointer rather than an array of size
> PATH_MAX, doesn't sizeof(symfs_filename) evaluate to 8 (on 64-bit systems)?
> 
> Will this cause strlcpy() to truncate the kcore extraction path to 7
> characters, leading to ENOENT failures in the downstream disassemblers?

Right, will fix.

Thanks,
Namhyung

