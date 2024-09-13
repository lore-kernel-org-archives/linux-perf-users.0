Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A23EA64;
	Fri, 13 Sep 2024 05:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726204874; cv=none; b=Gy/qAS41bnWgf3V78Esv1nkXwE093si2OyNO0+eFzow7s+/vbvpbHl8iVoMN4OBlKeaDBws32gKn5hSgLq3XYwWT53kKIomVuw77Mx3+2LRSgzubOnDpp1R5fzZj0/DiU4xRDSUY2B+EglR03gRKY+zfkFdszH/tIfc3fYbmPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726204874; c=relaxed/simple;
	bh=9mhtfvtunWRzgI8bl9G+jtMiHGKyFR/qD4W2JICRclQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VO8aFdPWUn/nOtkBCt0U4bsBHlDPVdWD1Txtz/RGx/cGFDQGPELd9Z91gmw4ogKSK2TfMhnqcwajcLR6pckX9Z9FSRb0p7hrY6yC7ZxW7AuTNtYY1G1xxHa8SSSRFLQ1puBnjC+g9gMHPIhmvJoh0+baFsi4RBO8B6oxHDbH7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQh2aSp5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQh2aSp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726204871; x=1757740871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9mhtfvtunWRzgI8bl9G+jtMiHGKyFR/qD4W2JICRclQ=;
  b=VQh2aSp5DZuZB8Qrth9Mehzk0myiZdRBKvBOXA3ODymLCFCCDQMMcm8n
   O44I7cxYeCu72tz09FdmLlY4u3Ms9KRci7v7eQT5B35cM2lFhsfD9Gw9m
   DMa4fY/mabwYSjdhWdSwJqax3rG45LWq1MQDc2xcCGXirjHUVVnZE7Bmg
   xacdOJidOR3u0pGzIXW0dM5rP30Q/IXfHM4ULwK4moENX/jw5L0ofiTw/
   stVvKN03YOPzFYKNREUSJYeQFmiMxhRjbL0RbkomZDlCaK/oyzNwBalFI
   D13G4XCWpHpsz1OFPgSTBcy8xX9zYoupWLPwoBX1pf2VTfgrYsi8KgSB0
   w==;
X-CSE-ConnectionGUID: cb+eKRxpRAmYclxdeaZ58A==
X-CSE-MsgGUID: F0GGkocdRh+zHp5/HaGq+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24967755"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24967755"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 22:21:10 -0700
X-CSE-ConnectionGUID: CvQlb3D2QLu0uBHqlC8Yug==
X-CSE-MsgGUID: AxhH5iE/SwiocrKLcV08og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67900580"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2024 22:21:07 -0700
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
Subject: [Patch v5 0/6] Bug fixes on topdown events reordering
Date: Fri, 13 Sep 2024 08:47:06 +0000
Message-Id: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
v5 -> v6:
  * no function change.
  * rebase patchset to latest code of perf-tool-next tree.
  * Add Kan's reviewed-by tag.

History:
  v4: https://lore.kernel.org/all/20240816122938.32228-1-dapeng1.mi@linux.intel.com/
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


base-commit: 1de5b5dcb8353f36581c963df2d359a5f151a0be
-- 
2.40.1

