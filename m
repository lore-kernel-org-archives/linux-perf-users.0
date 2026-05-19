Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB83EA97F;
	Tue, 19 May 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213067; cv=none; b=aMriaA+7Zp0SFnUmss4PrYZ6FWPh9Sh04hR05PrjE5w3ycOsSNAyJI3p045x+aLKEH9B0iaSyaGeyyRNjk8RSBpeU/6kTJcOUU6eBQhPv8GX6BDMi8wVymalxmBvt1tmSHFmqT/W+YMmpVSI3kYHBQkLJiIsc0PjNNVQlTzxuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213067; c=relaxed/simple;
	bh=JF/G830fxLsfhmVVCYFKHCOVvHpCJS410qYpqkz5oiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbnFS3s1PUXBn5FuA3RoEfZEabPHTb6bAjfV1mke16PY/Ms2Lgd4Xaegamy2dGCiqmTAe9GN2VYrMOUzRWaw40ZUorIbvX5iLHCR3BY9h2ZvQcCOWD2IsZOe3DAOW7AmLRVF3onr8JC94y14lmeB672xywCadKTZKtacm8tHACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1dP6jDm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1dP6jDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779213061; x=1810749061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JF/G830fxLsfhmVVCYFKHCOVvHpCJS410qYpqkz5oiM=;
  b=W1dP6jDmhzaGr/JoYWS9Qb3mYVdejeAviCsIpW9pH6HIFuQ4K7sKcBCx
   BLmCK5OZmCV2DiOyyQbunkvIilzuxkflCHByRdPjfuD0CixKlFvEJEjqx
   JC9Du0J2ZliOI+VrpuAa+0BvBd7Ds7sRlmdvzOL8P/tFowv7ObOMkho2n
   asCCYXA+SdtzgP+Wa6DwycYOL9LmFM4lxAsPOQlLz9V36IZPZ9zNLNHaK
   z5Va/YM430HY7SVOaNKTrd85DBN9HKFea1eUk7RucDyGjf2wzX+1pwLyF
   zmc/qiF+mwjMrnABhmLsHrh0K4j73l3+mXSE+1fav7okdz2EXT+k1PzfD
   Q==;
X-CSE-ConnectionGUID: 2LWXBCXxS1iOpMvJK+GSGA==
X-CSE-MsgGUID: 3ZAzGQmMSCuxvkfkcEM3vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79951780"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79951780"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:50:55 -0700
X-CSE-ConnectionGUID: BOO6qULWTPWwuMYdZFy4BQ==
X-CSE-MsgGUID: vo8a2dH4TRSCbLn55Ag26A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233475590"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.238])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:50:53 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [RESEND PATCH 0/2 v2] perf: Fix missing branch counter information in script and annotate
Date: Tue, 19 May 2026 12:50:41 -0500
Message-ID: <20260519175043.1490261-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two issues related to branch counter (br_cntr)
display in perf.

The first patch fixes a missing '+' indicator in 'perf script' output.
The '+' suffix is used to signal that event occurrences may have been
lost due to branch counter overflow.

The second patch fixes a regression in 'perf annotate' TUI mode where
the Branch Count column was never displayed. The check for whether to
enable branch counter display was performed before events were processed
and the counter data was populated, so the condition was never satisfied.
Moving the check to after event processing resolves this.

v2: Added a cover letter and expanded commit message for patch 1/2.
    Patch 2/2 was missing some conditional checks to enable branch counter
    display, which have been added back.
    

Dapeng Mi (1):
  perf script: Fix missing '+' indicator when branch counter reaches
    upper limit

Thomas Falcon (1):
  perf annotate: Fix missing branch counter column in TUI mode

 tools/perf/builtin-annotate.c | 9 +++++----
 tools/perf/builtin-script.c   | 8 ++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.43.0

