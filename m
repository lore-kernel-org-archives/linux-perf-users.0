Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332421078F;
	Mon, 24 Feb 2025 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361388; cv=none; b=CI+Ts9ayhy0S3ndc0oYTce8DoI1SrzT1BvrZnlGnHO2r8eO+ZFOxTIk1QIHpzd9Mv8zJPXVGAITThn+SJVq9Aab6om1PcBWNouF5PJmX8rFC7HmP6UQReL89kfUzBkCO8qQG8UN4qFGQ/KFrOU8TP4M4AH17Im4LFfb6Nl+jC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361388; c=relaxed/simple;
	bh=+fGMMmQJmUDha9+GSQFd7Vh4odXS6zP6KOJcMf0RKIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjTKnEOd+st74fTAfThoK1o3ym4k+C0IjT4XSdzwr6nFgTvQbU1ZJavtQmslZRlAeroIZgNte0I2VlKdVqqSzX/9M4P5vTWssxPdGYKSCqL4NwaUD4tT1xVxpa0GjVuTnib2IUBipf+lhBArtv2LXmLx4/2GF7MbBRJkDY5455s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvmUhVkG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvmUhVkG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740361386; x=1771897386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+fGMMmQJmUDha9+GSQFd7Vh4odXS6zP6KOJcMf0RKIU=;
  b=QvmUhVkGVwRQsrH4EnbbAGgiiVgVSnohNF0OPlMfpeZppMCJ/RgsOyd2
   YfgmzJcCO+ZdIW/KCfJLWibQDX41LW0Hteg0UUWtKJyujnX2sKmCeZvDR
   spvyDpb19kcOJRadQTpZPx2Yy+1tLwL5jbp+ccKrg81p8nKjvwhe9MMri
   9akk3jmrrUQkNdazCJJHUogUU3599iNfnQOj1dbNrBAbcDrRQstgoTqfS
   jXG58PnzYvITmBS3swkgpx7fJZ9G3h2wCktAD6JwYwtLVDTyNlVwRKHXt
   1A7sZ1RJSdCHn4dYGN4sVQe7tqczcO1qps1nDuVhLBVzaFTdQx+0MX930
   w==;
X-CSE-ConnectionGUID: aDlraoE9TwubV2KQxSTYdg==
X-CSE-MsgGUID: V5TijeJPRnSjPGLTkFowIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40293790"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40293790"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 17:43:05 -0800
X-CSE-ConnectionGUID: /cGXnOtHRTCFz7lce8+Lzw==
X-CSE-MsgGUID: xg6dlfh/S3K8sUZMLuorOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115892912"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa006.jf.intel.com with ESMTP; 23 Feb 2025 17:43:02 -0800
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 1/2] perf x86/topdown: Fix topdown leader sampling test error on hybrid
Date: Mon, 24 Feb 2025 08:33:05 +0000
Message-Id: <20250224083306.71813-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running topdown leader smapling test on Intel hybrid platforms,
such as LNL/ARL, we see the below error.

Topdown leader sampling test
Topdown leader sampling [Failed topdown events not reordered correctly]

It indciates the below command fails.

perf record -o "${perfdata}" -e "{instructions,slots,topdown-retiring}:S" true

The root cause is that perf tool creats a perf event for each PMU type
if it can create.

As for this command, there would be 5 perf events created,
cpu_atom/instructions/,cpu_atom/topdown_retiring/,
cpu_core/slots/,cpu_core/instructions/,cpu_core/topdown-retiring/

For these 5 events, the 2 cpu_atom events are in a group and the other 3
cpu_core events are in another group.

When arch_topdown_sample_read() traverses all these 5 events, events
cpu_atom/instructions/ and cpu_core/slots/ don't have a same group
leade, and then return false directly and lead to cpu_core/slots/ event
is used to sample and this is not allowed by PMU driver.

It's a overkill to return false directly if "evsel->core.leader !=
 leader->core.leader" since there could be multiple groups in the event
list.

Just "continue" instead of "return false" to fix this issue.

Fixes: 1e53e9d1787b ("perf x86/topdown: Correct leader selection with sample_read enabled")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/topdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index f63747d0abdf..d1c654839049 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -81,7 +81,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
 	 */
 	evlist__for_each_entry(leader->evlist, evsel) {
 		if (evsel->core.leader != leader->core.leader)
-			return false;
+			continue;
 		if (evsel != leader && arch_is_topdown_metrics(evsel))
 			return true;
 	}

base-commit: 4bac7fb5862740087825eda3ed6168e91da8b7e6
-- 
2.40.1

