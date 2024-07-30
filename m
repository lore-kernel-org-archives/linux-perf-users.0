Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6D13B780;
	Tue, 30 Jul 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329070; cv=none; b=EfZXFVKrIcdwfTWx9q6yD1OsfqjGBuaUNm9GZH4gRj95cd1jbUihQaPvBbVi4ErDBrh+Len1HcpBv5UUu/GMpMZmuTnu+jFbJHLGjWl1y7yqJ31CXRECeg5PgtsLMGDnnejqknF2LvBslkTBu4vQez5g6+i+VJCtpisUR8MeP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329070; c=relaxed/simple;
	bh=H0jLOJZj6byNqopyOz7Fpm9waZ1Cra5Kqi3Sh+xL+iA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VuGIMRUZUFwIuGXoomJCj20r2T5LuqmCKOatihjU4hrW+eBBlqWEiCgqDJNn6GfEDtjHXqrBzWvYXwWqJJ6Oe6AQaWYj3iKy9c5x7DGI5Eyf49+3FU8UFuSLgzn/Rbr0c1HVnXtV2YYWcgQ7B3ZBpb2yoDsKFATW1bv0TYSE9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E538A1007;
	Tue, 30 Jul 2024 01:44:52 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CE543F766;
	Tue, 30 Jul 2024 01:44:25 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v9 0/4] perf: Support PERF_SAMPLE_READ with inherit
Date: Tue, 30 Jul 2024 09:44:13 +0100
Message-ID: <20240730084417.7693-1-ben.gainey@arm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change allows events to use PERF_SAMPLE READ with inherit so long
as PERF_SAMPLE_TID is also set.

Currently it is not possible to use PERF_SAMPLE_READ with inherit. This
restriction assumes the user is interested in collecting aggregate
statistics as per `perf stat`. It prevents a user from collecting
per-thread samples using counter groups from a multi-threaded or
multi-process application, as with `perf record -e '{....}:S'`. Instead
users must use system-wide mode, or forgo the ability to sample counter
groups, or profile a single thread. System-wide mode is often
problematic as it requires specific permissions (no CAP_PERFMON / root
access), or may lead to capture of significant amounts of extra data
from other processes running on the system.

This patch changes `perf_event_alloc` relaxing the restriction against
combining `inherit` with `PERF_SAMPLE_READ` so that the combination
will be allowed so long as `PERF_SAMPLE_TID` is enabled. It modifies
sampling so that only the count associated with the active thread is
recorded into the buffer. It modifies the context switch handling so
that perf contexts are always switched out if they have this kind of
event so that the correct per-thread state is maintained. Finally, the
tools are updated to allow perf record to specify this combination and
to correctly decode the sample data.

In this configuration sample values, as may appear in the read_format
field of a PERF_RECORD_SAMPLE, are no longer global counters. Instead
the value reports the per-thread value for the active thread.
Tools that expect the global total, for example when calculate a delta
between samples, would need updating to take this into account when
opting into this new behaviour. Previously valid event configurations
(system-wide, no-inherit and so on) are unaffected.


Changes since v8:
 - Rebase on v6.11-rc1

Changes since v7:
 - Rebase on v6.10-rc3
 - Respond to Peter Zijlstra's feedback:
 - Renamed nr_pending to nr_no_switch_fast and merged in nr_inherit_read
   which otherwise had overlapping use
 - Updated some of the commit messages to provide better justifications
   of usecase, behavioural changes and so on
 - Cleanup perf_event_count/_cumulative
 - Make it explicit that the sampling event decides whether or not the
   per-thread value is given in read_format for PERF_RECORD_SAMPLE and
   PERF_RECORD_READ; updated tools to account for this.

Changes since v6:
 - Rebase on v6.10-rc2
 - Make additional "perf test" tests succeed / skip based on kernel
   version as per feedback from Namhyung.

Changes since v5:
 - Rebase on v6.9
 - Cleanup feedback from Namhyung Kim

Changes since v4:
 - Rebase on v6.9-rc1
 - Removed the dependency on inherit_stat that was previously assumed
   necessary as per feedback from Namhyung Kim.
 - Fixed an incorrect use of zfree instead of free in the tools leading
   to an abort on tool shutdown.
 - Additional test coverage improvements added to perf test.
 - Cleaned up the remaining bit of irrelevant change missed between v3
   and v4.

Changes since v3:
 - Cleaned up perf test data changes incorrectly included into this
   series from elsewhere.

Changes since v2:
 - Rebase on v6.8
 - Respond to James Clarke's feedback; fixup some typos and move some
   repeated checks into a helper macro.
 - Cleaned up checkpatch lints.
 - Updated perf test; fixed evsel handling so that existing tests pass
   and added new tests to cover the new behaviour.

Changes since v1:
 - Rebase on v6.8-rc1
 - Fixed value written into sample after child exists.
 - Modified handling of switch-out so that context with these events
   take the slow path, so that the per-event/per-thread PMU state is
   correctly switched.
 - Modified perf tools to support this mode of operation.

Ben Gainey (4):
  perf: Rename perf_event_context.nr_pending to nr_no_switch_fast.
  perf: Support PERF_SAMPLE_READ with inherit
  tools/perf: Correctly calculate sample period for inherited
    SAMPLE_READ values
  tools/perf: Allow inherit + PERF_SAMPLE_READ when opening events

 include/linux/perf_event.h                    |  8 ++-
 kernel/events/core.c                          | 67 +++++++++++++------
 tools/lib/perf/evsel.c                        | 48 +++++++++++++
 tools/lib/perf/include/internal/evsel.h       | 63 ++++++++++++++++-
 tools/perf/tests/attr/README                  |  2 +
 .../tests/attr/test-record-group-sampling     |  3 +-
 .../tests/attr/test-record-group-sampling1    | 51 ++++++++++++++
 .../tests/attr/test-record-group-sampling2    | 61 +++++++++++++++++
 tools/perf/tests/attr/test-record-group2      |  1 +
 ...{test-record-group2 => test-record-group3} | 10 +--
 tools/perf/util/evsel.c                       | 19 +++++-
 tools/perf/util/evsel.h                       |  1 +
 tools/perf/util/session.c                     | 25 ++++---
 13 files changed, 320 insertions(+), 39 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling1
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling2
 copy tools/perf/tests/attr/{test-record-group2 => test-record-group3} (81%)

-- 
2.45.2

