Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB036F2EB;
	Fri, 13 Sep 2024 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268575; cv=none; b=GZ6MYZh+Ocmk4gVMgtkl2EAgmTax0UZOX3iQy3fOwvzrhVTKQ9XVz7Oa6WJFFCGO+1v1W+5+PQQBVghlet9fYbzFdkoTfGdcDemplkNjAdki6Z8DDv+MEoLYmA/UpFSD+kHze5I78BffTlTaCmnBYKZ4OvLrBI3EF2NhrxhdQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268575; c=relaxed/simple;
	bh=I6c+y4kdGecoNeWVA0WJgrf/65LEkrijcHk4acvyETM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+MbC65MqNkXRfEE5r4mj87M7BBtPQSCJh/iAnuwxb+9EC/9Bp8xwToCtrLQJRWsHlvPfAl68hasYVHoo7HC+1ttqegR0wntWuEkhKm3CWTirJTbRoPYNndVjXH4AAhIsNwv4ZJOozPO/HNOc9tTk+0N19EENTOZi4gE9XOLvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEB1Yj+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEB1Yj+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D31C4CEC0;
	Fri, 13 Sep 2024 23:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268574;
	bh=I6c+y4kdGecoNeWVA0WJgrf/65LEkrijcHk4acvyETM=;
	h=From:To:Cc:Subject:Date:From;
	b=PEB1Yj+qJ/bw7TzY2NhzZ6uMnxloJswmHNnqwLVhEIqScFv2AfbaMNxDAZGiPtKle
	 PJEY/wItF6sPdcc7/Ue4FBcWCnqzdsH6nZQV4WOQ4caL+noIKvZr8N7uXZJWq5zz3L
	 i3rqs3Avf7/WmZ5dDtzqis+VgZfLEZQBL07yUlwMzOtsfVwuPWBPicA2YOtCNiqbK/
	 h7t3E8rtpXMMSTY0Mvu7ffKTBGLoqgW2k2mytgk5FEsGuJ7IJsRQtTjj2emtfMT+tu
	 BfaX/t0YXYRSjk6f2FG5GJuJrDuzbyC/8SxuV90l5yuUES5JMkRN3/eocxk0JBrVFG
	 SsXJs9C4I8jkw==
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
	Sam James <sam@gentoo.org>
Subject: [PATCH v2 00/11] unwind, perf: sframe user space unwinding, deferred perf callchains
Date: Sat, 14 Sep 2024 01:02:02 +0200
Message-ID: <cover.1726268190.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a new version of sframe user space unwinding + perf deferred
callchains.  Better late than never.

Unfortunately I didn't get a chance to do any testing with this one yet
as I'm rushing it out the door before GNU Cauldron starts.
Conference-driven development ;-)

Plus I don't have the perf tool piece working yet so I don't have a way
of doing end-to-end testing at the moment anyway.

In other words, please don't merge this yet.

Namhyung, if you're still available to write a perf tool patch which
integrates with this, that would be great.  Otherwise I could give it a
try.

Steven, let me know if this would interface ok with your anticipated
tracing usage.

v2:
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

Josh Poimboeuf (11):
  unwind: Introduce generic user space unwinding interface
  unwind/x86: Add HAVE_USER_UNWIND
  unwind: Introduce SFrame user space unwinding
  unwind/x86/64: Add HAVE_USER_UNWIND_SFRAME
  perf/x86: Use user_unwind interface
  perf: Remove get_perf_callchain() 'init_nr' argument
  perf: Remove get_perf_callchain() 'crosstask' argument
  perf: Simplify get_perf_callchain() user logic
  perf: Introduce deferred user callchains
  perf/x86: Add HAVE_PERF_CALLCHAIN_DEFERRED
  perf/x86: Enable SFrame unwinding for deferred user callchains

 arch/Kconfig                       |   9 +
 arch/x86/Kconfig                   |   3 +
 arch/x86/events/core.c             |  76 +++---
 arch/x86/include/asm/user_unwind.h |  11 +
 fs/binfmt_elf.c                    |  47 +++-
 include/linux/mm_types.h           |   3 +
 include/linux/perf_event.h         |  11 +-
 include/linux/sframe.h             |  46 ++++
 include/linux/user_unwind.h        |  32 +++
 include/uapi/linux/elf.h           |   1 +
 include/uapi/linux/perf_event.h    |  21 +-
 include/uapi/linux/prctl.h         |   3 +
 kernel/Makefile                    |   1 +
 kernel/bpf/stackmap.c              |   8 +-
 kernel/events/callchain.c          |  48 ++--
 kernel/events/core.c               |  82 +++++-
 kernel/fork.c                      |  10 +
 kernel/sys.c                       |  11 +
 kernel/unwind/Makefile             |   2 +
 kernel/unwind/sframe.c             | 420 +++++++++++++++++++++++++++++
 kernel/unwind/sframe.h             | 215 +++++++++++++++
 kernel/unwind/user.c               |  95 +++++++
 mm/init-mm.c                       |   4 +-
 23 files changed, 1086 insertions(+), 73 deletions(-)
 create mode 100644 arch/x86/include/asm/user_unwind.h
 create mode 100644 include/linux/sframe.h
 create mode 100644 include/linux/user_unwind.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h
 create mode 100644 kernel/unwind/user.c

-- 
2.46.0

