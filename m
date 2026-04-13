Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D13140DFC3;
	Mon, 13 Apr 2026 01:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776042850; cv=none; b=XUvAdZbPe5gg2kH2oX2wTKe69hUAeX5Ysp07URWFQLoskAHxI38TjePPQaCiZvCkJ5k3SKLkTYW1PnU9egxRyMcxvUmD3Is+9NZgJhUfx2vkTtTZywgVuz9kDgLp6J565qbXEnSnqCm5p1o0z6i66DOSbnVhUHnAUTCDtDt9OXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776042850; c=relaxed/simple;
	bh=XN1+YO7A+pjk8feH0l70+LPdjX09SYt+tbI57FLTsgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U7cO9cahq8F/Ku0WuOZFaHVaTxYMW+ForivzMdBpsP4dmBATtPCPGARnygJ13s06XvQVxyQaWGlDUrFlp4s8nRYbyETZ7EGSMWcfy5MMf6XnHMa6ZzyI5mhYj+UjGBCKourRv+cK68SIo5SDx/deYEMGQD1mfk0OOvp3T1x5RI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nY1MKU7k; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nY1MKU7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776042849; x=1807578849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XN1+YO7A+pjk8feH0l70+LPdjX09SYt+tbI57FLTsgk=;
  b=nY1MKU7kKkimohZ3r1dhdBnAll9TlNyv0KFC7YPmY7ZGOr0BPihMWoi0
   pqYUdpF5DfpJiw5XVmdYsRYQ2guXLraDy7oub6caSSqu+LGomFS6TUSxp
   jLBhAp+v4xqdytC1LeGRqQGD1IE91LqCfn4SeMaipYulvVS36xKDbs0W3
   qTkKX7j2cpprAYS6wVp0TRmBaA+G9oVZGk24iE5Y3yUyGZ9zGP3zn85er
   S5GHBIWUj3uRcDSWCSutkXB4RTJLVGoAD3pCJOFOb5ek+xRO25lklos2F
   YjhqKhBWlLBw9ugrfwGHrEezBXwnVZic3+UAHq/sE5sapoP0ykGyLdhmj
   g==;
X-CSE-ConnectionGUID: u6OlcDLDQByT0TaWqAzfGw==
X-CSE-MsgGUID: GgUsQeZJQaOFQqx4z/4OXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="94365103"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="94365103"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 18:14:09 -0700
X-CSE-ConnectionGUID: 5BZat5fBTyiPZXPY3Qc/Kw==
X-CSE-MsgGUID: cxN0RObfQiWtEndYHBPtGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="226942094"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 12 Apr 2026 18:14:05 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH] perf tests: Add auto counter reload (ACR) sampling test
Date: Mon, 13 Apr 2026 09:09:20 +0800
Message-Id: <20260413010920.546501-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add auto counter reload sampling test to verify that the intended event
records can be captured and the self-reloaded events won't generate any
records.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 7cb81cf3444a..1068843282f5 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -402,6 +402,47 @@ test_callgraph() {
   echo "Callgraph test [Success]"
 }
 
+test_acr_sampling() {
+  events="{instructions/period=20000,acr_mask=0x2/u,cycles/period=40000,acr_mask=0x3/u}"
+  pebs_events="{instructions/period=20000,acr_mask=0x2/pu,cycles/period=40000,acr_mask=0x3/u}"
+  echo "Auto counter reload sampling test"
+  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/null
+  then
+    echo "Auto counter reload sampling [Skipped not supported]"
+    return
+  fi
+  if ! perf script -i "${perfdata}" | grep -q "period=20000,acr_mask=0x2"
+  then
+    echo "Auto counter reload sampling [Failed missing instructions event]"
+    err=1
+    return
+  fi
+  if perf script -i "${perfdata}" | grep -q "period=40000,acr_mask=0x3"
+  then
+    echo "Auto counter reload sampling [Failed cycles event shouldn't be sampled]"
+    err=1
+    return
+  fi
+  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog} 2> /dev/null
+  then
+    echo "Auto counter reload PEBS sampling [Skipped not supported]"
+    return
+  fi
+  if ! perf script -i "${perfdata}" | grep -q "period=20000,acr_mask=0x2"
+  then
+    echo "Auto counter reload PEBS sampling [Failed missing instructions event]"
+    err=1
+    return
+  fi
+  if perf script -i "${perfdata}" | grep -q "period=40000,acr_mask=0x3"
+  then
+    echo "Auto counter reload PEBS sampling [Failed cycles event shouldn't be sampled]"
+    err=1
+    return
+  fi
+  echo "Auto counter reload sampling [Success]"
+}
+
 test_ratio_to_prev() {
   echo "ratio-to-prev test"
   if ! perf record -o /dev/null -e "{instructions, cycles/period=100000,ratio-to-prev=0.5/}" \
@@ -457,6 +498,7 @@ test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
 test_callgraph
+test_acr_sampling
 test_ratio_to_prev
 
 # restore the default value

base-commit: 4e03d6494f9504f8af46ba68a2a8b6877c196789
-- 
2.34.1

