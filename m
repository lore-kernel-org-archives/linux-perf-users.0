Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C1D515;
	Thu,  5 Sep 2024 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567868; cv=none; b=a5xm/NU3oVPQ4cNw7cCsKLxl/kxWn4ULAiSSKAy907Ahu/5MkQDqgNpoYRS1PmLAUQexSkjhfRw3WMEwQGso69gMqx+9azqzEf3cLG3V5ME48lKOFvbFDK3MV2KAq6qS4lNtqVg5aR8cvC9I8NX6y0hMWAYZQgEqqVIvrKnyeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567868; c=relaxed/simple;
	bh=1Ltl36sTyGtp/owX7mjKedpcbROgalM5MZaHiuzbPRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mM/A0lGM2VSfA6Gd4B8NGZcjTpd7uruCSsKAg/havda//9z80t74s9BJLs0LtRQ/7rLdFipejerUHKatDguF1AcdIJS0UDckcvmH2AIjKxo4+81TxAV4hyuyOzBj1VasaE7meRSK5x4WL33VNThSQRUAz7O8sMTZ09KzlaoyPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppM/w/2H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppM/w/2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763FAC4CEC3;
	Thu,  5 Sep 2024 20:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567868;
	bh=1Ltl36sTyGtp/owX7mjKedpcbROgalM5MZaHiuzbPRg=;
	h=From:To:Cc:Subject:Date:From;
	b=ppM/w/2H+qEsDO1zUm9vSqhZxdJpzEI0mrOTwvAaHp9l1DMuAa6I7CoillfpqdhdY
	 MmOmo8dKCM48xg+34Qj2jqSx5R7Dz+mHmlZVIqtfK1Yve8MHlnla31xe3rNvb0w3N1
	 vSEXcdOG5sdLvmfO3Dp4wx/Y5PUCO0vQC6WG0mfReNDjzVF9xPRQP6j3VBVs5vth0+
	 gNUf4Fe1gpQdOOnC8JMVAJHYgcwxIsu4xfpfZJBwftsQ4owBdxlA441aUTRazr0000
	 ECQ0YRDBXUWQ7WcPVreTMwLzLDnkNNf1YZuYwj4NPc8TiIRuXUCQrnmHFgslSR/1/N
	 vwIFWqfctptpQ==
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
Subject: [RFC/PATCHSET 00/10] perf tools: Do not set attr.exclude_guest by default (v3)
Date: Thu,  5 Sep 2024 13:24:16 -0700
Message-ID: <20240905202426.2690105-1-namhyung@kernel.org>
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

v3 changes)

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

The code is available at 'perf/exclude-v3' branch in
git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (10):
  perf tools: Add fallback for exclude_guest
  perf tools: Don't set attr.exclude_guest by default
  perf tools: Simplify evsel__add_modifier()
  perf stat: Add --exclude-guest option
  perf tools: Do not set exclude_guest for precise_ip
  perf tools: Detect missing kernel features properly
  perf tools: Separate exclude_hv fallback
  perf tools: Move x86__is_amd_cpu() to util/env.c
  perf tools: Check fallback error and order
  perf record: Just use "cycles:P" as the default event

 tools/perf/Documentation/perf-stat.txt      |   7 +
 tools/perf/arch/x86/util/Build              |   1 -
 tools/perf/arch/x86/util/env.c              |  19 -
 tools/perf/arch/x86/util/env.h              |   7 -
 tools/perf/arch/x86/util/pmu.c              |   2 +-
 tools/perf/builtin-kvm.c                    |   1 +
 tools/perf/builtin-record.c                 |   4 +-
 tools/perf/builtin-stat.c                   |   5 +-
 tools/perf/dlfilters/dlfilter-test-api-v0.c |   2 +-
 tools/perf/dlfilters/dlfilter-test-api-v2.c |   2 +-
 tools/perf/tests/attr/test-record-dummy-C0  |   2 +-
 tools/perf/tests/parse-events.c             |  30 +-
 tools/perf/util/env.c                       |  23 ++
 tools/perf/util/env.h                       |   4 +
 tools/perf/util/evsel.c                     | 410 +++++++++++++++-----
 tools/perf/util/evsel.h                     |   1 -
 tools/perf/util/parse-events.c              |   6 +-
 tools/perf/util/util.c                      |  10 +-
 tools/perf/util/util.h                      |   3 +
 19 files changed, 371 insertions(+), 168 deletions(-)
 delete mode 100644 tools/perf/arch/x86/util/env.c
 delete mode 100644 tools/perf/arch/x86/util/env.h

-- 
2.46.0.469.g59c65b2a67-goog

