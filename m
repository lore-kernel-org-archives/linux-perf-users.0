From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/6] perf probe: Do not depend on dwfl_module_addrsym()
Date: Mon,  9 Mar 2020 15:53:23 -0300
Message-ID: <20200309185323.22583-7-acme@kernel.org>
References: <20200309185323.22583-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200309185323.22583-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sasha Levin <sashal@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Do not depend on dwfl_module_addrsym() because it can fail on user-space
shared libraries.

Actually, same bug was fixed by commit 664fee3dc379 ("perf probe: Do not
use dwfl_module_addrsym if dwarf_diename finds symbol name"), but commit
07d369857808 ("perf probe: Fix wrong address verification) reverted to
get actual symbol address from symtab.

This fixes it again by getting symbol address from DIE, and only if the
DIE has only address range, it uses dwfl_module_addrsym().

Fixes: 07d369857808 ("perf probe: Fix wrong address verification)
Reported-by: Alexandre Ghiti <alex@ghiti.fr>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>
Link: http://lore.kernel.org/lkml/158281812176.476.14164573830975116234.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 1c817add6ca4..e4cff49384f4 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -637,14 +637,19 @@ static int convert_to_trace_point(Dwarf_Die *sp_die, Dwfl_Module *mod,
 		return -EINVAL;
 	}
 
-	/* Try to get actual symbol name from symtab */
-	symbol = dwfl_module_addrsym(mod, paddr, &sym, NULL);
+	if (dwarf_entrypc(sp_die, &eaddr) == 0) {
+		/* If the DIE has entrypc, use it. */
+		symbol = dwarf_diename(sp_die);
+	} else {
+		/* Try to get actual symbol name and address from symtab */
+		symbol = dwfl_module_addrsym(mod, paddr, &sym, NULL);
+		eaddr = sym.st_value;
+	}
 	if (!symbol) {
 		pr_warning("Failed to find symbol at 0x%lx\n",
 			   (unsigned long)paddr);
 		return -ENOENT;
 	}
-	eaddr = sym.st_value;
 
 	tp->offset = (unsigned long)(paddr - eaddr);
 	tp->address = (unsigned long)paddr;
-- 
2.21.1
