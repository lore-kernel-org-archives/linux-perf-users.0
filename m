Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244314;
	b=olsEouzsvbbFTR4xwE/d38dWBXNM1t/TlJBD/t5Jz/TkEnfAmaP4u3KARa/qKvVO8JBC
	 7BLxlKNYZ434gZbtcAZHPCWe+DOfv966h8hS2fwowGE6hFtpSIX2Wiuv58LDuQTKGudZ5
	 dnPLihlV0CBiDk/RUs2Q9ggOtcds+jJl87E1gbgwqYOCiAcsOjJ/QXHC2vrixmWakmHz5
	 DTkP22Jv9YTnIz5vh/YnUVDFCdV/YfA4AIUoGJbiK1uWntcm35/2ysNauCctLfoagprbX
	 Tijtrt8A46f5JnUEQai7O3yMg7G61fXffrTMF8H00f8UXQrL1geh7px1I2NtrmieQ8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2eeHn/vU358hjZQaIkj7hsmvvnmUmwz9N1L4ebDKQzw=;
	b=Ck3sqd3qigBwZzLhYW4xAHaUfALXtzLWWhvBxWtO+tCFJaQs4AbPf9ImygL6Ct7PdrPR
	 Ingj/gUP2QfsdTs4D8Hb1UBDLUEKdHQVK+/L9iajlgl85Z1undCucvp12IJNEuR7M4fOx
	 S9wx6ovdVGbk869KwbUlkweZmPZ5jZ8GWxxPJKytfmVaGqtsSUI/6NI7/pFcXpmRrF7C4
	 pD4eTNcoTBkP4lUEd9uBsYvlKjjQap/037iTm9iQwSpZiHF2kDHfJSZUDyRYka8tAiQ0W
	 2Ch6u4t+3wtO7x9acw14NnuvS60uDfdmzZBo1mAMy/6CbQCiKozO6DujuxbkGnrThBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vrlc6UF4;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD898606A320
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD898606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vrlc6UF4
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-370230d93efso5173398eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244313; x=1795849113; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2eeHn/vU358hjZQaIkj7hsmvvnmUmwz9N1L4ebDKQzw=;
        b=Vrlc6UF4NFc85BkUXVdeIqC09BA72kDVLQ91ATHmsjAqMjtarR8o3Hicg+xRXDmcU6
         oDNCUnS6QKR2e5RtGcxowfuSxoSeBAp3rmObsfny6n4Byt39WswrkUmw/0BkuK/PcM0+
         5MrQgOJi75+mNdIXHzH+Q5shSlR4KhfOWXgGhWQpBwbboBlIlcntzIRFLNlQ8dycekXx
         PyXkvC/eePeewtcACoQ845rKZydtZGHwfjD0EHBgMK00UlgfBQl3oXAiR0llV8hlcEiR
         19w05lDvnuBfntgbGQVQJyMC0Ny6peI3jKpFb1Egw1HV3pxvM6iij6Vb3/1/+kJxLTdK
         h6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244313; x=1795849113;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2eeHn/vU358hjZQaIkj7hsmvvnmUmwz9N1L4ebDKQzw=;
        b=sOswU7peSB2FA++ZbihbYEzSbiduq56cwmvHujSPGjC9lDyjK1hE/sXW650n+hSxgK
         8sBRnfAb7fTQ7W003LU7O9D+sKcr6148A+xv3GuxoVxEc6Mu2A0/a4fPqS2NKuSeCFyq
         mXME6fEdtbgXYROLfIqZ7KVvRpSlpOjHErrdC0WGhPSPkHpEQbQ2C1rIPzq2aqhjE5w9
         djUidfv1bntmvTAY1c6kwXbsiTMFxiYCZPugNDWKHHwcPggjpfrVwCCgR0MzKZzA9vyL
         ghLdculgy5NW132s9+/zhR7EIBydNdRvaungTiMIMNhPqy0QMAIpGP9C14Tx0WfU9I8T
         C6OQ==
X-Forwarded-Encrypted: i=1; AL+hErGHguHevh3FLG6eX3yffWUUAl7pB5wYQVtyRAlxVqixJFDDkIER6/1ztggTB4RjhX2W1mCjED1e1O5ppUWmypWj@vger.kernel.org
X-Gm-Message-State: APuU4Z+HIZyXje2XEPMI8Jpi52lpiKNJoF4rO1o+yCJTGXajCFjiwsk3
	zICX7RCAEW8lg6wo32QR/ash2p8Up/b12XMis6C+VMkM5cf4kcIIllyk//4P72LnwShDjJTx3vI
	vuhG4grv15A==
X-Received: from dlbvv25.prod.google.com ([2002:a05:7022:5f19:b0:1a4:c892:b166])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4555:20b0:1a2:2da2:b278
 with SMTP id a92af1059eb24-1b556894b6emr6073199c88.14.1795244312023; Fri, 20
 Nov 2026 22:58:32 -0800 (PST)
Date: Fri, 20 Nov 2026 22:57:49 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-1-irogers@google.com>
Subject: [PATCH v15 00/23] tools/perf: Adopt kernel compiler-context-analysis.h
 annotations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
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
config, intel-tpebs, env, maps, and machines. Along the way, separate
preparatory patches fix an unlocked __dsos__add() call and TOCTOU race in
__machine__addnew_vdso(), skip BPF and OOL DSOs in
dsos__find_kernel_dso(), ensure DSOs created in auxtrace, machine, and
symbol helpers belong to a dsos collection, avoid dropping
_dso__data_open_lock in dso__list_del() under REFCNT_CHECKING, switch
dso__data_open_lock and tpebs_mtx to DEFINE_MUTEX(), add a read-lock
fast path to dsos__findnew_id(), fix an unlocked read of
tpebs_reader_thread and double-close of tpebs_cmd.out in intel-tpebs,
remove unused maps__load_first(), fix map index lookup fallback and
removal in maps, and hold machines->lock for remaining direct accesses to
machines->guests.

This series was developed and reviewed with assistance from an AI coding
agent (Gemini 3.1 Pro) and reviewed with Sashiko.

v15:
  - Rebase onto perf-tools-next (converting the newly added
    _annotations_lock annotations in tools/perf/util/annotate.c).
  - Move -DWARN_CONTEXT_ANALYSIS from patch 4 to patch 5 with a comment
    explaining that linux/compiler-context-analysis.h gates its Clang
    thread-safety attributes behind WARN_CONTEXT_ANALYSIS, and use
    cc-option from tools/build/Build.include (placing TMPOUT under
    $(OUTPUT) when set) to probe optional Clang thread-safety flags
    (Namhyung).
  - Replace patch 19 ("perf maps: Fix lock inversion in
    maps__load_first()") with removal of unused maps__load_first()
    (Namhyung).

v14:
  - Rebase onto perf-tools-next (dropping the redundant __maps__insert()
    hunk from patch 20 now covered by commit 31fa6010e5c0 ("perf maps:
    Check map__start_cmp() in __maps__insert()")).
  - Keep mmap2_valid ahead of build_id in __dso_id__cmp() so DSOs
    created from inode-based MMAP2 events that later gain a build ID do
    not break bsearch() ordering for subsequent inode-only lookups
    (Sashiko).
  - Prepare TPEBS events under tpebs_mtx, wait on tpebs_starting (with
    tpebs_gen check) and check tpebs_enabled before treating an
    already-started session as ready in evsel__tpebs_open(), purge all
    prepared tpebs_results entries only for the owning session on error,
    initialize tpebs_cmd.out = -1, and re-lookup t after reacquiring
    tpebs_mtx in evsel__tpebs_read() (Sashiko).
  - Hold machines->lock around remaining direct accesses to
    machines.guests in aslr, build-id, and session, and annotate
    machines->guests with __guarded_by(&lock) (patches 22 and 23).

v13:
  - Rebase onto perf-tools-next.
  - Factor out dso__is_bpf_prog() for dsos__find_kernel_dso_cb() and
    check ksym_type == PERF_RECORD_KSYMBOL_TYPE_BPF &&
    is_bpf_image(event->ksymbol.name) before setting
    DSO_BINARY_TYPE__BPF_IMAGE in machine__process_ksymbol_register()
    (Namhyung).
  - Prioritize build IDs over inode fields in __dso_id__cmp(),
    dso__needs_improve_id(), and __dso__improve_id() so an existing DSO
    with a defined build ID is not updated with inode metadata
    (Namhyung).
  - Rewrite patch 15's commit message concisely, fold intel-tpebs lock
    annotations (with split control_fd/ack_fd declarations) into patch
    16, and split config and env annotations into standalone patches 17
    and 18 (Namhyung).

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

Ian Rogers (23):
  compiler-context-analysis: Avoid unused parameter warning in
    _context_unsafe_alias()
  tools headers compiler: Synchronize compiler_types.h with the kernel
    sources
  tools headers: Synchronize linux/compiler-context-analysis.h with the
    kernel sources
  perf mutex: Use kernel style compiler-context-analysis.h annotations
  perf build: Enable context analysis and Clang thread-safety flags
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
  perf intel-tpebs: Use DEFINE_MUTEX for tpebs_mtx and add lock
    annotations
  perf config: Add __guarded_by and __must_hold annotations
  perf env: Add __guarded_by and __must_hold annotations
  perf maps: Remove unused maps__load_first()
  perf maps: Fix map index lookup fallback and removal
  perf maps: Add context analysis annotations
  perf machine: Hold machines->lock for remaining guests rbtree accesses
  perf machine: Add __guarded_by annotation to machines->guests

 include/linux/compiler-context-analysis.h     |   2 +-
 tools/build/Build.include                     |   4 +-
 .../include/linux/compiler-context-analysis.h | 518 ++++++++++++++++--
 tools/include/linux/compiler-gcc.h            |  72 ++-
 tools/include/linux/compiler.h                |  50 +-
 tools/include/linux/compiler_types.h          | 206 ++++++-
 tools/perf/Makefile.config                    |   9 +-
 tools/perf/builtin-sched.c                    |  16 +-
 tools/perf/builtin-top.c                      |   4 +-
 tools/perf/check-headers.sh                   |   1 +
 tools/perf/tests/dso-data.c                   |   4 +
 tools/perf/tests/maps.c                       | 140 +++++
 tools/perf/util/annotate.c                    |   8 +-
 tools/perf/util/annotate.h                    |   8 +-
 tools/perf/util/aslr.c                        |   4 +
 tools/perf/util/auxtrace.c                    |  16 +-
 tools/perf/util/bpf-event.h                   |   5 +-
 tools/perf/util/build-id.c                    |   8 +
 tools/perf/util/comm.c                        |  10 +-
 tools/perf/util/config.c                      |  47 +-
 tools/perf/util/dso.c                         | 169 +++---
 tools/perf/util/dso.h                         |  33 +-
 tools/perf/util/dsos.c                        |  34 +-
 tools/perf/util/dsos.h                        |  12 +-
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  19 +-
 tools/perf/util/intel-tpebs.c                 | 314 +++++++----
 tools/perf/util/libbfd.c                      |   4 +-
 tools/perf/util/machine.c                     |  35 +-
 tools/perf/util/machine.h                     |   3 +-
 tools/perf/util/map.c                         |  14 +-
 tools/perf/util/maps.c                        | 212 ++++---
 tools/perf/util/maps.h                        |   2 -
 tools/perf/util/mutex.c                       |   4 +-
 tools/perf/util/mutex.h                       |  90 +--
 tools/perf/util/rwsem.c                       |   8 +-
 tools/perf/util/rwsem.h                       |  10 +-
 tools/perf/util/session.c                     |   8 +-
 tools/perf/util/symbol.c                      |   4 +
 tools/perf/util/thread.c                      |  10 +-
 tools/perf/util/thread.h                      |  30 +-
 tools/perf/util/threads.c                     |   4 +
 tools/perf/util/threads.h                     |   6 +-
 tools/perf/util/vdso.c                        |  53 +-
 44 files changed, 1599 insertions(+), 612 deletions(-)


base-commit: bb27ddbaee56536fb8df0a24f07b526766dfe131
-- 
2.56.1.750.gf70dc682cf-goog

