Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124F1E3775
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256502; cv=none; b=BQviziEz0aEo2agQrQChOxJpxBL3EkQrGu2MpPcM25b/ISqFwHluC0YGF8yPTH6li0WQ9bSkpTk07GW/5aA5dHvq+xD9Fb0cBbIxKDURYkK+TRi5woNdOnoefmhFrEr7XaRDL31WMI2aDIYkxBLX0DdM0ij7JV4cNfz9oO9gfwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256502; c=relaxed/simple;
	bh=fT4PBtAjKaVpkQpCI2E8JtbI/2Hel0is+n5sGwSWNng=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=kxTBjyMuVZsphbbhHQn8Gt31G+JMqwmKErHqtx5BaYrJCClqcSzO6Vrpz/sdnkFZQy3Lkk1gYdQz0N3PSX0AeGyMIdq24inRceTtnr8WdkzgiUZwXymeY6sn7b1Xgrb23ttpAb3ZgjXksIeLDaoMEibL4JbVRloHi6w5JtEzjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrsmQdlO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrsmQdlO"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e549b6c54a0so2926315276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 09:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738256499; x=1738861299; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H1ij39aLyh6QslqcEF3GcVzrzeodIqIF5/zrsn0ZYxw=;
        b=VrsmQdlOJoousydi223JjdeIgLY2Pp8ByVMCMkWVFq8iYaQ8F/3Edf6F2AT9f7Lj3w
         8Dy6sych1u22ccAV52B1AyRy3LMinR3lBEmkmWvIckHGz61zQHQ0w5jXPiVmT37tIkXE
         kAY4PCY9il4JSAiza4fmFyTr/BC9dOEM+1LrWl0YFk5ecOfRaVcG6CZ7jzGIWFNtiLbI
         ySE6va8YQTk0YVf+D0LT2+kTVCSEtLAI/dXoh/TOPgxW2HDnnuAbD1u801JF9anaAzv8
         fcRwXtf9S9pJGPaWszt91ZfpdQMFeYhpau8CSUhnbKlm47koDYL3nVF8d5Vf0yJkMGKH
         CZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738256499; x=1738861299;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1ij39aLyh6QslqcEF3GcVzrzeodIqIF5/zrsn0ZYxw=;
        b=SFzJFp2Cl8Qa1VRTvUrGMyEAE+YVZNu/T0J6v3P1y9p1ZupTwKaNlZlqlNsR789Qtt
         TPeDlgp/tcHAJKW/DM9A2R1iOhADM610wAkqFCpf8LOl3gyoc4v4JC9STDwEWjp3y+mb
         Zwda0uHtDQqTYH6kUtbRUxAiTrsvKVn17BGUGgBq0pyq/mb6/rDbo3UfIHWWiqdblXU5
         Fy7IaBA/0XoYaMzsbb2lj/K9OnLyTmdI1zDEa4ibL8toAcbQakVUCZVyTxzRbseTXvgy
         GOttiZQ9DoU+CdW3TM5XJY5Gy0ZtlQ9jrb4wUaMuddY2jEypS40+3gVQIJM3o3M5lPTJ
         LRUA==
X-Forwarded-Encrypted: i=1; AJvYcCXKmr4IxzLu2RBOS+qZJlaELiMCphD9HB8C7MPQ/ow5PG6OjtZeXqsCPNAm9PTAt5ADi7XabJOvwqlpTI7E6RDs@vger.kernel.org
X-Gm-Message-State: AOJu0YzZknXQiZwsXrhzVElHrfnKn4nIM1ra0SVt/lbJuW/q58MXuzsQ
	tH6gnYLWeX6Sgy1WsOuMMna3Y8DE0XWJfwLay22h9kZsRJxzIqmI5ekU/FPENvpS75PC6X2AEd6
	3HQjqrg==
X-Google-Smtp-Source: AGHT+IFF7YRZZC256K1Yo/ihXb2WFOAZtKoly4oRFO8prwmUUH/jbAfKXO2jdK5zgXhAAwx1LsYKK5PXrCza
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:3852:9948:e710:3ffd])
 (user=irogers job=sendgmr) by 2002:a25:3006:0:b0:e5a:ca1d:56da with SMTP id
 3f1490d57ef6-e5aca1d577bmr8436276.9.1738256499240; Thu, 30 Jan 2025 09:01:39
 -0800 (PST)
Date: Thu, 30 Jan 2025 09:01:35 -0800
Message-Id: <20250130170135.5817-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3] perf test shell tpebs: Extra verbosity and hypervisor skip
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

When not running as root and with higher perf event paranoia values
the perf record forked by TPEBS can fail to attach to the process. Skip
the test in these scenarios.

Intel TPEBS test skips on non-Intel CPUs. On Intel CPUs under a
hypervisor the cache-misses event may not be present or precise. Skip
the test under this condition.

Refactor the output code to be placed in a file so that on a signal
the file can be dumped. This was necessary to catch the issue above as
the failing perf record command would fail without output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v3: Add/squash missed patches pointed out by "Falcon, Thomas"
    <thomas.falcon@intel.com>
v2: Fix lost :R and use :p with record as it is ignored by perf stat.
---
 .../perf/tests/shell/test_stat_intel_tpebs.sh | 89 ++++++++++++++++---
 1 file changed, 76 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
index f95fc64bf0a7..a330ecdb7ba5 100755
--- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -3,20 +3,83 @@
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exit 2; }
 
-# Use this event for testing because it should exist in all platforms
-event=cache-misses:R
+ParanoidAndNotRoot() {
+  [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
+}
 
-# Hybrid platforms output like "cpu_atom/cache-misses/R", rather than as above
-alt_name=/cache-misses/R
+if ! grep -q GenuineIntel /proc/cpuinfo
+then
+  echo "Skipping non-Intel"
+  exit 2
+fi
 
-# Without this cmd option, default value or zero is returned
-#echo "Testing without --record-tpebs"
-#result=$(perf stat -e "$event" true 2>&1)
-#[[ "$result" =~ $event || "$result" =~ $alt_name ]] || exit 1
+if ParanoidAndNotRoot 0
+then
+  echo "Skipping paranoid >0 and not root"
+  exit 2
+fi
 
-# In platforms that do not support TPEBS, it should execute without error.
-echo "Testing with --record-tpebs"
-result=$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
-[[ "$result" =~ "perf record" && "$result" =~ $event || "$result" =~ $alt_name ]] || exit 1
+stat_output=$(mktemp /tmp/__perf_stat_tpebs_output.XXXXX)
+
+cleanup() {
+  rm -rf "${stat_output}"
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cat "${stat_output}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+# Event to be used in tests
+event=cache-misses
+
+if ! perf record -e "${event}:p" -a -o /dev/null sleep 0.01 > "${stat_output}" 2>&1
+then
+  echo "Missing ${event} support"
+  cleanup
+  exit 2
+fi
+
+test_with_record_tpebs() {
+  echo "Testing with --record-tpebs"
+  if ! perf stat -e "${event}:R" --record-tpebs -a sleep 0.01 > "${stat_output}" 2>&1
+  then
+    echo "Testing with --record-tpebs [Failed perf stat]"
+    cat "${stat_output}"
+    exit 1
+  fi
+
+  # Expected output:
+  # $ perf stat --record-tpebs -e cache-misses:R -a sleep 0.01
+  # Events enabled
+  # [ perf record: Woken up 2 times to write data ]
+  # [ perf record: Captured and wrote 0.056 MB - ]
+  #
+  #  Performance counter stats for 'system wide':
+  #
+  #                  0      cache-misses:R
+  #
+  #        0.013963299 seconds time elapsed
+  if ! grep "perf record" "${stat_output}"
+  then
+    echo "Testing with --record-tpebs [Failed missing perf record]"
+    cat "${stat_output}"
+    exit 1
+  fi
+  if ! grep "${event}:R" "${stat_output}" && ! grep "/${event}/R" "${stat_output}"
+  then
+    echo "Testing with --record-tpebs [Failed missing event name]"
+    cat "${stat_output}"
+    exit 1
+  fi
+  echo "Testing with --record-tpebs [Success]"
+}
+
+test_with_record_tpebs
+cleanup
+exit 0
-- 
2.48.1.262.g85cc9f2d1e-goog

