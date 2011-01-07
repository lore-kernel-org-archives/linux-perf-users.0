From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/9] Make cpu_idle events architecture independent
Date: Fri,  7 Jan 2011 11:29:41 +0100
Message-ID: <1294396190-23031-1-git-send-email-trenn@suse.de>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38765 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385Ab1AGKaI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 7 Jan 2011 05:30:08 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
Cc: linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, lenb@kernel.org, j-pihet@ti.com, Thomas Renninger <trenn@suse.de>

and cleanup/fix some related stuff.

The patches are based on latest linux-2.6-x86 tree.
I had to revert some latest userspace perf patches to test
as they seem to be buggy, but they should not interfere with these changes.

As most/all are rather easy patches it would be great to still get them queued
up in linux-2.6-x86 tree for 2.6.38 inclusion.

Thanks,

    Thomas


Thomas Renninger (9):
  acpi: Use ACPI C-state type instead of enumeration value to export
    cpuidle state name
  cpuidle: Rename X86 specific idle poll state[0] from C0 to POLL
  X86/perf: fix power:cpu_idle double end events and throw cpu_idle
    events from the cpuidle layer
  cpuidle: Introduce .abbr (abbrevation) for cpuidle states
  acpi: processor->cpuidle: Only set cpuidle check_bm flag if
    pr->flags.bm_check is set
  perf (userspace): Fix variable clash with glibc time() func
  perf (userspace): Introduce --verbose param for perf timechart
  perf timechart: Map power:cpu_idle events to the corresponding
    cpuidle state
  perf: timechart: Fix memleak

 arch/arm/mach-at91/cpuidle.c            |   12 ++-
 arch/arm/mach-davinci/cpuidle.c         |   13 ++-
 arch/arm/mach-kirkwood/cpuidle.c        |   12 ++-
 arch/arm/mach-omap2/cpuidle34xx.c       |    3 +-
 arch/sh/kernel/cpu/shmobile/cpuidle.c   |   19 ++--
 arch/x86/kernel/process.c               |    6 +-
 arch/x86/kernel/process_32.c            |    4 -
 arch/x86/kernel/process_64.c            |    6 -
 drivers/acpi/processor_idle.c           |   10 ++-
 drivers/cpuidle/cpuidle.c               |   13 ++-
 drivers/cpuidle/sysfs.c                 |    3 +
 drivers/idle/intel_idle.c               |   13 ++-
 include/linux/cpuidle.h                 |    2 +
 tools/perf/builtin-timechart.c          |   15 +++
 tools/perf/util/include/linux/cpuidle.h |   20 ++++
 tools/perf/util/svghelper.c             |  154 +++++++++++++++++++++++++++----
 16 files changed, 248 insertions(+), 57 deletions(-)
 create mode 100644 tools/perf/util/include/linux/cpuidle.h

-- 
1.7.3.1
