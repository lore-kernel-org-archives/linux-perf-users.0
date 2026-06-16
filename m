Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06483890FC
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573295; cv=none; b=YcywIlKxEnk5PqTV5G8b+lFAYEa88CwmRTlPyQnPz3oIOq/e+Lt60yyl2pNETOgZq9NTjWXfYiZd+m9VSAKL1goO/CB9O8mvplILYt3YSfpEpLNE5oXv43gVJFIO4bfskuxcw6KM+4hLG428H+QReR5hQqvpczci6BaM9aH3XuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573295; c=relaxed/simple;
	bh=BIIsVHw14AlfB5+sUSiVc2BYFc8fwPr+bn6W64wSPPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=u1CI0CMl5ChNXQ3plyRGKw2GCSvPZxEiJwAtPdIZetiF0HVs+E610gnl/NKL3gSVR5PpiURwxMcgixXmeigpBpJ5u9m1z4KmFyOUI8rE5N0O9zeQwc9SQKQ3sRp/m1cjJtV3VbEguD4kRcc9ut8e+SCXKx9on//SlYBwFVyZOfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agsSZ7ha; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agsSZ7ha"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304dd917645so8314745eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573294; x=1782178094; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1FPpTj4tXNFYu5bl111NYkOm6sMBpzwoN1Xqptn2N8=;
        b=agsSZ7haTjd3t0K2wsbHyiGWuNTW94uE4lBBX6+kmO2uXjP8X0yaP9+frBW3WQ2mdc
         WO41hoDpYNn77XKkumGjJkwnKIMqmmJ5z11zfJqg9i2O2k/WRDEfkK1EqXBD+zGApOJD
         X4aIGfM+ZOwnhSFMg45w+JHIchRM/PAKWl+Jc7GqsS+Cu1PI3OyBtDrz42U3OHKddPOC
         2a6wmy5m6lsoGcB801hI03EoNlXbz8YhTazOkAT/6nA0JyNGyCVYAZeDTeew1SWDjNnH
         qA/CqmRL8hbj8vhsEIl7WdDE5o2/rJH5IpkhH1OkIm35ur5fcp8LXuBDmqTUkckI8X1/
         WqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573294; x=1782178094;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X1FPpTj4tXNFYu5bl111NYkOm6sMBpzwoN1Xqptn2N8=;
        b=q1UUxEcW1yA5H9o4IVwpQxCfWLvsGzp1VVpky0pxOyTyF3HZgnRxNjABDCoPCiSppF
         Oih4XWUqvOKWZYFmP57Pm+6ehtqGSFvEZFo3gTCYf3/kHRSl1Z7QN88mGteIGpQgFXL1
         LXvAtau+JhNbqJzXjUqCCfTm7nxVTevnkKS7dJPQWL6kfv68NQ/C1OxqLGLEhrxgNL5g
         Um1IDLkFtFxuhovdlmtFEesf0J97pXdpfw50da633e/88BShQJKLukc4gbDU4MnRf2xS
         4vn4lWSY14wEERLpvLw6csLE9rUdsOQ861Py/jphilQfelcZQp4iFVWBlKhUsnX5tvhj
         ijxQ==
X-Forwarded-Encrypted: i=1; AFNElJ94zNxB5r6xq0S7+zb9fUx8PUviuVt1+4hFfO4wtg39ikA/e4DVGO7GvP6gOeUueFBefpOGQ16NhYvILfK7Xk3V@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkCEIdV30syUrSb1sqypEoDD9GGTgSOaoeskBjZ2VDWtoxTjj
	KthgKrYlfDUp/JtpzlPPRxlmDZwu/iPkT25Zd/eoYLdH0wV97xN8sJ2B9xDBpwGjR6HwnrLi4YF
	w+P1g2ePMqw==
X-Received: from dlaf6.prod.google.com ([2002:a05:701b:2406:b0:139:8598:5f49])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2390:b0:12c:44a5:fb4f
 with SMTP id a92af1059eb24-1384bafed09mr7298568c88.10.1781573293463; Mon, 15
 Jun 2026 18:28:13 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:44 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-13-irogers@google.com>
Subject: [PATCH v1 12/12] perf tests: Speed up metrics checking shell tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
index 5ee869452ee7..066e6cfd427b 100755
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

