Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F81212B0E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437734; cv=none; b=QyYtaaIEPcHA4OnNj3TE9zTtz7axBAvyBng9UPeEAyr5QZ0ze5B6QGzF0HbaVSxWZpDe9GdeWSE9RSdbz+2pXWpRYns6y+WjOhGbdW1h+/J5I2PiMRVVdDw+MoFwNeJwWPhKz4zubWCBCpBZYZmKKzGNI93QPgSohpU4Osc83qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437734; c=relaxed/simple;
	bh=vNm1zipX8l+y8MG6tw9MJGfiW0u+S4OqXwmISHUwx04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Touw4UNp4NVqZdtGgyAcsNJfdLuqHcsSWmSlEa1MOUX37oqlMrKSl/l2ju+KMU2R4iTLxUdkODr5qXYbFYoXFqYs/6DXlhO/r+m6fwFAdOYtgojKHYa0+gIY+FHmSksvPl2IEHrm4nkMbsKzdKVlNQ0f4bs095WIMoSXa6DipgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOJy0YYE; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOJy0YYE"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38dcc9653a7so280747f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 01:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739437730; x=1740042530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdHp3gJt+sZl9/jkaomemfmjBrhePbLjx4QyMp6pEyY=;
        b=eOJy0YYEpsenc/2wRFr2tJFNFNO8Lbvz8chrSjR4XYyZpGdB9z4h/d5FDRw86FSprj
         Dct1fLhPPxIyG8D2BD+BPK9E1jcTKWHL55xvkt2ehiPEMqJuozsfN0E53l7uMGLroX6n
         MdIrbHpHqSIt3wLBgfHO2buIzx4Iez1/OZ3UiF80gcQ+1G4QCSBHxpCQ/z/QuxZfGijk
         vp+SmdNT3iFLierNWa2oXYwlRu+9GXGc4wtphkn4ZPhWNFU+DnqesjD2WBW+8Zky7kh7
         tB/dqPvktN516ib5i78pVPswtvUoR3ZjESLKOnf0aAzMe32LvS/FwIMTKA20pTMNDegE
         Y6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437730; x=1740042530;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdHp3gJt+sZl9/jkaomemfmjBrhePbLjx4QyMp6pEyY=;
        b=M7ESOtrkDFlr+utEHhvIwYc3PQ0oSmqyHjFTkLqhRig734gbnWlPO/9Gb5dXClWQnL
         X/g/vSLZr/NLX0RZn4A7JM+JG1+75uNIqkpcT2qqQj9ZxCPaWE206OglsvI3QM/ikPEl
         Ny/90f8ZzMeEgSFavnfJOheKersNp0VDzv4rBX+sJjIP5fGqcWB3yd2geJ1aJnYRcHtG
         YTuWS35FT84UtKabGpJcD3XK/u7RqMvRRZgv0gs+VGhNeue964kNzr0NOi1ARAIh7CvS
         25WiQ9b1SIB8xUAtvorRoYq22XnqMFBbeyrbgQ1rEegF7ZQLQBXvd42TiGQs027ucL7m
         OfRA==
X-Gm-Message-State: AOJu0YxyMHIEnGk93g5vGAoXI7Dt//7eEO+3a0ujizvS9hwZGl0mKxj/
	4rbdtv9r4XANqw2vJjYrLcUGpOkefy/kMmSy3a9CkCtkG/E5pW0eJSuFWAjW/SaALY3ZOTPD0UZ
	vCUyN2Q==
X-Google-Smtp-Source: AGHT+IF+G4BAyfyJWSsO64c7Jj+8HIOb0dhGOApcR2eIgjNiak3y9klCm22xFuNKZ49XTx39xgEZTtsr9OtS
X-Received: from wmbg1.prod.google.com ([2002:a05:600c:a401:b0:439:6370:39d])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:c0b:b0:38f:2352:4314
 with SMTP id ffacd0b85a97d-38f24519e3dmr2304748f8f.38.1739437730701; Thu, 13
 Feb 2025 01:08:50 -0800 (PST)
Date: Thu, 13 Feb 2025 10:08:21 +0100
In-Reply-To: <cover.1739437531.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739437531.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <c129c8f02f328f68e1e9ef2cdc582f8a9786a97d.1739437531.git.dvyukov@google.com>
Subject: [PATCH v7 8/9] perf test: Add tests for latency and parallelism profiling
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org, 
	ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
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

