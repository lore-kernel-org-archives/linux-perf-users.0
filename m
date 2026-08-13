Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702AB47142E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655483; cv=none; b=EOdQvgiCT2ZkGa6x0TxEp4MD5XcxCgGXg+IgukaoSB95wR9BLPDKDgjYhTDSd+z53ZboxUFzNDwxuDHNciXhPjIQBNYAB+H9P1OhL/QI7BMhzE05bANO/Y9oxqmg0nKXv2eI8YQseostnCDlKdNGSDpqlzuLEyxQFDMuhfuBi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655483; c=relaxed/simple;
	bh=DrLm05uQYf9SigOs+2FvTWUMJmNw0vqGNkpwdwF4t/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaRc/AYrQD8MgWW3TmFZu9mk3Y5NBrOveIUo9flD/V1IOBIPg6UQ97zSa59YA4porjHnC74VP+4N7apzyuygFviDbQYZPtkHlbbbjpRN7AUqEIPblHskpA0yZ3R2B/zADDosqzJNJS7LqmMse6VfrXgpGCCRsViEd1wbPnFukXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWB1WBbj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWB1WBbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786655481; x=1818191481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DrLm05uQYf9SigOs+2FvTWUMJmNw0vqGNkpwdwF4t/g=;
  b=SWB1WBbjMPDr/1l9w79UBL1zxXplmHROrzp4D/LUyUT4Ndz0FxR/wqO6
   WdOVqsWCqgOtE8RVNL9YVW+muhJPby1C2I4Y8+hVjiXFWBw8xXvMB07M7
   UwNEIeNa43XwYvCajGOR7/Uirq7Phap7w7KQgOB3tQqA/mhmljvW0h3JA
   2eMFacKvWjVgN3pmVo/rNb9PEm+mMD7Wt5nugAVDBA4J/VBty2dZjr1Z0
   A9fgAbU1zKb1glSKb4JSqcppH0uviNqGPonO93TtodmTeJWQKUWI6bEf9
   0p4UKt1J5eFG/aZn1gOWAWuIEU/TZWD4YgGoib47tnDxUmY6raijRhfnf
   w==;
X-CSE-ConnectionGUID: mBcZxXRZTDqi3SwflS0cjQ==
X-CSE-MsgGUID: h9rXukC5TOaSmgSDEcTpFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89760250"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89760250"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:11:17 -0700
X-CSE-ConnectionGUID: 3iOpJnFeRC+tSI6ArddE8g==
X-CSE-MsgGUID: sgEY0HZdS9mOHo8EAHXxtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260773092"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:11:17 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 4/4] perf tools: Add test for weight annotation
Date: Thu, 13 Aug 2026 14:10:10 -0700
Message-ID: <20260813211109.240689-5-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813211109.240689-1-ak@linux.intel.com>
References: <20260813211109.240689-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case to check if --stdio weight annotation works

Assisted-by: omp:GPT-5.6-Luna
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/tests/shell/annotate_weight.sh | 63 +++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 tools/perf/tests/shell/annotate_weight.sh

diff --git a/tools/perf/tests/shell/annotate_weight.sh b/tools/perf/tests/shell/annotate_weight.sh
new file mode 100755
index 000000000000..6b8c105c048b
--- /dev/null
+++ b/tools/perf/tests/shell/annotate_weight.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+# perf annotate weight regression test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=tools/perf/tests/shell/lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
+testsym="test_loop"
+skip_test_missing_symbol "${testsym}"
+
+perfdata=$(mktemp /tmp/__perf_test.annotate_weight.XXXXX)
+record_log=$(mktemp /tmp/__perf_test.annotate_weight.XXXXX.log)
+report_out=$(mktemp /tmp/__perf_test.annotate_weight.XXXXX.report)
+annotate_out=$(mktemp /tmp/__perf_test.annotate_weight.XXXXX.annotate)
+
+cleanup() {
+	rm -f "${perfdata}" "${record_log}" "${report_out}" "${annotate_out}"
+	trap - EXIT TERM INT
+}
+
+trap 'cleanup; exit 1' TERM INT
+trap cleanup EXIT
+
+# mem-loads:pu requests a precise user PEBS event whose sample weight should
+# be populated by -W. Unsupported PEBS/weight PMUs are skipped below.
+if ! perf record -W -e mem-loads:pu -o "${perfdata}" -- perf test -w thloop \
+	> /dev/null 2> "${record_log}"; then
+	echo "[SKIP] precise PEBS weight sampling is unavailable"
+	exit 2
+fi
+
+# Confirm the PMU actually produced nonzero weights. A successful record alone
+# is insufficient: some PMUs accept the event but provide no weight payload.
+if ! perf report --stdio -i "${perfdata}" --fields=weight1,weight2,weight3,symbol --percent-limit 0 \
+	> "${report_out}" 2> "${record_log}"; then
+	echo "[SKIP] weighted samples cannot be decoded"
+	exit 2
+fi
+
+if ! awk '$1 ~ /^[0-9]/ && ($1 + 0) > 0 { found = 1 } END { exit !found }' \
+	"${report_out}"; then
+	echo "[SKIP] PEBS weight sampling produced no nonzero weights"
+	exit 2
+fi
+
+perf annotate --stdio -i "${perfdata}" --symbol "${testsym}" \
+	> "${annotate_out}" 2> "${record_log}"
+
+grep -q 'Percent Weight' "${annotate_out}"
+
+# The second numeric column is the rendered average weight. This assertion
+# fails on the original regression because calc_percent() left it at zero.
+if ! awk '$1 ~ /^[0-9]/ && $2 ~ /^[0-9]/ && ($2 + 0) > 0 { found = 1 } END { exit !found }' \
+	"${annotate_out}"; then
+	echo "Annotation output contained no nonzero weight"
+	cat "${annotate_out}"
+	exit 1
+fi
+
+echo "PEBS annotation weights: PASS"
-- 
2.55.0

