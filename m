Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8AD3C7E11
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459023; cv=none; b=LYt3hZbOwD2MC9cHJSRBAtqCbx02G2evYArwAQtdpw43F+tA8P0oM+Bw2yNI7++SkCv2QHM8FpbV9rfOtd57qHTlbsCbysUeqEl/Dk2yFjsUg4fTSaiRNRE8bVpc4d4+lLWW/1Js2AzQfsu82Vgo9MTwfJe89LKFFcNh9pBTqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459023; c=relaxed/simple;
	bh=FPAwh3tMDtLkSZCER6ZjMyy8O4etYqnOFFztkhjmdrw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ChUTTQtX33Q6sDthGLA0ueE7eE3coEC7TAnbiUWzMZvLNw2ESyvLt+jbyj+5A6iEHNjs98+HBvr5vdKQ6pIjxQ4VhDbYAWdS+9qc+Zg5t3ipHDEWlULBT2GeN/Xl9ElfbU3YmD0D0iXvWWKC+JD9a/PGQJEQf/BimDwzAnl9P4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/vMoAOd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/vMoAOd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c1030ca85eso688238eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774459021; x=1775063821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SrBkzZtmjALVxSdK+cHMSnOSQqnK80sDVfD1bwO90gc=;
        b=J/vMoAOd+i3ZuJFmsLof15x6EHOU6HrNeqi1wpf6D90GB8IlbBhxozmIICCRqDhi/h
         YQujI9w4grOWhMbOv0AesVKI1N/tErEdqN0UQiuLFvMLs4OZ82Fs9G/f0LrDA6LdK5Ia
         4Tsa4GIo2y2470A+bkvDbzCO69lSuisV15Cir1SuGsOZGsBgDvKyWY7GE68udXxBNK9W
         u9KTwowLt6dTlb36H03dTEYCKdoaiZOX/gw4qgWvXhzm+fhOmf+htnSCB/G5d8oTb6DX
         KISb125DKDq+97bCd5VGrdPTZ1iEy8jziJ9xgxiUCPDj04M3CHlUN867zQ+myjh85JYu
         K2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774459021; x=1775063821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrBkzZtmjALVxSdK+cHMSnOSQqnK80sDVfD1bwO90gc=;
        b=NoQLKrO/aupazJvVIHX8MF7jjRf8vPZt/7f6Yhrzvp8EH2vcPCcA1rnxY1UUMW5Cec
         p0j+HVcE12OW9NSdLL4W8WBvcIE9bzsUQtL5Ne9dbjQ2cF9JsEjJ8XpTZZSI67t0Bm6+
         Pf3YA+Qg33FWpqxaW85QKwf5nBuH4nYQryb92/rr0F1bcfrf9EUcTG+Iu+JwBL7D7Ptq
         BK+JsOZMxP9qvKmoGucAVA3ifChJjAHBxpW94KQO1lpHRZMIorte5MV2vEyFxdIt+Opw
         DGSekKnofr9CgS3pFdsZ+2Kzevov6w1ow3nrO+48nZBkXG0uwX/VibA/c1sU5DjiK9z3
         I1Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUcZ1lBORDZD1+H/DwGdvMOXWqzlI+I3UKEC4O06FJ9uC0I5YhNwx3RHvAqJABJ1hmklL06jUzNl8kGayl55nls@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjSWfWyYirFMHAOTky06md+sXAp+bUlWletd2uJq1MZroiK3G
	9FRSSyrCPf0FdQl3fywnBp5kGSbcBmlw6kDXfwzwCEId+n1bCAs64Z+q7Qho8i0UxaQUlJBVfqi
	xdAtiimbe3Q==
X-Received: from dlam9-n2.prod.google.com ([2002:a05:701b:2089:20b0:12a:7b92:3d63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:102:b0:121:a01a:8e2f
 with SMTP id a92af1059eb24-12a96f05572mr2314974c88.42.1774459021129; Wed, 25
 Mar 2026 10:17:01 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:16:53 -0700
In-Reply-To: <acOI-3Rtjys7JPyl@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <acOI-3Rtjys7JPyl@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325171653.1091337-1-irogers@google.com>
Subject: [PATCH v2] perf test: Fix perf stat --bpf-counters on hybrid machines
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: acme@kernel.org, adrian.hunter@intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Events on hardware PMUs may open on >1 hardware PMU on hybrid
machines. Unfortunately multiplexing introduces a scaling issue as
reported in:
https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/

Switch to using task-clock which as a software event runs on all CPUs
and has a single PMU.

For when hybrid event scaling is fixed, incorporate support for
combining hybrid counts as posted by Namhyung Kim in:
https://lore.kernel.org/lkml/20260319064513.9269-1-namhyung@kernel.org/

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
v1: https://lore.kernel.org/lkml/20260323202409.194123-1-irogers@google.com/
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 55 ++++++++++++++-------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index f43e28a136d3..f8c24ccc7830 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -5,6 +5,24 @@
 set -e
 
 workload="perf test -w sqrtloop"
+event=task-clock
+
+extract_count()
+{
+	local target_event="$1"
+
+	awk -v target="$target_event" -v i=0 -v c=0 '
+	$0 ~ target {
+		i++;
+		c += $1
+	}
+	END {
+		if (i > 0)
+			printf "%.0f\n", c;
+		else
+			print "<not counted>"
+	}'
+}
 
 # check whether $2 is within +/- 20% of $1
 compare_number()
@@ -25,15 +43,15 @@ compare_number()
 
 check_counts()
 {
-	base_instructions=$1
-	bpf_instructions=$2
+	base_count=$1
+	bpf_count=$2
 
-	if [ "$base_instructions" = "<not" ]; then
-		echo "Skipping: instructions event not counted"
+	if [ "$base_count" = "<not counted>" ]; then
+		echo "Skipping: $event event not counted"
 		exit 2
 	fi
-	if [ "$bpf_instructions" = "<not" ]; then
-		echo "Failed: instructions not counted with --bpf-counters"
+	if [ "$bpf_count" = "<not counted>" ]; then
+		echo "Failed: $event not counted with --bpf-counters"
 		exit 1
 	fi
 }
@@ -41,29 +59,32 @@ check_counts()
 test_bpf_counters()
 {
 	printf "Testing --bpf-counters "
-	base_instructions=$(perf stat --no-big-num -e instructions -- $workload 2>&1 | awk '/instructions/ {print $1}')
-	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | awk '/instructions/ {print $1}')
-	check_counts $base_instructions $bpf_instructions
-	compare_number $base_instructions $bpf_instructions
+	base_count=$(perf stat --no-big-num -e "$event" -- $workload 2>&1 \
+          | extract_count "$event")
+	bpf_count=$(perf stat --no-big-num --bpf-counters -e "$event" -- $workload  2>&1 \
+          | extract_count "$event")
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
+	stat_output=$(perf stat --no-big-num \
+          -e "$event/name=base_$event/,$event/name=bpf_$event/b" -- $workload 2>&1)
+	base_count=$(echo "$stat_output" | extract_count "base_$event")
+	bpf_count=$(echo "$stat_output"|  extract_count "bpf_$event")
+	check_counts "$base_count" "$bpf_count"
+	compare_number "$base_count" "$bpf_count"
 	echo "[Success]"
 }
 
 # skip if --bpf-counters is not supported
-if ! perf stat -e instructions --bpf-counters true > /dev/null 2>&1; then
+if ! perf stat -e "$event" --bpf-counters true > /dev/null 2>&1; then
 	if [ "$1" = "-v" ]; then
 		echo "Skipping: --bpf-counters not supported"
-		perf --no-pager stat -e instructions --bpf-counters true || true
+		perf --no-pager stat -e "$event" --bpf-counters true || true
 	fi
 	exit 2
 fi
-- 
2.53.0.1018.g2bb0e51243-goog

