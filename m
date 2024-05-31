Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD0115B96F
	for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184696; cv=none; b=NA7RMz9DcVLJGB9+Ivfv5WM3a1sWZsa/IUIN25JzYtBOy0my35yZBX1SF0NHGrnGdcGtmp9acgyb4d8OrOXUEMFh5cQu0aYjph/GlEOcJlxm8CeqzGVDsHG43tcGfAXbHbCBV7kbQmsTeGg6i1awi7wxr+rJfwfKwwtqzB7lP4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184696; c=relaxed/simple;
	bh=8PrxyWUH9fm9mbQmyfkGe3AkrOAkW1YHEwLyumeegnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZcCoYrU16iVZW/VLbxfQfN56fsNBSCAHvYzDQy4UeWQ4CkxELxNMaNK8XSqcepQ5nJeDFUVwWOOZXy1/zuELImoe/2ZcUv/TiVgkG0kNjHyUKSVXdrih6qczRoWLId9pBM8bsSAV75z+AQ4+CQU5wOkFnU0kYbQw1bVY/XEQiHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sD8Ai-0004nS-Gz; Fri, 31 May 2024 21:44:16 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sD8Ah-003liF-27; Fri, 31 May 2024 21:44:15 +0200
From: Lucas Stach <l.stach@pengutronix.de>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH] perf jevents: return potentially empty metrics table
Date: Fri, 31 May 2024 21:44:14 +0200
Message-Id: <20240531194414.1849270-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-perf-users@vger.kernel.org

Don't return NULL when a empty (num_pmus = 0) metrics table is encountered,
as this causes many of the users to bail out, which will skip matching any
potentially existing sys metrics later on. Instead return the empty table
which will be handled properly by the iterators and allows matching to
continue.

This fixes metrics reporting on systems where only the sys, but not the
core PMUs have metrics defined.

Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a PMU")
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e42efc16723e..0a1ed9ee1429 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1081,7 +1081,7 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
         if (!map)
                 return NULL;
 
-        if (!pmu)
+        if (!pmu || !map->metric_table.num_pmus)
                 return &map->metric_table;
 
         for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
-- 
2.39.2

