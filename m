Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F921A2FA9;
	Mon, 24 Jun 2024 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267655; cv=none; b=J+xnIoIo/RLK1enAwJQ4BzPb2dhN2EU1eGyVZwfm3AJFBeLicLqM6aQ6tLdIcIJDs+Fefvd5Um+pyR4rHMvBCE8hQmTvo519/hyw3BL05/OGYK9U2iOnJzsb08oxXjQ6raQGc28ySYe0DLiiT8MIgm95tVxzJY/5mETbL2Nf99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267655; c=relaxed/simple;
	bh=gPZ9MRVCe+ydnxFJBiXRGAGx/gI/Iro+2CmPLl5yGWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBeu30Etreg77w6WeZ7rbH0HHFjadTzlI1JL7IHkt3WDfa7M2ErI1grZFH4T8vJfXlvaaQm7SOUTls3cy4U4oi2zPA1nxu+V0EBCB824yiz8MhC0hxKr1dFk6AVmaIkvo8cE5qOdmBlG+3iAMYhEA4SfSvn2OKzrUa1vVcSMLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhP3IuTS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhP3IuTS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719267653; x=1750803653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gPZ9MRVCe+ydnxFJBiXRGAGx/gI/Iro+2CmPLl5yGWs=;
  b=MhP3IuTSmLd+du/REPGHGQxuZuEZ3m47llfVbeNau2b+7dKr+exv90os
   Ob+ryt/4j1r2IXfcoLdgyQw5MT2U+KMKwNnQzIgZXQJ4dqBczk2GIWR7S
   FYaPglZKBliIm2IdbUdb656Ae/fCAN+EtEFDn9/5viqR3Udd4U63Ksgkf
   ygu6Gh/eQ6rwVh7gK8DhGbCDbxZ84IhLrXef+g8ZmcFqUAfCMo9Er1Dxn
   YfiP4eHFYGGswwpFmmzzoecV3mx1hxOq7xbFtak1xqP6nai/KPSSBLqXa
   P97B0iTRnP1J7YSYUt77kB1eaK84WLeW4vBsLrbOCf2a9RgI0grtDBiFB
   g==;
X-CSE-ConnectionGUID: CorSnyFMSe2o4DA4i312oQ==
X-CSE-MsgGUID: ow16M4RaTn+uoj87p6oxlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="41681640"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="41681640"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 15:20:47 -0700
X-CSE-ConnectionGUID: vqf5WwKUSGawiFD1sBfXIw==
X-CSE-MsgGUID: Gnf39rfHRQGprtUVBX5Chg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="48608239"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa004.jf.intel.com with ESMTP; 24 Jun 2024 15:20:47 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v14 8/8] perf test: Add test for Intel TPEBS counting mode
Date: Mon, 24 Jun 2024 18:20:24 -0400
Message-ID: <20240624222026.229401-9-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624222026.229401-1-weilin.wang@intel.com>
References: <20240624222026.229401-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Intel TPEBS sampling mode is supported through perf record. The counting mode
code uses perf record to capture retire_latency value and use it in metric
calculation. This test checks the counting mode code.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 .../perf/tests/shell/test_stat_intel_tpebs.sh  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh

diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
new file mode 100755
index 000000000000..220b830eac61
--- /dev/null
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# test Intel TPEBS counting mode
+# SPDX-License-Identifier: GPL-2.0
+
+set e
+
+# Use this event for testing because it should exist in all platforms
+e=cache-misses:R
+
+# Without this cmd option, default value or zero is returned
+echo "Testing without --enable-tpebs-recording"
+result=$(perf stat -e "$e" true 2>&1)
+[[ "$result" =~ $e ]] || exit 1
+
+# In platforms that do not support TPEBS, it should execute without error.
+echo "Testing with --enable-tpebs-recording"
+result=$(perf stat -e "$e" --enable-tpebs-recording -a sleep 0.01 2>&1)
+[[ "$result" =~ "perf record" && "$result" =~ $e ]] || exit 1
-- 
2.43.0

