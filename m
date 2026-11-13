Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588121;
	b=dEoFEUOZ4v8k9M+5CaRBLeycno5bsZoRJ9uReq7upjz+GyZ6LoZCgEajVhAXPH6HvFHE
	 fX+/akZ+8Z3geZ1lJN69hNRagMuQjbl9r38+SQtdkIi1f3AvXyuSq9/0zqkXEKZmcaQ7L
	 qZ5ScBWW2JkT/cRXXDSSJzg/iCZ55CgwF5TWKiA/NDqjL1Ucy2arbdvUE/T77WHVPhl5J
	 9kIw6OzOiLy6rTOpgVea00lRbzFXVPFED0R7D92qlIv7q3+bfdwGAOuZWypISn+bK0p0e
	 zOEd4K2a9urabo3YFBlwEv2xsOkg8Lxo5dovdTx4JpHhbq/ZOpDD7U3IpBTqUT3OF5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=YrFwJGX2KUisQtbXdlIvGKLgBkkPHf7JKuf/4nujSSc=;
	b=dxub1TWJGzvdqu6+F5RHOe5WgUKtR3MRC0A9YHF/AgjpPB0fB2X0j09C4SQGvDXTGTTy
	 0xY0uvMXePE7ed78aPj9FEigkQmz7MgjV7QTneCHb0+K3RYoxOVkbbrsnesWN3JfWVxe3
	 X9VBdtjVssVs6FlDAEiNTxiTjUv+nLlX9owSNIr+DZBoxdHHQo+B+RDy8qN0hgVVXJbFQ
	 SOE0RTfjr3c6VzcIxgJ224olBFlf7C4XFty7Lf9jM+93zAHvJO4hnYetvNaeN6t/sztOs
	 efT0D/xujMvfiiH3BU49odACdr58vhGeNJHuF1FS82EYRCuzNiLPhU/qyJzbzPHvcog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nn8ABV79;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F3606A8AC
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 307F3606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nn8ABV79
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1492429eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794588119; x=1795192919; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YrFwJGX2KUisQtbXdlIvGKLgBkkPHf7JKuf/4nujSSc=;
        b=nn8ABV79ilcnDqtBoNff+pGSO960w5WkfNgfS5VlMdB37hqXerVi/5koohi/oNnUUr
         PcotctIiSOlUoQFyWVnL4oZli6sLvFog1IakyQsOO8PlMECXz5E4HloQp4Eg1LNTlHjI
         ZYONmZXX/oTgPZ5l2scjNu7P4bXqwMTmB+JjZ8uVCrACihr1bRGfZgW9LWhSqX1KByZY
         OPeQSX3J87q3MjApebiryyPtxX2V33cV7Sqy3ChFfJB5XUMffzIXl8wXZklfDwKjTPNS
         lCeXnEZLi2xwyPhKTmh3CmVOa3etM5cZediVjPsF4fRNbu/n3dR5my3sVZPpSoEU4TTY
         frog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588119; x=1795192919;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YrFwJGX2KUisQtbXdlIvGKLgBkkPHf7JKuf/4nujSSc=;
        b=tqif4AZv7sJ1/CXr5K9gujmqw8/A7E1i2d+MVIyUGmHgdL0jAU+SE5SEhL0KDYoOMY
         1SbqVJ96GVHYy8B6WS93Iog+9T+ymgLR58T7X53BoB8r4HSYO6CXCIlG2Ez2K6WJsmXI
         ebC4C8266ntu39dKLNcGMScge3T6rLlEDx0MYxnO/Xnz3VVhDtkmYE0lg4WIHDnLtIzl
         G+0DuTwfgcDsefq1FuVNGDAPqIFI0iIbIzzTyENt6I3QzXBAgk1EfPAGac2Xfcgohvum
         tt7OM/cdLRHN2k1cIzhu4Uo+p2zEPfxdvG2HSXEFlTKJaStay0ifGZibpdWlQQIYYAL0
         qCbg==
X-Forwarded-Encrypted: i=1; AL+hErE7bxOOBNkR+N6BhO7R6BPwMZA+d00lR5x593I2dVRrfBv8Kanwbi0dvGWoVVhMPIcMvbyiRqQu6ZuotVhRmCko@vger.kernel.org
X-Gm-Message-State: APuU4Z9ex/C/c9o9/SS7r/EbYpz1TdN7wWkZ3vGBkYSoK5mY1kjieDa3
	YII2OpdbRHdz/5wO/kT30dcD5Fdo+nsiXK/dzosBT/IcDIxt6l4w6sM3Ym15+uS1+xn6/feSnLt
	Erszwj0fWRw==
X-Received: from dybgv25.prod.google.com ([2002:a05:7301:2319:b0:36f:5688:8a11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:88dc:20b0:37a:7e8a:7407
 with SMTP id 5a478bee46e88-37a7e8a74f4mr429882eec.24.1794588118811; Fri, 13
 Nov 2026 08:41:58 -0800 (PST)
Date: Fri, 13 Nov 2026 08:41:31 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113164152.2095566-1-irogers@google.com>
Subject: [PATCH v13 00/21] tools/perf: Adopt kernel compiler-context-analysis.h
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

Ian Rogers (21):
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
  perf intel-tpebs: Use DEFINE_MUTEX for tpebs_mtx and add lock
    annotations
  perf config: Add __guarded_by and __must_hold annotations
  perf env: Add __guarded_by and __must_hold annotations
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
 tools/perf/util/dso.c                         | 179 +++---
 tools/perf/util/dso.h                         |  33 +-
 tools/perf/util/dsos.c                        |  34 +-
 tools/perf/util/dsos.h                        |  12 +-
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  19 +-
 tools/perf/util/intel-tpebs.c                 | 226 +++++---
 tools/perf/util/libbfd.c                      |   4 +-
 tools/perf/util/machine.c                     |  34 +-
 tools/perf/util/map.c                         |  14 +-
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
 38 files changed, 1531 insertions(+), 571 deletions(-)


base-commit: 4af65363b11fc4fe65fcb497f68bbe4f3e3a4d2c
-- 
2.56.1.703.gf848ed807c-goog

