Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE8F25C71C;
	Mon, 12 May 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042788; cv=none; b=kkQdw6rpYZVhdVCTZypvoGkrsaIuuZCnb8JT5sQbqkRPU7Iyg2KE/h+lZRIOu6PufBVCgOiLmX+CYdgnJVB4XurAeUeOF2kAxkLkobeqhMYMK99wHHI3ScuL3sRohAM4svGLewlYTC2qdwv/hWWNj2UFe3KiMS57ZO93hpasD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042788; c=relaxed/simple;
	bh=OWGbpyjz6iNu9roYMjUG6JcftOX3y3OPJMVVhqZwbUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmjYj0zfP/n1FqUkuR79cneVW6ewGTPC/N/+AbstHngKcRbXi3tmYMXrO7y17EDDRTKfHl6TDVDZW6VPw8sbHWVySG6aGRVYasH6+QfNaqukj4g0FWRwOueX8jT10eM/eXcExcsJEftsy3s5k5u2x6KsQnBKI+AmISCaq5ROmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaqH5ju+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaqH5ju+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747042784; x=1778578784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OWGbpyjz6iNu9roYMjUG6JcftOX3y3OPJMVVhqZwbUM=;
  b=AaqH5ju+24juUMIquY+zj0vt59a5p7gp8I6QtB/5S3o1nyzl8N+UpqqQ
   p3dfstp2yU10LEYGTpvSox+rOy0VAxib8Dk0KpJwTBAh9y0kD7SBX04Mi
   1EwN5NhZAmJGRd/7V7C/1YXmeAAuy0QuuBAwK+C576r4qxY+LzHURUfud
   089J4gAaefaNoGtlBnLPuBLOiHBVFP16W59iss66s5R43zP2vygTPlwLp
   wnvjsiQ4W+gBhohqp29rDUd0oasEL6tNo9l8SGpOVnzugharwNMDLvKgY
   titdFaPhP3eWQlhmwrP+Lht6+9ji+x+ANVMKdYAt+Ro3srsQvo+8DaEAl
   w==;
X-CSE-ConnectionGUID: lhtyfeWLQjGsrKwexycssw==
X-CSE-MsgGUID: c1Efj8rkTYOW5XeE8NrLUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="36457512"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="36457512"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:39:43 -0700
X-CSE-ConnectionGUID: 54r1uWIUS7COrWvE+V9eow==
X-CSE-MsgGUID: qujVF/gkTeC0D9fYnWOSSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142214276"
Received: from bvivekan-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.245.245.139])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:39:41 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf intel-pt: Fix PEBS-via-PT data_src etc
Date: Mon, 12 May 2025 12:39:29 +0300
Message-ID: <20250512093932.79854-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Here are some Intel PT related fixes.


Adrian Hunter (3):
      perf intel-pt: Fix PEBS-via-PT data_src
      perf intel-pt: Do not default to recording all switch events
      perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3

 tools/perf/Documentation/perf-config.txt         |   4 +
 tools/perf/arch/x86/util/intel-pt.c              |  16 +-
 tools/perf/scripts/python/exported-sql-viewer.py |   5 +-
 tools/perf/util/intel-pt.c                       | 205 ++++++++++++++++++++++-
 4 files changed, 225 insertions(+), 5 deletions(-)


Regards
Adrian
