Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300F2038B1;
	Mon, 28 Oct 2024 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152110; cv=none; b=aWv8NygEh4DqT+Ptx5RWTcBsDlD173jhjSp9AJ6NPTVAvFgUJVV7j7jGIzitPogWtsDJEpMs+KsDR0DAq06BabH+E//rCzG27QO1BgLKwo5fywc+lQAp8ns7H52r8k/3EkBN7DmKO+A1nO3YJ8qGclIytFdf1e+rGdwWuj1I0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152110; c=relaxed/simple;
	bh=DigfQVMbSZDd+BKHqmNjpUWl4LLpGFKZjeEsBqtUWCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpMi+QNRV2Z7s192OiiiqrhW2XTAe5+nuv8btuguiVdSpw8Pj7UzvMZM8j2aPrXhfptcvSKnWhuX3VWBSqzhAHvsv95aaXmDmAwPwP12KNxLnpMA4NItU0pHYsetxXjZrFyeHhmMwHtUqpEzEthjsFcX/g833yP1rEJpJFEz9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+Jgqq9j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+Jgqq9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CD6C4CEED;
	Mon, 28 Oct 2024 21:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152110;
	bh=DigfQVMbSZDd+BKHqmNjpUWl4LLpGFKZjeEsBqtUWCE=;
	h=From:To:Cc:Subject:Date:From;
	b=p+Jgqq9jTSGn5bxXQHDbX2uz1VC7GG7Om2cmA/F9wby208fOF1v5Xr7wdewaA6LE5
	 djYu+vrvmnlohoUORXmREvnxm2ieEdWRr/tdYk6fftyhW6pisSzo44o+vN+NsJK7jK
	 kzkTtORXIoCK7vjwJTtA9u6kpWTdGbMMajKPmtxszfR2pNUYpkTAPMPe3ACjrKszhz
	 5DHSEjfWyibDTMFUBbcSQYmRXaY10i73oxfotGRUGLM42bmwhGHVZdylm0jjslrKFT
	 eqbWLGzAzzPePlalu3xqm6WsuOrotwep0WyXi0sk1DU1MMcpkJr2Q/uC9Fp68fju9I
	 rEmU9104azwtg==
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
	linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 00/19] unwind, perf: sframe user space unwinding
Date: Mon, 28 Oct 2024 14:47:47 -0700
Message-ID: <cover.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20241028214747.iF-DIhGLGS65g6_Cgu_MYlMSAA1sixOMEs_--Foy1CA@z>

This has all the changes discussed in v2, plus VDSO sframe support and
Namhyung's perf tool patches (see detailed changelog below).

I did quite a bit of testing, it seems to work well.  It still needs
some binutils and glibc patches which I'll send in a reply.

Questions for perf experts:

  - Is the perf_event lifetime managed correctly or do we need to do
    something to ensure it exists in unwind_user_task_work()?

    Or alternatively is the original perf_event even needed in
    unwind_user_task_work() or can a new one be created on demand?

  - Is --call-graph=sframe needed for consistency?

  - Should perf use the context cookie?  Note that because the callback
    is usually only called once for multiple NMIs in the same entry
    context, it's possible for the PERF_RECORD_CALLCHAIN_DEFERRED event
    to arrive *before* some of the corresponding kernel events.  The
    context cookie disambiguates the corner cases.

Based on tip/master.

Also at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git sframe-v3


v3:
- move the "deferred" logic out of perf and into unwind_user with new
  unwind_user_deferred() interface [Steven, Mathieu]
- add more sframe sanity checks [Steven]
- make frame pointers optional depending on arch [Jens]
- fix perf event output [Namhyung]
- include Namhyung's perf tool patches
- enable sframe generation in VDSO
- fix build errors [robot]

v2: https://lore.kernel.org/cover.1726268190.git.jpoimboe@kernel.org
- rebase on v6.11-rc7
- reorganize the patches to add sframe first
- change to sframe v2
- add new perf event type: PERF_RECORD_CALLCHAIN_DEFERRED
- add new perf attribute: defer_callchain

v1: https://lore.kernel.org/cover.1699487758.git.jpoimboe@kernel.org

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



Josh Poimboeuf (15):
  x86/vdso: Fix DWARF generation for getrandom()
  x86/asm: Avoid emitting DWARF CFI for non-VDSO
  x86/asm: Fix VDSO DWARF generation with kernel IBT enabled
  x86/vdso: Use SYM_FUNC_{START,END} in __kernel_vsyscall()
  x86/vdso: Use CFI macros in __vdso_sgx_enter_enclave()
  x86/vdso: Enable sframe generation in VDSO
  unwind: Add user space unwinding API
  unwind/x86: Enable CONFIG_HAVE_UNWIND_USER_FP
  unwind: Introduce sframe user space unwinding
  unwind/x86: Enable CONFIG_HAVE_UNWIND_USER_SFRAME
  unwind: Add deferred user space unwinding API
  perf: Remove get_perf_callchain() 'init_nr' argument
  perf: Remove get_perf_callchain() 'crosstask' argument
  perf: Simplify get_perf_callchain() user logic
  perf: Add deferred user callchains

Namhyung Kim (4):
  perf tools: Minimal CALLCHAIN_DEFERRED support
  perf record: Enable defer_callchain for user callchains
  perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
  perf tools: Merge deferred user callchains

 arch/Kconfig                              |  14 +
 arch/x86/Kconfig                          |   2 +
 arch/x86/entry/vdso/Makefile              |   6 +-
 arch/x86/entry/vdso/vdso-layout.lds.S     |   5 +-
 arch/x86/entry/vdso/vdso32/system_call.S  |  10 +-
 arch/x86/entry/vdso/vgetrandom-chacha.S   |   3 +-
 arch/x86/entry/vdso/vsgx.S                |  19 +-
 arch/x86/include/asm/dwarf2.h             |  40 ++-
 arch/x86/include/asm/linkage.h            |  29 +-
 arch/x86/include/asm/mmu.h                |   2 +-
 arch/x86/include/asm/unwind_user.h        |  11 +
 arch/x86/include/asm/vdso.h               |   1 -
 fs/binfmt_elf.c                           |  35 +-
 include/linux/entry-common.h              |   3 +
 include/linux/mm_types.h                  |   3 +
 include/linux/perf_event.h                |  12 +-
 include/linux/sched.h                     |   5 +
 include/linux/sframe.h                    |  41 +++
 include/linux/unwind_user.h               |  99 ++++++
 include/uapi/linux/elf.h                  |   1 +
 include/uapi/linux/perf_event.h           |  22 +-
 include/uapi/linux/prctl.h                |   3 +
 kernel/Makefile                           |   1 +
 kernel/bpf/stackmap.c                     |  14 +-
 kernel/events/callchain.c                 |  47 +--
 kernel/events/core.c                      |  70 +++-
 kernel/fork.c                             |  14 +
 kernel/sys.c                              |  11 +
 kernel/unwind/Makefile                    |   2 +
 kernel/unwind/sframe.c                    | 380 ++++++++++++++++++++++
 kernel/unwind/sframe.h                    | 215 ++++++++++++
 kernel/unwind/user.c                      | 318 ++++++++++++++++++
 mm/init-mm.c                              |   6 +
 tools/include/uapi/linux/perf_event.h     |  22 +-
 tools/lib/perf/include/perf/event.h       |   7 +
 tools/perf/Documentation/perf-script.txt  |   5 +
 tools/perf/builtin-script.c               |  92 ++++++
 tools/perf/util/callchain.c               |  24 ++
 tools/perf/util/callchain.h               |   3 +
 tools/perf/util/event.c                   |   1 +
 tools/perf/util/evlist.c                  |   1 +
 tools/perf/util/evlist.h                  |   1 +
 tools/perf/util/evsel.c                   |  32 +-
 tools/perf/util/evsel.h                   |   1 +
 tools/perf/util/machine.c                 |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   1 +
 tools/perf/util/sample.h                  |   3 +-
 tools/perf/util/session.c                 |  78 +++++
 tools/perf/util/tool.c                    |   2 +
 tools/perf/util/tool.h                    |   4 +-
 50 files changed, 1634 insertions(+), 88 deletions(-)
 create mode 100644 arch/x86/include/asm/unwind_user.h
 create mode 100644 include/linux/sframe.h
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h
 create mode 100644 kernel/unwind/user.c

-- 
2.47.0

