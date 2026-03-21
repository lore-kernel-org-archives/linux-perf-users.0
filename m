Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631F36EAB0
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073699; cv=none; b=E4xfZh5KFsFvPldDcfYBoJ0kWLJa7kVqhFUvE1LD1xEeUlUVg8wG8VMAewVjGdSEHUcF7EP7ENRQ12o4fMyrTNjOeHtgpWO+91twsHZEDYd/i8ASRl4S5X4n90fsgf2BhiyP7O7uMy+4BDvVqrTN1I3U/zwbOFblhzWLGN/Y7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073699; c=relaxed/simple;
	bh=RaVBhRwD/TXOFi3vjdfMkXMF7yO5ilaxhU/GUdD89vo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=g1oIGi/6u4O0cVRCzdu5bqIzAdDfyAPy6eblFA+XZ3B52DpiT8OCdPXUYyh0ZsJuJ5hQJN9cx+qx7qzKariiNN34AGnCHOdkdmQQVG//kN4HpOMTWeESWanJasrvFofAG2mUQqoQ2dm9KYfM6iAIQEofUhC9KLltX4Xo8l7iywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tL6iefNm; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tL6iefNm"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12776bebeb3so48993386c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774073696; x=1774678496; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3aUi2AhNT7jHBIGjkzfrKcmaX2J03AlRffrZ+lkaYXk=;
        b=tL6iefNmIhmMHT9SmT063GLqqmr5h1q1RG9K9/1pXXW851lsc4BVrh5UehNwXndoWp
         vGyn+6wnjX9r1nFMvKnH1Nv2RXoOQkpqby2n5q7Wd0mV2kIGbXdCyLCcr83N8jarjgfG
         Fh9w/RWPEpwEDewlsb6XsnK08epr99zSMBhrhWpg4o0FmeFMZjVVjwQq6ltbEzEaGY5W
         rDSKnuA+D1lsX3lOMzPo7+2fWkpsS8ayTUKvtHW2aiOpIUZOkkZ5voCeeokXxJ66RsP+
         NodhroMnCRl24aqOE8/pKs7hHCNTx5dPeCfnMduKkMyRVkvsU168TzZAPzLqjG+396Ub
         KrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774073696; x=1774678496;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aUi2AhNT7jHBIGjkzfrKcmaX2J03AlRffrZ+lkaYXk=;
        b=Lnf4c6Rh/RJaFqtc/7t4Ecbou6HrtIHjK76L8ycCmZyFQhMbhuH0sG3GLM96yLLTvD
         3vXxfAQ9TMrhQoS2Loby4MoKicB45fU8zrhTCJrDtKL+PQYHKI8Tu9Xcfqr2onvkLqjo
         v3aNDD2UCPRK5GEEOT8g4R01o6S8fAIZjyjDl0fGI/PUaELsD9mLHNzN4za4p/+vtmTR
         mR2YOmTdnGnHFbjHiL+6TWZ3eLPubrgNB/QLUnoDUufUk2nZaih+pECk480boxtrHz9G
         dS2L1sP24/YxuprqbuEjt3TzYa3cjS7fFZluTcunDP8GaGvxWc3rliZMoIvYW4erj7V/
         BMAw==
X-Forwarded-Encrypted: i=1; AJvYcCW75B/OVkaluY+CSlFpJn5lkjQJdZKSbNtmv9LXYqYHzCWI3A8JgfTQWXqh4rOgx26ApN8IwqMY9LhqMjV/e4GB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb2OjYvBtfoSP61hlHKUZlA3DayWdjMD95t4V2Hje73DNx9rTx
	nIS+qUPWg6gdMq/HHAlLOvHMzS6ap2FmUWeWxZ8wIHEWvij5iGX7iyCJoG50b2JihEIqLnkukSa
	p56M/We/WGw==
X-Received: from dlai17.prod.google.com ([2002:a05:701b:2711:b0:128:e1c4:18c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4a1:b0:12a:6a64:8212
 with SMTP id a92af1059eb24-12a72648524mr2790183c88.4.1774073695747; Fri, 20
 Mar 2026 23:14:55 -0700 (PDT)
Date: Fri, 20 Mar 2026 23:14:48 -0700
In-Reply-To: <20260321061448.810525-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260321061448.810525-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260321061448.810525-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf tests sched stats: Write output to temp file
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Writing to the perf.data file can fail in various contexts such as
continual test. Other tests write to a mktemp-ed file, make the "perf
sched stats tests" follow this convention.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/perf_sched_stats.sh | 37 ++++++++++++++++------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/perf_sched_stats.sh b/tools/perf/tests/shell/perf_sched_stats.sh
index 2b1410b050d0..bef7714ef37a 100755
--- a/tools/perf/tests/shell/perf_sched_stats.sh
+++ b/tools/perf/tests/shell/perf_sched_stats.sh
@@ -4,10 +4,29 @@
 
 set -e
 
+perfdata=$(mktemp /tmp/__perf_test_sched_stats.perf.data.XXXXX)
+perfdata2=$(mktemp /tmp/__perf_test_sched_stats.perf.data.XXXXX)
+
+cleanup() {
+  rm -f "${perfdata}"
+  rm -f "${perfdata}".old
+  rm -f "${perfdata2}"
+  rm -f "${perfdata2}".old
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
 err=0
 test_perf_sched_stats_record() {
   echo "Basic perf sched stats record test"
-  if ! perf sched stats record true 2>&1 | \
+  if ! perf sched stats record -o "${perfdata}" true 2>&1 | \
     grep -E -q "[ perf sched stats: Wrote samples to perf.data ]"
   then
     echo "Basic perf sched stats record test [Failed]"
@@ -19,15 +38,13 @@ test_perf_sched_stats_record() {
 
 test_perf_sched_stats_report() {
   echo "Basic perf sched stats report test"
-  perf sched stats record true > /dev/null
-  if ! perf sched stats report 2>&1 | grep -E -q "Description"
+  perf sched stats record -o "${perfdata}" true > /dev/null
+  if ! perf sched stats report -i "${perfdata}" 2>&1 | grep -E -q "Description"
   then
     echo "Basic perf sched stats report test [Failed]"
     err=1
-    rm perf.data
     return
   fi
-  rm perf.data
   echo "Basic perf sched stats report test [Success]"
 }
 
@@ -44,16 +61,14 @@ test_perf_sched_stats_live() {
 
 test_perf_sched_stats_diff() {
   echo "Basic perf sched stats diff test"
-  perf sched stats record true > /dev/null
-  perf sched stats record true > /dev/null
-  if ! perf sched stats diff > /dev/null
+  perf sched stats record -o "${perfdata}" true > /dev/null
+  perf sched stats record -o "${perfdata2}" true > /dev/null
+  if ! perf sched stats diff "${perfdata}" "${perfdata2}" > /dev/null
   then
     echo "Basic perf sched stats diff test [Failed]"
     err=1
-    rm perf.data.old perf.data
     return
   fi
-  rm perf.data.old perf.data
   echo "Basic perf sched stats diff test [Success]"
 }
 
@@ -61,4 +76,6 @@ test_perf_sched_stats_record
 test_perf_sched_stats_report
 test_perf_sched_stats_live
 test_perf_sched_stats_diff
+
+cleanup
 exit $err
-- 
2.53.0.959.g497ff81fa9-goog

