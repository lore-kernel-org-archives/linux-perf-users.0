Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF041A80;
	Wed, 22 May 2024 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716410588; cv=none; b=aD7+7FsBEoD7ptS9LpO4npxx0+Gau49T7IpfjxqPksMNSfFvC+h/CX0stsJXVKBcENTu2/oVBjbTh/8xscmrWOSS4NPIQjKwAazwBX1d/mykfmBXgqdNZFSUm4ituYx9XupVNnsc0tsBmNw3q0LEaWOFqUJtxiDtlww6cQYI2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716410588; c=relaxed/simple;
	bh=vSToaAWtI+UPNyxsJqewuE9SnVckwS20wFWAi6Bsrn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubvDmpXamTSuJmEEqP6sRpGAidHJ05Rw6Xrj+cxrjhr4Yc0zx5mIpMoh18tGkcHwzjJ5XyDmzxabxzTR4oCjdoqg8AlPxXwZn3IPLlTjZ10FPBrCPleLVFsaHES2dL+YGMWFdzbLAUFSsmKgLeV8S4+8DqVBFTdPeC3uBdPxv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7YoX9Sq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7YoX9Sq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716410587; x=1747946587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vSToaAWtI+UPNyxsJqewuE9SnVckwS20wFWAi6Bsrn0=;
  b=Y7YoX9SquuxnEzTJIE4kph/tNWsfNO54gwOfTzLJN4r63YbADxcIMne/
   rCVv1bJvf0nPr8RY0W+k/MFm7ZMZrftTe4IJuER7pzlQ1LPRKiQApJo1B
   TVVAfBefsxY3Fb/BEthFthcPDFcmxQaYUWRqxsDqecaCG6pyKVr4oQPlw
   7pgXBdMfZVk6gsmhieK2KjJ7y6ldI8/0Y6XTFsaFHIUFK+YrRBi7pZR6A
   ROD8R26UNL7OVKl0RlAQMJiUxxoWYpQGnzgthMOStlbNf9QKB4+WdDmoz
   BwJzzymlJWTD9DLC+Su5pCh+av9JbFsWKgiLY6/l6zmgBMPu2pvsVvaT8
   Q==;
X-CSE-ConnectionGUID: QtVu16vtTHu1gJX0LtrQww==
X-CSE-MsgGUID: CLG+wj07QMK8N1py2bWDHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23827657"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23827657"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 13:43:06 -0700
X-CSE-ConnectionGUID: xFsTQ040Qf2GV9etUehbUg==
X-CSE-MsgGUID: NtZGR2rcSoOELGV7oq9UDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="64648569"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by fmviesa001.fm.intel.com with ESMTP; 22 May 2024 13:43:05 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [PATCH v1 1/1] perf test: make metric validation test return early when there is no metric supported on the test system
Date: Wed, 22 May 2024 13:42:54 -0700
Message-ID: <20240522204254.1841420-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add a check to return the metric validation test early when perf list metric
does not output any metric. This would happen when NO_JEVENTS=1 is set or in a
system that there is no metric supported.


Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/tests/shell/lib/perf_metric_validation.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/tools/perf/tests/shell/lib/perf_metric_validation.py
index a2d235252183..0b94216c9c46 100644
--- a/tools/perf/tests/shell/lib/perf_metric_validation.py
+++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
@@ -95,7 +95,7 @@ class Validator:
                       indent=4)

     def get_results(self, idx: int = 0):
-        return self.results[idx]
+        return self.results.get(idx)

     def get_bounds(self, lb, ub, error, alias={}, ridx: int = 0) -> list:
         """
@@ -173,7 +173,10 @@ class Validator:
         pcnt = 0
         tcnt = 0
         rerun = list()
-        for name, val in self.get_results().items():
+        results = self.get_results()
+        if not results:
+            return
+        for name, val in results.items():
             if val < 0:
                 negmetric[name] = val
                 rerun.append(name)
@@ -532,6 +535,9 @@ class Validator:
         '''
         if not self.collectlist:
             self.parse_perf_metrics()
+        if not self.metrics:
+            print("No metric found for testing")
+            return 0
         self.create_rules()
         for i in range(0, len(self.workloads)):
             self.wlidx = i
--
2.42.0

