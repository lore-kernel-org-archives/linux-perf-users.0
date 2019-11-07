From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/63] perf probe: Fix to show ranges of variables in functions without entry_pc
Date: Thu,  7 Nov 2019 15:59:32 -0300
Message-ID: <20191107190011.23924-25-acme@kernel.org>
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

Fix to show ranges of variables (--range and --vars option) in functions
which DIE has only ranges but no entry_pc attribute.

Without this fix:

  # perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
  	@<clear_tasks_mm_cpumask+0>
  		(No matched variables)

With this fix:

  # perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
	@<clear_tasks_mm_cpumask+0>
		[VAL]	int	cpu	@<clear_tasks_mm_cpumask+[0-35,317-317,2052-2059]>

Committer testing:

Before:

  [root@quaco ~]# perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
          @<clear_tasks_mm_cpumask+0>
                  (No matched variables)
  [root@quaco ~]#

After:

  [root@quaco ~]# perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
          @<clear_tasks_mm_cpumask+0>
                  [VAL]   int     cpu     @<clear_tasks_mm_cpumask+[0-23,23-105,105-106,106-106,1843-1850,1850-1862]>
  [root@quaco ~]#

Using it:

  [root@quaco ~]# perf probe clear_tasks_mm_cpumask cpu
  Added new event:
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask with cpu)

  You can now use it in all perf tools, such as:

  	perf record -e probe:clear_tasks_mm_cpumask -aR sleep 1

  [root@quaco ~]# perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@kernel/cpu.c with cpu)
  [root@quaco ~]#
  [root@quaco ~]# perf trace -e probe:*cpumask
  ^C[root@quaco ~]#

Fixes: 349e8d261131 ("perf probe: Add --range option to show a variable's location range")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157199323018.8075.8179744380479673672.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dwarf-aux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index e0c507d6b3b4..ac82fd937e4b 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1019,7 +1019,7 @@ static int die_get_var_innermost_scope(Dwarf_Die *sp_die, Dwarf_Die *vr_die,
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 
@@ -1082,7 +1082,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 
-- 
2.21.0
