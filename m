Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9853E16AE;
	Wed, 24 Jun 2026 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334746; cv=none; b=WVfHthtGOvpLfsa835pfZ0AatELqmGH147JynIFUCU1XxqCDvzZU3n4twkHjLpdc/zHdL+FuoTxw5oQ8X1UYJ6vHUEEITMUtL2o+Ltbn7p02CLM8nzGoWaJJXwfPH0qlX67vsV73Cw1lzANIgew+PGX5jDJ5t166OdHEDJl4awo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334746; c=relaxed/simple;
	bh=S2PYHGGRaBbOs9pq3lKeXNMdVjfJ9TwbB1YaW80/l0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfVad4+OqWKhQDy5gWHb7dloldDK+cMkYRPDYjOWxtQ1Dbmg0B/ckMGSBSMyLTIYH+g37JvpyFW9hvQhtuPvGFeI4DH/ql/W1XbKQNkpF5v60fsBUm1z6OhrPkyCBvzBy0vEzEJvLU3324h9Bq/ocoh5lpPUt44A2DpvwH7EVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFOkK8Ct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFOkK8Ct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD641F00ADE;
	Wed, 24 Jun 2026 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782334745;
	bh=3Q0PuIc/8l5trbmH6rUsl68kH29MwVMf0g8M9yVESME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eFOkK8CtArWATo70GMYCyM2of6dVkwdjdwU9O5n/z0J2SM4m8m+NNhAvjCVMblXe0
	 jLiQ22ZVGoeEvbQqC5DJoj+piKUQY0q9cVtT7G9M6bmQfnTDiBzeTPWiZtS6UQRvIh
	 I28iOq0sqtut/NBvDCmYFUtAEG+VG1onduti3H235q3njP+5Uf7NRNnG9cPQtwXFyV
	 z4QMmeUuW0k9nxzSywZ9+ZoVFczWOV4z3iMNqjqTbjhSegi/pSpNz7mWTG7FSgiFCh
	 8HCJkKGjhR40nC6nmJjxu0DxaIPgpUBgcTo4kbcanXjoK37TYjKlxgdZYMKTeR8Bd/
	 IUSKo0X9gOZzg==
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
Subject: [PATCH v3 7/8] perf timechart: Fix memory leaks in draw_wakeups()
Date: Wed, 24 Jun 2026 13:58:33 -0700
Message-ID: <20260624205852.3864874-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260624205852.3864874-1-namhyung@kernel.org>
References: <20260624205852.3864874-1-namhyung@kernel.org>
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
2.55.0.rc0.799.gd6f94ed593-goog

