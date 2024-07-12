Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA015EFAE;
	Fri, 12 Jul 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779704; cv=none; b=i5A1QdXtHr2ZV3eaaPgcKxL/OwZBKGk1PHkj+KCZx/qYK5750CrwZGWjLFaADTul3gDDlE5rF3xWEVYDFmnEyGxXMhD7kse6VafpbqeQhiyvp0hjdRU32TBvgH79t3T+Clizl3Oa+OH/BNgbHZTzIJ9SpFFI46rihuNm69561Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779704; c=relaxed/simple;
	bh=7NPeKnDoJ/P82slpVaSMciOgj75XI6ViCTDAXn0KGrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CnKVglxDu6RNyC6eZDD7qXRJ5tPca24xNhA1GaQ2bGyvlZBYu0UuefKhB1lWPg+0c4l5fQcd/wVsLTmvVdI9F9WNj4EUJyI/9rSG6GNE55fGY4wMn+h14cjB9d/qKUnhDubC3uyymxaNzK1M7e+SRT669zDQH/NsLOe4hLr6At4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLtCa7bi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLtCa7bi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720779703; x=1752315703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7NPeKnDoJ/P82slpVaSMciOgj75XI6ViCTDAXn0KGrA=;
  b=jLtCa7bifudI+CB0oo34xYpHAZKH0ZidLvUDQHirG5qI1dU0rbaS51Gs
   x23fFFoCQSJSteyunAj1S9nXgny8qSyRXbFTQOX7lZ6uhd66EQSuWNwAI
   n+tlF+8vYYa2l53rZRZyF0Zpd35EZpAVUNBSwvZbZD9MGr97++60M7Cji
   KaXhmLagW033vDkguqJcYd0aGaNnhb1p3zc9nkZxTQ03QVHjLlbaKTQoc
   GRYiI1A22jvddcSSkvEf18Ool5hlZu79W86jsz2sUrYCc2DgUOOn4zUFI
   0GYVxisn3aQ2VLRB70tRgKETJTlQJTjh1dXu3+8jWWfJ1yHha4WSgsz/j
   A==;
X-CSE-ConnectionGUID: ywjUGzueQg+AhrKY7aNJRw==
X-CSE-MsgGUID: S/X2ITp/Ssy5dj1Cgc8+RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="35756786"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="35756786"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 03:21:43 -0700
X-CSE-ConnectionGUID: hDF+Il1bThaZ4B4g7PJcLA==
X-CSE-MsgGUID: A2uYjbHrRaiiPLfSzNPF1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="79576254"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 12 Jul 2024 03:21:39 -0700
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
Subject: [Patch v3 4/5] perf tests: Add leader sampling test in record tests
Date: Fri, 12 Jul 2024 17:03:38 +0000
Message-Id: <20240712170339.185824-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
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

