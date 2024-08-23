Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB388469D;
	Fri, 23 Aug 2024 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412817; cv=none; b=YCFy7igpz9MRBmM89/wT58RrJACsHB5rAjJSBi4zt97QJu/enPDBEGlQn9yutDc9w6esMeBKcxBqF/4Z1du+aWrarn3GenWANeuU0AOYC4Y+nrYXA/KxBish+6PIujYQEDX+zD4Bo1eyPPXuv/yVyE1kOoCAxK0VNj+mwtBN8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412817; c=relaxed/simple;
	bh=Ya0YompZ78xHu5FXa+le+gsHI9P9F7LCgLYaQw87L/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=En98Ngroz4E8P5Kbu2BjSHFHXd8BqYSgt1GktI3qkX94D+ExSxoWu1ZtHhOqgcetoNGl3HV+C5YFa/HQyzVQVZ0ns125BIUJApxVJQFjSSHIgUPh/W2eKYqbLlGHjDyKzGID7TpFphgDtE8NTkLr/rd8pCTYYocanGGNvFMidgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E547DA7;
	Fri, 23 Aug 2024 04:33:54 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 323ED3F58B;
	Fri, 23 Aug 2024 04:33:26 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v6 0/8] perf auxtrace: Support multiple AUX events
Date: Fri, 23 Aug 2024 12:32:58 +0100
Message-Id: <20240823113306.2310957-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is to support multiple events with the *same* type in Perf
AUX trace. As the events are same type, the trace data shares the same
format and can be decoded by the same decoder.

Note, a more complex case - different types of AUX events, (e.g. Arm
CoreSight event and Arm SPE events are enabled simultaneously) - is
still not supported.

Patch 01 is to change the perf core layer in the kernel to allow
multiple AUX events to output to single FD, so that '--per-thread' mode
can be supported.

Patches 02 and 03 are refactoring with using evsel__is_aux_event().

Patch 04 validates the AUX events' CPU map. It presumes the AUX events
do not overlap for CPU maps, otherwise, it returns failure.

Patches 05, 06, 07 are to support multiple AUX events for buffer mapped
index.

Patch 08 is to support multiple Arm SPE events during report phase.

The patch series has been tested with multiple Arm SPE events (arm_spe_0
and arm_spe_1). And verified this patch series on Intel-PT test for no
regression.

Changes from v5:
- Changed to comparing string "arm_spe" in patch 08, as "arm_spe"
  is a general even name and passed Arm SPE test.

Changes from v4:
- Used 'evsel->name' to replace 'evsel->pmu_name' in patch 08.

Changes from v3:
- Changed to compare .setup_aux() callback in patch 01 (Peter.Z).
- Picked up patches 02 / 03 with evsel__is_aux_event() refactoring.
- Added new patch 08.

Changes from v2:
- Added patch 01 for support per-thread mode (Adrian).
- Added patch 02 for verifying CPU maps without overlapping (Adrian).
- Reworked patches to fix the regression on Intel-PT (Ian).

Changes from v1:
- Added comment in patch 01 for iterating AUX events (Adrian)
- Added patch 02 for removing unused field 'pmu' (Adrian)


Leo Yan (8):
  perf/core: Allow multiple AUX PMU events with the same module
  perf auxtrace: Use evsel__is_aux_event() for checking AUX event
  perf auxtrace: Remove unused 'pmu' pointer from struct auxtrace_record
  perf auxtrace: Introduce auxtrace_record__validate_events()
  perf auxtrace: Refactor evlist__enable_event_idx()
  perf auxtrace: Bails out after finding the event for the map index
  perf auxtrace: Iterate all AUX events when finish reading
  perf arm-spe: Support multiple events in arm_spe_evsel_is_auxtrace()

 kernel/events/core.c                  |   9 +-
 tools/perf/arch/arm/util/cs-etm.c     |   1 -
 tools/perf/arch/arm64/util/arm-spe.c  |   1 -
 tools/perf/arch/arm64/util/hisi-ptt.c |   1 -
 tools/perf/arch/x86/util/intel-bts.c  |   1 -
 tools/perf/arch/x86/util/intel-pt.c   |   1 -
 tools/perf/builtin-record.c           |   4 +
 tools/perf/util/arm-spe.c             |  11 +--
 tools/perf/util/auxtrace.c            | 114 +++++++++++++++++++++++---
 tools/perf/util/auxtrace.h            |   8 +-
 10 files changed, 125 insertions(+), 26 deletions(-)

-- 
2.34.1

