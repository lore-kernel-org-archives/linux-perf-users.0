Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4C1343D9E;
	Wed, 12 Nov 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966508; cv=none; b=aB9zGxDjO2/0EpltMjD8ICSt9ROLb5jT1V+fo5GqANL2+dLotvVWP0OOmWkEQ7gbqf17gCNFy6JNuh5FzSer1sqTE1SLC2JkRucqFkPV6hi93S3O1MuJlRmIOcnzQ84a54xfkqmMa9yX9cOJYqVY7jDwTH7ByJ6L9M/sHarYQEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966508; c=relaxed/simple;
	bh=WfIods2bJfQPmp7PBIC2biv1hfgAC7/+RMioDm3ndSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKPB+2YswBcM8PiabLGga0IlG3QAP1tNhEND90wBF1lIIA9hxpyvr46NsbDBqfi6bJQy+FhlLHGH1V7UTnAokpAF2i0BW+kP1BvS/+m5cm3rt+QaWzaItLTSgUnV/P4fCdflGkvdaacqUZ3l8OdHCkjPhHs7Ffr1Ry4Kgu+EGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2AHPp2Y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2AHPp2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762966506; x=1794502506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WfIods2bJfQPmp7PBIC2biv1hfgAC7/+RMioDm3ndSA=;
  b=J2AHPp2YgM8prlrdY3k8mWko5nxW3UwwlhTBV63ZHcPejBAdFNA9NQ/b
   PGUw2T3LFcsUvsOdvCHOhQ81Rld8M/EIY5LWH2HcaqmFvAGqMSe6ZZ0tq
   ZkffWLFv/OTrhU3yfz0JAtnt8Xom1cowSv88Vy16YxmhT6E2+CizI6aDH
   AAawjMLOBSGiE4+lFO8FW3qjeYuc2KnPFYopLUUqdDa2r4jHQ5H0YxXSi
   CQC1wBv8exJ0Yfavie8Jr6R/mCVs9fAMMAfDDEyD7hRCCDqkSh14ULEzc
   /cis6E/LFES8MmV4BVqKbuWILNRM5BgUiCVvI6M2ZCToPl6o19pEVQH1J
   A==;
X-CSE-ConnectionGUID: Z2/q6B6fTiidC0zBQvHHSQ==
X-CSE-MsgGUID: 2r81bIqzTJ6qmbiZPpUIeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64919280"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="64919280"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 08:55:00 -0800
X-CSE-ConnectionGUID: qsZVJDRASg6Nc88wTEmIjQ==
X-CSE-MsgGUID: YLe/dq/UTyWSb7cCZw0/rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="189440184"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 08:55:01 -0800
From: Zide Chen <zide.chen@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	thomas.falcon@intel.com,
	dapeng1.mi@linux.intel.com,
	xudong.hao@intel.com,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2] perf test: Add a perf event fallback test
Date: Wed, 12 Nov 2025 08:48:23 -0800
Message-ID: <20251112164823.80168-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds test cases to verify the precise ip fallback logic:

- If the system supports precise ip, for an event given with the maximum
  precision level, it should be able to decrease precise_ip to find a
  supported level.
- The same fallback behavior should also work in more complex scenarios,
  such as event groups or when PEBS is involved

Additional fallback tests, such as those covering missing feature cases,
can be added in the future.

Suggested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v2:
- Incorporated Namhyung's suggestion to change cycles:ppp to cycles:P

 .../tests/shell/test_event_open_fallback.sh   | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_event_open_fallback.sh

diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/perf/tests/shell/test_event_open_fallback.sh
new file mode 100755
index 000000000000..9c411153c01b
--- /dev/null
+++ b/tools/perf/tests/shell/test_event_open_fallback.sh
@@ -0,0 +1,86 @@
+#!/bin/bash
+# Perf event open fallback test
+# SPDX-License-Identifier: GPL-2.0
+
+skip_cnt=0
+ok_cnt=0
+err_cnt=0
+
+cleanup()
+{
+	rm -f perf.data
+	rm -f perf.data.old
+	trap - EXIT TERM INT
+}
+
+trap_cleanup()
+{
+	cleanup
+	exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+perf_record()
+{
+	perf record "$@" -- true 1>/dev/null 2>&1
+}
+
+test_decrease_precise_ip()
+{
+	echo "Decrease precise ip test"
+
+	perf list pmu | grep -q 'cycles' || return 2
+
+	if ! perf_record -e cycles; then
+		return 2
+	fi
+
+	# It should reduce precision level down to 0 if needed.
+	if ! perf_record -e cycles:P; then
+		return 1
+	fi
+	return 0
+}
+
+test_decrease_precise_ip_complicated()
+{
+	echo "Decrease precise ip test (complicated case)"
+
+	perf list pmu | grep -q 'mem-loads-aux' || return 2
+
+	if ! perf_record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}'; then
+		return 1
+	fi
+	return 0
+}
+
+count_result()
+{
+	if [ "$1" -eq 2 ] ; then
+		skip_cnt=$((skip_cnt + 1))
+		return
+	fi
+	if [ "$1" -eq 0 ] ; then
+		ok_cnt=$((ok_cnt + 1))
+		return
+	fi
+	err_cnt=$((err_cnt + 1))
+}
+
+ret=0
+test_decrease_precise_ip		|| ret=$? ; count_result $ret ; ret=0
+test_decrease_precise_ip_complicated	|| ret=$? ; count_result $ret ; ret=0
+
+cleanup
+
+if [ ${err_cnt} -gt 0 ] ; then
+	exit 1
+fi
+
+if [ ${ok_cnt} -gt 0 ] ; then
+	exit 0
+fi
+
+# Skip
+exit 2
-- 
2.51.1

