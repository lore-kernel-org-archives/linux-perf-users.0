Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9202EB5DA
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814729; cv=none; b=VFsv47lc9ytF2BW3GkM2WdAAR8EX5uNUlGWCgsa4OaluVnqvBLfxXMe7guFk08RV65aEkgRHyHIcBuQb4qxWRjFD7bHgdHvfUaqsX7sw0by8UBE3f7DS/fFSUzE7RIdrhRbNucpzkrkVWufasg6qWx37AFw2Mxoj2ANFN0E7xQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814729; c=relaxed/simple;
	bh=DHH2rU+Zp3WpjSOcFqndoLEJ1fs8EixAC2cPKeXp1bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nKsNtemp8xu0yObPW+vZSxmeKwr4UlTG3rEpM6m2afij22QokFFpkYQvNirsalzovsSFEwJH/WZbVpezMhlHJ+yJ410s8/VC9oLMPeKzBZ7AeYMAc18ur8NAvsMSrr9DXbcO8Y4/SGpfygT0JlWSdoiHUiy2rolAJiM1gyP/FSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwzuF2kb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwzuF2kb"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174c8fd2so2334029a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755814728; x=1756419528; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LS/TLPPn/kr4cah7f6KZL8HylpfPU2klxIkY6Orl+xQ=;
        b=vwzuF2kb/0z5sCi3jEnOUYynwTp6BYZbxlY8Gq5dm2EGZsisdzCG7cl197z0UBu828
         spDwVByu6DkzkpeR6do92HxSmuODRekYuY86UxdUS5rYTsw1FEvCDA7ftj3vkIM+i9QZ
         DBf4SqhYB0hIvYf2cIq74BxjI4Vzz1FuzCnD9NCH+vDxRE63CG1gRPPGAnc+1gAHAPpV
         cxOFfCa53oGU5QiC6Xm6yl+Dni8853Ff+r/9WogcgIFbAHGXvO4siZ9XIhWjzhGB8/KX
         61nEKpAb2OKKKXjUMSAXbWLXKAx8rf5uhFXbDd1G8LbUiro17nKbzsBtuARqB7W2HSfm
         3mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814728; x=1756419528;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LS/TLPPn/kr4cah7f6KZL8HylpfPU2klxIkY6Orl+xQ=;
        b=dxJSTDRNWJ4IakG2a0VFU+Ece3/kFGq36Rx1BoBRzJSy0c/ONO4E34BWct9Lkt2SfE
         EzFpfFWw8E3e7FwIm0Ad2zjxupFAJpXH4u/PUWcHP3udzodOzszEqOmLg3Rt0iNkwAzk
         YGmpbJ8U5mYNEdsUu1tL6Qy6VOV5ZtjjCeqtjZwYA7vzDV5cGU3otCNmezc8FNrs07sG
         q1JJGO/GdJ27yT7vjAHTfFZ5WIS2BFzBup6/7KyUG9CXglzkgZ6so+nUQDmA5iauLFTM
         L35KrLkYG7Q6NgCI9oehIP2NPKVEaDyV/1xdhekcGRR0TEuKJnBnaGibxeI2KDssoDQM
         bOWg==
X-Forwarded-Encrypted: i=1; AJvYcCXXB6BPbt6QbpatVQeARaCnlgLyCACPH3vMUWNmcj+JFe59czk/uRwUhQGP0HLS+/n65/f+P3CJrStqI+WW2FNX@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuSd8BRI+yTt8TlMzIbplJoQy8A2qAfTPxAdxWI15KTnFqojN
	a6r6n7Qj8RM5sZRd0SsxmG6YDglWVG7p7KRsZaMgfl6opUU+L/u9+LgExF9jFDrs0zQgzPCP42V
	L8I946Dodmg==
X-Google-Smtp-Source: AGHT+IHXPNLlePi8gsgIbXWjR2tpQQEuG8eoufHyr+zgrODcuxIvK91rUyW+ILAqostE++FR034QpB1CchUS
X-Received: from pjb3.prod.google.com ([2002:a17:90b:2f03:b0:321:b969:1e5d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a10:b0:243:78a:82aa
 with SMTP id adf61e73a8af0-24340d5e73dmr1106028637.50.1755814727694; Thu, 21
 Aug 2025 15:18:47 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:18:34 -0700
In-Reply-To: <20250821221834.1312002-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821221834.1312002-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821221834.1312002-5-irogers@google.com>
Subject: [PATCH v1 4/4] perf test: Avoid uncore_imc/clockticks in
 uniquification test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The detection of uncore_imc may happen for free running PMUs and the
clockticks event may be present on uncore_clock. Rewrite the test to
detect duplicated/deduplicated events from perf list, not hardcoded to
uncore_imc.

Fixes: 070b315333ee ("perf test: Restrict uniquifying test to machines with 'uncore_imc'")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/stat+event_uniquifying.sh     | 105 ++++++++----------
 1 file changed, 44 insertions(+), 61 deletions(-)

diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
index bf54bd6c3e2e..9bc7a1f520f9 100755
--- a/tools/perf/tests/shell/stat+event_uniquifying.sh
+++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
@@ -4,74 +4,57 @@
 
 set -e
 
-stat_output=$(mktemp /tmp/__perf_test.stat_output.XXXXX)
-perf_tool=perf
 err=0
+stat_output=$(mktemp /tmp/__perf_test.stat_output.XXXXX)
 
-test_event_uniquifying() {
-  # We use `clockticks` in `uncore_imc` to verify the uniquify behavior.
-  pmu="uncore_imc"
-  event="clockticks"
-
-  # If the `-A` option is added, the event should be uniquified.
-  #
-  # $perf list -v clockticks
-  #
-  # List of pre-defined events (to be used in -e or -M):
-  #
-  #   uncore_imc_0/clockticks/                           [Kernel PMU event]
-  #   uncore_imc_1/clockticks/                           [Kernel PMU event]
-  #   uncore_imc_2/clockticks/                           [Kernel PMU event]
-  #   uncore_imc_3/clockticks/                           [Kernel PMU event]
-  #   uncore_imc_4/clockticks/                           [Kernel PMU event]
-  #   uncore_imc_5/clockticks/                           [Kernel PMU event]
-  #
-  #   ...
-  #
-  # $perf stat -e clockticks -A -- true
-  #
-  #  Performance counter stats for 'system wide':
-  #
-  # CPU0            3,773,018      uncore_imc_0/clockticks/
-  # CPU0            3,609,025      uncore_imc_1/clockticks/
-  # CPU0                    0      uncore_imc_2/clockticks/
-  # CPU0            3,230,009      uncore_imc_3/clockticks/
-  # CPU0            3,049,897      uncore_imc_4/clockticks/
-  # CPU0                    0      uncore_imc_5/clockticks/
-  #
-  #        0.002029828 seconds time elapsed
-
-  echo "stat event uniquifying test"
-  uniquified_event_array=()
-
-  # Skip if the machine does not have `uncore_imc` device.
-  if ! ${perf_tool} list pmu | grep -q ${pmu}; then
-    echo "Target does not support PMU ${pmu} [Skipped]"
-    err=2
-    return
-  fi
+cleanup() {
+  rm -f "${stat_output}"
 
-  # Check how many uniquified events.
-  while IFS= read -r line; do
-    uniquified_event=$(echo "$line" | awk '{print $1}')
-    uniquified_event_array+=("${uniquified_event}")
-  done < <(${perf_tool} list -v ${event} | grep ${pmu})
+  trap - EXIT TERM INT
+}
 
-  perf_command="${perf_tool} stat -e $event -A -o ${stat_output} -- true"
-  $perf_command
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
 
-  # Check the output contains all uniquified events.
-  for uniquified_event in "${uniquified_event_array[@]}"; do
-    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then
-      echo "Event is not uniquified [Failed]"
-      echo "${perf_command}"
-      cat "${stat_output}"
-      err=1
-      break
-    fi
+test_event_uniquifying() {
+  echo "Uniquification of PMU sysfs events test"
+
+  # Read events from perf list with and without -v. With -v the duplicate PMUs
+  # aren't deduplicated. Note, json events are listed by perf list without a
+  # PMU.
+  read -ra pmu_events <<< "$(perf list --raw pmu)"
+  read -ra pmu_v_events <<< "$(perf list -v --raw pmu)"
+  # For all non-deduplicated events.
+  for pmu_v_event in "${pmu_v_events[@]}"; do
+    # If the event matches an event in the deduplicated events then it musn't
+    # be an event with duplicate PMUs, continue the outer loop.
+    for pmu_event in "${pmu_events[@]}"; do
+      if [[ "$pmu_v_event" == "$pmu_event" ]]; then
+        continue 2
+      fi
+    done
+    # Strip the suffix from the non-deduplicated event's PMU.
+    event=$(echo "$pmu_v_event" | sed -E 's/_[0-9]+//')
+    for pmu_event in "${pmu_events[@]}"; do
+      if [[ "$event" == "$pmu_event" ]]; then
+        echo "Testing event ${event} is uniquified to ${pmu_v_event}"
+        perf stat -e "$event" -A -o ${stat_output} -- true
+        # Ensure the non-deduplicated event appears in the output.
+        if ! grep -q "${pmu_v_event}" "${stat_output}"; then
+          echo "Uniquification of PMU sysfs events test [Failed]"
+          cat "${stat_output}"
+          err=1
+        fi
+        break
+      fi
+    done
   done
 }
 
 test_event_uniquifying
-rm -f "${stat_output}"
+cleanup
 exit $err
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

