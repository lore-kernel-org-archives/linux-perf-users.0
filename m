Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0474370D75
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481851; cv=none; b=VKQKUzRg9h67SjZoAQCDCkiKAh45AFitNj42GqIuhGi0kL/upZ0O0ahmtKq+9wj7hGSVzna+nPRG0r4uCDkumXt6i49hLQAXnYwADaiFPKua9pKt1l8Jd9OclCoIsupClmt1m8zL2q5+KXNcSvj2w4jpQ69x7OGkmnt9Bnno3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481851; c=relaxed/simple;
	bh=ESmfjIh7MN23IeBJPxwPdBU7xBIa18aM//caXhGjZcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gI0lcnBkfhre3KUfNwDvBZIB2BDdEcnWBgu/YWcDFbtBuXb7Z+FYHb96dA/N392Sg07km8mCCIwj/WAqzU25oHAOB2t5L0lJHSy3ffLpVAPfMgdliK4FWTQPwM9Xwo9+y+JVdJZzpdqhz9sRCWJEnQSnLocWE+NTKRQG2yXYTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lgaUu2iy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgaUu2iy"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so114312805e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481848; x=1781086648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXjR0tiVSlnNG0AciIMM1oZd4f63sbXFpo0GMT42zX4=;
        b=lgaUu2iyJyDxzbErkikl8wB/pDiinjfL0zeL7gnrNA7CSJ94VhQO9qwD6GRebkLPIT
         MXrdBvE+XaORPDcsxwky0UQlpa+NkwAKKdwFuirOGeaURI8CGJ1MhGUWQOWH4BHuAZSM
         CSVbRraoUVtde0gldYuovAtao/ouCcySKkHL6wNFvmPQ9MHmNCCHVReajd7Xm2Utxc/J
         vzCBNOI+fYHzrUErFM/zcf3QERZdnZqR1z088D3NKnacbPuszWGAfM1t+qbKRaILnW6B
         cY1TUhGCo/1hDtIEUQnkmyKq9OLciL5IAvpC9d6+J+aJ8G7q3j2r8ytr2fDtYBcbAmJ4
         G9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481848; x=1781086648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXjR0tiVSlnNG0AciIMM1oZd4f63sbXFpo0GMT42zX4=;
        b=hs9E+s5QTIi0bM/TMbJwg5RxTgjWIhQ1hcVOOrjNZobJ0EfUuPqsbyVe15kJMOb6db
         j89eI3HBIWVoyNH7FoBksHLaSkz9rqpwyDe6lFCNuR7YOVW1K4Xew0YME5RHqzhQCp3f
         oUMEILWHi7sGu9wLUtftedrKl66WpXEOFUhOcM/1Q1+PxCD5qM86OHIaD2hk3Tww+ZfN
         QEDX0wpoWh74jLtLWpbsV6/1PXsh1Bkk7cVKuiOoeaE0imweUxbJ3XoA9IhOmPONsWGe
         6pP0q65v1IpGa4QjphV9q0mIYuQlSUF+TNj9ERLCry/4uI0DG3QbSHs5p9T1e/QnCfLd
         zlsw==
X-Forwarded-Encrypted: i=1; AFNElJ8NbLIvX6YQmMx+QCxNZAFz4QSXubZ3C58U4PdZttI3wDbYPUPEakr5km26xf1eMGAKfjyGRNyg1o1pWkbwJom5@vger.kernel.org
X-Gm-Message-State: AOJu0YznkGLIOchO3hTK5rm4eYYpjNbnAbPkHoEv8DP37EvQx7gRJLBJ
	gj8C7MZlMJIEXgRLQal5IA5/jcPaITvxlBOgDzDkZbm75vXWL0HvR50IUYTvBwDofWI=
X-Gm-Gg: Acq92OG0DSuVMYGVT7txhO6wzZenGsm/dAwih6QYB7WQWps/ONJYXevjmMFk+fXpQq3
	tntTuBVHxIIWcVigcwh7U7X7UjIrVJHD+Z+w8rCThH0m4Dmojyov5j9laZoju0xUthOERDMxbND
	KnfYSedQuqLBmERzxbZa9BRveY4Lxf3F8+3LCSZQTOgQdWaUAVGohEyjJSxwdeJDDHGUSJ883dd
	sMQgm1AgZPTJvO4q7pRWdGmL/47cgLmGTQbT5hW7UmoAGHskGK9clHB5lpq64B2qEyUZEa63E6z
	gv09N/4AQXrMHAo+C+NKvQevKUCfes1BjFfWqsV5ciZjhjPPUurnasMzzDCOyCVZZCdlHljmrQC
	/EiD0zpLIlfON3lPeQNTlaz1vuiVNMcFJpoRdJIW1Q22GWhyn5ZuaLTrxmi3oMoQE3IQ11cK5aM
	Hae3mm3ptILMSQU99mEuO+ZKcR5TUWoBh+4Mz+d5mv3ClX/3LNQtLX8Q==
X-Received: by 2002:a05:600c:859b:b0:490:4b89:535d with SMTP id 5b1f17b1804b1-490b5e96157mr35768765e9.1.1780481848349;
        Wed, 03 Jun 2026 03:17:28 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:27 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:10 +0100
Subject: [PATCH v3 06/19] perf test cs-etm: Replace unroll loop thread with
 deterministic decode test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-6-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
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

Testing a long sequence without branches seems like it would be better
as a decoder unit test, and this test doesn't test decoding either, so
it's not clear what bugs this is trying to catch.

The new deterministic workload has somewhat long sequences when built
unoptimized, and we can always increase them later if we want to. But
now we test that decoding always gives the same result for the same
sequence of code which we've never had before.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/deterministic.sh  | 71 ++++++++++++++++++++++
 .../tests/shell/coresight/unroll_loop_thread_10.sh | 22 -------
 2 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/deterministic.sh b/tools/perf/tests/shell/coresight/deterministic.sh
new file mode 100755
index 000000000000..52e033fd6b82
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/deterministic.sh
@@ -0,0 +1,71 @@
+#!/bin/bash -e
+# Coresight deterministic workload decode (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If Coresight is not available, skip the test
+perf list pmu | grep -q cs_etm || exit 2
+
+tmpdir=$(mktemp -d /tmp/__perf_test.coresight_deterministic.XXXXX)
+
+cleanup() {
+	rm -rf "${tmpdir}"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+cf="$tmpdir/ctl"
+af="$tmpdir/ack"
+mkfifo "$cf" "$af"
+
+# Start disabled and use the control FIFO to only record the workload and not
+# startup.
+perf record -o "$tmpdir/data" -e cs_etm//u -D -1 --control fifo:"$cf","$af" -- \
+	perf test --workload-ctl fifo:"$cf","$af" -w deterministic > /dev/null 2>&1
+
+perf script -i "$tmpdir/data" --itrace=i1i -F ip,srcline | \
+	grep "deterministic.c" | uniq > "$tmpdir/script" 2>/dev/null
+
+
+# Remove open brace lines as they may not be hit depending on the compiler
+sed -i \
+  -e '/deterministic.c:8$/d' \
+  -e '/deterministic.c:15$/d' \
+  -e '/deterministic.c:23$/d' \
+  "$tmpdir/script"
+
+cat > "$tmpdir/expected" << EOF
+  deterministic.c:24
+  deterministic.c:25
+  deterministic.c:26
+  deterministic.c:28
+  deterministic.c:9
+  deterministic.c:10
+  deterministic.c:11
+  deterministic.c:12
+  deterministic.c:30
+  deterministic.c:31
+  deterministic.c:32
+  deterministic.c:34
+  deterministic.c:16
+  deterministic.c:17
+  deterministic.c:18
+  deterministic.c:19
+  deterministic.c:36
+  deterministic.c:37
+EOF
+
+if ! diff -q "$tmpdir/script" "$tmpdir/expected"; then
+	echo "FAIL: line numbers don't match expected: "
+	head -n 100 "$tmpdir/script"
+	cleanup
+	exit 1
+fi
+
+cleanup
+exit 0
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
deleted file mode 100755
index cb3e97a0a89f..000000000000
--- a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/bash -e
-# CoreSight / Unroll Loop Thread 10 (exclusive)
-
-# SPDX-License-Identifier: GPL-2.0
-# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
-
-TEST="unroll_loop_thread"
-
-# shellcheck source=../lib/coresight.sh
-. "$(dirname $0)"/../lib/coresight.sh
-
-ARGS="10"
-DATV="10"
-# shellcheck disable=SC2153
-DATA="$DATD/perf-$TEST-$DATV.data"
-
-perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
-
-perf_dump_aux_verify "$DATA" 10 10 10
-
-err=$?
-exit $err

-- 
2.34.1

