Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46247DF80
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628529; cv=none; b=Dzpj9PUDiSxPZvRb9xs4xeN3oWX3Q+ZIB15DeLRWtPBRqto4e0gKnnJkMUZwpFy+jXCHoQtEplFudUoThHXYhk9FszGIhuHMQ/9I3iXKP/7YL8aMnl37lPT9buHSyxZc6Y04CUW8+cxl7h40ExzL+jDsyaXzxsx6HRocKt49K9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628529; c=relaxed/simple;
	bh=vqxcmi9vvO4LO6iPNOD5818LRq+ytBVIGTBUn9ECP80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hky2LLyNVMXlOVqj1KpTmz4hBKvaxPgP3Tt/U+BPQVXB/AugrcYG0+dIMuc5dgsIxYU/ZaHZMLVZCtTSzcwADMzgqgrIfTeYOWfm728AU/okx+dxELHCTbyFUHHBMqRJSqZAp8D3bM3a1S1+OYxnssIZRY/SHCY8ETwmzQD4b0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VeMFMnLu; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VeMFMnLu"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-307fe856724so2663158eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628527; x=1782233327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HP80kLCTGZ1cb+i+XxqTv8yRiuay3NrASGY3ZfDBtEo=;
        b=VeMFMnLui8JK7bc7bZAFaF9xEsKcQSiuEqSMKTABF5V5bkGv8zV7dq10abYOogsB1s
         wuXEEWK7EzGGTWIFy4fUEshu6QlqBYilVKucfIshjCQm343YsLgHUJIwlPxRMFc+Ht9B
         KMJdCgIayXcDK7Jg2iIZfqO1Inpb0eSr3nU6JYN7dStDN4lcZiQuev7E4AW6SCYmqk03
         tyW5D0ekjkyBPwCvP3imzgQ24u3Cjnz57HbNiyi4qx5A2LzEfilaQ0Hr7wnEJtHuFRrM
         Z4OdFGRZVPF+LtHa+0lGdpU+GwvpRDBUYehvDOtJfQ7lIgu5c7LMficJodKtnpPAptK8
         3QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628527; x=1782233327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HP80kLCTGZ1cb+i+XxqTv8yRiuay3NrASGY3ZfDBtEo=;
        b=D6OT7PNoS5HYnosyGfhtFEMdw9cIGiDbVLtxCFg89c+qb/nZzSP7h2DvEwppKKOf6b
         zXph/tFhZggXQA15mTTv4Xm6NX4fITGTGG0y37Fu9ohBmbkrAAX+F/t7kWhfDb3ub2gr
         Xit5mD7FRaedOKSzunoOD+AVqkwcsVvhD+6Q2KbzY5fRclm3ggz2HjN/hIZMXrLcV967
         x/osZbITWrhaFDay5PbGOoVjeJFcJ2aKQkfv01jfGBb25Lq99aKjyozRzyU7/VrhChxV
         V+PatyTLJdsi25DLSIMzqkUywYYW6FxbSZwIe5YdAHnGi/h/1KIbXRMhN8bVg7WEdvqQ
         HegA==
X-Forwarded-Encrypted: i=1; AFNElJ8nvvV/cgfUpx4LZgfALPOKPIkiBDTwy31x9QkfGJmtV6y6IV5qIVsV4GEGvJKwEsor9a3TKd/zhGSsFpUfVgTX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/QqDvqIb4p6BbijDPKX9+vLT0rGgwU4xsG9NMixvKTLKqylbA
	BONgjMBzP6l80BLkI7Rol3vvka05IT9DWCwXgtUnpdFNpv0XcKjtLdsR8J8k6Pz3jthEZioNOyS
	QjKv4NFHmCw==
X-Received: from dybff20.prod.google.com ([2002:a05:7300:bf14:b0:304:5761:e0e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:10c5:b0:304:fa0d:85ba
 with SMTP id 5a478bee46e88-30bc9cb3ac3mr91623eec.12.1781628525587; Tue, 16
 Jun 2026 09:48:45 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:15 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-11-irogers@google.com>
Subject: [PATCH v3 10/13] perf tests: Speed up off-cpu profiling tests
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The off-cpu profiling test suite runs multiple recording commands with a
default workload of `sleep 1` to test the off-cpu threshold configurations
(specifically, above 999ms and below 1200ms). This adds a mandatory 3.0
seconds of sleep overhead.

Optimize this by scaling down the thresholds and workload durations by a
factor of 10:
- Use `sleep 0.1` as the workload duration.
- Change the above-threshold test to use `--off-cpu-thresh 50` and `sleep
  0.1`.
- Change the below-threshold test to use `--off-cpu-thresh 500` and `sleep
  0.1`.
- Update the awk period check in the above-threshold test to look for a
  period greater than 50,000,000 ns (50ms) instead of 999,000,000 ns
  (999ms).

This reduces raw test sleep overhead from 3.0s down to 0.3s, yielding a
~2.7 second speedup for this test.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 860a2d6f4b75..8ee2112b7778 100755
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
+  # collect direct off-cpu samples for tasks blocked for more than 50ms
+  if ! perf record -e dummy --off-cpu --off-cpu-thresh 50 -o ${perfdata} -- sleep 0.1 2> /dev/null
   then
     echo "${test_above_thresh} [Failed record]"
     err=1
@@ -115,7 +115,7 @@ test_offcpu_above_thresh() {
   fi
   # there should only be one direct sample, and its period should be higher than off-cpu-thresh
   if ! perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F period | \
-       awk '{ if (int($1) > 999000000) exit 0; else exit 1; }'
+       awk '{ if (int($1) > 50000000) exit 0; else exit 1; }'
   then
     echo "${test_above_thresh} [Failed off-cpu time too short]"
     err=1
@@ -128,8 +128,8 @@ test_offcpu_above_thresh() {
 test_offcpu_below_thresh() {
   echo "${test_below_thresh}"
 
-  # collect direct off-cpu samples for tasks blocked for more than 1.2s
-  if ! perf record -e dummy --off-cpu --off-cpu-thresh 1200 -o ${perfdata} -- sleep 1 2> /dev/null
+  # collect direct off-cpu samples for tasks blocked for more than 500ms
+  if ! perf record -e dummy --off-cpu --off-cpu-thresh 500 -o ${perfdata} -- sleep 0.1 2> /dev/null
   then
     echo "${test_below_thresh} [Failed record]"
     err=1
-- 
2.54.0.1189.g8c84645362-goog

