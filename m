Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D518C33A;
	Wed, 16 Oct 2024 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059841; cv=none; b=EDd8e9ip3CyWOXREmOWTFg5BVmMTRZXsue3pvZqGocQ08dYaZDFTRypkw9e+s6q2J1hgVNLSiT6OkYlNdB/rjivDRGkkuHsypltMN8rOszGRHLWFBzeuvzuUZdjLG9cRFOjijHTrGnap8mpK5CML2d5dOIu9LizkdPldNhH8YMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059841; c=relaxed/simple;
	bh=gD16iliRK0RMD/7spF6I5ukbi4EGzg6Y5kbt9o+bnbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHmWXC7epRZyZi7oYxJ5Sm5glAaZmE/x6Wmraopz5NRRz82UVl7nXuT7ES00n6xXblMiAiYMu+XpsOtPdSCzdRsI8EKxdvUwWjLv7aOyRvt8CSdTdkAbGE/YHEB1P9OBjLZEHXaLQ9zfE7o/cPYMsR1Hf2hN84q8EMNLkXJohBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toURjvBn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toURjvBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F93EC4CEC5;
	Wed, 16 Oct 2024 06:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059840;
	bh=gD16iliRK0RMD/7spF6I5ukbi4EGzg6Y5kbt9o+bnbU=;
	h=From:To:Cc:Subject:Date:From;
	b=toURjvBnG4GwRkezkqVCu7opcB+Avu+60Pr6aHLMYIg+MWEGvNuLUKq9uKGWHSj+2
	 omCi4w6yTWiwkoHyImBI3Sg6WjDq4lkPML2UE54OIr5WpStV4JVwHaHnAf1DdQdgMH
	 86Ah5VnDZzEer2R7zooW8XJP0xwoQLWkD23p/VFx+fKNewKJA32b+gJzrnstjSolMf
	 KWRgczYpE082gksdinSbiV1mU0Up3lmwEueqnlryl9MPsvmK3ZHq6btSgSSLvnl/gj
	 0e2zWoirkz6wGWo11nn5XuzfiKB3Lu21yw0loJLfCuygu/Z7+5T827LjZNjbiNOemH
	 OlFQFPzx0b30A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCHSET 0/9] perf tools: Do not set attr.exclude_guest by default (v5)
Date: Tue, 15 Oct 2024 23:23:50 -0700
Message-ID: <20241016062359.264929-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I found perf tools set exclude_guest bit inconsistently.  It used to
set the bit but now the default event for perf record doesn't.  So I'm
wondering why we want the bit in the first place.

Actually it's not good for PMUs don't support any exclusion like AMD
IBS because it disables new features after the exclude_guest due to
the missing feature detection logic.

v5 changes)

 * fix instruction:P failure on AMD  (Ravi)
 * add per-pmu exclude_guest test again  (Ravi)
 * add precise_max subtest to perf record shell test

v4) https://lore.kernel.org/lkml/20241001002027.1272889-1-namhyung@kernel.org

 * handle EOPNOTSUPP error in compatible way  (Kan)
 * drop --exclude-guest option in perf stat
 * not to separate exclude_hv fallback
 * rename to exclude_GH_default  (Kan)
 * drop the RFC from the subject

v3) https://lore.kernel.org/lkml/20240905202426.2690105-1-namhyung@kernel.org/

 * move exclude_guest fallback to the front
 * fix precise_max handling on AMD
 * simplify the default event for perf record

v2) https://lore.kernel.org/lkml/20240904064131.2377873-1-namhyung@kernel.org/

 * update the missing feature detection logic
 * separate exclude_hv fallback
 * add new fallback for exclude_guest

v1) https://lore.kernel.org/lkml/20240902014621.2002343-1-namhyung@kernel.org/

AFAIK it doesn't matter for the most cases but perf kvm.  If users
need to set the bit, they can still use :H modifier.  For vPMU pass-
through or Apple M1, it'd add the exclude_guest during the fallback
logic.

Also the kernel feature detection logic should be separated from the
exclude bit tests since it depends on the PMU implementation rather
than the core kernel features.  So I changed it to use a software
event for the detection and factor out some hw-specific checks.

The code is available at 'perf/exclude-v5' branch in
git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (9):
  perf tools: Add fallback for exclude_guest
  perf tools: Don't set attr.exclude_guest by default
  perf tools: Simplify evsel__add_modifier()
  perf tools: Do not set exclude_guest for precise_ip
  perf tools: Detect missing kernel features properly
  perf tools: Move x86__is_amd_cpu() to util/env.c
  perf tools: Check fallback error and order
  perf record: Just use "cycles:P" as the default event
  perf test: Add precise_max subtest to the perf record shell test

 tools/perf/arch/x86/util/Build              |   1 -
 tools/perf/arch/x86/util/env.c              |  19 -
 tools/perf/arch/x86/util/env.h              |   7 -
 tools/perf/arch/x86/util/pmu.c              |   2 +-
 tools/perf/builtin-kvm.c                    |   1 +
 tools/perf/builtin-record.c                 |   4 +-
 tools/perf/builtin-stat.c                   |  18 +-
 tools/perf/dlfilters/dlfilter-test-api-v0.c |   2 +-
 tools/perf/dlfilters/dlfilter-test-api-v2.c |   2 +-
 tools/perf/tests/attr/test-record-dummy-C0  |   2 +-
 tools/perf/tests/parse-events.c             |  30 +-
 tools/perf/tests/shell/record.sh            |  25 ++
 tools/perf/tests/shell/stat.sh              |   2 +-
 tools/perf/util/env.c                       |  23 +
 tools/perf/util/env.h                       |   4 +
 tools/perf/util/evsel.c                     | 457 +++++++++++++++-----
 tools/perf/util/evsel.h                     |   1 -
 tools/perf/util/parse-events.c              |   6 +-
 tools/perf/util/pmu.h                       |   4 +
 tools/perf/util/util.c                      |  10 +-
 tools/perf/util/util.h                      |   3 +
 21 files changed, 452 insertions(+), 171 deletions(-)
 delete mode 100644 tools/perf/arch/x86/util/env.c
 delete mode 100644 tools/perf/arch/x86/util/env.h


base-commit: ea2ead4224fd3899f6dadd4c1fc526f32ec2246c
-- 
2.47.0.rc1.288.g06298d1525-goog

