From: Chris Ryder <chris.ryder@arm.com>
Subject: [PATCH 0/7] perf annotate: Support for AArch64
Date: Thu, 19 May 2016 17:59:44 +0100
Message-ID: <cover.1463676839.git.chris.ryder@arm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36342 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147AbcESRAQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 May 2016 13:00:16 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Chris Ryder <chris.ryder@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>

Hi,

The linux perf tool has some basic support for annotating
AArch32 branch instructions when displaying assembly. This
patchset refactors the annotation support to have a cleaner
separation between architectures, and then adds support for
annotating AArch64 instructions.

Comments very welcome, thanks.
Chris.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>

Chris Ryder (7):
  perf annotate: Fix identification of ARM blt and bls instructions
  perf annotate: Sort list of recognised instructions
  pref annotate: Separate architecture specific annotation support
  perf annotate: Separate out architecture specific parsing
  perf annotate: Architecture neutral handling of return instruction
  perf annotate: Make action message be architecture specific
  perf annotate: AArch64 support

 tools/perf/arch/arm/include/annotate_ins.h   |  27 +++++
 tools/perf/arch/arm/util/Build               |   2 +
 tools/perf/arch/arm/util/annotate_ins.c      |  22 ++++
 tools/perf/arch/arm64/include/annotate_ins.h |  40 +++++++
 tools/perf/arch/arm64/util/Build             |   2 +
 tools/perf/arch/arm64/util/annotate_ins.c    |  21 ++++
 tools/perf/arch/x86/include/annotate_ins.h   |  84 +++++++++++++++
 tools/perf/arch/x86/util/Build               |   1 +
 tools/perf/arch/x86/util/annotate_ins.c      |  17 +++
 tools/perf/config/Makefile                   |  12 +++
 tools/perf/ui/browsers/annotate.c            |  15 +--
 tools/perf/util/Build                        |   1 +
 tools/perf/util/annotate.c                   | 150 +++++++--------------------
 tools/perf/util/annotate_ins.c               |  21 ++++
 tools/perf/util/annotate_ins.h               |  17 +++
 15 files changed, 313 insertions(+), 119 deletions(-)
 create mode 100644 tools/perf/arch/arm/include/annotate_ins.h
 create mode 100644 tools/perf/arch/arm/util/annotate_ins.c
 create mode 100644 tools/perf/arch/arm64/include/annotate_ins.h
 create mode 100644 tools/perf/arch/arm64/util/annotate_ins.c
 create mode 100644 tools/perf/arch/x86/include/annotate_ins.h
 create mode 100644 tools/perf/arch/x86/util/annotate_ins.c
 create mode 100644 tools/perf/util/annotate_ins.c
 create mode 100644 tools/perf/util/annotate_ins.h

-- 
2.1.4
