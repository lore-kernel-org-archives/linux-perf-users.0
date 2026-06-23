Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A50378D7F
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178112; cv=none; b=Z5h41GKi4wdnGDbF2nWl7WQSZrg4PgZZU7IQJH0oMZUuWXVeq/GXOacCmKASW3zRjxzORED+YoNjDJ84GowhbEK/ANweoeNufGAyUcFQfiiorfQtTGBGmIIYa3UBwAeKmgwXOGpzt9w9vMoJBD7Sl0Ln78L/bOiwOztDAZ5oX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178112; c=relaxed/simple;
	bh=cFaEqHOcEw8ckZnIX+zwYM0QN23YTh1/fcoat9sQnVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KphphSt0xrBALhikC4U19zxoGR4y8HhPq8OR/2f4jHLdhcIj8joa3iyM0vZncSascDDSPrvWs25xvvoJqwx9kOXmuTwH7uLoQyXndjww538GsKrZv7j/v0P4saauMfOrrslWpnBt2+4J2Orl6DmmWntI0lxbxV3dXJHjmD+3Xpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VuY8fM+n; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VuY8fM+n"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-138156c0492so3980071c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178107; x=1782782907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlIdX0eIomSmTo4V05ay64NQwCG4Uwzo/gmzOL4QupM=;
        b=VuY8fM+n+VHDogOTmdYZskCOKNxwjhNAjpE7WWVMzL39SX4vIFy48lw6gSPvWoQKYW
         AbMn3spW3y23Gm9eNwMyeGANXIASB6XekFunpMEpLogwG+JuNnHuuBdgIT5b9+Rj4YG4
         sZxrsDr1wbuuYX7rDrceR8z9YVSk9BZJgzrIo5rPXj5MkRcmW/NW+knOEE47U9XYsIQW
         E3Zge57oF/7X1JEYptLd6aSC7F3C31HCZsSizeSujMl2gPKeGOmFwxJzfLTArPxW9N2a
         Mu2lyZpwHRnexfQWs0P79fWucUYe1st4B9uiY2bdXclcYOyNvLJz4/LdYIRdRZGhhjcb
         rMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178107; x=1782782907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlIdX0eIomSmTo4V05ay64NQwCG4Uwzo/gmzOL4QupM=;
        b=ErikUk7Z01bbViimJcSuhMA2Ho1Y3EBT48F/P59a0cP+7r5LJucSQMT4goTBliM/Qn
         nG1aibwNuwJYy5aJTEtAxN90B78dczUn++hwpNM4TyknVSoeTUPHf/U9hugVOtcZhrwu
         XpFdVOUdU259eRiL/Hyj+NCIdl63ICNUhq8VrSh+5aoC1phikcZ1gHSiWL+oqKNVaqAK
         4cauKizDD6MNZXS/obsQZHApgT9DOjeRyh65xTl8aKLKa9tOHo8fs/YS0bJyNFIh8g+3
         duE5D1jWIKYC/iOLeWzW7+vD1zcxa6db2LnogZG0RztaDLUdCr9rBsRjx5IRxvAlVn8I
         qoOw==
X-Forwarded-Encrypted: i=1; AFNElJ/5DRpUj1VleVFFlf88OHxUHWchg97ElQDoxRS2kj9lFIygCO4h/LiZqv1/L6cgU8amP6RufTBIRwojZ5/Xyz0T@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rC0PPQtai0S/nfMfATwirLUDcGyZCUNUPENMxE7Tk2MKwdGL
	VLrm6k9NLaiL9OTzZBledu+3a3SkVCLIgkfThUYp/UoyF+OdvvsoFtGgYCSjUCe+LRdqn5Ow/Zl
	9h7oJRSWCfw==
X-Received: from dlbay41.prod.google.com ([2002:a05:7022:6629:b0:137:fec5:89b1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6612:b0:128:bae0:e03c
 with SMTP id a92af1059eb24-139c5e0206cmr579774c88.30.1782178106999; Mon, 22
 Jun 2026 18:28:26 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:57 -0700
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com> <20260623012758.2291858-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-13-irogers@google.com>
Subject: [PATCH v4 12/13] perf tests: Speed up metrics checking shell tests
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Optimize the execution of the metric validation and metric listing shell
test suites:

1. `stat_metrics_values.sh`:
   The Python metric validator runs the `perf bench futex hash` workload
   for each validated metric relationship. Reduce the benchmark runtime
   limit from `-r 2` (2 seconds) to `-r 1` (1 second). This cuts the
   workload duration in half while still generating sufficient PMU events
   to satisfy non-zero threshold metric validations.

2. `stat_all_metrics.sh`:
   The metric checking test runs `perf stat` sequentially across all
   433+ listed metrics. Change the default workload for system-wide runs
   from `sleep 0.01` to `true`. This avoids the 10ms sleep delay on each
   sequential metric invocation, saving over 4 seconds of total wall
   time during full test suite runs.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh    | 2 +-
 tools/perf/tests/shell/stat_metrics_values.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index feeb34c6fa6d..df5fa27b21ae 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -7,7 +7,7 @@ ParanoidAndNotRoot()
   [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
 }
 
-test_prog="sleep 0.01"
+test_prog="true"
 system_wide_flag="-a"
 if ParanoidAndNotRoot 0
 then
diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/tests/shell/stat_metrics_values.sh
index 76f1e99d1273..86c5c7f70933 100755
--- a/tools/perf/tests/shell/stat_metrics_values.sh
+++ b/tools/perf/tests/shell/stat_metrics_values.sh
@@ -18,7 +18,7 @@ fi
 pythonvalidator=$(dirname $0)/lib/perf_metric_validation.py
 rulefile=$(dirname $0)/lib/perf_metric_validation_rules.json
 tmpdir=$(mktemp -d /tmp/__perf_test.program.XXXXX)
-workload="perf bench futex hash -r 2 -s"
+workload="perf bench futex hash -r 1 -s"
 
 # Add -debug, save data file and full rule file
 echo "Launch python validation script $pythonvalidator"
-- 
2.55.0.rc0.786.g65d90a0328-goog

