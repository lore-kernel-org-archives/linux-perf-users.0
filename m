Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE916A949;
	Fri, 12 Jul 2024 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779707; cv=none; b=aPvx62ljDAz88PCINQ2HfGpDGk2FNKwe9T7Bpj2ZNbAx6AbCFkhH+86ozWLawXes1E9EFVp1bGZN2uX3/MahoYZtfT77V0WXGMcgYJWUBHQbiWKCmesHZLOLhVNm+VO4CJrbiTyQvf9M1IBRtoWUkxINfxYq3hlnxtBjIcvpR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779707; c=relaxed/simple;
	bh=mYzLvmSJZKTBkmZhbdKH2s+bnRSxYws90RWrHKTt1cU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqPKGGNSbw1xc/T7mxuLe4o7iduWVyYLPPJGpIXVdL61eSw6Kb+C+PejbXGQji2L8hFSUrrC9lN2QvBhKT6mnDsW6XMv5mnqdmJSDZn6tGpCfT7SiHRrUjh+ncb0ubzyOIFzRnlX548AceOJFReFKBvW9XEvZgVTgV17eCJ6ln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1ttPrIN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1ttPrIN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720779706; x=1752315706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYzLvmSJZKTBkmZhbdKH2s+bnRSxYws90RWrHKTt1cU=;
  b=C1ttPrINNR+5OiurQsMd14O1ycw/0BAuf4zDOTGmtxYrjgYPm63TpSqA
   qQ1DyRZNhPD8eee3jRqj/tTtJoOxEG49dg5BiAGro3BUafg/RVXa+LQ/M
   aDHD8sU97qY5sw6feu8kw3yuSwGVSWtNUYWgSzHlhm3a/ubabKfBlxNI1
   Mk2YirdSu2ytXSoF2dbUif6H2zQFJ8/uA7bubx+Jvut3MxrvijTenXs7Y
   8JJN2HFRVZJOh8CXlKPuNAQOyg7d0BhviMKFYkE2ScQvJ/KjQ5WhFRZYx
   +w5qYtjkjcfQKM+vAwPkTmAnq2blReFFAsGncvJsG5dedRsjt4E7IadJj
   A==;
X-CSE-ConnectionGUID: N3+Ww6aCQ2evm9vLPTNfqw==
X-CSE-MsgGUID: LKkDMbtwRLe5WRtEPKzjfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="35756794"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="35756794"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 03:21:46 -0700
X-CSE-ConnectionGUID: ALB4pOYJRsiMBYkTMa0WGw==
X-CSE-MsgGUID: PUIkzEv+R5S4LLOyky2ajw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="79576258"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 12 Jul 2024 03:21:42 -0700
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
Subject: [Patch v3 5/5] perf tests: Add topdown events counting and sampling tests
Date: Fri, 12 Jul 2024 17:03:39 +0000
Message-Id: <20240712170339.185824-6-dapeng1.mi@linux.intel.com>
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

Add counting and leader sampling tests to verify topdown events including
raw format can be reordered correctly.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 17 +++++++++++++++++
 tools/perf/tests/shell/stat.sh   |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 8e3e66780fed..9d0c43427811 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -217,12 +217,29 @@ test_leader_sampling() {
   echo "Basic leader sampling test [Success]"
 }
 
+test_topdown_leader_sampling() {
+  echo "Topdown leader sampling test"
+  if ! perf stat -e "{slots,topdown-retiring}" true 2> /dev/null
+  then
+    echo "Topdown leader sampling [Skipped event parsing failed]"
+    return
+  fi
+  if ! perf record -o "${perfdata}" -e "{instructions,slots,topdown-retiring}:S" true 2> /dev/null
+  then
+    echo "Topdown leader sampling [Failed topdown events not reordered correctly]"
+    err=1
+    return
+  fi
+  echo "Topdown leader sampling test [Success]"
+}
+
 test_per_thread
 test_register_capture
 test_system_wide
 test_workload
 test_branch_counter
 test_leader_sampling
+test_topdown_leader_sampling
 
 cleanup
 exit $err
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 3f1e67795490..092a7a2abcf8 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -79,6 +79,12 @@ test_topdown_groups() {
     err=1
     return
   fi
+  if perf stat -e '{instructions,r400,r8000}' true 2>&1 | grep -E -q "<not supported>"
+  then
+    echo "Topdown event group test [Failed raw format slots not reordered first]"
+    err=1
+    return
+  fi
   echo "Topdown event group test [Success]"
 }
 
-- 
2.40.1

