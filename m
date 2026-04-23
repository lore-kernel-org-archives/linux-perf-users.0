Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4863DB628
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916654; cv=none; b=Xicgma4GqUGJjYQve1206ipy5q1Fpuye+6SMQIySG+FD5A7vcvqYzYjIF9ggST1ngZn5ZsqGksUGsucHwnu83PXA0cTGwZGy3FGuC3E0arOerJyAEa+ndfS5duMfHE8rryB5BtRKHDnhdxpPg/Mxjtjua/Kz/hXVMwzvhifhPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916654; c=relaxed/simple;
	bh=q9qCaBC8SQRXKzJRpTF9IpYpsNVqNFm3u3EPd8mu4n4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DxQhlk15/5d9AfmqLLoAaviJlqjGDF88v8J82w4sx/uIsepG6FRUo5JU4QjENl5ziz+S+G9Nbnb0QoStY5nEP+Fy9WsBlfSodJsWjYMyHpuhjhUVB9pQQ9pYmlnSEntphU+AxsZVaN8YtCw6c3cVfwLhtBBvRYmpaZBnzJYVw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VSHCnSp3; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VSHCnSp3"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so5809644eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916652; x=1777521452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz7KkgG60U+qq/WkEKKVsCqRg/ilLtRWfP0GbIZ3c+U=;
        b=VSHCnSp3IqMihRaFi0j6gM8C0iUVw203qcBjQeX2rBb9seUYGppomwkmj9af313pe7
         DTZg8tMNKuHgk9eCh/VRyGXVBefPYS9ulvMUMj/xRHvCo+EB3MIIrtKSFCBdIsw6l3b9
         Du+Jz4httyVimrvhMmEX+YOz4uuL85Z+yb9QyLYjPV/K/WIl6Sdoc6eAh6wWIQ1G4uep
         Xi8OvAHcf7bF0CWHu72GV7ZWZJZjzRv5TJhEcHJXu+sZjc/GJCTyytVs36V/AECtlYYh
         8VWazqnrKtRZ6tlJD8g06Rfb5gVCkDo5ixDewrBjTviNS+VXxI83t5zu3TNaJ/VkIwQ7
         42Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916652; x=1777521452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz7KkgG60U+qq/WkEKKVsCqRg/ilLtRWfP0GbIZ3c+U=;
        b=MWePsNQElbyYslVeTY6vTEezozP0fmVF32bieFt45kpUmxdEpTZLXr+neuBlPHQ1CM
         olFYZ07LbYMbgJiwDExU2v709z6uGj5TPBnZQHECRVntPAcvWO+sDDuX36PKxnM7HMgb
         rPzCyrjHeR+Cufux6a967TJy06S+5RKLc0Wv5nROTrQh6HjWbKGEEtiJFdXCviNy1PlJ
         RvI5KueGoV00Ua4oty83L/A0x5+8giAEdBhHsD3sluID6Tt0RAsuFT1dwj0ZFP7i7CDe
         a2MrojWVCss360l442GjeWsUAiSKA439tGZrOZpbOeIhWHw1qBIVuBga0/RuYMK57ksm
         m3vQ==
X-Forwarded-Encrypted: i=1; AFNElJ9quufuA0ik2FLNm4zQTkxYGbY7KkbCCgj0XBdIB5hpZ84+NrYyhMxORVYtrLv3NZLASqAULn5MqH8P+CvokCnX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fShS1EmMR5X6WO6lnLMu662XKDp5oqPlTSDVQdjscmhqjDXi
	U+Yf5DfvVWqrqV+z3z93x+uIsRi1aiE6GmUyBxUOrMXudTj9ZsuY0+dmoXCeffIr/eYBPKd3hwg
	ezGovNPBasw==
X-Received: from dybmf1.prod.google.com ([2002:a05:7301:901:b0:2d8:f479:9a89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8005:b0:2dd:144b:6c2
 with SMTP id 5a478bee46e88-2e478e28c50mr10502019eec.27.1776916649006; Wed, 22
 Apr 2026 20:57:29 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:19 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-53-irogers@google.com>
Subject: [PATCH v2 52/58] perf test: Migrate Intel PT virtual LBR test to use
 Python API
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

