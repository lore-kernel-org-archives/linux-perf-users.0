Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795477219;
	b=OypKsoAz1QSQE4oyTFIUahsV2oUEPL/oQbA5Xxx0l4gpKkE5bmfuzMyG1epNZO+BYJOp
	 1r/OaMu6aLLKpff4d91Qzzsl0MGFVZXOu21t0NCkE5zqF+2YvoKVzsUsL391fLcAVXwf1
	 8P1VQK16d5SNrwqMjzJo014Z6OzsgohuTJMMZjv0e6/b6l7PdOeQbFaVxmXtQUlCskXJM
	 JYUAP6V/GIWEtvH0QT5/EPX+A//05t/HD0zAv21j1tVhncDdMT4iUzHzWCIiiasnNzh6P
	 3W8qSAFvUyIWx4qMwAlrbTklONHo8HUOtdMk4K2n+hJmRrOL+XoQ/6Gq9t6jUTB7epg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CigE2qc2xKI3yxYDFiBGYmMfp5SyNssHdMKcEErpMQo=;
	b=35btD61YLfJdEWI2Q68iKh6fc0d3jLVYzYVlo1Wt33WEJmu0Ac8YpLYyZDQIQGfHY5+s
	 mPq+Q4+ni/OPCs/XwE6QNtCFd+HRrqZwGF4gdYQTSnzf5xoNpXLp9ZO+J0RulQTIo42IC
	 +Znkt5jL3JzVaByp/qAzmEIiYiha5ECBKNd2EBZTF9ZIBkspS7zM+9WdhBAtXCNA9I3WV
	 SQl913lj8Zi++HwDZ3w+IpTp+cIvizmMeIlKrZYoNbyBVkJFTDXOGebHD3++Iy02dM11L
	 H9kDe8RO6VbK7wudHg+jh5axxazx2wgsRQ5h1Je8l8OddhF7qQTAjoRR37YkPSkCVOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TbmDkcwr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414A606A321
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 23:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7414A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TbmDkcwr
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-54492d8a988so675281cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 15:40:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795477217; cv=none;
        d=google.com; s=arc-20260327;
        b=gC9tLAOHM/aM1Z5ArwucAuwyW3mPynFhtCv+cEvtWCrUVtl3tfLpKlV2vzaloiSsaG
         wHUvU186uL3uSj6X9OUvUs1k129/fw/aaF3PWWeJgmF7ei4Nlbs6E6s2W9/gqPbp2Z8l
         SPKsYpfvurqtl+fM944/y9P+H9oMFlnF8QmMEOc9R/uyMD2PtIC4tvysys38iZim7+9g
         FcuVVKTQKb3AIkz/xr7p4/ThNYzJTmbn+AmO3vU37+02gOwLOvIM9JF9kFdDMZHqWev7
         2nIqIl0YzgKbfM+NYCdJRT5oUHqeRZHQ0WnJn+vvXaRW1fKtqwhCe8DAENTRKYx7Xcqc
         Pu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CigE2qc2xKI3yxYDFiBGYmMfp5SyNssHdMKcEErpMQo=;
        fh=IWEtw7AWrChkOZ0/NnfLPcXHjVea8GLjt8uOSfQld/k=;
        b=hgy/3lTjYpkZt4e284X4LbHzRBvnW03yoBFJhIg5DNSIHxhqVvzDtIBehop0fxojAZ
         OqePRQPBIp58fOMGzryVn9JTwd7YR0tpQIYZllzWzXidaqxLPcrLzn5s1CGaKRp9fK9c
         xb/+uQTEwcB4ayBkcSVK2mr3HowS0MPnS1XDFwHcBkKDS7oUQCsUmN2/hTUBrU/zW7aR
         AsC5wu7pySYpaDyJHVCufct3ZyCnVaUagVBPeJopE/5ZTCkqMoEcRYxrYIdahMMRWu+i
         OqIETEX5EgiwAEe7z1pzyWLqnmhdiTHfOtrokY/waHIJrOXlL3DQR/354SuZ6oQVdbk6
         VYXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477217; x=1796082017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CigE2qc2xKI3yxYDFiBGYmMfp5SyNssHdMKcEErpMQo=;
        b=TbmDkcwr0GdyCLUQXlRXa1Xnt8RWlrXBPJeAQ61FJCnDDP5Ae0zOTu3oEQRaU/XiYN
         iN2mt/E49YWm7eJBTCY3rkZqJyVLGU44Ja1BUzTjb1ngYVZM8FaQNX1Wxpvwbr+COEOT
         4roxi0ypBC9rIrGhNdRIDosT9geMswzZ2zi9M9T8lyswIAMKqtoiSbhxOKdZqjzLR+09
         /JbEFqmcgXjakcQgMMec/n83/c3cO8OQ/nvtvpWhTyIdw0gvMWO49o77Ue1FPnl/seXB
         BiWuyizq6lVCrp7iljhHClADH71wgksloZoGi2IYYKD7VAnORxU7t0HqvAC6RXvDKMrS
         3SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477217; x=1796082017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CigE2qc2xKI3yxYDFiBGYmMfp5SyNssHdMKcEErpMQo=;
        b=lwINm+/3+jQlO3o9tdpifEQWqgcR9bGUZd6KNnrKQip8kguiv5XWLJ/uf7qr0aG9/j
         XFSTkpvXb0Av1Fxy3F23mRLQQTqUJTaRUIlM7/7CCgZRUb1lWM5OAqvSiWPapc6x653b
         7/XiIA+EgAJ7rRaoqnv29ptvGsy0YA3HYVPMxrBMnvUQ2OZzDvf3vfiJ+5YTSZlOq8h0
         f52bFhCYhg87lCZFs2+J5E49h4NIH+gMV30fsWX6Dn2yV7vqAikeiSOssrfQexGflSbI
         fgf+08jx9l0a5lT8UYNqRQ6yNl6gTC7FEhhunDgR+ggBd/0ncF5DvatLSvfoBfYqY3mC
         Cd4A==
X-Forwarded-Encrypted: i=1; AL+hErHuJ3fySKJ/czWnZPA0dftD6soFUAhrC9IF5eUK1WWx/29rCXLzJfGI9yNs1BrMMO08A8O6GfXY3lltOAHHZUo5@vger.kernel.org
X-Gm-Message-State: APuU4Z/D8T2F63N+OQLlZTsDPzYZHiJVhOLV9GqE0ImNeAz0/3YHXqhu
	UogZCxP9lsagJQVzYF0romC/tg7nHGrfcqJ+W/44BiSAYmEnOOXUrdRSfgZDWV61QNdC6aHyXlX
	WAjvge2cHu9Jcl2hNIELmh4syEhIczYRfIdg5qGlzP+YSQgbHGeT8eeBL
X-Gm-Gg: AZFdTZcSGWMlKP5V+P6LAbwu3RRGcS8IKTCtT+enmj540QJ6Og7GWg0J72iAB+Up3gh
	4jjyfi0tWyrZ8IfHRum/K3QrU3+O1aT7zhDlsXhAQOVAXaGi7Bk+vZzCaidaKCXzC7V+lyF00Fr
	5YFC3rkwnxFfzWjb42TC/HKlo9V24kEN5ViUdIoAMfn8wiOSxwcoOaEHwNDMo17dC0YokLp4gOL
	Plg2d2BAPi1QHwvfN0eJ6bEmGcCcZh22zrLq/3FmoixoqRmXKYpJ4up+tFjqyPiI4SfZiqb+fYf
	wEzLp6vL+Wslsak9BdFDsb8hPePt++q1mnuVv/mXpYndbqkcCJ0RAe/U5EuJgGEexsZZQduPbKu
	aBaZ3eZ3pOmBSHRM+DbsMuwwjOODlwtPb6pCy
X-Received: by 2002:a05:622a:4d47:b0:534:313:9b4e with SMTP id
 d75a77b69052e-55d8815e2d1mr39911811cf.5.1795477216155; Mon, 23 Nov 2026
 15:40:16 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122050405.80335-1-irogers@google.com> <awS0QkL6JuMfC7Z0@google.com>
In-Reply-To: <awS0QkL6JuMfC7Z0@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Nov 2026 15:40:04 -0800
X-Gm-Features: Aa3M54q87N9tA-1KkNEvsdYeoK8WMER-2FcXp6N7XfmgWb1EWKZPQTPi3H_9giA
Message-ID: <CAP-5=fX4-HqRbB8zWNSUFyCc4Lzz44iNmok5HJVj5O1+oqoWOA@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] perf symbol: Sorted arrays, DSO-owned lifetimes,
 and memory shrinking
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alireza Haghdoost <haghdoost@uber.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 1:46=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Sat, Nov 21, 2026 at 09:03:55PM -0800, Ian Rogers wrote:
> > When profiling large binaries or long-running workloads with many DSOs =
and
> > threads, symbol and DSO tables frequently dominate perf's memory footpr=
int
> > and startup latency. Currently `struct symbol` still has several struct=
ural
> > limitations:
> >
> > 1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
> >    `dso->symbols` address rbtree, scattering lookups across non-contigu=
ous
> >    heap nodes.
> > 2. `dso__symbols()` has no internal synchronization against concurrent
> >    readers/writers, and unreferenced DSOs and auxiliary symbol/debuginf=
o
> >    buffers cannot yet be reclaimed under memory pressure.
> > 3. Sorting `dso->symbols` with `qsort()` does not take advantage of
> >    pre-ordered ascending runs in ELF symbol tables, and `first_ending_a=
fter()`
> >    in `struct maps` runs a full binary search even for ascending
> >    `/proc/pid/maps` synthesis.
> >
> > Thirteen preparatory fixes, benchmarks, `dso_symbol` lifetime conversio=
ns,
> > `symbol_conf.priv_size` removal, and ELF header caching patches from v4=
-v6
> > have landed in `perf-tools-next`. The remaining 10 patches convert symb=
ol
> > iteration to callbacks, replace the `dso->symbols` rbtree with a sorted
> > pointer array, stage natural-run merge sort and incremental symbol
> > insertion, and add memory shrinking APIs and unit tests:
>
> I've applied the first 6 patches to perf-tools-next.
>
> The patch 7 was bigger than I expected.  Can you simplify it more?
>
> Also I don't plan to merge the rest patches as of now.  Let's wait for
> the lazy loading and try that for a while.

Thanks for merging those ones. I will split patch 7 and rebase. Patch
8, shrinking DSOs, etc. is kind of the whole point of the series.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > - **Preparatory fix, `maps` tail fast-path, and symbol iteration (Patch=
es 1-4)**:
> >   - Patch 1 fixes an `alloc_func_regex` leak on error returns in
> >     `builtin-kmem.c`'s `build_alloc_func_list()`.
> >   - Patch 2 adds an O(1) tail fast-path check in `first_ending_after()`=
 for
> >     ascending map insertions.
> >   - Patch 3 converts `symbols__for_each_entry()`, `dso__for_each_symbol=
()`,
> >     and `map__for_each_symbol()` to callback-based iteration and update=
s
> >     existing callers.
> >   - Patch 4 converts open-coded `dso__first_symbol()` / `dso__next_symb=
ol()`,
> >     `rb_first_cached()`, and `dso__symbol_names()` loops to callback
> >     helpers and removes `dso__{first,last,next}_symbol()`.
> > - **Sorted symbol arrays and staged sorting optimizations (Patches 5-7)=
**:
> >   - Patch 5 replaces `dso->symbols` (`rb_root_cached`) and
> >     `dso->symbol_names` with a `rw_semaphore`-protected `struct symbols=
`
> >     container backed by sorted pointer arrays, removing `struct rb_node=
`
> >     from `struct symbol` (shrinking `sizeof(struct symbol)` from 48 to =
24
> >     bytes, or 16 bytes net per symbol after accounting for the array
> >     pointer).
> >   - Patch 6 replaces `qsort()` on `struct symbols` with a stable
> >     natural-run merge sort.
> >   - Patch 7 optimizes incremental dynamic symbol insertions
> >     (`dso__insert_symbol()`) and small appends using `@sorted_cnt` and =
a
> >     sorted tail buffer with amortized `sqrt(N)` merge.
> > - **Memory shrinking APIs and unit tests (Patches 8-10)**:
> >   - Patch 8 adds `symbols__shrink()`, `dso__shrink()`, `dsos__shrink()`=
,
> >     `machine__shrink()`, `machines__shrink()`, and `perf_session__shrin=
k()`
> >     to reclaim `symbols_by_name`, excess array capacity, cached DSO fil=
e
> >     descriptors/data/DWARF state, and unreferenced user DSOs (`refcnt =
=3D=3D 1`
> >     with no annotated symbols), with transparent on-demand reload via
> >     `dso__load()`.
> >   - Patch 9 adds `dso__session()` and `perf_session__malloc()` /
> >     `zalloc()` / `calloc()` / `realloc()` / `strdup()` wrappers (leavin=
g
> >     production caller wiring for follow-up once lazy symbol loading is
> >     evaluated).
> >   - Patch 10 adds unit tests in `perf test symbols` covering sorted sym=
bol
> >     insertion, equal-start aliases, symbol/DSO shrinking, `dso_symbol`
> >     lifetime pinning, inline frame/srcline cleanup ordering,
> >     `symbols_by_name` on-demand rebuild, transparent DSO reload, and se=
ssion
> >     allocation wrappers.
> >
> > Changes in v8:
> > - Rebase onto `tmp.perf-tools-next` (`eb79d2fbc230`), adopting
> >   `<linux/compiler-context-analysis.h>` annotations (`__guarded_by(&loc=
k)`,
> >   `__acquires_shared(&symbols->lock)`, `__must_hold(&symbols->lock)`,
> >   `__context_unsafe()`) on `struct symbols` and `dso` / `tests/symbols.=
c`
> >   and adapting `dso__shrink()` / `dso__try_evict()` to `dso__data_open_=
lock`
> >   and `close_dso()`.
> > - Pass `first_unsorted` (`m =3D symbols->sorted_cnt`) to
> >   `symbols__insertion_sort_range()` in `symbols__sort_locked()` (`Patch=
 7`)
> >   so the `k <=3D 8` small-append fast path and allocation-failure fallb=
acks
> >   skip scanning the already-sorted prefix `[0 .. m)` (Sashiko).
> >
> > Changes in v7:
> > - Rebase onto `perf-tools-next` (`bb27ddbaee56`), dropping the 3 patche=
s
> >   from v6 that have been applied upstream.
> > - Drop `nr_addr_sorted` and `nr_name_sorted` incremental partial-sort s=
tate
> >   from `struct maps`, keeping only the `first_ending_after()` tail
> >   fast-path check (`Patch 2`) (Namhyung Kim).
> > - Split out the `alloc_func_regex` leak fix in `builtin-kmem.c` (`Patch=
 1`),
> >   the `map__for_each_symbol()` callback conversion (`Patch 3`), and the
> >   conversion of open-coded symbol loops (`Patch 4`) ahead of the `rbtre=
e`
> >   to `struct symbols` array conversion (`Patch 5`) (Namhyung Kim).
> > - Split symbol sorting optimization into a simple natural-run merge sor=
t
> >   patch without galloping (`Patch 6`) followed by incremental dynamic
> >   symbol insertion with a sorted tail (`Patch 7`) (Namhyung Kim).
> >
> > Changes in v6:
> > - Fix `symbols__find()` when `sorted_cnt < cnt` so that if the slice
> >   (sorted prefix or unmerged sorted tail) with the higher `start <=3D i=
p`
> >   group ends before `ip`, `symbols__find()` returns `NULL` rather than
> >   falling back to an earlier outer symbol in the other slice, matching
> >   post-merge behavior, and add unmerged-vs-merged prefix/tail overlap a=
nd
> >   equal-start alias unit tests (Sashiko).
> > - Use positive `ENOMEM` rather than `-ENOMEM` on `symbol__annotation()`
> >   failure in `symbol__annotate()`, `symbol__annotate2()`, and
> >   `__hist_entry__tui_annotate()` to match `symbol__strerror_disassemble=
()`,
> >   check `symbol__annotate() !=3D 0` in `hist_entry__get_data_type()`, a=
nd
> >   guard against `NULL` `notes` / `notes->src` in `find_disasm_line()`
> >   (Sashiko).
> >
> > v7: https://lore.kernel.org/linux-perf-users/20261121071651.67118-1-iro=
gers@google.com/
> > v6: https://lore.kernel.org/linux-perf-users/20261117185305.108003-1-ir=
ogers@google.com/
> > v5: https://lore.kernel.org/linux-perf-users/20261116063435.2817923-1-i=
rogers@google.com/
> > v4: https://lore.kernel.org/linux-perf-users/20261113171734.2188066-1-i=
rogers@google.com/
> > v3: https://lore.kernel.org/linux-perf-users/20261110220803.2503416-1-i=
rogers@google.com/
> > v2: https://lore.kernel.org/linux-perf-users/20261027231513.816148-1-ir=
ogers@google.com/
> > v1: https://lore.kernel.org/lkml/20260928075237.3055101-1-irogers@googl=
e.com/
> >
> > AI Assistance Disclosure (per Documentation/process/coding-assistants.r=
st
> > and Documentation/process/generated-content.rst):
> > - Tools used: Google Antigravity / Jetski coding assistant and Sashiko
> >   automated patch review (sashiko.dev and internal Sashiko).
> > - Summary of prompts and assistance: Interactive pair-programming sessi=
on to
> >   replace per-symbol refcounting with `struct dso_symbol` DSO-borrowed
> >   lifetimes, split symbol callback iteration and staged natural-run mer=
ge
> >   sort / incremental insertion patches, rebase onto `tmp.perf-tools-nex=
t`
> >   context-analysis annotations, and address LKML reviewer and Sashiko
> >   feedback across `kmem`, `dso`, `map`, `maps`, `symbol`, and
> >   `tests/symbols.c`.
> > - Testing performed: Built each commit (`[1/10]` through `[10/10]`) wit=
h
> >   Clang (`-DWARN_CONTEXT_ANALYSIS -Wthread-safety -Wthread-safety-point=
er
> >   -Wthread-safety-beta`), AddressSanitizer, LeakSanitizer, and `DEBUG=
=3D1`
> >   (`REFCNT_CHECKING=3D1`); ran `perf test` (including `Symbols`, `Maps`=
, `DSO
> >   data`, `hists`, `thread`, and `annotate` suites), `perf bench interna=
ls`
> >   (`symbols` and `maps`), and `scripts/checkpatch.pl`.
> >
> > Ian Rogers (10):
> >   perf kmem: Fix alloc_func_regex leak on error in
> >     build_alloc_func_list()
> >   perf maps: Add tail fast-path check in first_ending_after()
> >   perf symbol: Convert map__for_each_symbol() to callback-based
> >     iteration
> >   perf symbol: Use callback iteration instead of open-coded symbol loop=
s
> >   perf symbol: Switch backing storage from rbtree to struct symbols
> >     array
> >   perf symbol: Replace qsort() with natural-run merge sort
> >   perf symbol: Optimize incremental symbol insertion with sorted tail
> >   perf symbol: Add memory shrinking for symbols, DSOs, and machines
> >   perf session: Add dso__session() and session-scoped allocation
> >     wrappers
> >   perf test symbols: Add tests for symbol shrinking and session alloc
> >     wrappers
> >
> >  tools/perf/arch/powerpc/util/sym-handling.c |   34 +-
> >  tools/perf/builtin-annotate.c               |   11 -
> >  tools/perf/builtin-kmem.c                   |   51 +-
> >  tools/perf/tests/hists_common.c             |    5 +-
> >  tools/perf/tests/maps.c                     |   46 +
> >  tools/perf/tests/symbols.c                  |  851 ++++++++++++++-
> >  tools/perf/tests/vmlinux-kallsyms.c         |  181 ++--
> >  tools/perf/ui/browser.c                     |    3 +
> >  tools/perf/ui/browsers/hists.c              |    3 +-
> >  tools/perf/ui/browsers/map.c                |   62 +-
> >  tools/perf/util/auxtrace.c                  |  109 +-
> >  tools/perf/util/db-export.c                 |    4 +-
> >  tools/perf/util/dso.c                       |  324 +++++-
> >  tools/perf/util/dso.h                       |   90 +-
> >  tools/perf/util/dsos.c                      |   51 +
> >  tools/perf/util/dsos.h                      |    3 +
> >  tools/perf/util/intel-pt.c                  |   74 +-
> >  tools/perf/util/libbfd.c                    |    3 +-
> >  tools/perf/util/machine.c                   |   60 +-
> >  tools/perf/util/machine.h                   |    8 +
> >  tools/perf/util/map.c                       |   36 +-
> >  tools/perf/util/map.h                       |    8 +-
> >  tools/perf/util/maps.c                      |    4 +
> >  tools/perf/util/probe-event.c               |   98 +-
> >  tools/perf/util/session.c                   |   78 ++
> >  tools/perf/util/session.h                   |    8 +
> >  tools/perf/util/symbol-elf.c                |   12 +-
> >  tools/perf/util/symbol.c                    | 1042 +++++++++++++++----
> >  tools/perf/util/symbol.h                    |   84 +-
> >  tools/perf/util/symbol_fprintf.c            |   25 +-
> >  30 files changed, 2706 insertions(+), 662 deletions(-)
> >
> >
> > base-commit: eb79d2fbc230d41b009e49f20671303c6efbd946
> > --
> > 2.56.1.750.gf70dc682cf-goog
> >
