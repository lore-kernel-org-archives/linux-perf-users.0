From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/4] perf map: Set kmap->kmaps backpointer for main kernel map chunks
Date: Mon, 23 Dec 2019 10:32:40 -0300
Message-ID: <20191223133241.8578-4-acme@kernel.org>
References: <20191223133241.8578-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191223133241.8578-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When a map is create to represent the main kernel area (vmlinux) with
map__new2() we allocate an extra area to store a pointer to the 'struct
maps' for the kernel maps, so that we can access that struct when
loading ELF files or kallsyms, as we will need to split it in multiple
maps, one per kernel module or ELF section (such as ".init.text").

So when map->dso->kernel is non-zero, it is expected that
map__kmap(map)->kmaps to be set to the tree of kernel maps (modules,
chunks of the main kernel, bpf progs put in place via
PERF_RECORD_KSYMBOL, the main kernel).

This was not the case when we were splitting the main kernel into chunks
for its ELF sections, which ended up making 'perf report --children'
processing a perf.data file with callchains to trip on
__map__is_kernel(), when we press ENTER to see the popup menu for main
histogram entries that starts at a symbol in the ".init.text" ELF
section, e.g.:

-    8.83%     0.00%  swapper     [kernel.vmlinux].init.text  [k] start_kernel
     start_kernel
     cpu_startup_entry
     do_idle
     cpuidle_enter
     cpuidle_enter_state
     intel_idle

Fix it.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/20191218190120.GB13282@kernel.org/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6658fbf196e6..1965aefccb02 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -920,6 +920,9 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		if (curr_map == NULL)
 			return -1;
 
+		if (curr_dso->kernel)
+			map__kmap(curr_map)->kmaps = kmaps;
+
 		if (adjust_kernel_syms) {
 			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
 			curr_map->end	 = curr_map->start + shdr->sh_size;
-- 
2.21.1
