From: Chris Ryder <chris.ryder@arm.com>
Subject: [PATCH 6/7] perf annotate: Make action message be architecture specific
Date: Thu, 19 May 2016 17:59:50 +0100
Message-ID: <dfd88a04030649d3919e05ba1650278b3fac9e28.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chris Ryder <chris.ryder@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-perf-users.vger.kernel.org

The help message displayed by perf report when pressing right arrow
or enter keys on an instruction that doesn't have an action is
currently hard coded and displays x86 instructions regardless of
the target architecture. Make the help message architecture specific.

Signed-off-by: Chris Ryder <chris.ryder@arm.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 tools/perf/arch/arm/include/annotate_ins.h | 2 ++
 tools/perf/arch/x86/include/annotate_ins.h | 2 ++
 tools/perf/ui/browsers/annotate.c          | 2 +-
 tools/perf/util/annotate_ins.h             | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/include/annotate_ins.h b/tools/perf/arch/arm/include/annotate_ins.h
index e8ea98d..143c478 100644
--- a/tools/perf/arch/arm/include/annotate_ins.h
+++ b/tools/perf/arch/arm/include/annotate_ins.h
@@ -22,4 +22,6 @@
 	{ .name = "orr",   .ops  = &mov_ops, }, \
 	}
 
+#define ARCH_ACTIONS "Actions are only available for branch instructions."
+
 #endif /* ARCH_ANNOTATE_INS_H */
diff --git a/tools/perf/arch/x86/include/annotate_ins.h b/tools/perf/arch/x86/include/annotate_ins.h
index 179b50e..2e889b8 100644
--- a/tools/perf/arch/x86/include/annotate_ins.h
+++ b/tools/perf/arch/x86/include/annotate_ins.h
@@ -79,4 +79,6 @@
 	{ .name = "xbeginq", .ops  = &jump_ops, }, \
 	}
 
+#define ARCH_ACTIONS "Actions are only available for 'callq', 'retq' & jump instructions."
+
 #endif /* ARCH_ANNOTATE_INS_H */
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 6816faf..56064f6 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -850,7 +850,7 @@ show_help:
 			} else if (!(annotate_browser__jump(browser) ||
 				     annotate_browser__callq(browser, evsel, hbt))) {
 show_sup_ins:
-				ui_helpline__puts("Actions are only available for 'callq', 'retq' & jump instructions.");
+				ui_helpline__puts(ARCH_ACTIONS);
 			}
 			continue;
 		case 't':
diff --git a/tools/perf/util/annotate_ins.h b/tools/perf/util/annotate_ins.h
index 15ac482..27457f8f 100644
--- a/tools/perf/util/annotate_ins.h
+++ b/tools/perf/util/annotate_ins.h
@@ -11,6 +11,7 @@ extern char *arch_parse_call_target(char *t);
 #include <annotate_ins.h>
 #else
 #define ARCH_INSTRUCTIONS { }
+#define ARCH_ACTIONS "Actions are not supported on this architecture"
 #endif
 
 #endif /* __ANNOTATE_INS_H */
-- 
2.1.4
