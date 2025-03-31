Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854B1BD9DD;
	Mon, 31 Mar 2025 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406643; cv=none; b=G5++TX492IbxZmz6jVsZ6fU6ugJPB3OGjaI0giPH1WNbRADhV3eQv4Y/JkYIUuwEgqwAXcH5DtefqwZxjBxM6QTJF6z03U+SzKGOb72zKmAejAhnzQHF8jmF1wkHiqHVaorc6/Q/cOGC3mHNc63bQtBi5EhR69AU09ia43hxa9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406643; c=relaxed/simple;
	bh=fEYwlgCm7q92ia1joFqvhxM1KBN13exMq/yGBZIbG/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gL14UgP2E1Cq0EbMqbmFc90WXQrvCR40qggY/j02jlEzAfopps8wC1uzCOJ7u2o89e8X4CJe4L17UvOGcQo6qxq8mt62K+QzcOzIHtCN2kqR5RNzTBDxrb7fnocITqCr0/sG+HYfl33t19zlXyIqcAs78Dsj16E+2JmhglUR+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLb0MF/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLb0MF/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD32FC4CEE3;
	Mon, 31 Mar 2025 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743406643;
	bh=fEYwlgCm7q92ia1joFqvhxM1KBN13exMq/yGBZIbG/M=;
	h=From:To:Cc:Subject:Date:From;
	b=OLb0MF/O4VhqbTGTLUzlBx2yFMBOn57W8sGE5N50dnlkKDXOK8Tcn/0EGMzNzUnJN
	 WQhzPqoaTLCH903NIRLz/t9+gbZXYaHWk4Rg7SGKAtAnx3ni8Qfi+lycKHdFYetzOK
	 ky2Yd1OR0k4iu9RZk0wZBnmzMy+lDg8cBjoyPpVuC5xwu8ME3BKUbInqo1mcxNyZGN
	 aCgZ2B9gv34zwQ7Kc98tYHdYaIMICkAJYjazbuOUoVfODY2h9jskd+W0L9qlPAflyC
	 l4Rxzh290BValECd7JCoHGReXVytk6DQGC5tnKF3b5JaNeTeRQ86K/qaoeELlRMbNA
	 7Fa8OgP+MojdQ==
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
Subject: [PATCH 0/4] perf report: Support custom output fields in hierarchy mode
Date: Mon, 31 Mar 2025 00:37:18 -0700
Message-ID: <20250331073722.4695-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is to remove arbitrary restrictions in the hierarchy mode.

The -F/--fields option is to specify output fields and sort keys in perf
report exactly what users want.  It was not allowed in the hierarchy mode
because it missed to handle the field correctly.

This patchset addresses that problem and allows the option.  It'd make
the output more flexible.  For example, this is possible:

  $ perf report -F overhead,comm,dso -H

Thanks,
Namhyung


Namhyung Kim (4):
  perf hist: Remove formats in hierarchy when cancel children
  perf hist: Remove formats in hierarchy when cancel latency
  perf hist: Set levels in output_field_add()
  perf hist: Allow custom output fields in hierarchy mode

 tools/perf/builtin-c2c.c    |  3 ++-
 tools/perf/builtin-report.c | 16 ++++++----------
 tools/perf/builtin-top.c    |  2 +-
 tools/perf/ui/hist.c        | 35 +++++++++++++++++++++++++++++++++--
 tools/perf/util/hist.h      |  4 ++--
 tools/perf/util/sort.c      | 36 +++++++++++++++++++++++-------------
 tools/perf/util/sort.h      |  2 +-
 7 files changed, 68 insertions(+), 30 deletions(-)


base-commit: 35d13f841a3d8159ef20d5e32a9ed3faa27875bc
-- 
2.49.0

