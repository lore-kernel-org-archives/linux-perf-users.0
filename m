Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB941DE3B8;
	Fri, 28 Feb 2025 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731070; cv=none; b=aEPICNMv9Y0Um7rQDeSAoXlQryR6hhlDa9A5GM3B8jvHlf0R4dpP3HhfQvqLCWD7HGilwsq/4TvMKZWqaj59nuChh4ZXaSXzm42B5QCQyzjlbEC4j0EqybYL/Rg5Ugj32roneEmwqRNKztycgPTCkpxE2XTLwUvNU8FCHT5veKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731070; c=relaxed/simple;
	bh=LlSkIAX/djOnsdZDBMCPrY1O5qB47kR43gsKeMKYdAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiHfpZklgFsxF9+/9Vsq+tghzJpFpvpY6F+rYbU8wMhAc1ANajTfNfnZuJezhqD+7eAkcjueyjiNSO/Ifepbyaz0Hsh/Zi4TALA3buAMABQy5a+/rU0O4BqkIXviHaCTXvOJL0bYRH9xL9nYPSz2U8eCzfYn754fg30YWoBBskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=QTDiHnwW; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QTDiHnwW"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51S8NdZY073880
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 28 Feb 2025 00:23:47 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51S8NdZY073880
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740731028;
	bh=38fasgPW0PfrZf0oSj1iXowgmsm+bi29oIMkTXvEjf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTDiHnwWwQuzRhbj6B3iXixzWz7UhtkkZMxi8i1rAmN4q/VfuXmeCGbOoJiZ0o4St
	 lW//3vG+afEEcZSb6y95Ryrh3eqHOnF3dn9Cy0ZLKscEc3xJpFu8rqkyk6NnMdv+Px
	 +YyMfbvKoDw9DFdibma3PVowPg9EM7ZA0OiCZ++9l4Af2zsmYw3t4STU6MdHj5f3KF
	 dNcLb9+etcEBH3vPJbs4OKzPAR0m1W8H8xIxmspkQ6g1/A2ZXOgA/BV5no7wj8m0zP
	 zj+8pDe4CvPKAmfSZbxV9I6j04gVWpiyag3ZdriFLW6ZdA5pNnAsVEo7ruqzD0zQLM
	 U/FdjSCOx2gnw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
        brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: [PATCH v6 3/5] x86/cpufeatures: Generate a feature mask header based on build config
Date: Fri, 28 Feb 2025 00:23:36 -0800
Message-ID: <20250228082338.73859-4-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228082338.73859-1-xin@zytor.com>
References: <20250228082338.73859-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Introduce an AWK script to auto-generate a header with required and
disabled feature masks based on <asm/cpufeatures.h> and current build
config. Thus for any CPU feature with a build config, e.g., X86_FRED,
simply add

config X86_DISABLED_FEATURE_FRED
	def_bool y
	depends on !X86_FRED

to arch/x86/Kconfig.cpufeatures, instead of adding a conditional CPU
feature disable flag, e.g., DISABLE_FRED.

Lastly the generated required and disabled feature masks will be added
to their corresponding feature masks for this particular compile-time
configuration.

[ Xin: build integration improvements ]

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
---

Change in v6:
* Make the AWK script work for mawk and BusyBox awk (Borislav Petkov).

Change in v5:
* More polishes (Nikolay Borisov).

Changes in v4:
* Add a few high-level comments to the AWK script (Nikolay Borisov).
* Enforce CPU feature mask values to be unsigned.

Changes in v3:
* Remove AWK code that generates extra debugging comments (Brian Gerst).
* Move SSE_MASK to verify_cpu.S, the only place it is used (Brian Gerst).

Change in v2:
* Remove code generating unused macros {REQUIRED,DISABLED}_FEATURE(x)
  to tell if a CPU feature, e.g., X86_FEATURE_FRED, is a required or
  disabled feature for this particular compile-time configuration.
---
 arch/x86/Makefile                  | 17 ++++++-
 arch/x86/boot/cpucheck.c           |  3 +-
 arch/x86/boot/cpuflags.c           |  1 -
 arch/x86/boot/mkcpustr.c           |  3 +-
 arch/x86/include/asm/Kbuild        |  1 +
 arch/x86/include/asm/cpufeature.h  |  1 +
 arch/x86/include/asm/cpufeatures.h |  8 ---
 arch/x86/kernel/verify_cpu.S       |  4 ++
 arch/x86/tools/featuremasks.awk    | 81 ++++++++++++++++++++++++++++++
 9 files changed, 105 insertions(+), 14 deletions(-)
 create mode 100755 arch/x86/tools/featuremasks.awk

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 6784129328f6..60583987d320 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -263,9 +263,22 @@ archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
 
 ###
-# Syscall table generation
+# Feature masks header and syscall table generation
 
-archheaders:
+out := arch/x86/include/generated/asm
+featuremasks_hdr := featuremasks.h
+featuremasks_awk := $(srctree)/arch/x86/tools/featuremasks.awk
+cpufeatures_hdr := $(srctree)/arch/x86/include/asm/cpufeatures.h
+quiet_cmd_gen_featuremasks = GEN     $@
+      cmd_gen_featuremasks = $(AWK) -f $(featuremasks_awk) $(cpufeatures_hdr) $(KCONFIG_CONFIG) > $@
+
+$(out)/$(featuremasks_hdr): $(featuremasks_awk) $(cpufeatures_hdr) $(KCONFIG_CONFIG) FORCE
+	$(shell mkdir -p $(out))
+	$(call if_changed,gen_featuremasks)
+
+targets += $(out)/$(featuremasks_hdr)
+
+archheaders: $(out)/$(featuremasks_hdr)
 	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
 
 ###
diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
index 0aae4d4ed615..8d03a741d1b2 100644
--- a/arch/x86/boot/cpucheck.c
+++ b/arch/x86/boot/cpucheck.c
@@ -22,10 +22,11 @@
 # include "boot.h"
 #endif
 #include <linux/types.h>
+#include <asm/featuremasks.h>
 #include <asm/intel-family.h>
 #include <asm/processor-flags.h>
-#include <asm/required-features.h>
 #include <asm/msr-index.h>
+
 #include "string.h"
 #include "msr.h"
 
diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index d75237ba7ce9..0cabdacb2a2f 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -3,7 +3,6 @@
 #include "bitops.h"
 
 #include <asm/processor-flags.h>
-#include <asm/required-features.h>
 #include <asm/msr-index.h>
 #include "cpuflags.h"
 
diff --git a/arch/x86/boot/mkcpustr.c b/arch/x86/boot/mkcpustr.c
index da0ccc5de538..b90110109675 100644
--- a/arch/x86/boot/mkcpustr.c
+++ b/arch/x86/boot/mkcpustr.c
@@ -12,8 +12,6 @@
 
 #include <stdio.h>
 
-#include "../include/asm/required-features.h"
-#include "../include/asm/disabled-features.h"
 #include "../include/asm/cpufeatures.h"
 #include "../include/asm/vmxfeatures.h"
 #include "../kernel/cpu/capflags.c"
@@ -23,6 +21,7 @@ int main(void)
 	int i, j;
 	const char *str;
 
+	printf("#include <asm/featuremasks.h>\n\n");
 	printf("static const char x86_cap_strs[] =\n");
 
 	for (i = 0; i < NCAPINTS; i++) {
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 58f4ddecc5fa..51022d21003e 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -8,6 +8,7 @@ generated-y += syscalls_x32.h
 generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
+generated-y += featuremasks.h
 
 generic-y += early_ioremap.h
 generic-y += fprobe.h
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index de1ad09fe8d7..077a5bbd1cc5 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -9,6 +9,7 @@
 #include <asm/asm.h>
 #include <linux/bitops.h>
 #include <asm/alternative.h>
+#include <asm/featuremasks.h>
 
 enum cpuid_leafs
 {
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index c8701abb7752..b9b7329f4ac4 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -2,14 +2,6 @@
 #ifndef _ASM_X86_CPUFEATURES_H
 #define _ASM_X86_CPUFEATURES_H
 
-#ifndef _ASM_X86_REQUIRED_FEATURES_H
-#include <asm/required-features.h>
-#endif
-
-#ifndef _ASM_X86_DISABLED_FEATURES_H
-#include <asm/disabled-features.h>
-#endif
-
 /*
  * Defines x86 CPU feature bits
  */
diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
index 1258a5872d12..a23a65d5d177 100644
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -29,8 +29,12 @@
  */
 
 #include <asm/cpufeatures.h>
+#include <asm/featuremasks.h>
 #include <asm/msr-index.h>
 
+#define SSE_MASK	\
+	(REQUIRED_MASK0 & ((1<<(X86_FEATURE_XMM & 31)) | (1<<(X86_FEATURE_XMM2 & 31))))
+
 SYM_FUNC_START_LOCAL(verify_cpu)
 	pushf				# Save caller passed flags
 	push	$0			# Kill any dangerous flags
diff --git a/arch/x86/tools/featuremasks.awk b/arch/x86/tools/featuremasks.awk
new file mode 100755
index 000000000000..fd3e72147157
--- /dev/null
+++ b/arch/x86/tools/featuremasks.awk
@@ -0,0 +1,81 @@
+#!/usr/bin/awk
+#
+# Convert cpufeatures.h to a list of compile-time masks
+# Note: this blithly assumes that each word has at least one
+# feature defined in it; if not, something else is wrong!
+#
+
+BEGIN {
+	printf "#ifndef _ASM_X86_FEATUREMASKS_H\n";
+	printf "#define _ASM_X86_FEATUREMASKS_H\n\n";
+
+	file = 0
+}
+
+FNR == 1 {
+	++file;
+
+	# arch/x86/include/asm/cpufeatures.h
+	if (file == 1)
+		FS = "[ \t()*+]+";
+
+	# .config
+	if (file == 2)
+		FS = "=";
+}
+
+# Create a dictionary of sorts, containing all defined feature bits
+file == 1 && $1 ~ /^#define$/ && $2 ~ /^X86_FEATURE_/ {
+	nfeat = $3 * $4 + $5;
+	feat = $2;
+	sub(/^X86_FEATURE_/, "", feat);
+	feats[nfeat] = feat;
+}
+file == 1 && $1 ~ /^#define$/ && $2 == "NCAPINTS" {
+	ncapints = int($3);
+}
+
+# Create a dictionary featstat[REQUIRED|DISABLED, FEATURE_NAME] = on | off
+file == 2 && $1 ~ /^CONFIG_X86_(REQUIRED|DISABLED)_FEATURE_/ {
+	on = ($2 == "y");
+	if (split($1, fs, "CONFIG_X86_|_FEATURE_") == 3)
+		featstat[fs[2], fs[3]] = on;
+}
+
+END {
+	sets[1] = "REQUIRED";
+	sets[2] = "DISABLED";
+
+	for (ns in sets) {
+		s = sets[ns];
+
+		printf "/*\n";
+		printf " * %s features:\n", s;
+		printf " *\n";
+		fstr = "";
+		for (i = 0; i < ncapints; i++) {
+			mask = 0;
+			for (j = 0; j < 32; j++) {
+				feat = feats[i*32 + j];
+				if (featstat[s, feat]) {
+					nfstr = fstr " " feat;
+					if (length(nfstr) > 72) {
+						printf " *   %s\n", fstr;
+						nfstr = " " feat;
+					}
+					fstr = nfstr;
+					mask += (2 ^ j);
+				}
+			}
+			masks[i] = mask;
+		}
+		printf " *   %s\n */\n", fstr;
+
+		for (i = 0; i < ncapints; i++)
+			printf "#define %s_MASK%d\t0x%08xU\n", s, i, masks[i];
+
+		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
+	}
+
+	printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
+}
-- 
2.48.1

