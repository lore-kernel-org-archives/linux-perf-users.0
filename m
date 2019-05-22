From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/3] perf record: Fix kallsym map size for s390
Date: Wed, 22 May 2019 16:46:00 +0200
Message-ID: <20190522144601.50763-3-tmricht@linux.ibm.com>
References: <20190522144601.50763-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522144601.50763-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On s390 command

   [root@m35lp76 perf]#./perf record -e cycles -- find ~

creates a perf.data file with a strange PERF_RECORD_MMAP for kallsyms:

   [root@m35lp76 perf]# ./perf report -D | fgrep kernel.kallsyms
   0 0x128 [0x50]: PERF_RECORD_MMAP -1/0:
            [0x100000(0x3ff7ff027f0) @ 0x100000]: x [kernel.kallsyms]_text
   [root@m35lp76 perf]#

The size of the kernel is 0x3ff7ff027f0 bytes which is simply wrong.
It is the difference between the kernel's _end symbol and the first module:

  [root@m35lp76 perf]# cat /proc/kallsyms |sort| les
  0000000002472000 B __bss_stop
  0000000002472000 B _end
  000003ff800027f0 T qdio_stop_irq        [qdio]
  000003ff80002898 t qdio_do_eqbs [qdio]

The root cause is the following function sequence:
  cmd__record
    __cmd_record
      perf_session__new
        perf_session__create_kernel_maps
          machine__create_kernel_maps
            machine__get_running_kernel_start
            machine__update_kernel_mmap
            machine__set_kernel_mmap;

Machine__get_running_kernel_start() searches /proc/kallsyms for the
start symbol and then calls machine__update_kernel_mmap() with ~0ULL
for the kernel's end address.
It relies on machine__set_kernel_mmap() to find the next map, which is
usually a module and then uses the first module's start address as
kernel end address.
This works nicely on x86 and similar plattforms but not on s390.

On s390 the kernel starts at address 0x10000 and modules are loaded
at kernel virtual address space somewhere around 0x3ff xxxx xxxx,
leaving a huge gap.

To fix this function machine__create_kernel_maps() also searches for
symbol _end as BSS symbol and if this symbol is found, use this
symbol's address a kernel end in machine__update_kernel_mmap().
Otherwise fall back to the previous method and use the first
kernel module's load address (as before).

Output before:
  [root@m35lp76 perf]# ./perf record -e cycles -- find ~
  [root@m35lp76 perf]# ./perf report -D | fgrep kernel.kallsyms
  0 0x128 [0x50]: PERF_RECORD_MMAP -1/0:
                [0x100000(0x3ff7ff027f0) @ 0x100000]:
                x [kernel.kallsyms]_text
  [root@m35lp76 perf]#

Output after:
  [root@m35lp76 perf]# ./perf record -e cycles -- find ~
  [root@m35lp76 perf]# ./perf report -D | fgrep kernel.kallsyms
  0 0x128 [0x50]: PERF_RECORD_MMAP -1/0:
                [0x100000(0x2372000) @ 0x100000]:
                x [kernel.kallsyms]_text
  [root@m35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/util/event.c   |  4 ++--
 tools/perf/util/machine.c | 29 +++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index d1ad6c419724..96b4cbdb655e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -876,11 +876,11 @@ static int find_symbol_cb(void *arg, const char *name, char type,
 	/*
 	 * Must be a function or at least an alias, as in PARISC64, where "_text" is
 	 * an 'A' to the same address as "_stext".
+	 * When searching for symbol _end allow symbol type 'B'.
 	 */
 	if (!(kallsyms__is_function(type) ||
-	      type == 'A') || strcmp(name, args->name))
+	      type == 'A' || type == 'B') || strcmp(name, args->name))
 		return 0;
-
 	args->start = start;
 	return 1;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 28a9541c4835..c278c1fe6dd3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -918,13 +918,18 @@ void machine__get_kallsyms_filename(struct machine *machine, char *buf,
 }
 
 const char *ref_reloc_sym_names[] = {"_text", "_stext", NULL};
+static const char *const ref_sym_endnames[] = {"_end", NULL};
 
 /* Figure out the start address of kernel map from /proc/kallsyms.
  * Returns the name of the start symbol in *symbol_name. Pass in NULL as
  * symbol_name if it's not that important.
+ *
+ * Get kernel end address for kernel map from /proc/kallsyms by
+ * searching for symbol _end.
  */
 static int machine__get_running_kernel_start(struct machine *machine,
-					     const char **symbol_name, u64 *start)
+					     const char **symbol_name,
+					     u64 *start, u64 *kernel_end)
 {
 	char filename[PATH_MAX];
 	int i, err = -1;
@@ -949,6 +954,16 @@ static int machine__get_running_kernel_start(struct machine *machine,
 		*symbol_name = name;
 
 	*start = addr;
+
+	/* Get kernel end address and store it when found */
+	for (i = 0; (name = ref_sym_endnames[i]) != NULL; i++) {
+		err = kallsyms__get_function_start(filename, name, &addr);
+		if (!err) {
+			*kernel_end = addr;
+			break;
+		}
+	}
+
 	return 0;
 }
 
@@ -1441,7 +1456,7 @@ int machine__create_kernel_maps(struct machine *machine)
 	struct dso *kernel = machine__get_kernel(machine);
 	const char *name = NULL;
 	struct map *map;
-	u64 addr = 0;
+	u64 addr = 0, e_addr = 0;
 	int ret;
 
 	if (kernel == NULL)
@@ -1460,7 +1475,7 @@ int machine__create_kernel_maps(struct machine *machine)
 				 "continuing anyway...\n", machine->pid);
 	}
 
-	if (!machine__get_running_kernel_start(machine, &name, &addr)) {
+	if (!machine__get_running_kernel_start(machine, &name, &addr, &e_addr)) {
 		if (name &&
 		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, addr)) {
 			machine__destroy_kernel_maps(machine);
@@ -1472,15 +1487,17 @@ int machine__create_kernel_maps(struct machine *machine)
 		 * we have a real start address now, so re-order the kmaps
 		 * assume it's the last in the kmaps
 		 */
-		machine__update_kernel_mmap(machine, addr, ~0ULL);
+		machine__update_kernel_mmap(machine, addr, e_addr ?: ~0ULL);
 	}
 
 	if (machine__create_extra_kernel_maps(machine, kernel))
 		pr_debug("Problems creating extra kernel maps, continuing anyway...\n");
 
-	/* update end address of the kernel map using adjacent module address */
+	/* update end address of the kernel map using adjacent module address
+	 * only when the kernel end could not be determined.
+	 */
 	map = map__next(machine__kernel_map(machine));
-	if (map)
+	if (!e_addr && map)
 		machine__set_kernel_mmap(machine, addr, map->start);
 out_put:
 	dso__put(kernel);
-- 
2.19.1
