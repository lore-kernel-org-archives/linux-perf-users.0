Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1D16A395
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767793; cv=none; b=JIyOicFufBfwOwV/BvjhDxDCkyIf5nNdaafxL52+H9hI1iMqnv45mSDRkVXM7DVsBDAsgiQvhTvJhKzvr4LjkESevgbZVXUWCL8UgkKmznleeKCCtEzmWuBcIiFVhxMubbQ1yCKJXnY2n2fdX9UMIoU8AZVkpTd6TjAct8chjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767793; c=relaxed/simple;
	bh=3YxL5VzE6bHl3FdRH/Jn9cIz8yFva46ZW763ff/pUc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b0Ix33182gMbAwn4hVDpUSc1Q1zNFjKF+lod+oqAK/u95NTzSrQAZ3aStcA48FnMJdDcviK2zC8b8H8SBhzgbbuLTbEooB8ML2643sxXNAb3QH/ls9YjZ03MkO9AIuT53jRxOTU10y2Gowo2dVOFjJbdtObLFdubZ10/d2Z2KMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLJHpHro; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLJHpHro"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dd33dc337so2378190c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767791; x=1778372591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6FeuxlGm3VrKdgs8XUfTlIan59NM0soqe95RHdyhTY=;
        b=dLJHpHroKqVd5fnvGBI+1fe5sA9FFPEbsYNby1D0Nr44ta/8F+fpw8aBr1vkRPu7rR
         Wr4gcy9EERlCVeKjAmrg0k8AVeshXAC/IQKMOehRCvCdY0A/G3dcJ42Ph7scPzqiTxKv
         3JcOtDUw+Yg4ZwVCmqJ19myvKoiWzGNXB/Eq723nJobwyPkw9PYFDxrQ4hqhqbrakVyQ
         5Am0P19M2cPZAZCQPjH+35hXHVIzf5BnQWJvYN7H5Ei3OhrfSvBLXgdm79mK9B+/vFKy
         ePpv4rQ4rrO0TyCO8AVJ9PUqN2T/SrZRM9cY1BgU5kkTofKaq1SBQGsDRPMdsAkXO0/j
         4HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767791; x=1778372591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6FeuxlGm3VrKdgs8XUfTlIan59NM0soqe95RHdyhTY=;
        b=AzOas4NyYUj3X9axZdAGRAj4uTdTuFXpy3qs+hlyYc259MUcQMQiTfNXb26FEVrGO3
         b5LwizEnDsXCO3q/Q3UZ91GGNjdzaw7i3j2172r07Dzop/zypHjtAZgOHjH394c5hPJM
         DH5VQ0f7cHcCmAb3wD5IC4SnveJf2Dw/MYFJnsfMn58qhxCRS1DfijJCe+Ydohi9Nau9
         UBN6MIhA7Yq1WfY6c6z1iiokCplO2nljO+4Y5z2q0VugMytYg8SlgkAUHGlh1Dmy/S2f
         iiednbBPkuJwjK6JMejHgxpTuEC1S2HIQEKTTUxhGW59niyqfQhL/+1L5koAjKzcT/vh
         ydtA==
X-Forwarded-Encrypted: i=1; AFNElJ/Oio5i1vQsxWuuJth1YF6G4zA4kyPgiFf+d3lH2cRMonxXAp1g/dkIIux22/vNZ/EgH2FPCknwq+3Y2irwyl4E@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUNLzGe4LdfeU7qqdSlgeGelj9Dz22vUgKrVmg8VeniK5oYDx
	tLSGqT6ghTLWmEwNyJHwn+ZbzCfdKO21E9dsNOwpBR3zT+oU1JlO96jWhhBCzJCtS9EjUOL0VcP
	XTWdcNeeWKw==
X-Received: from dyib18.prod.google.com ([2002:a05:7300:79d2:b0:2d9:3c6b:a26b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:203:b0:12c:9037:5126
 with SMTP id a92af1059eb24-12dec61125amr5551297c88.9.1777767790824; Sat, 02
 May 2026 17:23:10 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:39 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-10-irogers@google.com>
Subject: [PATCH v9 09/18] perf sort: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than the arch to determine x86 or PPC types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sort.c | 58 +++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0020089cb13c..90bc4a31bb55 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1,40 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "sort.h"
+
 #include <ctype.h>
 #include <errno.h>
 #include <inttypes.h>
-#include <regex.h>
 #include <stdlib.h>
+
+#include <elf.h>
+#include <linux/kernel.h>
 #include <linux/mman.h>
+#include <linux/string.h>
 #include <linux/time64.h>
+
+#include <regex.h>
+
+#include "annotate-data.h"
+#include "annotate.h"
+#include "branch.h"
+#include "cacheline.h"
+#include "cgroup.h"
+#include "comm.h"
 #include "debug.h"
 #include "dso.h"
-#include "sort.h"
+#include "event.h"
+#include "evlist.h"
+#include "evsel.h"
 #include "hist.h"
-#include "cacheline.h"
-#include "comm.h"
+#include "machine.h"
 #include "map.h"
-#include "maps.h"
-#include "symbol.h"
 #include "map_symbol.h"
-#include "branch.h"
-#include "thread.h"
-#include "evsel.h"
-#include "evlist.h"
-#include "srcline.h"
-#include "strlist.h"
-#include "strbuf.h"
+#include "maps.h"
 #include "mem-events.h"
 #include "mem-info.h"
-#include "annotate.h"
-#include "annotate-data.h"
-#include "event.h"
-#include "time-utils.h"
-#include "cgroup.h"
-#include "machine.h"
 #include "session.h"
+#include "srcline.h"
+#include "strbuf.h"
+#include "strlist.h"
+#include "symbol.h"
+#include "thread.h"
+#include "time-utils.h"
 #include "trace-event.h"
-#include <linux/kernel.h>
-#include <linux/string.h>
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
@@ -2673,9 +2678,10 @@ struct sort_dimension {
 
 static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (!strcmp("x86", arch) || !strcmp("powerpc", arch)) {
+	if (e_machine == EM_X86_64 || e_machine == EM_386 || e_machine == EM_PPC64 ||
+	    e_machine == EM_PPC) {
 		if (!strcmp(sort_key, "p_stage_cyc"))
 			return 1;
 		if (!strcmp(sort_key, "local_p_stage_cyc"))
@@ -2686,14 +2692,14 @@ static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 
 static const char *arch_perf_header_entry(const char *se_header, struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (!strcmp("x86", arch)) {
+	if (e_machine == EM_X86_64 || e_machine == EM_386) {
 		if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
 			return "Local Retire Latency";
 		else if (!strcmp(se_header, "Pipeline Stage Cycle"))
 			return "Retire Latency";
-	} else if (!strcmp("powerpc", arch)) {
+	} else if (e_machine == EM_PPC64 || e_machine == EM_PPC) {
 		if (!strcmp(se_header, "Local INSTR Latency"))
 			return "Finish Cyc";
 		else if (!strcmp(se_header, "INSTR Latency"))
-- 
2.54.0.545.g6539524ca2-goog

