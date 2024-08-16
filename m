Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8A13A26B;
	Fri, 16 Aug 2024 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790759; cv=none; b=a94rnjvsI6IPlPjCyWGbP1BcpbAqI+L1P7OXuOfF1EmrUQWx2kR3a/Q4MBuOvMENtevRzXD11nG60czcU0Qgzy24PvN8vm5Mf6fhRMTDsmFpB1S1Vvqh+92uNiUmXV8FkCKE3HbtM/e5II3Ob5mHDSjOP/j+BE+DcPTYnb0RQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790759; c=relaxed/simple;
	bh=PyZgNILmP4YBkkVr6sygCkBQ67L4OAU6Lr5J99p0djE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYZUUz98shy6MfUoPrPVh5UejCTUKo0Pl4PRODF+E5VFGj/UDhWIWqcy5a9HsQanAhI0+3Bz8f46q6ppl/iT6OSeSyMF/9FT1dCBoNYSkUhqSfdsj7vz4l1EnmavPdM17tgYjmMw22MgSQkuteQffFn96WFdRd5mCfzaQoYNbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/3Oa+e6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/3Oa+e6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723790758; x=1755326758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PyZgNILmP4YBkkVr6sygCkBQ67L4OAU6Lr5J99p0djE=;
  b=H/3Oa+e6EgBfyRmvr+hSqIw5BxQcCtZJZs+1LJdpOFvb0tBzq5fpqLyM
   OloZ7RgWiq+4+BAJVC/ZBIhHNLK/8UZgNRbcSNGuSyIjFsyIyl9RuAuMc
   /HNPMay2QasRb2ockbTT7fsfJPvqQ+eL0mTxPKwuik0wiMeiq+cuCHDaE
   pKMaUReMFSiSPWEaeIernZRaqttYCyhasxNqtnk9w5f5/KaV2DuQp2tM5
   Bboxjk08gJxFX07zqzEYZGeLHZ5Dpv0hwUc8/Uj6gpJy7eU4f/L2m/uEE
   YhGx9Eug70OE/QqQFtxZwk8qCG4jT7wqLULSYl7gCKCf1tYlEgCUS9hMP
   A==;
X-CSE-ConnectionGUID: wG+GA3uAR/O/nP+GlHEifA==
X-CSE-MsgGUID: G251xN08Sy6WZVRfMiFQDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39530797"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39530797"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 23:45:58 -0700
X-CSE-ConnectionGUID: DuWe3jLgQguiDKseF7Cg1A==
X-CSE-MsgGUID: 3djLFv0xTo60dRSDhdlzYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="60150062"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa007.jf.intel.com with ESMTP; 15 Aug 2024 23:45:56 -0700
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
Subject: [Patch v4 6/6] perf tests: Add more topdown events regroup tests
Date: Fri, 16 Aug 2024 12:29:38 +0000
Message-Id: <20240816122938.32228-7-dapeng1.mi@linux.intel.com>
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

Add more test cases to cover all supported topdown events regroup cases.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/stat.sh | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 092a7a2abcf8..85897898a1f4 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -73,9 +73,27 @@ test_topdown_groups() {
     err=1
     return
   fi
-  if perf stat -e '{topdown-retiring,slots}' true 2>&1 | grep -E -q "<not supported>"
+  if perf stat -e 'instructions,topdown-retiring,slots' true 2>&1 | grep -E -q "<not supported>"
   then
-    echo "Topdown event group test [Failed slots not reordered first]"
+    echo "Topdown event group test [Failed slots not reordered first in no-group case]"
+    err=1
+    return
+  fi
+  if perf stat -e '{instructions,topdown-retiring,slots}' true 2>&1 | grep -E -q "<not supported>"
+  then
+    echo "Topdown event group test [Failed slots not reordered first in single group case]"
+    err=1
+    return
+  fi
+  if perf stat -e '{instructions,slots},topdown-retiring' true 2>&1 | grep -E -q "<not supported>"
+  then
+    echo "Topdown event group test [Failed topdown metrics event not move into slots group]"
+    err=1
+    return
+  fi
+  if perf stat -e '{instructions,slots},{topdown-retiring}' true 2>&1 | grep -E -q "<not supported>"
+  then
+    echo "Topdown event group test [Failed topdown metrics group not merge into slots group]"
     err=1
     return
   fi
-- 
2.40.1

