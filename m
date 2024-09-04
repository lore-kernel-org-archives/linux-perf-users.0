Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0E13A25F;
	Wed,  4 Sep 2024 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432093; cv=none; b=ki7Sh/jhEY3vZ04ltmU5JrJjJqo3NX0b+6GyrG1ax6RZ6xbEop31Yewh0hI81SqwXtVz6SBMi0jge8C4hc4nteuxppr95qy078NY6XL2N6ASV/e8riil2BQru7Erya425tU1PJbaq6ESk1VeNcSDhmxIkOkKONj4YD2iVwnqBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432093; c=relaxed/simple;
	bh=hzXWzi1y0DuOGU4NJLtdQrc8GWfSE/4EwLwJIKZsKBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krKHaYDh0MF7p2gXXtTymKjeSg/zkvV5Zef/W9Wk47DQ298eXwoqKkl3EZB/Mg/Ak9z7d4QNFj3Bf1lc7IrxuBaDHBuDiCHc9OM8EWN/qGDjp05zUy2Y/l+EszI+JVAbq0H4740G94cYOptrlg7bzexrwpG8rw5+GFM/AeblIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCvY/X+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCvY/X+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7747CC4CEC2;
	Wed,  4 Sep 2024 06:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725432093;
	bh=hzXWzi1y0DuOGU4NJLtdQrc8GWfSE/4EwLwJIKZsKBI=;
	h=From:To:Cc:Subject:Date:From;
	b=tCvY/X+UYUoYTohDTPTsx2gbI2U+xbLsB2ockvLJjiC5aX9I6vAsroRaUytUfJmYN
	 D4Mnn/GKkoo+41qqQ08Uy2zpdn4wq5yW5KWzohZbOxDC/LFjf2UBpkjWc07I/Ojhzy
	 cK+kMyWParGT2zdiRSbJABi2Jhro5ntYL24YSo5Hhm3WCTQ69b9zq8nzOW5HFEEHsV
	 7ILp2LGoHy46G2JIAU7PM1AwK/yeOcdzhvJOCj2EDvWS7z0NAXVnTY3L6WwVvsFqnw
	 gfaMSNjAzEg7Kv6Qp8IN4VqfSsLUth86E2xR+XcHWaYw3wGPna4dl00+LvHncUJeru
	 c/SVToBM1qP5Q==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [RFC/PATCHSET 0/8] perf tools: Do not set attr.exclude_guest by default (v2)
Date: Tue,  3 Sep 2024 23:41:23 -0700
Message-ID: <20240904064131.2377873-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
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

v2 changes)
 * update the missing feature detection logic
 * separate exclude_hv fallback
 * add new fallback for exclude_guest

v1) https://lore.kernel.org/lkml/20240902014621.2002343-1-namhyung@kernel.org/

AFAIK it doesn't matter for the most cases but perf kvm.  If users
need to set the bit, they can still use :H modifier.  For vPMU pass-
through or Apple M1, it'd add the exclude_guest during the fallback
logic.  Please let me know if it's ok for you.

The code is available at 'perf/exclude-v2' branch in
git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (8):
  perf tools: Don't set attr.exclude_guest by default
  perf tools: Simplify evsel__add_modifier()
  perf stat: Add --exclude-guest option
  perf tools: Do not set exclude_guest for precise_ip
  perf tools: Detect missing kernel features properly
  perf tools: Separate exclude_hv fallback
  perf tools: Add fallback for exclude_guest
  perf tools: Check fallback error and order

 tools/perf/Documentation/perf-stat.txt      |   7 +
 tools/perf/builtin-kvm.c                    |   1 +
 tools/perf/builtin-stat.c                   |   2 +
 tools/perf/dlfilters/dlfilter-test-api-v0.c |   2 +-
 tools/perf/dlfilters/dlfilter-test-api-v2.c |   2 +-
 tools/perf/tests/attr/test-record-dummy-C0  |   2 +-
 tools/perf/tests/parse-events.c             |  30 +-
 tools/perf/util/evsel.c                     | 393 ++++++++++++++------
 tools/perf/util/evsel.h                     |   1 -
 tools/perf/util/parse-events.c              |   6 +-
 tools/perf/util/util.c                      |  10 +-
 tools/perf/util/util.h                      |   3 +
 12 files changed, 322 insertions(+), 137 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog

