Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9713793D3
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789860142; cv=pass; b=NAHu8VsB+zOFmXAkGk0GyfdlEE4ok7tS8moLlrhytmz+XVZbSk7FYUAAv0hG1/eAoXAXRUWpkDV7ZiKl3TUaYkDFL7Hu4lUmBLZ0gdFccYlYPMQRaWDlraFP0dm/ojFKnEvEIPeHo5n9SZ356rM5b8vtGQrSb8dNxNxbkWG+v5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789860142; c=relaxed/simple;
	bh=ZbfRrCsHGOMHU1C3c/VfEoUjlwG/5DvrvQk/2XrT2Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJOhnzOZsbpUJjutq5c88XVtCfjWS2rwLe7GnzOli2/T4FipWH2IXp2be8eQ6ZnsZeGQp1Gw1BqScYojIfXrYBSlWKz76XLmS58hJuNNKbUPU8NtMuPu8LNA71JfLxTjLnmiVSSgGVF8KvVI/I76fKxkpHc+vPdFuWoZPKz374g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=51uyvjG+; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="51uyvjG+"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab222dfso1747398d50.0
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 16:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789860140; cv=none;
        d=google.com; s=arc-20260327;
        b=TJ9WgOlEX7yxAjUgBEncQHKxqWNURqF7uU4/0UQ+Ie7CEqrld2Qf/3ROFPuvEq2LtF
         fN09GPlqLj0oTK4f0FdQ+Bp/AnPC50/WssN3nZM7fR8hX9kXw2RALP4dlZQloltehrUs
         BhyKWIS+nM+zLv9P6QQZZmjJhBVpoaUZXh+rg/Pi4JyZLs3KDXjg74xM/X+vkUJ10SIj
         PTvNuNko60rYGCvG59DnkKNFgjMG3t4PJS1aeSyxWdWCtYW2kfVxlzdCN67E46+sZ6QG
         DivnxjZqTN2hVcyi1yw0QsuEyt7IotNFZ4n3+mPBVHCDnVDfXl4u42L4TzZ77ZbYPRPW
         RFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U2yPeC8EwDJA7EfjJHpQpcfUJ0XSVbb7bMZgykMbs/Y=;
        fh=mJs4/jPnRQnDS4Erj+6LeQ7piz0VigGuV7DDRJl6uJo=;
        b=SeV1EvNJoSz3gPgPEh3MM1xZChfMTqnu0wSNfKY6XgkArreYRJ/TX6p3pUuXfIbjLA
         0TbES7Fo4Zz4DjJRwTG081TiGEtQwtsEcbaaOGyEdOXs4GdyQrx7KnvmxEVYPoOfKa66
         RxGMesCtcboQeWTfd6GwSZ70T1NWrAvs9E/ZU1hHC8e4a5+Aprq1GWisNRKiwnGQgmT2
         gNRphT0FkjwSlcVUpVR9V4ApPsPH/9LCvlclVT3lh8ptHBKumf60/CAP0/oaqEk82FSM
         68tzYZzxnigq5mZpx5oWyzGmJMQyqsEJbeFm8PRijy9B7XW48OW4verdqgH47rlb/ze+
         6Bmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1789860140; x=1790464940; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U2yPeC8EwDJA7EfjJHpQpcfUJ0XSVbb7bMZgykMbs/Y=;
        b=51uyvjG+/BPU5LtN8mLPwiLHR13TGkpDR6pKryy2yN2O0LPZsuJCtYafpoAaJe88ic
         7ampGuzn+OrLacxVFKbklWzdNZxAkBSwciGGip7+s8qMWmPkKPgdqcrIyhilRoDwt17P
         DRWgMNSxoddEKcnL8VV941TrFd0IJchu3gTp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789860140; x=1790464940;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U2yPeC8EwDJA7EfjJHpQpcfUJ0XSVbb7bMZgykMbs/Y=;
        b=RgHL9ZPLfOEHYqNYBHmR6kQyY3dR+kyW9rwvZnHYuChrbThyp1V+ix3+L98yc6vZAM
         OrW5kd4l6um7xk2XHnL5mm7I/sJ+0DAZv2MfIMsTo3ZfgTWKBwrhBGTVrBaUVsSK0dEP
         VYHnQJZt+/Dv51eJlOQspVMo2gTzoZ5RDmqmAz5QhydMm0aLVolI1VcgkD2R7rl/OhBh
         tDduvT2VJ0hhIUeaOqprNclPusekFNYMDIi7dFM4f4IXyHAR1q1vX3G83wXOK9dwYpxz
         FFp1oTJK9nJqEFWd3obwoeWAMbWlgIpDfkxD19ehZg3aYfLbjQEcYLinFVY89OHirqp3
         rBUw==
X-Forwarded-Encrypted: i=1; AKwUvBywHDunNG72ICRO6E3sUe/pKMbS9plWo9Eebi5KUdX2cTfHVAEid+RB5yGlEG4EDTxNm1p4v6WpYK1ohh0K/2Ir@vger.kernel.org
X-Gm-Message-State: AFuF++khhEvAJ49t1qtBXsI1r2pb+txhtrH/2MLCUdHdVtnMs2JkUEqq
	/OsN4/qAsj4YDDgFrC1SvLlhPGpXpJDr27cbtNZueQ6tMmN49YG0EWzKP27BjHhEFcIRpqVBODx
	+QCC95z98Y0/7/z+/Cy1gDd+iiQ1ziCmRNnCzmWG/hw==
X-Gm-Gg: AYBFou24xBw/6W89LaEoFrwLawz7mWuF4m//YBfjYooaK3xnhIMtQi2CrAD68iE+xjm
	LAce0eQA7xLHB4ddto7iip2C8TT/F9LwIJmBWSpxazkLDUnxwQuWf/mnMiGOUKVY8AeIKDaxNda
	/iaUZ+NCEu7TR2DlcNvQwRffm3xpSC4x2B+ejIejwS63VyvFzi2nruC9ZrZWTUzlSWeOL1n3HDv
	9bXi6RohL/0csgdrlVuZEtF5FdWewGav+a93pJRn6+0NDawXRrrMCJ/yN+y64+DqxT7kjLSb0lW
	KBHtaRskgfeBu0KYmQcAfNUdYK+emMu0kM25jyFcjNT8Bika2Y04BQiEm5xR1cPRQv0GZs/j6Xl
	aUVZ6nys5ibtN92vem6sWR20=
X-Received: by 2002:a05:690c:60c7:b0:873:5ddf:d85e with SMTP id
 00721157ae682-897346e1584mr19909387b3.41.1789860137805; Sat, 19 Sep 2026
 16:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-3-1d3360e21f07@uber.com> <aquVqBiZbVYceOJ2@z2>
In-Reply-To: <aquVqBiZbVYceOJ2@z2>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Sat, 19 Sep 2026 16:22:01 -0700
X-Gm-Features: AcwNN1Ut7SMbdpqTrGq_PmTl19FYlXIq0kQESIIpkQ07ObhSYaW8zxaCDaAbWTg
Message-ID: <CA+w=M=Toyobj0Q9UcWUtvW2cwaNoRFaF5KX0zshc+J2pcpHmpg@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf script: Add --lazy-load-symbols for lazy symbol loading
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andrii Nakryiko <andriin@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +static void dso__clip_ondemand_symbols_at(struct dso *dso, u64 addr)
> > +{
> > +     struct dso_ondemand *od = dso__ondemand(dso);
> > +     struct sym_idx *sym;
> > +     u32 lo = 0, hi, mid;
> > +
> > +     if (!od)
> > +             return;
> > +
> > +     hi = od->nr_sorted;
> > +     while (lo < hi) {
> > +             mid = (lo + hi) / 2;
> > +             if (od->sorted[mid].start < addr)
> > +                     lo = mid + 1;
> > +             else
> > +                     hi = mid;
> > +     }
>
> Why not use bsearch()?
>

This search is a lower-bound (bisect_left) operation. I could not find
an ISO C or glibc API that provides that operation.
In patch series v2, I will refactor this search into a small
sym_idx__lower_bound() helper. The clipping helper (symbol-elf.c:626)
and the exact-start IRELATIVE lookup (symbol-elf.c:2176) will use it,
while ordinary non-overlapping interval lookups will use bsearch().


> >  int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
> >  {
> >       uint32_t idx;
> > @@ -623,6 +650,8 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
> >       if (!elf_section_by_name(elf, &ehdr, &shdr_plt, ".plt", NULL))
> >               return 0;
> >
> > +     dso__clip_ondemand_symbols_at(dso, shdr_plt.sh_offset);
>
> Why is this needed?
>

Lazy address lookup uses the index, not the rb-tree. Without clipping
the index at .plt, a preceding fill-forward range can claim PLT IPs
before dso__synthesize_plt_symbols() inserts the PLT symbols. This is
the same truncation the eager path already does on the rb-tree
(symbol-elf.c:680). I will add that explanation at the call site in
v2.

> > +
> > +     /* Alias dedup: keep only the best symbol for each start address */
> > +     if (!symbol_conf.allow_aliases) {
>
> Probably better to factor out the dedup logic into a function.
>

I will factor out the duplicate-selection policy into
symbol__choose_best() and use it in both the eager and lazy paths. The
surrounding dedup loops remain separate because the eager path uses
rb-tree struct symbol objects while the lazy path uses compact index
entries before materialization.

> > +             u32 out = 0;
> > +
> > +             for (i = 0; i < count; i++) {
> > +                     u32 best = i;
> > +                     const char *na = NULL, *nb;
> > +                     char *da = NULL, *db;
> > +
> > +                     /* name_off is the strtab index (st_name) */
> > +                     na = elf_strptr(elf, shdr.sh_link,
> > +                                     od->sorted[best].name_off);
> > +                     if (na) {
> > +                             da = dso__demangle_sym(dso, 0, na);
> > +                             if (da)
> > +                                     na = da;
> > +                     }
> > +
> > +                     /* Find the best among all entries with this start */
> > +                     for (j = i + 1; j < count &&
> > +                          od->sorted[j].start == od->sorted[i].start; j++) {
> > +                             nb = elf_strptr(elf, shdr.sh_link,
> > +                                             od->sorted[j].name_off);
> > +                             if (!na || !nb)
> > +                                     continue;
> > +
> > +                             /* Demangle for comparison, matching eager path */
> > +                             db = dso__demangle_sym(dso, 0, nb);
> > +                             if (db)
> > +                                     nb = db;
> > +
> > +                             /* od->sorted[].end holds st_size at this point */
> > +                             if (choose_best_symbol_raw(
> > +                                         od->sorted[best].end,
> > +                                         od->sorted[best].type,
> > +                                         od->sorted[best].binding, na,
> > +                                         od->sorted[j].end,
> > +                                         od->sorted[j].type,
> > +                                         od->sorted[j].binding, nb) == SYMBOL_B) {
> > +                                     best = j;
> > +                                     free(da);
> > +                                     da = db;
> > +                                     na = nb;
> > +                             } else {
> > +                                     free(db);
> > +                             }
> > +                     }
> > +
> > +                     free(da);
> > +                     od->sorted[out++] = od->sorted[best];
> > +                     i = j - 1; /* skip past all aliases of this start */
> > +             }
> > +
> > +             if (out < count) {
> > +                     struct sym_idx *shrunk;
> > +
> > +                     shrunk = realloc(od->sorted, out * sizeof(*od->sorted));
> > +                     if (shrunk) {
> > +                             od->sorted = shrunk;
> > +                             od->nr_alloc = out;
> > +                     }
> > +             }
> > +             count = out;
> > +     }
> > +
> > +     /* Convert st_size to end addresses */
> > +     for (i = 0; i < count; i++) {
> > +             u64 size = od->sorted[i].end; /* was st_size */
> > +
> > +             if (size > 0)
> > +                     od->sorted[i].end = od->sorted[i].start + size;
> > +             else if (i + 1 < count)
> > +                     od->sorted[i].end = od->sorted[i + 1].start;
> > +             else
> > +                     /* Match symbols__fixup_end's last-symbol formula. */
> > +                     od->sorted[i].end = roundup(od->sorted[i].start, 4096) + 4096;
> > +     }
> > +
> > +     /*
> > +      * Keep a private fd open for pread() of symbol names.  Dup with
> > +      * O_CLOEXEC so children don't inherit it, and so that
> > +      * symsrc__destroy() can close the original regardless of whether
> > +      * it is a real file or a temporary debugdata extraction.
> > +      *
> > +      * If the dup fails (e.g. fd exhaustion), decline by returning 0
> > +      * without setting the index: the caller falls back to the eager
> > +      * loader so the DSO still gets symbols rather than going symbol-less.
> > +      */
> > +     od->fd = fcntl(syms_ss->fd, F_DUPFD_CLOEXEC, 0);
> > +     if (od->fd < 0) {
> > +             free(od->sorted);
> > +             free(od);
> > +             return 0;
> > +     }
> > +     od->strtab_offset = strtab_offset;
> > +     od->strtab_size = strshdr.sh_size;
> > +     od->nr_sorted = count;
> > +
> > +     symbol__account_bytes(od->nr_alloc * sizeof(*od->sorted));
> > +
> > +     dso__set_ondemand(dso, od);
> > +
> > +     pr_debug("%s: on-demand index: %u symbols\n",
> > +              dso__long_name(dso), count);
> > +
> > +     return 1;
> > +}
> > +
> > +/*
> > + * Read a NUL-terminated symbol name from the file's string table at
> > + * file offset @off.  The fast path uses a stack buffer; if the NUL is
> > + * not found within it (names can exceed 1 KiB for template-heavy C++
> > + * mangled names), grow a heap buffer geometrically from 4 KiB, doubling
> > + * until the terminator is found or the strtab is exhausted.  This keeps
> > + * a single long name cheap even when it sits near the start of a large
> > + * (tens of MB) strtab, while bounding a corrupt/missing terminator by
> > + * the remaining strtab size.
> > + *
> > + * Returns a pointer to the name (either @buf or a heap allocation) and
> > + * sets *@to_free to the buffer that must be free()d (NULL for @buf).
> > + * Returns NULL on read error or if no NUL terminator exists within the
> > + * strtab bounds.
> > + */
>
> We have dso-cache APIs to read file data (dso__data_read_offset) and it
> manages file descriptors so you don't need to worry about FD exhaustion.
>

Thanks, I will use dso__data_read_offset() in v2 and remove the
per-index retained fd. I will configure the data-cache reads with the
same symbol-file path and namespace used to build the index, so
split-debuginfo string-table offsets are not read from the runtime
image.


> > +struct symbol *dso__find_symbol_ondemand(struct dso *dso, u64 addr)
> > +{
> > +     struct dso_ondemand *od = dso__ondemand(dso);
> > +     u32 lo, hi, mid;
> > +     const char *name;
> > +     char namebuf[1024];
> > +     char *name_heap = NULL;
> > +     char *demangled;
> > +     struct symbol *s = NULL;
> > +
> > +     if (!od || !od->sorted || od->fd < 0)
> > +             return NULL;
> > +
> > +     lo = 0;
> > +     hi = od->nr_sorted;
> > +     while (lo < hi) {
> > +             mid = (lo + hi) / 2;
> > +             if (addr < od->sorted[mid].start)
> > +                     hi = mid;
> > +             else if (addr >= od->sorted[mid].end)
> > +                     lo = mid + 1;
> > +             else
> > +                     goto found;
> > +     }
>
> bsearch()?
>

Yes. In v2, the default deduplicated index has non-overlapping ranges,
so this lookup will use bsearch() with an interval comparator.
With --allow-aliases, two symbols can cover the same address.
bsearch() then cannot reliably choose which alias to return, so that
uncommon case keeps the explicit search.
