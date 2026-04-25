Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C63AF659
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157525; cv=none; b=f+b8qN3kkUfREfOggPO6Yr8yJlMi7OmsBkdqIJVVGYHfl52ygwoaoMgRYoCDQPHSNyXU3yOC94TdJC/gxY1NAPLDyaVxskwsUv4tHr7fGVZ9z+SYr7hE7Ue+Aw2ghxDtFn3tPltDSxppSRmIQzs72WlyNz0WRpHe4x/U7Tyx34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157525; c=relaxed/simple;
	bh=ZrJ2nullNFdPahYP4cmzB/NIEZ9UukgcFFOHNvNmBo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTYzebqsWHH+Egeoezwsrrgsu4OcJzXrIR95wWQp/ZHYHNrck5sISJP760sQR8uhtfCh4X/rLUbOUhYrlTUgSiBRChfrX0uxO7+DBhm20AwdFz0OFaxhEbFfgGoydb2osC2Uiy+7cgCXxu2Fv5jRPfTWh/53c5gwCbYF1s1J2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xjy9CaQm; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xjy9CaQm"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2eaf70f3b5fso734748eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157522; x=1777762322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4cIRIqFZJ5y1BubPplg9oWe019B443zoI45B5rxaHA=;
        b=Xjy9CaQmPZCrYl18kBAde+IGDu+qilwUaQNP8mSuYzN7ZdB7r5miC91jS0avQIBIqS
         kliZMjsQ6YOAB5F7fVGiLCAJ6M3xyKIO3hpuYVZNMTA305uNgb7OtCoUbQ0Dl1mZ8BbN
         LIRUD4bRoUh62POlruYFyG4FhwYwIBII4NjfuH4eHjTQU+dm9fbvQJ3TIyy+ChlVlIV6
         mmEakqyjMr6EpxZPucQudsNETudK/9p7FsGJJ4p58IzlmEaKLHW6HtSnPsTazUsBeZR9
         pkfY3bsCToz/wilVainhWyIumi1FB+fn+e2xaH+dHOQgg61D3WP+2iTNtOO2RR9J8m2g
         bumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157522; x=1777762322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4cIRIqFZJ5y1BubPplg9oWe019B443zoI45B5rxaHA=;
        b=tLd3q04FRcFfxj+1H53Yilk6hkggo//9ImL1Q6AyTW4G9tUaWGcN4KRG3YWI8dUzVv
         WV2qO7MiRj5RApJrlZs1W/dher3upAugjACdHK3uqr9RKJx/WKJZZmlTbeuEVUY2Xb4i
         zqkE7i0EY+7I72J8NLFDaqbXUoZi81fMICSBUT0q9reMrAryHLCYMoGgKBxDfQ5U44dR
         G5PEsgZEfgzzK+POat54+CoSYlpMXGgu7wlH0ZnPochHwdEDcGsL/+eOHl75kCJb/2ZZ
         zXTU7JTFc6hZ8EhqjpxnP3zCxMoBmFtzMx7BaG4HU6Mp6UtcmNB79PCXCl6A/XesUML8
         tbjg==
X-Forwarded-Encrypted: i=1; AFNElJ9OSgsxm58JLtxzpi7f5WJGXDG/21txF+XEh474vM0lgNOB9jb7UqUVGbJ7RcemJcU0oqzSoE8kRd8x5pK8Jpm2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+3JL3+LOa38IfqXb1luRXHlfB2zQo5VwUNjn5xh/jEFMFgNu
	cqMLafVvZ8JruVc3oZIXfHAqHaudHm+zzosRr5qduFLUvRbgso/u/280qoPbJcOuoyXjHv0CHmr
	YS7g5hByAUw==
X-Received: from dyaw25-n1.prod.google.com ([2002:a05:693c:4159:10b0:2df:5e19:9e69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5784:b0:2dd:c066:c02
 with SMTP id 5a478bee46e88-2e47a10653dmr20021430eec.22.1777157521693; Sat, 25
 Apr 2026 15:52:01 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:44 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-53-irogers@google.com>
Subject: [PATCH v7 52/59] perf test: Migrate Intel PT virtual LBR test to use
 Python API
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The Intel PT virtual LBR test used an ad-hoc Python script written on
the fly to parse branch stacks. This change migrates it to use the
newly added `brstack` iterator API in the `perf` Python module.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>

---
v7:
- Fixed permanent iterator exhaustion on brstack by converting it
  to a list.
---
 .../perf/tests/shell/lib/perf_brstack_max.py  | 43 +++++++++++++++++++
 tools/perf/tests/shell/test_intel_pt.sh       | 35 +++++----------
 2 files changed, 53 insertions(+), 25 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_brstack_max.py

diff --git a/tools/perf/tests/shell/lib/perf_brstack_max.py b/tools/perf/tests/shell/lib/perf_brstack_max.py
new file mode 100644
index 000000000000..bd1cdb463f28
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_brstack_max.py
@@ -0,0 +1,43 @@
+#!/usr/bin/python
+# SPDX-License-Identifier: GPL-2.0
+# Determine the maximum size of branch stacks in a perf.data file.
+
+import argparse
+import sys
+
+import os
+
+script_dir = os.path.dirname(os.path.abspath(__file__))
+python_dir = os.path.abspath(os.path.join(script_dir, "../../../python"))
+sys.path.insert(0, python_dir)
+
+import perf
+
+def main():
+    ap = argparse.ArgumentParser()
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+
+    bmax = 0
+
+    def process_event(sample):
+        nonlocal bmax
+        try:
+            brstack = sample.brstack
+            if brstack:
+                n = len(list(brstack))
+                if n > bmax:
+                    bmax = n
+        except AttributeError:
+            pass
+
+    try:
+        session = perf.session(perf.data(args.input), sample=process_event)
+        session.process_events()
+        print("max brstack", bmax)
+    except Exception as e:
+        print(f"Error processing events: {e}", file=sys.stderr)
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 8ee761f03c38..d711ecdf5be0 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -24,7 +24,6 @@ errfile="${temp_dir}/test-err.txt"
 workload="${temp_dir}/workload"
 awkscript="${temp_dir}/awkscript"
 jitdump_workload="${temp_dir}/jitdump_workload"
-maxbrstack="${temp_dir}/maxbrstack.py"
 
 cleanup()
 {
@@ -539,34 +538,20 @@ test_kernel_trace()
 test_virtual_lbr()
 {
 	echo "--- Test virtual LBR ---"
-	# Check if python script is supported
-	libpython=$(perf version --build-options | grep python | grep -cv OFF)
-	if [ "${libpython}" != "1" ] ; then
-		echo "SKIP: python scripting is not supported"
+	# shellcheck source=lib/setup_python.sh
+	. "$(dirname "$0")"/lib/setup_python.sh
+
+	if [ -z "$PYTHON" ] ; then
+		echo "SKIP: Python not found"
 		return 2
 	fi
 
-	# Python script to determine the maximum size of branch stacks
-	cat << "_end_of_file_" > "${maxbrstack}"
-from __future__ import print_function
-
-bmax = 0
-
-def process_event(param_dict):
-	if "brstack" in param_dict:
-		brstack = param_dict["brstack"]
-		n = len(brstack)
-		global bmax
-		if n > bmax:
-			bmax = n
-
-def trace_end():
-	print("max brstack", bmax)
-_end_of_file_
-
 	# Check if virtual lbr is working
-	perf_record_no_bpf -o "${perfdatafile}" --aux-sample -e '{intel_pt//,cycles}:u' uname
-	times_val=$(perf script -i "${perfdatafile}" --itrace=L -s "${maxbrstack}" 2>/dev/null | grep "max brstack " | cut -d " " -f 3)
+	perf_record_no_bpf -o "${tmpfile}" --aux-sample -e '{intel_pt//,cycles}:u' perf test -w brstack
+	perf inject --itrace=L -i "${tmpfile}" -o "${perfdatafile}"
+	output=$($PYTHON "$(dirname "$0")"/lib/perf_brstack_max.py -i "${perfdatafile}")
+	echo "Debug: perf_brstack_max.py output: $output"
+	times_val=$(echo "$output" | grep "max brstack " | cut -d " " -f 3)
 	case "${times_val}" in
 		[0-9]*)	;;
 		*)	times_val=0;;
-- 
2.54.0.545.g6539524ca2-goog

