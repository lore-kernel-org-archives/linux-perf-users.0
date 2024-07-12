Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E114039E;
	Fri, 12 Jul 2024 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779691; cv=none; b=aPJK+2MtQj8eRYPpcEnT4wCqLF8R8EnGJ6z2isHFMudevmQXSeqAmD/HCDipy7tAJn4UAqyfgqIzmDjyXtqkyP/h0NNYGvT3W4hLSKpBF5B+ik+81m/uZBXK1EAVO0yKa0Hsd+rU6G7O0LGaGoJu25gEGGc7D6MMlX4Z/98r7Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779691; c=relaxed/simple;
	bh=o/OQzjj4Q19TT6pXb75/cRh/pyYPf9i+smgytjVFrbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pq94Nj7AjMeiBIuXO5n+2ACv4u1Z6YJgVxKYwRkrFZsFDiIZxh2CbB45HYOey53MiNm3PmuT7RSHgQrVkPmfP4lVFR9ptXimw+BOpVrhrkFHVQXMZaakAAq7a9PR+aTu+iKc6VgpuDehHEZ0z1XtufncyD30zUCNC1ee3EDrFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LuvKU8ug; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LuvKU8ug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720779690; x=1752315690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o/OQzjj4Q19TT6pXb75/cRh/pyYPf9i+smgytjVFrbc=;
  b=LuvKU8ugCH0IukIgzwek5WogVJVzwsCD+Xy8+X/aIw+TqOnLdEDTf/eL
   aFO1Eqv4URyR87b1qfJwdXPfvJjI5eb3k6bSUXFhBOz1dQx8JOaM7Xv6t
   bigT7E2rq3aTcQNvGLnfIVDdDy0E7iwE1XPaqCewxuk+p+gKeycQ5uzlc
   J1yszS7w2SqQfkHXAiFUUVDjKy3dU8V6izEZjn6LHqBp5D8UTLmDapyv6
   z/hWMecgqXOeTa5BQAWpCSNTM0iQoIrjWYT4qPOr3cmRWhMRYdHcU4bjE
   H4XfS//g67TbNvrUkW8nCmZiyDYIigGLBi5YpiVhBbNZ4wU54qdDh95nr
   A==;
X-CSE-ConnectionGUID: ejYdIAPXQXWiVkA9jbaZrQ==
X-CSE-MsgGUID: HpCpp+OPQ+y34Ucny1W35A==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="35756753"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="35756753"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 03:21:29 -0700
X-CSE-ConnectionGUID: buARklK3T26zTWd2H1tWTg==
X-CSE-MsgGUID: sWnkryTySt6Ytqom+fvdYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="79576222"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 12 Jul 2024 03:21:26 -0700
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
Subject: [Patch v3 0/5] Bug fixes on topdown events reordering
Date: Fri, 12 Jul 2024 17:03:34 +0000
Message-Id: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
v2 -> v3:
  * Refine arch_is_topdown_metrics() (Kan Liang)
  * Only move topdown metric events forward when they are not in the
    group with previous event (Ian)
  * Check if topdown events is supported before test topown events
    leader sampling (Kan Liang)

History:
  v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@linux.intel.com/
  v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@linux.intel.com/


Dapeng Mi (5):
  perf x86/topdown: Complete topdown slots/metrics events check
  perf x86/topdown: Correct leader selection with sample_read enabled
  perf x86/topdown: Don't move topdown metric events in group
  perf tests: Add leader sampling test in record tests
  perf tests: Add topdown events counting and sampling tests

 tools/perf/arch/x86/util/evlist.c  | 13 +++++--
 tools/perf/arch/x86/util/evsel.c   |  3 +-
 tools/perf/arch/x86/util/topdown.c | 62 +++++++++++++++++++++++++++++-
 tools/perf/arch/x86/util/topdown.h |  2 +
 tools/perf/tests/shell/record.sh   | 45 ++++++++++++++++++++++
 tools/perf/tests/shell/stat.sh     |  6 +++
 6 files changed, 124 insertions(+), 7 deletions(-)


base-commit: 73e931504f8e0d42978bfcda37b323dbbd1afc08
-- 
2.40.1

