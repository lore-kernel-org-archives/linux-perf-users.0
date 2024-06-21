Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4377166318;
	Fri, 21 Jun 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989529; cv=none; b=neNtiR1Dc24lSp/Qdz9BuN0Bqei1rlkB+igZ1GOT0A5yE8/lvRlwuoZwSzMNxFXQq/PSTkZpFkaU8vCfmD+G4HB1J5wXNndIxvYrmqsi9b8TtoSyMv0fVyJ8Fz1PZwpiHymhzbi9wTp9sM+//NF8vPYofslEg1LCSQKr1/LIrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989529; c=relaxed/simple;
	bh=t+JsKmWGHAHPwrc4pGexNSToN6va7j/NSaMw2tsa80w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rkgQcEktjg7SjMe5pHvlGsE21uWCPLw6CmFUrdQuVxjvTRBHbiFD99EElH/YqjKXv6mX50JoIvW6BjP4yEznyvGLCLiww+JhnH4vk+1kObpYdq9wQ1aathyxOl3h2Jrpx+e+hto39nsj6YjWrktchQdo10XZOJKu2BLZ896Db0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0Gui/Ky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0Gui/Ky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A88C3277B;
	Fri, 21 Jun 2024 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718989529;
	bh=t+JsKmWGHAHPwrc4pGexNSToN6va7j/NSaMw2tsa80w=;
	h=From:To:Cc:Subject:Date:From;
	b=r0Gui/KyYyeRZho499Skqy+lwCtMkEz2qjqU/WO/ooEnK2NZs6E+Or8DDW9z1vjU0
	 hgxi995gwPgCpb2l45gsGXQegdFn3AcAFcoU0lJUtKMWorrESFBXtW4ppH6MWParj5
	 jfWkgY6AJPKUAdjqBw1oyN3qsYaA9A35gyYkn1LOH/sDp9GwbZ4tis1hvLx6znujMx
	 zcCt6ZgrlwvANzb61ZJO67mzvz0MVN57Iew6DWyoMcoWrfI5AX9aZw+gTxU9UGbZVe
	 uaEvAagHzAnGkpiOIunWndwEodDIisS0Xu0bYDZnno7xchl4pGfqmnpBB5V5GHAsLV
	 /1F6znGnJTXCA==
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
Subject: [PATCH 0/4] perf tools: Assorted random updates and fixes
Date: Fri, 21 Jun 2024 10:05:24 -0700
Message-ID: <20240621170528.608772-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I found some misc updates and fixes are still remaining.  Just sending out
together.  Please take a look!

Thanks,
Namhyung


Namhyung Kim (4):
  perf report: Fix condition in sort__sym_cmp()
  perf symbol: Simplify kernel module checking
  perf tools: Fix a compiler warning of NULL pointer
  perf mem: Fix a segfault with NULL event->name

 tools/perf/util/dsos.c       | 3 +++
 tools/perf/util/mem-events.c | 2 +-
 tools/perf/util/sort.c       | 2 +-
 tools/perf/util/symbol.c     | 5 +----
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.45.2.741.gdbec12cfda-goog

