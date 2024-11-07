Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DDE217334;
	Thu,  7 Nov 2024 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984000; cv=none; b=qQlMYpV2I+/rjBKc7PiWNk6kUqgIQet0dZ9z76GMacd5JBK0cEX0YUGEMwkmDZPTtXUAVgr1ZUWblsFc1IBKrLX5x2ntGPxQnrTU6b2ZZUFqDdxy1HIMwha95O2vOL0kktcqn1PJ8BNJjMSo9RjaTEodltjuboXtcqmM50jF32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984000; c=relaxed/simple;
	bh=2ac+t00RJGiy3YUCVZhCktDeGYaH1csfAwFKng5t2wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jgpx7FZW56Nou1sBAD6/lLpJEWyqH2T05rARrCFIffnZcjLflQslcxkfx0X9xwmOW6ulz3BYgactvnYIDdFtCw9DaTImXTARGZH5TY0E5mOih/01sM0u3RSv3QfMqrAwBIBMWMaDPprhpT3B7HI+YPPxPm+lxK1fhQiEsYrO50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1D77497;
	Thu,  7 Nov 2024 04:53:46 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A1273F66E;
	Thu,  7 Nov 2024 04:53:15 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/3] perf cpumap: Refactor perf_cpu_map__merge()
Date: Thu,  7 Nov 2024 12:53:05 +0000
Message-Id: <20241107125308.41226-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_cpu_map__merge() has two arguments, 'orig' and 'other'.  The
function definition might cause confusion as it could give
the impression that the CPU maps in the two arguments are copied into a
new allocated structure, which is then returned as the result.

This patch series refactors perf_cpu_map__merge(), makes that the first
argument 'orig' as a pointer to pointer, the merged result will be
updated into 'orig' rather than returning a pointer.  This can be clear
for the semantics that it merges 'other' into 'orig'.

The perf test has been updated for covering more cases for CPU map
merging.  Tested result is:

  # ./perf test 41
   41: CPU map                            :
   41.1: Synthesize cpu map               : Ok
   41.2: Print cpu map                    : Ok
   41.3: Merge cpu map                    : Ok
   41.4: Intersect cpu map                : Ok
   41.5: Equal cpu map                    : Ok


Leo Yan (3):
  libperf cpumap: Refactor perf_cpu_map__merge()
  perf cpumap: Add more tests for CPU map merging
  perf cpumap: Add checking for reference counter

 tools/lib/perf/cpumap.c              | 49 +++++++++++++------------
 tools/lib/perf/evlist.c              |  2 +-
 tools/lib/perf/include/perf/cpumap.h |  4 +--
 tools/perf/tests/cpumap.c            | 54 ++++++++++++++++++++++------
 tools/perf/util/mem-events.c         |  5 ++-
 5 files changed, 77 insertions(+), 37 deletions(-)

-- 
2.34.1

