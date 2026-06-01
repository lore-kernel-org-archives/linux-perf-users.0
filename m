Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1C3806CE
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296877; cv=none; b=B60eb6c5l8sYZy0VlcwLt9PDcZEQPckdwtpLG/6id/KqlrlO9NHMA4QamTqvjri42RFXmGuwZR4PNTxsak2qWMzBcIG0le6SPNOVl1y0q3nPJ6t1esCiMirKVj7ub3m9yBt1sv5FJbpIt8H/msfG5sDSCOAopEcgL6CMUhP5YGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296877; c=relaxed/simple;
	bh=paAhGMuVcFCJawkYRHI1yb+PMES60j9yTRYSD8knZOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XuveEtrvHjCrW3VYvAp+fFuBrl6D/NLsPu8VHE5eaJs78tNmZi5VD+Yb25J+VpFQQUh7PamCcpqPkdtcMPD60H9fpoyfhLeW/2cXz+aDHGe4suwSXSAYkDFfvoCbLU1ho9/QUAfNVsxOBP0wNcdTJ/R4ujeFHANbJGgeLdkvWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DLOlB3aC; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLOlB3aC"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135916eefa0so13425978c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296873; x=1780901673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=stvvHCX8qouUxL2lu5v4L2Thox3XkwMaO5uo38gU10I=;
        b=DLOlB3aCpDWRfmFK/zRCT7ik4CXnc64mjK9KiPVXN49T7rZeIJbOSDgIPUu+QpGBtn
         Tnd/Smmeg/WMwYZmRyGU764GOl4yPNro2eKFietI75gOmLZW+v9SL3+nGTJQtE0JAOu3
         5vbeHFw2C3AJ+StFwaBhdMgiB1jyqOGeZJn3YdjxG891a1WKWvuVo5wAzgqVCGcUSyo9
         h66NavW7Mtb+exYbwz/lQLbdr0jSgUQyF4PXneumhA/l18g5VT2x1iIALX6/ORskZ328
         Yf1Ol8Y1fWDiSJEtIra6ZO4vneRQldPwC+Dfh7RtXBe0lssO/qdU37lmPnmrCJCTD6HA
         +FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296873; x=1780901673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stvvHCX8qouUxL2lu5v4L2Thox3XkwMaO5uo38gU10I=;
        b=oTpQ21JsIoY0NDHzre3TykhuDAxsKl09NCOBPf+iD22gLj75ufsKm6LYqr44Lco/H2
         qyvtA8YIP7rvLnPQ40irJwmfZysbMzogNUOeEoOGtkxVjDP4mqZSnq70FNfe/UEwW8K7
         sidmTRVzyBIRWg0rNJMmMZgAWlNmE+mFrJo4KATwx2sjGjJlhR7ftB6dE4RS55dWJMYR
         FXoMcAaGDe6oNUa0XorGamoSgLVovPKj2f3+aHeGyIKZTGhz1cJdik+MISjJ1cCmmLiJ
         TcUfhp3HQsy3ihnKCwsVOVjwPo0f56EHdCW38TWRMtD784PXM2LuIS1FJTud/y6oJJFG
         kHMA==
X-Forwarded-Encrypted: i=1; AFNElJ/wgRVvGABjjtt0UVDCE7DGP3p6LeFpO6GiQezzfU20zkY0HnQ5oemz6e+v8PvBV3uCEBrLxSyZvgasYavBauqv@vger.kernel.org
X-Gm-Message-State: AOJu0YzaMO0kwtvI0ShBisGhXNlnBu6DUjfgspbVkXoiTYWj1wozuzSr
	ZbvhO5LJE5CzPS4XLe4SBmbNWTs50i9bMKLjq8q3xUL8frZ3DBTlggR/9kEFv7VYqxhPb+MQlFB
	1/uwzOY2Y2g==
X-Received: from dlea3-n2.prod.google.com ([2002:a05:701b:4203:20b0:135:dd6a:be57])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41:b0:135:608a:2864
 with SMTP id a92af1059eb24-137d42494e3mr4069314c88.33.1780296872813; Sun, 31
 May 2026 23:54:32 -0700 (PDT)
Date: Sun, 31 May 2026 23:53:59 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-11-irogers@google.com>
Subject: [PATCH v10 10/18] perf arch common: Use perf_env e_machine rather
 than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/common.c | 92 ++++++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index ad0cab830a4d..805a15ed99bc 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -1,13 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "common.h"
+
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+
+#include <linux/zalloc.h>
 #include <unistd.h>
-#include "common.h"
-#include "../util/env.h"
+
+#include <dwarf-regs.h>
+
 #include "../util/debug.h"
-#include <linux/zalloc.h>
+#include "../util/env.h"
 
 static const char *const arc_triplets[] = {
 	"arc-linux-",
@@ -141,11 +146,40 @@ static int lookup_triplets(const char *const *triplets, const char *name)
 	return -1;
 }
 
+static bool is_native_compatible(struct perf_env *env, uint16_t target, uint16_t host)
+{
+	if (target != host) {
+		/* A 64-bit host can natively disassemble its 32-bit compat architecture */
+		if (host == EM_X86_64 && target == EM_386)
+			return true;
+		if (host == EM_AARCH64 && target == EM_ARM)
+			return true;
+		if (host == EM_PPC64 && target == EM_PPC)
+			return true;
+		if (host == EM_SPARCV9 && target == EM_SPARC)
+			return true;
+		return false;
+	}
+
+	/* target == host case */
+	if (target == EM_RISCV) {
+		bool target_is_64 = perf_env__kernel_is_64_bit(env);
+		bool host_is_64 = (sizeof(void *) == 8);
+
+		/* 32-bit host cannot natively disassemble 64-bit target */
+		if (!host_is_64 && target_is_64)
+			return false;
+	}
+
+	return true;
+}
+
 static int perf_env__lookup_binutils_path(struct perf_env *env,
 					  const char *name, char **path)
 {
 	int idx;
-	const char *arch = perf_env__arch(env), *cross_env;
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
+	const char *cross_env;
 	const char *const *path_list;
 	char *buf = NULL;
 
@@ -153,7 +187,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 	 * We don't need to try to find objdump path for native system.
 	 * Just use default binutils path (e.g.: "objdump").
 	 */
-	if (!strcmp(perf_env__arch(NULL), arch))
+	if (is_native_compatible(env, e_machine, EM_HOST))
 		goto out;
 
 	cross_env = getenv("CROSS_COMPILE");
@@ -170,30 +204,42 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		zfree(&buf);
 	}
 
-	if (!strcmp(arch, "arc"))
+	switch (e_machine) {
+	case EM_ARC:
 		path_list = arc_triplets;
-	else if (!strcmp(arch, "arm"))
+		break;
+	case EM_ARM:
 		path_list = arm_triplets;
-	else if (!strcmp(arch, "arm64"))
+		break;
+	case EM_AARCH64:
 		path_list = arm64_triplets;
-	else if (!strcmp(arch, "powerpc"))
+		break;
+	case EM_PPC:
+	case EM_PPC64:
 		path_list = powerpc_triplets;
-	else if (!strcmp(arch, "riscv32"))
-		path_list = riscv32_triplets;
-	else if (!strcmp(arch, "riscv64"))
-		path_list = riscv64_triplets;
-	else if (!strcmp(arch, "sh"))
+		break;
+	case EM_RISCV:
+		path_list = perf_env__kernel_is_64_bit(env) ? riscv64_triplets : riscv32_triplets;
+		break;
+	case EM_SH:
 		path_list = sh_triplets;
-	else if (!strcmp(arch, "s390"))
+		break;
+	case EM_S390:
 		path_list = s390_triplets;
-	else if (!strcmp(arch, "sparc"))
+		break;
+	case EM_SPARC:
+	case EM_SPARCV9:
 		path_list = sparc_triplets;
-	else if (!strcmp(arch, "x86"))
+		break;
+	case EM_X86_64:
+	case EM_386:
 		path_list = x86_triplets;
-	else if (!strcmp(arch, "mips"))
+		break;
+	case EM_MIPS:
 		path_list = mips_triplets;
-	else {
-		ui__error("binutils for %s not supported.\n", arch);
+		break;
+	default:
+		ui__error("binutils for %s not supported.\n", perf_env__arch(env));
 		goto out_error;
 	}
 
@@ -202,7 +248,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		ui__error("Please install %s for %s.\n"
 			  "You can add it to PATH, set CROSS_COMPILE or "
 			  "override the default using --%s.\n",
-			  name, arch, name);
+			  name, perf_env__arch(env), name);
 		goto out_error;
 	}
 
@@ -237,7 +283,7 @@ int perf_env__lookup_objdump(struct perf_env *env, char **path)
  */
 bool perf_env__single_address_space(struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
 
-	return strcmp(arch, "s390") && strcmp(arch, "sparc");
+	return e_machine != EM_SPARC && e_machine != EM_SPARCV9;
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog

