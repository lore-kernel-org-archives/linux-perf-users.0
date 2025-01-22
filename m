Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09939186A;
	Wed, 22 Jan 2025 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513112; cv=none; b=OqHMpIrhXcDv7HuvLVc/AusVCnQ6Pv/lxWVgqoB3QpkfjmX1y6d7CiAmmt3I+sY+k6eAbbsLnsBylEZizDIduaMNHx44NXbSN7wuneEyqAU759hCVKrZJJdfxh3F9LR65wKfRbMyS5YoFWA/H3MG/d4FNNEdR3ixzVB/cTSZyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513112; c=relaxed/simple;
	bh=hAXFYSnj9CFuAEQQITFXF1IxiKqTvGWdfka2dfwleRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ehJT9zHpZhs/Rtw8fs23YvuqyhelZJwuMBxOofEeTqzxu2X422SF1/LW6YtR4RcemXDlyNvglW+fVgIwDUNqTkfndCduTX0DpDmCR7qtCbgaxVtbJyIpe5h+oLHTN4j7zMMomzxvx7NafkU3Fmq2FVS+xh1acgYgJl0CYs7hyGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UagMP5dK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UagMP5dK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E547C4CEDF;
	Wed, 22 Jan 2025 02:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513111;
	bh=hAXFYSnj9CFuAEQQITFXF1IxiKqTvGWdfka2dfwleRM=;
	h=From:To:Cc:Subject:Date:From;
	b=UagMP5dKW11Y30DtRVyPQaGQxaZrDlru78J5Rw1ZxhBvtVITBnMAlRwsbXG8JMiS2
	 LZbYMBZ5ieFml5gG1Tsa8unCvgwCbZYwGvEjDuKuwJebgIB81WkHBmOjbLK0sseccg
	 WB/eBC9NWGokcVtUHV04HXsNGdZP8Jwc4HcqilqxB8BDV1x+qcfbPUUMvpOj5mm0h3
	 r+LQPVGWxxj6nB6CctuC1bwXT4H4fMUSFoaNmRD87hpzpZyjD9vM10Zbmn/AMKKCyK
	 cWAl+RJdZ/0k/bjEdf4Hq3xop1+Qw/PAEDjbHebd9DPpYMigSnUVC5kK8LkjGkb47G
	 6VHv5oC9xa4Zg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 00/39] unwind, perf: sframe user space unwinding
Date: Tue, 21 Jan 2025 18:30:52 -0800
Message-ID: <cover.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This took a bit longer than expected.  I fell into some rabbit holes
chasing a number of subtle bugs.  I ended up rewriting the deferral code
several times.  But I think the end result is much better.

The deferral request has a new interface, which helps make the
implementation MUCH simpler and less fragile.  As a bonus it's now
possible for the request implementation to be NMI-safe.

The interface is similar to {task,irq}_work.  The caller owns an
unwind_work struct:

  struct unwind_work {
	struct callback_head		work;
	unwind_callback_t		func;
	int				pending;
  };

For perf, struct unwind_work is embedded in struct perf_event.  For
ftrace maybe it would live in task_struct?

The unwind_work can be passed to the following functions:

  void unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
  int unwind_deferred_request(struct unwind_work *work, u64 *cookie);
  bool unwind_deferred_cancel(struct task_struct *task, struct unwind_work *work);

If unwind_deferred_request() returns success, the callback is
guaranteed.  If the callback is already pending, it returns an error,
but the returned *cookie is still valid if it's nonzero.

Questions:

  - Peter, I'm not sure how well this works with Intel PEBS?  This just
    uses the original task regs, is that a problem?

  - Namhyung, I rebased your perf tool patches on the new missing
    feature validation code, do the patches still look sane?

For testing with user space, here are the latest binutils fixes:

  1785837a2570 ("ld: fix PR/32297")
  938fb512184d ("ld: fix wrong SFrame info for lazy IBT PLT")
  47c88752f9ad ("ld: generate SFrame stack trace info for .plt.got")

An out-of-tree glibc patch is also needed -- will attach in a reply.

Code also available at 

  git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git sframe-v4


v4:
- split up patches better [Andrii]
- add callback guarantee [Andrii]
- support multiple non-contiguous elf text segments [Andrii]
- sframe section validation [Andrii]
- x86 compat mode support [Peter]
- implement guard(mmap_read_lock) [Peter]
- synchronize callback with perf event lifetime [Peter]
- detect toolchain sframe support with CONFIG_SFRAME_AS [Jens]
- get vdso working (with updated glibc patches) [Jens]
- rebase perf tool on new missing feature validation code
- brand new deferred interface and implementation
- make unwind_deferred_request() NMI-safe
- sframe debugging infrastructure
- fix some task_work bugs
- enclose multiple user copies in single STAC/CLAC pair for performance
- much banging head on wall, refactoring, simplification
- fix a lot of bugs


Previous revisions
------------------

v3:
https://lore.kernel.org/cover.1730150953.git.jpoimboe@kernel.org
- move the "deferred" logic out of perf and into unwind_user with new
  unwind_user_deferred() interface [Steven, Mathieu]
- add more sframe sanity checks [Steven]
- make frame pointers optional depending on arch [Jens]
- fix perf event output [Namhyung]
- include Namhyung's perf tool patches
- enable sframe generation in VDSO
- fix build errors [robot]

v2:
https://lore.kernel.org/cover.1726268190.git.jpoimboe@kernel.org
- rebase on v6.11-rc7
- reorganize the patches to add sframe first
- change to sframe v2
- add new perf event type: PERF_RECORD_CALLCHAIN_DEFERRED
- add new perf attribute: defer_callchain

v1:
https://lore.kernel.org/cover.1699487758.git.jpoimboe@kernel.org


Original description
--------------------

Some distros have started compiling frame pointers into all their
packages to enable the kernel to do system-wide profiling of user space.
Unfortunately that creates a runtime performance penalty across the
entire system.  Using DWARF (or .eh_frame) instead isn't feasible
because of complexity and slowness.

For in-kernel unwinding we solved this problem with the creation of the
ORC unwinder for x86_64.  Similarly, for user space the GNU assembler
has created the SFrame ("Simple Frame") v2 format starting with binutils
2.41.

These patches add support for unwinding user space from the kernel using
SFrame with perf.  It should be easy to add user unwinding support for
other components like ftrace.

There were two main challenges:

1) Finding .sframe sections in shared/dlopened libraries

   The kernel has no visibility to the contents of shared libraries.
   This was solved by adding a PR_ADD_SFRAME option to prctl() which
   allows the runtime linker to manually provide the in-memory address
   of an .sframe section to the kernel.

2) Dealing with page faults

   Keeping all binaries' sframe data pinned would likely waste a lot of
   memory.  Instead, read it from user space on demand.  That can't be
   done from perf NMI context due to page faults, so defer the unwind to
   the next user exit.  Since the NMI handler doesn't do exit work,
   self-IPI and then schedule task work to be run on exit from the IPI.

Special thanks to Indu for the original concept, and to Steven and Peter
for helping a lot with the design.  And to Steven for letting me do it ;-)

Josh Poimboeuf (35):
  task_work: Fix TWA_NMI_CURRENT error handling
  task_work: Fix TWA_NMI_CURRENT race with __schedule()
  mm: Add guard for mmap_read_lock
  x86/vdso: Fix DWARF generation for getrandom()
  x86/asm: Avoid emitting DWARF CFI for non-VDSO
  x86/asm: Fix VDSO DWARF generation with kernel IBT enabled
  x86/vdso: Use SYM_FUNC_{START,END} in __kernel_vsyscall()
  x86/vdso: Use CFI macros in __vdso_sgx_enter_enclave()
  x86/vdso: Enable sframe generation in VDSO
  x86/uaccess: Add unsafe_copy_from_user() implementation
  unwind_user: Add user space unwinding API
  unwind_user: Add frame pointer support
  unwind_user/x86: Enable frame pointer unwinding on x86
  perf/x86: Rename get_segment_base() and make it global
  unwind_user: Add compat mode frame pointer support
  unwind_user/x86: Enable compat mode frame pointer unwinding on x86
  unwind_user/sframe: Add support for reading .sframe headers
  unwind_user/sframe: Store sframe section data in per-mm maple tree
  unwind_user/sframe: Add support for reading .sframe contents
  unwind_user/sframe: Detect .sframe sections in executables
  unwind_user/sframe: Add prctl() interface for registering .sframe
    sections
  unwind_user/sframe: Wire up unwind_user to sframe
  unwind_user/sframe/x86: Enable sframe unwinding on x86
  unwind_user/sframe: Remove .sframe section on detected corruption
  unwind_user/sframe: Show file name in debug output
  unwind_user/sframe: Enable debugging in uaccess regions
  unwind_user/sframe: Add .sframe validation option
  unwind_user/deferred: Add deferred unwinding interface
  unwind_user/deferred: Add unwind cache
  unwind_user/deferred: Make unwind deferral requests NMI-safe
  perf: Remove get_perf_callchain() 'init_nr' argument
  perf: Remove get_perf_callchain() 'crosstask' argument
  perf: Simplify get_perf_callchain() user logic
  perf: Skip user unwind if !current->mm
  perf: Support deferred user callchains

Namhyung Kim (4):
  perf tools: Minimal CALLCHAIN_DEFERRED support
  perf record: Enable defer_callchain for user callchains
  perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
  perf tools: Merge deferred user callchains

 arch/Kconfig                              |  40 ++
 arch/x86/Kconfig                          |   3 +
 arch/x86/entry/vdso/Makefile              |  10 +-
 arch/x86/entry/vdso/vdso-layout.lds.S     |   5 +-
 arch/x86/entry/vdso/vdso32/system_call.S  |  10 +-
 arch/x86/entry/vdso/vgetrandom-chacha.S   |   3 +-
 arch/x86/entry/vdso/vsgx.S                |  19 +-
 arch/x86/events/core.c                    |  10 +-
 arch/x86/include/asm/dwarf2.h             |  54 +-
 arch/x86/include/asm/linkage.h            |  29 +-
 arch/x86/include/asm/mmu.h                |   2 +-
 arch/x86/include/asm/perf_event.h         |   2 +
 arch/x86/include/asm/uaccess.h            |  39 +-
 arch/x86/include/asm/unwind_user.h        |  61 +++
 arch/x86/include/asm/unwind_user_types.h  |  17 +
 arch/x86/include/asm/vdso.h               |   1 -
 fs/binfmt_elf.c                           |  49 +-
 include/asm-generic/Kbuild                |   2 +
 include/asm-generic/unwind_user.h         |  24 +
 include/asm-generic/unwind_user_types.h   |   9 +
 include/linux/entry-common.h              |   3 +
 include/linux/mm_types.h                  |   3 +
 include/linux/mmap_lock.h                 |   2 +
 include/linux/perf_event.h                |  15 +-
 include/linux/sched.h                     |   5 +
 include/linux/sframe.h                    |  56 ++
 include/linux/unwind_deferred.h           |  52 ++
 include/linux/unwind_deferred_types.h     |  17 +
 include/linux/unwind_user.h               |  15 +
 include/linux/unwind_user_types.h         |  36 ++
 include/uapi/linux/elf.h                  |   1 +
 include/uapi/linux/perf_event.h           |  19 +-
 include/uapi/linux/prctl.h                |   5 +-
 kernel/Makefile                           |   1 +
 kernel/bpf/stackmap.c                     |  14 +-
 kernel/events/callchain.c                 |  47 +-
 kernel/events/core.c                      | 112 +++-
 kernel/fork.c                             |  14 +
 kernel/sys.c                              |   9 +
 kernel/task_work.c                        |  67 ++-
 kernel/unwind/Makefile                    |   2 +
 kernel/unwind/deferred.c                  | 266 ++++++++++
 kernel/unwind/sframe.c                    | 595 ++++++++++++++++++++++
 kernel/unwind/sframe.h                    |  71 +++
 kernel/unwind/sframe_debug.h              |  95 ++++
 kernel/unwind/user.c                      | 146 ++++++
 mm/init-mm.c                              |   2 +
 tools/include/uapi/linux/perf_event.h     |  19 +-
 tools/lib/perf/include/perf/event.h       |   7 +
 tools/perf/Documentation/perf-script.txt  |   5 +
 tools/perf/builtin-script.c               |  92 ++++
 tools/perf/util/callchain.c               |  24 +
 tools/perf/util/callchain.h               |   3 +
 tools/perf/util/event.c                   |   1 +
 tools/perf/util/evlist.c                  |   1 +
 tools/perf/util/evlist.h                  |   1 +
 tools/perf/util/evsel.c                   |  39 ++
 tools/perf/util/evsel.h                   |   1 +
 tools/perf/util/machine.c                 |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   1 +
 tools/perf/util/sample.h                  |   3 +-
 tools/perf/util/session.c                 |  78 +++
 tools/perf/util/tool.c                    |   2 +
 tools/perf/util/tool.h                    |   4 +-
 64 files changed, 2208 insertions(+), 133 deletions(-)
 create mode 100644 arch/x86/include/asm/unwind_user.h
 create mode 100644 arch/x86/include/asm/unwind_user_types.h
 create mode 100644 include/asm-generic/unwind_user.h
 create mode 100644 include/asm-generic/unwind_user_types.h
 create mode 100644 include/linux/sframe.h
 create mode 100644 include/linux/unwind_deferred.h
 create mode 100644 include/linux/unwind_deferred_types.h
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 include/linux/unwind_user_types.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/deferred.c
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h
 create mode 100644 kernel/unwind/sframe_debug.h
 create mode 100644 kernel/unwind/user.c

-- 
2.48.1

