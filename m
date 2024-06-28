Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2E28EA;
	Fri, 28 Jun 2024 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533165; cv=none; b=jDqphyv1sJkMV2nNsQb1t11JTGAqngJ0k8wN420K2d9I6a9mdvktwFlp4rrP2UXFkc9HlY9bmrHOmMrq2ZWPQTH9Ce15jeMej5x7CyM6lPK/+NgYt4LjPkdB6ltVcK8DCrL+WV9T1iRFV+Qk+xwcKxARthtLC4BMx0hvfNQQHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533165; c=relaxed/simple;
	bh=Xnc0KnqpcWwnpm5ZeJpJChJu9NgyORD56jPFuj9dkIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/BF7CMsaMmd46i6FeeU+fKSlGUOmbAGxWRxfQ5vp2gnNzgy7T02xwEYsXzvhjK5f0s9M8Fri9AzCS9x05rew8c5oA0O/AgXW4V2dqccjdY5hlIVW69bWTLHkzy3tWpaSnK+DO0wbXZH0dAto1OaYdw3ra2CxYKX+V4xRTjEBiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2zCw4N6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2zCw4N6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB67C2BBFC;
	Fri, 28 Jun 2024 00:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719533165;
	bh=Xnc0KnqpcWwnpm5ZeJpJChJu9NgyORD56jPFuj9dkIg=;
	h=From:To:Cc:Subject:Date:From;
	b=U2zCw4N62fMF0F//5yGIuu/Su+CfoaTc7jDF9vRb1UOKytWsaYeL3JA0FhnZHq2Uv
	 uOJx8j46JO74uG8NmV2Ho1iyWwPRnRkvK+fp0w8VvOAa8RVNg5QDJYwe5ZqPl6bpBb
	 Yt5bpqS7Pao/h1yeVCTyepKYG0spATh3wjTb0mZh9tMh25KU6tjfXzB7nfrHgkzSlk
	 tSNDnjOaigpSQVO12RrIPNNH6f7QnIOu/K7QTlmECjMiWIHWL047nNu+vO/zbc0m/7
	 d8xuqmG5o+JWWF2BB/vuxvzAXZVbtMOHuUQj0GRpU+ktEd3x8Zu00BTPpvsqXP711i
	 WaCqcQK/bJVqg==
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
Subject: [PATCH v2 1/2] perf stat: Fix a segfault with --per-cluster --metric-only
Date: Thu, 27 Jun 2024 17:06:03 -0700
Message-ID: <20240628000604.1296808-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
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
index 91d2f7f65df7..186305fd2d0e 100644
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
 	[AGGR_CORE] 	= 	"core,cpus,",
 	[AGGR_CACHE]	= 	"cache,cpus,",
+	[AGGR_CLUSTER]	= 	"cluster,cpus,",
 	[AGGR_DIE] 	= 	"die,cpus,",
 	[AGGR_SOCKET] 	= 	"socket,cpus,",
 	[AGGR_NONE] 	= 	"cpu,",
@@ -60,6 +62,7 @@ static const char *aggr_header_csv[] = {
 static const char *aggr_header_std[] = {
 	[AGGR_CORE] 	= 	"core",
 	[AGGR_CACHE] 	= 	"cache",
+	[AGGR_CLUSTER]	= 	"cluster",
 	[AGGR_DIE] 	= 	"die",
 	[AGGR_SOCKET] 	= 	"socket",
 	[AGGR_NONE] 	= 	"cpu",
-- 
2.45.2.803.g4e1b14247a-goog

