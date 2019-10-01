From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/24] perf annotate: Fix arch specific ->init() failure errors
Date: Tue,  1 Oct 2019 08:12:14 -0300
Message-ID: <20191001111216.7208-23-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

They are called from symbol__annotate() and to propagate errors that can
help understand the problem make them return what
symbol__strerror_disassemble() known, i.e. errno codes and other
annotation specific errors in a special, out of errnos, range.

Reported-by: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-pqx7srcv7tixgid251aeboj6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/annotate/instructions.c   | 4 ++--
 tools/perf/arch/arm64/annotate/instructions.c | 4 ++--
 tools/perf/arch/s390/annotate/instructions.c  | 6 ++++--
 tools/perf/arch/x86/annotate/instructions.c   | 6 ++++--
 tools/perf/util/annotate.c                    | 6 ++++++
 tools/perf/util/annotate.h                    | 2 ++
 6 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/arch/arm/annotate/instructions.c
index e1d4b484cc4b..2ff6cedeb9c5 100644
--- a/tools/perf/arch/arm/annotate/instructions.c
+++ b/tools/perf/arch/arm/annotate/instructions.c
@@ -37,7 +37,7 @@ static int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 
 	arm = zalloc(sizeof(*arm));
 	if (!arm)
-		return -1;
+		return ENOMEM;
 
 #define ARM_CONDS "(cc|cs|eq|ge|gt|hi|le|ls|lt|mi|ne|pl|vc|vs)"
 	err = regcomp(&arm->call_insn, "^blx?" ARM_CONDS "?$", REG_EXTENDED);
@@ -59,5 +59,5 @@ static int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	regfree(&arm->call_insn);
 out_free_arm:
 	free(arm);
-	return -1;
+	return SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
 }
diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 43aa93ed8414..037e292ecd8e 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -95,7 +95,7 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 
 	arm = zalloc(sizeof(*arm));
 	if (!arm)
-		return -1;
+		return ENOMEM;
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
@@ -118,5 +118,5 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	regfree(&arm->call_insn);
 out_free_arm:
 	free(arm);
-	return -1;
+	return SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
 }
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 89bb8f2c54ce..a50e70baf918 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -164,8 +164,10 @@ static int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	if (!arch->initialized) {
 		arch->initialized = true;
 		arch->associate_instruction_ops = s390__associate_ins_ops;
-		if (cpuid)
-			err = s390__cpuid_parse(arch, cpuid);
+		if (cpuid) {
+			if (s390__cpuid_parse(arch, cpuid))
+				err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
+		}
 	}
 
 	return err;
diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 44f5aba78210..7eb5621c021d 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -196,8 +196,10 @@ static int x86__annotate_init(struct arch *arch, char *cpuid)
 	if (arch->initialized)
 		return 0;
 
-	if (cpuid)
-		err = x86__cpuid_parse(arch, cpuid);
+	if (cpuid) {
+		if (x86__cpuid_parse(arch, cpuid))
+			err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
+	}
 
 	arch->initialized = true;
 	return err;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1de1a7091c48..dc15352924f9 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1631,6 +1631,12 @@ int symbol__strerror_disassemble(struct symbol *sym __maybe_unused, struct map *
 	case SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF:
 		scnprintf(buf, buflen, "Please link with binutils's libopcode to enable BPF annotation");
 		break;
+	case SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP:
+		scnprintf(buf, buflen, "Problems with arch specific instruction name regular expressions.");
+		break;
+	case SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING:
+		scnprintf(buf, buflen, "Problems while parsing the CPUID in the arch specific initialization.");
+		break;
 	default:
 		scnprintf(buf, buflen, "Internal error: Invalid %d error code\n", errnum);
 		break;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d94be9140e31..116e21f49da6 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -370,6 +370,8 @@ enum symbol_disassemble_errno {
 
 	SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX	= __SYMBOL_ANNOTATE_ERRNO__START,
 	SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF,
+	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING,
+	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP,
 
 	__SYMBOL_ANNOTATE_ERRNO__END,
 };
-- 
2.21.0
