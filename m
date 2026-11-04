Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825955;
	b=LOqd3NJJOtKx3iIbFFXftoHoCA/5Sn3SzxasrfBaFIlwZ4hTxSf85/KRU7d/iBq72V1M
	 bZoNL8ceo5xU/vONGJLnB51u+HD/eJlU6WPrTcclZAAa3yuMnA+kt17IpncgZJw1wuYFT
	 MuOLNDY7cXSf+NAl4aNcpNCC9lw2CC8ly+dHG7Gwaik9MCUssVeVFWNXLn0Oi3+yOvIPu
	 TnUp4wV1iKBRyREF+vWQduF9i+EAJbjjZf4f0lUz3Ks3/bXtbdcsUpZDmI1Hh/gqdP5LQ
	 Ym8dB/v7HT8iWCiL5y/PKC8y2wbpT3rif/K9h88ZRfvCbM6kTrP/CuekwwD+oR+PdkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dAk5t7/Uq2hFFngztPZcMYhv97rCmj99qhndfOYN6s0=;
	b=S6Hl+K4Fy/npmRyg7p04Q7eBOZO6+UgZ6Dhd/scYkP6oPqVxugh9zi49w3izre9PfnOj
	 6iXQouIBOaz7SFlTgTlsNkGEvk91jFY9burm1Q2ydqeIC3BEqyBfpvWOlJgmnQcX2Uvcv
	 FfJsxzExAmwmNdIQutcBOOeVDXhWeH5JKolD9G5YWNaIOVprUNzhhXK+WOSDkTp8zUIyL
	 V9geGBgphGK9EI/aYG9SUxNidkHS+kS6MTP7H0RizGGyAyTvjmkEWxUgvbexR+NN3G74S
	 KcC0hX4cTLwZPWh0lYEkAePLx0pT/Vkx5r9X92baOAG5+iLMNnE6aZtzPpXr5lROGDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RZCblD7v;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE144606C599
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 20:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE144606C599
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RZCblD7v
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3692c5b061bso2863924eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 12:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793825954; x=1794430754; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAk5t7/Uq2hFFngztPZcMYhv97rCmj99qhndfOYN6s0=;
        b=RZCblD7vKDvNY9beeUPRTm+Mgxv+aH5kIGeCqlFBRCxZSnH0DT53sXWg53gSxeRHT3
         eBDOgim5ZdwO+Hm+3le6sU5xlKVz+hC3uRZkR02e1CAYrbftTReRPMsd4T4HcO7WpW0L
         YDUV9U2saQ28yRkVo9TEuuha54A8CFhIUx9UJJh7btZdXxRId1YUg5iKf95FzvemoEW6
         Nsspc+FDsw3ULf0RTtjJCRXj+vZHcNtvKZXqCLiIeTGxXUinvaTUsoIU2HfJKlI9KjZk
         BM1AahWQObMLwoDemOm/drYkdqApHyCbmAQy3svU27k9wrOF/yJZmO+dqoK1e7FJHBED
         9LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825954; x=1794430754;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAk5t7/Uq2hFFngztPZcMYhv97rCmj99qhndfOYN6s0=;
        b=L6qwlgaq89iE4iCgffdb667d0/e3EKrmWZwqrSLuOBZ0D5EeckSVfKB+tFzfR/hWNR
         5QAfP1nj8dvev08qARQ97L/LAQ0i9io4YTOwFHmI7wVLuFrKhcMuaDSVCh44l+udNHGX
         iM3Lh6MhRzYJCG8RQlBONAVvteE+O7cQyRmTB1ou8Vw3EjPoyarlMu+pEkK+SHvzwEGn
         vG7yZNlXRusHQfLASaplvct1UAwCaAKmJ3moM/xTX2yvUZcfYM6mq/4hXk/5ztp4uDf+
         EfrCKTUxcvyVYJL4nfp+dIZ0RmaaoV4TedsN83buY6Gir0d377WcgGY1Gr6NH0AmmMxQ
         K5oQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTYQzmjBlCLSiggiFAYGjE6b5CassMb3GOJT9kJxvdbarvGTKaAES9H9pktu8b2I+IBw82PtvV5hTdo+eReuYY@vger.kernel.org
X-Gm-Message-State: APuU4Z/4FhzPQsqSpqqhMiO5A/CuM+k7VS2mWF4NS6Knnre48hg6osN/
	9ZJceCsrFx3g0AvVk4yD/o5fGVMtbDZheJtoKB33fi+DmwpL3YH528aFtZ9rO62ibjlBsjq8bWp
	78NDcVR6kTg==
X-Received: from dybkf19.prod.google.com ([2002:a05:7301:3a93:b0:35c:f432:c724])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:6393:20b0:369:f291:49da
 with SMTP id 5a478bee46e88-36a4243f71emr25862426eec.40.1793825953443; Wed, 04
 Nov 2026 12:59:13 -0800 (PST)
Date: Wed,  4 Nov 2026 12:58:50 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261104205909.2078411-1-irogers@google.com>
Subject: [PATCH v9 00/19] tools/perf: Adopt kernel compiler-context-analysis.h annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
__machine__addnew_vdso(), skip BPF and OOL DSOs in
dsos__find_kernel_dso(), ensure DSOs created in auxtrace, machine, and
symbol helpers belong to a dsos collection, avoid dropping
_dso__data_open_lock in dso__list_del() under REFCNT_CHECKING, switch
dso__data_open_lock and tpebs_mtx to DEFINE_MUTEX(), add a read-lock
fast path to dsos__findnew_id(), fix an unlocked read of
tpebs_reader_thread and double-close of tpebs_cmd.out in intel-tpebs,
and avoid a potential read-to-write deadlock in maps__load_first() and
out-of-bounds access in __maps__remove().

This series was developed and reviewed with assistance from an AI coding
agent (Gemini 3.1 Pro) and reviewed with Sashiko.

v9:
  - Rebase onto perf-tools-next (resolving the conflict in
    tools/include/linux/compiler.h with ASSERT_STATIC_STORAGE() and
    converting the newly added dso__set_symsrc_filename() lock
    annotation in tools/perf/util/dso.h).
  - Move __must_hold_shared(&dsos->lock) on __dsos__find() from patch 13
    into patch 7 where __dsos__find() is introduced so every commit in
    the series builds cleanly with -Wthread-safety.

v8:
  - Set DSO_BINARY_TYPE__BPF_IMAGE for non-OOL ksymbol DSOs in
    machine__process_ksymbol_register() and skip
    DSO_BINARY_TYPE__BPF_PROG_INFO, DSO_BINARY_TYPE__BPF_IMAGE, and
    DSO_BINARY_TYPE__OOL in dsos__find_kernel_dso_cb() so that
    dsos__find_kernel_dso() does not match ksymbol DSOs in
    machine->dsos (patch 8).
  - Split the dsos__add() additions in auxtrace, machine, and symbol into
    a standalone patch (patch 9) before "perf dso: Pass dso_data to
    close_data_fd() and dso__list_del()" (patch 10).

v7:
  - Add newly created DSOs in machine__process_ksymbol_register() and
    dso__split_kallsyms() to machine->dsos so assert(dso__dsos(dso)) in
    dso__list_add() always holds.
  - Add __guarded_by(&config_mutex) to function-local static parser
    buffers in parse_value() and perf_parse_file().
  - Remove from maps_by_name before calling
    map__put(maps_by_address[address_idx]) in __maps__remove() so
    callers such as maps__remove_maps() that pass maps_by_address[i] as
    map do not use a freed handle in maps__by_name_index() under
    REFCNT_CHECKING.

v6:
  - Rebase onto perf-tools-next.

v5:
  - Hold machine->dsos.lock in write mode across machine->vdso_info
    initialization and temporary file creation in
    machine__findnew_vdso() and __machine__findnew_compat(), and
    annotate __machine__addnew_vdso() with
    __must_hold(&machine->dsos.lock).
  - Reset tpebs_cmd.pid = 0 and return early without setting
    t->started = true if start_command() fails in
    evsel__tpebs_start_perf_record().

v4:
  - Place the DSO loaded in addr_filter__resolve_syms() into a dsos
    collection so dso__dsos(dso) is populated.
  - Join tpebs_reader_thread on error in evsel__tpebs_open(), document
    why tpebs_cmd.pid is cleared before pthread_join() in tpebs_stop(),
    and include <pthread.h> and <signal.h> in util/intel-tpebs.c.
  - Include <string.h> in util/maps.c.

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
    ASM_OUTPUT_RM overrides in tools/include/linux/compiler-gcc.h.
  - Probe for -Wthread-safety-pointer/-Wthread-safety-beta in
    Makefile.config.
  - Pass write_locked to __dsos__find().
  - Pass struct dso_data * to close_data_fd() and dso__list_del() to
    remove the REFCNT_CHECKING dso pointer from struct dso_data and
    avoid dropping dso__data_open_lock in dso__list_del(), and include
    <assert.h> in util/dso.c.
  - Re-validate DSO lookup under the write lock in dsos__findnew_id()
    via __dsos__findnew_id(), and handle NULL dso_id in
    dso__needs_improve_id(), __dso__improve_id(), and dso_id__cmp().
  - Reset tpebs_cmd.out = -1 if start_command() fails and include
    <stdint.h>, <stdlib.h>, <string.h>, and <unistd.h> in
    util/intel-tpebs.c.
  - Bounds-check the index in __maps__remove() (freeing maps_by_name if
    out of bounds).

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

Ian Rogers (19):
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
  perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
  perf dsos: Ensure DSOs in auxtrace, machine, and symbol are in dsos
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
 tools/perf/util/config.c                      |  47 +-
 tools/perf/util/dso.c                         | 140 +++--
 tools/perf/util/dso.h                         |  17 +-
 tools/perf/util/dsos.c                        |  34 +-
 tools/perf/util/dsos.h                        |  12 +-
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  19 +-
 tools/perf/util/intel-tpebs.c                 | 133 +++--
 tools/perf/util/libbfd.c                      |   4 +-
 tools/perf/util/machine.c                     |  13 +-
 tools/perf/util/maps.c                        | 157 ++++--
 tools/perf/util/mutex.c                       |   4 +-
 tools/perf/util/mutex.h                       |  90 +--
 tools/perf/util/rwsem.c                       |   8 +-
 tools/perf/util/rwsem.h                       |  10 +-
 tools/perf/util/symbol.c                      |   4 +
 tools/perf/util/thread.c                      |  10 +-
 tools/perf/util/thread.h                      |  30 +-
 tools/perf/util/threads.c                     |   4 +
 tools/perf/util/threads.h                     |   6 +-
 tools/perf/util/vdso.c                        |  53 +-
 36 files changed, 1227 insertions(+), 493 deletions(-)

-- 
2.56.0.455.g6c5a503b38-goog

