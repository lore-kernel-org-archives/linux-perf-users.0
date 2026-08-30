Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7F4309EE7
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788118515; cv=none; b=d92BtLMvz0s8mOWg5htRYuwp3TSrpj16wfY3CHGVu1qZEXKNC6rtKPoEdpdQkCip6PGqXZG87BrK7l1oV+nkV8z5sF4QPUTqEgoBKdYc8WfEG5BGZRmsM/aPSm7aL61+g659Jc3ky/y7x1CfuX8cNcm+tpEww7VYqYcL/Bymfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788118515; c=relaxed/simple;
	bh=DrLm05uQYf9SigOs+2FvTWUMJmNw0vqGNkpwdwF4t/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sElSVfnc5dI5tu76LgmlNpABnUcEObq6kahKFjH+ezNy9F+OgjXZ/NHqTk7dXdqaTS5bneRGzVrgBxWUs8WXiguNAHaagAZESCl2wZDy0/71nfuuHVnKA0sbUw2aNKo8lIGN7LLyGCuHW/nUY8KFdihwBE3DppxKQMAGwKKxv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtqcTHrM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtqcTHrM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788118514; x=1819654514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DrLm05uQYf9SigOs+2FvTWUMJmNw0vqGNkpwdwF4t/g=;
  b=QtqcTHrMM2YcAFaZ+gwyY8nSu8PnTy3zYvig0vTCZltIgt++pf+j7rnp
   trr2xUw/GwiHAHB6a+sgAH3reSVCNcy5F0DtZSBZ44Hj1F4YC+JubgZzC
   WOt+jbI7iQBpFZoO7OBOex5/BtcESOYKnKWc/ziZ3tkNLsqzbGFbwxlq2
   5K8g2WSGGGvLSx2YCEogTH1BqstneCnL5eACDVbgxRq3OivXwtB30nwkA
   eVroAScbhZgzh5BXY0i3nk/mWOFK+yQ2vZeCZNo3cRWDOyG6RKFP3IcAT
   rvET+624hZFAfNiqjL+DHSEXe8w8olJsvhD9KkoeeUbVtSC0YtrOIfMyE
   w==;
X-CSE-ConnectionGUID: L+HLzOJ2QeamjMIsvKdKDw==
X-CSE-MsgGUID: i8aUe+b2R1SClMScGrStpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="87667340"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="87667340"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 12:35:09 -0700
X-CSE-ConnectionGUID: XE4EPFtxRN+ChI8ziRBmVA==
X-CSE-MsgGUID: YL7LMr1DQ3+hmFU6qDli8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="292118657"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 12:35:08 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 4/4] perf tools: Add test for weight annotation
Date: Sun, 30 Aug 2026 12:34:40 -0700
Message-ID: <20260830193459.2840519-5-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830193459.2840519-1-ak@linux.intel.com>
References: <20260830193459.2840519-1-ak@linux.intel.com>
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

