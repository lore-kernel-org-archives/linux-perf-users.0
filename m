Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C5E47DFA5
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628534; cv=none; b=a5CieQ7jn7EQ/ctZh7gChRNfF0KGCvFPbqfDxDHPRRQA+X9td7H8L7N+S5OdbQaRbcbeJsR69G4bSOwkWPIKqBP+VEbkluVI8Mtuv87eQSje6iqBdZ3YTrO12R8F0Sge5Y6IrG6KvHlFqUgAdQ+C3xz41Wjwa9nenq2eQdvouro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628534; c=relaxed/simple;
	bh=comN1lU50UtE6xZMRFNhOmPnFpXHRiIrauxHtx1aZks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VO2KuMYXmEmhvlfcsAE8JAb6G4nkYCdyb6c7zQgNgTt/ugh2/eOpz2iA/eWpJGMTkmS3/v/PnfUtMGxmixlOF+1w8bImZ4AIqKJfzEnc8BH61XBzrPBNKRjQ0RGcARjUxuT89758YYAO04E+2WLpTUwE1pIjINofMuedA5NnY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5LUWMJ+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5LUWMJ+"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30bc7296c59so295056eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628532; x=1782233332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8f67QcyBWEbf5xZSpkTjIM3UVNd5TGoldZSjoyXtin0=;
        b=j5LUWMJ+ReCN565bEu2p9SS39tysii93AUBIBpnk/Z7zt5Oo0osoVQWAqyHwu+EXk+
         rmQJ3EaTGVcNDNZNOjxAUDZMOVCvcl0zto/EglY312zMPEkFMxKES8YsUjJ3odLEAJAo
         v0KadYzG/Y6LJH5yIdUIdnEho+4snjewX6Y0FJyQ2lwwuicx5dGIK95eOf07n3VOUlAl
         ku4I0H/EflFiXK1wd1P5ZHZm9GZfDG6kzxc/de7taoMlKWBhfjIm48GSevLJZaZ4Y6FN
         /n089CBzx8tzc0kxkjzpbW6754UgXvz4NF8egkPFUjzUlUjY9dvQvxDX/MtOncVKvw7M
         u5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628532; x=1782233332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8f67QcyBWEbf5xZSpkTjIM3UVNd5TGoldZSjoyXtin0=;
        b=qLg1uviDzmbFm/+cUWLxtphnt/ct5wrGMv1q5OCWbQXRzeLbWoV57EWe7GhK4QwE8+
         cC2a4/6qeiXhyMMbTk7JdJ8vvoOBPN4NSkrNFhjMV9HXF+4oIvn+NdX653BRqJFkc9EM
         JfKDcsomfl9kvQGK9PqtoACI2vaFUgV/rOTirj1sSHtNaSUhKJ9BvMpKmIkbV5XkCEA2
         Mcx2F/X5yleQcSnwP0fU7BjhtPvE4vLcw6kEI3WSnhYDGu5BfIi8uA7y3zyGCW2u3pHZ
         B+IL1/dcr7sdSW5XY4emM7VlZnElZUoWdINj/5ZOO2Q6ypYl1Fdy2RE22N3CvquWdY4p
         Jghg==
X-Forwarded-Encrypted: i=1; AFNElJ/1g75ve027sfabPGOZ0diIoJ4erjK1Ae8tESgXkZHZjWlDvoaEFg86n9/WZVK2tPbr7cOOtl0ZjDc+IuxwFZCr@vger.kernel.org
X-Gm-Message-State: AOJu0YzycIMD1myaDZsBWDusSBANrD/GO0lFq2hUv9ZoLwb1fynumsr7
	L8Ai2/XSGS88qoYVD3aSjFE0uGsFSFzN7lzMkSkeXvy0or7CJcT0nT4ZtlB7SUEOlrnvSDHlLwc
	KYSgTI/aAZQ==
X-Received: from dyz9.prod.google.com ([2002:a05:693c:4089:b0:2ed:8f25:962c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7c0e:b0:30b:6191:7f96
 with SMTP id 5a478bee46e88-30bca08d65bmr51283eec.30.1781628531675; Tue, 16
 Jun 2026 09:48:51 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:17 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-13-irogers@google.com>
Subject: [PATCH v3 12/13] perf tests: Speed up metrics checking shell tests
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
2.54.0.1189.g8c84645362-goog

