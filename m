From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/7] perf test: Fix vmlinux failure on s390x
Date: Fri, 29 Sep 2017 13:00:16 -0300
Message-ID: <20170929160017.29335-7-acme@kernel.org>
References: <20170929160017.29335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929160017.29335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Zvonko Kosic <zvonko.kosic@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

On s390x perf test 1 failed. It turned out that commit 4a084ecfc821
("perf report: Fix module symbol adjustment for s390x") was incorrect.
The previous implementation in dso__load_sym() is also suitable for
s390x.

Therefore this patch undoes commit 4a084ecfc821.

Signed-off-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Zvonko Kosic <zvonko.kosic@de.ibm.com>
Fixes: 4a084ecfc821 ("perf report: Fix module symbol adjustment for s390x")
LPU-Reference: 20170915071404.58398-1-tmricht@linux.vnet.ibm.com
Link: http://lkml.kernel.org/n/tip-5ani7ly57zji7s0hmzkx416l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/sym-handling.c | 8 --------
 tools/perf/util/symbol-elf.c             | 8 +-------
 tools/perf/util/symbol.h                 | 3 ---
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/perf/arch/s390/util/sym-handling.c b/tools/perf/arch/s390/util/sym-handling.c
index e103f6e46afe..581d4c5a896b 100644
--- a/tools/perf/arch/s390/util/sym-handling.c
+++ b/tools/perf/arch/s390/util/sym-handling.c
@@ -18,12 +18,4 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 		return false;
 	return ehdr.e_type == ET_REL || ehdr.e_type == ET_DYN;
 }
-
-void arch__adjust_sym_map_offset(GElf_Sym *sym,
-				 GElf_Shdr *shdr __maybe_unused,
-				 struct map *map)
-{
-	if (map->type == MAP__FUNCTION)
-		sym->st_value += map->start;
-}
 #endif
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 5c39f420111e..9cf781f0d8a2 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -810,12 +810,6 @@ static u64 ref_reloc(struct kmap *kmap)
 void __weak arch__sym_update(struct symbol *s __maybe_unused,
 		GElf_Sym *sym __maybe_unused) { }
 
-void __weak arch__adjust_sym_map_offset(GElf_Sym *sym, GElf_Shdr *shdr,
-				       struct map *map __maybe_unused)
-{
-	sym->st_value -= shdr->sh_addr - shdr->sh_offset;
-}
-
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		  struct symsrc *runtime_ss, int kmodule)
 {
@@ -996,7 +990,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 			/* Adjust symbol to map to file offset */
 			if (adjust_kernel_syms)
-				arch__adjust_sym_map_offset(&sym, &shdr, map);
+				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
 
 			if (strcmp(section_name,
 				   (curr_dso->short_name +
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 2bd6a1f01a1c..aad99e7e179b 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -344,9 +344,6 @@ int setup_intlist(struct intlist **list, const char *list_str,
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
 void arch__sym_update(struct symbol *s, GElf_Sym *sym);
-void arch__adjust_sym_map_offset(GElf_Sym *sym,
-				 GElf_Shdr *shdr __maybe_unused,
-				 struct map *map __maybe_unused);
 #endif
 
 #define SYMBOL_A 0
-- 
2.13.5
