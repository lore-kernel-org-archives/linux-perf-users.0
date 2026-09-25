Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E140BCB8
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367652; cv=pass; b=EN+IlGDPHRwM8vn/V6+Id2mp6GTBsS2HIi7V2B7HZjYzH7S8+vbIC6pUoXWUuAEAMw7MbjFq3JeYFoOrOmvo8rDMKJCwuKebGlZnS+YTls/1+Zyqv9v6YtIdi99TpU4JUEeyVtqGG5Edcs+ONgNvqLzRE5g4ZDP8Pa8uQV31G6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367652; c=relaxed/simple;
	bh=ntdvCfc1Y5/sPC6UOT9tkk623bqjbzk7ppMuSWDFXEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wv/TVKxodBCP2l95dfcv6KdjuK8ktUgi/kSKJBxlcpW+JXPg2tuah/7U2t9MjPIMIkfAhRRTA2jZdMqDGGmIPxEw/jgZ4TeBJ9YmaNaTKIzYViV1PC3xFJUmJv94WAKbTGRpJgpTle+DaiLYLT3fclymgN73eu9rJOUWxhjJU6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llNN9Wjz; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llNN9Wjz"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53113d72966so25401cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 13:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790367650; cv=none;
        d=google.com; s=arc-20260327;
        b=R7nG6fcQhEJ/zFyt5Cf3kIMUMIVPHaQ2bORtHUmgaX2d1YdyttFFl1MeUOtnMLhkv9
         L+diW6EWEW75CdcqBO91l3Reux8mQatS2A+OJr9iZmvHSAg25hNgz961byB/4JRLk3aw
         x9cgKcTKTJvQidrwxLMxdZzTQtNBBOHMpJThZlQO42e15H4C1cq7TL8shLQ1LEPcSdOP
         wyKbOcM4Xub9ZHmc6doq1W3o0P3vLcK7r8mGNvvF2rkCLWZUraGV3NNXkmyZhXbrkU3l
         Gsle8rCnkohR5EUI3Dut+HK1RNSUHDBim21hyLcTTvt7xhO/QLMe++OVVPEI9myZZlh7
         kOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9UAR/4keNWxLSi4t1vjjVFho1evIXjZioXSXvU/VZYg=;
        fh=FgAgTb9/T4eyVfC5qu0dmy21WUDWWoXjlQKLz0M8Ix0=;
        b=Czs59dbKtaz8MPj6bdnVm9SRM7wnqzImHG99p8CKzEAgtoUniGc3YnrEPod6cHlGC9
         Mf+6gPCY9DJKMr5lTWMh/Cq6FXNMokT0Ysn5c2VJMDNKvlpfC8zQ1xtoFmhBZwoAbepP
         1NDzaX819jECjX5ymyGCUugXo3RZWBl2ldYHpQQVKEWEd+QnBFaGC/IvlA8Kk2iRyv6x
         sAWjz2KhqftiTbF7VPfice3xXXJoV9uXgJvrFpYTQvKGi2j5On9zIce+TsgdI7rgPZFd
         N4siIr42NWRCZtCI0EFA7WIJiT5gTNiZXR+DR5a71jm83IjsTLDAbJDIxP3B4bWOma7E
         O67Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790367650; x=1790972450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9UAR/4keNWxLSi4t1vjjVFho1evIXjZioXSXvU/VZYg=;
        b=llNN9Wjzyrs21mqOvEQvZw/jXc7UkwFajPloxsArT9Lu6oU9efmtdCEo7vpu9obpld
         y2pBFNyiH2oeUPG39eYYVJ+ep3OMw82qWUabPh6/4y5X+YEGIweVwmwTsue4Rrx37PgK
         AOfP9sFYuVkKaHK3L+LTH5RjnI2Y3CzyMrmjtMvr5yephjrN4dsZboGwny/Qbnm7ahyU
         /QiTRy7Hvx/30mTy+gc3BNGjm5mWfJRqNcwL0O2wRknvek3eRY0fmYZm5Zi6X0cbfyDv
         8TWwb4ykh4euDeXqR5YuTp3Q58BVxdAij8C6/JibYEJwYbSLnJBbMuahGRTqgw34mgd+
         ksSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790367650; x=1790972450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UAR/4keNWxLSi4t1vjjVFho1evIXjZioXSXvU/VZYg=;
        b=GQuqXyrgF3m7DQqKjqgBiCSt7BZes+I9zTLJImB1oD4lf3fWIJN53xdLbnfuPAA4vM
         qFthhwzAmrPXy4xvHc4QAyeO7PwKAwjco3FGUR4vOsIuEqXxavSln9o+G/6vrmobFstK
         eRKuNE8a/TinXBg4dEpf2NDnQHixqTM7cz+AIFO/O/PbAUKRUQXw3+FRhmc5WFHULWwO
         uc10gcM/EKZVXlfBl7gYdWpJpmQqFBm6DJEfSPooBHsYDAAtVK5cMQnrO8Q6o9ktTwI7
         2bYVPkXHrq+0vUnS6d88f+l8JgTmGwG13z8fNT1nIQYGINJhas2oxeLsK5l6kuaa+UEb
         yt8A==
X-Forwarded-Encrypted: i=1; AKwUvBwaGcxv7kzlTPv8XZOt3XQXOQf+acw95oEc60dfnoypt6vTXcEFeJfhMVvQaUCHAcDlGvDnLdFZtoVXYgsk3wkG@vger.kernel.org
X-Gm-Message-State: AFuF++mFc5yxhO8Y1X1qvZgL1gQYArdrzN02eP2GJ9pcepdaevwtt7WH
	Tk1eY3LqJFkCEW3nNjnWkcSUor4iijvl94ZPiWRkZJsv2sbK9XlVPdfBhWiQXFkKKpfZIvIXNhD
	7X134o7qNd6XjhrS05go6lROezpFkveq6BbPnRhIv
X-Gm-Gg: AYBFou3ZKMY1b4qOha1+yDNWnHPXoKqs2UbXhtjArgrAdAWZ5+M9mMOEFhLHQJlKgVc
	3JmhJHD7++Ma3O0kPI/XdYuD4GDDaMM9vdoCiz5E2U3mNOBSsTKNhXo1d8DBsamlbE11SDBSKND
	S6UJ13i68jPvqMFO/A49h6vvIkSD9uvyRWlbzxvLKSbXO5X+ANWGcvQRoHUaoCaGToAJXQEyalv
	i55jRA/kGTCq/5jl8ICBW6jFiIAUV9ab2RoYBtwN3eCmIhaUCYVJoRnju9AfS7XaJMR4aIMAiNY
	K+rzzuetY8Dtbs9CK918HPyEytAjvsePIq1HMYsaVvxgTVoq+InxNwM9y88Mg8sAqGnXoWaC2tH
	DaW5l1e8oEA==
X-Received: by 2002:a05:622a:304:b0:532:eff8:3491 with SMTP id
 d75a77b69052e-5332017dac0mr3342871cf.14.1790367649498; Fri, 25 Sep 2026
 13:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com>
In-Reply-To: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 13:20:38 -0700
X-Gm-Features: AclHuK__5EL3z5lGL9iU2gLgFQUrPkWD2Krp0skWq8IhbjJj5TJ3lxNdTCO7P3U
Message-ID: <CAP-5=fWLp5c9HYZ6oTsfPhWprz3uMTT=mt3M-OVu8GEjzSpEww@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] perf script: Bounded and lazy symbol loading
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 12:15=E2=80=AFPM Alireza Haghdoost via B4 Relay
<devnull+haghdoost.uber.com@kernel.org> wrote:
>
> perf script loads the entire ELF symbol table of every DSO that appears
> in a sample, allocating each symbol into an rb-tree held until process
> exit. Therefore, a large enough profile turns symbol loading into an
> OOM kill. This does not scale to profiling a large cgroup with many large
> binaries on a production system with limited free memory.
>
> This series adds two independent, opt-in mechanisms, a leading
> regression fix, and two preparatory patches:
>
>   [1/6] Fix a broken "#ifdef ELF_C_READ_MMAP" guard so perf actually
>         mmaps ELF files instead of malloc'ing section data. This is a
>         standalone regression fix for 22dd1ac91a77.
>
>   [2/6] Let a DSO read its data from one explicit file through the DSO
>         data cache. This fixes the split-debuginfo case where offsets fro=
m
>         the debuginfo file would be applied to the runtime image.
>
>   [3/6] Factor duplicate-symbol selection so it works on symbol
>         attributes rather than struct symbol. No functional change.
>
>   [4/6] --max-symbol-bytes <size>: a byte budget on struct symbol
>         allocations (and the lazy index) enforced at the ELF symbol
>         loader, degrading to [unknown] with a warning past the cap.
>         An unbounded profile doesn't just risk OOM-killing itself. It
>         also forces memory pressure on the whole host, pushing the kernel
>         to reclaim from co-located latency-sensitive processes. Capping
>         it lets the user bound that footprint up front and choose the
>         trade-off explicitly.
>
>   [5/6] --lazy-load-symbols: build a compact per-DSO sorted index and
>         resolve only the sampled addresses, reading names through the DSO
>         data cache at lookup time. On the production fixture, peak RssAno=
n
>         drops from 265 MiB to 39 MiB (6.8x) and wall time from 3.1 s to
>         1.85 s (1.7x). Memory optimizations usually cost time; this one
>         does not because lazy loading skips a lot of calloc and demangle
>         calls.
>
>   [6/6] Shell and unit tests for both options.
>
> Lazy loading handles the common userspace ELF symtab/dynsym path. Eager
> loading remains available for dense coverage and for PPC64 .opd and
> .gnu_debugdata.

So currently we have a symbol as:
```
/**
 * A symtab entry. When allocated this may be preceded by an annotation (se=
e
 * symbol__annotation) and/or a browser_index (see symbol__browser_index).
 */
struct symbol {
        struct rb_node  rb_node;
        /** Range of symbol [start, end). */
        u64             start;
        u64             end;
        /** Length of the string name. */
        u16             namelen;
        _Atomic uint16_t flags;
        /** Architecture specific. Unused except on PPC where it holds
st_other. */
        u8              arch_sym;
        /** The name of length namelen associated with the symbol. */
        char            name[];
};
```
and the struct rb_node is a significant size cost:
```
struct rb_node {
        unsigned long  __rb_parent_color;
        struct rb_node *rb_right;
        struct rb_node *rb_left;
} __attribute__((aligned(sizeof(long))));
```

A sorted array of symbols would only require 1 pointer per entry,
saving 2 words. The array could reside in the "symbols" variable
passed around something like this:
```
struct symbols {
        struct rw_semaphore lock;
        struct symbol **symbols;
        unsigned int cnt;
        unsigned int allocated;
        bool sorted;
};
```
This is basically what we do with struct dso and dsos. With a struct
symbols we can add a lock and ensure operations are appropriately
synchronized. On top of this we can build lazy symbol resolution. For
the bounded memory size, I'd prefer something like a reference count
in every symbol (which uses one word we previously saved). We can
periodically scan the symbols array for symbols with a reference count
of 1 and then lower that count, knowing it is safe to release the
symbol's memory because no other thread is referencing it. This would
avoid having symbols appear as "[unknown]". We should really have a
similar scan of the dsos to free up their memory.

If we have a reference count then symbol__annotation and
symbol__browser_index can reference a symbol rather than using
container_of.

I think the patches 4 and 5 do the core work, but they introduce some
warts that I wish didn't have to exist. How do you feel about
reference counting? To avoid reference count leaks we adding a
checking framework that is documented here:
https://perfwiki.github.io/main/reference-count-checking/

Thanks,
Ian








> Changes in v3:
>
> - Rebase onto current perf-tools-next.
> - Pick up Namhyung's Reviewed-by for patch 1.
> - Split the exact-path DSO data support into its own patch (2/6), with a
>   DSO data test for reading and reopening through an explicit path.
> - Move the duplicate-selection refactor into a preparatory patch (3/6)
>   and factor the whole lazy alias-group handling (traversal, demangling,
>   IFUNC propagation, compaction) into one helper.
> - Keep struct symbol::namelen as u16. Charge symbol bytes from the stored
>   namelen on both allocation and free, and drop the 64 KiB-name test.
> - Fix lazy-loading races reported by Sashiko: in lazy mode, address
>   lookups always take the DSO lock, and building the name-sorted array
>   materializes and frees the lazy index even when the budget truncates
>   it, so the name array is never invalidated. dso__reset_symbol_names()
>   is gone. Add a concurrent budget-truncation test.
> - In lazy mode, when no PT_LOAD covers a symbol and its section is NOBITS
>   in the debuginfo file, adjust with the runtime section header as eager
>   loading does. Add a lazy/eager symbol parity test and a split-debuginfo
>   shell test that exercises this path.
> - Keep each unit test with the code it needs (DSO data in 2/6, budget
>   reservation in 4/6); the other tests stay in 6/6.
>
> Link: https://lore.kernel.org/all/20260919-perf-symbol-memory-send-v2-0-4=
95b8f00ad7c@uber.com/
>
> Changes in v2:
>
> - Replace direct pread() name reads with the exact symbol source's DSO da=
ta
>   cache, preserving split-debuginfo offsets and descriptor reopen behavio=
r.
> - Drop the byte-identical-output claim and retain eager loading for PPC64
>   .opd and .gnu_debugdata.
> - Make the symbol budget atomic and strict, account complete name lengths=
,
>   accept a bare 0 as unlimited, and keep partial zero-sized ranges from
>   covering omitted symbols.
> - Align lazy lookup with eager duplicate and IFUNC selection, PLT clippin=
g,
>   and name-sorted materialization.
> - Move option documentation into the feature patches. Add unit and shell
>   coverage for cache reopen, truncated names, budget truncation, and skip
>   handling.
>
> Link: https://lore.kernel.org/all/20260915-perf-symbol-memory-send-v1-0-1=
d3360e21f07@uber.com/
> ---
> Alireza Haghdoost (6):
>       perf symbols: Fix broken ELF_C_READ_MMAP fallback guard
>       perf dso: Allow reading DSO data from an explicit file
>       perf symbols: Factor out duplicate symbol selection
>       perf script: Add --max-symbol-bytes to bound ELF symbol memory
>       perf script: Add --lazy-load-symbols for lazy symbol loading
>       perf test: Test lazy symbol loading and symbol memory limits
>
>  tools/perf/Documentation/perf-script.txt           |  26 +
>  tools/perf/arch/powerpc/util/sym-handling.c        |   6 +-
>  tools/perf/builtin-script.c                        |  44 ++
>  tools/perf/tests/Build                             |   1 +
>  tools/perf/tests/builtin-test.c                    |   1 +
>  tools/perf/tests/dso-data.c                        |  42 ++
>  .../tests/shell/lazy_load_symbols_split_debug.sh   | 113 ++++
>  tools/perf/tests/shell/script_lazy_load_symbols.sh | 278 ++++++++
>  .../tests/shell/script_lazy_load_symbols_skip.sh   |  26 +
>  tools/perf/tests/symbol-bytes.c                    | 599 +++++++++++++++=
++
>  tools/perf/tests/tests.h                           |   1 +
>  tools/perf/util/dso.c                              |  60 +-
>  tools/perf/util/dso.h                              |  47 ++
>  tools/perf/util/map.c                              |  19 +-
>  tools/perf/util/symbol-elf.c                       | 728 +++++++++++++++=
+++++-
>  tools/perf/util/symbol-minimal.c                   |  16 +
>  tools/perf/util/symbol.c                           | 143 +++-
>  tools/perf/util/symbol.h                           |  30 +-
>  tools/perf/util/symbol_conf.h                      |   2 +
>  19 files changed, 2133 insertions(+), 49 deletions(-)
> ---
> base-commit: edd8a9fe2eca009599e013a29c421c7a6b5ad1b9
> change-id: 20260915-perf-symbol-memory-send-e7cfca1ac3d9
>
> Best regards,
> --
> Alireza Haghdoost <haghdoost@uber.com>
>
>
