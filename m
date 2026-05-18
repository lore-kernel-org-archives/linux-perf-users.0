Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7C537AA74;
	Mon, 18 May 2026 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133604; cv=none; b=ux3tGxbxs9kRDXW8YxpiUH5TChJKEQAFxkbiCVhQncvu3MVL/0VIkKLNObqf2sfGACgaSbuHmrzERNvZpMUj6KChP0a0A5uwlOXRgpIPK1aNq/MATmtHd2uGDenG17sz1b2gsQfZ97GpcpWJO+96MU0UdXExyTEQW6dbiv6aQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133604; c=relaxed/simple;
	bh=CIwVFWb3hoY6GvPDHAnYYVpICrm/ia8gKv56vEgE7sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=snQna01/NlMASQZY6/+4Q+tTQjsCVSfB012BWEunfU0pETpdJkTBsGB5Pt39PjBs/hdo0HpRiz7JdOjjE8ANu/S5jN3H9zMuQk8e1TMjfxdKTDd2TYKBcgyp3K0vB+wUPUPiaiZkacZKAr610+F6jTjkbNJKfhS9ikF1dmp6TP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJOdiH6F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJOdiH6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D9CC2BCB7;
	Mon, 18 May 2026 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779133604;
	bh=CIwVFWb3hoY6GvPDHAnYYVpICrm/ia8gKv56vEgE7sE=;
	h=From:To:Cc:Subject:Date:From;
	b=uJOdiH6FtE+p9tcxHhHgGsBYcfQA4pdkcKhKTE2Pvsxwnb8w3kR7+Dr7OY7xm9MMv
	 SblE5Wl37OG8e38u+GsRgSLMxa3pEE1zfZnDeL2sIICEKBPArnsH6CfJtqW3SxgKud
	 YmhGmtt9GYNewg/9/uFe2Dj041y03uVQFHfc2btqZrYkKRVzXLRFS71A/AMsHx7LYA
	 O77KfMMtQFKXJopqn6AhKuXemi5KAsFDp1wf6guRHxUoRaDf58TaNqJ4Mgb3Ja147t
	 eBHowjmRWQ7xlZE37nt/lDRA7Q1Umh0k7pRgLeYYcSC/CMxvY0CtvqcagS4QGgQyug
	 M/FAWfMV0eBHg==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v7.1-rc5
Date: Mon, 18 May 2026 12:46:41 -0700
Message-ID: <20260518194641.1509400-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v7.1.

Thanks,
Namhyung


The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.1-2026-05-18

for you to fetch changes up to 9a424b62f771a759b040b9be2f3762bad0da283f:

  Merge branch 'perf-upstream' (2026-05-18 12:41:38 -0700)

----------------------------------------------------------------
perf-tools fixes for v7.1-rc5

An usual sync-up for the header files and related codes.

 - copy headers that are used for perf trace syscall beautifier
 - update the beautifier scripts according to the changes
 - not to show differences in the headers by default

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Namhyung Kim (8):
      perf trace: Sync linux/socket.h with the kernel source
      perf trace: Sync uapi/linux/fs.h with the kernel source
      perf trace: Sync uapi/linux/mount.h with the kernel source
      perf trace: Sync uapi/linux/sched.h with the kernel source
      perf build: Add make check-headers target
      perf trace: Add beautifier script for fsmount flags
      perf trace: Update beautifier script for clone flags
      Merge branch 'perf-upstream'

 tools/perf/Makefile                                |  5 ++++-
 tools/perf/Makefile.perf                           |  9 ++++++++-
 tools/perf/builtin-trace.c                         |  9 +++------
 tools/perf/trace/beauty/beauty.h                   |  3 +++
 tools/perf/trace/beauty/clone.sh                   |  4 ++++
 tools/perf/trace/beauty/fsmount.c                  | 18 +++++++++++++++++-
 tools/perf/trace/beauty/fsmount.sh                 | 11 +++--------
 tools/perf/trace/beauty/fsmount_attr.sh            | 22 ++++++++++++++++++++++
 tools/perf/trace/beauty/include/linux/socket.h     |  2 +-
 tools/perf/trace/beauty/include/uapi/linux/fs.h    | 12 ++++++++++++
 tools/perf/trace/beauty/include/uapi/linux/mount.h |  1 +
 tools/perf/trace/beauty/include/uapi/linux/sched.h | 17 +++++++++++++++--
 12 files changed, 93 insertions(+), 20 deletions(-)
 create mode 100644 tools/perf/trace/beauty/fsmount_attr.sh
