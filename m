Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4818BC20;
	Fri, 13 Sep 2024 05:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726204885; cv=none; b=oDknOgUDQgi1UZhmJkYNoZfQ1H0mLEssgO6fDOWp1kdYZmhoQupvS9wOk1HorOH8eLFsck+2dGbxYeG+/7vf1RuEb8+kr5uiGuqRkLeGflWNVk9WRAQsckZ0KrbbJlfZnuMQAyOhZNjbOzvGM1DKRDmCeBebkN6YAx2YKOyMIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726204885; c=relaxed/simple;
	bh=M4wZMTQkeHr562pePJNnwyLBEOJd2PtzhwbjMGz+bu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzpw09JnlooPz6rw4fdjt6idtrSmf3Voc7RqGXRWsDhrLy7/cQtzpuk3QVbwpu0V/tNn1qxGcGHR4W8xz6k8P+7ExFo3/spg/HkFhiJMoA3c/x9wx4CAShKQhGoFch83e36Lo8XRwWI39DkvQyEcQpmJbB7on8pDFI/Z/n0viCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CreoeVY+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CreoeVY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726204883; x=1757740883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M4wZMTQkeHr562pePJNnwyLBEOJd2PtzhwbjMGz+bu8=;
  b=CreoeVY+lJAUkPIfiP70WjMx7GZJyQ5Qrv7gr+iffRTIEqetsEyn4dLT
   Ab/4os0TjJhC2Mht6eSg4NARgwtNh2LLbT/S40TiU1AmpDl5I+4jYH7tN
   RMQDs1ri5GN6AMM5ZmTj++sGLeDgpne03D2PcAtY2ImHHmeokc/h1jSAv
   VBJP1Tkc5gNrMD8BrHnJQAJOmYL8ySfaYfo70GNwyVkgAgiRv3figN0EG
   orA/c3PoUftTxBMpOXSDrF5w37pwvkHG0u4bstoL1BopcCOlh59skedbc
   D1M/+sDRzK3juYDldgjquk+46dn+FS0gRMo+riKlL2ejI9/+maC242HTa
   A==;
X-CSE-ConnectionGUID: bPo4HzKGSuKf1u5ICC1VIA==
X-CSE-MsgGUID: 3ap0+d6ORue9IrQJ7zzjEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24967786"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24967786"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 22:21:22 -0700
X-CSE-ConnectionGUID: 9pLGOrNBSjGOuNPYuXBzbg==
X-CSE-MsgGUID: XlJYMd44SkWVrvmdSdbebg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67900627"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2024 22:21:19 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v5 4/6] perf tests: Add leader sampling test in record tests
Date: Fri, 13 Sep 2024 08:47:10 +0000
Message-Id: <20240913084712.13861-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add leader sampling test to validate event counts are captured into
record and the count value is consistent.

Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 048078ee2eca..45baf7910640 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -17,6 +17,7 @@ skip_test_missing_symbol ${testsym}
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+script_output=$(mktemp /tmp/__perf_test.perf.data.XXXXX.script)
 testprog="perf test -w thloop"
 cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
 br_cntr_file="/caps/branch_counter_nr"
@@ -228,6 +229,32 @@ test_cgroup() {
   echo "Cgroup sampling test [Success]"
 }
 
+test_leader_sampling() {
+  echo "Basic leader sampling test"
+  if ! perf record -o "${perfdata}" -e "{branches,branches}:Su" perf test -w brstack 2> /dev/null
+  then
+    echo "Leader sampling [Failed record]"
+    err=1
+    return
+  fi
+  index=0
+  perf script -i "${perfdata}" > $script_output
+  while IFS= read -r line
+  do
+    # Check if the two branches counts are equal in each record
+    branches=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="branches:") print $(i-1)}')
+    if [ $(($index%2)) -ne 0 ] && [ ${branches}x != ${prev_branches}x ]
+    then
+      echo "Leader sampling [Failed inconsistent branches count]"
+      err=1
+      return
+    fi
+    index=$(($index+1))
+    prev_branches=$branches
+  done < $script_output
+  echo "Basic leader sampling test [Success]"
+}
+
 # raise the limit of file descriptors to minimum
 if [[ $default_fd_limit -lt $min_fd_limit ]]; then
        ulimit -Sn $min_fd_limit
@@ -239,6 +266,7 @@ test_system_wide
 test_workload
 test_branch_counter
 test_cgroup
+test_leader_sampling
 
 # restore the default value
 ulimit -Sn $default_fd_limit
-- 
2.40.1

