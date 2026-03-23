Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E6377000;
	Mon, 23 Mar 2026 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263460; cv=none; b=bx4ZliAP5LhD3CIGUk2/gpKpkXSxonAXCdKxgISDStJjKoWpl0FwH1MkjnuKWIjwHrMaZCjUGnwfohLKs4KH0Yr1WBwt+Jrc5HGXND9IoPMcYT6Fwgu/hyPIclfTaFLqEL6fywT6WlHPUyJkRakbCOyDPoTTXExP4FQVbsypQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263460; c=relaxed/simple;
	bh=x7CNtbT17Hl2JYwWV6Q66IoQuP5UgADqZbd80Y5dcSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kei5aqfKyfZlyei6t3Npb4BuWp2y7mDYopBlSnkhjhKuKidEEBkSTra5h0jqeSOYmo1oIkoN02CtFUYfrTSrWqc6hlTUpACsP5KMIsrgPOHKSJuHCdfITjqVQWrVwkzlTnuK+0fupj3KhxWu3RD5ik16G9nfBHHMYBxzwpx8obs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWQosb/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWQosb/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444FBC4CEF7;
	Mon, 23 Mar 2026 10:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263460;
	bh=x7CNtbT17Hl2JYwWV6Q66IoQuP5UgADqZbd80Y5dcSI=;
	h=From:To:Cc:Subject:Date:From;
	b=XWQosb/QIJgQv8sxoZUlOWxhHnBE9lxym+n7eRzzzNjaqJnpbmtEOx7o0RMddCjzU
	 voZVvFZ7/rHrDwta+OWreDIP8py5erIDrbyQhMVKNzEJmX9eioMSncUAX91JZ73w91
	 QSUw936Hms1XtFIORviyTVtIAJHtcq49XySoK9IhvNrB+1vhh7v3wJzettuKd78zUs
	 0OJwD3wVAiVqZEF1eHUFg7eYJXCvEqK94Dhk0U0Jj7m2AYxHLUfNWlLpWtzqDl0gT/
	 X5ZFj/Wf0EqZo7vD69gCCcn8bhXx8c3ugKMG2ybpR40oL4x3d/SuyneqfzftbAn/Nb
	 3GFO1uoaEGMXw==
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
	Leo Yan <leo.yan@arm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Francesco Nigro <nigro.fra@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v7.0: 2nd batch
Date: Mon, 23 Mar 2026 07:57:25 -0300
Message-ID: <20260323105725.1882966-1-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The following changes since commit 04a9f1766954687f0a1b7a0f7184dc4f86edcb30:

  Merge tag 'soc-fixes-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2026-03-18 08:28:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.0-2-2026-03-23

for you to fetch changes up to 493ad070cbcb0d62deed877d90e80e554cac7f01:

  tools headers: Synchronize linux/build_bug.h with the kernel sources (2026-03-22 18:34:39 -0300)

----------------------------------------------------------------
perf tools fixes for v7.0: 2nd batch

o Fix parsing 'overwrite' in command line event definitions in
  big-endian machines by writing correct union member.

o Fix finding default metric in 'perf stat'.

o Fix relative paths for including headers in 'perf kvm stat'.

o Sync header copies with the kernel sources: msr-index.h, kvm,
  build_bug.h.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
--
2.53.0

----------------------------------------------------------------
Arnaldo Carvalho de Melo (5):
      Merge remote-tracking branch 'torvalds/master' into perf-tools
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
      tools headers: Synchronize linux/build_bug.h with the kernel sources

Ian Rogers (1):
      perf metricgroup: Fix metricgroup__has_metric_or_groups()

Leo Yan (2):
      tools headers: Skip arm64 cputype.h check
      perf kvm stat: Fix relative paths for including headers

Thomas Richter (1):
      perf parse-events: Fix big-endian 'overwrite' by writing correct union member

 tools/arch/x86/include/asm/msr-index.h       |  5 +-
 tools/arch/x86/include/uapi/asm/kvm.h        |  1 +
 tools/include/linux/build_bug.h              |  4 +-
 tools/include/uapi/linux/kvm.h               |  8 +++
 tools/perf/check-headers.sh                  |  1 -
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c |  6 +-
 tools/perf/util/metricgroup.c                |  6 +-
 tools/perf/util/parse-events.c               | 82 ++++++++++++++++++++++------
 8 files changed, 87 insertions(+), 26 deletions(-)
