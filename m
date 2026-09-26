Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF1C3B14A4
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403746; cv=none; b=s+NyhpNrkDl4DJVAAgfWFrBvJOPRVKnIcD9iiQ59Fxfq3I4Tp9PYWeNRK4FHg8wNx4OTNBnQdSGZK0B+E5Eedh6AldwOT8Ahw2BZoltCr5iD9Eo78mjFr+tGjBgq/SyDrN9rALaV/CkXnJ5T0bX4Jp7qQRlxxNSrrT1dsjDliEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403746; c=relaxed/simple;
	bh=n3AikhSXtHzEAWWtxgWfcjl5xlu6Twp9Gx3lc+63O84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e2c41GFxROSThylyB+RMr5z4v25K8sMjtW6w6g2s4e4/UYfCLA2XsCXGBOB3wV5l+STcNyNY170sNDhLrZ+HHhOe7TcOjaaZDbEGX8p1S2IeeIJs6C1w7+s8Wa8aQdrSB3dXJ6INTtO69ewovoZlbX5zUrYrLAGmVUd2lS7RuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iOSqdZs6; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iOSqdZs6"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-142f4306744so4686718c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403741; x=1791008541; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FA8zfXKwkZjeopr8gq1BO6sSlKbNkbRzzuqhiBRxtis=;
        b=iOSqdZs696Pa4rD7lL5Dic4meORtwoYumpLGccBgT3Yo1GuDj2gfUpEM50XUQ6zDym
         tM+h/1ZyyqLP3vkc4y9VO8ceH1jz8tSqw104ukpV9R4qnorS4RjMWzH0FDYvCGWoHQ7X
         C9JBxHNOO1peoSqRlKKbFkOvXdiSl4/oCpy04BEyhwTmGnoV6+1Pr5PDmTI+qvMbmqtM
         K4OyySlQTTzvccchw3dTFYScC9CZT1+vWzwHUfwIqiC2Mm355AilxK2UVLn1/gnfXuRr
         NhSWdasMj7nsxDNZxB56hi4UFMyFq3u7qlC9k5JHRvGr5UMcsby1e8zSmBGMFN8PM6wA
         HknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403741; x=1791008541;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FA8zfXKwkZjeopr8gq1BO6sSlKbNkbRzzuqhiBRxtis=;
        b=FmpTT+YU10QHP+Hfy61CBxHEscraECXREuoIhSgXqfOYNH3/YUIMAhTVO3nzx4GuwT
         PcJXjAwgpEEKzmOPpkOZ5zSsfTiUO4jXRYPxknyrsqKYDp6GIYFacyhjZTgc6o42Rrb7
         QslTPjg4bvjKaYejDa56AtFSvCOz5s7JA7jZvX/0UdxahIxuK4W8Jrh1fxzNh/q+6bwL
         kbSXdDUDG0LQjBn+RDfHHiOZ3sN4gMGCdkjesBZh2T1qw8ycmHE48408mo4VOEE39j0C
         IRRJDrtYafEzJTAJLGm+WL8hhlB5UKXl6StPcl253YmymmkVOYJhaxdC+EdpF2pcgB7h
         A2eg==
X-Forwarded-Encrypted: i=1; AKwUvBzP0D7jR+vhph8rVtgWu5yL24b1qE7CulmfZKzWHMsKfCl54WWumc5+mgxIeChvYG19mBzMZ1AxkTmfkLp0oZI8@vger.kernel.org
X-Gm-Message-State: AFuF++n/53ySKJNG8g2whn8ohG0p5QqPg+hZBN0lK+y5C4prQJ1bkFVx
	a5t4ZBuLbvku6JLpC+kpOplEYyrO3qsOJaYAQoq27mlHW4N4W8oB3br5UWr7RCUN6TgBMgyH1y6
	z9E/gCgBkBw==
X-Received: from dlbsw8.prod.google.com ([2002:a05:7022:3a88:b0:147:cad:f1af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:424c:20b0:143:2984:6518
 with SMTP id a92af1059eb24-146d096b0camr2170294c88.39.1790403741142; Fri, 25
 Sep 2026 23:22:21 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:20:08 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-42-irogers@google.com>
Subject: [PATCH v4 41/49] perf test: Migrate Intel PT virtual LBR test to
 Python API
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Migrate the Intel PT virtual LBR test from generating an inline legacy
perf script callback to using a standalone Python script
(perf_brstack_max.py) with the brstack iterator API in the perf Python
module.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/tests/shell/lib/perf_brstack_max.py  | 40 +++++++++++++++++
 tools/perf/tests/shell/test_intel_pt.sh       | 43 ++++++++-----------
 2 files changed, 58 insertions(+), 25 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_brstack_max.py

diff --git a/tools/perf/tests/shell/lib/perf_brstack_max.py b/tools/perf/tests/shell/lib/perf_brstack_max.py
new file mode 100644
index 000000000000..cc065f07cfed
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_brstack_max.py
@@ -0,0 +1,40 @@
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
+    session = None
+    try:
+        session = perf.session(perf.data(args.input), sample=process_event)
+        session.process_events()
+        print("max brstack", bmax)
+    except Exception as e:
+        print(f"Error processing events: {e}", file=sys.stderr)
+        sys.exit(1)
+    finally:
+        session = None
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index a2e87ef09593..c0ecece0a825 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
-# Miscellaneous Intel PT testing (exclusive)
 # SPDX-License-Identifier: GPL-2.0
+# Miscellaneous Intel PT testing (exclusive)
 
 set -e
 
@@ -21,7 +21,6 @@ perfdatafile="${temp_dir}/test-perf.data"
 outfile="${temp_dir}/test-out.txt"
 errfile="${temp_dir}/test-err.txt"
 awkscript="${temp_dir}/awkscript"
-maxbrstack="${temp_dir}/maxbrstack.py"
 
 cleanup()
 {
@@ -375,34 +374,28 @@ test_kernel_trace()
 test_virtual_lbr()
 {
 	echo "--- Test virtual LBR ---"
-	# Check if python script is supported
-	libpython=$(perf version --build-options | grep python | grep -cv OFF)
-	if [ "${libpython}" != "1" ] ; then
-		echo "SKIP: python scripting is not supported"
+	# Run setup_python.sh in a subshell first so its 'exit 2' when Python is
+	# not detected skips only this subtest rather than exiting test_intel_pt.sh
+	# (which would trigger trap_cleanup and fail the suite).
+	# shellcheck source=lib/setup_python.sh
+	if ! ( . "${shelldir}"/lib/setup_python.sh ) ; then
 		return 2
 	fi
+	# shellcheck source=lib/setup_python.sh
+	. "${shelldir}"/lib/setup_python.sh
 
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
+	if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+		echo "SKIP: Python perf module not found"
+		return 2
+	fi
 
 	# Check if virtual lbr is working
-	perf_record_no_bpf -o "${perfdatafile}" --aux-sample -e '{intel_pt//,cycles}:u' uname
-	times_val=$(perf script -i "${perfdatafile}" --itrace=L -s "${maxbrstack}" 2>/dev/null | grep "max brstack " | cut -d " " -f 3)
+	perf_record_no_bpf -o "${tmpfile}" --aux-sample \
+		-e '{intel_pt//,cycles}:u' perf test -w brstack || return 1
+	perf inject --itrace=L -i "${tmpfile}" -o "${perfdatafile}" || return 1
+	output=$("$PYTHON" "${shelldir}/lib/perf_brstack_max.py" -i "${perfdatafile}") || return 1
+	echo "Debug: perf_brstack_max.py output: $output"
+	times_val=$(echo "$output" | grep "max brstack " | cut -d " " -f 3)
 	case "${times_val}" in
 		[0-9]*)	;;
 		*)	times_val=0;;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

