Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9890189BBF;
	Thu,  1 Aug 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515443; cv=none; b=HY6oPvxiFHu9REtZdE39a7ZjGJrQkZCfpxpC02aZ5+H3dXGQEnFoWcsC7fIxHGP4UEejdGqtVD2+KHCf8ryEiFzHVA90aGgPp/q8msoS/jE/UdPsS/QXqq7O2lW56DuvlYpxJz5JxlzBWQtM+016reX4DZAL41VZ6GTGuRNupSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515443; c=relaxed/simple;
	bh=KgkbOwFBKw3erB9TVYZLeWgMN272jNom2Oo4VVlnbTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTXHX3d5jnwTwR0TB5uqHdQWjSW4kbpWMRdKXscBETcWjfaWxnkR+0vZ3iaFWsAf9fgEonpitZiv/qPDqs3x+fbExs3uW2weW/7nzUBDO9l1B6GY6aCcug92K/sf5+QAyJPzSZVIeYrh0p2XE8jDzNVVvKpsYAIX3UR2EbVXnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DC0A15A1;
	Thu,  1 Aug 2024 05:31:06 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E06883F766;
	Thu,  1 Aug 2024 05:30:38 -0700 (PDT)
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
Subject: [PATCH v10 0/2] tools/perf: Support PERF_SAMPLE_READ with inherit
Date: Thu,  1 Aug 2024 13:30:28 +0100
Message-ID: <20240801123030.3075928-1-ben.gainey@arm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision of this change splits out the tools/perf changes requested 
by Namhung King for my previous work to enable PERF_SAMPLE READ with inherit (see 
https://lore.kernel.org/linux-perf-users/20240730084417.7693-1-ben.gainey@arm.com/ ) 
as the kernel side changes have been picked up by Peter Zijlstra.

Changes since v9:
 - Split out tools/perf patches only
 - Fixed system-wide mode in `perf record` to not set the inherit bit.

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

Ben Gainey (2):
  tools/perf: Correctly calculate sample period for inherited
    SAMPLE_READ values
  tools/perf: Allow inherit + PERF_SAMPLE_READ when opening events

 tools/lib/perf/evsel.c                        | 48 ++++++++++++++
 tools/lib/perf/include/internal/evsel.h       | 63 ++++++++++++++++++-
 tools/perf/tests/attr/README                  |  2 +
 tools/perf/tests/attr/test-record-C0          |  2 +
 tools/perf/tests/attr/test-record-dummy-C0    |  2 +-
 .../tests/attr/test-record-group-sampling     |  3 +-
 .../tests/attr/test-record-group-sampling1    | 51 +++++++++++++++
 .../tests/attr/test-record-group-sampling2    | 61 ++++++++++++++++++
 tools/perf/tests/attr/test-record-group2      |  1 +
 ...{test-record-group2 => test-record-group3} | 10 +--
 tools/perf/util/evsel.c                       | 21 ++++++-
 tools/perf/util/evsel.h                       |  1 +
 tools/perf/util/session.c                     | 25 +++++---
 13 files changed, 271 insertions(+), 19 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling1
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling2
 copy tools/perf/tests/attr/{test-record-group2 => test-record-group3} (81%)

-- 
2.45.2

