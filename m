Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A18B36E467
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297455; cv=none; b=Dq2ExM1gRyOACPlBTRtjNiHYt6mIfc7b31LkQ6aupe9BceI83KB/wtkQvKME9CKsgwjI4sEiYUBXFjdojnfABVT4vtWz38JNKx3k5IiAnVgoh7OT/7paz3okF31FEdH/dfVWlSxJB5AdsI5e9CEkHQiRw7nERAbZWsblUhE+EJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297455; c=relaxed/simple;
	bh=X8gFJpfagRDCL4PplhNHhmcJxYbTuG4VUhA+lAQFQdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YKR/Eren9KvNS2IHiL2rpzb/b1UfuGoThHjNEgJbgGR6YByPN5r++or9ey3xmJJn3omhyuSsdG+RXk8OQuH2UEm98PZXn7l5C7MbB42lxZCvaNdL5DVkrjisu130Za31t1G2xBJ0ZznRU9yVoc99zxQwNpSJlrC45IaVZr3AIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2xANuM/; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2xANuM/"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128edc72e5bso6377001c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774297453; x=1774902253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLDd1xOv31Pm+FHVm56FRbOcRw38zRd0ih5wpwcouGs=;
        b=M2xANuM/lhThL+CMhliN7wAOcQ1KiUwsiYs0BdZoEfGdYlX6Y3JulhK+ibExRYMUh7
         IldQ72g9TIvq6eLduZpLTwFWmxT3fR3thGQFHMPHwBNet+Be77/bmN08a1pdOmPN14Ws
         nO58vBv4NTQ1djnpJBs0GChz6pgvNjjW1sXZiRP4fu9pCp5K9mRg+OWRldlx63yfltO0
         HOC6cJsB28if46FcNqnNFtw0VQ4sNZ8tsgWAGHbBI7mWlWmN8cJ7d0RERke5VbzL9qUF
         kpTQjcHsM58qeAHzhLGbXGsYlcPhc4TmPI5gKsXCyE4DypGkWfRwAvJPac2xZ61LROa2
         YAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297453; x=1774902253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLDd1xOv31Pm+FHVm56FRbOcRw38zRd0ih5wpwcouGs=;
        b=c5jdGfKvph4qry23FlEY8Gegn7BsIriDs5s3nIn1m7dZe2GXEQa8HazCaPp/UnoBm3
         qqnv5aXTXhQcfnXDuNQPiD+b2alGSreA4Ni4hf1QEyehgQ6dkhnW98Wc1Yf+KKBlEWu5
         XZru1kkveOecjy6eDl35UHg5TqxZqh91qbuY0VtPtV48/C37Fp0YZFVE1gHaznokx5gT
         T8DcEmcnIdugSq5FspCBrGquYznC28wMu+d5sPLPpph2wmAufQAdll1clY1e/aG9bCJb
         X3FzCQTCz9eCliWWJR1PC9A3+raW7gIG+VCi+K5xuTGRr2XRXw8D6tb93CjNlr4koZ8X
         YrpA==
X-Forwarded-Encrypted: i=1; AJvYcCWLETtSAAy4la+opMjAeZQTgLRC35lKfHn10aBTVg34+63vDXSgJtSp7uoZMV+Qv2Bxp8hA5Ds5YGNa+jEBtlvN@vger.kernel.org
X-Gm-Message-State: AOJu0YycJ+Q36w6sRjUGvN1HfYzRBdrPMRBmH/yJMgPquelM8D2QNzsv
	ykyau29cu0Shln7ZxTfeyGeF+u7SQj3WlDkiDDgWmGLHtRtszwr8A8OOhbwJ+E9JKLLcteQLzYe
	qtt3dJEQ0oQ==
X-Received: from dlec14-n2.prod.google.com ([2002:a05:701b:428e:20b0:128:dcb1:bc27])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:c95:b0:12a:7f25:44ed
 with SMTP id a92af1059eb24-12a7f2546bfmr2495819c88.40.1774297452921; Mon, 23
 Mar 2026 13:24:12 -0700 (PDT)
Date: Mon, 23 Mar 2026 13:24:09 -0700
In-Reply-To: <CAP-5=fW5Cx-a0hm_PKNLDSmo=L0xu=LizKiAPyJF1YtH-coFdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fW5Cx-a0hm_PKNLDSmo=L0xu=LizKiAPyJF1YtH-coFdg@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260323202409.194123-1-irogers@google.com>
Subject: [RFC PATCH v1] perf test: Fix perf stat --bpf-counters on hybrid machines
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@kernel.org, namhyung@kernel.org, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Events on hardware PMUs may open on >1 hardware PMU on hybrid
machines. Unfortunately multiplexing introduces a scaling issue as
reported in:
https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/

Switch to using task-clock which as a software event runs on all CPUs
and has a single PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 35 +++++++++++----------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index f43e28a136d3..58f7dc9692ac 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -5,6 +5,7 @@
 set -e
 
 workload="perf test -w sqrtloop"
+event=task-clock
 
 # check whether $2 is within +/- 20% of $1
 compare_number()
@@ -25,15 +26,15 @@ compare_number()
 
 check_counts()
 {
-	base_instructions=$1
-	bpf_instructions=$2
+	base_count=$(echo "$1"|sed -e 's/[^0-9]*\([0-9]*\).*/\1/')
+	bpf_count=$(echo "$2"|sed -e 's/[^0-9]*\([0-9]*\).*/\1/')
 
-	if [ "$base_instructions" = "<not" ]; then
-		echo "Skipping: instructions event not counted"
+	if [ "$base_count" = "<not" ]; then
+		echo "Skipping: $event event not counted"
 		exit 2
 	fi
-	if [ "$bpf_instructions" = "<not" ]; then
-		echo "Failed: instructions not counted with --bpf-counters"
+	if [ "$bpf_count" = "<not" ]; then
+		echo "Failed: $event not counted with --bpf-counters"
 		exit 1
 	fi
 }
@@ -41,29 +42,29 @@ check_counts()
 test_bpf_counters()
 {
 	printf "Testing --bpf-counters "
-	base_instructions=$(perf stat --no-big-num -e instructions -- $workload 2>&1 | awk '/instructions/ {print $1}')
-	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | awk '/instructions/ {print $1}')
-	check_counts $base_instructions $bpf_instructions
-	compare_number $base_instructions $bpf_instructions
+	base_count=$(perf stat --no-big-num -e "$event" -- $workload 2>&1 | awk "/$event/ {print \$1}")
+	bpf_count=$(perf stat --no-big-num --bpf-counters -e "$event" -- $workload  2>&1 | awk "/$event/ {print \$1}")
+	check_counts "$base_count" "$bpf_count"
+	compare_number "$base_count" "$bpf_count"
 	echo "[Success]"
 }
 
 test_bpf_modifier()
 {
 	printf "Testing bpf event modifier "
-	stat_output=$(perf stat --no-big-num -e instructions/name=base_instructions/,instructions/name=bpf_instructions/b -- $workload 2>&1)
-	base_instructions=$(echo "$stat_output"| awk '/base_instructions/ {print $1}')
-	bpf_instructions=$(echo "$stat_output"| awk '/bpf_instructions/ {print $1}')
-	check_counts $base_instructions $bpf_instructions
-	compare_number $base_instructions $bpf_instructions
+	stat_output=$(perf stat --no-big-num -e "$event/name=base_$event/,$event/name=bpf_$event/b" -- $workload 2>&1)
+	base_count=$(echo "$stat_output"| awk "/base_$event/ {print \$1}")
+	bpf_count=$(echo "$stat_output"| awk "/bpf_$event/ {print \$1}")
+	check_counts "$base_count" "$bpf_count"
+	compare_number "$base_count" "$bpf_count"
 	echo "[Success]"
 }
 
 # skip if --bpf-counters is not supported
-if ! perf stat -e instructions --bpf-counters true > /dev/null 2>&1; then
+if ! perf stat -e $event --bpf-counters true > /dev/null 2>&1; then
 	if [ "$1" = "-v" ]; then
 		echo "Skipping: --bpf-counters not supported"
-		perf --no-pager stat -e instructions --bpf-counters true || true
+		perf --no-pager stat -e $event --bpf-counters true || true
 	fi
 	exit 2
 fi
-- 
2.53.0.1018.g2bb0e51243-goog

