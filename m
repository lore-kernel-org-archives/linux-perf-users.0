Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA9A1C6FFA;
	Thu, 24 Apr 2025 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525788; cv=none; b=RnowhRD95rrVuF1jtbt6UCqH+RpHDIgsOmjMJcSkNcdIZsaT0YrT5Wu3aJ69PffKOAQFgLtGc4mjdNjxoyBzpLhPTs+hrx5mstB809Ji+AD3MF/KV68TJskqaS9b21dPhqL4KlUwqKc+cjAwEaWgQjmA+HaHHcC7uwK8XmRNKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525788; c=relaxed/simple;
	bh=KeeVbnNomauR1fqRtkCW4Hw5hNY/GMwON7hWq9lvYvk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=B9Kv45iTyDlZhci/toUDkn6jPceAaRYk2gcFWx9apfvBMyUjUMMQ/2rlswKjBA85DjXDJka9mqyGGWTmucwMXwRYBjmiCL4jZ3G+lWdG2N3UaTQ0l/nS9/01wU12QUdvIuk5Q1tyWlGyyzsCEwTl/Z0/LUshh2iPirpg2r6iiDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC8BC4CEE3;
	Thu, 24 Apr 2025 20:16:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u831b-0000000H3sF-2N4W;
	Thu, 24 Apr 2025 16:18:23 -0400
Message-ID: <20250424201511.921245242@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 16:15:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
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
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v5 00/12] unwind_deferred: Implement sframe handling
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>


I'm currently working on getting sframe support from the kernel.
Josh Poimboeuf did a lot of the hard work already, but he told me he doesn't
have time to continue it so I'm picking it up where he left off.

His last series of v4 is here:

  https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/

It covers a lot of topics as he found issues with other aspects of
the kernel that needed to be fixed for sframes to work properly.

This adds the support for sframes to the deferred unwinder. It is based
on top of this series:

  https://lore.kernel.org/all/20250424192456.851953422@goodmis.org/

This series is the last of the work that Josh had done in v4.
Note, I did not address the comments that were made in the previous series.
I'm posting this so that others may have something to work from that is
based on the deferred unwinder code of the other series. This series is
specific for sframe decoding itself and can be worked on separately from the
other series.

Hopefully someone that understands the sframe specification better than
I do can continue this work. I'm only posting this so that there's
something others can start with.

Where there were discussions done on patches in v4, I left a Link:
tag in the change log so that it is easy to go back and see what was
discussed, as this series did not make an attempt to resolve those
discussions.

I'll be working on the other three series in trying to get them ready
for submission. Those series are:

 vdso: https://lore.kernel.org/all/20250422183439.895236512@goodmis.org/
 [ Which is a separate work that is not directly needed by the other serise ]

 perf: https://lore.kernel.org/all/20250424162529.686762589@goodmis.org/

 tracing: https://lore.kernel.org/all/20250424192456.851953422@goodmis.org/
 [ This is based on top of the perf series ]

Again, this series is based on the tracing series.

Hopefully someone can help me and work on this series ;-)

Cheers!

Josh Poimboeuf (12):
      unwind_user/sframe: Add support for reading .sframe headers
      unwind_user/sframe: Store sframe section data in per-mm maple tree
      x86/uaccess: Add unsafe_copy_from_user() implementation
      unwind_user/sframe: Add support for reading .sframe contents
      unwind_user/sframe: Detect .sframe sections in executables
      unwind_user/sframe: Add prctl() interface for registering .sframe sections
      unwind_user/sframe: Wire up unwind_user to sframe
      unwind_user/sframe/x86: Enable sframe unwinding on x86
      unwind_user/sframe: Remove .sframe section on detected corruption
      unwind_user/sframe: Show file name in debug output
      unwind_user/sframe: Enable debugging in uaccess regions
      unwind_user/sframe: Add .sframe validation option

----
 MAINTAINERS                       |   1 +
 arch/Kconfig                      |  23 ++
 arch/x86/Kconfig                  |   1 +
 arch/x86/include/asm/mmu.h        |   2 +-
 arch/x86/include/asm/uaccess.h    |  39 ++-
 fs/binfmt_elf.c                   |  49 +++-
 include/linux/mm_types.h          |   3 +
 include/linux/sframe.h            |  60 ++++
 include/linux/unwind_user_types.h |   1 +
 include/uapi/linux/elf.h          |   1 +
 include/uapi/linux/prctl.h        |   5 +-
 kernel/fork.c                     |  10 +
 kernel/sys.c                      |   9 +
 kernel/unwind/Makefile            |   1 +
 kernel/unwind/sframe.c            | 596 ++++++++++++++++++++++++++++++++++++++
 kernel/unwind/sframe.h            |  71 +++++
 kernel/unwind/sframe_debug.h      |  99 +++++++
 kernel/unwind/user.c              |  22 +-
 mm/init-mm.c                      |   2 +
 19 files changed, 977 insertions(+), 18 deletions(-)
 create mode 100644 include/linux/sframe.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h
 create mode 100644 kernel/unwind/sframe_debug.h
