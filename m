Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5A3197A65;
	Tue,  8 Oct 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395764; cv=none; b=ZvD7UDIXuxvICZIUmVdQdk2qvO+zz7YrSPAHicCgllEWHXfuRKcafyxnAiLYWLu+GrVWLb9awzLGdivUqc90817nQ0drdsEHcUVC0JmpMTmfw2sId+OllF/wV3nctbgJruryrNiZZwRbwytCmyFZI2WKAfvAwtZ84UY7UxZUJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395764; c=relaxed/simple;
	bh=l3v5zbOAu2VpNitLU1rz2xcsriFrmQpDRQUKMsWmwdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELd1X57BlpMPI4cJ0sUE+dxz25UqX6T9UWxbNihLWAIAoK5f8M/EQrKzquBDtU7N9bEEABVzDDSI1q41PZZ3igH0awJAeWGy6saiCaw6F6nGAhRq+2sLEDyqbh2xcFPy8Qlr012zKzb2f81r/3wLGbWTjkr/BGRGE1x+R2/E1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJcBIttx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJcBIttx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B40FC4CEC7;
	Tue,  8 Oct 2024 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395763;
	bh=l3v5zbOAu2VpNitLU1rz2xcsriFrmQpDRQUKMsWmwdw=;
	h=From:To:Cc:Subject:Date:From;
	b=kJcBIttxXZGEloWu2Jm18sb9Beb6pG4lVWi+d8BX80/hMKZlIoTN6OBsW1F9rck/R
	 4iczFFKtY3ZGxLkrVCfM+RkBeCn28BbUBmq0/h/bO8jDyTPNfR/vN+m5sDbSgP0uLu
	 2g/GkPGatZ+brJJATPTlM6SyLAD1jmS+gvtE+SCK535LHRMSFZtrn+BrLk0cIKgmYT
	 aPXqmMFMstTO6DvTn0JPUIDFO7lAWsm7AvTbKtOVYFwkT7F5UkC+8R+kyEQaLMpyqr
	 VWqZdf0oiam28q+CwzYT9+LE5qNifptn6KTz1mHXKJcWjYfHeTTVJ2YfSiNNRS0NJ9
	 YrYWl1Mf/BpKA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Monakov <amonakov@ispras.ru>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	James Clark <james.clark@linaro.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.12
Date: Tue,  8 Oct 2024 10:55:49 -0300
Message-ID: <20241008135549.988547-1-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
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

The following changes since commit eee280841e1c8188fe9af5536c193d07d184e874:

  Merge tag 'mm-hotfixes-stable-2024-09-27-09-45' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2024-09-27 10:27:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.12-1-2024-10-08

for you to fetch changes up to e934a35e3cc1fe0bfb1bc771e64f3ba6e70c40e2:

  perf cs-etm: Fix the assert() to handle captured and unprocessed cpu trace (2024-10-02 18:21:49 -0300)

----------------------------------------------------------------
perf tools fixes for v6.12:

- Fix an assert() to handle captured and unprocessed ARM CoreSight CPU traces.

- Fix static build compilation error when libdw isn't installed or is too old.

- Add missing include when building with !HAVE_DWARF_GETLOCATIONS_SUPPORT.

- Add missing refcount put on 32-bit DSOs.

- Fix disassembly of user space binaries by setting the binary_type of DSO when
  loading.

- Update headers with the kernel sources, including asound.h, sched.h, fcntl,
  msr-index.h, irq_vectors.h, socket.h, list_sort.c and arm64's cputype.h.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (11):
      Merge remote-tracking branch 'torvalds/master' into perf-tools
      tools include UAPI: Sync sound/asound.h copy with the kernel sources
      tools include UAPI: Sync linux/sched.h copy with the kernel sources
      tools include UAPI: Sync linux/fcntl.h copy with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      perf trace beauty: Update the arch/x86/include/asm/irq_vectors.h copy with the kernel sources
      tools headers UAPI: Sync the linux/in.h with the kernel sources
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools check_headers.sh: Add check variant that excludes some hunks
      perf tools: Cope with differences for lib/list_sort.c copy from the kernel
      tools headers arm64: Sync arm64's cputype.h with the kernel sources

Ian Rogers (1):
      perf vdso: Missed put on 32-bit dsos

Ilkka Koskinen (1):
      perf cs-etm: Fix the assert() to handle captured and unprocessed cpu trace

James Clark (1):
      perf dwarf-aux: Fix build with !HAVE_DWARF_GETLOCATIONS_SUPPORT

Namhyung Kim (1):
      perf symbol: Set binary_type of dso when loading

Yang Jihong (2):
      perf build: Fix static compilation error when libdw is not installed
      perf build: Fix build feature-dwarf_getlocations fail for old libdw

 tools/arch/arm64/include/asm/cputype.h             |  2 +
 tools/arch/x86/include/asm/msr-index.h             |  2 +
 tools/build/feature/Makefile                       |  5 +-
 tools/include/uapi/linux/in.h                      |  2 +-
 tools/perf/Makefile.config                         |  7 +-
 .../perf/check-header_ignore_hunks/lib/list_sort.c | 31 ++++++++
 tools/perf/check-headers.sh                        | 29 +++++++-
 .../beauty/arch/x86/include/asm/irq_vectors.h      |  4 +-
 tools/perf/trace/beauty/fs_at_flags.sh             |  5 ++
 tools/perf/trace/beauty/include/linux/socket.h     |  1 +
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 84 +++++++++++++++-------
 tools/perf/trace/beauty/include/uapi/linux/sched.h |  1 +
 .../perf/trace/beauty/include/uapi/sound/asound.h  | 17 ++++-
 tools/perf/trace/beauty/msg_flags.c                |  4 ++
 tools/perf/util/cs-etm.c                           |  2 +-
 tools/perf/util/dwarf-aux.h                        |  1 +
 tools/perf/util/symbol.c                           |  3 +
 tools/perf/util/vdso.c                             |  4 +-
 18 files changed, 170 insertions(+), 34 deletions(-)
 create mode 100644 tools/perf/check-header_ignore_hunks/lib/list_sort.c
