Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6831369BB;
	Fri, 16 Aug 2024 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790756; cv=none; b=MPThxM1lnpAqDCnrdoNMa6a0+Q5wyEHLsRUJGviC8zmf92k+toWk9XM3984eo77TtlOdt3fxUNsnwW38su1bMUve4CR9YGw+W908SHsTPuKy3IRtT1+f4ESQlyWjRfaeGOB9H5gl6DRNcIwQZPy/uLjLr4svpByefH5jbXbIgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790756; c=relaxed/simple;
	bh=mYzLvmSJZKTBkmZhbdKH2s+bnRSxYws90RWrHKTt1cU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzy1nfzqILA71UwNTHLULglboe9ATIMQo3H0Ob/K27fCBZKFEKhrrVERlgUryUiFYsQEIa9HGmpSZeiQTgUSlgB+x0a06r3YQfjhdqdzjnjnVge9cFT0MPCz2js0uldhbLHpXLPlKaBpk2rFRB6S02unZMV2nrlM3K3tNBpPoes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A27plleB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A27plleB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723790755; x=1755326755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYzLvmSJZKTBkmZhbdKH2s+bnRSxYws90RWrHKTt1cU=;
  b=A27plleBJYE7lO63sU5ympjAEizH+KSlKSfJ2EIRLjllfgO/iSQwsbMc
   thRVFbyNFjGOu2ewH3H9BMJGkn1PEKCYJ0hkESTyCdzW/Jpr8PPfgvW/D
   TMA4I1ae6ccao3QyFIf7SkT8aT9i9bwAlQKzF3BH+4/OkrA+pmvqZkuKw
   sTZwvy8AYTuvrQ3y5NK6JEJq7jnqlvGnymTesYEsG0JtB6ZuZcaI3YVmQ
   75EbCnf7wPywTe7myBuzjsozjz216qrKZSc3bXNvTic9Rx5yVHqDEtrYY
   dkSkXMChJasL1qsDi8nzbiXFGoxAnDLnSbIyCWhM4SwRIS488eH8SaCz/
   g==;
X-CSE-ConnectionGUID: jeoZ05HcTGORIo3q1Ogz4g==
X-CSE-MsgGUID: MWuz6JE9TB2mLxRdH/uDAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39530790"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39530790"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 23:45:55 -0700
X-CSE-ConnectionGUID: 4LN1bvIrRcyFYrjq6LuVaA==
X-CSE-MsgGUID: o2Yzk5sMSBm9JX8ARarJYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="60150058"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa007.jf.intel.com with ESMTP; 15 Aug 2024 23:45:53 -0700
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
Subject: [Patch v4 5/6] perf tests: Add topdown events counting and sampling tests
Date: Fri, 16 Aug 2024 12:29:37 +0000
Message-Id: <20240816122938.32228-6-dapeng1.mi@linux.intel.com>
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

