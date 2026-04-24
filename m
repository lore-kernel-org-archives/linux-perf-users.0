Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02903F0770
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049377; cv=none; b=GChUfsZrW9b7eJ++eAoxadV6OQCD+JVdLuUovIzmLNf0plPRkTLXLhjPmitn8L8jthk/nS144C1PhKiibipc5hJ+qx6wRbguktACGPF0HxrjLeOq7gtghCugeXgVbBxn5WYrQSW4zlsR5PC9CvaNrjQyLet7JsE30xtILZrneuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049377; c=relaxed/simple;
	bh=YHgQWzpsc79DdgqSEtpQwKd7Uqoexl9NyhBl34zHDz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ju61BfSub4cNqi2a3xkVVMDU2c6RgW7JxAQAjP/M+mLFLddqyUDcfLucndzunXiWqlDrHDPm71lH5HueYeEzT9UQcddOfi3Ik7VXQhB9JsZCTwdwRiUndDHhBVa8lOhYjksEq9vRJ8zRJtQqNfL9G2gYt6xWGi2XbR5SM62NH8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFx07oEk; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFx07oEk"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-126e8ee6227so7673055c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049375; x=1777654175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBEf1HaysC/cBOoYLsmf2YO5C7JIY0UsCgKYW3rfZDg=;
        b=DFx07oEk5tred48UvE1zpY3+WLegq6fcws0m7gPvqy3TGAeDG+WeensM1MNWuycn+r
         fwfUPfKC3oXaerv/+ZP6+G5yqogqRX4DP4//IJ03vbztvVzI9LtmDj9DXsqryrke5m+W
         z7TR/VmgVvR6IMJdyGbwW89tnokvDBl2E4+9+QgEtpPGlfYVfGqDzNlYJVwDy23eb1c0
         Q7YRrIsEgQIEStRoTlpS/zf0e1Y0e0pgLEKSRDhLKENLt9mUEKEikJc9I9oDT4i7RF/B
         b9H7iAl0TD3A0Ut/uV03cxxXCDX+4CY7ya9w1zbqqCaBKCSTY+PTk+1+2QnLpZKiYz5y
         CdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049375; x=1777654175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBEf1HaysC/cBOoYLsmf2YO5C7JIY0UsCgKYW3rfZDg=;
        b=rEX0gPjQ8ie2ky3sim6jiOn5Wg3s5JFNPEOLI/tLA3SGnKZhY85O6nsADWqvPbDnSq
         qpRJGksZGlUJ0+2AXqG+h9BtD79LGWhwmx+Ht6ThtgYh8xgLsGXkhxmAbn56qkgb/OyR
         bkZI4d5w66WaSDr3ClpLB0K60H1D5WyYmQq9/Ns77BDxGOZR5NiZ2eOxJ33kd3Mf7OLD
         q5OVibkjPNHF1p4m4AFVYhgYm7IsPU0DGES7h7/4EyHbfGoEpEWRuQOBiEV71LAkfmDm
         6wFYNUbLzhKNdHPXLouJxzOmBVxpZWCQO+p8GwHbWVORv+zrJsX2jSwLUD7yOOQU3TgG
         CMaA==
X-Forwarded-Encrypted: i=1; AFNElJ/qhOnoAUIvepvDt1ryoBfq4qZII8sam0fkeIyO0TRgKoW0oc4+uL4h+3BpMo3e12CgnYgprHCAziusufTdoP5F@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfbcZVoSAqFIl7H5xFWTYBpRnWsdPRpdZX3/rEWhm90dI8w0G
	G3xZ5E/ZCUhNSC83zOPCaLpUynwXAkIJSSoorVP0ZbwzhiaEAgxCLZ7oJjr4srA/7ne7lL3vbGu
	vDXsHpTnJAQ==
X-Received: from dlbts2-n1.prod.google.com ([2002:a05:7022:b042:10b0:12b:fe5e:215])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6884:b0:128:d23d:81a7
 with SMTP id a92af1059eb24-12c73f64315mr17189403c88.6.1777049374784; Fri, 24
 Apr 2026 09:49:34 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:14 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-53-irogers@google.com>
Subject: [PATCH v5 52/58] perf test: Migrate Intel PT virtual LBR test to use
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

