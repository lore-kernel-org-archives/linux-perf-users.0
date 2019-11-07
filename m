From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 52/63] perf probe: Filter out instances except for inlined subroutine and subprogram
Date: Thu,  7 Nov 2019 16:00:00 -0300
Message-ID: <20191107190011.23924-53-acme@kernel.org>
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

Filter out instances except for inlined_subroutine and subprogram DIE in
die_walk_instances() and die_is_func_instance().

This fixes an issue that perf probe sets some probes on calling address
instead of a target function itself.

When perf probe walks on instances of an abstruct origin (a kind of
function prototype of inlined function), die_walk_instances() can also
pass a GNU_call_site (a GNU extension for call site) to callback. Since
it is not an inlined instance of target function, we have to filter out
when searching a probe point.

Without this patch, perf probe sets probes on call site address too.This
can happen on some function which is marked "inlined", but has actual
symbol. (I'm not sure why GCC mark it "inlined"):

  # perf probe -D vfs_read
  p:probe/vfs_read _text+2500017
  p:probe/vfs_read_1 _text+2499468
  p:probe/vfs_read_2 _text+2499563
  p:probe/vfs_read_3 _text+2498876
  p:probe/vfs_read_4 _text+2498512
  p:probe/vfs_read_5 _text+2498627

With this patch:

Slightly different results, similar tho:

  # perf probe -D vfs_read
  p:probe/vfs_read _text+2498512

Committer testing:

  # uname -a
  Linux quaco 5.3.8-200.fc30.x86_64 #1 SMP Tue Oct 29 14:46:22 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

Before:

  # perf probe -D vfs_read
  p:probe/vfs_read _text+3131557
  p:probe/vfs_read_1 _text+3130975
  p:probe/vfs_read_2 _text+3131047
  p:probe/vfs_read_3 _text+3130380
  p:probe/vfs_read_4 _text+3130000
  # uname -a
  Linux quaco 5.3.8-200.fc30.x86_64 #1 SMP Tue Oct 29 14:46:22 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  #

After:

  # perf probe -D vfs_read
  p:probe/vfs_read _text+3130000
  #

Fixes: db0d2c6420ee ("perf probe: Search concrete out-of-line instances")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157241937063.32002.11024544873990816590.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dwarf-aux.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index f31001d13bfb..ac1289043204 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -334,18 +334,22 @@ int die_entrypc(Dwarf_Die *dw_die, Dwarf_Addr *addr)
  * @dw_die: a DIE
  *
  * Ensure that this DIE is an instance (which has an entry address).
- * This returns true if @dw_die is a function instance. If not, you need to
- * call die_walk_instances() to find actual instances.
+ * This returns true if @dw_die is a function instance. If not, the @dw_die
+ * must be a prototype. You can use die_walk_instances() to find actual
+ * instances.
  **/
 bool die_is_func_instance(Dwarf_Die *dw_die)
 {
 	Dwarf_Addr tmp;
 	Dwarf_Attribute attr_mem;
+	int tag = dwarf_tag(dw_die);
 
-	/* Actually gcc optimizes non-inline as like as inlined */
-	return !dwarf_func_inline(dw_die) &&
-	       (dwarf_entrypc(dw_die, &tmp) == 0 ||
-		dwarf_attr(dw_die, DW_AT_ranges, &attr_mem) != NULL);
+	if (tag != DW_TAG_subprogram &&
+	    tag != DW_TAG_inlined_subroutine)
+		return false;
+
+	return dwarf_entrypc(dw_die, &tmp) == 0 ||
+		dwarf_attr(dw_die, DW_AT_ranges, &attr_mem) != NULL;
 }
 
 /**
@@ -624,6 +628,9 @@ static int __die_walk_instances_cb(Dwarf_Die *inst, void *data)
 	Dwarf_Die *origin;
 	int tmp;
 
+	if (!die_is_func_instance(inst))
+		return DIE_FIND_CB_CONTINUE;
+
 	attr = dwarf_attr(inst, DW_AT_abstract_origin, &attr_mem);
 	if (attr == NULL)
 		return DIE_FIND_CB_CONTINUE;
-- 
2.21.0
