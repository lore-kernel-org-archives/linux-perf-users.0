Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E73DD871
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590483; cv=none; b=OEmJL2UQmU39hpcQEp4GUVRP/+4ph6y3eKHIVBdJltmThZEXYWXomkLyIspxBM2WGwGHkTW3MYg1TFJ1XYDJElPyrEc06b0ih+Z9ZDmXTIzDsd1KcWLOsqLZhwk/X1i7Na7zlaPYGKpAOj7VmcEnE4xLd/MMi1y8JdwhWIYSQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590483; c=relaxed/simple;
	bh=ieCtBH7NGdRALvq14n+aIqBPY80X7Y8EqE44MgtvKxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q4AzQUe1WVbyzybR/Qnx4i6Jwl/29LTVNreYYA4tmgNdUj5VS3fjUtBxMYvubNZcFH54TylDIpkKoMr8OoQ406VLXe6rCX9yQjJUqcCVw7jt0YD+XRUbK6xJJPDi4xxtZmi7jctjbMPxAXdfbg0ES49FQpuyICqrsToAUDsWSvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QHlb9G7z; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHlb9G7z"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137fe4a3640so6536618c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590473; x=1782195273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dP/QFiQYiyEnqwAIwu4/MnYcRbxzmyjPz9V3In5s0UI=;
        b=QHlb9G7zO3fTYnV5jW/Ta/+oJY2JBJ5KpiJLhvSjdcOuf0DzvdhxwUMcglPIT1AJw9
         okP2ndqGbcjdnMCCkpVJhMndy2d2o4oYSlOtPpr4YshrhJLg7pC5FviYFFZ4FM3mGY/S
         5apt6mObzQSiaRnEiA7XIl5Oj2vGNTzGN6sEylVdbR+Fn4+TrqPZTZESfI7V10fX0wbl
         ScfnXtAKYwIiFnD9ts+01Z8+PAQ/KYOOPEu7QIorMyVvPjBLk2BWXS2xWt5WXxav/Oq1
         7deOW1y8Gzb/0IXu6lk9MOJMQFo7G/j7gxss0CtqYhRFLaqeKN/KA75KeO5IAceK78iK
         1I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590473; x=1782195273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dP/QFiQYiyEnqwAIwu4/MnYcRbxzmyjPz9V3In5s0UI=;
        b=Y/dAEfztoKmLM/QGzMn/OIZSNfGK5bi7I4eR5yJBFRixbqvvrzAaTRqJsJ+ebas5Zc
         S8bR7BGhrV8L3boSJ7VhaB5BvospdxZeI4Q68KoBhOFcpMXUKsHbA24t/x8pkS1xd+lE
         W5rKd/+sAgXf3WL5ZoH7B/yDLbUuH2TJxCH3+owIpJ4Qnna8TZnVXe3YYu0vSKy5VehZ
         mNjKPNMHxJsvpUdiX0IyYQysX3OmoBWTWLr8KNo5HJFWt62HGdbw6EaMP7G7fQCCtMC8
         58rRs1ZupUSbG08pT/5RPSRvDfD8NeFkdZzyTPW4dvfSB/r8rSdE9YuePzjJHWApQp96
         FehQ==
X-Forwarded-Encrypted: i=1; AFNElJ9iXsvieX5Ss48koKfE6swVcNQgmSj0zQbBQ/++lTGKpRSL90zAJtuP4IBC23/C5ReIP2DxPMQ7olYyfWhaEKeC@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZEeaDS7ww9Cfp4YWprQjnraDipAZnMi5yoC2XE6h8xT69QTj
	hIua4KGTt/TglI+6e9bJiU+5UhGk1vQnq82WJM7Rfpwddd/s4qwRMZUs6lVOzJ3X5MtSi5+uUZV
	OvB8cAAYewA==
X-Received: from dldoa11.prod.google.com ([2002:a05:701a:ca8b:b0:137:fdb1:854c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2229:b0:12d:de3f:f3e5
 with SMTP id a92af1059eb24-13985f5e00cmr962950c88.37.1781590472660; Mon, 15
 Jun 2026 23:14:32 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:14:04 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com> <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-13-irogers@google.com>
Subject: [PATCH v2 12/12] perf tests: Speed up metrics checking shell tests
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
2.54.0.1136.gdb2ca164c4-goog

