Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3503712C7F9;
	Fri, 16 Aug 2024 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790753; cv=none; b=TOm3f+rG1aiv+4QQ1yLkNcZmQDOy+AZZ+/EtGKtUxHK9R40/Ca8GCaMbgzz1xaIhmgkV8N8vY2mPRLEB2kQmHJznIxrNeRZFwdtnYBTPMogu7XjMrY4jmxMrYni/MMtEgDCxaX7ZjkVvGB24T5AUquZ17uGhPhDIVPE607MRwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790753; c=relaxed/simple;
	bh=7NPeKnDoJ/P82slpVaSMciOgj75XI6ViCTDAXn0KGrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBTYfnHVzKkzDkC4nJ5eN7tMsck6kQoBUwjDM4gJVINH/DrjLjOAHR8+qP1A26vZbFIwVDlRywil64hkZFXHaIEqTTRoSirJ+BIM44KhgHpWAbORbwtaK/vm06fOUb2Agg80tFidkDx1cVwtgTKSz3EFj54puLdvaoAmYSmJCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cs5Uu5Yk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cs5Uu5Yk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723790752; x=1755326752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7NPeKnDoJ/P82slpVaSMciOgj75XI6ViCTDAXn0KGrA=;
  b=Cs5Uu5YkG79FfNvQNpez62mSYDXhNAEiYWuuwjlIcoroBOlr6wxoX+O2
   wx1Larf3J6RQtkQaK3j7FdeaG4ONAM0Ptdjov59aUAI13ov4mkFOG/rMb
   Q48O/Q0cYhvcdPvRmTiiAm+QpK2wYa+qXGf55Kcz9T27SKrw6rtJjwv36
   K3imNdCDBWMx5cx5vDl27bXtIoi7MyJDivBJIZQnzHggDfEgH5WuSX3rt
   HUIsjNbPhselFNWz1B4WWD1TvD5Ya10C0M5W6w7uz3r/dmMp/3FYLVGfj
   bKtvhqzBk3K9K2JAkv2DpIhjwyM6EX120yiT5mbXguf08oEa2LLlKyXx5
   A==;
X-CSE-ConnectionGUID: m65m93loSaaPHJRaW/pJ1A==
X-CSE-MsgGUID: bRXpYF13RPWqlJYaq+/4iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39530770"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39530770"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 23:45:52 -0700
X-CSE-ConnectionGUID: FOaWWgknTkO2Syj3YrtOZQ==
X-CSE-MsgGUID: cMxC8OtmTK601jyX7ia21Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="60150033"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa007.jf.intel.com with ESMTP; 15 Aug 2024 23:45:49 -0700
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
Subject: [Patch v4 4/6] perf tests: Add leader sampling test in record tests
Date: Fri, 16 Aug 2024 12:29:36 +0000
Message-Id: <20240816122938.32228-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816122938.32228-1-dapeng1.mi@linux.intel.com>
References: <20240816122938.32228-1-dapeng1.mi@linux.intel.com>
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
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 3d1a7759a7b2..8e3e66780fed 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -17,6 +17,7 @@ skip_test_missing_symbol ${testsym}
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+script_output=$(mktemp /tmp/__perf_test.perf.data.XXXXX.script)
 testprog="perf test -w thloop"
 cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
 br_cntr_file="/caps/branch_counter_nr"
@@ -190,11 +191,38 @@ test_branch_counter() {
   echo "Basic branch counter test [Success]"
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
 test_per_thread
 test_register_capture
 test_system_wide
 test_workload
 test_branch_counter
+test_leader_sampling
 
 cleanup
 exit $err
-- 
2.40.1

