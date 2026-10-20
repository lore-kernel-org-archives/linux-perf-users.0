Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514210;
	b=XJrKrvG/rlZpWmGYTskjhtkNYcO6gVuiRH9aZRhzvmbhB3foDhdnaNLtL8oU8yTqwEnE
	 WRi34t8w/lodHtKgHXRPbRyLCszuqpqEpIGRXGZQvx24jkKtMum+1cj66wuR6uJQ3nmde
	 XJCnOz88pCtOAr1xnYq/n3e3dudzQvUXGBITxRsSG02IAkBhZQvOCtnpTL3fNcb6iIjKZ
	 zpbyFnsLYUsvF8qhEpgTcXq3hyqKXlGf3hKlnvUseRqs59xGJfuPs77AZLuBkoXjBHxEz
	 zmzs2RfYQPiY7yk9KnGzIGNRVh49E09fiupQAiexXWWv2W/OGcLLbTSGB/HgFXLjRMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Os5V1VGJIS4aXlnwbIJQQclYeaqOeSoW9P5F76ri3m4=;
	b=lOhp9PmNLioYFzO81AizoQijC/3kxhVUemTIAkBUClaEtGkvmCYfOPCMckAI9d/VR0Wl
	 p7dprDsuIN9D67jKyWePod6iXYcUegzP/YbTQJiS127tdSmJGAh4h6wO3Qq0KngSd8VO/
	 +Nk0BnY+UmwWruZzRsaQHkrk4it5ILdgaLSqt7tNgc4FdwRU0LRFXkWH9PgHto19UY27s
	 O7/izOV9kLwQC/e+01Zoqhc4N4UcTlmI9NIyqseu/C74svBK+XEgVbHin3liwEn8UHMym
	 5M7gHp7qiEZ6zyFzQtVs6sec4qEshl/+mfsLIUWsz1DusM0anRDD24jGCEPSBjwChtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Uda1pMf0;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44725606A31B
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 16:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44725606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Uda1pMf0
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-147be78cd56so13459579c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514208; x=1793119008; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Os5V1VGJIS4aXlnwbIJQQclYeaqOeSoW9P5F76ri3m4=;
        b=Uda1pMf0N5vbyLCDZb48fmSRsyhXMtgdGMGuHAEpTQFftCxm8/fQzXRVYYJIzulSS2
         FrOwDuj1HQF/+r0JzFa+ytuxJRRltTdHyNRik9A4smC+EfzQNwl5VeFyx14l6SZ8bM1z
         OA56+ICCA5q4WGs/HusPAnIgoqJb3VkQCWRY164Afx14SD8mSARgiv17tIl9NRe9XOhc
         96/9oZIlNbq4/V/nLKLgNHbMaH6rqY+EbXXPx0Ha3qDFIejCZJMY4vKsvhSJ/V+rEHOp
         Z9Rfkk2vFU4jzeDld5S1/mUOrVyXQIceHELozPyRENp12Z4WEN2kv2WLot3C9rPG0OYH
         a4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514208; x=1793119008;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Os5V1VGJIS4aXlnwbIJQQclYeaqOeSoW9P5F76ri3m4=;
        b=2uBarm/H2EidtRsjTCfcK+oFUKC1vaQqI2sBxpibrmx+sbl8VRrgs01LP9D4czPUfs
         wmrVEkXHPuYoBIW2tPrQZVZ2KnNL/oV52tNC2Ludc0XeLKGPFCcnO9ybatENWSd25vpr
         v/LxyMozi4dOCF1r7EL3+nqa5naxm7sYKFKcYRJrQbVWz0D+bW/a37EX1zU7PaSwkaxk
         7ixnRbtJQKd1+O1fwSOu1v2ruHMYZopX3hu6XFQ3RavVv/Rny/t9RcLrbmH7TVC4+K9R
         qjWOyil2sT3YBBW8cbw1VgwGZOuvEU9eXk48PTg/9yGO4+ql0yiDGRf/TvBOjuCBSjhV
         VePQ==
X-Forwarded-Encrypted: i=1; AKwUvBzskThQxLcczYJZD29TeWeNu1e9Tr92OPT8W8EPr/qHGN7OQafifT1N8O6XcgctkSKEDx6QmbDLcwZngHPx/fjs@vger.kernel.org
X-Gm-Message-State: AFq9FYIv8leMbrVNIVde6GEUE4FcgEjLpnef3tRb6EQD72t29WvxvThQ
	W1uHI8jjjVAQX+bm2OmpRGu5zYM8xqS8HP0HbPsikIDSlmU2U7TP3JW0iSg74CFJFypcoe57Dgp
	eDY4rrNCBUg==
X-Received: from dlak16.prod.google.com ([2002:a05:701b:2910:b0:18f:4e29:3ddd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:464a:b0:143:868a:20c1
 with SMTP id a92af1059eb24-185151be30emr13684798c88.46.1792514207925; Tue, 20
 Oct 2026 09:36:47 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:36:23 -0700
In-Reply-To: <20261016221700.1282659-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261016221700.1282659-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020163640.746159-1-irogers@google.com>
Subject: [PATCH v5 00/17] tools/perf: Adopt kernel compiler-context-analysis.h annotations
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

v5:
  - Hold machine->dsos.lock in write mode across machine->vdso_info
    initialization and temporary file creation in
    machine__findnew_vdso() and __machine__findnew_compat(), and
    annotate __machine__addnew_vdso() with
    __must_hold(&machine->dsos.lock) (patches 7, 11).
  - Reset tpebs_cmd.pid = 0 and return early without setting
    t->started = true if start_command() fails in
    evsel__tpebs_start_perf_record() (patch 13).

v4:
  - Place the DSO loaded in addr_filter__resolve_syms() into a dsos
    collection so dso__dsos(dso) is populated (patch 8).
  - Join tpebs_reader_thread on error in evsel__tpebs_open(), document
    why tpebs_cmd.pid is cleared before pthread_join() in tpebs_stop(),
    and include <pthread.h> and <signal.h> in util/intel-tpebs.c
    (patch 13).
  - Include <string.h> in util/maps.c (patch 16).

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
 tools/perf/util/auxtrace.c                    |  16 +-
 tools/perf/util/bpf-event.h                   |   5 +-
 tools/perf/util/comm.c                        |  10 +-
 tools/perf/util/config.c                      |  43 +-
 tools/perf/util/dso.c                         | 140 +++--
 tools/perf/util/dso.h                         |  15 +-
 tools/perf/util/dsos.c                        |  31 +-
 tools/perf/util/dsos.h                        |  12 +-
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  19 +-
 tools/perf/util/intel-tpebs.c                 | 133 +++--
 tools/perf/util/libbfd.c                      |   4 +-
 tools/perf/util/maps.c                        | 148 +++--
 tools/perf/util/mutex.c                       |   4 +-
 tools/perf/util/mutex.h                       |  90 +--
 tools/perf/util/rwsem.c                       |   8 +-
 tools/perf/util/rwsem.h                       |  10 +-
 tools/perf/util/thread.c                      |  10 +-
 tools/perf/util/thread.h                      |  30 +-
 tools/perf/util/threads.c                     |   4 +
 tools/perf/util/threads.h                     |   6 +-
 tools/perf/util/vdso.c                        |  53 +-
 34 files changed, 1204 insertions(+), 481 deletions(-)

-- 
2.56.0.212.g129ede20d9-goog

