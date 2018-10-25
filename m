From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/37] perf jitdump: Add Sparc support.
Date: Thu, 25 Oct 2018 08:09:57 -0300
Message-ID: <20181025111031.3440-4-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Miller <davem@davemloft.net>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Miller <davem@davemloft.net>

Signed-off-by: David S. Miller <davem@davemloft.net>
Link: http://lkml.kernel.org/r/20181016.211545.1487970139012324624.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/sparc/Makefile | 2 ++
 tools/perf/util/genelf.h       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/arch/sparc/Makefile b/tools/perf/arch/sparc/Makefile
index 7fbca175099e..275dea7ff59a 100644
--- a/tools/perf/arch/sparc/Makefile
+++ b/tools/perf/arch/sparc/Makefile
@@ -1,3 +1,5 @@
 ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
+
+PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index de322d51c7fe..b72440bf9a79 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -29,6 +29,12 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #elif defined(__powerpc__)
 #define GEN_ELF_ARCH	EM_PPC
 #define GEN_ELF_CLASS	ELFCLASS32
+#elif defined(__sparc__) && defined(__arch64__)
+#define GEN_ELF_ARCH	EM_SPARCV9
+#define GEN_ELF_CLASS	ELFCLASS64
+#elif defined(__sparc__)
+#define GEN_ELF_ARCH	EM_SPARC
+#define GEN_ELF_CLASS	ELFCLASS32
 #else
 #error "unsupported architecture"
 #endif
-- 
2.14.4
