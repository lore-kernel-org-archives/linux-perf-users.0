Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418940;
	b=ninV8sOqY5Iy4/H+xmki/SumEzOLSQOnFFSZqlwsXee4rzSdy0nZVacXTANHe8M6bCj0
	 KrfV5Z+FzM6vU/FZc9cH4Gj0zyBXLgSI82tsxzY23YoB1PsLgIDImPYh7SUPcryUpFkUC
	 lK5TBcn56dsmpp/sIhya0GqcgpIDe51ajyxUtG1xllbsUvlhJv7S2YGry3cMcebUM6X6G
	 aVkZMY6Cy4YFK4Z+eHfJZXboJV/vOHnQ3+cl6RI1uGvuZfXNeZ586czucT6Xc0VezXxM6
	 Wvkp7ID250fqOZmYqF2bVV1awZbcYn6XwFOWLbMGzUWC57pFnKVvv3v9tAue+y50FdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=yh8nkpT4+CYfMHL+eFwrZnzXCycE6ehY6JiHLBYE62o=;
	b=qdLot2lXch0jaEoub2mRC+AjDgEyQ4zUZDyE01Gzbk2okjMdL2qN0rnxMW/VVRn61OtZ
	 861XD9V4OvmKlOlKS8cPKFTq2YzIbhrmONvM+KLc2UBB4/XzACTKYhqYYdOeCT2MPslCq
	 RpCRtFOR9WPnw8nld4/xOeLqHWv+bFVaYeXy4mHUE6K4N8K5ZTW/4tuyzxPiKqfyUJVvL
	 57374/LW8hz/67A1QYq6VA7YYkWO9CxMtMA8srvuhsOHNK/ToZ8i8oPa0DxbrHzFDs/WW
	 Tswcnlo0PZOXQ8EWlbzzYntg0pTq9lXf3D2HsJb4F50gr7bc4MtaFlFFQHnFRdmqrOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gX0HeSls;
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A4606A326
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F0A4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gX0HeSls
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4519ef1babeso1995700fac.2
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 09:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794418938; x=1795023738; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yh8nkpT4+CYfMHL+eFwrZnzXCycE6ehY6JiHLBYE62o=;
        b=gX0HeSlsm6KtQAm76hqJroi5arfRFXPsHDOBP94yc2q/cnD1/Mev3IgmeXAfzSFEjB
         uoUlmn7y7kqzvjT0+Q/tM/VH2DCDWTko3kICzq7061Pe6KhShK05s7gxT/l2e/inr95B
         a9A3YKztrZwa5/tnfRnLtYpqjw+aMsfxZJSJPMFRnqyYPFlXlNaFm4kMAIzLjckuDzFh
         +1u28dgXDTvgQyaSysZcwBSBq0njAAmcaklCiD8LmCrkeJuwQduiet4pxnNLhCcF95UO
         dP970rYVGMme8CL8sAiInJc5bDpN891pCjlqHvNTEQnMryKQrjAuLBc4DqdKonXWm6bb
         JA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418938; x=1795023738;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yh8nkpT4+CYfMHL+eFwrZnzXCycE6ehY6JiHLBYE62o=;
        b=XX5CjN+0rhAbd/IB5mA93zbuB0S/wqhRk/NLZujslJrJhNjLBXkOLWlzmLxROdXJG4
         Q/pYhVDUShUKVv7+H3QV1yJbxFTPO1EdGhP33Ox6Am1nPP8MDPh2H514BlM6FT12Njci
         TvPBi+eGqxMeeEGSkbKVwDOq3cKPVFE02DXpQLgfAruz897+Z8bGVrlYhIlJ7uB9GVeX
         yuT+IYvFfR1PPRa/3fiZObA1R+KrKcr+zTn5gbTj8QyCCBhrc+pODAaAIz1poRfGKcY2
         ekC/1oQheLfNIyhwJ76c19ebpYf1VCJnwxZpVIOeQs9yiOfndYThgjb7cb16DGYpkfm5
         hqwQ==
X-Forwarded-Encrypted: i=1; AL+hErFsZklLTZY0JqWjADhwLX4v0XAeEoA5OQlsG82X4i+bSB4RugSKJLTHrJUSZxMhTSBVzMeEXkSzmZ75OJECDcj5@vger.kernel.org
X-Gm-Message-State: APuU4Z/4WQJaoBs7YGKHRTh3HLiMug/spUS8vT7ntEekiA0eq497ULN4
	QGyajm5DWl7N6z6TIawsWXVukvDNmRfmH++bE7UMrvX6ri6+Flg9Fzq817OcJVAa59lXml3oKN1
	+QQupUI/zjA==
X-Received: from oacbc4.prod.google.com ([2002:a05:6871:a184:b0:4a7:3874:712b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:148e:b0:49e:1c69:1f57
 with SMTP id 586e51a60fabf-4ae46c43101mr2625466fac.41.1794418938199; Wed, 11
 Nov 2026 09:42:18 -0800 (PST)
Date: Wed, 11 Nov 2026 09:41:52 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111174213.3526604-1-irogers@google.com>
Subject: [PATCH v12 00/20] tools/perf: Adopt kernel compiler-context-analysis.h
 annotations
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
avoid a potential read-to-write deadlock in maps__load_first(), and fix
map index lookup fallback and removal in maps.

This series was developed and reviewed with assistance from an AI coding
agent (Gemini 3.1 Pro) and reviewed with Sashiko.

v12:
  - Rebase onto perf-tools-next.
  - Newline-terminate control commands in tpebs_send_record_cmd() so
    consecutive writes cannot coalesce in evlist__ctlfd_recv(), send
    SIGTERM in tpebs_stop() if ENABLE had not completed (tpebs_enabled,
    annotated __guarded_by(&tpebs_mtx) in patch 17) or sending STOP
    fails, and ignore late samples in process_sample_event() once
    tpebs_stopping is set.

v11:
  - Rebase onto perf-tools-next.
  - Add Fixes tags to patches 7, 15, and 18.
  - Serialize tpebs_send_record_cmd() with teardown via
    tpebs_cmd_in_flight and tpebs_cmd_cond, check
    check_if_command_finished(&tpebs_cmd) under tpebs_mtx only when not
    stopping, guard evsel__tpebs_open() against a concurrent tpebs_stop()
    with a generation counter (tpebs_gen) and tpebs_stopping across
    closing the fds and finish_command(), and annotate tpebs_cmd,
    control_fd, ack_fd, tpebs_stopping, tpebs_cmd_in_flight, and
    tpebs_gen with __guarded_by(&tpebs_mtx) in patch 17.

v10:
  - Split the maps__load_first() lock inversion fix (patch 18) from the
    maps index lookup and removal fixes (patch 19).
  - Fall back to the linear pointer scan in maps__by_address_index() and
    maps__by_name_index() when bsearch() returns NULL, check
    map__start(prev) < map__start(new) in __maps__insert(), factor out
    __maps__remove_at() so maps__remove_maps() removes at index i
    directly without risking an infinite loop, guard against -1 index
    wraparound in maps__find_next_entry(), refresh sort invariants in
    maps__fixup_end() and machine__create_kernel_maps(), and add a unit
    test in tests/maps.c.

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

Ian Rogers (20):
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
  perf maps: Fix lock inversion in maps__load_first()
  perf maps: Fix map index lookup fallback and removal
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
 tools/perf/tests/maps.c                       | 140 +++++
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
 tools/perf/util/intel-tpebs.c                 | 226 +++++---
 tools/perf/util/libbfd.c                      |   4 +-
 tools/perf/util/machine.c                     |  34 +-
 tools/perf/util/maps.c                        | 216 +++++---
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
 37 files changed, 1492 insertions(+), 541 deletions(-)


base-commit: cc905a18a647a8e3ad42cd1596baa0e08fba26eb
-- 
2.56.0.542.g3ef89b7020-goog

