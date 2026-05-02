Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686FA30BF4E
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705213; cv=none; b=EelEvMCX5GvQOwa4viW8yczxfP+tKHPgbieTR3bSNk0H7URNY4nIHWg4gmYZzlnrh2xtFvLX4MuiHRznFqfeq+OrKeVmO+LhKQexqIsdQICEK7hoU2OhdaM06u3+tBhLrv3q5dVJG/K3uz47eT96pRoinsZs6Ll//zX1uEjAThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705213; c=relaxed/simple;
	bh=AXv3Fg1RBRhXkrhLfgtZQHZ3SHCmISd26okTu7YyA9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=daFdmzdvNAm2DDrUy2Rk5BLD68oTN2X7Ce57kwJPe7gWRQ3U+HEpk03oceLYT4Fkr6koJobbJHkGZFIWtEWvBcHhWeK4KhOyg/LOvVsrBg8Yhlgj5iXYZe6teoKL6kKjCv2E4RtE0/4zOE2aVqfdIMdfOiYzITH4Zqjs2g3hpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SeuBMfYb; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeuBMfYb"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12df9e440d3so2131459c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 00:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705204; x=1778310004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U6K8oyFDbv3XjzNVf9nE6XxdE+Rb7NWBTjouZbi2tBc=;
        b=SeuBMfYbO7fVuiuJyzF+7zLV9YcsVKnex322Cr5QvO/90XKsw14S+Z15wpB77V8Edz
         0Lx9ye9iup1Pv2B+91Y1WuHb3ERV1oqGPSfQ4P37JVReO2NENkCyiJelcbcG5er47i5Q
         vZwCL5+wqVcRCu1Oe5boSGpYoZcDu4RC4aL4f9P2mqkUvvgXayl4bHMpT8B4zvqmGCd9
         bzPhPCetgZHEijvMMErB97bRRTYoNamfGBhpI5e9WJ9rQJlrKgIGuoFZy7l0UjTE/xJ7
         4g74yfbnfy9K+0Ny0M/gmxDY0MkB5czVOAS8Z6aPV6XOwvml7zoIPBkYwYJFj0VH418m
         FdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705204; x=1778310004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6K8oyFDbv3XjzNVf9nE6XxdE+Rb7NWBTjouZbi2tBc=;
        b=llxY4k9ut38h4W/bT/Zs2bW8VKByHiAY28MhlU2eeEAWbieCPPRiCIaRBIGnP/TV7x
         czGLD8z7N0sKPIIkGg5oUYgZ/fBl7VqDEqpKFKpYwPu40dGYJnc221QWFF53Fz32RSsT
         ha2KdzsYmMKQmZ/BoHxvc8w3kbWXiGxeInMcFWZ4HNn1LAPP1B/pqRoIaKT+6E02ZYaK
         cCejogk4QIXG/zanj/c98UxhuWIoBdXdgP3D/GgkBmzPdN3Lm+BLHe8PHUtQE00O2tVp
         YhMd5N4EFwbBJA1Ay6Y4nM2X6aUiJwqPfB59BRV2JqLjwSp5jq0OTayYrQWcgHCLU+8o
         hchA==
X-Forwarded-Encrypted: i=1; AFNElJ+Vc5xpWwJUwRcuvpBk2G+PipNdPARuj8Pc3B3eQdpqTZlB9F5YNIOHaAfh1H6a8K7mkIUtfzEfnhlMyFDaZTyY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0vB55HVlsQpwpSyMcfj2bLs72XdIvXzvuKDsH1Nn4nEZffH8
	fcD0ZtcXsLwGRdIsflaBbZbSWPg0morg9Mgk4hV9MzwA3KG+0R9y9Z9wkctpigrXHgsywo7RYvf
	GIrC1W/PJuw==
X-Received: from dldz12-n1.prod.google.com ([2002:a05:701b:418c:10b0:12c:91ef:91f4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6887:b0:128:d219:e169
 with SMTP id a92af1059eb24-12dfd7cacdbmr926932c88.10.1777705204310; Sat, 02
 May 2026 00:00:04 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:24 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-7-irogers@google.com>
Subject: [PATCH v8 06/17] perf sample-raw: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than the arch to determine S390 and x86 types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sample-raw.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/sample-raw.c b/tools/perf/util/sample-raw.c
index bcf442574d6e..b10056ac8057 100644
--- a/tools/perf/util/sample-raw.c
+++ b/tools/perf/util/sample-raw.c
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#include <string.h>
+#include <elf.h>
 #include <linux/string.h>
 #include "evlist.h"
 #include "env.h"
@@ -14,14 +13,15 @@
  */
 void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct perf_env *env)
 {
-	const char *arch_pf = perf_env__arch(env);
-	const char *cpuid = perf_env__cpuid(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (arch_pf && !strcmp("s390", arch_pf))
+	if (e_machine == EM_S390) {
 		evlist->trace_event_sample_raw = evlist__s390_sample_raw;
-	else if (arch_pf && !strcmp("x86", arch_pf) &&
-		 cpuid && strstarts(cpuid, "AuthenticAMD") &&
-		 evlist__has_amd_ibs(evlist)) {
-		evlist->trace_event_sample_raw = evlist__amd_sample_raw;
+	} else if (e_machine == EM_X86_64 || e_machine == EM_386) {
+		const char *cpuid = perf_env__cpuid(env);
+
+		if (cpuid && strstarts(cpuid, "AuthenticAMD") &&
+		    evlist__has_amd_ibs(evlist))
+			evlist->trace_event_sample_raw = evlist__amd_sample_raw;
 	}
 }
-- 
2.54.0.545.g6539524ca2-goog

