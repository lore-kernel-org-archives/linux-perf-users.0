Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DBF34FF5D;
	Thu,  7 May 2026 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138799; cv=none; b=GzqHT0R9B1YuoZ+BR6S95I9/jkGAoSjpVBcVVwExC2qNBi04WBb77/fLNHUrHfXW0O11n9+Nu5kQ7KdKrkBcM1W6a+RqlJEMra16riOnTs6dT/5GpMGsA18FvU8SFSerFDg7Er/uvHkdLuuPD1J9e45ZZUCkcanuoiUtvukmJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138799; c=relaxed/simple;
	bh=PZEMnK6gk+VG3Ru3GVW2lGV2wZUcn0yXtzqhqftadHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+wi5nTrZypP+Rkrodz1ihkZ5KaTEXaUpuNSHrakNHdoo+/SaAgYLHsjACfCih0+hgJf0ilGqMFNi2NvuCapgIZ9x5c28PL1sa+qk1lFguyRP9qAO3kObqrHg26CVr6jChVe5xNifQmc9U5LmDzbsBCBQ+LyOh33CuVHRg3yZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKS9qFwq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKS9qFwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DD0C2BCB8;
	Thu,  7 May 2026 07:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778138798;
	bh=PZEMnK6gk+VG3Ru3GVW2lGV2wZUcn0yXtzqhqftadHI=;
	h=From:To:Cc:Subject:Date:From;
	b=aKS9qFwqy1Loqu3EZv9lJXrdQrVxvKTlJ/1LVHLqprpoBLP9AP3ECqZNo6I0hz/t1
	 i8m7E0awkwroLM8zzun8T1jXccOTSfM+Bv2IKKEpmOPzUJli2k3sXc3TZ5wIsngc7n
	 TxxwXZ4qE2pNFkEIPAblZMmtBI/bnYvYcFnYlOglHIILIvzq38MPfQWuBmNTycDGBG
	 yLc+lDIoyv5P5xPsSGC7dxfPUMvJT3EVk44TlAXq+F8tqJ3ZcyzGqcC6wVHjtOsqrt
	 q4z691bv7kA2rMYoDemmVRMG8Sxip5WkelVjAbM+9XSRs8UOtCsydZ7pvX8nsWjKNd
	 vdHa+WACQrzoQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH v2 0/7] perf build: Update kernel headers
Date: Thu,  7 May 2026 00:26:25 -0700
Message-ID: <20260507072632.37152-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is to update copy of kernel headers for v7.1.  I've updated ones
in the tools/perf/trace/beauty/ and left others which seem not to
affect perf syscall beautifiers.  This is suggested by Linus to avoid
unnecessary builds of objtool and the kernel.

There are AMD IBS changes that are directly related to perf, but I
think Ravi is working on it with other Zen6 changes.  So I didn't
include it here.

Due to the header file changes, some beautifier scripts for perf trace
are updated too.  This was detected by Sashiko.

Also I removed the header difference output in the default perf build
and added a new make target to check it explicitly.

Thanks,
Namhyung


Namhyung Kim (7):
  perf trace: Sync linux/socket.h with the kernel source
  perf trace: Sync uapi/linux/fs.h with the kernel source
  perf trace: Sync uapi/linux/mount.h with the kernel source
  perf trace: Sync uapi/linux/sched.h with the kernel source
  perf build: Add make check-headers target
  perf trace: Add beautifier script for fsmount flags
  perf trace: Update beautifier script for clone flags

 tools/perf/Makefile                           |  5 ++++-
 tools/perf/Makefile.perf                      |  8 ++++++-
 tools/perf/builtin-trace.c                    |  7 +-----
 tools/perf/trace/beauty/beauty.h              |  3 +++
 tools/perf/trace/beauty/clone.sh              |  4 ++--
 tools/perf/trace/beauty/fsmount.c             | 18 ++++++++++++++-
 tools/perf/trace/beauty/fsmount.sh            | 11 +++-------
 tools/perf/trace/beauty/fsmount_attr.sh       | 22 +++++++++++++++++++
 .../perf/trace/beauty/include/linux/socket.h  |  2 +-
 .../perf/trace/beauty/include/uapi/linux/fs.h | 12 ++++++++++
 .../trace/beauty/include/uapi/linux/mount.h   |  1 +
 .../trace/beauty/include/uapi/linux/sched.h   | 17 ++++++++++++--
 12 files changed, 88 insertions(+), 22 deletions(-)
 create mode 100644 tools/perf/trace/beauty/fsmount_attr.sh

-- 
2.53.0

