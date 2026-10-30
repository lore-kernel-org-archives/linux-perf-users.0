Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793376671;
	b=E6el72n9IvCg+ffvps4qRO4zUhRG6gVrvnqQSjyaUJ/d8S+ZOYfBJfuRmmaYRHFW5R98
	 YdinPRsDv651ueA4EHB+9Lqt2RQzDDIYk1iQEHet4JZsI/acIcf7Iukp2RGFPo/mcgw92
	 jcyzE8RidjADzfRgA3NKZaIjSQRRFfYgLall2Ka83cQ/vOh+T2EkoVUmW0aoq8mszXA7n
	 yihA5jl8iyKyrL+Yl7DyePc9f+mSBaMb1LTyy930lCQ2tj03yuY/yDqWZ55N6lkJepxg7
	 vMIz+LK3T5EoLf0vtby0PPkpbfq3TTPt1LPhNXZ6v2Dqc2kMXY8gLzjsfqAxWSLmwvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TNjsSFlLDJVVFoW1snuBxdG9MIhom6SgtqfBIIBH38k=;
	b=nisHISCC7NEg9m5oatxYtnphFnZDr3bEWejDvFu+PWzMSGvdRYGScHAk/7xf1wxcOj2Y
	 QGNE9QUsFkuRN78U8pafggAnKV9IycW7cge1WyKGQ1L6S3PlcwkDZ2XAh4VRH8sKJTFQy
	 XY60dEwFQitWo+sNCDC8Ql/GmTNcWE0aZ3glYlGxiJ/04fJ/rmvqxn81iDx+j9J2YftKk
	 iPZoZiX2wONfj4ux8GUY3zSYJHTrUYpSc0hZQZr1OSvqVXRMEdxRsCUhRWJLSauj3xamE
	 KG6HJHCUs/ZKVf32WAKHruYRFc36nFyRiPFd1K9fYY518gNYZK6Igax2rmeZSjqynrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eFD5hT7H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C36606A31F
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 16:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13C36606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eFD5hT7H
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533202fe429so384991cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 09:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793376669; cv=none;
        d=google.com; s=arc-20260327;
        b=lxpsw4sTHs1ELoBmo56jJpEehKxoam1adWvqRCeyCqJEQe4FWytyPjD05pZAZ8W35l
         OCxY1wZNGdpbK/7NE3TMNLpK5XuhS4hLDYwBbIoi9dh99n3FTFbQmrbZ/yjCrORdmWUb
         Er8NPQNsfGZIUYqdAWDv43I/9Sik1eiRkOOfAY7iZ3Yfsl8F16vnciXPZPhpIMfBoReM
         5/AX83iqAiqDTKxzAR1DNC4eQbqbqqLUp+QAMpn5jFu7NSKyiRdWSoljdvPkcf70rW/m
         iFSb0gU/QOJWhyZCJrZEzWhIeL1RqAfvAqdkfEqZ8h8QmOlq4WXWwsSGU3MpC1BWlzco
         nxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TNjsSFlLDJVVFoW1snuBxdG9MIhom6SgtqfBIIBH38k=;
        fh=TW3UnjYHqlTgNBZoOlDyf4/R2mJ0iIdW8Ci0J0kI4ag=;
        b=X83yRA6fvtDkP20n52/6Z3Mp7VkKCBGEwFzV5fFEz7IsviTSuoDmlAnJehltcUto2w
         FFP/uQyZBdAoLnNjRJ8L4efCQwkvbXz5vJOHGkqylOk+AlMyCIWRPjB/anupf7Vtsd6o
         Vr6w9IGxobaKi5M6Yr3qHxWY8jo2+1U7csf3dI9AReqzzkG+Ah/6lKrb/wLa0r3LvQfn
         ueOFi6OK/CUajRXMP0ZKXPb8pYPSy4/+7D5QLh1YDSU06WEkb3IDxvFlu/kPUQhfO5Vk
         90z8m7oEnuwbfygAXQzO+RB3XO581EN53etpbw8eJs/CnmLvKbt8g192LW8U04nWwFLm
         xNiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793376669; x=1793981469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNjsSFlLDJVVFoW1snuBxdG9MIhom6SgtqfBIIBH38k=;
        b=eFD5hT7H335oGYikO3Hdrc6RKKtkQjBQr+Nwqujr2/Uubx8PEw7zHF0F9HbvJLk8EG
         eZM5ozLJbp54K831PhLeXJQ9onUm7d9J0cwzdCKuGq57klLwEgoUCx1fQBg+w2dzsm6k
         3doTNWvJVnGh/BR/PNDb15Sg4wFJeYMMqaEEgsrvEtdtTiHOYew6yIHOMVHxoT7mPBsC
         dPI5493A0U+qc2hjsqMxoFCYJ2IYZB1DYRg4p7bVRR9PNEe28vK1PkQXcy08waHX8SQk
         VHKH1U5bDozEUre4Pwq2bgRiS/ZpOb+jiioJ1jJxSYss1wwxkTC7wzN72wESLUiIh5lD
         9o9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793376669; x=1793981469;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNjsSFlLDJVVFoW1snuBxdG9MIhom6SgtqfBIIBH38k=;
        b=Xa+G/GgmrL1od/vQ3MC7tfRb/kjenIuw36GQ71slRO2QKLCin79ONSfsdkbLG/3OW5
         s61zy+i1xsUvcffSy80tUeNGYA5UMpbCqLFZQmPszsgNLfrI/n6RSR8XpaCjd1FDE42n
         frs2V2SGO5vkfNB8cBsgcBysekzfRjevdMIWTVW4lw60LkDHvkrdhwRwbz6dEa47JKFr
         1qHe/fYcp3Vg6RmsdnlvqsN0pqkAzTH9StmBLIzu9ooh5vGujZ1NHV8O6yXMS9ByGkk5
         k+qbOHAza8b8C7avAefwixzQow5ikD+y+nPUZ9rMrNG7z5yGgTSj0GNsDLo5WBr1tO0R
         YYbA==
X-Forwarded-Encrypted: i=1; AKwUvByo7/7+Ryp2JK8hOr99j1KK5hJS9UqnZrt7nnOPQiJu/Kntd+aXSAv12ptqX3rORuUZvdVQ1VKhHuzoOZiIgr6x@vger.kernel.org
X-Gm-Message-State: AFq9FYJXNriezb/nIGV1YLGR03QjKT7ZUSzYUferc0b54sFwG4qYs8Wh
	UtoWrtHjQkHzyoVX4GdOx79o1Am3eccgroC1LbiQaH/Q0g6rk+D1cisY9/oZkebW5FWMc/EaWAT
	XuKITJbjSwvfrwdwIBWkFU6r+nrGy9SW8uLOX0AvD
X-Gm-Gg: AYBFou2GtJtUBzOhEa6mb8ivZYNbSQmJw+uEcv8OTnjbuSaBT5ASvUWozV3jN9sCt9z
	oQSraDXYwSGafAt5iQkzqrb9lavx1HFPnI8dkXTgWxcEVC7b7UglXNjmASjaH8U6wITOzwid7vR
	1vfmO3hR795PF/UTPGtRpmyuBKb9EjmTyDrbcVk7GW8KdmU6KXH65SvoaDIVrPeNNCztQkExpE+
	kTs6aAvx+i/SIRLpd+FhMWLCcrw+RmNTbJpM7BNgzr9gle7VaqPoWB3zgUNjlPOhJIwliJx0T4Z
	WWQEuAUH4969TVTl+QpEvuHHeYIeXBiivgoLqljGiv5QHEdR2/yqFg3TzWwKzKvhF6f5qeyfsum
	nuQ6h//m+yy9yUVT7DYggYGOmhAWM+XLlosstzkJzL5mrK7frP7vErMTspKrv3k/dC/VWgd6xFE
	KAePAA1LobEuwR
X-Received: by 2002:a05:622a:6109:b0:534:d386:c3f1 with SMTP id
 d75a77b69052e-5414d92c144mr41174701cf.9.1793376667874; Fri, 30 Oct 2026
 09:11:07 -0700 (PDT)
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
 <CAP-5=fUpji7seZpsxh0BN05oAA6nMUyM-bNdHBg4YfkeNAT00A@mail.gmail.com> <CA+w=M=TEYScc9rDyzthN75Ym41ATXoNLNu8_yj0dsjymb+m7jA@mail.gmail.com>
In-Reply-To: <CA+w=M=TEYScc9rDyzthN75Ym41ATXoNLNu8_yj0dsjymb+m7jA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Oct 2026 09:10:55 -0700
X-Gm-Features: AclHuK9mYlj6JWLUlYT46kZJqTJgbbCSdV353JDG4HSi8P7MAJB-qJKEJ-L-gyw
Message-ID: <CAP-5=fX211V8=NCWyr9btd7=hbBB=oiMDETxCDdVr49idP13Fw@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] perf symbol: Reference counting, sorted arrays,
 and memory shrinking
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 7:02=E2=80=AFAM Alireza Haghdoost <haghdoost@uber.c=
om> wrote:
>
> Hi Ian,
>
> I applied v2 on perf-tools-next e74880764bf9 with the ELF_C_READ_MMAP
> fix and your three fixes, and compared it with the same tree without
> the 18 patches. I posted comments are on the individual patches; this is =
the
> summary.
>
> On a profile of a large C++ service, about 1M symbols, perf script and pe=
rf r
> eport output is byte-identical and roughly 22-32% faster:
>
> Execution time and peak RSS before and after:
> perf script                                3.3s 334 MiB vs 2.25s 332 MiB
> perf report --sort dso,sym       3.0s 389 MiB vs 2.25s 386 MiB
> perf report --children -g caller 4.6s 706 MiB vs 3.60s 703 MiB
>
> Peak RSS barely moves. sizeof(struct symbol) goes from 48 to 32 bytes,
> but the address array adds a pointer per symbol back, so the net is
> about 8 bytes per symbol before malloc rounding. That is under 1%
> here.

Thanks for your work and running the numbers! I think we should aim to
land your lazy loading patches ahead of these patches. The merge
conflicts don't look like they'll be too terrible, wdyt?

Since the merge window for Linux v7.4 is currently open, I don't see
anything landing before November 1st. So I can do a v3 incorporating
your suggestions and rebase it on top of your patches when they land.
I'll work on pulling out the fixes (you highlighted some you thought
were particularly worthwhile) to mail for v7.4 for now.

Thanks,
Ian

> Thanks
> Alireza
>
> On Wed, Oct 28, 2026 at 1:29=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Tue, Oct 27, 2026 at 4:15=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > When profiling large binaries or long-running workloads with many DSO=
s and
> > > threads, symbol and DSO tables frequently dominate perf's memory foot=
print
> > > and startup latency. Currently `struct symbol` has several structural
> > > limitations:
> > >
> > > 1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
> > >    `dso->symbols` address rbtree, plus an optional negative-offset
> > >    allocation prefix (`symbol_conf.priv_size`) for TUI browser indice=
s,
> > >    `db-export` IDs, or `struct annotation` state even when only a tin=
y
> > >    fraction of symbols are ever annotated or exported.
> > > 2. Unlike `struct map`, `struct dso`, and `struct thread`, `struct sy=
mbol`
> > >    is not reference-counted: once loaded into a `struct dso`, symbols=
 can
> > >    never be safely evicted while `hist_entry`, `callchain_cursor_node=
`, or
> > >    `map_symbol` references exist, and `dso__symbols()` has no interna=
l
> > >    synchronization against concurrent readers/writers.
> > > 3. ELF symbol table loading (`dso__load_sym_internal()`) repeatedly
> > >    invokes `libelf` section/program header lookups per symbol, calls
> > >    `elf_sym__name()` before filtering out non-function/non-allocated
> > >    symbols, runs Rust/Java demanglers on plain C symbols without fast=
-path
> > >    prefix checks, and resorts `dso->symbols` with `qsort()` even when=
 ELF
> > >    symbol tables are already largely ordered in ascending address run=
s.
> > >
> > > This series modernizes `struct symbol` to match the rest of `tools/pe=
rf/util`
> > > (`DECLARE_RC_STRUCT`, `struct rw_semaphore`, sorted pointer arrays) a=
nd
> > > introduces symbol/DSO memory shrinking and faster ELF symbol loading:
> > >
> > > - Patch 1 adds `perf bench internals symbols` and `perf bench interna=
ls maps`
> > >   to benchmark ELF symbol loading, bulk symbol insertion/sorting/look=
up,
> > >   incremental symbol appends, ascending map insertion, and incrementa=
l map
> > >   appends.
> > > - Patch 2 adds fast-path prefix checks in `dso__demangle_sym()` (befo=
re
> > >   calling `rust_demangle_demangle()`, keeping `demangle-rust-v0.c`
> > >   unmodified relative to upstream `rustc-demangle`) and in
> > >   `java_demangle_sym()`.
> > > - Patches 3-6 encapsulate `struct symbol` field access behind accesso=
r
> > >   functions (annotated with `__attribute__((nonnull))`) and replace t=
he
> > >   negative-offset `symbol_conf.priv_size` allocation prefix with on-d=
emand
> > >   browser index calculation and per-DSO/per-exporter hashmaps for
> > >   `db-export` and `struct annotation`.
> > > - Patch 7 replaces `dso->symbols` (`rb_root_cached`) and `dso->symbol=
_names`
> > >   with a locked `struct symbols` container backed by sorted pointer a=
rrays
> > >   (`symbols` and `symbols_by_name`) protected by a `struct rw_semapho=
re`,
> > >   removing `struct rb_node` from `struct symbol`.
> > > - Patch 8 wraps `struct symbol` in `DECLARE_RC_STRUCT(symbol)` with
> > >   `refcount_t` (`symbol__get()` / `symbol__put()` / `symbol__zput()`)=
 for
> > >   sanitizer-checked reference counting across `map_symbol`, `addr_loc=
ation`,
> > >   `hist_entry`, `callchain`, `thread_stack`, and `db-export`.
> > > - Patch 9 replaces `qsort()` in `struct symbols` with a natural-run m=
erge
> > >   sort and galloping merge (taking advantage of pre-ordered runs in
> > >   `.symtab`/`.dynsym` and `kallsyms`) plus an in-place binary inserti=
on
> > >   fast path for small incremental appends.
> > > - Patch 10 applies the same incremental binary-insertion sort and an =
O(1)
> > >   tail-insertion fast path to `struct maps` for `/proc/<pid>/maps` sy=
nthesis
> > >   and runtime `PERF_RECORD_MMAP2` / JIT map insertions.
> > > - Patch 11 caches ELF program and section headers during
> > >   `dso__load_sym_internal()`, defers `elf_sym__name()` string table l=
ookups
> > >   until after symbol filtering, and runs `symbols__fixup_end()` /
> > >   `symbols__fixup_duplicate()` once per DSO load.
> > > - Patches 12-17 add `down_read_trylock()` / `down_write_trylock()`, p=
rotect
> > >   `machines->guests` with a `rw_semaphore`, implement `symbols__shrin=
k()`,
> > >   `dso__shrink()`, `dsos__shrink()`, and `perf_session__shrink()` (wi=
th
> > >   transparent on-demand reload in `dso__load()` that preserves pointe=
r
> > >   identity for retained symbols), and provide `perf_session__malloc()=
` /
> > >   `zalloc()` / `calloc()` / `realloc()` / `strdup()` wrappers that
> > >   automatically shrink unreferenced symbols and DSOs on allocation fa=
ilure.
> > > - Patch 18 adds unit tests in `perf test symbols` covering sorted sym=
bol
> > >   insertion, symbol/DSO shrinking, transparent DSO reload after shrin=
k, and
> > >   session allocation wrappers.
> > >
> > > End-to-end benchmark results across the series:
> > >
> > >   perf bench internals symbols (perf binary):
> > >     Average DSO load + sort:      7.348 msec ->   5.324 msec (-27.5%)
> > >     Average DSO memory usage:        1401 KB ->      1308 KB ( -6.6%)
> > >     Average bulk insert + lookup: 1453.95 us -> 1161.00 us   (-20.1%)
> > >     Average append + lookup (200 interior inserts into 10,000 symbols=
):
> > >       rbtree: 42.85 us -> array+qsort: 40429.75 us -> array+binary-in=
sert: 152.70 us
> > >
> > >   perf bench internals symbols -b libLLVM.so.21.1:
> > >     Average DSO load + sort:     81.196 msec ->  62.582 msec (-22.9%)
> > >     Average DSO memory usage:        9530 KB ->      9164 KB ( -3.8%)
> > >
> > >   perf bench internals symbols -b libLLVM.so.21.1 --no-demangle:
> > >     Average DSO load + sort:     32.675 msec ->  19.122 msec (-41.5%)
> > >     Average DSO memory usage:        7589 KB ->      7229 KB ( -4.7%)
> > >
> > >   perf bench internals maps:
> > >     Average ascending insert + lookup:   63.37 us -> 58.97 us ( -6.9%=
)
> > >     Average append + lookup:           7477.45 us -> 96.67 us (-98.7%=
, 77.3x faster)
> > >
> > > Net performance and memory trade-offs:
> > > - Replacing the per-symbol rbtree (`struct rb_node`) and negative-off=
set
> > >   `symbol_conf.priv_size` allocation prefix with a contiguous sorted =
pointer
> > >   array reduces per-symbol heap overhead by 16 to 24+ bytes (saving 3=
.8% to
> > >   6.6% of total DSO symbol table heap memory unconditionally, and all=
owing
> > >   unreferenced symbols and DSOs to be shrunk on demand under memory
> > >   pressure).
> > > - For the dominant symbol workloads=E2=80=94loading ELF binaries (`-2=
2.9%` to
> > >   `-41.5%`) and bulk symbol insertion, sorting, and lookup (`-20.1%`)=
=E2=80=94the
> > >   contiguous array, natural-run merge sort, ELF header caching, and
> > >   demangler fast paths yield substantial speedups over the rbtree bas=
eline.
> > > - For synthetic single-symbol interior insertions interleaved with im=
mediate
> > >   lookups into an already-large 10,000-symbol DSO (`dso__insert_symbo=
l()`),
> > >   an rbtree rotation takes ~0.21 us/op (`42.85 us` for 200 ops) where=
as
> > >   shifting the contiguous pointer array tail with `memmove()` after b=
inary
> > >   search takes ~0.76 us/op (`152.70 us` for 200 ops, down from `40429=
.75 us`
> > >   with naive `qsort()`). In real workloads, symbols are either loaded=
 in
> > >   bulk (`dso__load()`) or inserted into small per-prog BPF/JIT DSOs w=
here
> > >   the array fits in a few cache lines, making this sub-microsecond
> > >   difference negligible in practice.
> > > - Overall, the series reduces memory consumption across all workloads=
 while
> > >   significantly improving=E2=80=94or remaining neutral on=E2=80=94run=
time performance.
> > >
> > > v2:
> > > - Rebased onto perf-tools-next (dropping "perf symbols: Fix broken
> > >   ELF_C_READ_MMAP fallback guard", which was merged upstream, and spl=
itting
> > >   "perf libdw: Optimize fallback logic for missing DWARF" into a sepa=
rate
> > >   fixes series).
> > > - Added 'perf bench internals symbols' and 'perf bench internals maps=
'
> > >   benchmarks (Patch 1) and included before/after numbers in the optim=
ization
> > >   patches.
> > > - Added __attribute__((nonnull)) annotations to struct symbol accesso=
r
> > >   functions (Patch 3).
> > > - Split the symbol_conf.priv_size removal patch into three separate p=
atches
> > >   for map_browser (Patch 4), db-export (Patch 5), and annotate (Patch=
 6).
> > > - Added dedicated optimization patches for Rust/Java demangler prefix=
 checks
> > >   (Patch 2), natural-run merge sort and binary insertion in struct sy=
mbols
> > >   (Patch 9), tail-insertion and incremental binary-insertion sort in =
struct
> > >   maps (Patch 10), and ELF program/section header caching and deferre=
d
> > >   symbol name lookup (Patch 11).
> > > - Replaced periodic heuristic LRU shrinking and windowed ELF symbol l=
oading
> > >   with on-demand shrinking (symbols__shrink(), dso__shrink(),
> > >   dsos__shrink(), perf_session__shrink()) triggered on allocation fai=
lure via
> > >   session-scoped allocation wrappers, plus transparent DSO reload pre=
serving
> > >   retained symbol pointers (Patches 12-18).
> > >
> > > v1: https://lore.kernel.org/lkml/20260928075237.3055101-1-irogers@goo=
gle.com/
> > >
> > > Assisted-by: Antigravity:gemini-3.1-pro
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > So Sashiko failed to apply the patches (local Sashiko runs were clean)
> > because I had these four patches applied locally:
> >  - Alireza's "perf symbols: Fix broken ELF_C_READ_MMAP fallback guard"
> >    https://lore.kernel.org/linux-perf-users/20261005-perf-symbol-memory=
-send-v5-1-165dceb2b049@uber.com/
> >  - My fixes in "perf: Fix libdw addr2line fallback, pr_debugN
> > overhead, and cumulative hist decay"
> >    https://lore.kernel.org/linux-perf-users/cover.1792995775.git.iroger=
s@google.com/
> >
> > Hopefully the patches above won't take too long to land, so I'll hold
> > off sending v3 until then.
> >
> > Thanks,
> > Ian
> >
> > > Ian Rogers (18):
> > >   perf bench internals: Add symbols and maps benchmarks
> > >   perf demangle: Add fast-path prefix checks for Rust and Java
> > >     demanglers
> > >   perf symbol: Add accessor functions for struct symbol fields
> > >   perf map_browser: Compute symbol browser index on demand
> > >   perf db-export: Store symbol database IDs in a hashmap
> > >   perf annotate: Move struct annotation to a hashmap and remove
> > >     symbol_conf.priv_size
> > >   perf symbol: Switch backing storage from rbtree to struct symbols
> > >     array
> > >   perf symbol: Add reference counting and DECLARE_RC_STRUCT(symbol)
> > >   perf symbol: Optimize symbol sorting with natural-run merge sort an=
d
> > >     binary insertion
> > >   perf maps: Optimize tail insertion and small-append sorting
> > >   perf symbol-elf: Cache ELF program/section headers and defer symbol
> > >     name lookup
> > >   perf rwsem: Add down_read_trylock() and down_write_trylock()
> > >   perf vdso: Constify dso parameter in dso__is_vdso()
> > >   perf machine: Protect machines->guests rbtree with a rw_semaphore
> > >   perf symbol: Add memory shrinking for symbols, DSOs, and machines
> > >   perf session: Add dso__session() and session-scoped allocation
> > >     wrappers
> > >   perf symbol: Use session allocation wrappers in symbol, DSO, thread=
,
> > >     and hist paths
> > >   perf test symbols: Add tests for symbol shrinking and session alloc
> > >     wrappers
> > >
> > >  tools/perf/Documentation/perf-bench.txt       |    6 +
> > >  .../arch/powerpc/util/skip-callchain-idx.c    |    2 +-
> > >  tools/perf/arch/powerpc/util/sym-handling.c   |   40 +-
> > >  tools/perf/bench/Build                        |    2 +
> > >  tools/perf/bench/bench.h                      |    2 +
> > >  tools/perf/bench/maps.c                       |  186 +++
> > >  tools/perf/bench/symbols.c                    |  239 +++
> > >  tools/perf/builtin-annotate.c                 |   22 +-
> > >  tools/perf/builtin-bench.c                    |    2 +
> > >  tools/perf/builtin-c2c.c                      |   14 -
> > >  tools/perf/builtin-diff.c                     |    4 +-
> > >  tools/perf/builtin-kallsyms.c                 |    9 +-
> > >  tools/perf/builtin-kmem.c                     |   82 +-
> > >  tools/perf/builtin-kwork.c                    |    4 +-
> > >  tools/perf/builtin-lock.c                     |   25 +-
> > >  tools/perf/builtin-mem.c                      |    2 +-
> > >  tools/perf/builtin-report.c                   |   14 -
> > >  tools/perf/builtin-sched.c                    |    6 +-
> > >  tools/perf/builtin-script.c                   |   18 +-
> > >  tools/perf/builtin-timechart.c                |    2 +-
> > >  tools/perf/builtin-top.c                      |   24 +-
> > >  tools/perf/builtin-trace.c                    |   23 +-
> > >  tools/perf/tests/builtin-test.c               |    1 -
> > >  tools/perf/tests/dlfilter-test.c              |   12 +-
> > >  tools/perf/tests/dwarf-unwind.c               |    2 +-
> > >  tools/perf/tests/hists_common.c               |    9 +-
> > >  tools/perf/tests/hists_cumulate.c             |    8 +-
> > >  tools/perf/tests/hists_filter.c               |   10 +-
> > >  tools/perf/tests/hists_link.c                 |   16 +-
> > >  tools/perf/tests/hists_output.c               |    9 +-
> > >  tools/perf/tests/kallsyms-split.c             |    5 +-
> > >  tools/perf/tests/maps.c                       |   58 +
> > >  tools/perf/tests/pe-file-parsing.c            |    1 +
> > >  tools/perf/tests/symbols.c                    |  454 +++++-
> > >  tools/perf/tests/vmlinux-kallsyms.c           |  187 ++-
> > >  tools/perf/ui/browser.c                       |    3 +
> > >  tools/perf/ui/browsers/annotate.c             |   10 +-
> > >  tools/perf/ui/browsers/hists.c                |   35 +-
> > >  tools/perf/ui/browsers/map.c                  |   88 +-
> > >  tools/perf/ui/gtk/annotate.c                  |    6 +-
> > >  tools/perf/ui/stdio/hist.c                    |    6 +-
> > >  tools/perf/util/addr2line.c                   |    8 +-
> > >  tools/perf/util/addr_location.c               |    4 +
> > >  .../perf/util/annotate-arch/annotate-alpha.c  |    5 +-
> > >  .../perf/util/annotate-arch/annotate-arm64.c  |   12 +-
> > >  .../util/annotate-arch/annotate-loongarch.c   |   15 +-
> > >  tools/perf/util/annotate-arch/annotate-s390.c |    6 +-
> > >  tools/perf/util/annotate-arch/annotate-x86.c  |   14 +-
> > >  tools/perf/util/annotate-data.c               |   12 +-
> > >  tools/perf/util/annotate.c                    |  211 ++-
> > >  tools/perf/util/annotate.h                    |    6 +-
> > >  tools/perf/util/auxtrace.c                    |  111 +-
> > >  tools/perf/util/block-info.c                  |   12 +-
> > >  tools/perf/util/bpf_lock_contention.c         |   35 +-
> > >  tools/perf/util/c2c-function.c                |   32 +-
> > >  tools/perf/util/call-path.c                   |   15 +-
> > >  tools/perf/util/callchain.c                   |   23 +-
> > >  tools/perf/util/capstone.c                    |   22 +-
> > >  tools/perf/util/data-convert-json.c           |    4 +-
> > >  tools/perf/util/db-export.c                   |   99 +-
> > >  tools/perf/util/db-export.h                   |    8 +
> > >  tools/perf/util/debug.c                       |    3 +-
> > >  tools/perf/util/demangle-java.c               |   23 +-
> > >  tools/perf/util/disasm.c                      |   69 +-
> > >  tools/perf/util/dlfilter.c                    |   12 +-
> > >  tools/perf/util/dso.c                         |  257 ++-
> > >  tools/perf/util/dso.h                         |   94 +-
> > >  tools/perf/util/dsos.c                        |   76 +
> > >  tools/perf/util/dsos.h                        |    3 +
> > >  tools/perf/util/event.c                       |   12 +-
> > >  tools/perf/util/evsel_fprintf.c               |    2 +-
> > >  tools/perf/util/hist.c                        |   70 +-
> > >  tools/perf/util/intel-pt.c                    |   74 +-
> > >  tools/perf/util/libbfd.c                      |   14 +-
> > >  tools/perf/util/libdw.c                       |    5 +-
> > >  tools/perf/util/llvm.c                        |    8 +-
> > >  tools/perf/util/lock-contention.c             |    8 +-
> > >  tools/perf/util/machine.c                     |  189 ++-
> > >  tools/perf/util/machine.h                     |    9 +
> > >  tools/perf/util/map.c                         |   27 +-
> > >  tools/perf/util/map.h                         |   18 +-
> > >  tools/perf/util/map_symbol.c                  |    4 +-
> > >  tools/perf/util/maps.c                        |  284 +++-
> > >  tools/perf/util/mutex.h                       |    3 +
> > >  tools/perf/util/probe-event.c                 |  148 +-
> > >  tools/perf/util/python.c                      |   36 +-
> > >  tools/perf/util/rwsem.c                       |   20 +
> > >  tools/perf/util/rwsem.h                       |    2 +
> > >  tools/perf/util/session.c                     |   78 +
> > >  tools/perf/util/session.h                     |    8 +
> > >  tools/perf/util/sort.c                        |   47 +-
> > >  tools/perf/util/srcline.c                     |   22 +-
> > >  tools/perf/util/symbol-elf.c                  |  311 +++-
> > >  tools/perf/util/symbol.c                      | 1438 +++++++++++++--=
--
> > >  tools/perf/util/symbol.h                      |  187 ++-
> > >  tools/perf/util/symbol_conf.h                 |    1 -
> > >  tools/perf/util/symbol_fprintf.c              |   37 +-
> > >  tools/perf/util/thread-stack.c                |   18 +-
> > >  tools/perf/util/threads.c                     |   17 +-
> > >  tools/perf/util/unwind-libdw.c                |    4 +-
> > >  tools/perf/util/unwind-libunwind.c            |    2 +-
> > >  tools/perf/util/vdso.c                        |    2 +-
> > >  tools/perf/util/vdso.h                        |    2 +-
> > >  103 files changed, 4557 insertions(+), 1389 deletions(-)
> > >  create mode 100644 tools/perf/bench/maps.c
> > >  create mode 100644 tools/perf/bench/symbols.c
> > >
> > > --
> > > 2.56.0.313.g2479322e68-goog
> > >
