Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4DF2F4A0C
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705213; cv=none; b=XObzO00YwZ5Vt7+aYJePPQHCYv9l0Eo3DE8yO5RNs0NKH4+X+idpq0YBfzke+YFGsFPmoeAg6QlVm/kjek9wxt61avAaxWhaq/BZtOePmYdhMrEAlXAtwr/0U5pKpXVu+WQgPEsZixGl9fiK2MuXJkEWJ4L4AYkbiefrtvJq0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705213; c=relaxed/simple;
	bh=DL0FkAdJqRHCqRP3d1NRnpycL7mImdH6HLMS8H+qh7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CPSOGuNRH3dLzu0efgS0yBYrXiJsjBVKmrzgOTyhQzu91XnZMEOlTC59eSugFqlEFwUtl8Xm/8eEEc7XQAnpCB0zuQ47YWM6Xi3nb3pACruYu1zKQ6mWN2I5RnX5c/dFWYsKs0GkWuJPN/9UV3xBuuU+cxMdZzZARr53KKZEdiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHOFXF0d; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHOFXF0d"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3594620fe97so6734300a91.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 00:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705210; x=1778310010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4fl8atXwJsXGN4qhUfGPrxc+n6KtD9kAzXZ7gC0fcA=;
        b=UHOFXF0d80IURHSfj4Sf6cmv+aA4OjHzaZuF84pD70dhn0txoQhpcFul0asBT3bG56
         VwLZsHZvQTRfcjyFLdHLzz0KMRpzzZK9rI6i5rDfJ7UtGGTiGFopYNqQ1sLE070x02NM
         8nmB5TucD5mkB14c2C4ySakbQ2nBjYWbJGl24GkJka2Gey0JWTPp3801JRf0q5Wqo9aV
         sbKLwaeMWmJDZUNTMqTTHoYJNfOlvrdTyGFShtHhqQJNtDUOeCJLNywFiiWIrxdCrhum
         mjgVEDntPnx4YzEgqVNBlNYAPKQl9qTjHz8gxyoa0ewyxp20vOh6AOemw9NecF68uuBU
         iWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705210; x=1778310010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4fl8atXwJsXGN4qhUfGPrxc+n6KtD9kAzXZ7gC0fcA=;
        b=WSQm2VLfukJhkEV+MS8wl1kHK0kgwDhl38ibaBwFaqwjBRFQSHl6aiBU1pOW9gWOWQ
         J4GDzPtXT1vVJoUWLxdvYap8/JmwL4LxYpZ74+W2UriGEPnlhiKKf6Vs9UZKcDxjcZ8T
         icu53r10x2fJpQOVnpQopLd/ovxKx1yw8T30wdFKnR7oiu5lfxmMrsJwpD4fQmRnbG8J
         RCb13JtvRrPk9vQQ9qWtn4SFOdfhum1TnbWIQRpDuU3JpnyIqar+LWSZ1nuSm9jgmSBp
         ogT23vLmH4FI/gdGOyJKnhO6anVg39pVRk72h7FVbBfSciU1kch7CP6VP29QJ4+8Xj3B
         5Z5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9SLvin3l7uJmfEOM/D3SGHkXGmpKMr5xpbQFvNtgRsQeDiX5Nn9uayGDPki4KuPtfKoNjOA1O7nzp3eq2E9y9H@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8RFysdOybO8cB1bqTiwrNdzECgFPBAKDpmH20fWYu/9GEZd9Z
	ZiLhsVJv0taKIwHV87PMA7jmDkXZ8eCgyzetNhN8CDxeHU7asfXfVU8OBM3ZjIkEJkNxLjlG6bR
	X3nEqPpQ6GQ==
X-Received: from pgbl22.prod.google.com ([2002:a63:5716:0:b0:c79:97ca:668b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9188:b0:398:90e5:a9b9
 with SMTP id adf61e73a8af0-3a7f1c392ccmr2264086637.27.1777705210076; Sat, 02
 May 2026 00:00:10 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:27 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-10-irogers@google.com>
Subject: [PATCH v8 09/17] perf arch common: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/common.c | 55 +++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 21836f70f231..e9b5b61feffe 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "common.h"
+
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include "common.h"
 #include "../util/env.h"
 #include "../util/debug.h"
+#include <dwarf-regs.h>
 #include <linux/zalloc.h>
 
 static const char *const arc_triplets[] = {
@@ -145,7 +147,8 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 					  const char *name, char **path)
 {
 	int idx;
-	const char *arch = perf_env__arch(env), *cross_env;
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
+	const char *cross_env;
 	const char *const *path_list;
 	char *buf = NULL;
 
@@ -153,7 +156,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 	 * We don't need to try to find objdump path for native system.
 	 * Just use default binutils path (e.g.: "objdump").
 	 */
-	if (!strcmp(perf_env__arch(NULL), arch))
+	if (e_machine == EM_HOST)
 		goto out;
 
 	cross_env = getenv("CROSS_COMPILE");
@@ -170,30 +173,42 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		zfree(&buf);
 	}
 
-	if (!strcmp(arch, "arc"))
+	switch(e_machine) {
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
 
@@ -202,7 +217,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		ui__error("Please install %s for %s.\n"
 			  "You can add it to PATH, set CROSS_COMPILE or "
 			  "override the default using --%s.\n",
-			  name, arch, name);
+			  name, perf_env__arch(env), name);
 		goto out_error;
 	}
 
@@ -237,5 +252,5 @@ int perf_env__lookup_objdump(struct perf_env *env, char **path)
  */
 bool perf_env__single_address_space(struct perf_env *env)
 {
-	return strcmp(perf_env__arch(env), "sparc");
+	return perf_env__e_machine(env, /*e_flags=*/NULL) == EM_SPARC;
 }
-- 
2.54.0.545.g6539524ca2-goog

