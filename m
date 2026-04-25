Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4037B023
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139447; cv=none; b=Jp+6L6h1F7aBh4I0RGhwaW/Du3v4ATJwI2mMHRifJ59Ch3iSs+UbdWkc8KrVrK9c4aLTSwrTT+URofYFxA6RmnItA5QxP5CLR/Mxw8uSxQNiZFFcjkYibQZLr+kXsJ2chViaUlg/uY389lSDQ4t4RQXB2AUgyYoh6+sLVuoaUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139447; c=relaxed/simple;
	bh=YHgQWzpsc79DdgqSEtpQwKd7Uqoexl9NyhBl34zHDz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EFKfgFyDK8dIvBk5DLy3tqNg7qEEJbSClF0mduvyAolNVBzR9HYVROQ2IQctv0iFmSS/UZ34jGEs2wnSFIo8h24Op5TemozsvLtx2V+XaSzYLN2BbU88uybPL8uocZ5Sv0AaLo1K5gOqwGN7IGB6xdCqwLcGiNmIWn54uO5/nFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDg1Eryo; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDg1Eryo"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so12314377eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139446; x=1777744246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBEf1HaysC/cBOoYLsmf2YO5C7JIY0UsCgKYW3rfZDg=;
        b=tDg1EryoN7iE/Cg51H1OBcHLKYZ2m+g3t9AWaWSYnDtu9d5HjEYw7tY/IMuKRkW2u0
         7LWO8S4QYUGT8tHZ24C5Pa2NOVSgxWQOPAUxBTdMQ86w2e0T4yorxLH4KUAdjU0gLDFd
         4E06RmKwjaHeg8g/bR/if06Z0TqkAwiuNhJEptdVsTmOv2A1/reRGwTXP4W/BrBLp9OH
         nOTaH1tveVfsk6xj/aRDJSaElfIvy7elUM336YL9pNJnfWGxXSCZDMKnCy1B2pHGz3oj
         Iz/airIgQ+j3pJTw13+q5vDfUlvq29kKqT2oVw88j/lJqGczLKfjjxNFALiYmVi7qwp+
         Y3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139446; x=1777744246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBEf1HaysC/cBOoYLsmf2YO5C7JIY0UsCgKYW3rfZDg=;
        b=QMx89MJfafpo1x30IRSozzUwSvBtpZA+MehcMSI6Q0zQSMqQ9PLmHPk70Ae34E2d5s
         A56wCL/4me8JKuBvvGPjbYcDXha9XzTaCyUkFz1hEEr9vK3w3kHDLFL1ISfy8gHzXm2x
         8JGmWtjnX7nrXj5f/Q1cla+pcge2Y5h+pGvffRtsxcPYeB4uV/aGlzvI4pQZDHLOE9T6
         4Sel8MJAKs7lBIXYf/hL7Vlwebqzti3x2LBKV9rioiISGbVkCGwA9f6NZ70CDgY+uyWM
         MqT9vTJ87r9k+7HsMyGcji+UonGO3Dnb8wumG+IFkBC99ZUUUKDhw3LLqnfUco2i8AtU
         iv3g==
X-Forwarded-Encrypted: i=1; AFNElJ/2gcPNen8qO0YkQY7cbpoX5kGTZdJbbKvEvhEOShkxctWzpc/yYkMsljlSv06zMmFL2CnytD/xAuqCVpAeY8q9@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsHcpxR773gJ2Zr1kZWP1ja8IS6OsPy2TGmiPANWlmPV5kzjn
	fmUdzJRLFKwgfkaVoid9+oVMWHpllfUJKo5ymf1Tkv3b2C+ZFN2sDlRSkLYuZjcdLC0ps52gJgw
	5bzcgTvAFJg==
X-Received: from dldz5-n2.prod.google.com ([2002:a05:701b:4185:20b0:128:ed1b:481d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fe04:b0:12d:b175:2573
 with SMTP id a92af1059eb24-12db17526edmr11537724c88.7.1777139445523; Sat, 25
 Apr 2026 10:50:45 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:50 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-53-irogers@google.com>
Subject: [PATCH v6 52/59] perf test: Migrate Intel PT virtual LBR test to use
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
 .../perf/tests/shell/lib/perf_brstack_max.py  | 43 +++++++++++++++++++
 tools/perf/tests/shell/test_intel_pt.sh       | 35 +++++----------
 2 files changed, 53 insertions(+), 25 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_brstack_max.py

diff --git a/tools/perf/tests/shell/lib/perf_brstack_max.py b/tools/perf/tests/shell/lib/perf_brstack_max.py
new file mode 100644
index 000000000000..c826e14160d6
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
+                n = sum(1 for _ in brstack)
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

