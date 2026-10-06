Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F83426694;
	Tue,  6 Oct 2026 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303207; cv=none; b=kHxmeahxzSvZp6YVEvUgu1R0DLSm37LSIoe3oTT1Dc92+crzd4AOqCtCSS2i0Q9uQGJCNSq2mqvmY3DTebQLdJ2T9tXvzUFXnhpFrAj5ZWtwCCMSGpFM0eSRvWX8QRZ1nXp+lB6KSr5faFhCoxQfEqR914YUvi/0aCNi5dA/BFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303207; c=relaxed/simple;
	bh=L6YrQFjxrZay3z4YRJ5AlXCS+dt2cqkiJklb5wFDOsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1HXzHP8a2rVJfczHeyFrBNshJ29pjFEk4qURqgSHaNsQSQFGkO5/w/7kPknN8ta7BNhYUwzoWbysLKXIwHvZDrNT6l3N83VhwyPRo+dUh2D9GEi090nILyH7iFd5Suhq5KJzlZWHYocFkgJlQIyj3AXgafWbz0diQ3NZk56wuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAKXiZ91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAKXiZ91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACC31F0089B;
	Tue,  6 Oct 2026 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303206;
	bh=h9U13ZBroojWUwc9Vy2P+q7LzVA/xvvQDE6Ftok6ux0=;
	h=From:To:Cc:Subject:Date;
	b=eAKXiZ91puH7bkoHp7yBpYFP9IpvIjtdaY2xAQOaSy5TkZNuQQALkPNXzH+h/ZL52
	 Q4uoxR9NA4fKZGFzqgJ0RlyHJc+86ROkLT0Lu6lU/v3RoZ4V81oU6ngTsz9cQS9irw
	 KtmX/x3FeIfgtGBUggg68ETJ0ifyDNPJjEWj7cbJL9JfyTDcHu7ymV1ccS2Kfm1nAk
	 xsWHVuvdh8fHemjLL6sR+PNGMVORa3mP/oP6/Zqijo/ONBY4H7sj5cCMBXziyquIZq
	 3VFzCxZOSuq0IDKhhgbaBLWjvXRXuzWj+0R0L7BMPbfRQTNvupWATDlaoPmOBCo1CU
	 an5TVXyMcqs0A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 0/6 v1] perf test attr: Fix the re-enabled test
Date: Tue,  6 Oct 2026 18:13:03 +0200
Message-ID: <20261006161309.3078488-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hello all,

This series fixes the "Perf attribute expectations test" (perf test 82,
formerly "Setup struct perf_event_attr").

Patches 1-2 are Michael Petlan's prerequisite fixes that make the shell
wrapper propagate attr.py's return value and correct the
perf_event_attr size expectation after struct config4 was added.  They
are included at the start of the series so that it applies cleanly on
the current perf-tools-next (and for the review bots to verify the new
patches); the new fixes are patches 3-6.

With the test reporting failures again, several stale expectations
surfaced and are addressed here:

- test-record-graph-dwarf still expected PERF_SAMPLE_ADDR and
  PERF_SAMPLE_DATA_SRC for --call-graph dwarf.  Those were dropped by
  bdd051e249141c79 ("perf record: Split --data-mmap option"), which
  decoupled data MMAP recording from the sample address bits.

- The record and stat group tests expected cache-misses and
  instructions to be the legacy PERF_TYPE_HARDWARE events, but since
  b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy
  hardware and cache parsing") they resolve to the core PMU sysfs/JSON
  events, so request the legacy encodings explicitly with the
  legacy-hardware-config term.

- The perf stat default metrics open their events in groups and the
  raw encodings of instructions, branch-misses, cpu-cycles and
  stalled-cycles-frontend/backend differ between Intel and AMD, so
  base-stat now accepts the standalone and group variants and
  test-stat-default/detailed-{1,2,3} gained the per-vendor raw
  encodings.

- attr.py no longer requires a recorded event to be in a group when
  the matching expectation does not declare one, allowing the stat
  tests to verify event attributes without encoding the metric
  grouping.  Expectations that declare a group are still verified in
  both directions.

The test passes with 'perf test -vv attribute' on x86_64.  The AMD
encodings come from the amd_pmu_event_map tables in
arch/x86/events/amd/core.c.

Arnaldo

Arnaldo Carvalho de Melo (4):
  perf test attr: Fix record dwarf sample_type expectation
  perf test attr: Fix legacy event encodings in group tests
  perf test attr: Fix default stat metrics expectations
  perf test attr: Relax group checking for ungrouped expectations

Michael Petlan (2):
  perf test attr: Propagate the return value from the test to the
    wrapper
  perf test attr: Fix wrong size expectation for events

 tools/perf/tests/shell/attr.sh                |  1 +
 tools/perf/tests/shell/attr/README            | 10 +++---
 tools/perf/tests/shell/attr/base-record       |  2 +-
 tools/perf/tests/shell/attr/base-stat         |  8 ++---
 tools/perf/tests/shell/attr/system-wide-dummy |  2 +-
 .../tests/shell/attr/test-record-dummy-C0     |  2 +-
 .../tests/shell/attr/test-record-graph-dwarf  |  2 +-
 .../shell/attr/test-record-group-sampling     |  4 +--
 .../shell/attr/test-record-group-sampling1    |  4 +--
 .../shell/attr/test-record-group-sampling2    |  4 +--
 .../perf/tests/shell/attr/test-record-group1  |  2 +-
 .../perf/tests/shell/attr/test-record-group2  |  2 +-
 .../perf/tests/shell/attr/test-record-group3  |  2 +-
 tools/perf/tests/shell/attr/test-stat-default | 32 +++++++++++++++++--
 .../tests/shell/attr/test-stat-detailed-1     | 32 +++++++++++++++++--
 .../tests/shell/attr/test-stat-detailed-2     | 32 +++++++++++++++++--
 .../tests/shell/attr/test-stat-detailed-3     | 32 +++++++++++++++++--
 tools/perf/tests/shell/attr/test-stat-group1  |  2 +-
 tools/perf/tests/shell/lib/attr.py            | 11 +++++--
 19 files changed, 152 insertions(+), 34 deletions(-)

-- 
2.55.0

