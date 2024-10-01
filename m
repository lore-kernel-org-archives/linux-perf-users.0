Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9CEBA2E;
	Tue,  1 Oct 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742029; cv=none; b=M4AEdeLIzFPjSPAiC8p5gYnFfEaBGQH4gp6OAcrGfGEs6IdJbyld8rM/rcAge6u/3touTIIHQU0QX1GmE8LQQY0wjGVy4Lk+S0kXiW8Oj1UOJT7G1E0o6R4L0tWaCgUbv02PjCfzixzyTLVFAw50uISEzViED/2FS1136dPpNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742029; c=relaxed/simple;
	bh=sn+sJmUR9kNVPMvS6f/VhxpSWF2d9kStnRUNJ0cts8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLOb/26ay8zGbb3zpyxTLLXToQAABRqVwu9x5pPsWMRGc6yjy6cMX58Fsj6N5X9gfSg21SAz32ose6pAeWM9AKGFVJGGc9qrIaSeOaHxjv0rom9pmHMRheaWVo93Tkn8gLKRaND8jLfPwLNHd329krctPl1mPMdMQI/dOw8Bk9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV9tVRFZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV9tVRFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EDBC4CEC7;
	Tue,  1 Oct 2024 00:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727742029;
	bh=sn+sJmUR9kNVPMvS6f/VhxpSWF2d9kStnRUNJ0cts8k=;
	h=From:To:Cc:Subject:Date:From;
	b=bV9tVRFZh5ZFdVk50Qs6g56yLY9nbp1IOmyO81xLioKMWN+j203YrDshvKkFF9Btg
	 STROPrt1gFYQqcnzp5QkJsezq48Twlj7IqB67I5UTxp1A4NkTllRmsUH9qIz56/J50
	 4idUomRGwzmWAFX6VInd5k84wXwUyvm5xt6TcKKsfLjtud7u7ZCxp6a994DlzhIPTC
	 8lCEpEEGUMFJOcGg4v5B3g6y54qstQS6QLqWiJhiyZnV5auir4pG8LD91oKc0RTbOL
	 5PKCsKGTny1EMP1LmhnEZ7xg6hw1blaaORPCJD5FfRM9xa8eXo+4aI88+jHdkunoLE
	 hi7MQv3batJ+g==
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
Subject: [PATCHSET 0/8] perf tools: Do not set attr.exclude_guest by default (v4)
Date: Mon, 30 Sep 2024 17:20:19 -0700
Message-ID: <20241001002027.1272889-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
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

v4 changes)

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

The code is available at 'perf/exclude-v4' branch in
git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (8):
  perf tools: Add fallback for exclude_guest
  perf tools: Don't set attr.exclude_guest by default
  perf tools: Simplify evsel__add_modifier()
  perf tools: Do not set exclude_guest for precise_ip
  perf tools: Detect missing kernel features properly
  perf tools: Move x86__is_amd_cpu() to util/env.c
  perf tools: Check fallback error and order
  perf record: Just use "cycles:P" as the default event

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
 tools/perf/util/env.c                       |  24 ++
 tools/perf/util/env.h                       |   4 +
 tools/perf/util/evsel.c                     | 394 ++++++++++++++------
 tools/perf/util/evsel.h                     |   1 -
 tools/perf/util/parse-events.c              |   6 +-
 tools/perf/util/util.c                      |  10 +-
 tools/perf/util/util.h                      |   3 +
 18 files changed, 364 insertions(+), 166 deletions(-)
 delete mode 100644 tools/perf/arch/x86/util/env.c
 delete mode 100644 tools/perf/arch/x86/util/env.h

-- 
2.46.1.824.gd892dcdcdd-goog

