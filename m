Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946FD4E1C83
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609893; cv=pass; b=dhWcYV13K6A8+ezfe0NtpaJP3bbFuSLKTqcbZGqMmiGKobueyO8J2kK0uOB0ExF2UfWpTMv09uTDghVtc3ee5MDkulpH5wAkXtD+vhzdQ8epsTKULIL0b+eRzklwcpQvLsnZ84IGG7x8VNEOkYTJ4swFnNMnYmDrNcrntnUEp/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609893; c=relaxed/simple;
	bh=8Y9bbTn89w8VoXCyYlqZIwJfpguKgWY9CQcyUG1iN5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bb6JUiaoyNYYZrEH3s7YMJKMCCkkzPwPpsm1lNIad5CMGM5LJwo38437fuC8bXeyXevUOUMaxJo9Rj1NPFTyijyG5d2hBjwyVwUixj1aMKcL6JNgoPeNYXfiwDCyHeHrnLi6qP2bcIY9mBktXqI7HGQzsJeBYaV0D/4qtjCiAdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PVI+xkh6; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PVI+xkh6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d8facae850so95385ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790609890; cv=none;
        d=google.com; s=arc-20260327;
        b=NXL8Qg+O9XVN+nrGu9BYYAlg1vOUjHeInlkygH2687XD5nj0lnhyf32gkBTjzkpTFx
         gEKQKM5XeGqje30Ac/ayHNVb5r4eWGyHcAD+yYOKcsn6eQswPFzdp7VDugkHAkEYlQmV
         EnmT27kzSt1qmAnQ0so4bhPbSWr7KyUzEsz2AruIjxyPrpbj4FRHSCAqeVhBy4Z0A3iC
         OqaPKnPus+CllzTU5jW9kT+xs9ad/RRq+IQ8/aXglCZtVygrulJb5Yr8T5PCJyCHmwPd
         L9ojsnHNVSJLQmA6vCrU+8u5bqyx3mpZE5jc2lNu9rgJu6JcdYtCkP9HW34PPV8Pbew6
         4fNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9IpxaLdV3Hbxl/0CC3MiHKCbcwhbCd+rmtf5QzXGbpM=;
        fh=I1dYvxSdOVkbp4WImSRZrzBqeLs3ASKYXYhnqqMp72A=;
        b=MbTna2XC0ZsqhCLmzFuwXRdPCl2VbBVFis9RFk8LMCrPxV9EHXbeYtX1KPBMDazE3G
         67kTAolRc+NRUlXmuPyEZwLWibQCvin5AZHgG6uCQmLRNLxJtwgdgNaCGKtSUPxUWuOr
         iI/F4N7mkVQg+yG/K+2RkwdS7TwW4pXcOL0NQpGuKswYU0ly4XEKOnVb1T7OvzuVsMgs
         Ne2of6CAdcPeO/yecx3RFdeHHVopA/jUrhppYtWlM1laXTon9rhFZ2f8vm5NbKfxaUMY
         B1LN9nKp+4VtqpaIj9WHL2uj7pbTToDAiaC8nbDt2K+4aK7cezMDoFxZavqmSjP963Ci
         AoJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790609890; x=1791214690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9IpxaLdV3Hbxl/0CC3MiHKCbcwhbCd+rmtf5QzXGbpM=;
        b=PVI+xkh68DyzhaMHz9dpe0CGcAqH993SBHM4UPw2MtoM05QsKpSdNHLz9QU5wFNKbM
         5XQHPeX5TJH1iDsz0abNpgs7ulrVFgSEvpO0uedsbk0F7Q7sIUKVEol6ItGt2oDEebZX
         +rJUMJ8JOpCtIG2EDYK8A4/vb067nvoRCcpQhAI7mTaV5mMOeLliyvtmDwrAiksH4+ca
         BKLs0HbMHlGHCfdvx/pR5w3trzJW2bbMqoanuxQB9LcfbD2u4vOm2pFbBMjnTcz8MUGc
         ehz2R3O/Q/M2HgfEnGkHQQfLxKZX3mI7mxTqXT8OXl5U8u+TxSiwKQIyf5e08MC3XysO
         LSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609890; x=1791214690;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9IpxaLdV3Hbxl/0CC3MiHKCbcwhbCd+rmtf5QzXGbpM=;
        b=XrrnJXwBy1TtLXPg6PBhgKMB37Aig2n7kwe7V6YqoAzEw3Y8S/JD1+Pv8W48vgcjWd
         2vWU60qazqx1D/q2snY36Wu4klyDTf8wl/zd3Jst9rjrWhzPO0po1b7sGk5p9ilA8P6I
         YFSeTv2MM812gyLTIoM0bDhF61zqRmmu0Ov3EtX9PTBCtfnK62e+pO0AQxtWRY9dmv3c
         ZmnA9XN3aS/wBBqm2lVBmqFBjH/4d6heSb4Mb8OC3Csu3W2GlW5xwwHhdKCPUEZKRXgL
         zv6JrGYay9VZRk0opmLF2eaMjOBhO/TvVt5NcSpp7131iC40+USCviae7nXMa6MAttla
         0AQA==
X-Forwarded-Encrypted: i=1; AKwUvBwxYlEj2Am6/AtCsyWS6FC2KSjitm399UyYfglIZZjmNKRfXnwQgvToDpqjwaxz8fRc0hZaK+P09nwFjRWRO0Gr@vger.kernel.org
X-Gm-Message-State: AFq9FYL7evBEeMQS+bOFODJTAlubbaQMtrjuOwMliWH8UiTuMATYlvsE
	QKW9Byhl4upGubBF6BanAGSu8GCkDx2xHR/Cxs+T6kupas6/Jf8XKWRTmMwDsuN80chczs27EtF
	GgGkWb11ZjolQdlCfnI+RLTmlq7Mjt2/y+ziy7Gcw
X-Gm-Gg: AYBFou0rRY3gYUvE4SViPN5rpe/zGnYcTPwLX0nX5EfqxDX/nUsdv4kMqJ63FmMtcB1
	b0Mp97aeyXJ41D+GfNL1byCBANW5Gul94WKMsmJwsIYWsONIQmezwuN/7ucopj1kpjTotHHcqYc
	1k4XF+oMX4WLisjvVxY4wU9tEPhLxlVjRqf+9RQfhMt+o+v7MmD0n/qAbZ9wgYxDUmsAJrCqgu+
	cG/aGaKH2a+HlgXfcEuZOMKDmO6mF4RlFod7XAImL4ovwLDfkV5kD3ADBKmGVvB2VK2DQZLuNTV
	1anI9nGTb+AZlsgPHyX7inv5OZ6Lwzt63CD1TebF4Eh0POTr9fnkS3Xh1RvK8/2VhMcaahzaYDv
	igPM2JUi9
X-Received: by 2002:a17:902:c946:b0:2c9:b404:b55 with SMTP id
 d9443c01a7336-2dfa6159052mr7100275ad.6.1790609889150; Mon, 28 Sep 2026
 08:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com>
In-Reply-To: <20260928075237.3055101-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 08:37:56 -0700
X-Gm-Features: AclHuK-d92ythp_cLUL7Z9I6ZrXnOiXu0iQR3T_Q_FdXXAli3u4X2IMcS-wm2UA
Message-ID: <CAP-5=fUZ7+N-91iNVsq2Y_K_pCOAq+NNeey_r_a07jefbGuXdw@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] perf symbol: Reference counting, flat array
 storage, and LRU shrinking
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alireza Haghdoost <haghdoost@uber.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:52=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> This series modernizes struct symbol memory management and backing storag=
e in
> tools/perf to support reference counting (DECLARE_RC_STRUCT(symbol)) and
> periodic LRU memory shrinking during long or large profiling sessions:
>
> 1. Field accessors (Patch 1): Introduces inline getters/setters for
>    struct symbol fields across tools/perf in preparation for wrapping
>    struct symbol with DECLARE_RC_STRUCT(symbol).
> 2. Remove negative-offset private allocations (Patch 2): Replaces
>    symbol_conf.priv_size and symbol__priv() negative-offset allocations i=
n
>    util/annotate.c and util/db-export.c with hashmaps keyed by symbol
>    pointer (struct annotated_symbol protected by an rw_semaphore, and
>    sym_db_ids on struct db_export).
> 3. Flat sorted array backing storage (Patch 3): Replaces the dual
>    address-sorted and name-sorted red-black trees (rb_node) in struct dso
>    with a struct symbols container backed by dynamically sorted flat arra=
ys
>    protected by struct rw_semaphore (util/rwsem.h) with Clang thread-safe=
ty
>    annotations. Saves 48 bytes per struct symbol (two rb_nodes) and provi=
des
>    cache-friendly binary search (bsearch) and callback-based iteration.
> 4. Reference counting and DECLARE_RC_STRUCT(symbol) (Patch 4): Wraps
>    struct symbol with DECLARE_RC_STRUCT(symbol) and adds refcount_t refcn=
t
>    along with symbol__get(), symbol__put(), and symbol__zput(). Lookup
>    functions return a counted reference acquired under symbols->lock, and
>    lifetime holders (addr_location, map_symbol, hist_entry, call_path,
>    block_info, disasm_line, thread_stack, db_export, etc.) properly
>    manage symbol references.
> 5. LRU memory shrinking (Patch 5): Adds an accessed bit to struct dso
>    and implements symbols__shrink(), dso__shrink_symbols(), dsos__shrink(=
),
>    machine__shrink(), and machines__shrink(). Unreferenced symbols (refcn=
t =3D=3D 1)
>    in cold DSOs are reclaimed, and shrunken DSOs transparently reload on =
demand
>    via dso__load() while preserving live symbols and their RC_STRUCT(symb=
ol)
>    identity.
> 6. Periodic session shrinking (Patch 6): Hooks machines__shrink() into
>    perf_session event processing so long-running sessions periodically re=
claim
>    cold symbols and DSOs.
> 7. Unit tests (Patch 7): Adds unit tests in tools/perf/tests/symbols.c
>    covering symbol reference counting, symbols__shrink() retention of act=
ive
>    symbols, dsos__shrink() two-pass LRU clock behavior, and on-demand rel=
oad
>    preserving live symbol identity.

This needs a rebase to after the changes to the python integration,
hence no Sashiko reviews. I'll do that asap.

Thanks,
Ian

> Ian Rogers (7):
>   perf symbol: Add accessor functions for struct symbol fields
>   perf symbol: Remove symbol_conf.priv_size and negative-offset
>     allocations
>   perf symbol: Switch backing storage from rbtree to struct symbols
>     array
>   perf symbol: Add reference counting and DECLARE_RC_STRUCT(symbol)
>   perf symbol: Add LRU memory shrinking for symbols, DSOs, and machines
>   perf session: Periodically shrink symbols and DSOs during event
>     processing
>   perf test symbols: Add tests for symbol and DSO LRU shrinking
>
>  .../arch/powerpc/util/skip-callchain-idx.c    |   2 +-
>  tools/perf/arch/powerpc/util/sym-handling.c   |  40 +-
>  tools/perf/builtin-annotate.c                 |  15 +-
>  tools/perf/builtin-c2c.c                      |  14 -
>  tools/perf/builtin-diff.c                     |   5 +-
>  tools/perf/builtin-kallsyms.c                 |  10 +-
>  tools/perf/builtin-kmem.c                     |  66 +-
>  tools/perf/builtin-kwork.c                    |   4 +-
>  tools/perf/builtin-lock.c                     |  27 +-
>  tools/perf/builtin-mem.c                      |   2 +-
>  tools/perf/builtin-report.c                   |  14 -
>  tools/perf/builtin-sched.c                    |   6 +-
>  tools/perf/builtin-script.c                   |  18 +-
>  tools/perf/builtin-timechart.c                |   2 +-
>  tools/perf/builtin-top.c                      |  29 +-
>  tools/perf/builtin-trace.c                    |  12 +-
>  tools/perf/tests/builtin-test.c               |   1 -
>  tools/perf/tests/dlfilter-test.c              |  12 +-
>  tools/perf/tests/dwarf-unwind.c               |   2 +-
>  tools/perf/tests/hists_common.c               |   4 +-
>  tools/perf/tests/hists_cumulate.c             |   8 +-
>  tools/perf/tests/hists_filter.c               |  10 +-
>  tools/perf/tests/hists_link.c                 |  16 +-
>  tools/perf/tests/hists_output.c               |   9 +-
>  tools/perf/tests/kallsyms-split.c             |   5 +-
>  tools/perf/tests/pe-file-parsing.c            |   1 +
>  tools/perf/tests/symbols.c                    | 289 +++++-
>  tools/perf/tests/vmlinux-kallsyms.c           | 191 ++--
>  tools/perf/ui/browsers/annotate.c             |  11 +-
>  tools/perf/ui/browsers/hists.c                |  17 +-
>  tools/perf/ui/browsers/map.c                  |  87 +-
>  tools/perf/ui/gtk/annotate.c                  |   7 +-
>  tools/perf/ui/stdio/hist.c                    |   6 +-
>  tools/perf/util/addr_location.c               |   4 +
>  .../perf/util/annotate-arch/annotate-alpha.c  |   2 +-
>  .../util/annotate-arch/annotate-loongarch.c   |   8 +-
>  tools/perf/util/annotate-arch/annotate-s390.c |   2 +-
>  tools/perf/util/annotate-arch/annotate-x86.c  |  14 +-
>  tools/perf/util/annotate-data.c               |  14 +-
>  tools/perf/util/annotate.c                    | 211 ++++-
>  tools/perf/util/annotate.h                    |   6 +-
>  tools/perf/util/auxtrace.c                    | 111 ++-
>  tools/perf/util/block-info.c                  |  13 +-
>  tools/perf/util/bpf_lock_contention.c         |  39 +-
>  tools/perf/util/c2c-function.c                |  25 +-
>  tools/perf/util/call-path.c                   |  15 +-
>  tools/perf/util/callchain.c                   |  19 +-
>  tools/perf/util/capstone.c                    |  21 +-
>  tools/perf/util/data-convert-json.c           |   4 +-
>  tools/perf/util/db-export.c                   |  76 +-
>  tools/perf/util/db-export.h                   |   6 +
>  tools/perf/util/debug.c                       |   3 +-
>  tools/perf/util/disasm.c                      |  57 +-
>  tools/perf/util/dlfilter.c                    |  12 +-
>  tools/perf/util/dso.c                         | 236 +++--
>  tools/perf/util/dso.h                         |  85 +-
>  tools/perf/util/dsos.c                        | 100 +++
>  tools/perf/util/dsos.h                        |  12 +-
>  tools/perf/util/event.c                       |  12 +-
>  tools/perf/util/evsel_fprintf.c               |   2 +-
>  tools/perf/util/hist.c                        |  30 +-
>  tools/perf/util/intel-pt.c                    |  74 +-
>  tools/perf/util/libbfd.c                      |   5 +-
>  tools/perf/util/libdw.c                       |   5 +-
>  tools/perf/util/llvm.c                        |   6 +-
>  tools/perf/util/lock-contention.c             |   8 +-
>  tools/perf/util/machine.c                     | 143 ++-
>  tools/perf/util/machine.h                     |   2 +
>  tools/perf/util/map.c                         |  53 +-
>  tools/perf/util/map.h                         |  18 +-
>  tools/perf/util/map_symbol.c                  |   4 +-
>  tools/perf/util/maps.c                        |   3 +-
>  tools/perf/util/probe-event.c                 | 135 +--
>  tools/perf/util/python.c                      |  20 +-
>  .../util/scripting-engines/trace-event-perl.c |   8 +-
>  .../scripting-engines/trace-event-python.c    |  38 +-
>  tools/perf/util/session.c                     |  31 +
>  tools/perf/util/session.h                     |  13 +
>  tools/perf/util/sort.c                        |  44 +-
>  tools/perf/util/srcline.c                     |  19 +-
>  tools/perf/util/symbol-elf.c                  |  22 +-
>  tools/perf/util/symbol.c                      | 845 ++++++++++++------
>  tools/perf/util/symbol.h                      | 203 ++++-
>  tools/perf/util/symbol_conf.h                 |   1 -
>  tools/perf/util/symbol_fprintf.c              |  14 +-
>  tools/perf/util/thread-stack.c                |  18 +-
>  tools/perf/util/threads.c                     |  17 +-
>  tools/perf/util/unwind-libdw.c                |   4 +-
>  tools/perf/util/unwind-libunwind.c            |   2 +-
>  89 files changed, 2644 insertions(+), 1192 deletions(-)
>
> --
> 2.56.0.rc1.315.gc6ed9934b7-goog
>
