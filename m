Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77CF6BFCE
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Apr 2025 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744418836; cv=none; b=sJXVyxDVBwegdQXnyCIVlUgRKlWFW5OK2dfWSQJQutUBXkcEUVa1YDYN4jluQ0Inv+W68G1F+I5KSIJe+jjDuQxjFt+JFRgl16ycNzdisnyq+Y2st52u0NjAFl/HcL7UBn2p9k/M4z1+0m4cFzFhg8lUF2RsAi6a9mBvYK6swm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744418836; c=relaxed/simple;
	bh=SgrkXJin2j58VtTRHS0thbHOP+JvBUAmfK0Umsec3c0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=doYnxDcGf1TND1s0Ko/lZ9K37acB7RzAyst33naFelz5bSaHayw1UdBTVr4dLdFe8m9p4Qmg5w1NsBEkxXTdcDs6adZ7eX//U7TNmslRAoSzN8MLU7nfRMKoc9KK/6sMvdT2UFcLf7d2lUKo968uJ8oDi0UGrGZ+zbDHVMMg8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhWUge6s; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhWUge6s"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af534e796baso1619698a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Apr 2025 17:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744418834; x=1745023634; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DuVdS/mDB646tZJrkVuYHIUb6miCp1Cr3X1H8i/VEm4=;
        b=MhWUge6shMe07ejwUOREnhfgKxzlm4PjW0OyXHo7+Y0Icc7f8qDWHA/NWR2HQCLRsn
         OOzaKy+7qEeryjuQZQuyU3gZWgK9gkaaWMxvl4fyYtbP35KZmpAkncgZj/teTcQaX+1w
         zX+8O4qjlHmvf87cyO7DcgQ0yzbGgDpgUitRKFVvjI7s34runDfDWoPfhgDKZnubKce2
         IPs/mDiJtY2L9g0463of4IqTmCNJ/q+bdfa6ddGylEUVDWmWi2iEQOTD9yD9SHpAE44P
         wI/Mo+88gFMnV0F0do/xKCyavx7C3CEXDSUlGcGUNgdOafxQBe22DjmpoA6JmvlGuvxU
         9mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744418834; x=1745023634;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuVdS/mDB646tZJrkVuYHIUb6miCp1Cr3X1H8i/VEm4=;
        b=uA79nVLg09nM5LKXJupJnZmYwSlv09eOCsGJi07Inl5FYKCnS8mCT//Q90obfQblTw
         Lv1jP/8N82X/xirm+VQupvi6Grekea5nlb/DZkgIw3vgiG6M84N/M1Z3gFhUUlqOnyW9
         MSaZV4DNTy+qQiiYkGVjxJqYXO80PshbvVW9YMBhMbQa0Ah9kXl2HnVET6h9/EMbYbnh
         icXwtOcO7CZ4J48Yo94M+aMNGZ39J3eV4TjyVtR3NKSXo0wDVM3Dfdkt9y7cAtzY0+Xz
         XULPoLPPCv2Ted0jLUNF8hd8MBh4tNt3AAzoYong7o6T6CpdJRGI4zZcGuGHMdi9zWur
         lSUg==
X-Forwarded-Encrypted: i=1; AJvYcCUME1pmaEqNWROIzDkTWcKuzC7VPGEeqiiYssh01K5BAx66WlBwquRCQeJzlengwOtonGBNAezhJJkvLfSiXm8L@vger.kernel.org
X-Gm-Message-State: AOJu0YxbR7e1yPafMSM4vwSmGYUHCAC0j4hL8W07ZXkT328jWsuiPAkf
	1C4wv3NnoN69DCjVzH3FNouECfzNEdPKvNdsfRGzNmCexBpIgLnTPbB1/Qfpq2PmxqKXGzbpUDi
	r82A3Iw==
X-Google-Smtp-Source: AGHT+IFQGy4qnSQfWF82eM3HWZ1nwuNMXL0YMLjooqqLoMv6CYp/VuMMv1tm3pD0+X0LCx0GO3Qt/ZHbTcWM
X-Received: from plop14.prod.google.com ([2002:a17:902:8a8e:b0:223:f7b1:99cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d492:b0:223:66bb:8993
 with SMTP id d9443c01a7336-22bea50bd60mr70305725ad.43.1744418833998; Fri, 11
 Apr 2025 17:47:13 -0700 (PDT)
Date: Fri, 11 Apr 2025 17:47:04 -0700
In-Reply-To: <20250412004704.2297939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250412004704.2297939-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250412004704.2297939-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf tests metrics: Permission related fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan@google.com, 
	Liang@google.com, kan.liang@linux.intel.com, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When permissions are limited running sleep without system wide isn't a
good benchmark to run to achieve samples, switch to running noploop.
Remove indent for non-success cases.
Allow skip for the not counted case.
Minor debug changes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 118 +++++++++++----------
 1 file changed, 64 insertions(+), 54 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index ee817c66da06..6fa585a1e34c 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -7,86 +7,96 @@ ParanoidAndNotRoot()
   [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
 }
 
+test_prog="sleep 0.01"
 system_wide_flag="-a"
 if ParanoidAndNotRoot 0
 then
   system_wide_flag=""
+  test_prog="perf test -w noploop"
 fi
 
 err=0
 for m in $(perf list --raw-dump metrics); do
   echo "Testing $m"
-  result=$(perf stat -M "$m" $system_wide_flag -- sleep 0.01 2>&1)
+  result=$(perf stat -M "$m" $system_wide_flag -- $test_prog 2>&1)
   result_err=$?
-  if [[ $result_err -gt 0 ]]
+  if [[ $result_err -eq 0 && "$result" =~ ${m:0:50} ]]
   then
-    if [[ "$result" =~ "Cannot resolve IDs for" ]]
-    then
-      echo "Metric contains missing events"
-      echo $result
-      err=1 # Fail
-      continue
-    elif [[ "$result" =~ \
-          "Access to performance monitoring and observability operations is limited" ]]
+    # No error result and metric shown.
+    continue
+  fi
+  if [[ "$result" =~ "Cannot resolve IDs for" ]]
+  then
+    echo "Metric contains missing events"
+    echo $result
+    err=1 # Fail
+    continue
+  elif [[ "$result" =~ \
+        "Access to performance monitoring and observability operations is limited" ]]
+  then
+    echo "Permission failure"
+    echo $result
+    if [[ $err -eq 0 ]]
     then
-      echo "Permission failure"
-      echo $result
-      if [[ $err -eq 0 ]]
-      then
-        err=2 # Skip
-      fi
-      continue
-    elif [[ "$result" =~ "in per-thread mode, enable system wide" ]]
+      err=2 # Skip
+    fi
+    continue
+  elif [[ "$result" =~ "in per-thread mode, enable system wide" ]]
+  then
+    echo "Permissions - need system wide mode"
+    echo $result
+    if [[ $err -eq 0 ]]
     then
-      echo "Permissions - need system wide mode"
-      echo $result
-      if [[ $err -eq 0 ]]
-      then
-        err=2 # Skip
-      fi
-      continue
-    elif [[ "$result" =~ "<not supported>" ]]
+      err=2 # Skip
+    fi
+    continue
+  elif [[ "$result" =~ "<not supported>" ]]
+  then
+    echo "Not supported events"
+    echo $result
+    if [[ $err -eq 0 ]]
     then
-      echo "Not supported events"
-      echo $result
-      if [[ $err -eq 0 ]]
-      then
-        err=2 # Skip
-      fi
-      continue
-    elif [[ "$result" =~ "FP_ARITH" || "$result" =~ "AMX" ]]
+      err=2 # Skip
+    fi
+    continue
+  elif [[ "$result" =~ "<not counted>" ]]
+  then
+    echo "Not counted events"
+    echo $result
+    if [[ $err -eq 0 ]]
     then
-      echo "FP issues"
-      echo $result
-      if [[ $err -eq 0 ]]
-      then
-        err=2 # Skip
-      fi
-      continue
-    elif [[ "$result" =~ "PMM" ]]
+      err=2 # Skip
+    fi
+    continue
+  elif [[ "$result" =~ "FP_ARITH" || "$result" =~ "AMX" ]]
+  then
+    echo "FP issues"
+    echo $result
+    if [[ $err -eq 0 ]]
     then
-      echo "Optane memory issues"
-      echo $result
-      if [[ $err -eq 0 ]]
-      then
-        err=2 # Skip
-      fi
-      continue
+      err=2 # Skip
     fi
-  fi
-
-  if [[ "$result" =~ ${m:0:50} ]]
+    continue
+  elif [[ "$result" =~ "PMM" ]]
   then
+    echo "Optane memory issues"
+    echo $result
+    if [[ $err -eq 0 ]]
+    then
+      err=2 # Skip
+    fi
     continue
   fi
 
   # Failed, possibly the workload was too small so retry with something longer.
   result=$(perf stat -M "$m" $system_wide_flag -- perf bench internals synthesize 2>&1)
-  if [[ "$result" =~ ${m:0:50} ]]
+  result_err=$?
+  if [[ $result_err -eq 0 && "$result" =~ ${m:0:50} ]]
   then
+    # No error result and metric shown.
     continue
   fi
-  echo "Metric '$m' not printed in:"
+  echo "Metric '$m' has non-zero error '$result_err' or not printed in:"
   echo "$result"
   err=1
 done
-- 
2.49.0.604.gff1f9ca942-goog

