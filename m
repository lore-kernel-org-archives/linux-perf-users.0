Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912B201273;
	Tue,  6 Aug 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959855; cv=none; b=pGxmPPdGTywIYD0tHm0ROiraXoEvdUD2s2XB/sfKQpE4Kh/D7gexHZZZAYQ37hBub3pqwhOP+LejS2XNMWjWtUKYR+GxVCiEpy0uFktn61O4ShzRIJIz/df4h8zlXbsc5vm+DdY5A11nqcG+YZWpVvBS4TtqW9z7bd/D16Zwndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959855; c=relaxed/simple;
	bh=T3lYCZNDTOox5kJQOOR6Dbvex/BUJB0U27xJgGtdjGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBK3GJ8DQRdwcspSgHqNTstOHKw2+z/EBXdBi/A87G1wEhVwjH6rF2wGeSAzWOfuJVDNVpSQBaGqr1WXtvQwzyfFJxPruVuoYxMUPvYxhdibm+hHQ5sFRm80i+o7uHVVcBkD1fPHyVQq+2DpoJRHtdS6Xeti5f2ZHrz5beT27To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgOyeNaw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgOyeNaw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722959854; x=1754495854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T3lYCZNDTOox5kJQOOR6Dbvex/BUJB0U27xJgGtdjGk=;
  b=LgOyeNawwFROUasGgZPQZAN3G4ZWiR++U1fdbgyIuxKYwIulmVNJ1ny2
   OLtcP6+U9FEPPP3LYawHjSLU9pPwFSUR+yW+nH+X0Ac8BQCUPliiSZkUl
   EWQWO3d6SUKMcvBzHgoARPKn27fvhthUoFm2gJvVTCFlqMJ8ceWIcnrdP
   6vK/7mL23zfBlvmfppnu6gok1zY96Su9u2Csea6fejf080n2sF8ntgZv9
   b0YtMAXNhZzV8V2BwoMFlmtVtgm3oZf3KhIWaOOlpvEkZsz+NtDQ2i+pk
   kYDHSQDdUbkaijgKW9XnTxRWmRdSqdnI1u3o1pSgcWFa4NBjK3puCht2Z
   w==;
X-CSE-ConnectionGUID: UUkCMN4lRVmWCFlmdAV/kw==
X-CSE-MsgGUID: tKtC/4N/RtiXokUXGxvFBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="43514306"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="43514306"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:56:30 -0700
X-CSE-ConnectionGUID: KmWNhmmERSCv4N7Km3j1ew==
X-CSE-MsgGUID: AqnACi6NS2CldDv+WSzWTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56631503"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.248.17])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:56:24 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V11 10/10] perf intel-pt: Add a test for pause / resume
Date: Tue,  6 Aug 2024 18:55:14 +0300
Message-Id: <20240806155514.17900-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806155514.17900-1-adrian.hunter@intel.com>
References: <20240806155514.17900-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Add a simple sub-test to the "Miscellaneous Intel PT testing" test to
check pause / resume.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 723ec501f99a..e359db0d0ff2 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -644,6 +644,33 @@ test_pipe()
 	return 0
 }
 
+test_pause_resume()
+{
+	echo "--- Test with pause / resume ---"
+	if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt/aux-action=start-paused/u uname ; then
+		echo "SKIP: pause / resume is not supported"
+		return 2
+	fi
+	if ! perf_record_no_bpf -o "${perfdatafile}" \
+			-e intel_pt/aux-action=start-paused/u \
+			-e instructions/period=50000,aux-action=resume,name=Resume/u \
+			-e instructions/period=100000,aux-action=pause,name=Pause/u uname  ; then
+		echo "perf record with pause / resume failed"
+		return 1
+	fi
+	if ! perf script -i "${perfdatafile}" --itrace=b -Fperiod,event | \
+			awk 'BEGIN {paused=1;branches=0}
+			     /Resume/ {paused=0}
+			     /branches/ {if (paused) exit 1;branches=1}
+			     /Pause/ {paused=1}
+			     END {if (!branches) exit 1}' ; then
+		echo "perf record with pause / resume failed"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
 count_result()
 {
 	if [ "$1" -eq 2 ] ; then
@@ -672,6 +699,7 @@ test_power_event			|| ret=$? ; count_result $ret ; ret=0
 test_no_tnt				|| ret=$? ; count_result $ret ; ret=0
 test_event_trace			|| ret=$? ; count_result $ret ; ret=0
 test_pipe				|| ret=$? ; count_result $ret ; ret=0
+test_pause_resume			|| ret=$? ; count_result $ret ; ret=0
 
 cleanup
 
-- 
2.34.1

