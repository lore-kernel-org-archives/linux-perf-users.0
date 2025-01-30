Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D81DA5F;
	Thu, 30 Jan 2025 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738273777; cv=none; b=drCRIiiVcXUaJ+8cNV11HHR3hc9C+pbiPrljlLa6NqBjU90CDI0XJSxoL2lHqvXaEMkKLooLwO9dMW3CJlCbl8G+kkDHgGlZzb0fD6kvXAjD/FGRzTRRoD8vpDRHvYw1XuJTUrcdlfUEgUXbgSN+63AP9+E7ZdTHv2Xl1/p2Zzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738273777; c=relaxed/simple;
	bh=2t8rVTMwBcb/P3DZwdZDi3FNG5kEb1diABrmtIkiEHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7G/Z/dAwxR0xZrSKTKcLjAe+MP1dCoLKt1JctjKXqVm/1+OrVwtomT3ACFc1+4mH55Fqu95JfCRUfU4CpfflKU7fEvNxqMfuG3zXKCWRLwHsgTfZUhD6L53SPvbBkN2n0XoqH939Z49/O6bhBvRPzNqIyzDMRU3mh3TDprpXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfzWXRAw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfzWXRAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EC3C4CED2;
	Thu, 30 Jan 2025 21:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738273777;
	bh=2t8rVTMwBcb/P3DZwdZDi3FNG5kEb1diABrmtIkiEHQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BfzWXRAw4iuFmLQ8LTGUpnU9FwXhxf3IQjTTKgjQTepwrYt0Pt4sOlNRbpDKkbB7f
	 rw8oOlS4r4vWM1Qnm9QWlrRoQFcQnwJzWXEkWMGLsabtyfb+aHMbmzWiPYGiJGanEt
	 JzAp+FPzMlh4OE1QwDfClrJ8cxqC7xjVWh2ypY4+qhx6lmMxz0maJo3VkATAVacBnN
	 0JDWnlklvDDgXQ4fvD61RBZ4xfux5AheDQK8nKc+BXOUBdN9hv/ISL+nnQW05l+Wv8
	 gmdpDm3+hVQ7guz9QV25ZFwmq4SSRUU44y6+w+iWlpF9YsxXG29HL6eS0itRv/ZuRX
	 jsEX86mBsC1EA==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.14
Date: Thu, 30 Jan 2025 13:49:35 -0800
Message-ID: <20250130214935.2148549-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.14.

Thanks,
Namhyung


The following changes since commit 91b7747dc70d64b5ec56ffe493310f207e7ffc99:

  perf test: Update event_groups test to use instructions (2025-01-18 10:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.14-2025-01-30

for you to fetch changes up to 9fae5884bb0e3480dbb69314b82ed3d8f8482eef:

  perf cpumap: Fix die and cluster IDs (2025-01-28 10:03:26 -0800)

----------------------------------------------------------------
perf-tools fixes for 6.14

An early round of random fixes in perf tools for this cycle.

perf trace
----------
* Fix loading of BPF program on certain clang versions
* Fix out-of-bound access in syscalls with 6 arguments
* Skip syscall enum test if landlock syscall is not available

perf annotate
-------------
* Fix segfaults due to invalid access in disasm arrays

perf stat
---------
* Fix error handling in topology parsing

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Howard Chu (2):
      perf trace: Fix BPF loading failure (-E2BIG)
      perf trace: Fix runtime error of index out of bounds

Ian Rogers (1):
      perf annotate: Use an array for the disassembler preference

James Clark (1):
      perf cpumap: Fix die and cluster IDs

Namhyung Kim (1):
      perf test: Skip syscall enum test if no landlock syscall

 tools/perf/builtin-trace.c                         |  6 +-
 tools/perf/tests/shell/trace_btf_enum.sh           |  8 ++-
 tools/perf/util/annotate.c                         | 76 ++++++++++++++++++--
 tools/perf/util/annotate.h                         | 15 ++--
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     | 11 ++-
 tools/perf/util/cpumap.c                           |  4 +-
 tools/perf/util/disasm.c                           | 83 ++++------------------
 7 files changed, 113 insertions(+), 90 deletions(-)
