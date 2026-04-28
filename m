Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577F4219FA
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360865; cv=none; b=aUNH5ZLkr0s05YIdlBiyN0a7G80SDb0vXGStMdi7UZlE2eCPkgdnLxs7/nPxP7hJ2coS0ume/y/njW3Znj8EP6WulWvOwnmwFYt7kiGnh+PhtflC6MS98H4oWB/B66EVJ0OXp1Eiq4k1nxmwO8/SFD91ywDCMER0KO4UCATZNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360865; c=relaxed/simple;
	bh=ZrJ2nullNFdPahYP4cmzB/NIEZ9UukgcFFOHNvNmBo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ipeOrkynI7vpFGNyqbQ7k+q5u1Ve4FRzcIHJ4yQEj7SWrE8hp6Gxg4S3PZTwbFjDxyuK5hqGoqIqDJZkTXkEGJDSZ8iggZ/nSL84xBMk9ntbrz0OYn/hixN/5V+tHQI235Pq06NNwRvnV5lALVO6fVLLCXSxDdIfl2Es4xXOmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnlrWj/X; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnlrWj/X"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so13393755eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360863; x=1777965663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4cIRIqFZJ5y1BubPplg9oWe019B443zoI45B5rxaHA=;
        b=KnlrWj/XoFanqxBMV4BJ11W//ACFEFytgNca1A/toHKNhelUGySn5u+WhAUVXzJw0q
         /YNQX8Wfo0b4SIfbFBYInDPet2Wo5SS++9mm9LeF5S3abH5XsxlmxF4CHtPzf7kzuWkt
         OsjFXacZ7jgD6U1gywKy/4ePAkWWeQY37wdtvRqjbD4E5lx9iZkQa1Az6blvzh6jCrM8
         ZbuPvXx7HiObCYWHEd/KCfzMaWNZ7jAvZa+voqeXPu9y0E3Q0ipgHcmF1uBKvWYvudmc
         +s6CCyDS9cW5hC0eKJnWK9cI5Hh8Ek/T2FBH6+0WZ85JWZkmc837OG9TB1qK2CWlpIZ2
         ybLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360863; x=1777965663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4cIRIqFZJ5y1BubPplg9oWe019B443zoI45B5rxaHA=;
        b=HeeUCSG7r8TQGatzadBmfA6oYIKau2Zw/ESESS52FNSZ8geEmMP8SObNSvLBSCCdTH
         +yRJI15Y3QlFlpA2V4TSVm8R/XEByHYSROIV7FkhAVUERgWsExrMc2XdGNAISkFqgp6v
         gNUoCoBshb9OY8aLaETn1yt3GZm6qu5i44TGlKXqXb2NtIt3D+EgONxYoRxbOi0BbY6Z
         /Vho2KfHbV+Miqy9V8VVITadMqoJWym+1c5abs0fnsW+fqaUZ/oXjbumI40snvzOYFIf
         ahzhPwci8URGIr8xjQAdaG1MtaCKQruq9hKjSU75KMeHibNCdSmv7FljzgjWDd0PXuVb
         +1FQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kAIgojuOHcLaK7L8UJgsfxMITxfjBO3wobajEw10XhW7Pfj6qU09UNy/l9fE+dIWRaxDtoyANvqgMrZ9d1kJQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHv8rz+ZyMidISuIFaqfQJ23dSSJIy69HfEAKcYd5x3ZcRXLg
	9tIEvG9ygSShtm/RvklBEfWeJcNXwDHL60pjVyzTNW2Ub/hfteSi0krBoToE10E1AUXNeGP71Ou
	E4XJbNHJbTw==
X-Received: from dycnh13.prod.google.com ([2002:a05:7300:ce8d:b0:2dd:3fe1:f5b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2b06:b0:2ea:ed70:3ea8
 with SMTP id 5a478bee46e88-2ed0a2680a3mr1095594eec.29.1777360862799; Tue, 28
 Apr 2026 00:21:02 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:57 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-53-irogers@google.com>
Subject: [PATCH v8 52/58] perf test: Migrate Intel PT virtual LBR test to use
 Python API
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

