Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868F3546F9
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016033; cv=none; b=N+WfqZe3MmLWOpYr2QATiWdyA2FdNw7OvKUhysg8rGS0+D6NVh6kyxP2oA1PngPjM8q9Bqk09phOgVN5MjVseMvPqbFNgw1LdICmJUXF4woacWCRe5WBaTgoDUtXGr4CAw7SYRo6KpY+2QfjvuR5BdMVCPc30dV1BXCMCKE6cm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016033; c=relaxed/simple;
	bh=MJ+K3Rs0bnya53fFL+gZpbiLUdkfojL7f7z2lYvhul8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNZzbz+3cbeYuguT0r5u30gMjyESRKc+2AzKyx0kbPSKpgO6YBg472oMSFSlAq7AKoisyhcnuU/E8hJnkm3j9Wts/mPUasUhh3aeky8iqgemw2cGAex5xq6/kvokq40mPOKBmjYaieZ3Ne7GJZ20jrcU2koAj7Q0ab0OHayIAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PNlUBcrQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNlUBcrQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so62088015e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016031; x=1781620831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEOwD57aFV/Xs3z58IqNxAAWjTXC2csM2SlQM9DxCXs=;
        b=PNlUBcrQHppv9CuEj7e9cTMXxvkNxVMUYQYmnXuWF6847LqAqQ9e8xeYgUev655ZGE
         AwplK2iq7oRWU8xTIY/ZTTuiBniETyXYWkEsBr5o9NwbG6gs0LZ5fQ7HC1iIRL0QHmJQ
         N2meS/IL6L75IEJk3hP8SBn30ffabITvPXeILyshyaTvlHUrAzNeJRD8yUqBr+fPVxyK
         b53/kSPuUHnfwVeAHolAuvW4a1yFh4YQQGKcSMtbca8pSUz4gHHj1C5A/Hw04cXk+oOY
         DNwAVSIFTP/NDX4pbvCiovqDG6ivQ+2zL1HRCqbYt+euOqoTm9002dG2/5jJfl+iMVyi
         SOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016031; x=1781620831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bEOwD57aFV/Xs3z58IqNxAAWjTXC2csM2SlQM9DxCXs=;
        b=N+H7zSfD6P6FoWuT4jY9ci5icfVN9fA+lo2f6lNSb/yC8sCa1gouJ4lnqK/UXmtYz/
         yjgTur0G4B3wB8fJRDuf3nTuGAGkB9lWATdYdg1/yS35Jn0rmCzh13CnqY1C8Z7vLUYl
         Zwb9/VbLlUJsgGzSXdk4Nh+/sskDLo1acWs7ZIHQKPZgVHyh8zoJzJP3xPdUQuRS5odQ
         5lckNIiEiofIYqJtggzQ5P/hlBJuzcCfmAVupqxBw43fuCBuCXebgTiTtS/PUMeeDn13
         rZD+pRr35qxx8U+ozVTN8fm9uy66PN4LDfiDmXX7ev3/bwekbsn2dTmj8FPoESPxRCwI
         60GQ==
X-Forwarded-Encrypted: i=1; AFNElJ+f0+3hYgiDPnkG7Z/dYZg8jOBxgRsyckOd3iH3h3Ek9x31z4Q69J5l6tGBaq8SxJ+WSQqvdfIwRdhfCrFNj9FA@vger.kernel.org
X-Gm-Message-State: AOJu0YwlfFlOJAwbZP4EOaArD4m1kr2Gld9L8SQhGVGSIFkmocDrUNA/
	smRWw0FAsxM32GW7ebbLf9Q8A7s9/Mp+Z8c5ppNjZFFU7KCEYs3NSi4e5p7vg6DtFNU=
X-Gm-Gg: Acq92OESfQHK+DBwn8+0kjuGTa5tjz6X75n6ckti5xfOHiz7hejkYCUjAUJSQZbHNTf
	ri+ghgZ8zWo1gHzBQOWE/6hjWVZ5t+dUQ8sufOinBgF/6UainG0SOc/DvTV6Ov4PUnNK10SQiBR
	qYMlTUJ0PMXagAEERXOgeEveReafRNP/WI27/fGT/RXFSD03H9cCCDkyl5Ong/tElaXbtJqxhGt
	nJ66IG493O+hS8UsFuC15nupdlahNKI8PApWUzuliNndwtJqTUJOv8Glc6kBdnfteSWBW+597nk
	ZR1KYN2UUQL+NDwhkzBZWJPCf6UgazxDqy9rJqor6ZuHN6YkkstT/pFL4r+O3xhpCQv/o4mkUHY
	sbJMnboA7Qd+E63nhK4h56lAgyeIoX7l63fDZswHKb/BZ0o0JnlyHqv5gKmy2Sgq2uwMxikoeGo
	DoU/xcA/dTo8gOfljn8YNB9BD0nqnaFvCM+5w7h1FY3P8=
X-Received: by 2002:a05:600c:a117:b0:490:c2a3:abaf with SMTP id 5b1f17b1804b1-490c2a3abdemr253443555e9.35.1781016030785;
        Tue, 09 Jun 2026 07:40:30 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:29 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:40:10 +0100
Subject: [PATCH v5 05/19] perf test: Add deterministic workload
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v5-5-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Add a workload that does the same thing every time for testing CPU trace
decoding.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-test.txt     |  4 +--
 tools/perf/tests/builtin-test.c            |  1 +
 tools/perf/tests/tests.h                   |  1 +
 tools/perf/tests/workloads/Build           |  2 ++
 tools/perf/tests/workloads/deterministic.c | 39 ++++++++++++++++++++++++++++++
 5 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 213eb62603eb..c50a4b2d2d29 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -57,7 +57,7 @@ OPTIONS
 --workload=::
 	Run a built-in workload, to list them use '--list-workloads', current
 	ones include: noploop, thloop, leafloop, sqrtloop, brstack, datasym,
-	context_switch_loop and landlock.
+	context_switch_loop, deterministic and landlock.
 
 	Used with the shell script regression tests.
 
@@ -66,7 +66,7 @@ OPTIONS
 		seconds: leafloop, noploop, sqrtloop, thloop
 		nrloops: brstack, context_switch_loop
 
-	The datasym and landlock workloads don't accept any.
+	The datasym, landlock and deterministic workloads don't accept any.
 
 --list-workloads::
 	List the available workloads to use with -w/--workload.
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 9284f897de3c..ef7e3f52a383 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -164,6 +164,7 @@ static struct test_workload *workloads[] = {
 	&workload__inlineloop,
 	&workload__jitdump,
 	&workload__context_switch_loop,
+	&workload__deterministic,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 7cd4da4e96d3..bcfe9c33fc66 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -246,6 +246,7 @@ DECLARE_WORKLOAD(traploop);
 DECLARE_WORKLOAD(inlineloop);
 DECLARE_WORKLOAD(jitdump);
 DECLARE_WORKLOAD(context_switch_loop);
+DECLARE_WORKLOAD(deterministic);
 
 #ifdef HAVE_RUST_SUPPORT
 DECLARE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 7134a031cb7c..90f2d8aa4941 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -11,6 +11,7 @@ perf-test-y += traploop.o
 perf-test-y += inlineloop.o
 perf-test-y += jitdump.o
 perf-test-y += context_switch_loop.o
+perf-test-y += deterministic.o
 
 ifeq ($(CONFIG_RUST_SUPPORT),y)
     perf-test-y += code_with_type.o
@@ -23,3 +24,4 @@ CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_inlineloop.o       = -g -O2
+CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/deterministic.c b/tools/perf/tests/workloads/deterministic.c
new file mode 100644
index 000000000000..8a78519fd075
--- /dev/null
+++ b/tools/perf/tests/workloads/deterministic.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include "../tests.h"
+
+int dt_work = 1234;
+
+static void function1(void)
+{
+	dt_work += 7;
+	dt_work += 7;
+	dt_work += 7;
+}
+
+static void function2(void)
+{
+	dt_work += 7;
+	dt_work += 7;
+	dt_work += 7;
+}
+
+static int deterministic(int argc __maybe_unused,
+			 const char **argv __maybe_unused)
+{
+	dt_work += 7;
+	dt_work += 7;
+	dt_work += 7;
+
+	function1();
+
+	dt_work += 7;
+	dt_work += 7;
+	dt_work += 7;
+
+	function2();
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(deterministic);

-- 
2.34.1

