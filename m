Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2901A18D62B;
	Tue,  6 Aug 2024 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977309; cv=none; b=NreubjOHBCFwpx5MrNTB8dgiAeCK+OTdzYvkH0w25PZy31mqJBHbOq3ECQ/skKlMWUJ/fGgO6hguVHR9pwTQX9DKlo3D0ttz7JfqPGhi1xi/7uyx8eXnJeJdRWf7vn3qIBmkDBpYZAsef5/1mrZSsWDCK8GpOG6IB8PZDzUjHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977309; c=relaxed/simple;
	bh=a6DsiXojv1z/Ig3NHwypyVb6gTS4FFtygsdzyq9CcY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sADHy18MAMMHMpltuR9YU+zc50j8W6tmlLMSu8GyNYIcm5tfEPh7GscY/WBZ2yvgG6rjNnS0OXDalNzgLGbrGf4Jnu/Q6pPan2g6R94Ysuiq5MQiTj9CSJt0ipvVegeVXFQPMkoE78aCi2+O9zb31JPgYIj7kvlHV6c6Q+IxRSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CAA1FEC;
	Tue,  6 Aug 2024 13:48:53 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D9783F766;
	Tue,  6 Aug 2024 13:48:25 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 0/5] perf auxtrace: Support multiple AUX events
Date: Tue,  6 Aug 2024 21:48:08 +0100
Message-Id: <20240806204813.722372-1-leo.yan@arm.com>
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

This patch series is dependent on auxtrace refactoring patch series:
https://lore.kernel.org/lkml/20240806204130.720977-1-leo.yan@arm.com/T/#mae62825a677381797a13252c1d071caf18d957d7

Note, a more complex case - different types of AUX events, (e.g. Arm
CoreSight event and Arm SPE events are enabled simultaneously) - is
still not supported.

Patch 01 is to change the perf core layer in the kernel to allow
multiple AUX events to output to single FD, so that '--per-thread' mode
can be supported.

Patch 02 validates the AUX events' CPU map. It presumes the AUX events
do not overlap for CPU maps, otherwise, it returns failure.

Patches 03, 04, 05 is to support multiple AUX events for buffer mapped
index.

As the first enabled instance, the patch series has been tested with
multiple Arm SPE events (e.g. arm_spe_0, arm_spe_1, etc). And verified
this patch series on Intel-PT for no regression.


Changes from v2:
- Added patch 01 for support per-thread mode (Adrian).
- Added patch 02 for verifying CPU maps without overlapping (Adrian).
- Reworked patches to fix the regression on Intel-PT (Ian).

Changes from v1:
- Added comment in patch 01 for iterating AUX events (Adrian)
- Added patch 02 for removing unused field 'pmu' (Adrian)


Leo Yan (5):
  perf/core: Allow multiple AUX PMU events with the same module
  perf auxtrace: Introduce auxtrace_record__validate_events()
  perf auxtrace: Refactor evlist__enable_event_idx()
  perf auxtrace: Bails out after finding the event for the map index
  perf auxtrace: Iterate all AUX events when finish reading

 kernel/events/core.c        |   3 +-
 tools/perf/builtin-record.c |   4 ++
 tools/perf/util/auxtrace.c  | 110 ++++++++++++++++++++++++++++++++----
 tools/perf/util/auxtrace.h  |   7 +++
 4 files changed, 113 insertions(+), 11 deletions(-)

-- 
2.34.1

