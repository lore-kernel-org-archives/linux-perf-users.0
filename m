Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C419D8AF;
	Thu, 27 Jun 2024 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518635; cv=none; b=YLlxqQyoUKqq/xP0dID7QbdVbQ8q5M+pButM8dwFyvKNhr0lCxYGFUttnbGgiJ9XiT5pDOHht5uz0Arzx2yto8lpbwwch8PttjfkWdugppiHFZcDzcoOE8esxs5RCzisubQMtdtT7mu+bzTGSeBWbJiOFIzXIgEU6Wmqa3f0qJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518635; c=relaxed/simple;
	bh=w5lKM63h2MNeYhdBkKdMcXuUKOZrBvaTgOKjOiaoPm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F09m/o/RjPr9wNPgkNmxf+GMOAKVtBD1kuZbT4zyKMUDDBz/GgkaH8Bt6grqdtnZeG34k9ZKcrbJrA/vloTHX6PUol4bzytD8q/31z177EzY10Kj5dqjH+6n9byWzRqnHKxSPwAPTHvIWuTcrOpSaeW7S7uNriNo0C2kby61wcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZfKvwSx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZfKvwSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B497C4AF0C;
	Thu, 27 Jun 2024 20:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719518634;
	bh=w5lKM63h2MNeYhdBkKdMcXuUKOZrBvaTgOKjOiaoPm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZfKvwSxz9gdc4BEgN4E0QrlkQtrjOi+Nik/F3wHKeTtcSEWooLK58J2nSuwg0Y4V
	 sWbwFchkcdgEODs9Syss1zFARdt3wSJhf+IlWoIV+kcDtw5+V3Z6ooa+VyOiCtRaOE
	 piX1+LQDdxbDxjo2L5uutC/2bnF+cP53alAJgWD1DhsEf9N6TQxhRjj3rO7NZJiTpB
	 zaVa4LizMqGLoubvPt8Rzh9d0RuqJC5GXcwxcjClW9M9LwoGbeAaRctJyFpC+Yo1j1
	 f/5RpElQ9QzLtXMU7S1xPbo8DzUWHm5z+3xze+cuNhHIQ5AwX6TYg412LE0qWhGwEm
	 zbd6Lo2pdF3Lw==
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
	Yicong Yang <yangyicong@hisilicon.com>
Subject: [PATCH 2/2] perf stat: Fix a segfault with --per-cluster --metric-only
Date: Thu, 27 Jun 2024 13:03:53 -0700
Message-ID: <20240627200353.1230407-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240627200353.1230407-1-namhyung@kernel.org>
References: <20240627200353.1230407-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new --per-cluster option was added recently but it forgot to update
the aggr_header fields which are used for --metric-only option.  And it
resulted in a segfault due to NULL string in fputs().

Fixes: cbc917a1b03b ("perf stat: Support per-cluster aggregation")
Cc: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e8673c9f6b49..462227f663cb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -38,6 +38,7 @@
 static int aggr_header_lens[] = {
 	[AGGR_CORE] 	= 18,
 	[AGGR_CACHE]	= 22,
+	[AGGR_CLUSTER]	= 20,
 	[AGGR_DIE] 	= 12,
 	[AGGR_SOCKET] 	= 6,
 	[AGGR_NODE] 	= 6,
@@ -49,6 +50,7 @@ static int aggr_header_lens[] = {
 static const char *aggr_header_csv[] = {
 	[AGGR_CORE] 	= 	"core%scpus%s",
 	[AGGR_CACHE]	= 	"cache%scpus%s",
+	[AGGR_CLUSTER]	= 	"cluster%scpus%s",
 	[AGGR_DIE] 	= 	"die%scpus%s",
 	[AGGR_SOCKET] 	= 	"socket%scpus%s",
 	[AGGR_NONE] 	= 	"cpu%s",
@@ -60,6 +62,7 @@ static const char *aggr_header_csv[] = {
 static int aggr_header_num[] = {
 	[AGGR_CORE] 	= 	2,
 	[AGGR_CACHE]	= 	2,
+	[AGGR_CLUSTER]	= 	2,
 	[AGGR_DIE] 	= 	2,
 	[AGGR_SOCKET] 	= 	2,
 	[AGGR_NONE] 	= 	1,
-- 
2.45.2.803.g4e1b14247a-goog

