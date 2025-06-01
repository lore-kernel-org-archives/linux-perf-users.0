Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DCB9460;
	Sun,  1 Jun 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748760784; cv=none; b=VdL94pfEtQuJyWn9cPSurn4J+WZjZEKxM0XHMje/uqePKrIonKFrtblndasaPJykA5i/TiVvPZTrYYNpKdqHlLidQUEECBRyAcRxBe0cgj4q6BuYZy64Wh+/iFzCF6kkj/rmZojWgABbwleJBD4Pd8f7FOONUU1hw955z6y2Hgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748760784; c=relaxed/simple;
	bh=0luutmRdb7eHxQQu8rU4oW6okBxYEbzgNa4IEh3chAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHHRhyNy7JUoeY2Vh8/tqzwTgojiHwylb6ChZbe6WlIJ+VNOUzvtSVY/7ghUi98pmAtFI/OekDlS3UDZw1P8bAhWY8Fn/v0zNebonyIMx+D/KRGxwVD5DODGAXW4p9/XK3co6Di7sqw5G/HKd4svOGyePdyugimNT4DwNpshd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJuxiYsg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJuxiYsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0115C4CEE7;
	Sun,  1 Jun 2025 06:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748760783;
	bh=0luutmRdb7eHxQQu8rU4oW6okBxYEbzgNa4IEh3chAA=;
	h=From:To:Cc:Subject:Date:From;
	b=lJuxiYsgLxjY+tMfBx479ID0hOD3thdaO53GJJ5qKC2z8zNCxOSMDeUffoAQer535
	 hlAXzccomKL0xm70uVHNWNSbhHESheTf2i3pQ7a6HE7p6N1hPo2zKb0PzQAXCBeqIj
	 3vMrPMbCj1JiYYg4l+VJcHEcgIE4LqtCIayduBmelptNd0n4xJbx8NARUiA5vnj2kW
	 eVIpq2H0Duit0tn2+THiM4CkLFmviGQm35nXGe6cnFPa+cPp/ws7FrbE+fBrslWgZe
	 bQCoEdlfYV46PASDtKbcgtPqduI06i2nyyVyg4xN5JdLIpAYCo9fqn8gjqy0xApRB0
	 QP1d5tUbW3liQ==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCHSET 0/6] perf annotate: Support --code-with-type on TUI (v1)
Date: Sat, 31 May 2025 23:52:56 -0700
Message-ID: <20250601065302.12531-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The --code-with-type option is to show normal annotate output with type
information.  It was supported only on --stdio, but this change adds it
to TUI as well.

Actually the command line option sets the default behavior and users can
change it by pressing 'y' key in the TUI annotate browser.

The code is also available at 'perf/annotate-code-type-tui-v1' branch at
https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (6):
  perf annotate: Rename to __hist_entry__tui_annotate()
  perf annotate: Remove __annotation_line__write()
  perf annotate: Pass annotation_print_data to annotaiton_line__write()
  perf annotate: Simplify width calculation in annotation_line__write()
  perf annotate: Add --code-with-type support for TUI
  perf annotate: Add 'y' hot key to toggle data type display

 tools/perf/Documentation/perf-annotate.txt |   1 -
 tools/perf/builtin-annotate.c              |   5 -
 tools/perf/ui/browsers/annotate.c          |  43 ++++--
 tools/perf/ui/browsers/hists.c             |   2 +-
 tools/perf/util/annotate.c                 | 149 ++++++++++++++-------
 tools/perf/util/annotate.h                 |  27 ++--
 tools/perf/util/hist.h                     |  12 +-
 7 files changed, 149 insertions(+), 90 deletions(-)

-- 
2.49.0

