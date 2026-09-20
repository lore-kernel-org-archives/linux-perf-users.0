Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA193E49D8
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881835; cv=none; b=jiTfJQvNoU1R7LeiSoka/6L1Ry8I6WFeuRCT60XOO6rYSM7t8BXyLyG8CmsyygTSxW5HVRUjrCEARFz8lVxlhOoJvsltkg8EqEqiFVADsRNDio8+ymrd5prC+Nm2eKi5HPSUf79yfIVo85sjjYeB5bqSagtmrjg9R4btS6d88k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881835; c=relaxed/simple;
	bh=zwM1q1YUzZunL1x1lMbSfSDg6zmfdHldNS3fF7NQPj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B+PJe+HRXwUmOHqHCaKzsLCPMfAbdnWfyLpTaDsRgFoKzTlzjXq5NFF0nqEopRXldLPjQVbw7uVTa7WIc/7mGeQfsnqAEnWr7HEMKwLkfmd/kJP7e6dUgiqddPI/+W8yon76/328yd2Hcrng38uV5jNk1CUcFlLX2Rd7CSQggZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htH35Biy; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htH35Biy"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso2702292a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881832; x=1790486632; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0HHfRcO9ZuBTSYkylxeBWu1seR4mW7jH0oHiQdS/3lo=;
        b=htH35Biyeddw9Bc2Z7Ho40fBvj1E6uMxEfjvCJNy4jKKmMbNopkfTkwrsANj2Ilryr
         gEu1DfUPjuxKo0WGk709nTVEAr6L8d5QNFNps1QwK4t750bVXDuDVRpo9SX78ODs/4yb
         V7Sf36+62/CWo3iRNY7zn4ea5O7JAjApjP+SE15UPiqxTVr6Rs4+sqHs4VomyTuzS27r
         WJp2hgdBe3oJxNUQzIAUUnReNzD/sGFViUtunU4w2/Pf3/6J0waWhB2JsTaNoY1ySqLp
         Xh9gmMm9fBu+Grwbj0bs0N2vHUS9j1Kj4lZP2IsRfhp/qp97Z7xHS54H+IpLlB2H9jE3
         PV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881832; x=1790486632;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HHfRcO9ZuBTSYkylxeBWu1seR4mW7jH0oHiQdS/3lo=;
        b=SkLvYqLe9BKuxAaMcB0oCUyJf0mdom0wGFGplhBRLOc6X1CxyNbd4o/L2nAKNS7ag4
         ddw2HW84ZsEJk5e+7zKKmAY8nXNcv95MDOSvpgrC3jJZvNFFPfHfwWd+THH4dLktyp+I
         B2QL7mK3D55+lrrpdsRkB7OfDrplu8obBIyqaYVd6BWQkCYMMv7gQzrHE/vqesSAMLKj
         xFA711S27LWYYWyt8JnJN1kzXzCBRCKf1Ux/eCPavOeX1cunoS/hGODkAxg8w1l7/9l5
         P3RfCw8/8XR0eQNx+bhVwtRhMQ5w4MinFmZ7s/Ai3dEUOhrTXpCnySq0FajGWctSfx6O
         8Srg==
X-Forwarded-Encrypted: i=1; AKwUvBwr0si83/ZVrqtDgEmKt6+UQXEVeeGq4WHRVX3eillNPUEIOirUbSep9Cv3utG8k9UsVAW3IL41cRkrexXLE20j@vger.kernel.org
X-Gm-Message-State: AFuF++lh2XmVT2eQoSN3xPufuNLTQHDwuDZXn+F0AKfMfZ8Z64c8ahz8
	M+bg1iYlNMR3Id2twh46xqdsziSgFvVNfB+MmuHL9exUwJ94cCw5er4V9L6e7YTprtD9uKRp260
	upwefT7Bykg==
X-Received: from dlbts22-n2.prod.google.com ([2002:a05:7022:b056:20b0:144:ce9a:b252])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1347:b0:39e:6c68:c77e
 with SMTP id 98e67ed59e1d1-39e6c68cae6mr5817878a91.52.1789881832482; Sat, 19
 Sep 2026 22:23:52 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:33 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <a4cedfb86804468cac0b629ac4ea553ab494ce22.1789880842.git.irogers@google.com>
Subject: [PATCH v1 41/49] perf test: Migrate Intel PT virtual LBR test to
 Python API
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Migrate the Intel PT virtual LBR test from generating an inline legacy
perf script callback to using a standalone Python script
(perf_brstack_max.py) with the brstack iterator API in the perf Python
module.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/tests/shell/lib/perf_brstack_max.py  | 37 +++++++++++++++++
 tools/perf/tests/shell/test_intel_pt.sh       | 41 ++++++++-----------
 2 files changed, 54 insertions(+), 24 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_brstack_max.py

diff --git a/tools/perf/tests/shell/lib/perf_brstack_max.py b/tools/perf/tests/shell/lib/perf_brstack_max.py
new file mode 100644
index 000000000000..e2f5362de5e6
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_brstack_max.py
@@ -0,0 +1,37 @@
+#!/usr/bin/python
+# SPDX-License-Identifier: GPL-2.0
+# Determine the maximum size of branch stacks in a perf.data file.
+
+import argparse
+import sys
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
index 26243ff760ec..e512d0c88dd0 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
-# Miscellaneous Intel PT testing (exclusive)
 # SPDX-License-Identifier: GPL-2.0
+# Miscellaneous Intel PT testing (exclusive)
 
 set -e
 
@@ -22,7 +22,7 @@ perfdatafile="${temp_dir}/test-perf.data"
 outfile="${temp_dir}/test-out.txt"
 errfile="${temp_dir}/test-err.txt"
 awkscript="${temp_dir}/awkscript"
-maxbrstack="${temp_dir}/maxbrstack.py"
+
 
 cleanup()
 {
@@ -376,34 +376,27 @@ test_kernel_trace()
 test_virtual_lbr()
 {
 	echo "--- Test virtual LBR ---"
-	# Check if python script is supported
-	libpython=$(perf version --build-options | grep python | grep -cv OFF)
-	if [ "${libpython}" != "1" ] ; then
-		echo "SKIP: python scripting is not supported"
+	# Check if python is available
+	if ! command -v python3 >/dev/null 2>&1 && ! command -v python >/dev/null 2>&1; then
+		echo "SKIP: python not found"
 		return 2
 	fi
 
-	# Python script to determine the maximum size of branch stacks
-	cat << "_end_of_file_" > "${maxbrstack}"
-from __future__ import print_function
-
-bmax = 0
+	# shellcheck source=lib/setup_python.sh
+	. "$(dirname "$0")"/lib/setup_python.sh
 
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
+	if ! $PYTHON -c 'import perf' > /dev/null 2>&1; then
+		echo "SKIP: Python perf module not found"
+		return 2
+	fi
 
 	# Check if virtual lbr is working
-	perf_record_no_bpf -o "${perfdatafile}" --aux-sample -e '{intel_pt//,cycles}:u' uname
-	times_val=$(perf script -i "${perfdatafile}" --itrace=L -s "${maxbrstack}" 2>/dev/null | grep "max brstack " | cut -d " " -f 3)
+	perf_record_no_bpf -o "${tmpfile}" --aux-sample \
+		-e '{intel_pt//,cycles}:u' perf test -w brstack
+	perf inject --itrace=L -i "${tmpfile}" -o "${perfdatafile}"
+	output=$($PYTHON "$(dirname "$0")"/lib/perf_brstack_max.py -i "${perfdatafile}")
+	echo "Debug: perf_brstack_max.py output: $output"
+	times_val=$(echo "$output" | grep "max brstack " | cut -d " " -f 3)
 	case "${times_val}" in
 		[0-9]*)	;;
 		*)	times_val=0;;
-- 
2.55.0.1082.g2b9226bbc0-goog

