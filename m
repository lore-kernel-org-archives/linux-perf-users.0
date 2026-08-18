Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE5383C92
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094163; cv=none; b=lENSWFE55J1FwmxJzbBkTvxXTxtYcZPosLCsmG8Hx47SgfY3Bwe61Z84vMb9GrMevvOcoYPKv6xiGiRJqWZStfO2totBY/ELWbQd5rywUPua311dzpZkFqYSJE3Q8CdQJR/CGUjEPgr/hsuiIUWtLA2Jr/1lFn3FEJyE6KY/imI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094163; c=relaxed/simple;
	bh=DrLm05uQYf9SigOs+2FvTWUMJmNw0vqGNkpwdwF4t/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+xyPGTCIv8BlhyfJr9eKH3U///cCkrsCBMM0ICn1csObpwehq6YZotF0mwGL9QJDxjn0bJ80so0fT5yF8dGjUR7S0yvRpJzaDGrsf11+FzRP7eZyE0GhVUQNfk1x9OyG18es+9K6xwETv79SMMlSwq5MYxr21iE8uKJ8AnhLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Btk/yfya; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Btk/yfya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787094161; x=1818630161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DrLm05uQYf9SigOs+2FvTWUMJmNw0vqGNkpwdwF4t/g=;
  b=Btk/yfyaaZQkUKCp3V8WeHdNQwT5YQBtQCtBpe3I6hLTRGoaN+BaFqTd
   PjwNpLyXZQVE6OiWNX/D7gMaeYKy3jlRKjrw2pKuuy2GpBy/nMN/WsIv5
   a02eTaIcatqyhcZHAYxZf6iUrR7BxtkGzmKtfuBONrkySDrqwjtmaNZrH
   4b7sPYVYMhSJDmq4S+T4BRZeh6bRNRNOEuPnfk180o/S572q52jhoqMYc
   my86dlR7XtZQx56fFKs5KiNSXoeunb0Dldzy7Zl58lY1Dg65sjeydxz2Q
   qXMdAECbBG8y2RpEjd86ARi7qRYmpmrr2xMuFrtbaOQi6UPWu967mp4dL
   A==;
X-CSE-ConnectionGUID: B5ESw9dCStyKe2qdXoFbRg==
X-CSE-MsgGUID: f4lhudcWSBqOuopDcBkEAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91409649"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91409649"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:02:35 -0700
X-CSE-ConnectionGUID: cyCNrLehQGmMnqrTeklZ7A==
X-CSE-MsgGUID: DnfECPg4Rx2eJNwwYDtiiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="264060588"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:02:34 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 4/4] perf tools: Add test for weight annotation
Date: Tue, 18 Aug 2026 16:01:08 -0700
Message-ID: <20260818230229.1491871-5-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818230229.1491871-1-ak@linux.intel.com>
References: <20260818230229.1491871-1-ak@linux.intel.com>
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

