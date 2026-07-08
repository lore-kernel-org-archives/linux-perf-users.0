Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135293BE165;
	Wed,  8 Jul 2026 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489148; cv=none; b=kMRap0wvflC5K2t36bA7weHU72kOVM4910SCycO8sdBcF58vhheTtxppeUFYPZSdYetqvfbTygXCpf/wqAkZuzVjp00TU26Xc66En59eO+gH2YhJjgcn7+aIC9DOzTXRtfCJ9ZGzUDRvAolwDdP+6a5lTydYkPOFEJB6cFUlijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489148; c=relaxed/simple;
	bh=3QoFQofQo/PqCjBVaF+LBcDBtmYjDMkQ/Xo0oKbUO2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oDs1P9T0AAsuPoHu8Wiqjldet5VVtmwOxBRqrfRLUMq8Xmb42AFcNgrOGRFtIsjt0TC17HlRjoXvZi9uv35gB2GYky0RzUQQsAFKPM1QXqNXFSCsFWcX0rCwlqeoktLM+bEsUDsTu/IQf2BIyihKLxlsomP12s/scGEKA6073+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1AJXKDb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1AJXKDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783489147; x=1815025147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3QoFQofQo/PqCjBVaF+LBcDBtmYjDMkQ/Xo0oKbUO2E=;
  b=X1AJXKDbnjWuj2lmnYIXxKsPt6CgRZgXnvBOfI1F1Bu3E4FF9n7arj6c
   Ovm6D/UG7vhLnvrOGqIyrn8ko8Oab4hXtN1Vnax+Vt7uoVEfutsz4nO+Y
   3C9j25vuVQKNoGgpkyFn5ANshFe9xd5Jo3QfSv1X6WchiHeDLiR1L38pV
   eHCXgXdJYbF2T19d4U9zC9qb6txMRrGTAbaXxooB4p2NQUovhS5RhiCdF
   hu9aLJJFnD6frw68nmQh+6IfneWczf+3rAY9LT4wo1RXPHnPLLUgDbSLX
   WudJ9LaDi+T6odslb0Ur8x5G4jmft0/Y7A4fzvokNl/h+AktVmteN5mBR
   Q==;
X-CSE-ConnectionGUID: J5JiI1lVTFOayyCc8ImyYg==
X-CSE-MsgGUID: XTadi1ytTYmJZ+wOY8UsTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83922120"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83922120"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 22:39:07 -0700
X-CSE-ConnectionGUID: ytcZkJUgQR6mS1FEjKrBUg==
X-CSE-MsgGUID: LjBDKEWVT06GydrB/BvS3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253099585"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa010.jf.intel.com with ESMTP; 07 Jul 2026 22:39:03 -0700
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
Subject: [PATCH] perf jevents: Add Intel OMR MSR mappings
Date: Wed,  8 Jul 2026 13:32:26 +0800
Message-Id: <20260708053226.3776183-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New OMR MSRs are introduced for OMR events on DMR and NVL. Perf continues
to reuse the existing offcore_rsp attribute to encode the MSR value,
similar to existing OCR event handling.

Add the corresponding OMR MSR mappings in lookup_msr() so jevents can
translate these events and generate the correct offcore_rsp attribute.

Link: https://lore.kernel.org/all/20260114011750.350569-2-dapeng1.mi@linux.intel.com/
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 376dc2d24162..2bb51cc621b5 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -249,6 +249,10 @@ class JsonEvent:
           0x3F6: 'ldlat=',
           0x1A6: 'offcore_rsp=',
           0x1A7: 'offcore_rsp=',
+          0x3E0: 'offcore_rsp=',
+          0x3E1: 'offcore_rsp=',
+          0x3E2: 'offcore_rsp=',
+          0x3E3: 'offcore_rsp=',
           0x3F7: 'frontend=',
       }
       return msrmap[int(num.split(',', 1)[0], 0)]
-- 
2.34.1

