Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588A383999
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967319; cv=none; b=aOZoqcxCSHzGTHQCD+tgiebN43DMCHZmPDPvZNJ+a66c8QAnLQxrQLR//HlWK2YivlmZexJVzNHxuxs4UHG4nFIHsX2EZ62WAcwVWQVGW8PpLZQvIiZRXzb7HLrUEsP9ZX2J0ojOmJGLTCiGjs76HILvdr1o9NcxRq5AumjVtTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967319; c=relaxed/simple;
	bh=zwM1q1YUzZunL1x1lMbSfSDg6zmfdHldNS3fF7NQPj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L6K9htuvpHCZ2SuP6dDa5OdO+rf8WABMqheD9xNlRMw4uHyBt0jTS034t5GQkDXWCewiY3FO92uVM1xB6f0mm6OePtFH7mPKLMGdE2+hObFsdMr9QbRH14ERNHlsAg8ekdTE64zi2NsgqzxBlRNYHslWSuaA0vZQNRKC4co/hnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ozpgm5Ay; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ozpgm5Ay"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso2496083a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967316; x=1790572116; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0HHfRcO9ZuBTSYkylxeBWu1seR4mW7jH0oHiQdS/3lo=;
        b=ozpgm5AyvqiSCq0OFRrrfnWVx+681lnS2nFdmzhMOgo5VLauP2hhxR91a4AqrVRsfj
         Ofq9ZCAECn30c1WRfc1O9b4Iy1kApRGsALbXEiTn6FTfxcT5h+z7Pmgc8CiRekBB1Qdx
         Y2FuG9ZQQ9XyScqJN5NoPJnNpCPe9XGPnQj15wpzCJ13lvaxU2RIuysoNX5Uvvhuw6Sy
         wSDbBY3IHzK42oFCIPD/mtLs4i1OwsVhxINk3IuTFzPXYFFdsD04fCb/8r1vhckgBJ9t
         F7t/Z6g5pl0aauV1paQokx1yO0qUcUWTck7NfhUf3ShlasNXQRzhKrm1yPhcIuTMkw2+
         ir+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967316; x=1790572116;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HHfRcO9ZuBTSYkylxeBWu1seR4mW7jH0oHiQdS/3lo=;
        b=P1sGQQewwuZAN1ZpolkiGrw5++sTrpBkkyscdc6r+ubBiDOn6uptMOcPlpL6/0N+cy
         PEdvptwhApzqz4egvWLAhF+quW/VTkJW8H9WAI9HeMZHl5gx67rMTXPEo/wNK70wMWH3
         hbgBr2WcOxfDUSXE3zmh/YJ0CPuvMirL9Ob1SqAr9kPfOnf7zI+zV5qqXEvNWLr8S0/L
         LyS++lSY0VFduZXJCFoRHJ52WC0MJEiRzOVNymG40wQFTHQUSAl1CYsoJEUsj77X3IGK
         rQJpUxON9X862gdKcZn3ZdAfiS6A9gdk6oE1I7ioLqaH9nQkLCpgsJqc24h2roHYQ4qN
         MarA==
X-Forwarded-Encrypted: i=1; AKwUvBy8xr2fSZeS2gGrj7ozIOC+0jAMp1bhGaANCNs5SNnWq10QcTAeeNbpJBaQBXsI1QIG97lFpSE98RSsEQU/4Tx1@vger.kernel.org
X-Gm-Message-State: AFuF++nqCN9DACK5Po/0dAFxYg8dPpsvzWZltQbgv8Sj1JctRRLFhbVB
	O2vcd37bduy/Gn29v3F1YZWKljoES46NfVG75sxUSMzHe1yEUbeQ12V1PI8foPWguTUVYe6TI36
	M3dacn0HfKw==
X-Received: from dlbqc6.prod.google.com ([2002:a05:7023:a86:b0:143:7a1a:167d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d84:b0:39e:6a7e:ee1b
 with SMTP id 98e67ed59e1d1-39e6a7eef16mr8490339a91.39.1789967316042; Sun, 20
 Sep 2026 22:08:36 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:59 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <1caa73a4802b459f83ef8d4b93893c32d392192e.1789966896.git.irogers@google.com>
Subject: [PATCH v2 41/49] perf test: Migrate Intel PT virtual LBR test to
 Python API
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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

