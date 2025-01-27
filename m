Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C71A8404
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738012665; cv=none; b=hPp7f6gp4D9xeMF/Fl8HS/TBrGuBy+y/Lgt8BadKe+JgJ9lYwTQPE0EOufDt7qLUxITIhdKaSCg4lk2nVYtBJF/yZHAByJmtq1XWdt5aKtiGUtU4lRq0RunJOxaap2gi9PG30Jw4alxvIratj71lZM2nsRQHPR/Gp4ER1qoEpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738012665; c=relaxed/simple;
	bh=/BUu3mEM3rCKji5mZxUeA/2/5w1poUKM7wvA/jnX+ao=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=kuZ6LcdfnsvhXqJlYQ0ZWhSI1DsISc9+fJr9KdI1uJNbOFgTZr+bjhQ4NwQGXmDCzRxp/vy77Ey+HnuAHuzBIfgngraDumKwl1HbiKcGnVOPhgrYh8GckWhV9mPFAukjraCGGqsA/aWZ7J9zdFJ95tZvcIjNqBA3YfBPtWGW3/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SrhJ7eiu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrhJ7eiu"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3c61a11a40so13681435276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738012663; x=1738617463; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bP3LjJM2yqm7ZF1bzjxMchIFOPBg28Ep2NfICJoxEig=;
        b=SrhJ7eiuYWCO5+NlEPHJBPmlsvyrBq0CP2rJpzuMGP64OlFh9KRzRUruVoqK6ObCKq
         f//Lp13oRzWJ9e0GVOdOyk1GZILp7wmRcRsrPqjgKDebOJIe6q6i65hsYOKAYIcm+KkZ
         Pc/4lmFOpbTLz10DzDvDnKY/pvzD0VWJ6w52N0BVJCvKBIq5hMywl2X1mMUScN5mcHgu
         4+nBLTwPOtYbc29uBXnMl0cvNEkjpsggtFeHQz+wuBguth/6fkLm0qDfsOqz/GLWoA9n
         Vrph3K2Moulrn77NJE6LEBojY6iO/C2P6iYMOZL5cdAIz9KfnfOMbWgQh2CT0nt5CbvB
         9s6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738012663; x=1738617463;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bP3LjJM2yqm7ZF1bzjxMchIFOPBg28Ep2NfICJoxEig=;
        b=BZYU1XEMfby7qd/NoObQSH+5WaRt20scAE5JhXOukeOgtjGdi13LYrHiJhKcO36Kqr
         Lp9feiNgcIXmiPjnmVBbmur+eJ6/TTJxgYtBA8u/1GxAz1MuGGKuC9mYdNllizTDqQlA
         H4YDzqfdM2CgTQ8DI2aarRRex3V+hMUTFmlOkJKwVk4TcFA2VDeSh7ZI50lECI8LHida
         OsRM1kP81hxlmZi8lL06OYEzhhFraqQVll5vAOdFWEJULcSwKGZCRu3f4fzt8bzPWOP1
         SWwWancOi3hIYAA4kR+uvYAzlS51A+xY6EgfCdZcUAAnER450goprtB5ag9U/QYZLBez
         7hxg==
X-Forwarded-Encrypted: i=1; AJvYcCVRBbxXkUGneYmf1G/V2acSGa4eIt/TRHmkOLpopUKu3UD6HlYg8SdJL9MdV4Lju+u1gb+XVqkXzr2Kg8zwftcJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyhsuAdbUDVD+0jqtO+yJt3K5IJUSyHRlYlymBvxcwvFMFdbdJY
	m3NlApJIrBADaXM2Byasmodj0mQdcw/iKp0Bfm2UX7Ybirv4/S4TESNf5+guyj1ESxxIpEj9dFg
	RV8VJ0w==
X-Google-Smtp-Source: AGHT+IFLyWZwAHPDf3bUMlxmeXS5Vi2qWI6NmUZnoCT3gdOdbk12QZL0AWwKmFqrPa3VVAeJiyPjXHBXSNKy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8343:7b31:63b1:a4be])
 (user=irogers job=sendgmr) by 2002:a25:aab3:0:b0:e57:f577:5564 with SMTP id
 3f1490d57ef6-e57f57756dbmr58057276.8.1738012662727; Mon, 27 Jan 2025 13:17:42
 -0800 (PST)
Date: Mon, 27 Jan 2025 13:17:37 -0800
Message-Id: <20250127211737.179059-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v1] perf test: Skip Intel TPEBS under hypervisor
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Intel TPEBS test skips on non-Intel CPUs. On Intel CPUs under a
hypervisor the cache-misses event may not be present. Skip the test
under this condition.

Refactor the output code to be placed in a file so that on a signal
the file can be dumped. This was necessary to catch the issue above as
the failing perf record command would fail without output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/tests/shell/test_stat_intel_tpebs.sh | 35 +++++++++++--------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
index 695dcb93bb5e..1b61b219cd2f 100755
--- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -20,31 +20,38 @@ then
   exit 2
 fi
 
+stat_output=$(mktemp /tmp/__perf_stat_tpebs_output.XXXXX)
+
 cleanup() {
+  rm -rf "${stat_output}"
   trap - EXIT TERM INT
 }
 
 trap_cleanup() {
   echo "Unexpected signal in ${FUNCNAME[1]}"
+  cat "${stat_output}"
   cleanup
   exit 1
 }
 trap trap_cleanup EXIT TERM INT
 
-# Use this event for testing because it should exist in all platforms
-event=cache-misses:R
-
-# Hybrid platforms output like "cpu_atom/cache-misses/R", rather than as above
-alt_name=/cache-misses/R
+# Event to be used in tests
+event=cache-misses
 
-# Without this cmd option, default value or zero is returned
-#echo "Testing without --record-tpebs"
-#result=$(perf stat -e "$event" true 2>&1)
-#[[ "$result" =~ $event || "$result" =~ $alt_name ]] || exit 1
+if ! perf stat  -e "${event}:p" --record-tpebs -a sleep 0.01
+then
+  echo "Missing ${event} support"
+  exit 2
+fi
 
 test_with_record_tpebs() {
   echo "Testing with --record-tpebs"
-  result=$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
+  if ! perf stat -e "${event}" --record-tpebs -a sleep 0.01 > "${stat_output}" 2>&1
+  then
+    echo "Testing with --record-tpebs [Failed perf stat]"
+    cat "${stat_output}"
+    exit 1
+  fi
 
   # Expected output:
   # $ perf stat --record-tpebs -e cache-misses:R -a sleep 0.01
@@ -57,16 +64,16 @@ test_with_record_tpebs() {
   #                  0      cache-misses:R
   #
   #        0.013963299 seconds time elapsed
-  if [[ ! "$result" =~ "perf record" ]]
+  if ! grep "perf record" "${stat_output}"
   then
     echo "Testing with --record-tpebs [Failed missing perf record]"
-    echo "$result"
+    cat "${stat_output}"
     exit 1
   fi
-  if [[ ! "$result" =~ $event && ! "$result" =~ $alt_name ]]
+  if ! grep "${event}:R" "${stat_output}" && ! grep "/${event}/R" "${stat_output}"
   then
     echo "Testing with --record-tpebs [Failed missing event name]"
-    echo "$result"
+    cat "${stat_output}"
     exit 1
   fi
   echo "Testing with --record-tpebs [Success]"
-- 
2.48.1.262.g85cc9f2d1e-goog

