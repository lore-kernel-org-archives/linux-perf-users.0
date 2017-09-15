From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 1/2] perf test: fix vmlinux failure on s390x
Date: Fri, 15 Sep 2017 09:14:03 +0200
Message-ID: <20170915071404.58398-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750787AbdIOHOe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Sep 2017 03:14:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8F7EVAk108264
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Sep 2017 03:14:33 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d05x1bcd0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Sep 2017 03:14:33 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Fri, 15 Sep 2017 08:14:17 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: =brueckner@linux.vnet.ibm.com, =zvonko.kosic@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

On s390x perf test 1 failed. It turned out that commit 4a084ecfc821
("perf report: Fix module symbol adjustment for s390x") was incorrect.
The previous implementation in dso__load_sym() is also
suitable for s390x.
Therefore this patch undoes commit 4a084ecfc821.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/util/sym-handling.c | 8 --------
 tools/perf/util/symbol-elf.c             | 8 +-------
 tools/perf/util/symbol.h                 | 3 ---
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/perf/arch/s390/util/sym-handling.c b/tools/perf/arch/s390/util/sym-handling.c
index e103f6e..581d4c5 100644
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
index 5c39f42..9cf781f 100644
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
index 2bd6a1f..aad99e7 100644
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
2.9.3
