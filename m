Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E7539A7E7
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157128; cv=none; b=JA0E0hlSSfnwuSoit2eKI1wBNMRBhv1pskWj02zWht9MkKvtfMy07/H3ig8jKsvRCfMcfll2Da3ONrxeAOmoydmFUlDZxcHxD7qj+2UtNiSwNLxe9a/WMMqAdAY5y7+/9zxnRibnmsh0833uYaxuEyFyZbxvsbRFi+ggoO/VNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157128; c=relaxed/simple;
	bh=ZrJ2nullNFdPahYP4cmzB/NIEZ9UukgcFFOHNvNmBo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kae601bpAxCiuU4JZMy4bniqqGXr8cd64YmecGsbU8ccBvJqSkLcYKt5udA377O1v5f8SxHkQZdjT+Kquvtrd9NKHxotIs1El4d8BF1d7pazvFTMPUS7LcHQ1wbm8agkYfjPqdg7sSj/xKp6HTYzhQkE9bqLpCkkRG8nD7RIJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yl9cA5sk; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yl9cA5sk"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8ccc7593so10493072c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157126; x=1777761926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4cIRIqFZJ5y1BubPplg9oWe019B443zoI45B5rxaHA=;
        b=Yl9cA5skiy+q7KdDnAhziNnbKcd32APXZoO7IA5ONpKiehEntB/tI8f1zDmjqJCrKy
         E6QdPI7xvWbwrT3ZjYq0oAEILzpP+XRMOCSBUL8AhCFPNiRwQ2FdypJQBKrSOgCT6U8J
         A8MuS8gL0wU1/4DiFK+9M63+cB5rEmrDWVhLbb9Zzxr30msK1m5I1fxIzX9Y3l+qJPvM
         TXITIq2aqOKW7VEweft2S/kzs34Pe4zC/2KIk+Bixei7hue0eM2AJuBe0OnQqyJwOICM
         A1lpCy1IcIBzXT/2+5VJ70LED9F+0NtXu7U5dL/4S7Dj0JDBlAoaqN7AXRenH7EsvpV4
         XlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157126; x=1777761926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4cIRIqFZJ5y1BubPplg9oWe019B443zoI45B5rxaHA=;
        b=c31kMN14rO8PcsTwLJXDr/qbUiDSjLrjSf2Ka+MV5dgMNrBNHwmJmEemByKiR2BXwS
         6r5oCOuP4hMd0ZCBUxb/jqFA/nQcDk9Acnq4Ek2nCcre26XRdAb+EFzJBdbpYCFXm+CT
         R+TpTgMi4W/PVKiKeJDVNXSOp94VaZUvH84GLJF7O+x6fJcsxjSLYb/dEN8WqME36RQu
         fXaH5NDcf5SoqbPq+XRrBYMjhhlNRphgwGgpMzPUhEIkz7zFCZFv9aOd8Eh4XiggbsPO
         KcY8opTiXGWS2dtn/LPGf4ZEUNx6eiouRk5wJO6S5+gx98ttGyF5XbGnk9AB6f71q5rX
         z43w==
X-Forwarded-Encrypted: i=1; AFNElJ+p95AUTLbBFgqatxPXZ3+AX0APZYB11/dlYnuVZsLyKZO8l0JaDlQzOpOPidG8sNDDvZ1WUTRIUvN/xiU1f6gN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1RMA54CMqcynENUIii7CxS3T/t3S39cH7ZtzNOaZTcEVDKV8
	2VBbyAhzH9oYBULszRf8iZX6qo+kyDS6L4z4pKHgJedIwIyOxQeTK6f1EMPxui6JK2+BJf3rKHr
	Z60O7QA5pXw==
X-Received: from dlam10.prod.google.com ([2002:a05:701b:208a:b0:12c:912f:7d3f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:383:b0:128:d4db:447a
 with SMTP id a92af1059eb24-12c73fa73e6mr20056887c88.29.1777157125536; Sat, 25
 Apr 2026 15:45:25 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:44:56 -0700
In-Reply-To: <20260425224503.170337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224503.170337-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224503.170337-10-irogers@google.com>
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

