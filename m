From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/19] perf report: Fix module symbol adjustment for s390x
Date: Mon, 14 Aug 2017 13:27:40 -0300
Message-ID: <20170814162741.6101-19-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Zvonko Kosic <zvonko.kosic@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

The 'perf report' tool does not display the addresses of kernel module
symbols correctly.

For example symbol qeth_send_ipa_cmd in kernel module qeth.ko has this
relative address for function qeth_send_ipa_cmd():

  [root@s8360047 linux]# nm -g drivers/s390/net/qeth.ko | fgrep send_ipa_cmd
  0000000000013088 T qeth_send_ipa_cmd

The module is loaded at address:

  [root@s8360047 linux]# cat /sys/module/qeth/sections/.text
  0x000003ff80296d20
  [root@s8360047 linux]#

This should result in a start address of:

  0x13088 + 0x3ff80296d20 = 0x3ff802a9da8

Using crash to verify the address on a live system:

  [root@s8360046 linux]# crash vmlinux

  crash 7.1.9++
  Copyright (C) 2002-2016  Red Hat, Inc.
  Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation

  [...]

  crash> mod -s qeth drivers/s390/net/qeth.ko
       MODULE       NAME        SIZE  OBJECT FILE
       3ff8028d700  qeth      151552  drivers/s390/net/qeth.ko
  crash> sym qeth_send_ipa_cmd
  3ff802a9da8 (T) qeth_send_ipa_cmd [qeth] /root/linux/drivers/s390/net/qeth_core_main.c: 2944
  crash>

Now perf report displays the address of symbol qeth_send_ipa_cmd:
symbol__new:

  qeth_send_ipa_cmd 0x130f0-0x132ce

There is a difference of 0x68 between the entry in the symbol table (see
nm command above) and perf. The difference is from the offset the .text
segment of qeth.ko:

  [root@s8360047 perf]# readelf -a drivers/s390/net/qeth.ko
  Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .note.gnu.build-i NOTE             0000000000000000  00000040
       0000000000000024  0000000000000000   A       0     0     4
  [ 2] .text             PROGBITS         0000000000000000  00000068
       000000000001c8a0  0000000000000000  AX       0     0     8

As seen the .text segment has an offset of 0x68 with start address 0x0.
Therefore 0x68 is added to the address of qeth_send_ipa_cmd and thus
0x13088 + 0x68 = 0x130f0 is displayed.

This is wrong, perf report needs to display the start address of symbol
qeth_send_ipa_cmd at 0x13088 + qeth.ko.text section start address.

The qeth.ko module .text start address is available in the qeth.ko DSO
map. Just identify the kernel module symbols and correct the addresses.

With the fix I see this correct address for symbol: symbol__new:
qeth_send_ipa_cmd 0x3ff802a9da8-0x3ff802a9f86

Signed-off-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Zvonko Kosic <zvonko.kosic@de.ibm.com>
LPU-Reference: 20170803134902.47207-1-tmricht@linux.vnet.ibm.com
Link: http://lkml.kernel.org/n/tip-q8lktlpoxb5e3dj52u1s1rw4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/sym-handling.c | 7 +++++++
 tools/perf/util/symbol-elf.c             | 8 +++++++-
 tools/perf/util/symbol.h                 | 3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/util/sym-handling.c b/tools/perf/arch/s390/util/sym-handling.c
index b6cd056ccf71..e103f6e46afe 100644
--- a/tools/perf/arch/s390/util/sym-handling.c
+++ b/tools/perf/arch/s390/util/sym-handling.c
@@ -19,4 +19,11 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 	return ehdr.e_type == ET_REL || ehdr.e_type == ET_DYN;
 }
 
+void arch__adjust_sym_map_offset(GElf_Sym *sym,
+				 GElf_Shdr *shdr __maybe_unused,
+				 struct map *map)
+{
+	if (map->type == MAP__FUNCTION)
+		sym->st_value += map->start;
+}
 #endif
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 98deabb9b47e..a70479061fce 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -793,6 +793,12 @@ static u64 ref_reloc(struct kmap *kmap)
 void __weak arch__sym_update(struct symbol *s __maybe_unused,
 		GElf_Sym *sym __maybe_unused) { }
 
+void __weak arch__adjust_sym_map_offset(GElf_Sym *sym, GElf_Shdr *shdr,
+				       struct map *map __maybe_unused)
+{
+	sym->st_value -= shdr->sh_addr - shdr->sh_offset;
+}
+
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		  struct symsrc *runtime_ss, int kmodule)
 {
@@ -973,7 +979,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 			/* Adjust symbol to map to file offset */
 			if (adjust_kernel_syms)
-				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
+				arch__adjust_sym_map_offset(&sym, &shdr, map);
 
 			if (strcmp(section_name,
 				   (curr_dso->short_name +
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index b221671070e2..d00a012cfdfb 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -343,6 +343,9 @@ int setup_intlist(struct intlist **list, const char *list_str,
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
 void arch__sym_update(struct symbol *s, GElf_Sym *sym);
+void arch__adjust_sym_map_offset(GElf_Sym *sym,
+				 GElf_Shdr *shdr __maybe_unused,
+				 struct map *map __maybe_unused);
 #endif
 
 #define SYMBOL_A 0
-- 
2.13.4
