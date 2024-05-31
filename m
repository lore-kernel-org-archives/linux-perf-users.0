Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147D823AC;
	Fri, 31 May 2024 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135137; cv=none; b=MgXnOQyKF9QFFUlSAq8LC7wYZSQKKCM/h9QW1viO4mYnDyQMIcPe9AP4BjMDFz7WDgI/P/AAHGjqThl1zdUsczjUqaxoGtyHQYbKyf0JSD4d93CDSEogNu8FlLpSGKdz3KLe0pHS57bwu8XeSTVq9w9fTeD2VAAYAV/KLopXlSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135137; c=relaxed/simple;
	bh=T3lYCZNDTOox5kJQOOR6Dbvex/BUJB0U27xJgGtdjGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kMvoiSrjrYlGHBDtNOiXF/yI2APSxJH3SlmXeBjQILwpZJjNTTHdQZ0/ogqwKMsfe0Y9xFfOsQalEMVvAYM6Hek+0spfjn26FvUzueptxIR25XQrTzRdFnoS90Fcycip9EepOqiQ0bBUzVRCjUDqyPPTWnCqfl9xYT9E7rGQ/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eT/sDjCn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eT/sDjCn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717135136; x=1748671136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T3lYCZNDTOox5kJQOOR6Dbvex/BUJB0U27xJgGtdjGk=;
  b=eT/sDjCnFzy2Vc2/g4Oel29M4rDvrmihdh53l4fdJVU8tecz5vpVwP2A
   H27W6B3yyrVjjPyWuFwBsL7s+/teEjnqvSJY9crSVzhzU9MxilN85b7bd
   CY8DkapYu5aNpJXUHUMXdZCNvNKWgu+PBPIwXtm+dCJOsjHdbMLlhfZRu
   l5e7lUGnyZs/xLoqsXhrcjSObo3u2XIxcHuPmDcScagIKQ1Vn3Kk34bIe
   3+2O7BO7JQqhKfmrRPjj6Xf86+TXYgMJTEuhdXQIyjYEkc4E82Kd6n1Ry
   yuQ5QgELmubzFv/0CL26mUSdFoY3csiu6V/QXZkCvDcJsFKoV7H4VjJ9M
   g==;
X-CSE-ConnectionGUID: hhMI/G/+TLCx4/VNpgBPfg==
X-CSE-MsgGUID: vX01tnVnTvWHxeEl5+Hc2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25068342"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25068342"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:55 -0700
X-CSE-ConnectionGUID: SxjeQndQTHueuh3XL3CyeQ==
X-CSE-MsgGUID: P9VZf4uyTHmJ9O/ifrtZkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40511003"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.41.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:51 -0700
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
Subject: [PATCH V7 12/12] perf intel-pt: Add a test for pause / resume
Date: Fri, 31 May 2024 08:57:31 +0300
Message-Id: <20240531055731.12541-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531055731.12541-1-adrian.hunter@intel.com>
References: <20240531055731.12541-1-adrian.hunter@intel.com>
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

