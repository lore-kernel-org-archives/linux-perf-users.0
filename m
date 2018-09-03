From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/13] perf probe powerpc: Ignore SyS symbols irrespective of endianness
Date: Mon,  3 Sep 2018 11:52:23 -0300
Message-ID: <20180903145224.12318-13-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sandipan Das <sandipan@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

This makes sure that the SyS symbols are ignored for any powerpc system,
not just the big endian ones.

Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Fixes: fb6d59423115 ("perf probe ppc: Use the right prefix when ignoring SyS symbols on ppc")
Link: http://lkml.kernel.org/r/20180828090848.1914-1-sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 20e7d74d86cd..10a44e946f77 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -22,15 +22,16 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 
 #endif
 
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
 int arch__choose_best_symbol(struct symbol *syma,
 			     struct symbol *symb __maybe_unused)
 {
 	char *sym = syma->name;
 
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
 	/* Skip over any initial dot */
 	if (*sym == '.')
 		sym++;
+#endif
 
 	/* Avoid "SyS" kernel syscall aliases */
 	if (strlen(sym) >= 3 && !strncmp(sym, "SyS", 3))
@@ -41,6 +42,7 @@ int arch__choose_best_symbol(struct symbol *syma,
 	return SYMBOL_A;
 }
 
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
 /* Allow matching against dot variants */
 int arch__compare_symbol_names(const char *namea, const char *nameb)
 {
-- 
2.14.4
