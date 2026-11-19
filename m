Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106385;
	b=zQGdicM5Wq4bWNkMUqgPddc/vZ3t1M6cuCe3TI6GdeJpxdik3+8Gqjxf2bEAvAGyaC2N
	 3t+MpPWgq2lmbmqlR9NM8DAXJ4kEAVbqeXeD6lpInjT+L6H4ASivCDFXhDJvL8v6Ow1af
	 ZK5uMLudpBI42HmgTq4j1JQHqnRb4xtg+DY2f1iz2KNh3VwjO85STenGdRU2b7MKreVhf
	 hcKBjQBQ37NLn4bfpI24zUntpts4TKHr6bbutTFcNL91ta7fd6TMfC2TUTqfoGCuKvyQk
	 j6o/+jB5QtdrF9WueWtU6fGuP/Cozyy09v0xfJxG4uSW5mcTuTZhVOrTPteHiKRcyLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QZgYvU7eym+6lMDcaT36H7kwBZLKrQ+fCTbEjV93l7A=;
	b=IBRsrbc/acr1OeFq6hSnFQRMAFsFJKrWReJAwunnTCfPx9NwyV71uNfg+J6UhkU44/my
	 LBoE6uz7WoTI7Wnc0uqVXVQ3KFa3u1/Jd/R0zAuloW9ykLQwJgrUzhywHsIVMbljftI/Z
	 AnWBYzt+LA2JoWuo8lVdFJuhIguOg50qhuRvMVlUpUu00cWNukGNIpd4CgJxnygb1RIhq
	 wMv4Yg1r6IzN49Q84ZgcHJR4fYzgxJe14EaySqZAhGxXR+vYz8KPHC0ZebxSLq/WoawLB
	 PuWvze+GdJ9uNeGHRy5BvDz9uVAuYZpWsw9Bo+JQmqDKuMnf+XODFrl7/CesPAsjHFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ggKDXVn8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C651606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 16:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C651606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ggKDXVn8
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55c7445cf85so347871cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 08:39:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795106383; cv=none;
        d=google.com; s=arc-20260327;
        b=Kf3K16BMyfo8yD8hp7szrGy7Z+5ZN/yFhyEfrnMCzRiXviK0F0vNGXHYyeaeXWvYm9
         pzIbekM1OWI1DWCpZVafF7NLxXZJjElvk/Pusjs+kmm6H8uezlncyd7WvwWoCwG0s7WE
         IsACKOHTitbNGXjbHza9lguYYAq787G/iZX2z90Au79p/YIvxRth+R9Y0KI3KwEK13TP
         p4VEeMipvu3kc6mtNR2I3AhW4uXB9Suo+3XX3MRuzWedoHD1pCAbM/Qid8L2VdcK9nLl
         2+BpzbNZJpPERSawbqOQuCaPUW8v+hEaqoKPjc2YUP0fDvQui2TvXXkHZYr3SwG/ttSo
         zQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QZgYvU7eym+6lMDcaT36H7kwBZLKrQ+fCTbEjV93l7A=;
        fh=j5kToHQ1KIrVrkZBVvEFLxZFuHxQ8qlhiIfaZNOWC9c=;
        b=SEhfMhbvAMYKDlTXsWVxFZ7KqYgiY3F+9swE5B2lTsCHieaYL7U/kzZySonFHxP2MT
         VMUOXMJNIwTqDLwuneRgCpiZL784S0eBovsaXX2RXm6RPGmr4c11iGZ1a+tTt5QTUjDt
         UT6Exf78G0l+Jx8+XKiH3MGo+NSupw0mawEllXCmdje8UkoIMDIw5qENw9XawLpQNgM9
         zsRE61GfoGVc22LiENqWFYJfbIeF+ia9VcM+eXPRlS3xJ8CU9HEZuLK/oao6x/sa9MLH
         w4CyEjzNpYPuc8kwqZ6xSmEJopQcJ19nbt4MtbgVvPsH6uwuM8AJRcqGowM7s7jqEkYB
         RJlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795106383; x=1795711183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QZgYvU7eym+6lMDcaT36H7kwBZLKrQ+fCTbEjV93l7A=;
        b=ggKDXVn8EAEn3I/ciecMaxSMbSLVfnDuxOXrQQlT3ojazksFd1ea2BbcYL972plG8d
         fCVKt5Kx/eo505fzzXmb5CTTNst79WunOl09ujtysOuARnZBMkBZCV6QnahCgO/j+ItH
         v5mgM3ETf/S4cv0JxhqCw7lwQOdOXhgfHvTiphU1o57HFc4pyB4NdaxCsKUHIG75acGo
         GBbeb+DVDkxezzrJCNcgX5kY6HsAZghbosdb+BqGedp+rM6yL0xkCDiJ9sGzd/s2JJ65
         T5PVT8x518j2W5cO5bylDIJc4OKJreTeh21SY7P1Jkfy/4ogFaGQHFLY40nJckscZVzt
         ArTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795106383; x=1795711183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZgYvU7eym+6lMDcaT36H7kwBZLKrQ+fCTbEjV93l7A=;
        b=NbsGx0bKETaqC2NRaKEmy6I1L6tIAMQ6qS0bJGj6AzhI/lfLlKmH3LSdVX4uE84Hw5
         7EjLRc8/gzW+RIhYWCe7ygnHPalZAWlBBCGcmPv7RE/7isZN/PL5wRKirrtxRgIlbTr4
         x0pdmjYVQj12ryE/4kCs5kUk0dpg95Aj5xZcZRGLfhZ68COlEtysKmr5yjgs9k005kVc
         bCYgkOYHI4kWS7tZmnKkPcsPkzW4+SAwJFaggfc1OfMMJQswowfHXGxb2/Ig31pnUQPQ
         WYTpHcFmPpVOoWG//fFviaGYf9imR7YTU6YBInOJkeYg3HhpWXmzy/WGMzHl3t+/IJFa
         Ww9w==
X-Forwarded-Encrypted: i=1; AL+hErHHOCbZndO6doybO/AETY9l3hfDSzqTCJf5dq8b7yLVP5PEoO38zYQf2VU770QJZtb9E6R4c5JFMEq/zBerObnB@vger.kernel.org
X-Gm-Message-State: APuU4Z+A+9sdb2XA7svEb30uhcRrWjMIRfRlp7cC3kgIIoXYwRfV5k7E
	B7ukqHljaJwaRMed+6YShRJtP1GHyHPdbBcQ9yZfHOT57pv8QUzQWz1JksPQIsQDnWJyDraDs+A
	Xpog0YrwybizNiqXJ47OGPZKkjzRNUzKFEKUMD9v6
X-Gm-Gg: AYBFou0hu6Lx2sMKUoiy/nQ1UMwAGgzqIIRXylmqn6XGZxYFFN+/K1qxOJ1KNtrmB59
	asUabnsl0Y90FzvN0+5pI3iGMMC9EWHuZMEFwzbR+uV1H28c4Wows3vWUFT6pQdjzqda+SCrY5k
	mlqKWSQ6cbK0aWhynGEc1/yK9A7lLkd7HpU6gwpe8Zb9XSzzB7EqDiDshHidK+eOThhD4bQuPSM
	CqWhcFxMYkIcYMyJcBMGKZMDYA+V94j2XCbH83d/1nKtk97Q0V/QA4hw0dFmgQqmoHtj43/b0v3
	0JQXqX3xFQdXl/xg2rmWYXuthFHNYmh13V3DrO6oz2QQXE7N/7kMlNiEzO1N5jUpqdTCCiAr9lr
	vJGv9DV2Leg9vIAE2GuwXg+wBlmwz0NBHx4/RvjLgf/k6H+FbdnncVlrZq0Q=
X-Received: by 2002:a05:622a:1e95:b0:55b:ab4a:6fad with SMTP id
 d75a77b69052e-55d6f2ee177mr11384171cf.9.1795106382365; Thu, 19 Nov 2026
 08:39:42 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com>
In-Reply-To: <20261113164152.2095566-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 19 Nov 2026 08:39:31 -0800
X-Gm-Features: Aa3M54oEAtzUo1O6L9OpyLmsaNSRCcj6uhOG4546z35DOIs3DLm5JDdREmZI0CU
Message-ID: <CAP-5=fXUg_bDxprNnL6x244zRse2UK1OAUVT13Fvg6PWTHWeYw@mail.gmail.com>
Subject: Re: [PATCH v13 00/21] tools/perf: Adopt kernel compiler-context-analysis.h
 annotations
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 8:41=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
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
>
> v13:
>   - Rebase onto perf-tools-next.
>   - Factor out dso__is_bpf_prog() for dsos__find_kernel_dso_cb() and
>     check ksym_type =3D=3D PERF_RECORD_KSYMBOL_TYPE_BPF &&
>     is_bpf_image(event->ksymbol.name) before setting
>     DSO_BINARY_TYPE__BPF_IMAGE in machine__process_ksymbol_register()
>     (Namhyung).
>   - Prioritize build IDs over inode fields in __dso_id__cmp(),
>     dso__needs_improve_id(), and __dso__improve_id() so an existing DSO
>     with a defined build ID is not updated with inode metadata
>     (Namhyung).
>   - Rewrite patch 15's commit message concisely, fold intel-tpebs lock
>     annotations (with split control_fd/ack_fd declarations) into patch
>     16, and split config and env annotations into standalone patches 17
>     and 18 (Namhyung).

It would be nice to land this series as it touches multiple places in
the code. The series has no Sashiko reported issues:
https://sashiko.dev/#/patchset/20261117184844.99889-1-irogers%40google.com
It has also caught some real bugs, and the bulk of it has been pretty
constant. v1 was sent on 10/13/2026.

Thanks,
Ian

> v12:
>   - Rebase onto perf-tools-next.
>   - Newline-terminate control commands in tpebs_send_record_cmd() so
>     consecutive writes cannot coalesce in evlist__ctlfd_recv(), send
>     SIGTERM in tpebs_stop() if ENABLE had not completed (tpebs_enabled,
>     annotated __guarded_by(&tpebs_mtx) in patch 17) or sending STOP
>     fails, and ignore late samples in process_sample_event() once
>     tpebs_stopping is set.
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
>   - Reset tpebs_cmd.pid =3D 0 and return early without setting
>     t->started =3D true if start_command() fails in
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
>   - Reset tpebs_cmd.out =3D -1 if start_command() fails and include
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
>     tpebs_cmd.out =3D -1 in evsel__tpebs_open() to avoid a double-close i=
n
>     tpebs_stop(), and clarify the config_set_mutex comment.
>   - Drop maps__lock before calling map__load() in maps__load_first() to
>     avoid a read-to-write self-deadlock when loading kernel maps inserts
>     additional trampoline maps.
>
> Ian Rogers (21):
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
>   perf intel-tpebs: Use DEFINE_MUTEX for tpebs_mtx and add lock
>     annotations
>   perf config: Add __guarded_by and __must_hold annotations
>   perf env: Add __guarded_by and __must_hold annotations
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
>  tools/perf/util/dso.c                         | 179 +++---
>  tools/perf/util/dso.h                         |  33 +-
>  tools/perf/util/dsos.c                        |  34 +-
>  tools/perf/util/dsos.h                        |  12 +-
>  tools/perf/util/env.c                         |   1 +
>  tools/perf/util/env.h                         |  19 +-
>  tools/perf/util/intel-tpebs.c                 | 226 +++++---
>  tools/perf/util/libbfd.c                      |   4 +-
>  tools/perf/util/machine.c                     |  34 +-
>  tools/perf/util/map.c                         |  14 +-
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
>  38 files changed, 1531 insertions(+), 571 deletions(-)
>
>
> base-commit: 4af65363b11fc4fe65fcb497f68bbe4f3e3a4d2c
> --
> 2.56.1.703.gf848ed807c-goog
>
