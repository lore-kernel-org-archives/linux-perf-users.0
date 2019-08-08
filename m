From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/10] perf annotate: Fix s390 gap between kernel end and module start
Date: Thu,  8 Aug 2019 15:53:57 -0300
Message-ID: <20190808185358.20125-10-acme@kernel.org>
References: <20190808185358.20125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808185358.20125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Klaus Theurich <klaus.theurich@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

During execution of command 'perf top' the error message:

   Not enough memory for annotating '__irf_end' symbol!)

is emitted from this call sequence:
  __cmd_top
    perf_top__mmap_read
      perf_top__mmap_read_idx
        perf_event__process_sample
          hist_entry_iter__add
            hist_iter__top_callback
              perf_top__record_precise_ip
                hist_entry__inc_addr_samples
                  symbol__inc_addr_samples
                    symbol__get_annotation
                      symbol__alloc_hist

In this function the size of symbol __irf_end is calculated. The size of
a symbol is the difference between its start and end address.

When the symbol was read the first time, its start and end was set to:

   symbol__new: __irf_end 0xe954d0-0xe954d0

which is correct and maps with /proc/kallsyms:

   root@s8360046:~/linux-4.15.0/tools/perf# fgrep _irf_end /proc/kallsyms
   0000000000e954d0 t __irf_end
   root@s8360046:~/linux-4.15.0/tools/perf#

In function symbol__alloc_hist() the end of symbol __irf_end is

  symbol__alloc_hist sym:__irf_end start:0xe954d0 end:0x3ff80045a8

which is identical with the first module entry in /proc/kallsyms

This results in a symbol size of __irf_req for histogram analyses of
70334140059072 bytes and a malloc() for this requested size fails.

The root cause of this is function
  __dso__load_kallsyms()
  +-> symbols__fixup_end()

Function symbols__fixup_end() enlarges the last symbol in the kallsyms
map:

   # fgrep __irf_end /proc/kallsyms
   0000000000e954d0 t __irf_end
   #

to the start address of the first module:
   # cat /proc/kallsyms | sort  | egrep ' [tT] '
   ....
   0000000000e952d0 T __security_initcall_end
   0000000000e954d0 T __initramfs_size
   0000000000e954d0 t __irf_end
   000003ff800045a8 T fc_get_event_number       [scsi_transport_fc]
   000003ff800045d0 t store_fc_vport_disable    [scsi_transport_fc]
   000003ff800046a8 T scsi_is_fc_rport  [scsi_transport_fc]
   000003ff800046d0 t fc_target_setup   [scsi_transport_fc]

On s390 the kernel is located around memory address 0x200, 0x10000 or
0x100000, depending on linux version. Modules however start some- where
around 0x3ff xxxx xxxx.

This is different than x86 and produces a large gap for which histogram
allocation fails.

Fix this by detecting the kernel's last symbol and do no adjustment for
it. Introduce a weak function and handle s390 specifics.

Reported-by: Klaus Theurich <klaus.theurich@de.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190724122703.3996-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/machine.c | 17 +++++++++++++++++
 tools/perf/util/symbol.c            |  7 ++++++-
 tools/perf/util/symbol.h            |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index de26b1441a48..c8c86a0c9b79 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -6,6 +6,7 @@
 #include "machine.h"
 #include "api/fs/fs.h"
 #include "debug.h"
+#include "symbol.h"
 
 int arch__fix_module_text_start(u64 *start, u64 *size, const char *name)
 {
@@ -33,3 +34,19 @@ int arch__fix_module_text_start(u64 *start, u64 *size, const char *name)
 
 	return 0;
 }
+
+/* On s390 kernel text segment start is located at very low memory addresses,
+ * for example 0x10000. Modules are located at very high memory addresses,
+ * for example 0x3ff xxxx xxxx. The gap between end of kernel text segment
+ * and beginning of first module's text segment is very big.
+ * Therefore do not fill this gap and do not assign it to the kernel dso map.
+ */
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+{
+	if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
+		/* Last kernel symbol mapped to end of page */
+		p->end = roundup(p->end, page_size);
+	else
+		p->end = c->start;
+	pr_debug4("%s sym:%s end:%#lx\n", __func__, p->name, p->end);
+}
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 173f3378aaa0..4efde7879474 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -92,6 +92,11 @@ static int prefix_underscores_count(const char *str)
 	return tail - str;
 }
 
+void __weak arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+{
+	p->end = c->start;
+}
+
 const char * __weak arch__normalize_symbol_name(const char *name)
 {
 	return name;
@@ -218,7 +223,7 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
 		curr = rb_entry(nd, struct symbol, rb_node);
 
 		if (prev->end == prev->start && prev->end != curr->start)
-			prev->end = curr->start;
+			arch__symbols__fixup_end(prev, curr);
 	}
 
 	/* Last entry */
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 12755b42ea93..183f630cb5f1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -288,6 +288,7 @@ const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
 
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c);
 int arch__compare_symbol_names(const char *namea, const char *nameb);
 int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 				 unsigned int n);
-- 
2.21.0
