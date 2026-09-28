Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF5440A3C
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581972; cv=none; b=Cni5q+XoTVw29grA+zoXvbIZ6tlCPGgHm9yQ3zb5Q8t7Le+2X5JbTxjUuTnPzUE9J0BNUrx91vjadjupZViUQEbbR46mHGPpU1SET7dVuTp0ZSgRQEvgooOIKTY1S40+oVfbRXdgkEbsFga5jOaT5wlgvCBQDLxlkbHOSyP5H4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581972; c=relaxed/simple;
	bh=hf45zLQY/y/TbwPuxkgI7dG+6Qg2PnSHjHkgFxPMSbQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=OVEZU52lZygOy5iivh9LpxokmRniuE6o2/fy5N2W1YmjEXmBhmKNqHVat4VgjPKFaSoH3L0wUlQWJOOqVsNTummHLDE5WfoExQ6H2lAEyOfa1CM2A4D07vzqKlpMWVeKUuJqJ8Z2QQJhGt6mC54OxlZ0kUvbP0z6sGKk1Oyt4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXhk3C9F; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXhk3C9F"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1431ba79941so2400496c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790581970; x=1791186770; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B4tdTICCl/+vjJl3IWfNL5LCVaqwjaR/BVOD7v7SkYg=;
        b=tXhk3C9F89rB7O85/vGjsl1Ew8D3Zahf9YddMtD9hYqg9MMjANDgNWvDQEM0ZrEFe2
         LmyXuJ+Z9v/CH7Ju8ZpRWSmqkH5XFlGRj9N+rFEAVn8vCMIgMxR+SeVR6tQUs8MwSF07
         UMZYYw5+RhoeO1Tvr/nb9ySRr7afwy8bDJy9s0pQXjUA6VFvgZpmGDTMOGeb5sX+6YH0
         UVXJYFl39vBwg6GynsQ7glxJc0dUASRSputenZxuBLrl/oPHW7WNruKVkx7yBcKS+WgG
         Px2Kpqnr7qaK1xYb6I1DnrmmMYjnCg4qVtAOy0dF/RNpLEp0UviA00xiCY5ki0h8wlge
         GWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581970; x=1791186770;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B4tdTICCl/+vjJl3IWfNL5LCVaqwjaR/BVOD7v7SkYg=;
        b=sKtGjJ9BmxJHR8wl156qF+hZSlEy+GykFXpQ6nMrc9gYXl0mLr8t4+BXVs8jEr4zT2
         bAK6YOna9FhyrE3XVBqlLEVz4JisfbHUZFt04V4AUePVPVN+6QOFhG0j49cA5mgZyxBC
         o9xRinAct6GGomw63ERw2lsfXqeodPMrOFgND1E5XNAPjsxwKf7OYkG0HzRlB782j9wR
         MXuGm74YsXI5z12XtQnheC+9N8Tnot3448/gwIPvRawtr/yK0+iQeQ+gVmQLwjSWSD6X
         u3mdmWW2kFcFFBuUCfzGRS8PPyTa8wO4/FLYE/JSkwBAob5+QqZomh1ak1Md4nUmfpg6
         SU/A==
X-Forwarded-Encrypted: i=1; AKwUvByqtmb/GQLhklWe6pVQ0MwYHSlGFbukDDGf2R5qQKJZvRqDvujNKYztOm0E9RjbD0CXbhvkUh40SWqFH5bZo6Lg@vger.kernel.org
X-Gm-Message-State: AFuF++lgT+CxqV82YBUyeNWYMaLOh1wcnJOA10lY+SkK/pgABSK31u0C
	pTnyYwinSReW2zePIt4OOwlQMxSTpeGCrNYZxIjh3/0jGlf83+aixW9RuLcCKnl5Tjdnk7ut4DT
	VTAWq+07tCw==
X-Received: from dlx9.prod.google.com ([2002:a05:7022:89:b0:144:cdf0:6a43])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4186:10b0:143:5c63:23a1
 with SMTP id a92af1059eb24-146ce680185mr9350679c88.19.1790581969739; Mon, 28
 Sep 2026 00:52:49 -0700 (PDT)
Date: Mon, 28 Sep 2026 00:52:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928075237.3055101-1-irogers@google.com>
Subject: [PATCH v1 0/7] perf symbol: Reference counting, flat array storage,
 and LRU shrinking
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alireza Haghdoost <haghdoost@uber.com>
Content-Type: text/plain; charset="UTF-8"

This series modernizes struct symbol memory management and backing storage in
tools/perf to support reference counting (DECLARE_RC_STRUCT(symbol)) and
periodic LRU memory shrinking during long or large profiling sessions:

1. Field accessors (Patch 1): Introduces inline getters/setters for
   struct symbol fields across tools/perf in preparation for wrapping
   struct symbol with DECLARE_RC_STRUCT(symbol).
2. Remove negative-offset private allocations (Patch 2): Replaces
   symbol_conf.priv_size and symbol__priv() negative-offset allocations in
   util/annotate.c and util/db-export.c with hashmaps keyed by symbol
   pointer (struct annotated_symbol protected by an rw_semaphore, and
   sym_db_ids on struct db_export).
3. Flat sorted array backing storage (Patch 3): Replaces the dual
   address-sorted and name-sorted red-black trees (rb_node) in struct dso
   with a struct symbols container backed by dynamically sorted flat arrays
   protected by struct rw_semaphore (util/rwsem.h) with Clang thread-safety
   annotations. Saves 48 bytes per struct symbol (two rb_nodes) and provides
   cache-friendly binary search (bsearch) and callback-based iteration.
4. Reference counting and DECLARE_RC_STRUCT(symbol) (Patch 4): Wraps
   struct symbol with DECLARE_RC_STRUCT(symbol) and adds refcount_t refcnt
   along with symbol__get(), symbol__put(), and symbol__zput(). Lookup
   functions return a counted reference acquired under symbols->lock, and
   lifetime holders (addr_location, map_symbol, hist_entry, call_path,
   block_info, disasm_line, thread_stack, db_export, etc.) properly
   manage symbol references.
5. LRU memory shrinking (Patch 5): Adds an accessed bit to struct dso
   and implements symbols__shrink(), dso__shrink_symbols(), dsos__shrink(),
   machine__shrink(), and machines__shrink(). Unreferenced symbols (refcnt == 1)
   in cold DSOs are reclaimed, and shrunken DSOs transparently reload on demand
   via dso__load() while preserving live symbols and their RC_STRUCT(symbol)
   identity.
6. Periodic session shrinking (Patch 6): Hooks machines__shrink() into
   perf_session event processing so long-running sessions periodically reclaim
   cold symbols and DSOs.
7. Unit tests (Patch 7): Adds unit tests in tools/perf/tests/symbols.c
   covering symbol reference counting, symbols__shrink() retention of active
   symbols, dsos__shrink() two-pass LRU clock behavior, and on-demand reload
   preserving live symbol identity.

Ian Rogers (7):
  perf symbol: Add accessor functions for struct symbol fields
  perf symbol: Remove symbol_conf.priv_size and negative-offset
    allocations
  perf symbol: Switch backing storage from rbtree to struct symbols
    array
  perf symbol: Add reference counting and DECLARE_RC_STRUCT(symbol)
  perf symbol: Add LRU memory shrinking for symbols, DSOs, and machines
  perf session: Periodically shrink symbols and DSOs during event
    processing
  perf test symbols: Add tests for symbol and DSO LRU shrinking

 .../arch/powerpc/util/skip-callchain-idx.c    |   2 +-
 tools/perf/arch/powerpc/util/sym-handling.c   |  40 +-
 tools/perf/builtin-annotate.c                 |  15 +-
 tools/perf/builtin-c2c.c                      |  14 -
 tools/perf/builtin-diff.c                     |   5 +-
 tools/perf/builtin-kallsyms.c                 |  10 +-
 tools/perf/builtin-kmem.c                     |  66 +-
 tools/perf/builtin-kwork.c                    |   4 +-
 tools/perf/builtin-lock.c                     |  27 +-
 tools/perf/builtin-mem.c                      |   2 +-
 tools/perf/builtin-report.c                   |  14 -
 tools/perf/builtin-sched.c                    |   6 +-
 tools/perf/builtin-script.c                   |  18 +-
 tools/perf/builtin-timechart.c                |   2 +-
 tools/perf/builtin-top.c                      |  29 +-
 tools/perf/builtin-trace.c                    |  12 +-
 tools/perf/tests/builtin-test.c               |   1 -
 tools/perf/tests/dlfilter-test.c              |  12 +-
 tools/perf/tests/dwarf-unwind.c               |   2 +-
 tools/perf/tests/hists_common.c               |   4 +-
 tools/perf/tests/hists_cumulate.c             |   8 +-
 tools/perf/tests/hists_filter.c               |  10 +-
 tools/perf/tests/hists_link.c                 |  16 +-
 tools/perf/tests/hists_output.c               |   9 +-
 tools/perf/tests/kallsyms-split.c             |   5 +-
 tools/perf/tests/pe-file-parsing.c            |   1 +
 tools/perf/tests/symbols.c                    | 289 +++++-
 tools/perf/tests/vmlinux-kallsyms.c           | 191 ++--
 tools/perf/ui/browsers/annotate.c             |  11 +-
 tools/perf/ui/browsers/hists.c                |  17 +-
 tools/perf/ui/browsers/map.c                  |  87 +-
 tools/perf/ui/gtk/annotate.c                  |   7 +-
 tools/perf/ui/stdio/hist.c                    |   6 +-
 tools/perf/util/addr_location.c               |   4 +
 .../perf/util/annotate-arch/annotate-alpha.c  |   2 +-
 .../util/annotate-arch/annotate-loongarch.c   |   8 +-
 tools/perf/util/annotate-arch/annotate-s390.c |   2 +-
 tools/perf/util/annotate-arch/annotate-x86.c  |  14 +-
 tools/perf/util/annotate-data.c               |  14 +-
 tools/perf/util/annotate.c                    | 211 ++++-
 tools/perf/util/annotate.h                    |   6 +-
 tools/perf/util/auxtrace.c                    | 111 ++-
 tools/perf/util/block-info.c                  |  13 +-
 tools/perf/util/bpf_lock_contention.c         |  39 +-
 tools/perf/util/c2c-function.c                |  25 +-
 tools/perf/util/call-path.c                   |  15 +-
 tools/perf/util/callchain.c                   |  19 +-
 tools/perf/util/capstone.c                    |  21 +-
 tools/perf/util/data-convert-json.c           |   4 +-
 tools/perf/util/db-export.c                   |  76 +-
 tools/perf/util/db-export.h                   |   6 +
 tools/perf/util/debug.c                       |   3 +-
 tools/perf/util/disasm.c                      |  57 +-
 tools/perf/util/dlfilter.c                    |  12 +-
 tools/perf/util/dso.c                         | 236 +++--
 tools/perf/util/dso.h                         |  85 +-
 tools/perf/util/dsos.c                        | 100 +++
 tools/perf/util/dsos.h                        |  12 +-
 tools/perf/util/event.c                       |  12 +-
 tools/perf/util/evsel_fprintf.c               |   2 +-
 tools/perf/util/hist.c                        |  30 +-
 tools/perf/util/intel-pt.c                    |  74 +-
 tools/perf/util/libbfd.c                      |   5 +-
 tools/perf/util/libdw.c                       |   5 +-
 tools/perf/util/llvm.c                        |   6 +-
 tools/perf/util/lock-contention.c             |   8 +-
 tools/perf/util/machine.c                     | 143 ++-
 tools/perf/util/machine.h                     |   2 +
 tools/perf/util/map.c                         |  53 +-
 tools/perf/util/map.h                         |  18 +-
 tools/perf/util/map_symbol.c                  |   4 +-
 tools/perf/util/maps.c                        |   3 +-
 tools/perf/util/probe-event.c                 | 135 +--
 tools/perf/util/python.c                      |  20 +-
 .../util/scripting-engines/trace-event-perl.c |   8 +-
 .../scripting-engines/trace-event-python.c    |  38 +-
 tools/perf/util/session.c                     |  31 +
 tools/perf/util/session.h                     |  13 +
 tools/perf/util/sort.c                        |  44 +-
 tools/perf/util/srcline.c                     |  19 +-
 tools/perf/util/symbol-elf.c                  |  22 +-
 tools/perf/util/symbol.c                      | 845 ++++++++++++------
 tools/perf/util/symbol.h                      | 203 ++++-
 tools/perf/util/symbol_conf.h                 |   1 -
 tools/perf/util/symbol_fprintf.c              |  14 +-
 tools/perf/util/thread-stack.c                |  18 +-
 tools/perf/util/threads.c                     |  17 +-
 tools/perf/util/unwind-libdw.c                |   4 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 89 files changed, 2644 insertions(+), 1192 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

