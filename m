Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B223220F49;
	Wed, 23 Sep 2026 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128934; cv=none; b=P9OdNvNUbFkw87z4RTYJXf7eZudvLpFlF1mect0+SLWSp7H8Ly/WN+Krm7ljhTpERdlKfh6B93sEqvCod5aGQQaifUzEmSu3LMV1OzOV41UmyImtyzhRNv5hOe6MpURNdl3nTDaOwGWTush1i/x/6svRroUFTdUakNbBbhRiDPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128934; c=relaxed/simple;
	bh=bio4YOFhc2GECIi47z621ruaYq9Ev41Dg88V9sDgF6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OTJFUR13LXc6TOej/3sYNIWWgwBJbIJVEtggjagSEeNYZafTgiZeA7b4PU+zxSkQh6ftwyp4qQiglS0Chv8//YF9bqGG686PRcuOLl7P2Ym6XAv969DAHSjLE75xoTIr5/ZryJa0tjMIa0ktPyDqo1vgFTjFl9PT1Qsgd6sW8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nclFIl8q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nclFIl8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790128933; x=1821664933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bio4YOFhc2GECIi47z621ruaYq9Ev41Dg88V9sDgF6A=;
  b=nclFIl8qRAvuubagrWtPyp1gKT7Mp5OzT9YyKxCMCXKVhMfn4VlBsFZP
   SwqPuNi6vI4+BDqyLgRnSd1/iwbmi1D66eb1RRK3ZQq8+wgaX5hTs6eQg
   S50GeVY+RykO8L7BpWmnlUFPH7CApNdwyf3Ly6NlJI2WTiEIANkKwZ/0U
   SdJN5OlcZPOcFmk+mdwpgOuvgIWks6SvKz5qBzrrbrGidLCZjox/XDgWu
   SwbzUI4/7XQW0Dg5l5jVnohiTg4IzYoLh6nS9k0WPkXjacwX3nC41LydW
   S2zC8BMMini4ssRN2bgTZ+9RMb8ruSsW2lu0uLRpy0NfVBpwsWcgTw0ep
   A==;
X-CSE-ConnectionGUID: e2d5KnsoRg+Pmzyq1/9acQ==
X-CSE-MsgGUID: l66mRNC9RwSloSyCcadZTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="93285546"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="93285546"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 19:02:12 -0700
X-CSE-ConnectionGUID: 8u2wUIypSdiRHdyqYpZsPA==
X-CSE-MsgGUID: xohlvFzlROGQ5CflPUqzlg==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 22 Sep 2026 19:02:08 -0700
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
Subject: [PATCH] perf jevents: Rename OMR offcore_rsp attribute to offmodule_rsp
Date: Wed, 23 Sep 2026 09:55:17 +0800
Message-Id: <20260923015517.2665398-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel renamed the OMR data attribute from offcore_rsp to
offmodule_rsp to avoid confusion and keep the naming consistent.

So update the perf jevents msrmap accordingly.

Link: https://lore.kernel.org/all/20260917015234.981153-12-dapeng1.mi@linux.intel.com/
Link: https://lore.kernel.org/all/20260917015234.981153-13-dapeng1.mi@linux.intel.com/
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

Note: The dependent kernel patches have been queued into tip/perf/urgent
tree.

 tools/perf/pmu-events/jevents.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 860027bb71b2..93cf04fa8ca4 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -249,10 +249,10 @@ class JsonEvent:
           0x3F6: 'ldlat=',
           0x1A6: 'offcore_rsp=',
           0x1A7: 'offcore_rsp=',
-          0x3E0: 'offcore_rsp=',
-          0x3E1: 'offcore_rsp=',
-          0x3E2: 'offcore_rsp=',
-          0x3E3: 'offcore_rsp=',
+          0x3E0: 'offmodule_rsp=',
+          0x3E1: 'offmodule_rsp=',
+          0x3E2: 'offmodule_rsp=',
+          0x3E3: 'offmodule_rsp=',
           0x3F7: 'frontend=',
       }
       return msrmap[int(num.split(',', 1)[0], 0)]

base-commit: edd8a9fe2eca009599e013a29c421c7a6b5ad1b9
-- 
2.34.1

