Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAA4D0A1E
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498910; cv=none; b=XPed6hXGMj6ZvbNIpJLJIF+VN4VlaqBbleS6fIzoIb4tQwnrsXbEdwFBj6xOpRFxIT6R5xMsnq5YgxDYzrRN6cjVZXXgZF6ElwSvGJqHnez+h+56ZUTDjh58YX9VAosVEcoUOj72JoFnWyMf3CX+HsbWTJkjjzRXFbOo539aJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498910; c=relaxed/simple;
	bh=Gu3FIa5FaUGQe6fiaQOQz/HK0J4VGSOGrIwQovGFUog=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UdOwB9Sz6TbHN1vE90UaVZOzdPiplKmVzGeU5m89XJcbGUUkERUwSs3/fXWcBve4IH/vj6/PwqrEYIeaQUt+hXTyEhhp6mZh5J5AsR+fapVPqAnNPjqsJzku3ravBNXLslq1DA7+KigEs3HAwiOdRWdkjmDFVWrXpbTCtGK9cpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHPeHJow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHPeHJow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2131F008A2;
	Tue, 15 Sep 2026 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789498892;
	bh=U9Hzo3nqpkmZZHZYIWmOHANmuEQfchbLG/cPsWU6iUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UHPeHJow4T3ld8yw7yzyL6+yxhmIpelEbQ2TjiQvUKO8aBX5GtWStkk5UV3S6g9uB
	 /UDmVG9Z/rjVLxnfEP+VLtCCFtG+FIZy8fZJhswtrb6Da3dnbfcwYrl5nXzNqwy19k
	 17N4flaBhNmrTv0U5qGg94jjVGefezR4teHluEmyFX1/Aizd91t4ko6FP7uLfLgTo1
	 6Rae2M4x6659u75mZS0Fs/kIXwQ84olccU/cjwBMnJM4lkEFddJUb+6WfIIdyYs7sH
	 UwMZ2cn3hoWXV8/aFMV4VLfxP20S+81vioZfr7JOYvtwC/tLAhVRXz4BisLkwcnhAI
	 G0I9ks/FJH5Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf script: Add --max-symbol-bytes to bound ELF
 symbol memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260915-perf-symbol-memory-send-v1-2-1d3360e21f07@uber.com>
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-2-1d3360e21f07@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 19:01:31 +0000
Message-Id: <20260915190132.9B2131F008A2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf: data race and underflow on global symbol_bytes_used counter
- [High] perf: early abort of ELF symbol loading stretches symbols over add=
ress gaps
- [Medium] perf: u16 truncation in sym->namelen causes permanent memory bud=
get leak
--

commit c9eea40a0a34f49638af63c080650086fd45e844
Author: Alireza Haghdoost <haghdoost@uber.com>

perf script: Add --max-symbol-bytes to bound ELF symbol memory

This patch adds a --max-symbol-bytes option to bound the memory allocated
for struct symbol when loading ELF symbols. Once the budget is reached,
further loading is aborted to prevent OOM kills.

> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index e955c3feddcd6..914e42d21f70f 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1634,6 +1634,13 @@ dso__load_sym_internal(struct dso *dso, struct map=
 *map, struct symsrc *syms_ss,
>  		int is_label =3D elf_sym__is_label(&sym);
>  		const char *section_name;
>  		bool used_opd =3D false;
> +		if (symbol_conf.max_symbol_bytes &&
> +		    symbol__bytes_used() >=3D symbol_conf.max_symbol_bytes) {
> +			pr_warning_once("perf: symbol memory budget exceeded (%lu bytes), "
> +					"remaining symbols will be [unknown]\n",
> +					symbol_conf.max_symbol_bytes);
> +			break;

[Severity: High]
Since ELF symbol tables are generally not sorted by address (they are group=
ed
by binding), breaking out of the loop early creates random gaps in the
address space. Following this, symbols__fixup_end() iterates the partially
loaded rb-tree and stretches any zero-length symbols to the start address of
the very next loaded symbol (prev->end =3D curr->start).

Will this cause execution samples originating in the missing un-symbolized
gaps to be incorrectly attributed to completely unrelated, stretched
zero-length symbols instead of falling back to [unknown]?

[ ... ]
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 3587ad2431590..62a4f91c2f5db 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> +static size_t symbol_bytes_used;
> +
> +size_t symbol__bytes_used(void)
> +{
> +	return symbol_bytes_used;
> +}
> +
> +void symbol__account_bytes(size_t bytes)
> +{
> +	symbol_bytes_used +=3D bytes;
> +}
> +
> +void symbol__unaccount_bytes(size_t bytes)
> +{
> +	symbol_bytes_used -=3D bytes;
> +}

[Severity: High]
The global symbol_bytes_used is updated without atomic operations. In
multi-threaded tools like perf top where different DSOs are loaded
concurrently by different threads, will concurrent updates cause lost
increments?

If subsequent decrements succeed, this could underflow symbol_bytes_used to
SIZE_MAX, instantly exhausting the memory budget and breaking all further
symbol resolution.

> +
>  struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, cons=
t char *name)
>  {
>  	size_t namelen =3D strlen(name) + 1;
> -	struct symbol *sym =3D calloc(1, (symbol_conf.priv_size +
> -					sizeof(*sym) + namelen));
> +	size_t alloc_size =3D symbol_conf.priv_size + sizeof(struct symbol) + n=
amelen;
> +	struct symbol *sym;
> +
> +	sym =3D calloc(1, alloc_size);
>  	if (sym =3D=3D NULL)
>  		return NULL;
> =20
> +	symbol__account_bytes(alloc_size);
> +
[ ... ]
>  void symbol__delete(struct symbol *sym)
>  {
> +	size_t alloc_size =3D symbol_conf.priv_size + sizeof(struct symbol) +
> +			    sym->namelen + 1;

[Severity: Medium]
If a symbol name exceeds 65,535 bytes (which is possible with deeply mangled
C++ or Rust templates), the u16 sym->namelen field silently wraps when it is
assigned during allocation.

When symbol__delete() recalculates the budget to subtract using this trunca=
ted
u16 value, will it result in a much smaller subtraction than the original
addition, acting as a permanent memory budget leak that artificially exhaus=
ts
the limit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-perf-symbo=
l-memory-send-v1-0-1d3360e21f07@uber.com?part=3D2
