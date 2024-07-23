Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65047A64;
	Tue, 23 Jul 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775879; cv=none; b=nrpiP6ADZK5CqULI9ypbNcrL4wy+7HLHgsY55zmVffRMq9nbac/CHUyxibuoB1699GCAagMSufmxjj6pOz/78KsES8xytBlKbpMNwxLQwhhYC9q8UVq9BvqN3ufyq2LJL3p0xPDClFedKnRmmjWMq2VPp1NeCBSPe2EgRKaPXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775879; c=relaxed/simple;
	bh=V+HFxS6OxHeWHEqmERNoZYH4TokFIx1UF14I2CUeOqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tju5YHjiNy3D44ORmq9U8t3Ci86awYilOUhcpkHDIydKXi9gime3RKLym7RewXRIa+py6mBhm7Wepa/8QIZVjWvAIOfBxU6PrZrobRrWKMXOeG263Ik/IOCJxk2oqNcgHeqFjp0LyBqwLmW/KQNtCl4M/iBQZIjnfUE68IW39G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXzRlegH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXzRlegH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E16DC4AF0A;
	Tue, 23 Jul 2024 23:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721775879;
	bh=V+HFxS6OxHeWHEqmERNoZYH4TokFIx1UF14I2CUeOqg=;
	h=From:To:Cc:Subject:Date:From;
	b=EXzRlegHsrgxvPfI/CF//8u9Idqoy9RIGvo/3O1gOr1sjSt8bUlho60A0/zEINIyE
	 PGDKAN18Ff3Hy6q4Lk5aGDAD2wyZX0SisfTFfIoPAdRhYkXLLbD/rDXxFGOJoRg7hl
	 HVy1PtBYrVQ09tOPgbA3rCX3EHZL5HGseV9i8zFj6FvPUQwdxje1UH6qMHpLF1DHVs
	 fVIPiRpwMg5XyW7CpjbJFQBokLmnYui07JN5Z1YqYZxvUgwYWNqR2GPK3HrnGkThG9
	 9DaXyfRDFyelHMqvYO2X76K05t7fy+KOTP3aHWZDOB9AB4k2DHC56TYA2b6qKpTq0Y
	 laguwrCLvLwxA==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.11-rc1
Date: Tue, 23 Jul 2024 16:04:36 -0700
Message-ID: <20240723230436.1050616-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.11.

Thanks,
Namhyung


The following changes since commit 7a2fb5619cc1fb53cb8784154d5ef2bd99997436:

  perf trace: Fix iteration of syscall ids in syscalltbl->entries (2024-07-12 09:49:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.11-2024-07-23

for you to fetch changes up to 92717bc077892d1ce60fee07aee3a33f33909b85:

  perf dso: Fix build when libunwind is enabled (2024-07-17 13:17:57 -0700)

----------------------------------------------------------------
perf tools fixes for v6.11

Two fixes about building perf and other tools:

* Fix breakage in tracing tools due to pkg-config for libtrace{event,fs}

* Fix build of perf when libunwind is used

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Guilherme Amadio (5):
      perf build: Warn if libtracefs is not found
      tools: Make pkg-config dependency checks usable by other tools
      tools/verification: Use pkg-config in lib_setup of Makefile.config
      tools/rtla: Use pkg-config in lib_setup of Makefile.config
      tools/latency: Use pkg-config in lib_setup of Makefile.config

James Clark (1):
      perf dso: Fix build when libunwind is enabled

 tools/build/Makefile.feature             | 18 ++++++++++++++++++
 tools/perf/Makefile.config               | 13 +++++--------
 tools/perf/util/dso.c                    |  2 +-
 tools/perf/util/dso.h                    |  5 +++++
 tools/perf/util/unwind-libunwind-local.c |  2 +-
 tools/tracing/latency/Makefile.config    |  3 ++-
 tools/tracing/rtla/Makefile.config       |  3 ++-
 tools/verification/rv/Makefile.config    |  3 ++-
 8 files changed, 36 insertions(+), 13 deletions(-)
