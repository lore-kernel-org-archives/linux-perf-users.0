Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223C3BA226
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960717; cv=none; b=gH2yePn1g60KfZQQ+eNSunmuoYNRvEzThL9Itwfvy4p/K8iblie+CJdnlJkHw8NMi/gXe3NBqgyha4BDTfdHLjBEcqsgAQ+NDTbi0vox35iLQEquWQ3bSktFBCguxZv/IHjXobwNl8vIZ8yvlyU38buveeUrHGR50DxW/HTxgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960717; c=relaxed/simple;
	bh=q9qCaBC8SQRXKzJRpTF9IpYpsNVqNFm3u3EPd8mu4n4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ko8GXpvBSghgFuSNYmilJCbfCeFK8h7o8zbVmsyNAwjOPz7gdIMJyGva3ekXehNDa62yt9dpE2ARp+BhllFg9Auj/rUu/th+tKtIuaaiSjPAz830d+nyjSP/+8UpO8DOxLPZnk2c9JVftRJYsHipp9g38zJ17ul3IpW0+tBpY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdKFCOcb; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdKFCOcb"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d889997495so16326031eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960715; x=1777565515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz7KkgG60U+qq/WkEKKVsCqRg/ilLtRWfP0GbIZ3c+U=;
        b=gdKFCOcbPF19nm93MiSUQgu4G+mzHa6KZS1G3hNVkuxGGAnhYSXQgWSYVdWgOzFieO
         8rSLGWpK3EiEeWSITZm9Zo9aMu5uXitk+/rZtGeeJmYOnOlYLOkvlS5E2G7WmipH9ep8
         +YIfcq5smWRlH6ZmoxS+474KeHca/gsXarLceb2ri8wIBEz1+Qzcb+afs1dhRZiUtVgL
         EqQg+pK6bMeIANEq7fJdTg5LYGHxb690tplzVFanEqiywFiJt3FO71jNSPmnEVRhHwA1
         1Cgwl8V1m7Scf0v1wp2el1Os0mLO3syRa/ibDfNtr6bNK0mP15nx0b0j2diZtNJGY28u
         6K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960715; x=1777565515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz7KkgG60U+qq/WkEKKVsCqRg/ilLtRWfP0GbIZ3c+U=;
        b=KIvilI6tPYrGcW+Bud5unWqTp/CI+V+kCHbqF3OV1xPMeAHFgQ6hsWRgWC4JPkw6D6
         isLAn7b2QADgm4rYz0886tRuxFCssS40ztCv1PmUbGDXpth1MRPLikvqjm4HtFXBZnzP
         dT+vhRVd/rrdJvBlmvllzZYj2/OHFitWLUOsq9p2TScVjaP10MNnJa+zsodQz+MX3hnp
         nYFB1IEztjXvgM473tTVEyPjRP+LmqUTyu5/6YVGqIpSSGOK1CRe+x+w5pL52MlUpbNl
         mdn6jpMkRLw+J+unx0pGyA4xhd9Ta1X5PbS1yX2ei/bIeTe7sJAOe2NPqtwmQ4ub430Y
         Mucg==
X-Forwarded-Encrypted: i=1; AFNElJ9AeCTC8RPaTPCzXsGgJiVYZfqIFSYGq7Y53MSCvEVB+0PsIWNGu2xn/hVTSfBL25jf8V7P1L88DP8DiNU4193p@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8a5GoG++vPJT2haODCZkqgC6KckhK8Dr5EbHRNsj6T8hCtgBx
	l1kddRbMAzOMYgFkyhT+LOQ3/eIj+2RKr+b6yyG1Qc/pwbzxmcgVV1HUob8qhtFU2y98v+oyZS9
	vG3Nwefe4KA==
X-Received: from dycnm22.prod.google.com ([2002:a05:7300:d196:b0:2e2:2088:dca7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fa10:b0:2e6:e504:5435
 with SMTP id 5a478bee46e88-2e6e5045e56mr8106299eec.12.1776960715172; Thu, 23
 Apr 2026 09:11:55 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:58 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-52-irogers@google.com>
Subject: [PATCH v3 51/58] perf test: Migrate Intel PT virtual LBR test to use
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

