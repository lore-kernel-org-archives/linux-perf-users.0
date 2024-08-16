Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40A81AB1;
	Fri, 16 Aug 2024 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790741; cv=none; b=baEWZ/gMwZD9MSo048qEuTciPZ8C0HLzhAoNF2qe5wC8vwhoAGLwySyv+gLgMPQ0YdYzuOKQ3hGRcPp7yBOI7c67kM112BqigZprQxUx2Icl7TBNupL1zI3gpEmBqt+pDEwS+/OqQzovkoWzQ6CIxfFdTKK6XXMykzYvti/+dxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790741; c=relaxed/simple;
	bh=BM3mmTwd9nhAhhQMEYFZRk/KGpcqH22Lu6l8cWMaeD4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pcd2lWcHnSzh4N8fDRAx4mjdPRaqICeYIB0SGKoeoCE9C2AJb4G8qvOzH6iHMzBLTru+mwFfynmmXyoCwEF/BXnQWaKcZlv7PVJPzQ68e/p3Hcqc2rEH+SH5W00o116W2IWIR8rlWZHp8BB75STZd2g0hp8HCHAqApoIxgwDJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIgginQV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIgginQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723790740; x=1755326740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BM3mmTwd9nhAhhQMEYFZRk/KGpcqH22Lu6l8cWMaeD4=;
  b=kIgginQVr+6kR38lRTSFM1ZzWh414199i/LKCtSx7krpTl4vNUMMs58t
   BMx3qepX1c8HjcaJkannBZOKCoG0AaWXMfbOGv5y2kykInvRa/WSSDL9W
   sC545ARrlVQF5VFxp3aEOpwF6vZSVsbUwH+5nWBH6xI7Ve6qvClT4hh0c
   TvkoM+sYd8xZbGBrgkuIcejBqGrm3n2oRxjTQLo0658AcJIl/U3zxRn8y
   PFUV3DQQ214iCg1kqXj+ph6FP3pmZPBteb/uGlJNOrA488+XPL6C0wpKu
   HRd8B8+9qa+q237h8+AwpfKq0gtwEVrL0cbLaZWQ1Kh8+o4xjiReTDpyT
   Q==;
X-CSE-ConnectionGUID: RGcjP+evTd+kfdS9cYLd3Q==
X-CSE-MsgGUID: /DkJ/DrcRLK+1xXzv215GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39530737"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39530737"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 23:45:38 -0700
X-CSE-ConnectionGUID: W0pspMy7SOSgg1IGdvXaDQ==
X-CSE-MsgGUID: 2G52cYW4RF6qMdOQ9HsPrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="60150003"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa007.jf.intel.com with ESMTP; 15 Aug 2024 23:45:36 -0700
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
Subject: [Patch v4 0/6] Bug fixes on topdown events reordering
Date: Fri, 16 Aug 2024 12:29:32 +0000
Message-Id: <20240816122938.32228-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
v3 -> v4:
  * limit metrics event searching inside group for group leader
    sampling (Kan)
  * add comments to illustrate supported and unsupported topdown events
    regrouping formats (Kan)
  * add more test cases to verify supported topdown regrouping
    formats (Kan)

History:
  v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.mi@linux.intel.com/
  v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@linux.intel.com/
  v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (6):
  perf x86/topdown: Complete topdown slots/metrics events check
  perf x86/topdown: Correct leader selection with sample_read enabled
  perf x86/topdown: Don't move topdown metric events in group
  perf tests: Add leader sampling test in record tests
  perf tests: Add topdown events counting and sampling tests
  perf tests: Add more topdown events regroup tests

 tools/perf/arch/x86/util/evlist.c  | 68 ++++++++++++++++++++++++++++--
 tools/perf/arch/x86/util/evsel.c   |  3 +-
 tools/perf/arch/x86/util/topdown.c | 64 +++++++++++++++++++++++++++-
 tools/perf/arch/x86/util/topdown.h |  2 +
 tools/perf/tests/shell/record.sh   | 45 ++++++++++++++++++++
 tools/perf/tests/shell/stat.sh     | 28 +++++++++++-
 6 files changed, 201 insertions(+), 9 deletions(-)


base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
-- 
2.40.1

