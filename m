Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831C14F88
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiXMuK2h"
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00E5D4E;
	Fri,  3 Nov 2023 12:55:44 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b4145e887bso1330368b6e.3;
        Fri, 03 Nov 2023 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699041344; x=1699646144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=aJea9QtR9jwyrwPF423TcQS3gd5WZ44JQNQlg1ipmx0=;
        b=jiXMuK2h/X/zILKdX3YfHWiKPtheYPlCACOuU0cl/kmqOW9iemPdn/q27oUaewH3Tu
         N9YROXPqLBZ29RWxdhqvUYx3I0OMksfmtaN+KUKQTy05w3k1Hg+EefWvbsz0r32mpXe7
         /p7JWcgrymd6mxS+suj6BRK9goPw0tgmukxEW9MhCFdcSwWRmkz8f+bbjeDrQntZP2fO
         Yr+M4ezhEgAX/kbXmULSMfZ6ECD9Eh4CiNxQdkahe9lRHCUrPNA6nrK6APmEavO3H6Fc
         7bDd6PNoAvQefkuzfpn1fIx+/zxVG20GY4ISMsLxMxZCAHAt4u2Vq7R/oQcH4VMRATW/
         mHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699041344; x=1699646144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJea9QtR9jwyrwPF423TcQS3gd5WZ44JQNQlg1ipmx0=;
        b=t7WYRBO6z+C9nOL5Z4cbdMYYpZc4cSc2axlU9Yh8HJ+JYKS4G3EX6Kkrjr3kfhtocm
         1jXTxvy6sgebD21AHZNm76+MUwVSYN76hrXY1ies/wrPd3hahu0Tpjg/vQtmkeSI6mtN
         0icPhibKzXGHf8lqLnEEA4be8iQXmNdTcbO8ImCUX54myZAB0WZW01JBCmCUdn5NrTVG
         p5Qqvn/aaeMyfPGF42Fakqz4VoKeFkqR0J31qz/Bfnk0Bjagf1qftuCig1kMGuq99mZY
         LuaXeX5y0JgIXbd/3OZ93RdBQdyCN6F9fev64Uz6bCmpit5pMWYoupGHzApaQ4gC7f2K
         TD5Q==
X-Gm-Message-State: AOJu0YxSD4XN3ncqnTY25N+Ra1P8igRadg3PnTe36Zc36petFVMtidvQ
	caaw3XPANIyoXV2upwbiSio=
X-Google-Smtp-Source: AGHT+IF7RigU8kYFbilZuXBEvj+GE5xxsISr5kgehDPIgjlBhAs5odqpOrTn5gN2i8Ehtdx2JJvv7g==
X-Received: by 2002:a05:6808:1920:b0:3b5:64c9:5146 with SMTP id bf32-20020a056808192000b003b564c95146mr13605707oib.42.1699041343748;
        Fri, 03 Nov 2023 12:55:43 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:8234:4ed3:2635:c9d6])
        by smtp.gmail.com with ESMTPSA id q18-20020a62ae12000000b006bae6eea9d0sm1785917pff.49.2023.11.03.12.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 12:55:43 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@arm.com>
Subject: [PATCH v2] perf test: Simplify object code reading test
Date: Fri,  3 Nov 2023 12:55:41 -0700
Message-ID: <20231103195541.67788-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It tries cycles (or cpu-clock on s390) event with exclude_kernel bit to
open.  But other arch on a VM can fail with the hardware event and need
to fallback to the software event in the same way.

So let's get rid of the cpuid check and use generic fallback mechanism
using an array of event candidates.  Now event in the odd index excludes
the kernel so use that for the return value.

Cc: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
* update exclude_kernel check using ":u" modifier string

 tools/perf/tests/code-reading.c | 76 ++++++++++-----------------------
 1 file changed, 23 insertions(+), 53 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 3af81012014e..d6e845c57902 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -511,38 +511,6 @@ static void fs_something(void)
 	}
 }
 
-#ifdef __s390x__
-#include "header.h" // for get_cpuid()
-#endif
-
-static const char *do_determine_event(bool excl_kernel)
-{
-	const char *event = excl_kernel ? "cycles:u" : "cycles";
-
-#ifdef __s390x__
-	char cpuid[128], model[16], model_c[16], cpum_cf_v[16];
-	unsigned int family;
-	int ret, cpum_cf_a;
-
-	if (get_cpuid(cpuid, sizeof(cpuid)))
-		goto out_clocks;
-	ret = sscanf(cpuid, "%*[^,],%u,%[^,],%[^,],%[^,],%x", &family, model_c,
-		     model, cpum_cf_v, &cpum_cf_a);
-	if (ret != 5)		 /* Not available */
-		goto out_clocks;
-	if (excl_kernel && (cpum_cf_a & 4))
-		return event;
-	if (!excl_kernel && (cpum_cf_a & 2))
-		return event;
-
-	/* Fall through: missing authorization */
-out_clocks:
-	event = excl_kernel ? "cpu-clock:u" : "cpu-clock";
-
-#endif
-	return event;
-}
-
 static void do_something(void)
 {
 	fs_something();
@@ -583,8 +551,10 @@ static int do_test_code_reading(bool try_kcore)
 	int err = -1, ret;
 	pid_t pid;
 	struct map *map;
-	bool have_vmlinux, have_kcore, excl_kernel = false;
+	bool have_vmlinux, have_kcore;
 	struct dso *dso;
+	const char *events[] = { "cycles", "cycles:u", "cpu-clock", "cpu-clock:u", NULL };
+	int evidx = 0;
 
 	pid = getpid();
 
@@ -618,7 +588,7 @@ static int do_test_code_reading(bool try_kcore)
 
 	/* No point getting kernel events if there is no kernel object */
 	if (!have_vmlinux && !have_kcore)
-		excl_kernel = true;
+		evidx++;
 
 	threads = thread_map__new_by_tid(pid);
 	if (!threads) {
@@ -646,7 +616,7 @@ static int do_test_code_reading(bool try_kcore)
 		goto out_put;
 	}
 
-	while (1) {
+	while (events[evidx]) {
 		const char *str;
 
 		evlist = evlist__new();
@@ -657,7 +627,7 @@ static int do_test_code_reading(bool try_kcore)
 
 		perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-		str = do_determine_event(excl_kernel);
+		str = events[evidx];
 		pr_debug("Parsing event '%s'\n", str);
 		ret = parse_event(evlist, str);
 		if (ret < 0) {
@@ -675,32 +645,32 @@ static int do_test_code_reading(bool try_kcore)
 
 		ret = evlist__open(evlist);
 		if (ret < 0) {
-			if (!excl_kernel) {
-				excl_kernel = true;
-				/*
-				 * Both cpus and threads are now owned by evlist
-				 * and will be freed by following perf_evlist__set_maps
-				 * call. Getting reference to keep them alive.
-				 */
-				perf_cpu_map__get(cpus);
-				perf_thread_map__get(threads);
-				perf_evlist__set_maps(&evlist->core, NULL, NULL);
-				evlist__delete(evlist);
-				evlist = NULL;
-				continue;
-			}
+			evidx++;
 
-			if (verbose > 0) {
+			if (events[evidx] == NULL && verbose > 0) {
 				char errbuf[512];
 				evlist__strerror_open(evlist, errno, errbuf, sizeof(errbuf));
 				pr_debug("perf_evlist__open() failed!\n%s\n", errbuf);
 			}
 
-			goto out_put;
+			/*
+			 * Both cpus and threads are now owned by evlist
+			 * and will be freed by following perf_evlist__set_maps
+			 * call. Getting reference to keep them alive.
+			 */
+			perf_cpu_map__get(cpus);
+			perf_thread_map__get(threads);
+			perf_evlist__set_maps(&evlist->core, NULL, NULL);
+			evlist__delete(evlist);
+			evlist = NULL;
+			continue;
 		}
 		break;
 	}
 
+	if (events[evidx] == NULL)
+		goto out_put;
+
 	ret = evlist__mmap(evlist, UINT_MAX);
 	if (ret < 0) {
 		pr_debug("evlist__mmap failed\n");
@@ -721,7 +691,7 @@ static int do_test_code_reading(bool try_kcore)
 		err = TEST_CODE_READING_NO_KERNEL_OBJ;
 	else if (!have_vmlinux && !try_kcore)
 		err = TEST_CODE_READING_NO_VMLINUX;
-	else if (excl_kernel)
+	else if (strstr(events[evidx], ":u"))
 		err = TEST_CODE_READING_NO_ACCESS;
 	else
 		err = TEST_CODE_READING_OK;
-- 
2.42.0.869.gea05f2083d-goog

