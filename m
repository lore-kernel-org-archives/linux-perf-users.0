From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/3] perf: Include JVMTI support for s390
Date: Mon,  9 Sep 2019 13:41:15 +0200
Message-ID: <20190909114116.50469-3-tmricht@linux.ibm.com>
References: <20190909114116.50469-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190909114116.50469-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.ibm.com, gor@linux.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Enable JTI support for s390 perf tool chain

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/arch/s390/Makefile | 1 +
 tools/perf/util/genelf.h      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index cb198787570a..6ac8887be7c9 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -4,6 +4,7 @@ PERF_HAVE_DWARF_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
+PERF_HAVE_JITDUMP := 1
 
 #
 # Syscall table generation for perf
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index b72440bf9a79..d4137559be05 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -35,6 +35,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #elif defined(__sparc__)
 #define GEN_ELF_ARCH	EM_SPARC
 #define GEN_ELF_CLASS	ELFCLASS32
+#elif defined(__s390x__)
+#define GEN_ELF_ARCH	EM_S390
+#define GEN_ELF_CLASS	ELFCLASS64
 #else
 #error "unsupported architecture"
 #endif
-- 
2.21.0
