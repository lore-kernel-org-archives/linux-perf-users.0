Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53047139F;
	Tue,  9 Jul 2024 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503833; cv=none; b=oaaqCoHJ1r0q5bd2mlr+Q4xHp9rp2+6pDHqWtU7KA77SG9hla+0xPQc1FEkS0QH5+0ott0LmLE9ctA9HVCitvpV2WCy735PRwEM2kgV2w3TjhwK/YYJQBiQPIybJLJCgmj6Rsu3jyxB0hQnuzcDMmSZTySgQwSknQ0O3kH2/g2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503833; c=relaxed/simple;
	bh=od1n4zy8osQlD7k7VfiAEzfL1iPPQCGHPtG2pdYpFkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9Fagz5gx/um34gjBIOUYAw1u+qaGtBxcSHVFxJRAVNzDKPn4ULwfg58wmDsuvzev6Gh3u3LAxtsH4BIfwgUcg/1NCYUrbrbeHfKf/tHxnLW4HxnjFj/Wk2NSefj+WaGWV0YMFGZPBbGWEakjxyiFeKFHHYIM1q+9pZ1RZeDgco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=iMOodFga; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iMOodFga"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4695gsek3374655
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 8 Jul 2024 22:42:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4695gsek3374655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720503779;
	bh=KY3/TlDVX3F1LlfRxsxqrMzmbQ35lUV3hyGmROgX8c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMOodFgaNGPvxaJEhOJ64I2hDqZ9eBqJpNaOfJ5udP2ltQGU1u83z2I4oEXuKGaMx
	 zwtXFEnlgHu2wfcHyZ1nAZHSKajgY+j0DI8i289B7axG9Rhzy/+ey9lfUdO0rjzeKH
	 YcMZlL1p3ad1w5GZ7Dt3vvcBSX9lqzl9YtFeNUQn8xx/fcs5GP5WtHh1DHUc7oIjQi
	 NCuBCZx7GuZWXe6dWCDgFo0E8K9lOmEgeoSBlNmSjfoMBoXFK1RXGnMMcUagYfJuNf
	 vCCyUjNANFqyC0H+Wo5kV7fq6R7fxmfSrLF43PKqXCEBg7pgtmSzaM1Q78+WPIqA+E
	 UkNQ7DYmWs8Dw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com,
        andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: [PATCH v4A 2/4] x86/cpufeatures: Generate a feature mask header based on build config
Date: Mon,  8 Jul 2024 22:42:54 -0700
Message-ID: <20240709054254.3374645-1-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <df5b3001-e79b-4bfd-a2a1-c63111feba8a@suse.com>
References: <df5b3001-e79b-4bfd-a2a1-c63111feba8a@suse.com>
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

Change since v4:
* More polishes (Nikolay Borisov).

Changes since v3:
* Add a few high-level comments to the AWK script (Nikolay Borisov).
* Enforce CPU feature mask values to be unsigned.

Changes since v2:
* Remove AWK code that generates extra debugging comments (Brian Gerst).
* Move SSE_MASK to verify_cpu.S, the only place it is used (Brian Gerst).

Change since v1:
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
index 801fd85c3ef6..211c0820b150 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -261,9 +261,22 @@ archscripts: scripts_basic
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
index a192bdea69e2..29c3481f40fc 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -8,6 +8,7 @@ generated-y += syscalls_x32.h
 generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
+generated-y += featuremasks.h
 
 generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 0b9611da6c53..8332f596ba3c 100644
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
index 6007462e03d6..4a297a8a376c 100644
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
index 000000000000..dfac56a697fc
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
+BEGINFILE {
+	switch (++file) {
+	case 1:			# cpufeatures.h
+		FPAT = "#[ \t]*[a-z]+|[A-Za-z0-9_]+|[^ \t]";
+		break;
+	case 2:			# .config
+		FPAT = "CONFIG_[A-Z0-9_]+|is not set|[yn]";
+		break;
+	}
+}
+
+# Create a dictionary of sorts, containing all defined feature bits
+file == 1 && $1 ~ /^#[ \t]*define$/ && $2 ~ /^X86_FEATURE_/ &&
+$3 == "(" && $5 == "*" && $7 == "+" && $9 == ")" {
+	nfeat = $4 * $6 + $8;
+	feat = $2;
+	sub(/^X86_FEATURE_/, "", feat);
+	feats[nfeat] = feat;
+}
+file == 1 && $1 ~ /^#[ \t]*define$/ && $2 == "NCAPINTS" {
+	ncapints = strtonum($3);
+}
+
+# Create a dictionary featstat[REQUIRED|DISABLED, FEATURE_NAME] = on | off
+file == 2 && $1 ~ /^CONFIG_X86_[A-Z]*_FEATURE_/ {
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
2.45.2

