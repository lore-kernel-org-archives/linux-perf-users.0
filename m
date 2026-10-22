Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700110;
	b=ws0LZHdsKWb9B//gmtBNLAzfB4g2W3A50RFvum87VJKy3WJ7tvq4rcXD3XZ/q9a2na4F
	 f4Ox8axu71oPYeijmJb618Fcq9ysUpDZe2eOPOUp6F7XaA2x2cEYFbzS+uHtewPCcSW0D
	 5+lBGx6OOJAJQXERFv1j61YxFUc52iU0USAJW5ofBG4KE6if3baSwSYR1h58M/0k1RUOo
	 of+/fKpLfpywP0H75UqCPcFO7IwmLVHqWDZGQm59diqxrK8eYKXExPKYJtSnN+rnJ7WZQ
	 AKd7bFSw4Nqeqx0kMhdd074xceiMHoEHRAd277njW96dKsD9EdxAMyw52HIOXWKP1Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=sawlpfhN5yFFaNeuDW7ZRPpZXyzPmy9v0u9NImEoi0s=;
	b=s/yWNg3eCPLlJp9PshFdFE0IWm15IIjdb7EwOD5/OTOyAi3OCwRsW0TR91sjK8MhAQ7R
	 iawGdSIXDzd28WKir1lCkbNckDbrfwKSwP2TQmubtCx5V+h4fuqy+79LnbUhAGgoSzCbT
	 7FcRrf4KAZp438/DB8C6YKWd5kB7v7xcieY6T4X4YmPTbWrk1Wt7R82XgdxXkUXHC/y5j
	 hf9ObI0bwH/JGVvyr65cBw25SoLA6gUXDjTjOuu3zrlzSlrEja8f5MWb+x8Hi6QrYLDJe
	 cqDGWhWkJXqVCbzkAiwRqdbpxmXi9n3VpdKTJg3VcHZB5+VkUmAg38ljyjLwddP5jSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Tk+XMgUF;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F797606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F797606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Tk+XMgUF
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36637676140so304155eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700108; x=1793304908; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sawlpfhN5yFFaNeuDW7ZRPpZXyzPmy9v0u9NImEoi0s=;
        b=Tk+XMgUFzD8Fp4FkKLB6IwExCj8jbfibAL3GUvjOF/6n8TSJ80Vv42w1La/xTzw9g0
         6Lv1CpTyAyNvVmJ3h1NlfGIDj/JixPGB9buPuTfQk0GhM6VxqBl2e+rny1+qrO9UgrKe
         mcB7zuocWaSWzPEqz0bp3EQvZoc9GA9A9sUYUGqX4ROHUIu/Mqp26OSmD2QUXY3kAfok
         XHkXTOdBFNYbkJRhcAHxi9nkF8+LXI+o3Ky3XlhwTj6HT1pinvPnbgAv+sjsBZpjLgUe
         /fGKIZN1yTDkH3yyaQMhyIsFae+eA9jq92Rwm1flMRAUfrbxLyRbTdxa3whSTDGwiBmZ
         nbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700108; x=1793304908;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sawlpfhN5yFFaNeuDW7ZRPpZXyzPmy9v0u9NImEoi0s=;
        b=rmTSe+bgkGq7vbGEfRLzIwjr+DJOandO06r0c4M8WS6EQ2Mm1l1BpKsYLpM0DnR/bE
         nW6zNZSN+90pRe8E2noFdm7AhTzJTruihy5g7UjKXGnX7BqPgO45LTvT6590YOj8iGMv
         qCsjfh2j+DvD5349zo/KC4FOO3n/ZhQM9L0CVX2/QUWYVP3Y0MkMz0Y3ta5bbpUrDoyp
         cjqCmoT3HnDmdWQJn8Y4p4JXO4E0LATzA5XqBDfnFsoccRC6P8KVjY9noHIBG6/vpQTk
         jO7rIQxJR1Au0hvuEOj4OKs9o162Bn2Oh2y5WntoBMrQiVeU5VBJiwJskSHpJvcZjyJ4
         kk2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxX9YqODeIr05qG7EM8C7fDtVrBFfwWAOwMvsEI9ICmaroojxBjixWSP5FdukVTd2wjwR36HJDLCT5VqgBvsfRJ@vger.kernel.org
X-Gm-Message-State: AFq9FYKLN7C34JQpQ3N51yT1lwb58qJRZYx/3lbCScRXbKA0Yu4tpqXy
	GHoGLD5Z6i0xg8VacU/aWgvvyy4qRBVdFLJ9BwJQUze2iOsoo8MFJHfg69LYR04yy4BR6dYs/GL
	j8FF+7P6FvQ==
X-Received: from dlai25.prod.google.com ([2002:a05:701b:2719:b0:194:611e:c050])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3f05:b0:190:596:4071
 with SMTP id a92af1059eb24-195982d8b56mr792827c88.11.1792700108096; Thu, 22
 Oct 2026 13:15:08 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:33 -0700
In-Reply-To: <20261021223905.715051-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-1-irogers@google.com>
Subject: [PATCH v8 00/19] tools/perf: Adopt kernel compiler-context-analysis.h annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
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
 tools/perf/util/dso.h                         |  15 +-
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
 36 files changed, 1226 insertions(+), 492 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog

