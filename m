Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084032550A0
	for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075632; cv=none; b=mlwTsYqi/V5sO7dAOz/C3Iyw65WjSRiskq0b5WEHcN1D5T6EkalzhUjCciceBvylAlNwYToB4tMtkKHEOYz4FRk5tpVPnEv/As8fwn07reFgBrsDOEZ/8+aTj0dMrouEIszOgR3dbiFfyAittGQN0byuT3/U790/e4ScHTSv10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075632; c=relaxed/simple;
	bh=zJvyNdX2YgdEqoNXg3n4TWo71oZ36ldMsiFZEsSn1ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dMy2S7ZlavCR131lNKa4XUXELLEsYX7q+YbAb6K9g9vHgy/qiTWPYggBR9t8GdH7B4uAARzB7ZsQ83T/Y0UykXhKVJY0x9HspSs+6hDuZy1ltpC69Hs51I11z5C7971fwxSJRHR0evdBkYYHQFRAICFYDIF70UbDZ2rrfcvEbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1HwZ2dDw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1HwZ2dDw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22e544a4c83so46710845ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747075630; x=1747680430; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AvMb/mvqXOc4kGMuj8jXPuGYMUK8d+5O6okErUodjJo=;
        b=1HwZ2dDwsLmob/1REMEo/enhHeIcvjXyxGaVdJ0dbmahvR3QSj2WQ65KQpZwAnPS58
         Z5I3U6OprYf/G30n9Fk4U+7MjrLW9wedmarFzfmSgx5BHEiOlEvkJyq13LZpEoGdi2YN
         ztnUlQaRe4/WBo3YNBJSe9NIeYo5SnJoUp6tMde6uivGPMNxtTCbXfybf6AHtzVinWV0
         dxP+mxUenJEPEFy3qRrodZJw7BDJ/lQasgIAyt8ylv2tg8v71JqM6teyYv6nIhuee5hW
         8vVWClBoq07MU9as3JbiuRhbR3MEkKm3OgEwQdXgv8mLSx1zAkJCfspTy+7PqnOmw9Sn
         bbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747075630; x=1747680430;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvMb/mvqXOc4kGMuj8jXPuGYMUK8d+5O6okErUodjJo=;
        b=ndCTuZR0LgS76IyNMfA+2SmSP/eWzSX3e5g5IB/fBgZq3iG5xyFOT76mvxRQUTgl/g
         BxzSNanlnScss8n79nBvq70p/3hth+2MNpvZeMMT5jNykCaFyp/KpuWaNNoKdhNud9OQ
         NOErXy764qIHqOvO4dmUXhcSUUnzVZl269vQGFSTb1fyHyT+TlQYVbGOzNm0tiEpbhJp
         btK0Tbg0HZ4Uk2KKlVWNvmKLbhNTnXNRpdukK+83Q1ZB5g3ReaD47QMD/x6aqre+4dkP
         xygg2ilF3Tcz9EuiaZHlOWF1IWAs+i/CgMULgmFTwBD7b0PGvEjmBIqMDY+m1Kv3/Wdw
         IQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoXR7K7kbQJW1zw6oItrg7yPn2F5+RSrp3DT3+5OMXjUxK6EcVIkGNdxcaPx1+6Y5MdjksG3w8RK5egRc0JjSN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7k/KxdqVgwutEIet15Y30HQb1NojyDVCTnrMSuwsPbU3pSeq
	VqfqlWRLoA0vh9QmJm1aKbP7d5QTKSwdO6A/tePaxDbmOjooVGB1iPOD1dm2F8hsqFDxzOJnUl/
	k4pRNow==
X-Google-Smtp-Source: AGHT+IF6DRng9Ys70rVqDkR2VNd1jFwXPfLJ9xYMfUoFSksY3J1duClwQNcQWc7iMUssoYXSZswWKh1T10hm
X-Received: from plle7.prod.google.com ([2002:a17:903:1667:b0:223:225b:3d83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c6c:b0:215:9eac:1857
 with SMTP id d9443c01a7336-2317cade1b7mr7587905ad.5.1747075630302; Mon, 12
 May 2025 11:47:10 -0700 (PDT)
Date: Mon, 12 May 2025 11:47:00 -0700
In-Reply-To: <20250512184700.11691-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512184700.11691-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512184700.11691-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf test: Hybrid improvements for metric value
 validation test
From: Ian Rogers <irogers@google.com>
To: Weilin Wang <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On my alderlake I currently see for the "perf metrics value validation" test:
```
Total Test Count:  142
Passed Test Count:  139
[
Metric Relationship Error:      The collected value of metric ['tma_fetch_latency', 'tma_fetch_bandwidth', 'tma_frontend_bound']
                        is [31.137028] in workload(s): ['perf bench futex hash -r 2 -s']
                        but expected value range is [tma_frontend_bound, tma_frontend_bound]
                        Relationship rule description: 'Sum of the level 2 children should equal level 1 parent',
Metric Relationship Error:      The collected value of metric ['tma_memory_bound', 'tma_core_bound', 'tma_backend_bound']
                        is [6.564442] in workload(s): ['perf bench futex hash -r 2 -s']
                        but expected value range is [tma_backend_bound, tma_backend_bound]
                        Relationship rule description: 'Sum of the level 2 children should equal level 1 parent',
Metric Relationship Error:      The collected value of metric ['tma_light_operations', 'tma_heavy_operations', 'tma_retiring']
                        is [57.806179] in workload(s): ['perf bench futex hash -r 2 -s']
                        but expected value range is [tma_retiring, tma_retiring]
                        Relationship rule description: 'Sum of the level 2 children should equal level 1 parent']
Metric validation return with erros. Please check metrics reported with errors.
```
I suspect it is due to two metrics for different CPU types being
enabled. Add a -cputype option to avoid this. The test still fails with:
```
Total Test Count:  115
Passed Test Count:  114
[
Wrong Metric Value Error:       The collected value of metric ['tma_l2_hit_latency']
                        is [117.947088] in workload(s): ['perf bench futex hash -r 2 -s']
                        but expected value range is [0, 100]]
Metric validation return with errors. Please check metrics reported with errors.
```
which is a reproducible genuine error and likely requires a metric fix.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/lib/perf_metric_validation.py   | 12 +++++++++---
 tools/perf/tests/shell/stat_metrics_values.sh   | 17 +++++++++++------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/tools/perf/tests/shell/lib/perf_metric_validation.py
index 0b94216c9c46..dea8ef1977bf 100644
--- a/tools/perf/tests/shell/lib/perf_metric_validation.py
+++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
@@ -35,7 +35,8 @@ class TestError:
 
 
 class Validator:
-    def __init__(self, rulefname, reportfname='', t=5, debug=False, datafname='', fullrulefname='', workload='true', metrics=''):
+    def __init__(self, rulefname, reportfname='', t=5, debug=False, datafname='', fullrulefname='',
+                 workload='true', metrics='', cputype='cpu'):
         self.rulefname = rulefname
         self.reportfname = reportfname
         self.rules = None
@@ -43,6 +44,7 @@ class Validator:
         self.metrics = self.__set_metrics(metrics)
         self.skiplist = set()
         self.tolerance = t
+        self.cputype = cputype
 
         self.workloads = [x for x in workload.split(",") if x]
         self.wlidx = 0  # idx of current workloads
@@ -377,7 +379,7 @@ class Validator:
 
     def _run_perf(self, metric, workload: str):
         tool = 'perf'
-        command = [tool, 'stat', '-j', '-M', f"{metric}", "-a"]
+        command = [tool, 'stat', '--cputype', self.cputype, '-j', '-M', f"{metric}", "-a"]
         wl = workload.split()
         command.extend(wl)
         print(" ".join(command))
@@ -443,6 +445,8 @@ class Validator:
                 if 'MetricName' not in m:
                     print("Warning: no metric name")
                     continue
+                if 'Unit' in m and m['Unit'] != self.cputype:
+                    continue
                 name = m['MetricName'].lower()
                 self.metrics.add(name)
                 if 'ScaleUnit' in m and (m['ScaleUnit'] == '1%' or m['ScaleUnit'] == '100%'):
@@ -578,6 +582,8 @@ def main() -> None:
     parser.add_argument(
         "-wl", help="Workload to run while data collection", default="true")
     parser.add_argument("-m", help="Metric list to validate", default="")
+    parser.add_argument("-cputype", help="Only test metrics for the given CPU/PMU type",
+                        default="cpu")
     args = parser.parse_args()
     outpath = Path(args.output_dir)
     reportf = Path.joinpath(outpath, 'perf_report.json')
@@ -586,7 +592,7 @@ def main() -> None:
 
     validator = Validator(args.rule, reportf, debug=args.debug,
                           datafname=datafile, fullrulefname=fullrule, workload=args.wl,
-                          metrics=args.m)
+                          metrics=args.m, cputype=args.cputype)
     ret = validator.test()
 
     return ret
diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/tests/shell/stat_metrics_values.sh
index 279f19c5919a..30566f0b5427 100755
--- a/tools/perf/tests/shell/stat_metrics_values.sh
+++ b/tools/perf/tests/shell/stat_metrics_values.sh
@@ -16,11 +16,16 @@ workload="perf bench futex hash -r 2 -s"
 # Add -debug, save data file and full rule file
 echo "Launch python validation script $pythonvalidator"
 echo "Output will be stored in: $tmpdir"
-$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${workload}"
-ret=$?
-rm -rf $tmpdir
-if [ $ret -ne 0 ]; then
-	echo "Metric validation return with erros. Please check metrics reported with errors."
-fi
+for cputype in /sys/bus/event_source/devices/cpu_*; do
+	cputype=$(basename "$cputype")
+	echo "Testing metrics for: $cputype"
+	$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${workload}" \
+		-cputype "${cputype}"
+	ret=$?
+	rm -rf $tmpdir
+	if [ $ret -ne 0 ]; then
+		echo "Metric validation return with errors. Please check metrics reported with errors."
+	fi
+done
 exit $ret
 
-- 
2.49.0.1045.g170613ef41-goog

