Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4D5FBB1;
	Tue, 21 May 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298239; cv=none; b=dmu2GfB4rqGGhMlmZ/v4Xd2sQJ5CM6ZBFmxoCZ7pJQxb/p5g3Ch4YDLqSXHUADUxqppw4yCuxfv7uDeVwYlRuLApV1Brfe8CStv9n3c5vSm+7eeehRhoGfEy86JU2Oy62na41mcL7hEX7hY5mSjahVwuV9XED1weKoQXLMxTieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298239; c=relaxed/simple;
	bh=aOBxTb0SIctrnxguRhCJKdv1YkI8dBF3Vz8QHuFmXhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTvIt4liP9LSjQGbk23eJrkzecI6Aon7MF2IZdmuk7ksaV77S8bxEsa7dLJpFkkBc8hcYGmR63fMvj1oSfCUtnEP9sCsrHF79qxwFqAchovxlNlePP8YGwmmokOM3aPnDmEZhLVPijc8mDq49unlNgrDPUDiapayv4ljsdYGn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F575DA7;
	Tue, 21 May 2024 06:31:01 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7108D3F641;
	Tue, 21 May 2024 06:30:35 -0700 (PDT)
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
Subject: [PATCH v6 0/4] perf: Support PERF_SAMPLE_READ with inherit
Date: Tue, 21 May 2024 14:30:25 +0100
Message-ID: <20240521133029.83654-1-ben.gainey@arm.com>
X-Mailer: git-send-email 2.45.1
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
groups. System-wide mode is often problematic as it requires specific
permissions (no CAP_PERFMON / root access), or may lead to capture of
significant amounts of extra data from other processes running on the
system.

This patch changes `perf_event_alloc` relaxing the restriction against
combining `inherit` with `PERF_SAMPLE_READ` so that the combination
will be allowed so long as `PERF_SAMPLE_TID` is enabled. It modifies
sampling so that only the count associated with the active thread is
recorded into the buffer. It modifies the context switch handling so
that perf contexts are always switched out if they have this kind of
event so that the correct per-thread state is maintained. Finally, the
tools are updated to allow perf record to specify this combination and
to correctly decode the sample data.

In this configuration stream ids (such as may appear in the read_format
field of a PERF_RECORD_SAMPLE) are no longer globally unique, rather
the pair of (stream id, tid) uniquely identify each event. Tools that
rely on this, for example to calculate a delta between samples, would
need updating to take this into account. Previously valid event
configurations (system-wide, no-inherit and so on) where each stream id
is the identifier are unaffected.


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
  perf: Support PERF_SAMPLE_READ with inherit
  tools/perf: Track where perf_sample_ids need per-thread periods
  tools/perf: Correctly calculate sample period for inherited
    SAMPLE_READ values
  tools/perf: Allow inherit + PERF_SAMPLE_READ when opening events

 include/linux/perf_event.h                    |  1 +
 kernel/events/core.c                          | 78 ++++++++++++++-----
 tools/lib/perf/evlist.c                       |  1 +
 tools/lib/perf/evsel.c                        | 48 ++++++++++++
 tools/lib/perf/include/internal/evsel.h       | 54 ++++++++++++-
 tools/perf/tests/attr/README                  |  2 +
 .../tests/attr/test-record-group-sampling     | 39 ----------
 .../tests/attr/test-record-group-sampling1    | 50 ++++++++++++
 .../tests/attr/test-record-group-sampling2    | 60 ++++++++++++++
 tools/perf/tests/attr/test-record-group2      |  9 ++-
 tools/perf/util/evsel.c                       | 19 ++++-
 tools/perf/util/evsel.h                       |  1 +
 tools/perf/util/session.c                     | 11 ++-
 13 files changed, 302 insertions(+), 71 deletions(-)
 delete mode 100644 tools/perf/tests/attr/test-record-group-sampling
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling1
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling2

-- 
2.45.1

