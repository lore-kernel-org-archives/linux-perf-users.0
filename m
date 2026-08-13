Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D030947988A
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627769; cv=none; b=dpWQnvvFkezOCzo7gU2GRFgjgDk6bXZCdA2z4wMW18+bJZZ0F24cxej6zGatHUA6bTKHV1olIbRvYqRti3Pcc9lsAc3q1Tinv49TxdqX6ry/+9vdJf2Z4Hr3co+Q5vorgoki8hl3Mz6BiXdbzgSQ5cCimSyjcWeg9AA4t2cAiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627769; c=relaxed/simple;
	bh=DrLm05uQYf9SigOs+2FvTWUMJmNw0vqGNkpwdwF4t/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqNwri6JChuvMNnnvHo5gXHiHdCvwZb6TN1JCYZS+OPK+inp6eiV5UB8dCDVC4brfzeIriUY5wnnOJj6kEWt0u15pV0ic7/vFQbgK4zEhomO7dMEafsLQhqWMc+Q551ylbThhY/6hFkyZbCHJwHs4gkLQ42bNGCDnxhevyVsbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOQnZoHq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOQnZoHq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786627767; x=1818163767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DrLm05uQYf9SigOs+2FvTWUMJmNw0vqGNkpwdwF4t/g=;
  b=TOQnZoHq5wODj23fEGdUZMINgfgmuBiC0hIwFH4CIJ3Do6bpiaajMFdI
   Wlc0Q3se8Uf5A3JHtI54OIyq9bSG5eIytzHoDRHx7nX76AnK4HEQshNVd
   KNVOuhdV0M10WWEJ1ttKua+2EBkTuac2mAcHOpsTqbWmaoknsAAH5TUdu
   5cvFC74OyQdkdGJXTXosNitkBZ9LNTUZOCZJmKbl8qzCsUkrlyPfeQjn8
   VvHDER4jiKd9HJAgU8C65Vsinvdvj+gP24NTaQrBf90frTLpNZP7X+s8H
   +r3jpOr9nRxRoLQbmi21bB87RZbnV/3ZSeS6IwyUFDDZg9W4+uLEl/Kzv
   w==;
X-CSE-ConnectionGUID: k0Gy24wZTey9v85+ABN7xQ==
X-CSE-MsgGUID: BHdOFyEJRhq42SKkmD6NaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89720111"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="89720111"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 06:29:26 -0700
X-CSE-ConnectionGUID: 20pGBaNeSYCWJygKBzAVZQ==
X-CSE-MsgGUID: J/BVTyN0Q0C44vVZDRB8Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="267455276"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 06:29:26 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 4/4] perf tools: Add test for weight annotation
Date: Thu, 13 Aug 2026 06:29:07 -0700
Message-ID: <20260813132907.50738-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813132907.50738-1-ak@linux.intel.com>
References: <20260813132907.50738-1-ak@linux.intel.com>
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

