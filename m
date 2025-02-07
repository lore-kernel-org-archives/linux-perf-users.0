Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA81EC018
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928494; cv=none; b=Wqqmih8MLhrm6umsuvswxsfY/pSp6DjWljYYDiSwZ+q7CLXZoTHjA/VL74DGokJUFEZX85UjiODnkcY/Ld7Zl7j5NSkzlwty0lBLxi7+/BmsB1Hdsx38J3fefqzOrsu5UnicWk2JqWMtNa1UkyahWckkaAQHwTa7saeBLTwGJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928494; c=relaxed/simple;
	bh=vNm1zipX8l+y8MG6tw9MJGfiW0u+S4OqXwmISHUwx04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GZRu6f+GS/youFBP6Xuq0F5J4JlOWtCkwGS38E3A90hntVGUrOSNjDdJg0zSSzp1M+op3lYpdmb2/OsnqVo03BTn2/uWxyzIJfNGxydTprG3zk/DaFLWCvwDgnD9HqR3InLZIchD3my+cEWPmyBpOJl21/C6pLe3/2LAkOq1WpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHutgQNe; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHutgQNe"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ab78f08e32cso50353566b.2
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 03:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738928491; x=1739533291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdHp3gJt+sZl9/jkaomemfmjBrhePbLjx4QyMp6pEyY=;
        b=wHutgQNerEimp8zMrQlTXbdFwpHAhR+PmLDW9R3vUbWvZ+QIo43ChxDQk+ZBwkBUjq
         NMhc3i2Duys/y40ralMJn9K9bv9w+MvJcDetpb8ymC88L7w/EPE1kP4MhVYgR622c0Hl
         TVFNeBo4vb4IZKJ2X8s5+YGimjxWElCr4i9zVwZcVRtQpgutnQzT7hWyzlmMF/BPrQe4
         0ANkMQAJVbBZz1gIr3pCfJhL70RSWTL8I6IKZFNUIuX5/eBgaQ6VKhKeXQ6tPNSmiUYZ
         z663eFQbbkRrvkDb3fA3hfrxpWag8M+E9es/bfHc2/TLqzUnAMS5Sw+uC43CbG0iP64i
         phlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928491; x=1739533291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdHp3gJt+sZl9/jkaomemfmjBrhePbLjx4QyMp6pEyY=;
        b=AnTYbwjjUgAcyl49c0vRXg7qqBJglByaCclxT1VpWto7BCuKipXa6x43cr+phKlsAX
         kOxBpiL2V5QDvARh/nhnSj6KUD7wjwtCjYUjMIikV6gUQIf9IwmCiOpLmHTQFjxXHzn8
         MU839Evr+pxfaJr2lTxsP2SdqHAPDp9irYadRLKhdTBQVCdEA8wQJc4o30Q9KhHeWlcq
         9MflA7gV82MNmgiqEzILC4jehpr9lAS08tl/Bs1/Y7qyy9Cdj8hEJq7LU7/FFKwELD+y
         1v3mrk9M01tuxu+zWzj2yM0NbZzJmCwoCbu+1sSVSoAmn41t0Ma45fpCNEehan0PYtB+
         zVKQ==
X-Gm-Message-State: AOJu0YyuSwaquD74ajLrcVTgBCHimBKkeXIC/Bh1+izYOtEvUgHhpv+i
	02hYzy8E0A+U2GTUiljFcgln6hQvadG1znMbq/weujDtN87W5g+EjtgwGAjEj+96ag2QcIkDzXL
	T2RhYVA==
X-Google-Smtp-Source: AGHT+IH1amhx1xJYRjBBKMtU9a0fw8ozglGfaN1AajY2U9HtOdxgdOl7Sy8xGf48tXpJSRaikmmpoAYoSzX+
X-Received: from ejcla14.prod.google.com ([2002:a17:907:780e:b0:ab7:8a7c:e5c3])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:c285:b0:aaf:ab71:67b6
 with SMTP id a640c23a62f3a-ab789ba4ff8mr303416266b.31.1738928491042; Fri, 07
 Feb 2025 03:41:31 -0800 (PST)
Date: Fri,  7 Feb 2025 12:40:35 +0100
In-Reply-To: <cover.1738928210.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738928210.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <eb8506dfa5998da3b891ba3d36f7ed4a7db4ca2b.1738928210.git.dvyukov@google.com>
Subject: [PATCH v6 8/9] perf test: Add tests for latency and parallelism profiling
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Ensure basic operation of latency/parallelism profiling and that
main latency/parallelism record/report invocations don't fail/crash.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/tests/shell/base_report/setup.sh   | 18 ++++++-
 .../tests/shell/base_report/test_basic.sh     | 52 +++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/base_report/setup.sh b/tools/perf/tests/shell/base_report/setup.sh
index b03501b2e8fc5..8634e7e0dda6a 100755
--- a/tools/perf/tests/shell/base_report/setup.sh
+++ b/tools/perf/tests/shell/base_report/setup.sh
@@ -15,6 +15,8 @@
 # include working environment
 . ../common/init.sh
 
+TEST_RESULT=0
+
 test -d "$HEADER_TAR_DIR" || mkdir -p "$HEADER_TAR_DIR"
 
 SW_EVENT="cpu-clock"
@@ -26,7 +28,21 @@ PERF_EXIT_CODE=$?
 CHECK_EXIT_CODE=$?
 
 print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "prepare the perf.data file"
-TEST_RESULT=$?
+(( TEST_RESULT += $? ))
+
+# Some minimal parallel workload.
+$CMD_PERF record --latency -o $CURRENT_TEST_DIR/perf.data.1 bash -c "for i in {1..100} ; do cat /proc/cpuinfo 1> /dev/null & done; sleep 1" 2> $LOGS_DIR/setup-latency.log
+PERF_EXIT_CODE=$?
+
+echo ==================
+cat $LOGS_DIR/setup-latency.log
+echo ==================
+
+../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/setup-latency.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "prepare the perf.data.1 file"
+(( TEST_RESULT += $? ))
 
 print_overall_results $TEST_RESULT
 exit $?
diff --git a/tools/perf/tests/shell/base_report/test_basic.sh b/tools/perf/tests/shell/base_report/test_basic.sh
index 2398eba4d3fdd..adfd8713b8f87 100755
--- a/tools/perf/tests/shell/base_report/test_basic.sh
+++ b/tools/perf/tests/shell/base_report/test_basic.sh
@@ -183,6 +183,58 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "symbol filter"
 (( TEST_RESULT += $? ))
 
 
+### latency and parallelism
+
+# Record with --latency should record with context switches.
+$CMD_PERF report -i $CURRENT_TEST_DIR/perf.data.1 --stdio --header-only > $LOGS_DIR/latency_header.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl ", context_switch = 1, " < $LOGS_DIR/latency_header.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "latency header"
+(( TEST_RESULT += $? ))
+
+
+# The default report for latency profile should show Overhead and Latency fields (in that order).
+$CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data.1 > $LOGS_DIR/latency_default.log 2> $LOGS_DIR/latency_default.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "# Overhead   Latency  Command" < $LOGS_DIR/latency_default.log
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/latency_default.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "default report for latency profile"
+(( TEST_RESULT += $? ))
+
+
+# The latency report for latency profile should show Latency and Overhead fields (in that order).
+$CMD_PERF report --latency --stdio -i $CURRENT_TEST_DIR/perf.data.1 > $LOGS_DIR/latency_latency.log 2> $LOGS_DIR/latency_latency.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "#  Latency  Overhead  Command" < $LOGS_DIR/latency_latency.log
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/latency_latency.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "latency report for latency profile"
+(( TEST_RESULT += $? ))
+
+
+# Ensure parallelism histogram with parallelism filter does not fail/crash.
+$CMD_PERF report --hierarchy --sort latency,parallelism,comm,symbol --parallelism=1,2 --stdio -i $CURRENT_TEST_DIR/perf.data.1 > $LOGS_DIR/parallelism_hierarchy.log 2> $LOGS_DIR/parallelism_hierarchy.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "#           Latency  Parallelism / Command / Symbol" < $LOGS_DIR/parallelism_hierarchy.log
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/parallelism_hierarchy.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "parallelism histogram"
+(( TEST_RESULT += $? ))
+
+
 # TODO: $CMD_PERF report -n --showcpuutilization -TUxDg 2> 01.log
 
 # print overall results
-- 
2.48.1.502.g6dc24dfdaf-goog

