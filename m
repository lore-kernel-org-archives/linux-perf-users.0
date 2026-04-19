Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4AC346773
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643284; cv=none; b=V8m6rkdnpCwKlM2ZUFfU/2y/0QHIXz5M8L+a2IvqrqV9PMYHtrmr4viNqUr8CNTnt/iojRKczrFRjCazCAVwnX73SUeMQgq2ETMe9VxEmuPvZbhMrXmiBCUbd+6Ztw33uvP44Nu7Nwia2M1XaG0N3MQF7Qbg4qaWFhwr9NLKS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643284; c=relaxed/simple;
	bh=6LB1yzq5Ho1rErrVfSTPs2fgnqOAduEGynC5Jxhpw0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P2ykgzStT+qHHDnYb0nFhm0PACV7IpwcwiVpUhfMsJengwRqCJwpzmjJrrOLRKDyJT+0Kai/hhfM1UcoXeiN2vTMSsqrYtxDJD0z76tQaREEu79A9hbMdiLMntx8jtKQ2SqxIN30tHtQ4u5R9DtyxyOekir7vmYB3GZAiIUHXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhQ20tjl; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhQ20tjl"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c8ccc7593so367156c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643281; x=1777248081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmnIjzASzZO0InMKsKr1KOkNFSKDQz5refCKbhu3+qA=;
        b=qhQ20tjlTN6hqQk83aYi3l5NqD51NBxWHMw4MYFpeMa8CVwQfxOB5mKyKqCndrbF3f
         SqwrpH148nI/tExAZ0SjXeAqohQfsxIz2gX7NpE45GxBQErcouXTWREq/f1n3YWUl2Am
         dBJeGIELmI2FI6Q+ecU8YzVO6DdOH160m/6d3nIkOqXc9QewqZ7lAwynNhqAHOBOmHEo
         FNJIY+0uSWyjaM18GG5+4ZZ3BDsxRRw7f1vIgwumtgHAStZLrz2ZZfyqZICz4vVbxel5
         9nqU+UhFbNCsTFWDIuTYX+2ayLYaJ0qJjIO+XOyQJFsiCrH2sg4g4VhzCFwyvv0lwgyK
         Xlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643281; x=1777248081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmnIjzASzZO0InMKsKr1KOkNFSKDQz5refCKbhu3+qA=;
        b=P7k2G6K4fui+oQGMIJHLOPFPMvMyQl/8mutVjLsRS05c3ZNEWisbOINh2J8ygNEMaS
         lpLk6nmD8UxBtZm8qf3hOxW6KcxoJoU5yYqdPOj2W5iGomxVJcMgPyChzeNrpbHqUrDb
         LM7GqR0L1+8ibgq15Uct+5K15pUDnm+tQRoRICUzrnSVIAhBcdmPZaNMg6F7kF5Ab3mU
         Bz7w/Tt11U5tIVPAIDhe7GseXQdo+RYYcORgMGl4rDwVWJTEq8NB6InTWFweH/jhYRiY
         UlVtA42MwGAo+UpwyM4eRyT6PwQsycb/nHb9PnwCWMYskNIyBMdadLf8v+mUcFRlCnoo
         TTbQ==
X-Forwarded-Encrypted: i=1; AFNElJ96f9J/mBtrbIK7hmqI/qV63l+vqFZlJQRWRq5gOZ+zt8PRgn6/rWFy8WBfPmqXTItBnFo1priUE8EH/LuISd5i@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq8FIzcUjk8gVCYCPOzgb7yF/OlxkUui+Ty3J422rbeXh9tOAY
	zbAIsncOpWO6qvGirwt/AvXE81Y+sgC08jx5ryClHhn/i4iG847kRi+1vV+KSZaKpBoiGh82SCH
	UNo9gUEiMIQ==
X-Received: from dybqf21.prod.google.com ([2002:a05:7301:6495:b0:2d8:b1cf:5d12])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:103:b0:12c:3d30:37ba
 with SMTP id a92af1059eb24-12c73f9bf03mr4651099c88.25.1776643280566; Sun, 19
 Apr 2026 17:01:20 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:59:04 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-53-irogers@google.com>
Subject: [PATCH v1 52/58] perf test: Migrate Intel PT virtual LBR test to use
 Python API
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
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
2.54.0.rc1.513.gad8abe7a5a-goog

