Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1C1D90DF;
	Tue, 11 Nov 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901370; cv=none; b=JQxm/qk/RAORyHh5QYRDza/0Z9AWkGztV3AeKu7qp1ukLEE+cU2YobDmR1kUufMcScG22fY+aVASRe2s/s15gAruilKdXvwDD7LjnU5VEgD4sa5SKWfO+myxjK1vgq+RqNKLL/nOnEbEl3spADa4NgumC4OUSSl+uONEZV9nHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901370; c=relaxed/simple;
	bh=/fHUw/ANnosy7hAphJl/q9TvTk58/LAGaJ/yzGfpkOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ec3MDdtzws5YNaRMulWgq1ZeUA6a29ayzzsuYKhRjM3UXl7MtMMsvnCVa0u/jg3n0eowbMVXI0NsiDQ1wlHUS32QkPAQqKJhCdfxuJYyJFVZCfJBrJvW3sNrh+VPVh+yxYN6CD8uewzMtIAx6te4q87QSmsOpHTAxg5f8Y7sAKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij5J06Xp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij5J06Xp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762901369; x=1794437369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/fHUw/ANnosy7hAphJl/q9TvTk58/LAGaJ/yzGfpkOw=;
  b=ij5J06Xp3vHkachmhwiT9P9E2p8xC/FP/Sf5tcpWZpiW7KT7byNFQDze
   j5Ikl0FzxBIyQUwUkZjeCi7w8E3rDWg+8TbfESY0dwDRx4nB+NcO5TY93
   AOxZP3GX8KWNv5hvQnG4gNYt347+9CS1tYi7DF6JOMDUl9sD37TZqqsFh
   DmIM+uqeya7/hDxm5ZrD7qh64tgR5Y9aAFkpYN52W87Z0SyuMhXcrH+GB
   iFxheB1i++v0RUOFl7inWj7j7BvtzHD6F1mqKiF4R5C+U4KJVm7ry3ZYt
   xNXaZArSa8YwcjqszPW+CwV02EYVYTfVXyCTjmGUwEI0beRLvf7mYVmEo
   g==;
X-CSE-ConnectionGUID: F77s67gOQUC9nmtdI2oiLQ==
X-CSE-MsgGUID: 04JlmyU5Shqs0NElzLp3tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="90435546"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="90435546"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 14:49:28 -0800
X-CSE-ConnectionGUID: qJRHqiKTSOiUWwCaKbEdYg==
X-CSE-MsgGUID: 81Btt+n+S6q67465fTl6TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="219791871"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 14:49:27 -0800
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
Subject: [PATCH] perf test: Add a perf event fallback test
Date: Tue, 11 Nov 2025 14:42:46 -0800
Message-ID: <20251111224246.73673-1-zide.chen@intel.com>
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
 .../tests/shell/test_event_open_fallback.sh   | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_event_open_fallback.sh

diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/perf/tests/shell/test_event_open_fallback.sh
new file mode 100755
index 000000000000..72c1ac32c785
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
+	if ! perf_record -e cycles:ppp; then
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

