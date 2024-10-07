Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811EE1D6182;
	Mon,  7 Oct 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310298; cv=none; b=Dwnutfc6f1sTqCQgkTR+/P+CBgUMFpPe3nJcqggmSc7ev5c1XJ49B+OA3t4xyXpz/a6RZaw6JQQfwAbWCUoTRynnlDfGy+RDb+rn+nsp32ROsntFiumFqtGMuNDatdKTm8aydtKp0I5muKdlgVe5lt+ukFG+/Oy8+z+znViGe60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310298; c=relaxed/simple;
	bh=HvUNDL8dAP+7s0rvV3MlShaHb15zvas9haBDEv5Ov9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KBsQRpa4BFQBcNoyCf62M6n2pZLggu6aURmbsjqxThiYsDo9IrkPxlssL3nmlE9Kjj1PJ3/H5JB/XjfRRs89qIibVeHzTBstIQhwIOd+dIpOsua4D2VntNhnLOIxp40DaXU92+LC1Ord2kz8GuuOLbWOGFmXmhHVvPKENNrE6Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 706C2FEC;
	Mon,  7 Oct 2024 07:12:05 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 03DAD3F64C;
	Mon,  7 Oct 2024 07:11:33 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Dima Kogan <dima@secretsauce.net>,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 1/3] perf: Dynamically allocate buffer for event string
Date: Mon,  7 Oct 2024 15:11:14 +0100
Message-Id: <20241007141116.882450-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007141116.882450-1-leo.yan@arm.com>
References: <20241007141116.882450-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamically allocate and free buffer to support event name.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/probe-event.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a17c9b8a7a79..cad11d95af4f 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2834,6 +2834,9 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
 	free(buf);
 }
 
+/* Defined in kernel/trace/trace.h */
+#define MAX_EVENT_NAME_LEN	64
+
 /* Set new name from original perf_probe_event and namelist */
 static int probe_trace_event__set_name(struct probe_trace_event *tev,
 				       struct perf_probe_event *pev,
@@ -2841,9 +2844,13 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 				       bool allow_suffix)
 {
 	const char *event, *group;
-	char buf[64];
+	char *buf;
 	int ret;
 
+	buf = malloc(MAX_EVENT_NAME_LEN);
+	if (!buf)
+		return -ENOMEM;
+
 	/* If probe_event or trace_event already have the name, reuse it */
 	if (pev->event && !pev->sdt)
 		event = pev->event;
@@ -2866,17 +2873,19 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 		group = PERFPROBE_GROUP;
 
 	/* Get an unused new event name */
-	ret = get_new_event_name(buf, sizeof(buf), event, namelist,
+	ret = get_new_event_name(buf, MAX_EVENT_NAME_LEN, event, namelist,
 				 tev->point.retprobe, allow_suffix);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	event = buf;
 
 	tev->event = strdup(event);
 	tev->group = strdup(group);
-	if (tev->event == NULL || tev->group == NULL)
-		return -ENOMEM;
+	if (tev->event == NULL || tev->group == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	/*
 	 * Add new event name to namelist if multiprobe event is NOT
@@ -2885,7 +2894,10 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 	 */
 	if (!multiprobe_event_is_supported())
 		strlist__add(namelist, event);
-	return 0;
+
+out:
+	free(buf);
+	return ret < 0 ? ret : 0;
 }
 
 static int __open_probe_file_and_namelist(bool uprobe,
-- 
2.34.1

