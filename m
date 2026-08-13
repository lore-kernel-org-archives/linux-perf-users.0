Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49144432313
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657315; cv=none; b=lolZVbUKZ8LdXJCV/6a99OImgl3R8wcVY1UGcn0PSRkLbPaoyfRP1ik03X7ojiLprMhg9jZSMKTIRt8PiZOCu98Qu7E97t4yBHGU2Qq50akwHdn9Hhw+D1rK6S0z6/Jn45cHzbY8uWHhvTY2ko2kY5bEu0Nos7kIcNiGRVKXYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657315; c=relaxed/simple;
	bh=DrLm05uQYf9SigOs+2FvTWUMJmNw0vqGNkpwdwF4t/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5ptSOXOBiGXLRn2C/rFHt5Q1ZMlCjQkwGagRS7qq+WoKK1zE2iMHJ70bJZg4ilTQVp/o/He7t6ShVOAjNghN/ziQDNMAl/kWXG7qMd3uESEiMWWnPrm5m2Ry1OpBePhgFzNPvXggXx6+HZ1T02fsBqpdraIi73+kfVgKjAO+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihBsqv5i; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihBsqv5i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786657314; x=1818193314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DrLm05uQYf9SigOs+2FvTWUMJmNw0vqGNkpwdwF4t/g=;
  b=ihBsqv5i+CLbGEEm2ow6pLIW2MoOMLhhLceMQZz+CI/WmdOET9ecVQrl
   a6A5bQiKVJN+ly+Ufbhe2EdS6L0DtXHRwW5TwL1EbhRbqdSUkkjPQBUiJ
   1ea1utTdUq7Jzp92IWfxiKxwXHS4YOiZLJv4247NNVnKUgvQN0D2Xvhsi
   8ybRag1LrTAjT0TptlV6756qRJkHwhUkJ3IcIiLyhhWsFSLa6GZ6RE+ev
   JfHfCQzqx4sdKc50Gn+4gwin1uz9ZRY5c6PH5UgCiuJTtp1hGyRmp9v2l
   7KfZo2Y37sf/VlC3Kh6PtbKBMCpRb3NSb9UbCLL8pXk/tMaXQn/KUbd+C
   g==;
X-CSE-ConnectionGUID: gRiBI8tXTD67lCkZsH5Ftw==
X-CSE-MsgGUID: AiCH6019TSqUo9Kcpq8jYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89761877"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89761877"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:41:50 -0700
X-CSE-ConnectionGUID: abLINyzTRAWGW0QIYPmwmQ==
X-CSE-MsgGUID: XihdI76VQ7i9ProdxqkRIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="267909913"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:41:50 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 4/4] perf tools: Add test for weight annotation
Date: Thu, 13 Aug 2026 14:40:59 -0700
Message-ID: <20260813214143.253418-5-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813214143.253418-1-ak@linux.intel.com>
References: <20260813214143.253418-1-ak@linux.intel.com>
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

