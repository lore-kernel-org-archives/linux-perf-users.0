Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4093FBB6F;
	Fri,  5 Jun 2026 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701118; cv=none; b=bd9qKbCVtZRM7hu082sgXVKtP6uCnocKY+U+LTP75qe2Ih8tmfdP491UiqFrmXe4/j7d7lVqm9lh+9JG3LL6uWRtAXKmnaPIywtqJO67yDM5kZS2hBIYEpopaGRRtzFf0+NvhFbgVpsNrNeZcXS5bUUMsWoTeUeGGbjqZjTklO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701118; c=relaxed/simple;
	bh=Lqlmcsk5Lgf5Xs/v38e+14b+p32qOTDIWKOvSddURWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGjRV89fLbhdCbJHGVwTy2SAOMf1nY3onM50a6ZU6Q5sKVzs9nKF+tsi3XuW4FJXK+ilRkSZvZnYiM1qB8YGKYinasArAWJ2kEx+jHhWjGVmnFeo7kZ7Nalt3rNhFsz8c3Dsd0EEvqBb5mRw8uzZdLKD+78V8szTmI6BcLPCxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcN+oB3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcN+oB3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38D31F00898;
	Fri,  5 Jun 2026 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701117;
	bh=6pXxrcFAudnc6PlL7iAOib1DFz07jJcwVVd648vjHxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcN+oB3oujF3+2IgpZNfkoS/vFVJF6AzxUvVZD0NwLhjlBJwx6mroZcTDznlpWZor
	 U0d7AIYTAjufrd5T3Ys80tadnkf5l1YUXukfBCfHq+kSBJxffAyFuJSKv3D2U+liwc
	 uCLQ8jyifK4rjefmkT/vRNSflC31+0vcLTXwC3oLV8KP4DYuYvT6vnJ8GTDLYxTnyJ
	 d/KjhUOTbL0xFBQmZJ7RHy3WhMgWbtEm3g5tbLvyWCF58gLD/IfmFdmVzpUYbOnmLC
	 +tg+LrOmwfSGS4mJwgSO2oiZuX7nkO+gW+nZAV0+69qTsnE+LP+OGCZkg7xDnjS6/P
	 gyhJJxP5KDfzw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/4] perf timechart: Fix memory leaks in draw_wakeups()
Date: Fri,  5 Jun 2026 16:11:54 -0700
Message-ID: <20260605231155.2415760-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605231155.2415760-1-namhyung@kernel.org>
References: <20260605231155.2415760-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second loop for per_pidcommd is meaningful only when it doesn't have
from and to tasks.  Also make sure c->Y is set before copying the comm
string otherwise it will be overwritten by next one.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index d56adb41dcf9bb69..e8d01c8723959e80 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1110,12 +1110,12 @@ static void draw_wakeups(struct timechart *tchart)
 					c = c->next;
 				}
 				c = p->all;
-				while (c) {
-					if (p->pid == we->waker && !from) {
+				while (c && !from && !to) {
+					if (c->Y && p->pid == we->waker && !from) {
 						from = c->Y;
 						task_from = strdup(c->comm);
 					}
-					if (p->pid == we->wakee && !to) {
+					if (c->Y && p->pid == we->wakee && !to) {
 						to = c->Y;
 						task_to = strdup(c->comm);
 					}
-- 
2.54.0.1032.g2f8565e1d1-goog

