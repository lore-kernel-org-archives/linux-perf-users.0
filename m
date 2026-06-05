Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1136F903;
	Fri,  5 Jun 2026 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703494; cv=none; b=ghSCL5kWWFdNfDlELajEMSlIznn++UrnJ2AsqpkPj7oyX8tozEDhq3xH5NjoJSGxDpx8sLULH0SxqaRq/i99MbYm/95MvlXtSzy9XrO8RCb3NPihLLs8Ycx/XAhGDQb7CF2Trfg7VQt+T9ihmKEHNuIG/yG3sEZN1gstz4Jey4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703494; c=relaxed/simple;
	bh=pb/LBh5xXsHZVp2i+HG5TnZasum53aJ6yY1408iX7sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC/8lFrMUTy9ZEp4tFgdhDXpIwMgjRFdWhr6Le7D2KsmQ10YE3d6kqk5Y8XXWHUhxqWbc4J0BfAf4GZ+rZS+M15Fr8Jw4K+hIrmRcXD1N1pel1VeiwY0hYMcqylaSFvmS34HGEIXSD56ye5zmk+ziAh3XTk1nQGEwoFo/yYT2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWGkb0pS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWGkb0pS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271151F0089B;
	Fri,  5 Jun 2026 23:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780703493;
	bh=wZQaDS0K02xGerco7f1cxzy/n2Ou+5DVBEqgxI0HPeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jWGkb0pSCY7upgHxkvX8VbInLupjms3YNCgienIoBpaEo0e3VUPLCiq0U29+Azijp
	 UlYdFnyNAHfIoIUMbPiFLtJjd7rYHu/3uFNeda6cG1ThFNpvjxGgfT2gY8kgc++X4/
	 lc6cNun3SGevuHSGn09zuzdkhieBsWrfYls+cx5faS73KhrL89xhce5st0y/+i8VSt
	 pEp5RfNYvdn7tC6tdaqkrTNpGNrFVftSZvIEAs+esZuhdyEQz+5Tg+ua15b2DTD5BP
	 9Ol3Gs5357iaTjVHXnRjttoHT8lVvn61WZ8q/OildwGpcmPDzzLtnNNTx3nsZBbHye
	 Mz/tBI/s5Y7Uw==
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
Subject: [PATCH v2 3/4] perf timechart: Fix memory leaks in draw_wakeups()
Date: Fri,  5 Jun 2026 16:51:30 -0700
Message-ID: <20260605235131.2440270-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605235131.2440270-1-namhyung@kernel.org>
References: <20260605235131.2440270-1-namhyung@kernel.org>
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
index a73f0ab22fd64241..3f9153d5ecfb79b0 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1110,12 +1110,12 @@ static void draw_wakeups(struct timechart *tchart)
 					c = c->next;
 				}
 				c = p->all;
-				while (c) {
-					if (p->pid == we->waker && !from) {
+				while (c && (!from || !to)) {
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

