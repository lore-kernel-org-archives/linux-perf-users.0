Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D0315D25;
	Fri,  5 Sep 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103618; cv=none; b=GJTCgAiIUdo455jTTJAUqwOOSe9EopfzzyqU0pfsO9+MXs7iNBkDwQBhzbn09e/5BNKQOMX3gIbZiLv6w8UTTykyV6tqnPydla4HKzQcNIpqLn4d3z7Qv1tfFg2jn4afFR2QKyltl4P30/+9CT9K7fI59pObDdsqgmbbeat5ZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103618; c=relaxed/simple;
	bh=9pHesOHkR5mAh2Wyj6pq8fayBw5SKI5QpASkLp7zRLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvhM7vgj8WY0N1NZAXZB3ny9VkwLD38UTj8JraLotCWzSfTyH6hYv1Fz6g8ARWov0ioJ6z3pdoXyI9TB9IcYR7uOnpsQNJN33kZpiGuiBIbIWwnSIgtD9cnJAVaZC2mNEOUEj+E43vhr1yvi/KE3xq3J+MopNbIGYSBLwaHiVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk1d0UGk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk1d0UGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17923C4CEF1;
	Fri,  5 Sep 2025 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757103616;
	bh=9pHesOHkR5mAh2Wyj6pq8fayBw5SKI5QpASkLp7zRLg=;
	h=From:To:Cc:Subject:Date:From;
	b=Mk1d0UGkmKjB3Oi20UhqkeabvmKtwD8PpWSWpfV0YjZ6EqsrefvCe887rejvG9Jdo
	 IyRX/BdsoquwWGEjtmz8kfaroBAMrKSLY+On/qu0b1dS6bfuTT946PTig5UUrEnyx4
	 DN06R3j9J5zEfyIVL7+Ggh9Z9HzESmirn7Sc69L2NhX1WOz2p9hOicg+EI8DQ4R9J5
	 +JA96edOCJD1siKCzwhg10GVLzoWJhgcyR75mxH/QEqMKGqKIuNyT+LJYsOuPRAXge
	 d5JRWwOnbSHqVMrluRhO+kP9YgjYoW3i3EObqtdDFflnw7X1r6JzMcU9CrJu2RBl6M
	 S2b+TrBbnfguA==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.17-rc5
Date: Fri,  5 Sep 2025 13:20:12 -0700
Message-ID: <20250905202012.2341155-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.17.
This includes fixes for segfaults that I reported earlier.

Thanks,
Namhyung


The following changes since commit 2c369d91d0933aaff96b6b807b22363e6a38a625:

  perf symbol: Add blocking argument to filename__read_build_id (2025-08-25 15:07:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.17-2025-09-05

for you to fetch changes up to ca81e74dc34734078d34485d4aa123561ba75b15:

  perf symbol-elf: Add support for the block argument for libbfd (2025-09-04 16:37:35 -0700)

----------------------------------------------------------------
perf-tools fixes for v6.17-rc5

This series contains fixes for use-after-free resulted in segfaults
after merging the bpf tree.  Also a couple of build and test fixes.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Ian Rogers (4):
      perf bpf-event: Fix use-after-free in synthesis
      perf bpf-utils: Constify bpil_array_desc
      perf bpf-utils: Harden get_bpf_prog_info_linear
      perf symbol-elf: Add support for the block argument for libbfd

James Clark (1):
      perf tests: Fix "PE file support" test build

Thomas Richter (1):
      perf test: Checking BPF metadata collection fails on version string

 tools/perf/tests/pe-file-parsing.c          |  4 +-
 tools/perf/tests/shell/test_bpf_metadata.sh |  2 +-
 tools/perf/util/bpf-event.c                 | 39 ++++++++++++------
 tools/perf/util/bpf-utils.c                 | 61 ++++++++++++++++++-----------
 tools/perf/util/symbol-elf.c                | 10 +++--
 5 files changed, 76 insertions(+), 40 deletions(-)
