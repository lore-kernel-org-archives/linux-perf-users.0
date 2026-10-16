Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864CE57F736
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171874; cv=none; b=Pf8m4W/9jzo38H2F4TLLMa6OHIQ3OgzXBbOTCQgBrJSqpK3mOaSHNmKRW7kXfNWaLZhihJidmygftMHsIkPiDB9GJdKh3ZocTSY3SiBmLqbgWZpSRPYsdg6fkF9K945EwunQATegsfdUs6pOqQT1idKQdqgR8jRClUio3ZwQh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171874; c=relaxed/simple;
	bh=CFQ5jrx/u6vw66XOyYC58LB1oD8ERnPk3m8rwkYRKZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jRz3eoxdWkmFVRDEx/VDr43KKma9z/XdAW56PAQiv1ARj/6wOyHZDo3kRv+oSkPIr2t5CVkFA/wJQTGfx1fvhby8FFkXy3V30G/opcYvMcJIQ9dHWYKWBy6Xrh2JBk5ipSzu7t0W9TCm+o/yHdgyMbMZSFsKyaZSrIcqxgSCXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K5QrNMUt; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5QrNMUt"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so387951c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792171871; x=1792776671; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NA++Fw4E9Z7IMDY/xneFvYBRbHMUxJ8a3G6LvbVZpwA=;
        b=K5QrNMUtK/N1VwPT0GQL118sSKaiaNnl8/J6R1X8ugKZ/etb4GAVcFWiPwtKdo5qWx
         uzhF/vTKRZoC9JRGvKXZJPC2qojSDrpHdYUnN3QCnqvE6LijHz9JdaFbbf3Oiofg+8o5
         5z0fOVLJjkb0WTUDHWXexqGQPQJp27Yms9Xg5HwyKpU7FmmqMaxJ1fXHZRI9e7poy4an
         EoepZw9mvu6fxqUSo4DJWtWKcbWDUFvYXGulXz8SkmI/KRr3L36kV/R2Edss65mUrThP
         4Ws++Qr5iZbrwm/jfmVi0R+0od57/UaAeQhKZcQUHOPWVWSgMVcYyRRNO3lxmGmaMl+6
         Wk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171871; x=1792776671;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NA++Fw4E9Z7IMDY/xneFvYBRbHMUxJ8a3G6LvbVZpwA=;
        b=UXxFl/rvpPP5kQHd8ZtsWrqJlQWh1onTs7I7eZ1YI5G7WvkEnTve7XwFQDKABR8C7I
         LxbyELxw5FeFS31MSA20/izSU5R92AIiF30V5ZiIPzrC2JKvIxbEx9AL0oKCRmt4Hp5r
         vRCSLVLVTW6OjyOxffTeiKtOCYoUKJ5ImuPhqKiJyBJBX68R7PxbGKf7jqwB+Oeg7CVU
         FyN+E3VMu7DNjLOULrg32fD6/NOxl4WcCePfJzoWwLjSMtq8JTdfr1mzqtcGSzNT3L3Z
         uD7qWRLDET5eDFwPMJNePozwjKvQh2Odtd5lN0vDgU2DUVEDpuN66oPhnm0y/Mgd1JIi
         Tg4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzZEA9Fwogy4m9cQBpFUehi38rh42nNj2Npf3Chuml18K9W4f535KBvPE0e1ZizOnAJmhh8L158Eks8eSWqtIoz@vger.kernel.org
X-Gm-Message-State: AFq9FYJWj5au9OBWqfWAeHMwWTac8AvM2S5XzrV9rkD9gYuE9lrj39sj
	8eIf2uTG/aRIyUMpXBlFLdNeT0DfIjCd5yIneqragYLVSjYIzT7o6aGUnv1ebGwk2CIMN4zVhlw
	ppukUAGB1Ng==
X-Received: from dlbqc13.prod.google.com ([2002:a05:7023:a8d:b0:161:df69:3983])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:170d:b0:149:cfa4:9b3b
 with SMTP id a92af1059eb24-1850cda6f5cmr781129c88.3.1792171870846; Fri, 16
 Oct 2026 10:31:10 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:30:49 -0700
In-Reply-To: <20261013222622.1822619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013222622.1822619-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016173106.679725-1-irogers@google.com>
Subject: [PATCH v3 00/17] tools/perf: Adopt kernel compiler-context-analysis.h annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

The perf tool previously added Clang thread-safety annotations in
tools/perf/util/mutex.h (GUARDED_BY, LOCKABLE, EXCLUSIVE_LOCK_FUNCTION,
UNLOCK_FUNCTION, etc.). Since then, the Linux kernel has adopted a
unified set of static context analysis macros and attributes in
include/linux/compiler-context-analysis.h (context_lock_struct,
__guarded_by, __acquires, __releases, __must_hold, etc.).

This series makes tools/include/linux/compiler-context-analysis.h
functional by synchronizing it and the required compiler_types.h helpers
with the kernel headers, converts tools/perf from its custom mutex.h
macros to the kernel-style compiler-context-analysis.h annotations, and
expands context analysis coverage across comm, dso/dsos, thread/threads,
config, intel-tpebs, env, and maps. Along the way, separate preparatory
patches fix an unlocked __dsos__add() call and TOCTOU race in
__machine__addnew_vdso(), avoid dropping _dso__data_open_lock in
dso__list_del() under REFCNT_CHECKING, switch dso__data_open_lock and
tpebs_mtx to DEFINE_MUTEX(), add a read-lock fast path to
dsos__findnew_id(), fix an unlocked read of tpebs_reader_thread and
double-close of tpebs_cmd.out in intel-tpebs, and avoid a potential
read-to-write deadlock in maps__load_first() and out-of-bounds access in
__maps__remove().

This series was developed and reviewed with assistance from an AI coding
agent (Gemini 3.1 Pro) and reviewed with Sashiko.

v3:
  - Rebase onto perf-tools-next (converting the newly added
    dso__find_binary_type() lock annotations in util/dso.c).
  - Separate bug fixes, DEFINE_MUTEX() cleanups, and improvements (vdso,
    dso_data, dso__data_open_lock, dsos__findnew_id, intel-tpebs,
    tpebs_mtx, maps) from the annotation patches.
  - Move AI coding assistant attribution to the cover letter and drop
    per-commit Assisted-by tags per linux-next
    Documentation/process/coding-assistants.rst.
  - Add Marco Elver's Reviewed-by to patch 1.
  - Define __diag_clang_23() and Clang ASM_INPUT_G/ASM_INPUT_RM/
    ASM_OUTPUT_RM overrides in tools/include/linux/compiler-gcc.h
    (patch 2).
  - Probe for -Wthread-safety-pointer/-Wthread-safety-beta in
    Makefile.config (patch 5).
  - Pass write_locked to __dsos__find() (patch 7).
  - Pass struct dso_data * to close_data_fd() and dso__list_del() to
    remove the REFCNT_CHECKING dso pointer from struct dso_data and
    avoid dropping dso__data_open_lock in dso__list_del(), and include
    <assert.h> in util/dso.c (patch 8).
  - Re-validate DSO lookup under the write lock in dsos__findnew_id()
    via __dsos__findnew_id(), and handle NULL dso_id in
    dso__needs_improve_id(), __dso__improve_id(), and dso_id__cmp()
    (patch 10).
  - Reset tpebs_cmd.out = -1 if start_command() fails and include
    <stdint.h>, <stdlib.h>, <string.h>, and <unistd.h> in
    util/intel-tpebs.c (patch 13).
  - Bounds-check the index in __maps__remove() (freeing maps_by_name if
    out of bounds) (patch 16).

v2:
  - Use -c rather than -E when probing for
    -fexperimental-late-parse-attributes in Makefile.config to avoid
    -Werror,-Wunused-command-line-argument.
  - Acquire machine->dsos.lock in write mode across duplicate checking,
    dso__set_long_name(), and __dsos__add() in __machine__addnew_vdso().
  - Avoid dropping dso__data_open_lock in dso__list_del() under
    REFCNT_CHECKING.
  - Pass tpebs_cmd.out directly to __sample_reader() and set
    tpebs_cmd.out = -1 in evsel__tpebs_open() to avoid a double-close in
    tpebs_stop(), and clarify the config_set_mutex comment.
  - Drop maps__lock before calling map__load() in maps__load_first() to
    avoid a read-to-write self-deadlock when loading kernel maps inserts
    additional trampoline maps.

Ian Rogers (17):
  compiler-context-analysis: Avoid unused parameter warning in
    _context_unsafe_alias()
  tools headers compiler: Synchronize compiler_types.h with the kernel
    sources
  tools headers: Synchronize linux/compiler-context-analysis.h with the
    kernel sources
  perf mutex: Use kernel style compiler-context-analysis.h annotations
  perf build: Enable additional Clang thread-safety flags
  perf comm: Add __guarded_by annotations to struct comm_strs
  perf vdso: Fix unlocked __dsos__add() and race in
    __machine__addnew_vdso()
  perf dso: Pass dso_data to close_data_fd() and dso__list_del()
  perf dso: Use DEFINE_MUTEX for dso__data_open_lock
  perf dsos: Use read lock fast path in dsos__findnew_id()
  perf dso: Expand context analysis annotations
  perf thread: Expand context analysis annotations to threads and
    namespaces_lock
  perf intel-tpebs: Fix race in tpebs_stop() and tpebs_cmd.out fd
    handling
  perf intel-tpebs: Use DEFINE_MUTEX for tpebs_mtx
  perf config, intel-tpebs, env: Add __guarded_by and __must_hold
    annotations
  perf maps: Fix lock inversion in maps__load_first() and bounds check
    in __maps__remove()
  perf maps: Add context analysis annotations

 include/linux/compiler-context-analysis.h     |   2 +-
 .../include/linux/compiler-context-analysis.h | 518 ++++++++++++++++--
 tools/include/linux/compiler-gcc.h            |  72 ++-
 tools/include/linux/compiler.h                |  50 +-
 tools/include/linux/compiler_types.h          | 206 ++++++-
 tools/perf/Makefile.config                    |   8 +-
 tools/perf/builtin-sched.c                    |  16 +-
 tools/perf/builtin-top.c                      |   4 +-
 tools/perf/check-headers.sh                   |   1 +
 tools/perf/tests/dso-data.c                   |   4 +
 tools/perf/util/annotate.c                    |   4 +-
 tools/perf/util/annotate.h                    |   8 +-
 tools/perf/util/bpf-event.h                   |   5 +-
 tools/perf/util/comm.c                        |  10 +-
 tools/perf/util/config.c                      |  43 +-
 tools/perf/util/dso.c                         | 140 +++--
 tools/perf/util/dso.h                         |  15 +-
 tools/perf/util/dsos.c                        |  31 +-
 tools/perf/util/dsos.h                        |  12 +-
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  19 +-
 tools/perf/util/intel-tpebs.c                 | 104 ++--
 tools/perf/util/libbfd.c                      |   4 +-
 tools/perf/util/maps.c                        | 147 +++--
 tools/perf/util/mutex.c                       |   4 +-
 tools/perf/util/mutex.h                       |  90 +--
 tools/perf/util/rwsem.c                       |   8 +-
 tools/perf/util/rwsem.h                       |  10 +-
 tools/perf/util/thread.c                      |  10 +-
 tools/perf/util/thread.h                      |  30 +-
 tools/perf/util/threads.c                     |   4 +
 tools/perf/util/threads.h                     |   6 +-
 tools/perf/util/vdso.c                        |  17 +-
 33 files changed, 1144 insertions(+), 459 deletions(-)

-- 
2.56.0.212.g129ede20d9-goog

