Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602655;
	b=kGn/ryyb8yZBy6ufzZp5+OnVsuaQegLx4Pjymh0RR4EYws9Xpgw+HZWKF9IJnLnIqoAv
	 yl4pjs9aCp/2YdhK+qU12hkRFTxcbV6nG8bWQC794NKuPxH42VbfZJczQgbDxnT231zzG
	 dK35C7su/iUs8vLOjxdOVFrLz/gXRRXjyQbaItnUxW98pB2Q0Fy22hXO61KyVNhFxh8Cp
	 TICNLKVxQVEx3mJpM7Xr9BqNeMAwJP9T1pw5PLVPeYMoXATrdd1GkSQcFs1yWeSalukqc
	 cyaKEoXDADjByrlxfZtEuG2Z+W/lMng9ifAqxBgtiLJ3SNbuma6YIXbw4TgAeevn17w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HibgJhitNqYx90KHPc8hl4hJtyn8X6V6EDcChq4tAIE=;
	b=uQPhxUW39so/R2/ehXPHGSPhMIRlmtJ2K/jpVurdhLAmBmdgsdbGkEEEZUlGV/aZH1Uh
	 c5E+i9ROsVNzcnEZ13D40TzvRrUQVTSHzA/IZCdBM3UdkqF2qoug1Xct82tSiFV1wtXYB
	 eKWLdTagRyDB1Cx2zFtw5F6RM4o44NmR2oaNTtfUMOD+QsTDF6zIs9mjQmPo2mUxjsMvH
	 Gynmkl8ZIAwVisQ4ve8H9i5hPrI7GWfBbiglbdwH+f5NcASsSxR6A5MyrBZuZRVS8kzNC
	 0j1AQBU6in4FgbuIod0o0c86EG6s6RJwT2KSFS1mey5EVDSligSNgHJCodNYiyyXnKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LunwwrYZ;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E892606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E892606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LunwwrYZ
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c902e0da2so87352eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792602653; x=1793207453; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HibgJhitNqYx90KHPc8hl4hJtyn8X6V6EDcChq4tAIE=;
        b=LunwwrYZfP0AbgMU/Mp7VF6/3bYEn8Tc3H/bNp6VZYaq5L12PXH1/mXYbhtL6fYXES
         Ti1T+G8j3IpptJRCQStJf7ytztj+2yB3XCOw8JiiBSJ+9HrcIjhc7k3h9f6YDsC1OYvH
         tKYGi+WrOHo+IJ9EeCvx8Q7wIagFioMPmu48k6ZeqBQKq1NWg94n+8wOxGdu9r5MtvV+
         eQYNmzde51ADw2NShW4WpA2Rm4uIkPPYf+7zcu8c/U9dZWZ1nLr7itop7bVficQ2bJur
         SVkAC7F1tmbROJ/fRmtaaYcgAJHhWSYrqlzI1fiaioA6vDyyJmYsviGI9VsouSjVNFQw
         fZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602653; x=1793207453;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HibgJhitNqYx90KHPc8hl4hJtyn8X6V6EDcChq4tAIE=;
        b=VSj7K9pd5ojwS0x1FrmwBJN/m5OBE54yzW3MFkXxfCj2ldM1YQg3GNlV8jcn2d9Ybc
         uyJ2LPAdNAKSVSkSjorTQeMXWWexcttjNWVzmRJsO3iGtUWJSu0vGmo2Vv4XgTRywwXY
         PMYRt/YGU1CQRzFfnE2I7AUjnrrazxH2Aa4Ez6sJvC2oiR4pHakixnIYskWMYWIu41Q+
         +FVIpDm9UMvF9a3MHvoBGN4/Fn/JWHk7KttUWYbjsRRIswMEmgST+4Qx+bGjAneLPN6q
         krOXw07qGm0q29EC1JrM4LuxYy28mZb4AyjVsnVN7F2GPnBsp62NGRHljiRbe3yzP7+k
         E3WQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0xlLXpH7rL8e0oM2y4J/Eo6t6YLALOLkIJbHO3vRaTszU9HtImUtbqYl5EC9N5Aw75oMBlulRxN9dWQzL6HGs@vger.kernel.org
X-Gm-Message-State: AFq9FYL5Wgkz5tC1Uvzqlv/7fl8M4V1uQZc8a/8OR7SpJtOeR9d3K0il
	BdFQuBTf7z2b+PTv8mjSX+5I0RoH7wzOXOfbxiRYZDz1HiYmPBPohvqDtbavGAyjXRaZyOAKjFu
	0KK4qQ+GXpw==
X-Received: from dlbtx6.prod.google.com ([2002:a05:7022:fc06:b0:168:b4b9:d783])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:689e:b0:158:b944:b15
 with SMTP id a92af1059eb24-190a7c21cb9mr4649944c88.22.1792602652788; Wed, 21
 Oct 2026 10:10:52 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:10:26 -0700
In-Reply-To: <20261020163640.746159-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020163640.746159-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021171044.155240-1-irogers@google.com>
Subject: [PATCH v6 00/17] tools/perf: Adopt kernel compiler-context-analysis.h annotations
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

v6:
  - Rebase onto perf-tools-next.

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
2.56.0.218.g1ec904b173-goog

