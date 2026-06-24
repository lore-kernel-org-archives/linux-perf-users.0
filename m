Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD853A3E8B;
	Wed, 24 Jun 2026 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293948; cv=none; b=nvBQ7NyteaZ5h3ZL/v/QAFPdR8Y5LNsteF63/VFn9YSgIDWnQVejmEUlicx9RHxyYevKJGApWy53KxkBwpTqBY9dXYRNe7qrnGs8cV37wkOAcuC5L0mYCpzBZuO4tkq0IEhPeSey0i0Zj2VpIpMuG91zYs1NoUD8tji+8Lb+jiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293948; c=relaxed/simple;
	bh=HbGpwqHngTix9zuzjwtgAwowR/puI6WNCd6x5rm9r3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=smLr5UrV8P7jjgHPuco793hF1XZGLom/fYoKa0m1q1KcBrc8LvcBSMrK/tjNCMz74MmQUE6CLc9/iu92Mqc5u1v4lJhc3FordFP0m/aisCei1QCHJ/JW5vBHegh/1Iq8IzZjHcALcVpgcLGGBgTIjhUpr5RIgd1KpRUcsnGaHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Se5CX/RJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Se5CX/RJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782293942; x=1813829942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HbGpwqHngTix9zuzjwtgAwowR/puI6WNCd6x5rm9r3k=;
  b=Se5CX/RJMg7lRrpZHy6zNp8fvrXS0q/wdNm8AUgNb7Au3IOTD0EywBBF
   AoBr3dGyNqPrm1eYneoPYIuW2XWE5w5ITn0nOUiRBnCxw2L1Llnl2o/y7
   mYaFMHeEWLX1i+5P/6dzU++Lvo+IQu5oHVBpvPKpoiovZZzpH9bbP8XBd
   ahU8k3gjm3XqW8LMMBC5BGZLzHfx1p65gHttsD+TgVT7LLx0ko4NOcOw7
   sTUfNTz6rsS9Ql9LxXXYR7m+3SAsINllUby4x4tv4gxc8f3qhBpJV8x9o
   bkLZ9AvUBltARdE2vkBx9c7gino6I58adpUAFCjnl/0KNZP7Ixfm/Qbsg
   A==;
X-CSE-ConnectionGUID: NoJSe646TJybZrh1UwkoLA==
X-CSE-MsgGUID: 98iiU8ieR3GvqQkD4bHluQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="105844686"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="105844686"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 02:38:59 -0700
X-CSE-ConnectionGUID: +n99EoZzQfWvPYFC2NLmcQ==
X-CSE-MsgGUID: M2L4fjyqSK2bUM0VE1yIXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="243410101"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 24 Jun 2026 02:38:55 -0700
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
Subject: [Patch v4] perf tests: Add auto counter reload (ACR) sampling test
Date: Wed, 24 Jun 2026 17:33:16 +0800
Message-Id: <20260624093316.1439582-1-dapeng1.mi@linux.intel.com>
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

V4: Remove model-specific ACR sampling test in ratio_to_prev test to
avoid false positive. Some hybrid platforms only support ACR on E-cores,
e.g., PTL. If the test process is scheduled on P-core, it leads to false
positive since P-core doesn't support ACR. test_acr_sampling() is
already fair enough to validate ACR sampling functionalities.

History:
V3: https://lore.kernel.org/all/20260421045511.2401316-1-dapeng1.mi@linux.intel.com/
V2: https://lore.kernel.org/all/20260420025501.2133495-1-dapeng1.mi@linux.intel.com/
v1: https://lore.kernel.org/all/20260413010920.546501-1-dapeng1.mi@linux.intel.com/

 tools/perf/tests/shell/record.sh | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 7cb81cf3444a..5819f11ad3a9 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -402,6 +402,48 @@ test_callgraph() {
   echo "Callgraph test [Success]"
 }
 
+test_acr_sampling() {
+  events="{instructions/period=40000,acr_mask=0x2/u,cycles/period=20000,acr_mask=0x3/u}"
+  pebs_events="{instructions/period=40000,acr_mask=0x2/pu,cycles/period=20000,acr_mask=0x3/u}"
+  echo "Auto counter reload (ACR) sampling test"
+  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/null
+  then
+    echo "Auto counter reload sampling [Skipped not supported]"
+    return
+  fi
+  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
+  then
+    echo "Auto counter reload sampling [Failed missing instructions event]"
+    err=1
+    return
+  fi
+  if perf script -i "${perfdata}" -F event | grep -q "cycles"
+  then
+    echo "Auto counter reload sampling [Failed cycles event shouldn't be sampled]"
+    err=1
+    return
+  fi
+  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog} 2> /dev/null
+  then
+    echo "Auto counter reload PEBS sampling [Skipped not supported]"
+    echo "Auto counter reload sampling [Success]"
+    return
+  fi
+  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
+  then
+    echo "Auto counter reload PEBS sampling [Failed missing instructions event]"
+    err=1
+    return
+  fi
+  if perf script -i "${perfdata}" -F event | grep -q "cycles"
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
@@ -457,6 +499,7 @@ test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
 test_callgraph
+test_acr_sampling
 test_ratio_to_prev
 
 # restore the default value

base-commit: 40db90ac9f66c8246c1746c56d397283d161655c
-- 
2.34.1

