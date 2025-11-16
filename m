Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A23E573;
	Sun, 16 Nov 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763321352; cv=none; b=n8gXdt5Li2Ay2WfIZrSBJH/sCjxqZIhNTVBG3T9NBY1YI44eW7sLe39xdvzM9FQrp2KWzg9vOoArgNTrm9W0/UGQ+61/SxmsZiIxaX2u/D+lHVq+pnSCWOHSIFC49u2YCyHyqHSuKX4aZJw2oghLrOHCnIPcLlVWwA+RrtyRHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763321352; c=relaxed/simple;
	bh=/bw70WQh8cJc6R4hU3UvK+/wy9ygjGRWdsMH3R6WQUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/ZLcwjFpy/XDZbwOo+t2Ruyl2BKHtkX4Y/M7AvOWbcucGKOplm06al/shBoSkvTEJMqjggm6LEBcchqixONqH+Fxf4Gsjl2dITCFas4n0tWrHySua33UY3+V+5C/Qftmur/zis/M7hYo3hzCSfwRiPsCHedYrmAsR/kjP0VRkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGgR9jsd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGgR9jsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC966C113D0;
	Sun, 16 Nov 2025 19:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763321351;
	bh=/bw70WQh8cJc6R4hU3UvK+/wy9ygjGRWdsMH3R6WQUg=;
	h=From:To:Cc:Subject:Date:From;
	b=YGgR9jsdaryqeS3ayqDOmNage0Z6s6bYpUoAkKFl3CTv9luuMezASITKxDIkQoyAT
	 69DuakAl9+Zv7CLEecWI/T8bPGuAnucohruCtbvGNO1YATJFulTG8HiKKDQZTeFY9b
	 6s2JaiJtyBSAk7xKTUbs06rfRuwIa+nip7EIpuMeCg+G5e0PCxCf2yvtdttLsFEAnM
	 5BgDGHA5X2SY19sXJyE2DJObDCcuF70YE1YgMUfICLuk+w18aXo337VAK9TFC4qFIw
	 sFgO+iMpSACO3UzttN9bPQ9aMagQNxRVPWa8hzYSOHS2hLhUVi8PH+qcKsE9194BQU
	 ko7xpA+6E34wA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Guilherme Amadio <amadio@gentoo.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tycho Andersen <tycho@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.18: 2nd batch
Date: Sun, 16 Nov 2025 16:29:01 -0300
Message-ID: <20251116192901.272457-1-acme@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 9b9e43704d2b05514aeeaea36311addba2c72408:

  Merge tag 'slab-for-6.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab (2025-11-13 11:42:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.18-2-2025-11-16

for you to fetch changes up to b72b8132d8fd2d6bf5b420a03d4fc553980c3a92:

  perf libbfd: Ensure libbfd is initialized prior to use (2025-11-13 17:55:19 -0300)

----------------------------------------------------------------
perf tools fixes for v6.18: 2nd batch

- Fix writing bpf_prog (infos|btfs)_cnt to data file, to not generate
  invalid perf.data files in some corner cases.

- Fix 'perf top' segfault by ensuring libbfd is initialized. This is an
  opt-in feature due to license incompatibilities.

- Fix segfault in 'perf lock' due to missing kernel map.

- Fix 'perf lock contention' test.

- Don't fail fast path detection if binutils-devel isn't available.

- Sync KVM's vmx.h with the kernel to pick SEAMCALL exit reason.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (2):
      perf build: Don't fail fast path feature detection when binutils-devel is not available
      tools headers UAPI: Sync KVM's vmx.h with the kernel to pick SEAMCALL exit reason

Ian Rogers (1):
      perf libbfd: Ensure libbfd is initialized prior to use

Ravi Bangoria (2):
      perf lock: Fix segfault due to missing kernel map
      perf test: Fix lock contention test

Thomas Falcon (1):
      perf header: Write bpf_prog (infos|btfs)_cnt to data file

 tools/arch/x86/include/uapi/asm/vmx.h     |  1 +
 tools/build/feature/Makefile              |  4 ++--
 tools/perf/Makefile.config                |  5 ++--
 tools/perf/builtin-lock.c                 |  2 ++
 tools/perf/tests/shell/lock_contention.sh | 14 ++++++++----
 tools/perf/util/header.c                  | 10 ++------
 tools/perf/util/libbfd.c                  | 38 +++++++++++++++++++++++++++++++
 tools/perf/util/mutex.c                   | 14 ++++++++----
 tools/perf/util/mutex.h                   |  2 ++
 9 files changed, 68 insertions(+), 22 deletions(-)
