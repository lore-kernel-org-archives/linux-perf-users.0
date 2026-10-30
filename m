Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793368980;
	b=E1ia85Vw6mi3N17IfeTt5sSa7fWsjmOkoaC/mOYtvIl4KvelTpLsWTSwn/O5A6dD648V
	 iqhhCuwG48PIB6Qi/PKNu8DtdRe2gnarLEog9wNxWJXCUxV+6CkO0QlJsNMRggFOoldn8
	 YqWwJ7pZAWy5W8uCkJbJpZVGzMopZfXBlWE6IfsmDobXVUlDiXtxOwR8UPguwxKRZdxXT
	 TSLgHLOaFa9T7CU0/zc1YK2PZvl0TFGh4QO5xODtN65T0ERRMqNS+TACPWrLyoMdqlsmt
	 M1Bm+Lh6MTD6pmHtw6lRNyYgXWJfzKu21xrCJyY212xf5s+IQNhernaDU+HIKi4jATw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xStrK9E8kQ84HOqKghD273ii2ItB0D83WuD1/iC0dus=;
	b=JfczjoKl0944kEIiXv/v/owMSYfDpCe9O7VsRG61vxwVgOAtsnFz00h6TaAnMjNQ9HmP
	 gjaskdKyraTV10NjouPw8HRuY10gqk2fbQXWVF1xqhSyNdROixgYMUo40HZ7w8rCC/4rL
	 lfk9IpJuRLK30J7pwXQ6QH/ZCYhWB3nfQ6S/OdZylyoDepXBIPYSZ3Bg4hFXM9bDEApsa
	 /U7lX+AejcCkErv+kIwRXgyd5O1qDC/2z6OCrZSf9B8H5GR/oNng5VJ5COl9hASjRayX5
	 uAwBV/fREFQ+cdjHrbjM6/oXwZ0mBvzduzSrJV9Qf2BLNm6JqSqFcTZDpD+gLEb0yHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=rrn6lIPd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC90606A32E
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 14:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAC90606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=rrn6lIPd
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-679a2297c55so814255d50.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 07:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793368979; cv=none;
        d=google.com; s=arc-20260327;
        b=sPtA3J8FKaswKWe8JgQQACAueNVh5C8uz2/zlGu3y9osXnXM2WO8mWqj0ssZOIGXoh
         1DZ5HnIrSkU7LBAuIB/zf7Te+AuEeQdcbIS8fBzV3TRkvEUVTWTHRhl48d0rUih2dvFv
         hqDg9xLKCtu5lKY4qL1glP/1czwQDbR590oHDk32jjkUnKDKTZxn0oGuhGTVy+bUx0bx
         if4H8hv1olBMA98fY+KGuNCsJhcm0Etw6J1IZzQ/dbl1IIOX18VfMvaTXAM+i3mCamU9
         uFzt6Qh9BpAkD3NgNiIE3NEWCJ50qcJ5HNcFbYrGVyUqSwm4HnM2Ki7QMHIX0tNxbuv1
         gO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xStrK9E8kQ84HOqKghD273ii2ItB0D83WuD1/iC0dus=;
        fh=7ShJY1rW/8ZdOLlFwpWreRZWxA17231UWv6KOvuY6gQ=;
        b=k7BE8y0HIEGFXLvnoHyGPrLV/feP1gaV9faFxP7Tgw7BFbMIQCtBF4A8NgyjPcGpx1
         QF3x15Eh6+IyjzFKFc5akTdpnyjEAuhso9u+kKEUt20lGsRQyRHR83koLd95NrBy6mgq
         QsU96+GXdQD+NmaLvoY6PJ2VkvIecOBdKDCT3iw6GSZcnqOUO/Csur+9QdvxhJagr1EQ
         CeHcAKLTwibaBbGlpZzl8m+mlgFXljUEDvo2KdtNRCugeZmwUEpIT00rrbG9kjSMoQdq
         Hu9OOp0yGI+GJL3Z2iS1Pr/hKiw/5E1QJi7aasVP7lB7toKL5yhpiXOe+Be6VxWh8Dvk
         a7Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1793368979; x=1793973779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xStrK9E8kQ84HOqKghD273ii2ItB0D83WuD1/iC0dus=;
        b=rrn6lIPdfTi4ivuU/87smaCCtJM0b4ZSCe2vGQGZcGwuFXoThkEAYM6WpkXFNce1PJ
         RObuMZSc8bx1bnvAEOjhR8GVrK8yFS6n7Fw/KP9TubKLfdKPhkW/hSHJrCjwOoAbl5Gi
         N1IMQZy3rW3CpGrE4AGoWGoKpMumHQdBuO1D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368979; x=1793973779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xStrK9E8kQ84HOqKghD273ii2ItB0D83WuD1/iC0dus=;
        b=T1i24t/FSBeLRG50aIR/1jsNMcOvaXP2QLDvvGkbswnRdJu2Zm4eOLhRYHPGHj0ToB
         mxf5qlES+heAZQwLtHmsqcYL4uZhO1ItWusbS+6ox9iNz3Elad7ANfS9x3U73PgyRrvo
         pFAHZ/NoW5CAlGkx1z/4EE0trUUaFY8rrDjwPzkzLPcHWVMtjGX2m01l8q/CN14YkMax
         cMBzaMVHghCQnZxeINGMmpNgzl9Lmnv4zKhQQOw2Agzq8AoLBeQVupzRTLgqbMJrqBP6
         F5KGHmAh308tx9o5B3Jl1pIj0BBoFkFBlnqw3zZiStKD1bMhF1dPvXHK9sGzD2ghlwK3
         OnVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwK9Ii5bxm8CLKOMOjAX+ousw7vUr5rMDwHrryXDjOnlQWVleX6/uGAPsjl8vxXiGlqR4WzO/MvJc8vgif35FIG@vger.kernel.org
X-Gm-Message-State: AFq9FYK6m92ulP1TEJyjckoR/aJ5f8tR3p6bVAYKC74EXFHQDzDHzdxN
	GFDSZkkehfqPVFyA5mPJYvnFsrNqGnNeH/Tsiro14FjxBqQEe4DEmHBQpq6qSpVVtzZ+oYGyS4u
	Ftd2xSIW4ew6Y7/4YMoZI0yGVOYM0HqHVktDVjCDc/w==
X-Gm-Gg: AYBFou335rUe6dRe0C8C0nitjR7GlT6T58WkZMuPAbEVHOQe05ztHYFEf7L3mtuXyJh
	+5rHZEVgteuj9ZXeJuUCoAyZc7dEjtR9PhU4QVutUKi7m+8q8cOxJZzunLF+RtDfrwyvQYvjy15
	YyOtJ0l26IVLvxl+p2Z51A2o/OqghSQmjuDsIWfA4xLK31f37aX79SE0mdJQrnGbHCVW+6FdcEq
	LpMZNGktDeO8CEXANJuUr0w8PHlj9We/oQPkB+kerZPC67IoBfW1iuQphM+KrINoRq1CAPu4CCk
	s07yGGLZNcl76yQ57ZeKYW3MH4Typj/n6jA7AT05cbrL5nHgni9pJBKpZhL4MVrInpTEZo5wDIk
	rqtUx6d9Yq7lH/4lJIKavtkKiKInwCyN7lVuRANS222vwcjMTDpPRP4P5d+xnoOzSSOS4GQ==
X-Received: by 2002:a05:690e:801:10b0:675:2f4a:53fc with SMTP id
 956f58d0204a3-67ba4fbad81mr1132986d50.19.1793368978306; Fri, 30 Oct 2026
 07:02:58 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
 <CAP-5=fUpji7seZpsxh0BN05oAA6nMUyM-bNdHBg4YfkeNAT00A@mail.gmail.com>
In-Reply-To: <CAP-5=fUpji7seZpsxh0BN05oAA6nMUyM-bNdHBg4YfkeNAT00A@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 30 Oct 2026 07:02:41 -0700
X-Gm-Features: AclHuK9L55dtmknuOLxAAr9xuWmR5QC8l5_v06c-eIMTLFdmut2VrtfBK30Uy4A
Message-ID: <CA+w=M=TEYScc9rDyzthN75Ym41ATXoNLNu8_yj0dsjymb+m7jA@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] perf symbol: Reference counting, sorted arrays,
 and memory shrinking
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

I applied v2 on perf-tools-next e74880764bf9 with the ELF_C_READ_MMAP
fix and your three fixes, and compared it with the same tree without
the 18 patches. I posted comments are on the individual patches; this is th=
e
summary.

On a profile of a large C++ service, about 1M symbols, perf script and perf=
 r
eport output is byte-identical and roughly 22-32% faster:

Execution time and peak RSS before and after:
perf script                                3.3s 334 MiB vs 2.25s 332 MiB
perf report --sort dso,sym       3.0s 389 MiB vs 2.25s 386 MiB
perf report --children -g caller 4.6s 706 MiB vs 3.60s 703 MiB

Peak RSS barely moves. sizeof(struct symbol) goes from 48 to 32 bytes,
but the address array adds a pointer per symbol back, so the net is
about 8 bytes per symbol before malloc rounding. That is under 1%
here.

Thanks
Alireza

On Wed, Oct 28, 2026 at 1:29=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Oct 27, 2026 at 4:15=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > When profiling large binaries or long-running workloads with many DSOs =
and
> > threads, symbol and DSO tables frequently dominate perf's memory footpr=
int
> > and startup latency. Currently `struct symbol` has several structural
> > limitations:
> >
> > 1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
> >    `dso->symbols` address rbtree, plus an optional negative-offset
> >    allocation prefix (`symbol_conf.priv_size`) for TUI browser indices,
> >    `db-export` IDs, or `struct annotation` state even when only a tiny
> >    fraction of symbols are ever annotated or exported.
> > 2. Unlike `struct map`, `struct dso`, and `struct thread`, `struct symb=
ol`
> >    is not reference-counted: once loaded into a `struct dso`, symbols c=
an
> >    never be safely evicted while `hist_entry`, `callchain_cursor_node`,=
 or
> >    `map_symbol` references exist, and `dso__symbols()` has no internal
> >    synchronization against concurrent readers/writers.
> > 3. ELF symbol table loading (`dso__load_sym_internal()`) repeatedly
> >    invokes `libelf` section/program header lookups per symbol, calls
> >    `elf_sym__name()` before filtering out non-function/non-allocated
> >    symbols, runs Rust/Java demanglers on plain C symbols without fast-p=
ath
> >    prefix checks, and resorts `dso->symbols` with `qsort()` even when E=
LF
> >    symbol tables are already largely ordered in ascending address runs.
> >
> > This series modernizes `struct symbol` to match the rest of `tools/perf=
/util`
> > (`DECLARE_RC_STRUCT`, `struct rw_semaphore`, sorted pointer arrays) and
> > introduces symbol/DSO memory shrinking and faster ELF symbol loading:
> >
> > - Patch 1 adds `perf bench internals symbols` and `perf bench internals=
 maps`
> >   to benchmark ELF symbol loading, bulk symbol insertion/sorting/lookup=
,
> >   incremental symbol appends, ascending map insertion, and incremental =
map
> >   appends.
> > - Patch 2 adds fast-path prefix checks in `dso__demangle_sym()` (before
> >   calling `rust_demangle_demangle()`, keeping `demangle-rust-v0.c`
> >   unmodified relative to upstream `rustc-demangle`) and in
> >   `java_demangle_sym()`.
> > - Patches 3-6 encapsulate `struct symbol` field access behind accessor
> >   functions (annotated with `__attribute__((nonnull))`) and replace the
> >   negative-offset `symbol_conf.priv_size` allocation prefix with on-dem=
and
> >   browser index calculation and per-DSO/per-exporter hashmaps for
> >   `db-export` and `struct annotation`.
> > - Patch 7 replaces `dso->symbols` (`rb_root_cached`) and `dso->symbol_n=
ames`
> >   with a locked `struct symbols` container backed by sorted pointer arr=
ays
> >   (`symbols` and `symbols_by_name`) protected by a `struct rw_semaphore=
`,
> >   removing `struct rb_node` from `struct symbol`.
> > - Patch 8 wraps `struct symbol` in `DECLARE_RC_STRUCT(symbol)` with
> >   `refcount_t` (`symbol__get()` / `symbol__put()` / `symbol__zput()`) f=
or
> >   sanitizer-checked reference counting across `map_symbol`, `addr_locat=
ion`,
> >   `hist_entry`, `callchain`, `thread_stack`, and `db-export`.
> > - Patch 9 replaces `qsort()` in `struct symbols` with a natural-run mer=
ge
> >   sort and galloping merge (taking advantage of pre-ordered runs in
> >   `.symtab`/`.dynsym` and `kallsyms`) plus an in-place binary insertion
> >   fast path for small incremental appends.
> > - Patch 10 applies the same incremental binary-insertion sort and an O(=
1)
> >   tail-insertion fast path to `struct maps` for `/proc/<pid>/maps` synt=
hesis
> >   and runtime `PERF_RECORD_MMAP2` / JIT map insertions.
> > - Patch 11 caches ELF program and section headers during
> >   `dso__load_sym_internal()`, defers `elf_sym__name()` string table loo=
kups
> >   until after symbol filtering, and runs `symbols__fixup_end()` /
> >   `symbols__fixup_duplicate()` once per DSO load.
> > - Patches 12-17 add `down_read_trylock()` / `down_write_trylock()`, pro=
tect
> >   `machines->guests` with a `rw_semaphore`, implement `symbols__shrink(=
)`,
> >   `dso__shrink()`, `dsos__shrink()`, and `perf_session__shrink()` (with
> >   transparent on-demand reload in `dso__load()` that preserves pointer
> >   identity for retained symbols), and provide `perf_session__malloc()` =
/
> >   `zalloc()` / `calloc()` / `realloc()` / `strdup()` wrappers that
> >   automatically shrink unreferenced symbols and DSOs on allocation fail=
ure.
> > - Patch 18 adds unit tests in `perf test symbols` covering sorted symbo=
l
> >   insertion, symbol/DSO shrinking, transparent DSO reload after shrink,=
 and
> >   session allocation wrappers.
> >
> > End-to-end benchmark results across the series:
> >
> >   perf bench internals symbols (perf binary):
> >     Average DSO load + sort:      7.348 msec ->   5.324 msec (-27.5%)
> >     Average DSO memory usage:        1401 KB ->      1308 KB ( -6.6%)
> >     Average bulk insert + lookup: 1453.95 us -> 1161.00 us   (-20.1%)
> >     Average append + lookup (200 interior inserts into 10,000 symbols):
> >       rbtree: 42.85 us -> array+qsort: 40429.75 us -> array+binary-inse=
rt: 152.70 us
> >
> >   perf bench internals symbols -b libLLVM.so.21.1:
> >     Average DSO load + sort:     81.196 msec ->  62.582 msec (-22.9%)
> >     Average DSO memory usage:        9530 KB ->      9164 KB ( -3.8%)
> >
> >   perf bench internals symbols -b libLLVM.so.21.1 --no-demangle:
> >     Average DSO load + sort:     32.675 msec ->  19.122 msec (-41.5%)
> >     Average DSO memory usage:        7589 KB ->      7229 KB ( -4.7%)
> >
> >   perf bench internals maps:
> >     Average ascending insert + lookup:   63.37 us -> 58.97 us ( -6.9%)
> >     Average append + lookup:           7477.45 us -> 96.67 us (-98.7%, =
77.3x faster)
> >
> > Net performance and memory trade-offs:
> > - Replacing the per-symbol rbtree (`struct rb_node`) and negative-offse=
t
> >   `symbol_conf.priv_size` allocation prefix with a contiguous sorted po=
inter
> >   array reduces per-symbol heap overhead by 16 to 24+ bytes (saving 3.8=
% to
> >   6.6% of total DSO symbol table heap memory unconditionally, and allow=
ing
> >   unreferenced symbols and DSOs to be shrunk on demand under memory
> >   pressure).
> > - For the dominant symbol workloads=E2=80=94loading ELF binaries (`-22.=
9%` to
> >   `-41.5%`) and bulk symbol insertion, sorting, and lookup (`-20.1%`)=
=E2=80=94the
> >   contiguous array, natural-run merge sort, ELF header caching, and
> >   demangler fast paths yield substantial speedups over the rbtree basel=
ine.
> > - For synthetic single-symbol interior insertions interleaved with imme=
diate
> >   lookups into an already-large 10,000-symbol DSO (`dso__insert_symbol(=
)`),
> >   an rbtree rotation takes ~0.21 us/op (`42.85 us` for 200 ops) whereas
> >   shifting the contiguous pointer array tail with `memmove()` after bin=
ary
> >   search takes ~0.76 us/op (`152.70 us` for 200 ops, down from `40429.7=
5 us`
> >   with naive `qsort()`). In real workloads, symbols are either loaded i=
n
> >   bulk (`dso__load()`) or inserted into small per-prog BPF/JIT DSOs whe=
re
> >   the array fits in a few cache lines, making this sub-microsecond
> >   difference negligible in practice.
> > - Overall, the series reduces memory consumption across all workloads w=
hile
> >   significantly improving=E2=80=94or remaining neutral on=E2=80=94runti=
me performance.
> >
> > v2:
> > - Rebased onto perf-tools-next (dropping "perf symbols: Fix broken
> >   ELF_C_READ_MMAP fallback guard", which was merged upstream, and split=
ting
> >   "perf libdw: Optimize fallback logic for missing DWARF" into a separa=
te
> >   fixes series).
> > - Added 'perf bench internals symbols' and 'perf bench internals maps'
> >   benchmarks (Patch 1) and included before/after numbers in the optimiz=
ation
> >   patches.
> > - Added __attribute__((nonnull)) annotations to struct symbol accessor
> >   functions (Patch 3).
> > - Split the symbol_conf.priv_size removal patch into three separate pat=
ches
> >   for map_browser (Patch 4), db-export (Patch 5), and annotate (Patch 6=
).
> > - Added dedicated optimization patches for Rust/Java demangler prefix c=
hecks
> >   (Patch 2), natural-run merge sort and binary insertion in struct symb=
ols
> >   (Patch 9), tail-insertion and incremental binary-insertion sort in st=
ruct
> >   maps (Patch 10), and ELF program/section header caching and deferred
> >   symbol name lookup (Patch 11).
> > - Replaced periodic heuristic LRU shrinking and windowed ELF symbol loa=
ding
> >   with on-demand shrinking (symbols__shrink(), dso__shrink(),
> >   dsos__shrink(), perf_session__shrink()) triggered on allocation failu=
re via
> >   session-scoped allocation wrappers, plus transparent DSO reload prese=
rving
> >   retained symbol pointers (Patches 12-18).
> >
> > v1: https://lore.kernel.org/lkml/20260928075237.3055101-1-irogers@googl=
e.com/
> >
> > Assisted-by: Antigravity:gemini-3.1-pro
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> So Sashiko failed to apply the patches (local Sashiko runs were clean)
> because I had these four patches applied locally:
>  - Alireza's "perf symbols: Fix broken ELF_C_READ_MMAP fallback guard"
>    https://lore.kernel.org/linux-perf-users/20261005-perf-symbol-memory-s=
end-v5-1-165dceb2b049@uber.com/
>  - My fixes in "perf: Fix libdw addr2line fallback, pr_debugN
> overhead, and cumulative hist decay"
>    https://lore.kernel.org/linux-perf-users/cover.1792995775.git.irogers@=
google.com/
>
> Hopefully the patches above won't take too long to land, so I'll hold
> off sending v3 until then.
>
> Thanks,
> Ian
>
> > Ian Rogers (18):
> >   perf bench internals: Add symbols and maps benchmarks
> >   perf demangle: Add fast-path prefix checks for Rust and Java
> >     demanglers
> >   perf symbol: Add accessor functions for struct symbol fields
> >   perf map_browser: Compute symbol browser index on demand
> >   perf db-export: Store symbol database IDs in a hashmap
> >   perf annotate: Move struct annotation to a hashmap and remove
> >     symbol_conf.priv_size
> >   perf symbol: Switch backing storage from rbtree to struct symbols
> >     array
> >   perf symbol: Add reference counting and DECLARE_RC_STRUCT(symbol)
> >   perf symbol: Optimize symbol sorting with natural-run merge sort and
> >     binary insertion
> >   perf maps: Optimize tail insertion and small-append sorting
> >   perf symbol-elf: Cache ELF program/section headers and defer symbol
> >     name lookup
> >   perf rwsem: Add down_read_trylock() and down_write_trylock()
> >   perf vdso: Constify dso parameter in dso__is_vdso()
> >   perf machine: Protect machines->guests rbtree with a rw_semaphore
> >   perf symbol: Add memory shrinking for symbols, DSOs, and machines
> >   perf session: Add dso__session() and session-scoped allocation
> >     wrappers
> >   perf symbol: Use session allocation wrappers in symbol, DSO, thread,
> >     and hist paths
> >   perf test symbols: Add tests for symbol shrinking and session alloc
> >     wrappers
> >
> >  tools/perf/Documentation/perf-bench.txt       |    6 +
> >  .../arch/powerpc/util/skip-callchain-idx.c    |    2 +-
> >  tools/perf/arch/powerpc/util/sym-handling.c   |   40 +-
> >  tools/perf/bench/Build                        |    2 +
> >  tools/perf/bench/bench.h                      |    2 +
> >  tools/perf/bench/maps.c                       |  186 +++
> >  tools/perf/bench/symbols.c                    |  239 +++
> >  tools/perf/builtin-annotate.c                 |   22 +-
> >  tools/perf/builtin-bench.c                    |    2 +
> >  tools/perf/builtin-c2c.c                      |   14 -
> >  tools/perf/builtin-diff.c                     |    4 +-
> >  tools/perf/builtin-kallsyms.c                 |    9 +-
> >  tools/perf/builtin-kmem.c                     |   82 +-
> >  tools/perf/builtin-kwork.c                    |    4 +-
> >  tools/perf/builtin-lock.c                     |   25 +-
> >  tools/perf/builtin-mem.c                      |    2 +-
> >  tools/perf/builtin-report.c                   |   14 -
> >  tools/perf/builtin-sched.c                    |    6 +-
> >  tools/perf/builtin-script.c                   |   18 +-
> >  tools/perf/builtin-timechart.c                |    2 +-
> >  tools/perf/builtin-top.c                      |   24 +-
> >  tools/perf/builtin-trace.c                    |   23 +-
> >  tools/perf/tests/builtin-test.c               |    1 -
> >  tools/perf/tests/dlfilter-test.c              |   12 +-
> >  tools/perf/tests/dwarf-unwind.c               |    2 +-
> >  tools/perf/tests/hists_common.c               |    9 +-
> >  tools/perf/tests/hists_cumulate.c             |    8 +-
> >  tools/perf/tests/hists_filter.c               |   10 +-
> >  tools/perf/tests/hists_link.c                 |   16 +-
> >  tools/perf/tests/hists_output.c               |    9 +-
> >  tools/perf/tests/kallsyms-split.c             |    5 +-
> >  tools/perf/tests/maps.c                       |   58 +
> >  tools/perf/tests/pe-file-parsing.c            |    1 +
> >  tools/perf/tests/symbols.c                    |  454 +++++-
> >  tools/perf/tests/vmlinux-kallsyms.c           |  187 ++-
> >  tools/perf/ui/browser.c                       |    3 +
> >  tools/perf/ui/browsers/annotate.c             |   10 +-
> >  tools/perf/ui/browsers/hists.c                |   35 +-
> >  tools/perf/ui/browsers/map.c                  |   88 +-
> >  tools/perf/ui/gtk/annotate.c                  |    6 +-
> >  tools/perf/ui/stdio/hist.c                    |    6 +-
> >  tools/perf/util/addr2line.c                   |    8 +-
> >  tools/perf/util/addr_location.c               |    4 +
> >  .../perf/util/annotate-arch/annotate-alpha.c  |    5 +-
> >  .../perf/util/annotate-arch/annotate-arm64.c  |   12 +-
> >  .../util/annotate-arch/annotate-loongarch.c   |   15 +-
> >  tools/perf/util/annotate-arch/annotate-s390.c |    6 +-
> >  tools/perf/util/annotate-arch/annotate-x86.c  |   14 +-
> >  tools/perf/util/annotate-data.c               |   12 +-
> >  tools/perf/util/annotate.c                    |  211 ++-
> >  tools/perf/util/annotate.h                    |    6 +-
> >  tools/perf/util/auxtrace.c                    |  111 +-
> >  tools/perf/util/block-info.c                  |   12 +-
> >  tools/perf/util/bpf_lock_contention.c         |   35 +-
> >  tools/perf/util/c2c-function.c                |   32 +-
> >  tools/perf/util/call-path.c                   |   15 +-
> >  tools/perf/util/callchain.c                   |   23 +-
> >  tools/perf/util/capstone.c                    |   22 +-
> >  tools/perf/util/data-convert-json.c           |    4 +-
> >  tools/perf/util/db-export.c                   |   99 +-
> >  tools/perf/util/db-export.h                   |    8 +
> >  tools/perf/util/debug.c                       |    3 +-
> >  tools/perf/util/demangle-java.c               |   23 +-
> >  tools/perf/util/disasm.c                      |   69 +-
> >  tools/perf/util/dlfilter.c                    |   12 +-
> >  tools/perf/util/dso.c                         |  257 ++-
> >  tools/perf/util/dso.h                         |   94 +-
> >  tools/perf/util/dsos.c                        |   76 +
> >  tools/perf/util/dsos.h                        |    3 +
> >  tools/perf/util/event.c                       |   12 +-
> >  tools/perf/util/evsel_fprintf.c               |    2 +-
> >  tools/perf/util/hist.c                        |   70 +-
> >  tools/perf/util/intel-pt.c                    |   74 +-
> >  tools/perf/util/libbfd.c                      |   14 +-
> >  tools/perf/util/libdw.c                       |    5 +-
> >  tools/perf/util/llvm.c                        |    8 +-
> >  tools/perf/util/lock-contention.c             |    8 +-
> >  tools/perf/util/machine.c                     |  189 ++-
> >  tools/perf/util/machine.h                     |    9 +
> >  tools/perf/util/map.c                         |   27 +-
> >  tools/perf/util/map.h                         |   18 +-
> >  tools/perf/util/map_symbol.c                  |    4 +-
> >  tools/perf/util/maps.c                        |  284 +++-
> >  tools/perf/util/mutex.h                       |    3 +
> >  tools/perf/util/probe-event.c                 |  148 +-
> >  tools/perf/util/python.c                      |   36 +-
> >  tools/perf/util/rwsem.c                       |   20 +
> >  tools/perf/util/rwsem.h                       |    2 +
> >  tools/perf/util/session.c                     |   78 +
> >  tools/perf/util/session.h                     |    8 +
> >  tools/perf/util/sort.c                        |   47 +-
> >  tools/perf/util/srcline.c                     |   22 +-
> >  tools/perf/util/symbol-elf.c                  |  311 +++-
> >  tools/perf/util/symbol.c                      | 1438 +++++++++++++----
> >  tools/perf/util/symbol.h                      |  187 ++-
> >  tools/perf/util/symbol_conf.h                 |    1 -
> >  tools/perf/util/symbol_fprintf.c              |   37 +-
> >  tools/perf/util/thread-stack.c                |   18 +-
> >  tools/perf/util/threads.c                     |   17 +-
> >  tools/perf/util/unwind-libdw.c                |    4 +-
> >  tools/perf/util/unwind-libunwind.c            |    2 +-
> >  tools/perf/util/vdso.c                        |    2 +-
> >  tools/perf/util/vdso.h                        |    2 +-
> >  103 files changed, 4557 insertions(+), 1389 deletions(-)
> >  create mode 100644 tools/perf/bench/maps.c
> >  create mode 100644 tools/perf/bench/symbols.c
> >
> > --
> > 2.56.0.313.g2479322e68-goog
> >
