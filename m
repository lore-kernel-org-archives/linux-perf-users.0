Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E280B;
	Wed, 16 Jul 2025 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642061; cv=none; b=u5V59NAjHisgh7feMQ0uSuel+byWS+iZvGkNYCHNSGFxU94CpgFo0MoJlQROA/7gXqJlsWv812lXAjdEAaKUlOgEEOWnBC0fLjRJ+6urwUdmCIGMO8rnXnzaWoKVmRFyku+Zgbgu9OYba8WvEXKrxYzDrkBFTDMjpaUYYhfQxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642061; c=relaxed/simple;
	bh=XtMLpOAa387i4NV6spyJjvSiaB6ijPaTYqz33VZsloI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRPrMpAvC4FrsY11vkzUOTQpZME9vK2Gv8oIPb6A94Fs1lrATr4AW6ECSosodNeI+K95vDvzQERt8arUx4XUbqCMxwMmYbIMEm2ap8pBBK+Os1G/kpA5/EfVkRopbE+lWI/Cl22LyrSjFIwRESrLqJsYCJukKujDjzL76/v2djM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUOgZ7yS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUOgZ7yS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4651DC4CEF0;
	Wed, 16 Jul 2025 05:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752642060;
	bh=XtMLpOAa387i4NV6spyJjvSiaB6ijPaTYqz33VZsloI=;
	h=From:To:Cc:Subject:Date:From;
	b=CUOgZ7ySkmppISK6/IyY8ZPVXqLnoazEWK8E/BOZJdCoJa9pKKuteKcvS3PRvdXiT
	 Iev1PcZJKvTUrhwbp8MJAxG/dvT3RFgIgWyM6WNZE4gpAoy8PUvEVPLLhN91Mou1st
	 fdMV5kTVYIiK8RHrxCn46VmgbQIBl3CBD5Ij9mrHfLLdu98WxsfEsLOWDV9SJTJ1ei
	 Go/KrhhpZ5FZaJa9JBryhKApSIqS6emzkaUdCxy0uyz21RG5F1Yu8IVOhF+COVq1xf
	 yRZ2BuX00jIXAKiHhw7FimCCEKZ+3IdMfYJ4gc6tm3/Ha+K8JfemaLOZ7FxNGg2vHg
	 Az1M7m+oQtzOQ==
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
Subject: [PATCHSET v3 0/8] perf annotate: Support --code-with-type on TUI
Date: Tue, 15 Jul 2025 22:00:46 -0700
Message-ID: <20250716050054.14130-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0
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

v3 changes)
 * hide stack operation and stack canary by default

v2 changes)
 * use 'T' key to toggle data type display  (Arnaldo)
 * display '[Type]' in the title line when it's enabled  (Arnaldo)
 * show warning when debug info is not available  (Arnaldo)
 * fix a typo  (Arnaldo)

Actually the command line option sets the default behavior and users can
change it by pressing 'T' key in the TUI annotate browser.

The code is also available at 'perf/annotate-code-type-tui-v3' branch at
https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (8):
  perf annotate: Rename to __hist_entry__tui_annotate()
  perf annotate: Remove __annotation_line__write()
  perf annotate: Pass annotation_print_data to annotation_line__write()
  perf annotate: Simplify width calculation in annotation_line__write()
  perf annotate: Add --code-with-type support for TUI
  perf annotate: Add 'T' hot key to toggle data type display
  perf annotate: Show warning when debuginfo is not available
  perf annotate: Hide data-type for stack operation and canary

 tools/perf/Documentation/perf-annotate.txt |   1 -
 tools/perf/builtin-annotate.c              |   5 -
 tools/perf/ui/browsers/annotate.c          |  66 +++++++--
 tools/perf/ui/browsers/hists.c             |   2 +-
 tools/perf/util/annotate.c                 | 157 ++++++++++++++-------
 tools/perf/util/annotate.h                 |  27 ++--
 tools/perf/util/dso.h                      |  11 ++
 tools/perf/util/hist.h                     |  12 +-
 8 files changed, 191 insertions(+), 90 deletions(-)

-- 
2.50.0

