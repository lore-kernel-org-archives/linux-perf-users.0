From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/63] perf probe: Fix to list probe event with correct line number
Date: Thu,  7 Nov 2019 15:59:30 -0300
Message-ID: <20191107190011.23924-23-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since debuginfo__find_probe_point() uses dwarf_entrypc() for finding the
entry address of the function on which a probe is, it will fail when the
function DIE has only ranges attribute.

To fix this issue, use die_entrypc() instead of dwarf_entrypc().

Without this fix, perf probe -l shows incorrect offset:

  # perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask+18446744071579263632@work/linux/linux/kernel/cpu.c)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask+18446744071579263752@work/linux/linux/kernel/cpu.c)

With this:

  # perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@work/linux/linux/kernel/cpu.c)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask:21@work/linux/linux/kernel/cpu.c)

Committer testing:

Before:

  [root@quaco ~]# perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask+18446744071579765152@kernel/cpu.c)
  [root@quaco ~]#

After:

  [root@quaco ~]# perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@kernel/cpu.c)
  [root@quaco ~]#

Fixes: 1d46ea2a6a40 ("perf probe: Fix listing incorrect line number with inline function")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157199321227.8075.14655572419136993015.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 2fa932bcf960..88e17a4f5ac3 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1566,7 +1566,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 		/* Get function entry information */
 		func = basefunc = dwarf_diename(&spdie);
 		if (!func ||
-		    dwarf_entrypc(&spdie, &baseaddr) != 0 ||
+		    die_entrypc(&spdie, &baseaddr) != 0 ||
 		    dwarf_decl_line(&spdie, &baseline) != 0) {
 			lineno = 0;
 			goto post;
@@ -1583,7 +1583,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 		while (die_find_top_inlinefunc(&spdie, (Dwarf_Addr)addr,
 						&indie)) {
 			/* There is an inline function */
-			if (dwarf_entrypc(&indie, &_addr) == 0 &&
+			if (die_entrypc(&indie, &_addr) == 0 &&
 			    _addr == addr) {
 				/*
 				 * addr is at an inline function entry.
-- 
2.21.0
