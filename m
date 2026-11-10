Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351494;
	b=407gU1woT3zDX67IagBMr0RfIfwiFiELKaeo5lXCYPzhgUliwSkv/Uz9b/H77o366+lv
	 5TymZH1NsWBSwZskMUTJ8Wo8yFKKX1FCQd80lIN0GviBgUfWL5zT2v7Av1niqseLVUQ0o
	 FkHNAPBrAav+W+A+vltaGza7aprC/o4G0F+e0yyyj9D8XPglZw7MCZfyLZ9FAwpFMFQtw
	 AXub1zRGHUxGKYQLfNAebqWSoQUrViImOer0BlEhJ+hK1d9EOXsInxcITQdrjIDQSQmow
	 7vuCbLE+71WAHMZnJkXL2zupsmiQRSsa79l8k6EpoXWZyCuu3Nt9ZTHzNYSs9PecJ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351494;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NyqK5t5Jucqd/1TA7Y4odc+MHM7utrQ3droOuvmbCwI=;
	b=I+IlOBno7ZDQYcqxyOglqgeYUiqbE62qgeJJti3AuDiunLptyJqQam2Y2cQ7fwJtM+Bk
	 8/dX05TMW1nOv9aETwp5o78sR8aDG07PYeNq8Mo1m/WRywOJ4936RcFKL9uEbwZ5JwMU8
	 qbEyNZgc5Xpi4wOH6SY/rLC7ZR5LQcpElOMI8iSJKNXdD05WIzbaAyVYoBWytFqwYC8kH
	 eFdewRJRGbrZF8E73JpwkfVSyGtocFCM0cdbo8nyQAm7kiXFgTsV5V14kuWnAvluUGCnU
	 Tb+ygvt23a+1E0t+MIo6CIqlbWIoMPz5KTRe6Zo0EqF4JJV9PjlZphDKrEDT8RljWAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2x1ERak;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381CA606A321;
	Tue, 10 Nov 2026 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2x1ERak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A991F0093C;
	Tue, 10 Nov 2026 22:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351493;
	bh=NyqK5t5Jucqd/1TA7Y4odc+MHM7utrQ3droOuvmbCwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k2x1ERakUGIOYvpFHgC8OdnRlEpp1ikz4h9fxSXMzBZKpbGgg9mlM0nSlpbKBHqMH
	 H8pUPhqObfSgITg26xZ+GUau24ZYlXi37eXluVuRKI+gab5RP65EBbObIurw9082S3
	 QFvZhLeJGKgz7xuV8VL40u4ykpUgrnRfJfA/Aqb/8sfUyFntsfzsaoK72fsLrTPpPR
	 JxCQp7dQeKw4mckN75URZFl1njX2yPagEx//pAzthsLM5mCbYQGP9BZdx42sN6p5Hq
	 J9KhUjKWHBzx5PqyuTT/heNxCt8BsCuGtkY0ERYRTrmsf2LTfm516kZRwwsghZVnnw
	 LE5y8ihlBYlUA==
Date: Tue, 10 Nov 2026 14:58:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org,
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	mingo@redhat.com, morbo@google.com, nathan@kernel.org,
	ndesaulniers@google.com, peterz@infradead.org
Subject: Re: [PATCH v11 00/20] tools/perf: Adopt kernel
 compiler-context-analysis.h annotations
Message-ID: <avOhhIL1EExpcJBi@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261107044102.1506626-1-irogers@google.com>

Hi Ian,

On Fri, Nov 06, 2026 at 08:40:41PM -0800, Ian Rogers wrote:
> The perf tool previously added Clang thread-safety annotations in
> tools/perf/util/mutex.h (GUARDED_BY, LOCKABLE, EXCLUSIVE_LOCK_FUNCTION,
> UNLOCK_FUNCTION, etc.). Since then, the Linux kernel has adopted a
> unified set of static context analysis macros and attributes in
> include/linux/compiler-context-analysis.h (context_lock_struct,
> __guarded_by, __acquires, __releases, __must_hold, etc.).
> 
> This series makes tools/include/linux/compiler-context-analysis.h
> functional by synchronizing it and the required compiler_types.h helpers
> with the kernel headers, converts tools/perf from its custom mutex.h
> macros to the kernel-style compiler-context-analysis.h annotations, and
> expands context analysis coverage across comm, dso/dsos, thread/threads,
> config, intel-tpebs, env, and maps. Along the way, separate preparatory
> patches fix an unlocked __dsos__add() call and TOCTOU race in
> __machine__addnew_vdso(), skip BPF and OOL DSOs in
> dsos__find_kernel_dso(), ensure DSOs created in auxtrace, machine, and
> symbol helpers belong to a dsos collection, avoid dropping
> _dso__data_open_lock in dso__list_del() under REFCNT_CHECKING, switch
> dso__data_open_lock and tpebs_mtx to DEFINE_MUTEX(), add a read-lock
> fast path to dsos__findnew_id(), fix an unlocked read of
> tpebs_reader_thread and double-close of tpebs_cmd.out in intel-tpebs,
> avoid a potential read-to-write deadlock in maps__load_first(), and fix
> map index lookup fallback and removal in maps.
> 
> This series was developed and reviewed with assistance from an AI coding
> agent (Gemini 3.1 Pro) and reviewed with Sashiko.

Is there any chance other tools than perf can be affected by this
change? 

How can I check this?  Does it require specific build flags?  Does it
work with GCC as well?  Can we extend the build test to validate this
automatically?

Thanks,
Namhyung

> 
> v11:
>   - Rebase onto perf-tools-next.
>   - Add Fixes tags to patches 7, 15, and 18.
>   - Serialize tpebs_send_record_cmd() with teardown via
>     tpebs_cmd_in_flight and tpebs_cmd_cond, check
>     check_if_command_finished(&tpebs_cmd) under tpebs_mtx only when not
>     stopping, guard evsel__tpebs_open() against a concurrent tpebs_stop()
>     with a generation counter (tpebs_gen) and tpebs_stopping across
>     closing the fds and finish_command(), and annotate tpebs_cmd,
>     control_fd, ack_fd, tpebs_stopping, tpebs_cmd_in_flight, and
>     tpebs_gen with __guarded_by(&tpebs_mtx) in patch 17.
> 
> v10:
>   - Split the maps__load_first() lock inversion fix (patch 18) from the
>     maps index lookup and removal fixes (patch 19).
>   - Fall back to the linear pointer scan in maps__by_address_index() and
>     maps__by_name_index() when bsearch() returns NULL, check
>     map__start(prev) < map__start(new) in __maps__insert(), factor out
>     __maps__remove_at() so maps__remove_maps() removes at index i
>     directly without risking an infinite loop, guard against -1 index
>     wraparound in maps__find_next_entry(), refresh sort invariants in
>     maps__fixup_end() and machine__create_kernel_maps(), and add a unit
>     test in tests/maps.c.
> 
> v9:
>   - Rebase onto perf-tools-next (resolving the conflict in
>     tools/include/linux/compiler.h with ASSERT_STATIC_STORAGE() and
>     converting the newly added dso__set_symsrc_filename() lock
>     annotation in tools/perf/util/dso.h).
>   - Move __must_hold_shared(&dsos->lock) on __dsos__find() from patch 13
>     into patch 7 where __dsos__find() is introduced so every commit in
>     the series builds cleanly with -Wthread-safety.
> 
> v8:
>   - Set DSO_BINARY_TYPE__BPF_IMAGE for non-OOL ksymbol DSOs in
>     machine__process_ksymbol_register() and skip
>     DSO_BINARY_TYPE__BPF_PROG_INFO, DSO_BINARY_TYPE__BPF_IMAGE, and
>     DSO_BINARY_TYPE__OOL in dsos__find_kernel_dso_cb() so that
>     dsos__find_kernel_dso() does not match ksymbol DSOs in
>     machine->dsos (patch 8).
>   - Split the dsos__add() additions in auxtrace, machine, and symbol into
>     a standalone patch (patch 9) before "perf dso: Pass dso_data to
>     close_data_fd() and dso__list_del()" (patch 10).
> 
> v7:
>   - Add newly created DSOs in machine__process_ksymbol_register() and
>     dso__split_kallsyms() to machine->dsos so assert(dso__dsos(dso)) in
>     dso__list_add() always holds.
>   - Add __guarded_by(&config_mutex) to function-local static parser
>     buffers in parse_value() and perf_parse_file().
>   - Remove from maps_by_name before calling
>     map__put(maps_by_address[address_idx]) in __maps__remove() so
>     callers such as maps__remove_maps() that pass maps_by_address[i] as
>     map do not use a freed handle in maps__by_name_index() under
>     REFCNT_CHECKING.
> 
> v6:
>   - Rebase onto perf-tools-next.
> 
> v5:
>   - Hold machine->dsos.lock in write mode across machine->vdso_info
>     initialization and temporary file creation in
>     machine__findnew_vdso() and __machine__findnew_compat(), and
>     annotate __machine__addnew_vdso() with
>     __must_hold(&machine->dsos.lock).
>   - Reset tpebs_cmd.pid = 0 and return early without setting
>     t->started = true if start_command() fails in
>     evsel__tpebs_start_perf_record().
> 
> v4:
>   - Place the DSO loaded in addr_filter__resolve_syms() into a dsos
>     collection so dso__dsos(dso) is populated.
>   - Join tpebs_reader_thread on error in evsel__tpebs_open(), document
>     why tpebs_cmd.pid is cleared before pthread_join() in tpebs_stop(),
>     and include <pthread.h> and <signal.h> in util/intel-tpebs.c.
>   - Include <string.h> in util/maps.c.
> 
> v3:
>   - Rebase onto perf-tools-next (converting the newly added
>     dso__find_binary_type() lock annotations in util/dso.c).
>   - Separate bug fixes, DEFINE_MUTEX() cleanups, and improvements (vdso,
>     dso_data, dso__data_open_lock, dsos__findnew_id, intel-tpebs,
>     tpebs_mtx, maps) from the annotation patches.
>   - Move AI coding assistant attribution to the cover letter and drop
>     per-commit Assisted-by tags per linux-next
>     Documentation/process/coding-assistants.rst.
>   - Add Marco Elver's Reviewed-by to patch 1.
>   - Define __diag_clang_23() and Clang ASM_INPUT_G/ASM_INPUT_RM/
>     ASM_OUTPUT_RM overrides in tools/include/linux/compiler-gcc.h.
>   - Probe for -Wthread-safety-pointer/-Wthread-safety-beta in
>     Makefile.config.
>   - Pass write_locked to __dsos__find().
>   - Pass struct dso_data * to close_data_fd() and dso__list_del() to
>     remove the REFCNT_CHECKING dso pointer from struct dso_data and
>     avoid dropping dso__data_open_lock in dso__list_del(), and include
>     <assert.h> in util/dso.c.
>   - Re-validate DSO lookup under the write lock in dsos__findnew_id()
>     via __dsos__findnew_id(), and handle NULL dso_id in
>     dso__needs_improve_id(), __dso__improve_id(), and dso_id__cmp().
>   - Reset tpebs_cmd.out = -1 if start_command() fails and include
>     <stdint.h>, <stdlib.h>, <string.h>, and <unistd.h> in
>     util/intel-tpebs.c.
>   - Bounds-check the index in __maps__remove() (freeing maps_by_name if
>     out of bounds).
> 
> v2:
>   - Use -c rather than -E when probing for
>     -fexperimental-late-parse-attributes in Makefile.config to avoid
>     -Werror,-Wunused-command-line-argument.
>   - Acquire machine->dsos.lock in write mode across duplicate checking,
>     dso__set_long_name(), and __dsos__add() in __machine__addnew_vdso().
>   - Avoid dropping dso__data_open_lock in dso__list_del() under
>     REFCNT_CHECKING.
>   - Pass tpebs_cmd.out directly to __sample_reader() and set
>     tpebs_cmd.out = -1 in evsel__tpebs_open() to avoid a double-close in
>     tpebs_stop(), and clarify the config_set_mutex comment.
>   - Drop maps__lock before calling map__load() in maps__load_first() to
>     avoid a read-to-write self-deadlock when loading kernel maps inserts
>     additional trampoline maps.
> 
> Ian Rogers (20):
>   compiler-context-analysis: Avoid unused parameter warning in
>     _context_unsafe_alias()
>   tools headers compiler: Synchronize compiler_types.h with the kernel
>     sources
>   tools headers: Synchronize linux/compiler-context-analysis.h with the
>     kernel sources
>   perf mutex: Use kernel style compiler-context-analysis.h annotations
>   perf build: Enable additional Clang thread-safety flags
>   perf comm: Add __guarded_by annotations to struct comm_strs
>   perf vdso: Fix unlocked __dsos__add() and race in
>     __machine__addnew_vdso()
>   perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
>   perf dsos: Ensure DSOs in auxtrace, machine, and symbol are in dsos
>   perf dso: Pass dso_data to close_data_fd() and dso__list_del()
>   perf dso: Use DEFINE_MUTEX for dso__data_open_lock
>   perf dsos: Use read lock fast path in dsos__findnew_id()
>   perf dso: Expand context analysis annotations
>   perf thread: Expand context analysis annotations to threads and
>     namespaces_lock
>   perf intel-tpebs: Fix race in tpebs_stop() and tpebs_cmd.out fd
>     handling
>   perf intel-tpebs: Use DEFINE_MUTEX for tpebs_mtx
>   perf config, intel-tpebs, env: Add __guarded_by and __must_hold
>     annotations
>   perf maps: Fix lock inversion in maps__load_first()
>   perf maps: Fix map index lookup fallback and removal
>   perf maps: Add context analysis annotations
> 
>  include/linux/compiler-context-analysis.h     |   2 +-
>  .../include/linux/compiler-context-analysis.h | 518 ++++++++++++++++--
>  tools/include/linux/compiler-gcc.h            |  72 ++-
>  tools/include/linux/compiler.h                |  50 +-
>  tools/include/linux/compiler_types.h          | 206 ++++++-
>  tools/perf/Makefile.config                    |   8 +-
>  tools/perf/builtin-sched.c                    |  16 +-
>  tools/perf/builtin-top.c                      |   4 +-
>  tools/perf/check-headers.sh                   |   1 +
>  tools/perf/tests/dso-data.c                   |   4 +
>  tools/perf/tests/maps.c                       | 140 +++++
>  tools/perf/util/annotate.c                    |   4 +-
>  tools/perf/util/annotate.h                    |   8 +-
>  tools/perf/util/auxtrace.c                    |  16 +-
>  tools/perf/util/bpf-event.h                   |   5 +-
>  tools/perf/util/comm.c                        |  10 +-
>  tools/perf/util/config.c                      |  47 +-
>  tools/perf/util/dso.c                         | 140 +++--
>  tools/perf/util/dso.h                         |  17 +-
>  tools/perf/util/dsos.c                        |  34 +-
>  tools/perf/util/dsos.h                        |  12 +-
>  tools/perf/util/env.c                         |   1 +
>  tools/perf/util/env.h                         |  19 +-
>  tools/perf/util/intel-tpebs.c                 | 206 ++++---
>  tools/perf/util/libbfd.c                      |   4 +-
>  tools/perf/util/machine.c                     |  34 +-
>  tools/perf/util/maps.c                        | 216 +++++---
>  tools/perf/util/mutex.c                       |   4 +-
>  tools/perf/util/mutex.h                       |  90 +--
>  tools/perf/util/rwsem.c                       |   8 +-
>  tools/perf/util/rwsem.h                       |  10 +-
>  tools/perf/util/symbol.c                      |   4 +
>  tools/perf/util/thread.c                      |  10 +-
>  tools/perf/util/thread.h                      |  30 +-
>  tools/perf/util/threads.c                     |   4 +
>  tools/perf/util/threads.h                     |   6 +-
>  tools/perf/util/vdso.c                        |  53 +-
>  37 files changed, 1477 insertions(+), 536 deletions(-)
> 
> 
> base-commit: 13a8d580433a3b72b10be34f0e26787fe5659d3c
> -- 
> 2.56.0.455.g6c5a503b38-goog
> 
