Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E52FC881
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154899; cv=none; b=GtAj0Rr+qZJyp7IHI/zJd8yVX8Ru/xCIqFzDT+rzTzsHz7zhra2B4g9dQnb2vpkU86EZ4XqW4dQYMN3+kTD6HZ/lbAkgjbGL63rqd808NE6PZlW+d62tZR+3Sp1Xl6ZFcKsd2a9g+ks0SDST8pXfGdhr46AQiktjz106C5Ea3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154899; c=relaxed/simple;
	bh=Y0A7uIYm0/hTwz3uOvIKTQjqsYkyO72j5ZJc+bz7kWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PwOQucBjYnKov+vztC2ATEmbnu47tHZxOFzOtJ3ntidzvu2UcxGjUw3jbnzGbcb7J2X7h+OEKAPWJ5i4gs5jhuX+RTxpnhIAy0ZLEKu4RspuY9QPYO9AgvWl4646YE0GR6IgnRIcEb/jKIptW2KHIrdLeRBCS697lzioJAqSD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vT201cPB; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vT201cPB"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13536592ebeso14058493c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779154896; x=1779759696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FLbhfS6dmKPZbmfI47Elwx0wCEuwKnKMsF58wjgvdo=;
        b=vT201cPBu6XeLmxNzP1ZN0p1GTQQbJAFl68ekgJBgx+o53AKPqIdPmVJFBLGGNNRyl
         XDhqy4/obrpGef2kjdx83FF7IKfK7QI9rrYa+yGIXYTgoNW+C2WD8HU2ksAnuAsDDoy7
         0bw3XWKdIs/QAs9nz2KZaMOSIIEXN0Q5E410EtEsI1ptfs4Abw6k4nwCslG4dXjfbdbN
         MBu2UuUivwpWvQiyGdBAb/V9O4St92/8s9nh82WdqR1h5urudfO41lwJvD5VuUi2nsLM
         rOtRCHq8nrkdqkTGcT+QZsZGhG8In8mpsAoZ4XuImyCTc0xysiPwHTbiNgav1a5EaWTr
         FeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154896; x=1779759696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FLbhfS6dmKPZbmfI47Elwx0wCEuwKnKMsF58wjgvdo=;
        b=hvGa1K2SfUcMSv1hlDA5RjyDZVk2LdUq1PWYd/vFbtSXakNh4ch9oVsGGX75pdjSYQ
         YVPYOv2IBbNVXnd4uILF1wwYBBfwwPQAWr2BYnx2TaKPW1kFqEfFX67lE64CMFgMF3zd
         mPIBK1V2IuEOuAzbfU5MFZNjrcV7eTXxGom3o9lIZmALJeVEbR86VcwW5aUBWfmd3Jg3
         PMoOLFtCexyPEZrII8O9IEHBQqLZ8v/XqIc33DwFMjOA61veOoyq7IQBfbLHnWM4ILaJ
         oonoUfIuaV6B4xNBnnSLYjdA0H517DPsZ4az78PMuAqFxX4684tGFGjLR7twQDjSvnGV
         qyGA==
X-Forwarded-Encrypted: i=1; AFNElJ/8gNtzf8MQnWFqLcSeqy1NLlfZ3u3SM5avoHAqmWbwOZPTjTaa0ZNhgFI63RAmq+8ijRutO/6bsmG8V6N9HHgp@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPK24lIu0JbPEJsZ4vNbSv+T1KF79UbwxSMdTxSkLqUda5F0z
	L3gvCzKKH4Pl9BUTp3aNFkGv85QfbcHmq1kUvaAaoTLmaLtYo5I32MsKOfpYEIclEyeDQy65OlL
	wqNKsV2mVCg==
X-Received: from dlbcj24.prod.google.com ([2002:a05:7022:6998:b0:12c:20df:7530])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1a85:b0:12d:d972:b96e
 with SMTP id a92af1059eb24-1350542e8e5mr7867042c88.20.1779154895600; Mon, 18
 May 2026 18:41:35 -0700 (PDT)
Date: Mon, 18 May 2026 18:41:06 -0700
In-Reply-To: <20260519014106.3089452-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518223733.3034897-1-irogers@google.com> <20260519014106.3089452-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519014106.3089452-3-irogers@google.com>
Subject: [PATCH v4 2/2] perf tests: Add test for stat delay option with duration_time
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, nigro.fra@gmail.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add a new test case `test_stat_delay` to `stat.sh` to verify that
`duration_time` correctly excludes the delay period when using the
delay option (-D).

The test runs `perf stat -D 1000 -e duration_time sleep 2` and
verifies that `duration_time` is ~1s (excluding the 1s delay), not
~2s.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3-flash
---
 tools/perf/tests/shell/stat.sh | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 4edb04039036..1e17bee026bd 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -483,6 +483,58 @@ test_stat_pid() {
   wait $pid 2>/dev/null || true
 }
 
+test_stat_delay() {
+  echo "stat -D test"
+  if ! env LC_ALL=C perf stat -D 1000 -e duration_time sleep 2 > "${stat_output}" 2>&1
+  then
+    echo "stat -D test [Failed - command failed]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  duration=$(grep "duration_time" "${stat_output}" | awk '{print $1}' | tr -d ',')
+  elapsed=$(grep "seconds time elapsed" "${stat_output}" | awk '{print $1}')
+
+  if [ -z "$duration" ] || [ -z "$elapsed" ]
+  then
+    echo "stat -D test [Failed - failed to find duration_time or time elapsed in output]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+
+  # Compare duration (ns) and elapsed (s) using awk to handle float and allow tolerance.
+  if ! awk -v d="$duration" -v e="$elapsed" '
+    BEGIN {
+      diff = d - (e * 1e9);
+      if (diff < 0) diff = -diff;
+      # Allow 200ms tolerance (200,000,000 ns) for loaded CI machines.
+      if (diff > 200000000) {
+        printf "Fail: duration (%d ns) and elapsed (%f s) mismatch (diff %d ns)\n", d, e, diff;
+        exit 1;
+      }
+      # Lower bound check: must be at least 0.5s.
+      if (d < 500000000) {
+        printf "Fail: duration (%d ns) is abnormally small\n", d;
+        exit 1;
+      }
+      # Upper bound check: must be strictly less than 1.7s (proving delay was excluded).
+      if (d > 1700000000) {
+        printf "Fail: duration (%d ns) is too large (delay might not be excluded)\n", d;
+        exit 1;
+      }
+      exit 0;
+    }'
+  then
+    echo "stat -D test [Failed - validation failed]"
+    cat "${stat_output}"
+    err=1
+    return
+  fi
+  echo "stat -D test [Success]"
+}
+
 test_default_stat
 test_null_stat
 test_offline_cpu_stat
@@ -498,6 +550,7 @@ test_stat_no_aggr
 test_stat_detailed
 test_stat_repeat
 test_stat_pid
+test_stat_delay
 
 cleanup
 exit $err
-- 
2.54.0.631.ge1b05301d1-goog

