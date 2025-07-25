Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C52D052;
	Fri, 25 Jul 2025 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472282; cv=none; b=u00VZNWbS38UQU7KUZE0hDn1izEuhW0gBHWCcAg5oAZsoIs/IBdeYvBUk+cahvuczqbJDhg/525yLRGNzxqtlhAkbB6juKqgYq9b2jBhEsCTYFVLx05o0RW7UjXOOmPY0+zhdjn+IM4RbVHRhSiy3VaCOZEzhqAUlyeqPso1xPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472282; c=relaxed/simple;
	bh=bEox++np+gZQdQ3g0D4Q2QhzZPcdtYtL/cQZzR/t7Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wje2uPWBCUePHL62A326Q9SU5ort6P/8C1otyETGSKvRoOqNzSB9xCM97cZq6e8zC1qwBjBpc7/FcHJnqNYgcDHAVPSQPmIXbVFGFWqZBvI43IL3dFmo8NcQD1M/wLUWfCBlDjKHf+md32AK6jTtpPP/ou1YN96lHBGNItHnBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEVosa4Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEVosa4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC82C4CEE7;
	Fri, 25 Jul 2025 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753472281;
	bh=bEox++np+gZQdQ3g0D4Q2QhzZPcdtYtL/cQZzR/t7Iw=;
	h=From:To:Cc:Subject:Date:From;
	b=rEVosa4QFaazZPCusQ6MQcPhE2rtvJmt8fMdT9bvbCdyZGGJiz7za7O+zWJpPCEAx
	 to9JgCgdGFNpqTU4q6p49gyGFbPVRUYZvoPZRZgkCGuKy8MaiOjBNUgS9CACztksXE
	 lJg/2giq9uS2KFs+8WS5RcHRcP8weCU7/LiNjcY/chC/mgi3PtPPrzyOH9LMTiGdzU
	 VbZadqalxu6bZA5UGrHg7ajAeIwBpCpdA+kz7tVJMtIUEYeUjpEFlBIbXgHEbFbdC/
	 QNhf2RpfsC56TilmPys5GWtSxhWxqblYPJ6rE8HTARG/v9xiE9CoR/ftAzF0qkBWpu
	 F7io5uaiHz8sQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCHSET v4 0/9] perf annotate: Support --code-with-type on TUI
Date: Fri, 25 Jul 2025 12:37:46 -0700
Message-ID: <20250725193755.12276-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
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

Arnaldo, please tell me if you still don't like the
__hist_entry__tui_annotate() but I don't have a better idea for now.

v4 changes)
 * add dso__debuginfo() helper  (Ian)

v3 changes)
 * hide stack operation and stack canary by default

v2 changes)
 * use 'T' key to toggle data type display  (Arnaldo)
 * display '[Type]' in the title line when it's enabled  (Arnaldo)
 * show warning when debug info is not available  (Arnaldo)
 * fix a typo  (Arnaldo)

Actually the command line option sets the default behavior and users can
change it by pressing 'T' key in the TUI annotate browser.

The code is also available at 'perf/annotate-code-type-tui-v4' branch at
https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (9):
  perf annotate: Rename to __hist_entry__tui_annotate()
  perf annotate: Remove __annotation_line__write()
  perf annotate: Pass annotation_print_data to annotation_line__write()
  perf annotate: Simplify width calculation in annotation_line__write()
  perf annotate: Add --code-with-type support for TUI
  perf annotate: Add 'T' hot key to toggle data type display
  perf annotate: Show warning when debuginfo is not available
  perf annotate: Hide data-type for stack operation and canary
  perf annotate: Add dso__debuginfo() helper

 tools/perf/Documentation/perf-annotate.txt |   1 -
 tools/perf/builtin-annotate.c              |   5 -
 tools/perf/ui/browsers/annotate.c          |  66 +++++++--
 tools/perf/ui/browsers/hists.c             |   2 +-
 tools/perf/util/annotate.c                 | 161 ++++++++++++++-------
 tools/perf/util/annotate.h                 |  27 ++--
 tools/perf/util/dso.h                      |  21 +++
 tools/perf/util/hist.h                     |  12 +-
 8 files changed, 203 insertions(+), 92 deletions(-)

-- 
2.50.1

