Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A092FFDD5
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143873; cv=none; b=ZPq6nM6HaNiomoXtrGyKCDdRjWFLGuQ/j92M5c79gulnEVHhcVAdRuuf0/YA/b4/350OipuEqicTkKBmOnshcleLOI0r9+6G6APdGhhu/J5TB+DOdN0yzj9GNzzAqg/4uCm2xEGyryMGtfYmBq7iF7RG5myIEtFlUNkaqmBHquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143873; c=relaxed/simple;
	bh=Y0A7uIYm0/hTwz3uOvIKTQjqsYkyO72j5ZJc+bz7kWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cmdAHiLHQ/iUY92QXOfET6mNk7sIimf5BBagiQW+HgwqAy4tfB5AaeI3NfYvh+HMVOfs7ZQMR4r5reDq7fSNOuWfzsoTCVPVfNz20VcPGUf9Y1iokSLi33R0oJOEeFpTMnzt0HNgTiwWTuuVwaXJC64AmEG9WKsFJ2NLPj4znMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dHNr0jbp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHNr0jbp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba268cb5e6so28651075ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779143871; x=1779748671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FLbhfS6dmKPZbmfI47Elwx0wCEuwKnKMsF58wjgvdo=;
        b=dHNr0jbpt+KOouRYy8M5ydRgtl9IhD/ZEoP7EjazE4wEsoUNykDV94mnplkH7jM4uv
         8nrAWpWcuvqeBVG0szz2ImQwAkti5wKnf5RN8qD29C54bFR0jir7+Uk4/PRSo5pQOCEI
         ajE9uqQ/tCHri1rvkFqKsYmHG88iFQkHxbk3RhNQ7iU6rP+ArR6QWSknwOCod+OTHy+G
         HF48rZk9o0ersnaY/hr61h7Tl8uDRKpyqyimNnukIR2eW0wz6/TjLM+MCAWZowEtk0J1
         SZ062tqzmMS+ivqT3xXaQkyh3bwnhegwPU4hW17BDMq1tFF2xb77sic2YU9B0+BK9TUP
         4GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779143871; x=1779748671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FLbhfS6dmKPZbmfI47Elwx0wCEuwKnKMsF58wjgvdo=;
        b=K8WibGI7i4q+E2nbtn9iC1HvHHXH5lzVWaXRAKOaP0zEhs60KPAmiEaQl4AMYdCST0
         hrbrhcYDBZuFoFsAX4J0qcPNu0YsCoAQteVr8XYSnzF1t8s/I4E4v2MsvyzGXAOnoB4v
         gaXnWoI995m9xFQ6O7aiIKKhiP1cKmi+8tQaccDafAqMprKSYO18ssl4Ujqardu3yAQX
         ICuhPMZ9fqMNIa/Gk1i4xhVBWFgasX7jOsBzxXMDzZh9Qb9W7mfbZ3ytiSqeMLQBEeh4
         GJDwDfdZSR/LNfjpBzGSz8i3hcjz6qrMEosIGzrlFJJiWKDRvpWd99sJ0tmjz6As+RnX
         hmjw==
X-Forwarded-Encrypted: i=1; AFNElJ9A0T3/xHc9eR5EPLmppiYVQDcMBUu2QOhovQ1a3/Gb4qj6uzEhi4I3gnS9YvxOLFQC0VuH5RM1ZNix+0woxJOy@vger.kernel.org
X-Gm-Message-State: AOJu0YyHExLWiIjwBuDznjS1kXENQ1gVvZiE3IRmdpvG0XoxQ52oHuoT
	rvHSrbzbjVgXCxONUOKhJApRUxEwRIUXLu9CclTV6PbEr43YU1OjWdPJOGULz70e51SbM9NRL0y
	z/XG2PuSilA==
X-Received: from plrp20.prod.google.com ([2002:a17:902:b094:b0:2bd:4f41:fbf4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef11:b0:2be:1eb1:eaf7
 with SMTP id d9443c01a7336-2be1eb1ec68mr29595175ad.24.1779143871131; Mon, 18
 May 2026 15:37:51 -0700 (PDT)
Date: Mon, 18 May 2026 15:37:33 -0700
In-Reply-To: <20260518223733.3034897-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518201419.2943132-1-irogers@google.com> <20260518223733.3034897-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518223733.3034897-3-irogers@google.com>
Subject: [PATCH v3 2/2] perf tests: Add test for stat delay option with duration_time
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

