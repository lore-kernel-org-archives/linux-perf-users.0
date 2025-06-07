Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18951CEACB;
	Sat,  7 Jun 2025 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749338741; cv=none; b=aCtYs3PBOLeBunMHJxSYkzE1UW7HGpt95MHOOXlXuM8sVO/yWxnr3L1tfeVSRPBo9VIBGup8Xd52C5rw6M1C1PEvBncF6ijxJFk4541H9DUgzJpOQj5tR6Oxp2Sk9o1AhJsK5SH2hUVNPdArfaXkNece8rD2tbGxuPXeVEG7Dto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749338741; c=relaxed/simple;
	bh=+x9iYkp2kMj0sWpU2OJi05D4QCZU/V3hzCNqWpZ+VCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDyY4WUYywqoZ7J+xPCkGqFQZy0pyMwFF2gO5DyT5a9oWYBDCMUXq4qphs8louPbChAEW696yEY6xmM8tkCg39tqs1Ju7DpFUpEZLnyDQ8LHQwDjzFrb05wGlFRGUDz4zZBsIHoHyxiI8yF+3ZNy9Zd/A9T51mq87pnmLQ+sDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sd+a2cjn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sd+a2cjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8096C4CEE4;
	Sat,  7 Jun 2025 23:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749338741;
	bh=+x9iYkp2kMj0sWpU2OJi05D4QCZU/V3hzCNqWpZ+VCM=;
	h=From:To:Cc:Subject:Date:From;
	b=sd+a2cjnLoBwh9G9zTq8fcF2gHx2gNF/5SH/jtfCnhnVwnzKxf1NDZsRQz7iVktyQ
	 jicOgx4PbiXhH5dJq1WZlIumOkjDZYfIfmQF2g9dtXGkYoBNV1vmyjLd4sDmK+hvR6
	 ekYE4PUffSyDC9L/0CYrW62dbQ/WAee5FLRaDlL9cWtpH1nK8xNJvWVRMjgA9L8Bnj
	 X6+lGzjfdOEAk1k9LcHW58R2nva279HN+ixmuE7N9ljBUyfJfDz6BlsP0vduAj4VQB
	 hEqSYVEXN4DjLDixRRbiforofZCY1te/cP19gfC3jLH72P1lhW3qRmH1a/mHG7lPQ7
	 xqaBNjmp4d+7Q==
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
Subject: [PATCHSET v2 0/7] perf annotate: Support --code-with-type on TUI
Date: Sat,  7 Jun 2025 16:25:33 -0700
Message-ID: <20250607232540.89488-1-namhyung@kernel.org>
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

v2 changes)
 * use 'T' key to toggle data type display  (Arnaldo)
 * display '[Type]' in the title line when it's enabled  (Arnaldo)
 * show warning when debug info is not available  (Arnaldo)
 * fix a typo  (Arnaldo)

Actually the command line option sets the default behavior and users can
change it by pressing 'T' key in the TUI annotate browser.

The code is also available at 'perf/annotate-code-type-tui-v2' branch at
https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (7):
  perf annotate: Rename to __hist_entry__tui_annotate()
  perf annotate: Remove __annotation_line__write()
  perf annotate: Pass annotation_print_data to annotation_line__write()
  perf annotate: Simplify width calculation in annotation_line__write()
  perf annotate: Add --code-with-type support for TUI
  perf annotate: Add 'T' hot key to toggle data type display
  perf annotate: Show warning when debuginfo is not available

 tools/perf/Documentation/perf-annotate.txt |   1 -
 tools/perf/builtin-annotate.c              |   5 -
 tools/perf/ui/browsers/annotate.c          |  66 +++++++---
 tools/perf/ui/browsers/hists.c             |   2 +-
 tools/perf/util/annotate.c                 | 146 ++++++++++++++-------
 tools/perf/util/annotate.h                 |  27 ++--
 tools/perf/util/dso.h                      |  11 ++
 tools/perf/util/hist.h                     |  12 +-
 8 files changed, 180 insertions(+), 90 deletions(-)

-- 
2.49.0

