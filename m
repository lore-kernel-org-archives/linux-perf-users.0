Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7292388E61
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573291; cv=none; b=bt1bOn+9rwPOjJu6kUYRO1mjzJHR9F/66OWB/l/qTC075pkin36MHcCtA/0PlkciqEfpB2TATOUqaUENe7JiGgUH+gn4VmQ5N+NY6A1GGJsRp7mxFIlaST0PiNmLF5OhAY82B5TMfMVvAG327yJGoQbybLZqHI4DYf43005HNlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573291; c=relaxed/simple;
	bh=TR2yC+sykqOaFMdLMpJra92odOUiI6zeEMJ3i13of5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=upck0esH3zFIvXZO5dDtfjIWflObiYV4aeSZxLDSXHtqjdxQ5Sf3UAuuKpRC3uplOy8UTlZj7YtFtL8FXFjJK7QOawXW/Cpat2YLbsa58ZH63GqH2ge3sXiXEf0mvYPf8dVsARYh9q1DG6fhn/T+mgh42F19kNogWpXS4F0a6JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hsp/yftO; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsp/yftO"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30761ab3483so866682eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573290; x=1782178090; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVWp3mpr9dgI9fxZTkmex4IA3oadZ8edc8eMOFveGow=;
        b=hsp/yftOCXWS6w+4KcIlWJtQZ0HkvtVQAlfAprnwp/q+wQMic9lpB0uhD53ulecLon
         qQDWl8kGHH+v2Pt96P0TpJtvC5AKuMnghGa+4EyAd9cUfY3mzVoVuVDh/eKKLqhUs35n
         aximx1GRoyoUE15I3syJbixPk7qtGmRPLIMoklqeo/Rel+udKR9XJcrIUqpiaASgMXJz
         5bBN6uksDLTD1DgXswTUa/GCAN/Tn1xW/vdEHkt0JJ503HeJoCMZ9q8IaB5Gydtx8jko
         wZ5+vITHaQI9y/65Gkd3GbGhtkIWO5WnJMgKkYdORxtws2qTqKAP1K7OgscX9Oeve2+u
         vZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573290; x=1782178090;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVWp3mpr9dgI9fxZTkmex4IA3oadZ8edc8eMOFveGow=;
        b=LaE7QRWiR+/glgZmtLrSIyGyY4BSbtrCLYeUa8brnTYQU8ES6Q4tbxRdzo3e5n+nHl
         X+tgAy3bqVp16sVzAU4lzGmy0ybnkNuBwkP29i2HwEdkqf1HumGcFoKgxuLUI2cXjjlc
         9dJgrnyWyoWLJaBQMZIQiGJXtH8kyurdplQYLL7McuAnv/eeOWeuNNrORIoB/N79Jh+I
         EtDbZCnCjIsrEYooGyxhs2zBxBK51KeYL1Pdj/FfSQ7Wcj5njsiDGnXeBsKSttx5bTz/
         aqtY6532Prbv6ysThHsQgWxQ2ocyvlZXDueLM+4dlduA3lJNoG+Nb0NEvTMnv7m7xbMt
         FdWg==
X-Forwarded-Encrypted: i=1; AFNElJ8Ze7qggOC4R/sgd73/1m8uLZvg6mzpzspHAGXEdXa2aalx4OLbjxbTSacQfoE8JOcFAapwq2sZGE0hB6J6qq5X@vger.kernel.org
X-Gm-Message-State: AOJu0YwGPkPasxUfvzc/rWOK/XYDkI7jR1J/+6MK58qMGsOBsbTPAeh2
	MjwKHGLtY4by1PmGPUEnYsyLsEPh4dyreT7RRfPdfxGoAI198dZInJuvVTEfrdriqqbGqbUg7Nk
	ct+Nley+vkg==
X-Received: from dybmk48.prod.google.com ([2002:a05:7301:eb0:b0:304:eb73:cff1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:231d:b0:2e7:c701:aa85
 with SMTP id 5a478bee46e88-30ba5f65687mr1065795eec.17.1781573289497; Mon, 15
 Jun 2026 18:28:09 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:42 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-11-irogers@google.com>
Subject: [PATCH v1 10/12] perf tests: Speed up off-cpu profiling tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The off-cpu profiling test suite runs multiple recording commands with
a default workload of `sleep 1` to test the off-cpu threshold configurations
(specifically, above 999ms and below 1200ms). This adds a mandatory 3.0
seconds of sleep overhead.

Optimize this by scaling down the thresholds and workload durations by a
factor of 10:
- Use `sleep 0.1` as the workload duration.
- Change the above-threshold test to use `--off-cpu-thresh 99` and `sleep 0.1`.
- Change the below-threshold test to use `--off-cpu-thresh 120` and `sleep 0.1`.
- Update the awk period check in the above-threshold test to look for a period greater than 99,000,000 ns (99ms) instead of 999,000,000 ns (999ms).

This reduces raw test sleep overhead from 3.0s down to 0.3s, yielding a
~2.7 second speedup for this test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 860a2d6f4b75..39319437b8f9 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -45,7 +45,7 @@ test_offcpu_priv() {
 test_offcpu_basic() {
   echo "Basic off-cpu test"
 
-  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/null
+  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 0.1 2> /dev/null
   then
     echo "Basic off-cpu test [Failed record]"
     err=1
@@ -98,8 +98,8 @@ test_offcpu_child() {
 test_offcpu_above_thresh() {
   echo "${test_above_thresh}"
 
-  # collect direct off-cpu samples for tasks blocked for more than 999ms
-  if ! perf record -e dummy --off-cpu --off-cpu-thresh 999 -o ${perfdata} -- sleep 1 2> /dev/null
+  # collect direct off-cpu samples for tasks blocked for more than 99ms
+  if ! perf record -e dummy --off-cpu --off-cpu-thresh 99 -o ${perfdata} -- sleep 0.1 2> /dev/null
   then
     echo "${test_above_thresh} [Failed record]"
     err=1
@@ -115,7 +115,7 @@ test_offcpu_above_thresh() {
   fi
   # there should only be one direct sample, and its period should be higher than off-cpu-thresh
   if ! perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F period | \
-       awk '{ if (int($1) > 999000000) exit 0; else exit 1; }'
+       awk '{ if (int($1) > 99000000) exit 0; else exit 1; }'
   then
     echo "${test_above_thresh} [Failed off-cpu time too short]"
     err=1
@@ -128,8 +128,8 @@ test_offcpu_above_thresh() {
 test_offcpu_below_thresh() {
   echo "${test_below_thresh}"
 
-  # collect direct off-cpu samples for tasks blocked for more than 1.2s
-  if ! perf record -e dummy --off-cpu --off-cpu-thresh 1200 -o ${perfdata} -- sleep 1 2> /dev/null
+  # collect direct off-cpu samples for tasks blocked for more than 120ms
+  if ! perf record -e dummy --off-cpu --off-cpu-thresh 120 -o ${perfdata} -- sleep 0.1 2> /dev/null
   then
     echo "${test_below_thresh} [Failed record]"
     err=1
-- 
2.54.0.1136.gdb2ca164c4-goog

