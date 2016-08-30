From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf symbols: Demangle symbols for synthesized @plt entries.
Date: Tue, 30 Aug 2016 13:41:02 +0200
Message-ID: <20160830114102.30863-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:35176 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756753AbcH3Lla (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Aug 2016 07:41:30 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

The symbols in the synthesized @plt entries where not demangled
before, i.e. we could end up with entries such as:

    $ perf report
    Samples: 7K of event 'cycles:ppp', Event count (approx.): 6223833141
    Children      Self  Command          Shared Object           Symbol
    -   93.63%    28.89%  lab_mandelbrot   lab_mandelbrot        [.] main
        - 73.81% main
            - 33.57% hypot
              27.76% __hypot_finite
              15.97% __muldc3
               2.90% __muldc3@plt
               2.40% _ZNK6QImage6heightEv@plt
             + 2.14% QColor::rgb
               1.94% _ZNK6QImage5widthEv@plt
               1.92% cabs@plt

This patch remedies this issue by also applying demangling to the
synthesized symbols. The output for the above is now:

    $ perf report
    Samples: 7K of event 'cycles:ppp', Event count (approx.): 6223833141
    Children      Self  Command          Shared Object           Symbol
    -   93.63%    28.89%  lab_mandelbrot   lab_mandelbrot        [.] main
        - 73.81% main
            - 33.57% hypot
              27.76% __hypot_finite
              15.97% __muldc3
               2.90% __muldc3@plt
               2.40% QImage::height() const@plt
             + 2.14% QColor::rgb
               1.94% QImage::width() const@plt
               1.92% cabs@plt

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/util/symbol-elf.c | 81 ++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index a811c13..fbe31ef 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -206,6 +206,37 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 	return NULL;
 }
 
+static bool want_demangle(bool is_kernel_sym)
+{
+	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
+}
+
+static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
+{
+	int demangle_flags = verbose ? (DMGL_PARAMS | DMGL_ANSI) : DMGL_NO_OPTS;
+	char *demangled = NULL;
+
+	/*
+	 * We need to figure out if the object was created from C++ sources
+	 * DWARF DW_compile_unit has this, but we don't always have access
+	 * to it...
+	 */
+	if (!want_demangle(dso->kernel || kmodule))
+	    return demangled;
+
+	demangled = bfd_demangle(NULL, elf_name, demangle_flags);
+	if (demangled == NULL)
+		demangled = java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
+	else if (rust_is_mangled(demangled))
+		/*
+		    * Input to Rust demangling is the BFD-demangled
+		    * name which it Rust-demangles in place.
+		    */
+		rust_demangle_sym(demangled);
+
+	return demangled;
+}
+
 #define elf_section__for_each_rel(reldata, pos, pos_mem, idx, nr_entries) \
 	for (idx = 0, pos = gelf_getrel(reldata, 0, &pos_mem); \
 	     idx < nr_entries; \
@@ -301,11 +332,19 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss, struct map *
 
 		elf_section__for_each_rela(reldata, pos, pos_mem, idx,
 					   nr_rel_entries) {
+			const char *elf_name = NULL;
+			char *demangled = NULL;
 			symidx = GELF_R_SYM(pos->r_info);
 			plt_offset += shdr_plt.sh_entsize;
 			gelf_getsym(syms, symidx, &sym);
+
+			elf_name = elf_sym__name(&sym, symstrs);
+			demangled = demangle_sym(dso, 0, elf_name);
+			if (demangled != NULL)
+				elf_name = demangled;
 			snprintf(sympltname, sizeof(sympltname),
-				 "%s@plt", elf_sym__name(&sym, symstrs));
+				 "%s@plt", elf_name);
+			free(demangled);
 
 			f = symbol__new(plt_offset, shdr_plt.sh_entsize,
 					STB_GLOBAL, sympltname);
@@ -323,11 +362,19 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss, struct map *
 		GElf_Rel pos_mem, *pos;
 		elf_section__for_each_rel(reldata, pos, pos_mem, idx,
 					  nr_rel_entries) {
+			const char *elf_name = NULL;
+			char *demangled = NULL;
 			symidx = GELF_R_SYM(pos->r_info);
 			plt_offset += shdr_plt.sh_entsize;
 			gelf_getsym(syms, symidx, &sym);
+
+			elf_name = elf_sym__name(&sym, symstrs);
+			demangled = demangle_sym(dso, 0, elf_name);
+			if (demangled != NULL)
+				elf_name = demangled;
 			snprintf(sympltname, sizeof(sympltname),
-				 "%s@plt", elf_sym__name(&sym, symstrs));
+				 "%s@plt", elf_name);
+			free(demangled);
 
 			f = symbol__new(plt_offset, shdr_plt.sh_entsize,
 					STB_GLOBAL, sympltname);
@@ -775,11 +822,6 @@ static u64 ref_reloc(struct kmap *kmap)
 	return 0;
 }
 
-static bool want_demangle(bool is_kernel_sym)
-{
-	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
-}
-
 void __weak arch__sym_update(struct symbol *s __maybe_unused,
 		GElf_Sym *sym __maybe_unused) { }
 
@@ -1070,29 +1112,10 @@ int dso__load_sym(struct dso *dso, struct map *map,
 			sym.st_value -= shdr.sh_addr - shdr.sh_offset;
 		}
 new_symbol:
-		/*
-		 * We need to figure out if the object was created from C++ sources
-		 * DWARF DW_compile_unit has this, but we don't always have access
-		 * to it...
-		 */
-		if (want_demangle(dso->kernel || kmodule)) {
-			int demangle_flags = DMGL_NO_OPTS;
-			if (verbose)
-				demangle_flags = DMGL_PARAMS | DMGL_ANSI;
-
-			demangled = bfd_demangle(NULL, elf_name, demangle_flags);
-			if (demangled == NULL)
-				demangled = java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
-			else if (rust_is_mangled(demangled))
-				/*
-				 * Input to Rust demangling is the BFD-demangled
-				 * name which it Rust-demangles in place.
-				 */
-				rust_demangle_sym(demangled);
+		demangled = demangle_sym(dso, kmodule, elf_name);
+		if (demangled != NULL)
+			elf_name = demangled;
 
-			if (demangled != NULL)
-				elf_name = demangled;
-		}
 		f = symbol__new(sym.st_value, sym.st_size,
 				GELF_ST_BIND(sym.st_info), elf_name);
 		free(demangled);
-- 
2.9.3
