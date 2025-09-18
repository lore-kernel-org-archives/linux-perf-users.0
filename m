Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F013090EF
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234134; cv=none; b=USpe4bbnd39IfgEtSONq64EwwxynZa/dr5h/r68uEkdzz4JMiWs4V/dd9tSTvKTNaCl1hmFtVllp1nLuGM8yCKPUXOBcXZeOYib6ZOetF5AYlrZN1ESMkIUiHfbMg670f/9TQ4OX87TIzRKcB+MjNv37gDRx5at5WK6Wuk+wTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234134; c=relaxed/simple;
	bh=TwqoMqLQHjUxI2rkeJmleYPOhZn3UgjHTrrdcI1tvtg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bVH8CKS2PbFw6lB88X7s/brk3KrA0RSd35G3XG4xJV49sChEnyvlrEuVXbuodXhl9FDxUMIQtu1AjHaNwpfVPLKHVcotpicApdWDPezkUpQDe1xL+E5j9FuWKkCCl0Z8SPcxXOCDV8+zjVtKtTbK8HN+ID9xDkb2q+2TPrekZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlpREUlv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlpREUlv"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-269939bfccbso12274745ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758234132; x=1758838932; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxusbh2pXscDQhVlXFTi2xaqfqmPjhhvMWLhfAOar+Y=;
        b=mlpREUlvP6e6n7GOUsRf0ozKfZih0ZW3SnZMpMfcDw8FVQ3Q7ixTXjjKvhzQFvS760
         9/gQXa5ca44XjHNNLjx/QqjSWDVo/PRTvotjnbAyjodzCyLHmPwBpatm9B+ZxbcjGq2y
         9yY/v4pfwY2sLFkCjIcyHgH27YHw3vi2QYTT/NBMOjVC1y5qHMhKxaTXN13qLqxv3LDn
         gYwXYuZ1wOq0JnE9IDJDXvDBeNbu7UKJLhZaOpEYwPoYxuHmFzmhbsig8xP7x8Pu7oJ6
         LnTfzTR7qgRBsUA2SIOSkZdo22FYMqHWuDTHc4boV+LzAAxNmo22OidCT0E6X0DFLZBb
         vJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234132; x=1758838932;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxusbh2pXscDQhVlXFTi2xaqfqmPjhhvMWLhfAOar+Y=;
        b=iPWJUXXeR4LZX+cs4YTAeB5c6uvOBQiz6wbV77xyuGMLt2cKWgBtKtqfAFoNavUaDq
         ZGcJmczNX4sWhtYDCk3JT94288jucdqEDnNtFqHa84sNjDSl5kMMGKAL0qtnT7qJFuFP
         uzEkYuAimw9GomNKBMPUo1AWgWj29zmaLjjH8jVLM9pSiS5XfiCLfKUg0cZKxvibyedJ
         150GbVyTpCdtwRZzcPi/YIUX7GEpbK2K0k4ukrLoNQJn3DC5n7YmuZNp5U2titSzCd+L
         8b536jJgTSDoC03G/kmyepxXc1xczJSXahjJvn5/vL3l68k4njUDAmdOJn+OEeLOcfcI
         6a+g==
X-Forwarded-Encrypted: i=1; AJvYcCVeSFWyT31uCGW6ix6oQ0zu94T9o0mm4WUGs2U/o3Q3P+jTk782u/zYHzZ2fnKuc+9hsl27dAbb5uvMvv/pMYT/@vger.kernel.org
X-Gm-Message-State: AOJu0YycRlttVLNqToIQ4lZA95Qq+P4tEWGHfriEHIH/fmqNUuAdW7+2
	8KespSQzrCjD0BKFkM8Ed9KOPss/zdgkHcba7o01VhX1rlO8jODwKuGYZoGDz76HGvh7h7buFin
	LzaDCgg3nnA==
X-Google-Smtp-Source: AGHT+IF1i3RQ5YoxqBTNWNiUwo8wn69WpweQEoJjE2pE6tp3kNd89jJ6Dl20BgOSosjGWmWOoivuP5joC6Lb
X-Received: from pjbsv6.prod.google.com ([2002:a17:90b:5386:b0:330:8c66:4984])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:246:b0:269:a8a8:4029
 with SMTP id d9443c01a7336-269ba3ea13bmr18290485ad.5.1758234131690; Thu, 18
 Sep 2025 15:22:11 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:22:02 -0700
In-Reply-To: <20250918222202.1353854-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918222202.1353854-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918222202.1353854-4-irogers@google.com>
Subject: [PATCH v2 3/3] perf test: Avoid uncore_imc/clockticks in
 uniquification test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The detection of uncore_imc may happen for free running PMUs and the
clockticks event may be present on uncore_clock. Rewrite the test to
detect duplicated/deduplicated events from perf list, not hardcoded to
uncore_imc.

If perf stat fails then assume it is permissions and skip the test.

Fixes: 070b315333ee ("perf test: Restrict uniquifying test to machines with 'uncore_imc'")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/stat+event_uniquifying.sh     | 109 ++++++++----------
 1 file changed, 49 insertions(+), 60 deletions(-)

diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
index bf54bd6c3e2e..b5dec6b6da36 100755
--- a/tools/perf/tests/shell/stat+event_uniquifying.sh
+++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
@@ -4,74 +4,63 @@
 
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
+cleanup() {
+  rm -f "${stat_output}"
 
-  # Skip if the machine does not have `uncore_imc` device.
-  if ! ${perf_tool} list pmu | grep -q ${pmu}; then
-    echo "Target does not support PMU ${pmu} [Skipped]"
-    err=2
-    return
-  fi
+  trap - EXIT TERM INT
+}
 
-  # Check how many uniquified events.
-  while IFS= read -r line; do
-    uniquified_event=$(echo "$line" | awk '{print $1}')
-    uniquified_event_array+=("${uniquified_event}")
-  done < <(${perf_tool} list -v ${event} | grep ${pmu})
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
 
-  perf_command="${perf_tool} stat -e $event -A -o ${stat_output} -- true"
-  $perf_command
+test_event_uniquifying() {
+  echo "Uniquification of PMU sysfs events test"
 
-  # Check the output contains all uniquified events.
-  for uniquified_event in "${uniquified_event_array[@]}"; do
-    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then
-      echo "Event is not uniquified [Failed]"
-      echo "${perf_command}"
-      cat "${stat_output}"
-      err=1
-      break
-    fi
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
+        if ! perf stat -e "$event" -A -o ${stat_output} -- true; then
+          echo "Error running perf stat for event '$event'  [Skip]"
+          if [ $err = 0 ]; then
+            err=2
+          fi
+          continue
+        fi
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
2.51.0.470.ga7dc726c21-goog

