Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9DE14B97D;
	Tue,  2 Jul 2024 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902395; cv=none; b=AbiB0vLAl/ZIFdRAGVQFHnxDbZVbOxM+/hq6JkFyJOM28bhTL3MEO28kG/Y0umspL3DKCM/aoMTg8f6qw3QojKxWdTRkHgTYZYFUGGx1d6m6o+zVRkWunq1jLLAuzCqFU1tHCfBX28QoQhd7uU0iIR7BYI4a2H6vpQsJ0KmYdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902395; c=relaxed/simple;
	bh=7NPeKnDoJ/P82slpVaSMciOgj75XI6ViCTDAXn0KGrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SO7HQjnIc9PNUiijRv0H6fzMR+CuEth197nLGWWzrbdsisGcB1nNEwUBO05zJyosdLvrWIpCwJNssQ6H7BEOO8HCIXj16ISLhpoBZl8XvGH2Bhzwsg9pY1/TEccvW0z9uZ6ZXFvxzUNDZteNMAONbkgchKc4WWIZbH2MNY0M0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sf9RGDO+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sf9RGDO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902394; x=1751438394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7NPeKnDoJ/P82slpVaSMciOgj75XI6ViCTDAXn0KGrA=;
  b=Sf9RGDO+91C4pCOs8XqDkuIFgAFaQJWBOD2Lvhw1RTw0G8SGCpPbvy3g
   3PSq6BTOjRXL3fAi59/MSinDduHQ4TqaUr3I1Feq6S3WVmNh2B7M14wZZ
   bpoUKEGT7Y4ntVLVqB0tNpEp0xc3+m4sRdpETVNWC9Ml5aSdcgEJJiitb
   QvnScDkv5P57qIf5BKZXTCIDwRFlzD/BT2I9geNa4fYRP9IL2aUWgmSmB
   UHXIGglzwDLLzD/HtDgMbJ0u8SLRLAsF0ceTIhjL+Pf/Y5U8UVHTnn4aq
   JR8nCTJtsXiaBdnjXP77AxpVIIRFUCqR4pHiQ2Y48K2tsnmHvYaSVwuSU
   w==;
X-CSE-ConnectionGUID: Ph/4wuruTPyaaBnzUmAWwg==
X-CSE-MsgGUID: RN0yfUfLQDSyneK7lyfDBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20868314"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20868314"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:39:54 -0700
X-CSE-ConnectionGUID: JVYy6AcfQ3my9bBm+Ctx/g==
X-CSE-MsgGUID: K9AZoyEjTwmJ4iL38u3GMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45926378"
Received: from unknown (HELO dell-3650.sh.intel.com) ([10.239.159.147])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2024 23:39:50 -0700
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
	Yanfei Xu <yanfei.xu@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 4/4] perf tests: Add leader sampling test in record tests
Date: Wed,  3 Jul 2024 06:40:37 +0800
Message-Id: <20240702224037.343958-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
References: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
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

