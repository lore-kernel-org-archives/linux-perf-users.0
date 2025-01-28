Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CD94C8E
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 04:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738039080; cv=none; b=binT9zeL0Dv17FUsiuRDsNvXN85p13BJutbAU4G28oKnyaNhIoazRcBdRIuP6wYVEUr/EQYOr1pgWNQ5waoPNTQcgyIAMjfEsnaAL7WoxSMdsnkTUgt8PbddHauIKOhlkgcwpsDt65tr80DL3xY6d//8wxcO/5R0FcWBPGaWKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738039080; c=relaxed/simple;
	bh=RXkm8/CBiETLLKlDEygxtOcVPiIRsx0Laqc6OH4KyyE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=G+ImFiwEMy9eRz71i2RO9r9qerx2bXAf588PAD51D5er1IXsLthNnw54gE+kLrPBVGOYkrbt7BOh8R9UjWlc10YdTL+KA6sPFUWSeBvVJUMDs/Dp4eNL0669cAWCD/rWpsq4qvPdzdDlHM3cBgfIiQMNJmYnG5MY9M/XcBQa0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TrqT4PHf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrqT4PHf"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e572cd106f7so13181513276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 20:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738039078; x=1738643878; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IAZZQEeERPxR9fF5OUC/u0sdru3uMlWZB2AQi6BmOGw=;
        b=TrqT4PHfWM5o2pACW0rZvneOHQqM/ySF8ok4RztaN3hB9/uVYwcA0cIkf7taLhwDTI
         P+ngFggPiVDESCxG2ECbdQzvAJbZjPwO4Tzzc+Kcynp4o3wuloro1aJZP9NbBC0cKWX4
         Bt7OFHkngLxSIfgnClLpb/eY5qM+LUy7G0RxUo0XNeHh2JdHCe0v4vGeNUiEEcSINepz
         F9XEwVKp4YDaktzBCFGOPdLaummDtY02JNgVeKXPwbrqzDiAxZSJpGl0YzqgN1aRY+7b
         Kku4mrEP6qyBXhHEYaoFaH/3adGGl/W+px3MwGahEp8HcLN4Jm9KaJs+gV2LYwl/4IVx
         bWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738039078; x=1738643878;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAZZQEeERPxR9fF5OUC/u0sdru3uMlWZB2AQi6BmOGw=;
        b=jaOspzrco8n6vJGCtexvmCzj0rR3aAOX3YIwhfcZqvrFVgII6ul2VopqBYb89vM11n
         PX8Rd2MuASbio0DYYEqhE1vvEPEsolGzx+fiRqpfVGUpfW2CqyBXFM2JO2y6MD1XkOqg
         7tZYb/zOMB8JlTjEY9yqK6xyT+L9ClGGhiYzo16RDwb1S/Wgk8Vc2bmfD/w/zl3VITRW
         YVnv7++2HhQl/GQQePFhnY6cPx/+s+UYU96TjhiBzeCaAEor9CBgwvUFkqNYO/SqL4Kl
         ewriTH/s25JStPLukVNQAc1lWb5dxSkL0CCm1f6RJlpKE2KnOWg3W0bM8RJZJPqOPHwB
         JIwg==
X-Forwarded-Encrypted: i=1; AJvYcCXvnAmWeYqLd7Xns6s+gavN2CAT+bgzH3cgHr6vWA2yunxJWn4oC0zdYpVCwaumNolufSN7ESzccC3nGi8KFA9k@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAW7Tt8gPYsHYzCoHAtyxf7AvRVKUgW23tUFcib+Qnbip1XyF
	sTZ+I+MPQvJt0+GU2kk/cTkUcAisnVuC03wS5Yqkl53uk/8EaMIT1yt9oMyVEO45SwUWzFrHmbd
	1SNg32A==
X-Google-Smtp-Source: AGHT+IFm2nE0moPwnKm0+CpY1o4uTKWLwhVekmcD2YAVOHIT8V25GLGdN5U24VMCJMM5MPCgFo2eIBQulPga
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2b71:c18d:89c2:8713])
 (user=irogers job=sendgmr) by 2002:a25:aab3:0:b0:e57:f577:5564 with SMTP id
 3f1490d57ef6-e57f57756dbmr60744276.8.1738039077772; Mon, 27 Jan 2025 20:37:57
 -0800 (PST)
Date: Mon, 27 Jan 2025 20:37:39 -0800
Message-Id: <20250128043739.256305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v2] perf test: Skip Intel TPEBS under hypervisor
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
v2: Fix lost :R and use :p with record as it is ignored by perf stat.
---
 .../perf/tests/shell/test_stat_intel_tpebs.sh | 36 +++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
index 695dcb93bb5e..a330ecdb7ba5 100755
--- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -20,31 +20,39 @@ then
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
+if ! perf record -e "${event}:p" -a -o /dev/null sleep 0.01 > "${stat_output}" 2>&1
+then
+  echo "Missing ${event} support"
+  cleanup
+  exit 2
+fi
 
 test_with_record_tpebs() {
   echo "Testing with --record-tpebs"
-  result=$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
+  if ! perf stat -e "${event}:R" --record-tpebs -a sleep 0.01 > "${stat_output}" 2>&1
+  then
+    echo "Testing with --record-tpebs [Failed perf stat]"
+    cat "${stat_output}"
+    exit 1
+  fi
 
   # Expected output:
   # $ perf stat --record-tpebs -e cache-misses:R -a sleep 0.01
@@ -57,16 +65,16 @@ test_with_record_tpebs() {
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

