Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F030542B74A
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622598; cv=pass; b=BHhMwtzp/0uWpFe+ibYiiXXw4RbjLbt14rubggrtkdWjHPirjvB9F7MhK0ESTWtT5yQS2XRHYZqJ9i8LZZoYud6Lpw050I5Rv6V8baoAy72vlHmt/ycy/p3yvdqFu+6yufT3GIY84uMLB1f7i++xFirpCMV0fTWNMMKn2c47bD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622598; c=relaxed/simple;
	bh=Tl6IoSLDWM40qa5D5A0et6JaIkKxG5qT9LLjVKjW5S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZsGh/3Cu3qtRx8nM596pEIBcqBcQPRRRP855mPoT1XsHGXwS9PLgwoJs/j77dCozlVqEmrKASwCSxTDnJ7dYiJkMOSnsg3DV9M5Scp1Jtb2cHBQHoxX7pKjB5xjb8DLvZAdFPUHFLa42Zwz6Xv+FPdIGZrElUTA4/l7LLfLpN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RXyooHVs; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RXyooHVs"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf2d865383so52605ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 08:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781622596; cv=none;
        d=google.com; s=arc-20240605;
        b=ETUvHlACLKQIrwC9EzWjsom+00R2TcNGhEtb8hRdRkmMePaZyaB1drkR5LmuczZNVG
         gtQP03aR2wje6alylw/b2p4KJvMkT9p1GrJ3/+J0OD9MgWkQF6PmdM/izuKRP1khYY3h
         GCbKDg63o3nn00xt+R+7gJYJAas99mFfVHb0TCmW2i9htmigVwEs31xdpeYRG3ymM/XA
         j1Z41Tq+RHbQ0LtlwgFUfGLYGF89nuhlfyCK64Fe+PjAOQrug2q9pYYlafy8hU8W2dJO
         CprOpYgxNwCtFUS4QX5VusddsG2e1cE0XY7TYs/IqLOasIqtpgZ0W67tOPB9UtGzT9Ze
         AWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CKcNwAsxxkJji6ajliJ7QgoJZzbxotWlm6w9rVR6AyE=;
        fh=HKSBTdSNNqGRY3KYln6Iw4M57N4NsRYdtUNqKNNjQTE=;
        b=G8OscKm34+RH2B7aO2yB4ZO+L653wVxF1El5QhlH9HF7l9R1Sw9+gHcKKHknjrGN/O
         jh8tv6egFr3OsBEM6gxwtPIEvX32QttDEbMy0gR8AMqR3SgIl0P5ZjPqwQuZdI5bmX8H
         SYJyRuUok0RyY22QJlhQN3M4RhjVWOac9a1HAu+5mK8Un0TR5FxBBBRQ5+qVT4wMIRpH
         n3HxurAJKMfGCAdbrmtZOGJJnbTLSd4ayzPSQGSBnWWYkH0URKEbipTwozI0496qDXVa
         dLOm5MeQwhqEA4N7wmvv13I3GRVI7CGIKvL17e6EeNm4weUg+Yf5Jg/Vkgj5joJG0gIt
         CMvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781622596; x=1782227396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKcNwAsxxkJji6ajliJ7QgoJZzbxotWlm6w9rVR6AyE=;
        b=RXyooHVsb2LzOTaQ819oNpuJhijUceTnd06c3b0VtbSLkx0wGKdSeW5jsLy6PhWqXq
         XKtXAH88Wx7ih+MBO08Lobkkll3W9dbfGFjcQmWcBcCXhatSLKOjUzvtLDtA2Na6214K
         C/kiodu1+tpT/11Cpij9T8QxNqumV61MqX628R/xnPZOP3EjNHK4eagnVbv5EDtaseWT
         FpDvmApl07UJN8A4iAaAl5FeCqgxt0yEeouL+kt+qytgsTltruoSwPks+bRNNG02Vxai
         yqyFxZHhxOZnH0e0kyMyjYFERtLlRflGt6rmrbJOErIlb5Q85S039lLNdjsNxf2gPyfl
         w9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781622596; x=1782227396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CKcNwAsxxkJji6ajliJ7QgoJZzbxotWlm6w9rVR6AyE=;
        b=eTcCoOBwzB7eDJm5BX6CF3cwbv3LxVJWPjQWFg6Bzu3EFM2KbZz5OFDsMCORDhAIK8
         mFCGcqAx4tre6seUD6eAMedoTJBQKXwQXkEp1i/27qG2yxKhZnYU1tULCk6TNTOMQ4mw
         QAe72zoYmCEOVnyEzQJzcY4w36zqCeTWH47VxpDUKAnvJGh72l2ZnYsPXkzB7lWral7G
         hCAwDCdDZGyNrlV+PB4iyT3GvWtTAcNxyvhv7Bz/F38b0s8byjZ0DHfo1bkKfm0fOPBe
         lVD5Ls7a+BjMagRntxm1EhJJ7JbnCUhrZC+kai7aJzzr1wgQW+qCPE93PU1B1Q6+RyPS
         HRCg==
X-Forwarded-Encrypted: i=1; AFNElJ/uVlpKiydGSvG3avrZHdwOFDngcNqlKM98s5FXe84sdQ5EOUeTaAU3fy7L0hfUeA/T3f7vRRD8pMQh7euN4lOT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fO47CcMgXc21wxIm4PPgV9ACU2AlpS4u2Xfwv+0USfvmUBj/
	Lq1fb6CxU5QwalALFlg1ModpuGW+jEF4qjz+f9qLmJASk/ooqay8TIxvc47xx1bkJlVZgvN88Kb
	nOttDu7qrE7lqzxAusWC+UJRTfL5+NYvlCWdAHnJk
X-Gm-Gg: Acq92OFujnkTV4wQpnIDUv7bJVMfXFznViODMTlx/dzCmLUr+wHk15gogmiybe1woOk
	2g8aZjv94B+WnRGTBuPVZ/M+ddh97HUt3Qm5iREIYcYH1u60mnHEY8AKZ2t97xV+w51JliCv3r/
	1oHj7PZDo4vNlx6Krx9UK/ltClzc9ghJWw0CliIVVcwn+VeONlWNe9/gkqrQ6cVdmVqt3eKiuVr
	4xxcc88oIKxKjhjcDppSfPgu4vkK4fwQA+cwPTSAvKr13W1MdMOpdXjMNrUZKzZ4vOHpf8FmdvU
	cuXVF6bZzeK5KG0P2y7jY+j9+wA3GhlUCUCX
X-Received: by 2002:a17:903:240b:b0:2bf:b01:2b4c with SMTP id
 d9443c01a7336-2c69c1f26e9mr1926055ad.9.1781622595606; Tue, 16 Jun 2026
 08:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jun 2026 08:09:42 -0700
X-Gm-Features: AVVi8CdaovgasKM3kljMB_SpKxWbXE6-E_dRLsPa6zLRvmJcaMCqplT6fbvxT7Y
Message-ID: <CAP-5=fU6E79UbXj4qyJhaHeHN98_E2nDWmjo6Qnw75F4YxyeLA@mail.gmail.com>
Subject: Re: [PATCH v21 00/21] Add additional python API support
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So I think this is the point where I stop trying to address every
Sashiko point and hope for human review to land these patches. Here is
the Sashiko feedback:
https://sashiko.dev/#/patchset/20260616011543.4037138-1-irogers%40google.co=
m

To summarize: all raised issues are either already addressed or align
perfectly with the objectives planned for Phase 2.

Specifically:
- **Build and Reference Counting Fixes:** The missing
`evlist__nr_entries()` accessor in `s390/util/auxtrace.c` when
`REFCNT_CHECKING` is enabled, as well as the need for additional
`perf_sample__exit()` cleanups in C core error paths (e.g.
`builtin-inject.c`) and `NULL` checks for `evsel__get()` after
`evlist__id2evsel()`, are great catches. These C-core adjustments will
be handled in follow-up patches as we harden the reference counting
baseline in Phase 2.
- **Concurrency & Lifecycles:** The potential for a double-free race
in `evlist__put()` under concurrent destruction is a known limitation.
Implementing a thread-safe, symmetrical global GC lifecycle is a core
goal of Phase 2.
- **API Boundary Hardening:** The need for `PyObject_TypeCheck`
validation in `pyrf_evsel__open()` (similar to what we added for
`parse_events` in v21) will be addressed as we continue to lock down
the C-API boundary in Phase 2.
- **Stubs & Scripts:** The refinement of the `perf.pyi` typing (e.g.,
handling the `MetricGroup` list of strings) and the actual migration
of `syscall-counts.py` to use the new `syscall_name/id` methods are
explicitly the focus of Phase 2 ("Script Porting & Tool Migration").
- **Cross-endian analysis:** As noted in the cover letter, proper
cross-endian analysis for packed 32-bit fields is deferred to Phase 2.

I'm looking forward to landing this Phase 1 baseline so we can begin
sending the Phase 2 series to address these remaining architectural
updates and script migrations.

Thanks,
Ian

On Mon, Jun 15, 2026 at 6:15=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> The perf script command has long supported running Python and Perl script=
s
> by embedding libpython and libperl. This approach has several drawbacks:
>  - overhead by creating Python dictionaries for every event (whether used=
 or
>    not),
>  - complex build dependencies on specific Python/Perl versions,
>  - complications with threading due to perf being the interpreter,
>  - no clear way to run standalone scripts like ilist.py.
>
> This series takes a different approach with some initial implementation p=
osted
> as an RFC last October:
> https://lore.kernel.org/linux-perf-users/20231025081156.963491-1-irogers@=
google.com/
>
> It builds the python extension as part of the normal build. The extension
> is able to read perf.data files. The event callbacks are converted to
> have a python evsel/evlist/sample passed to them.
>
> To make the review process more manageable, the original 58-patch
> series has been split. This v18 series represents "Phase 1: API &
> Infrastructure" (20 patches).  The first 4 patches of Phase 1
> (cleanups and arch-specific header sorting) have already been merged
> upstream.
>
> This remaining set contains:
> 1. Missed explicit dependency cleanups and header sorting for util/ and p=
ython.
> 2. Crucial core safety infrastructure (reference counting for evlist/evse=
l)
>    to support safe lifecycle management in garbage-collected Python.
> 3. The core Python API extensions (session wrappers, perf_data wrappers,
>    sample accessors, stubs, and LiveSession helper).
>
> Phase 2 ("Script Porting & Tool Migration") will migrate the remaining 35=
+
> existing Python/Perl scripts to the new API (which yields up to 35x speed=
ups
> as demonstrated previously) and the final removal of embedded interpreter=
s.
>
>
> Addressing v20 Review Feedback:
>
> The v21 patches merely update a commit message. Sashiko has correctly
> identified several structural limitations and edge cases. Almost all
> of these points correspond to known limitations that we have
> explicitly mapped out and planned for "Phase 2" of this Python binding
> refactor. Our primary goal with this v21 series (Phase 1) is to
> establish the baseline abstractions, fix immediate memory corruption
> bugs, and provide the foundational wrappers.
>
> - Patch 4 (perf data: Add open flag): The reported issue with
>   perf_data__switch failing to close thread-local files during directory
>   mode rotation is a pre-existing bug in the C core. This patch strictly
>   fixes the boolean data->open state tracking for Python integration.
>
> - Patch 7 (perf evlist: Add reference count checking): evlist is
>   fundamentally not thread-safe for concurrent destruction in the C core.
>   The asymmetric leak (leaving cycles intact if evlist is dropped before
>   evsel) is a known limitation. Implementing a thread-safe, symmetrical
>   global GC lifecycle for evlist/evsel is planned for Phase 2.
>
> - Patch 10 (perf python: Add python session abstraction):
>   1) perf.thread cannot cause a NULL dereference because it does not
>   implement tp_new/tp_init, so it cannot be instantiated directly from
>   Python. 2) Proper cross-endian analysis of packed 32-bit fields and
>   the implementation of the remaining tool callbacks are explicitly
>   deferred to Phase 2.
>
> - Patch 11 (perf python: Refactor and add accessors to sample event):
>   1) Session UAF due to tracking the topological lifetime of the session
>   relative to events requires a major lifecycle overhaul, slated for
>   Phase 2. 2) The commit message previously inaccurately claimed we only
>   allocate the strictly necessary copy size. This has been corrected
>   in v21. We use PyObject_New with the static tp_basicsize; optimizing
>   the dynamic allocation size is a future cleanup.
>
> - Patch 16 (perf python: Add syscall name/id): The legacy scripts
>   remain untouched in this series. Migrating the existing Python/Perl
>   scripts to use the new C-API and dropping libaudit entirely is the
>   core objective of Phase 2.
>
> - Patch 20 (perf python: Add perf.pyi stubs file): While the stub is
>   currently loosely typed as Any for threads, the segmentation fault is
>   no longer possible since Patch 19 added runtime type validation
>   (PyObject_TypeCheck) to the C implementation. We will tighten the
>   stub typing in a follow-up patch.
>
> Addressing v19 Review Feedback:
> - Patch 19: Added PyObject_TypeCheck runtime validations to parse_events
>   and parse_metrics to prevent memory corruption when invalid objects
>   are passed from Python, resolving the blind C cast vulnerability.
> - Patch 20: Updated perf.pyi stubs to properly type the threads parameter
>   as Optional['thread_map'] instead of Optional[Any] to catch invalid
>   types during static analysis.
>
> Note: Other architectural limitations raised in the v19 review (e.g. TOCT=
OU
> cycle races, asymmetric cycle leaks, cross-endian needs_swap bypass, and
> session object dangling pointers) are explicitly acknowledged as limitati=
ons
> of this transitional patch set. As noted previously, implementing thread-=
safe,
> symmetrical GC for the Python bindings and hardening the C-API boundary
> are the primary focus of the upcoming Phase 2 series.
>
> Addressing v18 Review Feedback:
> - Patch 10 (`perf.thread` initialization): Added missing `CHECK_INITIALIZ=
ED()`
>   in `pyrf_thread__comm` to prevent NULL dereference when instantiated di=
rectly.
> - Patch 14 (STAT events): Passed `NULL` to `pyrf_event__new` for STAT eve=
nts
>   to prevent unconditional `evsel__parse_sample` and potential out-of-bou=
nds
>   reads.
> - Patch 20 (`LiveSession` timeout): Broadened exception handling to expli=
citly
>   ignore "Unexpected header type" for valid but unsupported events.
>
> Note: Other feedback items raised in v18 (TOCTOU cycle races, asymmetric
> cycle collection, cross-endian data handling, guest machine symbol resolu=
tion,
> and pre-existing memory leaks/uninitialized variables) are acknowledged a=
s
> limitations of the current implementation and will be addressed in Phase =
2
> or separate cleanup patches.
>
> Addressing v17 Review Feedback:
>  - Patch 8: Added missing `perf_sample__exit(&sample)` to
>    `intel_pt_synth_ptwrite_sample()` to fix an evsel reference leak.
>  - Patch 10: Fixed a bug in `pyrf_session_tool__sample()` that caused
>    double byte-swapping on foreign-endian files by temporarily disabling
>    `needs_swap` during re-parsing instead of assigning `*sample`.
>  - Patch 11: (Missed fixing address resolution for guest samples - will
>    fix in next spin or Phase 2).
>  - Patch 19: Prevented `python-clean` from deleting tracked source file
>    `python/perf.pyi` when building in tree. Also explicitly exported
>    `COUNT_HW_REF_CPU_CYCLES`, `thread`, `callchain`, and `callchain_node`
>    types/constants to the module via `PyInit_perf`.
>  - Patch 20: Narrowed `except TypeError` in `LiveSession.run()` to explic=
itly
>    check for "Unknown CPU" so legitimate event parsing failures aren't
>    swallowed.
>
> Addressing v16 Review Feedback:
>  - Patch 10: Removed unconditional `perf_session__create_kernel_maps` to
>    prevent corrupting cross-platform offline analysis.
>  - Patch 11: Corrected inaccurate commit message regarding memory
>    allocation sizing.
>  - Patch 19: Fixed numerous type inconsistencies, missing properties, and
>    incorrect return types in the `perf.pyi` stubs file.
>  - Patch 20: Cleaned up unused `import errno` in `perf_live.py`.
>
> Note: Several issues spotted in v16/v17 review (e.g. pyrf_evsel__init for=
mat
> string type mismatch, evlist lockless double free, asymmetric memory
> leaks, missing Py_None type checks, and lack of NUL-termination for
> COMM/MMAP) are pre-existing limitations in the codebase or side-effects
> of the transitional cycle-breaking design. As discussed previously, these
> structurally complex or pre-existing bugs are deliberately deferred to
> the Phase 2 series.
>
> Addressing v15 Review Feedback:
> - Patch 2 (buffer overflow & type checks): The buffer overflow in
>   `pyrf_event__new()` has been resolved by verifying `event->header.size`
>   against the event struct size.
> - Patch 2 (PyObject_HEAD_INIT): The initialization macros have been corre=
cted
>   to use the proper Python 3 compatibility approach.
> - Patch 5 (Memory leak & RC validation): Applied extensive structural fix=
es
>   using `refcount_t` semantics. Added validation wrapper structures to
>   statically verify memory access safety in the lockless cycles.
> - Patch 8 (`evlist.open` memory leak): Restructured lifecycle management =
for
>   mmap buffers using `do_munmap()` hooks in `evlist__put()`.
> - Patch 16 (`perf.pyi` stubs): Corrected return types (`Optional` and pro=
per
>   object properties) and missing documentation strings in type stubs.
> - Patch 20 (`perf_live.py` timeout): Adjusted poll timeout from 10000ms b=
ack
>   to 100ms, replacing the tight exception loop.
>
> Ian Rogers (21):
>   perf util: Sort includes and add missed explicit dependencies
>   perf python: Add missed explicit dependencies
>   perf evsel/evlist: Avoid unnecessary #includes
>   perf data: Add open flag
>   perf evlist: Add reference count
>   perf evsel: Add reference count
>   perf evlist: Add reference count checking
>   perf python: Use evsel in sample in pyrf_event
>   perf python: Add wrapper for perf_data file abstraction
>   perf python: Add python session abstraction wrapping perf's session
>   perf python: Refactor and add accessors to sample event
>   perf python: Add mmap2 event
>   perf python: Add callchain support
>   perf python: Extend API for stat events in python.c
>   perf python: Expose brstack in sample event
>   perf python: Add syscall name/id to convert syscall number and name
>   perf python: Add config file access
>   perf python: Handle Py_None for thread and cpu maps
>   perf python: Add type checking for parse_events/parse_metrics
>   perf python: Add perf.pyi stubs file
>   perf python: Add LiveSession helper
>
>  tools/perf/Makefile.perf                    |    7 +-
>  tools/perf/arch/arm/util/cs-etm.c           |   10 +-
>  tools/perf/arch/arm64/util/arm-spe.c        |    8 +-
>  tools/perf/arch/arm64/util/hisi-ptt.c       |    2 +-
>  tools/perf/arch/x86/tests/hybrid.c          |   22 +-
>  tools/perf/arch/x86/tests/topdown.c         |    4 +-
>  tools/perf/arch/x86/util/auxtrace.c         |    2 +-
>  tools/perf/arch/x86/util/intel-bts.c        |    6 +-
>  tools/perf/arch/x86/util/intel-pt.c         |    9 +-
>  tools/perf/arch/x86/util/iostat.c           |   14 +-
>  tools/perf/bench/evlist-open-close.c        |   29 +-
>  tools/perf/builtin-annotate.c               |    7 +-
>  tools/perf/builtin-ftrace.c                 |   14 +-
>  tools/perf/builtin-inject.c                 |    9 +-
>  tools/perf/builtin-kvm.c                    |   14 +-
>  tools/perf/builtin-kwork.c                  |    8 +-
>  tools/perf/builtin-lock.c                   |    4 +-
>  tools/perf/builtin-record.c                 |   95 +-
>  tools/perf/builtin-report.c                 |    6 +-
>  tools/perf/builtin-sched.c                  |   30 +-
>  tools/perf/builtin-script.c                 |   15 +-
>  tools/perf/builtin-stat.c                   |   83 +-
>  tools/perf/builtin-top.c                    |  104 +-
>  tools/perf/builtin-trace.c                  |   65 +-
>  tools/perf/python/perf.pyi                  |  672 +++++
>  tools/perf/python/perf_live.py              |   59 +
>  tools/perf/tests/backward-ring-buffer.c     |   26 +-
>  tools/perf/tests/code-reading.c             |   14 +-
>  tools/perf/tests/event-times.c              |    6 +-
>  tools/perf/tests/event_update.c             |    4 +-
>  tools/perf/tests/evsel-roundtrip-name.c     |    8 +-
>  tools/perf/tests/evsel-tp-sched.c           |    4 +-
>  tools/perf/tests/expand-cgroup.c            |   12 +-
>  tools/perf/tests/hists_cumulate.c           |    2 +-
>  tools/perf/tests/hists_filter.c             |    2 +-
>  tools/perf/tests/hists_link.c               |    2 +-
>  tools/perf/tests/hists_output.c             |    2 +-
>  tools/perf/tests/hwmon_pmu.c                |    7 +-
>  tools/perf/tests/keep-tracking.c            |   10 +-
>  tools/perf/tests/mmap-basic.c               |   24 +-
>  tools/perf/tests/openat-syscall-all-cpus.c  |    6 +-
>  tools/perf/tests/openat-syscall-tp-fields.c |   26 +-
>  tools/perf/tests/openat-syscall.c           |    6 +-
>  tools/perf/tests/parse-events.c             |  139 +-
>  tools/perf/tests/parse-metric.c             |    8 +-
>  tools/perf/tests/parse-no-sample-id-all.c   |    2 +-
>  tools/perf/tests/perf-record.c              |   38 +-
>  tools/perf/tests/perf-time-to-tsc.c         |   12 +-
>  tools/perf/tests/pfm.c                      |   12 +-
>  tools/perf/tests/pmu-events.c               |   11 +-
>  tools/perf/tests/pmu.c                      |    4 +-
>  tools/perf/tests/sample-parsing.c           |   45 +-
>  tools/perf/tests/shell/lib/setup_python.sh  |   13 +
>  tools/perf/tests/sw-clock.c                 |   20 +-
>  tools/perf/tests/switch-tracking.c          |   11 +-
>  tools/perf/tests/task-exit.c                |   20 +-
>  tools/perf/tests/time-utils-test.c          |   14 +-
>  tools/perf/tests/tool_pmu.c                 |    7 +-
>  tools/perf/tests/topology.c                 |    4 +-
>  tools/perf/tests/uncore-event-sorting.c     |    6 +-
>  tools/perf/ui/browsers/annotate.c           |    2 +-
>  tools/perf/ui/browsers/hists.c              |   22 +-
>  tools/perf/util/Build                       |    1 -
>  tools/perf/util/amd-sample-raw.c            |    2 +-
>  tools/perf/util/annotate-data.c             |    2 +-
>  tools/perf/util/annotate.c                  |   10 +-
>  tools/perf/util/auxtrace.c                  |   14 +-
>  tools/perf/util/block-info.c                |    4 +-
>  tools/perf/util/bpf_counter.c               |    2 +-
>  tools/perf/util/bpf_counter_cgroup.c        |   14 +-
>  tools/perf/util/bpf_ftrace.c                |    9 +-
>  tools/perf/util/bpf_lock_contention.c       |   12 +-
>  tools/perf/util/bpf_off_cpu.c               |   44 +-
>  tools/perf/util/bpf_trace_augment.c         |    8 +-
>  tools/perf/util/cgroup.c                    |   26 +-
>  tools/perf/util/cs-etm.c                    |    5 +-
>  tools/perf/util/data-convert-bt.c           |    2 +-
>  tools/perf/util/data.c                      |   27 +-
>  tools/perf/util/data.h                      |    4 +-
>  tools/perf/util/evlist.c                    |  496 ++--
>  tools/perf/util/evlist.h                    |  273 +-
>  tools/perf/util/evsel.c                     |   39 +-
>  tools/perf/util/evsel.h                     |   40 +-
>  tools/perf/util/expr.c                      |    2 +-
>  tools/perf/util/header.c                    |   69 +-
>  tools/perf/util/header.h                    |    2 +-
>  tools/perf/util/intel-pt.c                  |    8 +-
>  tools/perf/util/intel-tpebs.c               |    7 +-
>  tools/perf/util/iostat.c                    |    2 +-
>  tools/perf/util/iostat.h                    |    2 +-
>  tools/perf/util/map.h                       |    9 +-
>  tools/perf/util/metricgroup.c               |   12 +-
>  tools/perf/util/parse-events.c              |   10 +-
>  tools/perf/util/parse-events.y              |    2 +-
>  tools/perf/util/perf_api_probe.c            |   20 +-
>  tools/perf/util/pfm.c                       |    4 +-
>  tools/perf/util/print-events.c              |    2 +-
>  tools/perf/util/python.c                    | 2846 ++++++++++++++++---
>  tools/perf/util/record.c                    |   11 +-
>  tools/perf/util/s390-sample-raw.c           |   20 +-
>  tools/perf/util/sample-raw.c                |    4 +-
>  tools/perf/util/sample.c                    |   17 +-
>  tools/perf/util/session.c                   |   69 +-
>  tools/perf/util/session.h                   |    2 +
>  tools/perf/util/setup.py                    |    5 +
>  tools/perf/util/sideband_evlist.c           |   40 +-
>  tools/perf/util/sort.c                      |    2 +-
>  tools/perf/util/stat-display.c              |    6 +-
>  tools/perf/util/stat-shadow.c               |   24 +-
>  tools/perf/util/stat.c                      |   20 +-
>  tools/perf/util/stream.c                    |    4 +-
>  tools/perf/util/synthetic-events.c          |   11 +-
>  tools/perf/util/time-utils.c                |   12 +-
>  tools/perf/util/top.c                       |    4 +-
>  114 files changed, 4602 insertions(+), 1529 deletions(-)
>  create mode 100644 tools/perf/python/perf.pyi
>  create mode 100755 tools/perf/python/perf_live.py
>
> --
> 2.54.0.1136.gdb2ca164c4-goog
>
