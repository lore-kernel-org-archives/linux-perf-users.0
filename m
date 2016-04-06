From: Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] perf tools: Add dedicated unwind addr_space member into
 thread struct
Date: Wed, 6 Apr 2016 17:46:57 +0200
Message-ID: <20160406154657.GA14971@krava.brq.redhat.com>
References: <1894563.GPSC8z33rH@agathebauer>
 <4309725.73SKaCNb55@agathebauer>
 <20160404061408.GA2137@krava.local>
 <2600188.8x2NmCkWJL@agathebauer>
 <20160405083524.GB17232@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47793 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbcDFPrD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 6 Apr 2016 11:47:03 -0400
Content-Disposition: inline
In-Reply-To: <20160405083524.GB17232@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, perf group <linux-perf-users@vger.kernel.org>

On Tue, Apr 05, 2016 at 10:35:24AM +0200, Jiri Olsa wrote:
> On Mon, Apr 04, 2016 at 11:17:11PM +0200, Milian Wolff wrote:
> 
> SNIP
> 
> >             7f688a5ef0c4 usleep (/usr/lib/libc-2.23.so)
> >             5582244227cd main (/tmp/ex_sleep)
> >   1001.702 ( 0.059 ms): ex_sleep/4390 nanosleep(rqtp: 0x7ffe4d16eec0                                        
> > ) = 0
> >                   20379e syscall_slow_exit_work ([kernel.kallsyms])
> >                   203bc4 syscall_return_slowpath ([kernel.kallsyms])
> >                   797248 int_ret_from_sys_call ([kernel.kallsyms])
> >             7f688a5c5600 __nanosleep (/usr/lib/libc-2.23.so)
> >             7f688a5ef0c4 usleep (/usr/lib/libc-2.23.so)
> >             5582244227d7 main (/tmp/ex_sleep)
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Is there a way to increase the event buffer or something like that to not lose 
> > events when the costly dwarf unwinding happens for the first time? Consecutive 
> > unwinding is cached by libunwind and much faster.
> 
> not sure about perf trace, but there's -m option available for perf record
> that allows you to increase the buffer size
> 
> > 
> > Alternatively, I could try to unwind in the `sys_enter`, but then I'd need to 
> > buffer the output to print the trace after the duration line...
> > 
> > How would you guys handle this situation?
> > 
> > Also, Jiri, Arnaldo - what would be your suggestion on how to handle the 
> > `thread::priv` situation - I doubt my naive `priv2` approach is acceptable.
> 
> yea, I think one priv is more than enough ;-)
> 
> I think we want to move the the unwinder usage of this field into separate field

need to run test over this, but will try to post it this week
let me know if this solution would work for you

thanks,
jirka

---
Adding dedicated unwind addr_space member into thread struct.

Link: http://lkml.kernel.org/n/tip-pwiici9lf2l0iuji1jv1f5kx@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/thread.h           |  6 ++++++
 tools/perf/util/unwind-libunwind.c | 25 +++++++++----------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index a0ac0317affb..e214207bb13a 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -9,6 +9,9 @@
 #include "symbol.h"
 #include <strlist.h>
 #include <intlist.h>
+#ifdef HAVE_LIBUNWIND_SUPPORT
+#include <libunwind.h>
+#endif
 
 struct thread_stack;
 
@@ -32,6 +35,9 @@ struct thread {
 
 	void			*priv;
 	struct thread_stack	*ts;
+#ifdef HAVE_LIBUNWIND_SUPPORT
+	unw_addr_space_t	addr_space;
+#endif
 };
 
 struct machine;
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index ee7e372297e5..63687d3a344e 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -32,6 +32,7 @@
 #include "symbol.h"
 #include "util.h"
 #include "debug.h"
+#include "asm/bug.h"
 
 extern int
 UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
@@ -580,43 +581,33 @@ static unw_accessors_t accessors = {
 
 int unwind__prepare_access(struct thread *thread)
 {
-	unw_addr_space_t addr_space;
-
 	if (callchain_param.record_mode != CALLCHAIN_DWARF)
 		return 0;
 
-	addr_space = unw_create_addr_space(&accessors, 0);
-	if (!addr_space) {
+	thread->addr_space = unw_create_addr_space(&accessors, 0);
+	if (!thread->addr_space) {
 		pr_err("unwind: Can't create unwind address space.\n");
 		return -ENOMEM;
 	}
 
-	unw_set_caching_policy(addr_space, UNW_CACHE_GLOBAL);
-	thread__set_priv(thread, addr_space);
-
+	unw_set_caching_policy(thread->addr_space, UNW_CACHE_GLOBAL);
 	return 0;
 }
 
 void unwind__flush_access(struct thread *thread)
 {
-	unw_addr_space_t addr_space;
-
 	if (callchain_param.record_mode != CALLCHAIN_DWARF)
 		return;
 
-	addr_space = thread__priv(thread);
-	unw_flush_cache(addr_space, 0, 0);
+	unw_flush_cache(thread->addr_space, 0, 0);
 }
 
 void unwind__finish_access(struct thread *thread)
 {
-	unw_addr_space_t addr_space;
-
 	if (callchain_param.record_mode != CALLCHAIN_DWARF)
 		return;
 
-	addr_space = thread__priv(thread);
-	unw_destroy_addr_space(addr_space);
+	unw_destroy_addr_space(thread->addr_space);
 }
 
 static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
@@ -639,7 +630,9 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 	 * unwind itself.
 	 */
 	if (max_stack - 1 > 0) {
-		addr_space = thread__priv(ui->thread);
+		WARN_ONCE(!ui->thread, "WARNING: ui->thread is NULL");
+		addr_space = ui->thread->addr_space;
+
 		if (addr_space == NULL)
 			return -1;
 
-- 
2.4.11
