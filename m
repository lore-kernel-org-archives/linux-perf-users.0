Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0893939DF;
	Wed, 25 Mar 2026 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774434301; cv=none; b=FMH7AdMYtB+iDl3stkYG83vb25IGzAjQFClosvEJyl3cmACGCvSYw3pZfx5ql17e8MBtdFzIDAHJ7vNeNaDEWlXZbJUCXskXFy2jaPrSiA+qHyCG7ghel30VbzrlHM+fZXmidzOEgeoTaDpJdsz+LlAsiDRLxs5DvlnmvdQ3nn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774434301; c=relaxed/simple;
	bh=c+qH9vBJ7Cy1tr9tNvd+WKnja75AJUV1J2eiRMmVjUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qHhG4KLZ4YNvHGYjJmDK2YDMc3+zxBvek9ceZUcGMklg8Cvbq8mq8/CEMkIJXhggBc9eF6OGcVXcuXgxb7Lhy3RR9F7e43P5l8qpn9P3AapPXF5ooOYfqDHqJkbZxMivnZ1C8n7ll4yhkZ6k74I3V/6+WlAPXf8XbREzhgObfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cBOMBT4v; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cBOMBT4v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=CmHtMiAdLNN40FHGoEYbgu4STZYHNCDu0t499ydvFM0=; b=cBOMBT4vfd6O7SzyuDsY6kK+1U
	p6Fsfpbc7KV2XJXIE5ViBi1pfkNPnDP5OdOgmAeQlO6XNTo/kZroHibLM051m/7kCsyNMGRyeId2G
	Sv/ctKtD3lsrYve0GUCl8tzqbyAn027m5lkoPpZoTsqflmgVAk+XNpHh0T9tK1bY10ump2POtroCH
	HRl9GMHmwicJQ/TDGqcUwV/I44W0vLlVGsF/wE65j0e/c/z/4YOQRA2OiTy9qx8+hIShEEVgTm3Co
	AOo1//ZsCAald/Ew3yR6/keGqfw4KXVtq9t+aLaagLspbFXS7ox5tHrOnJjsxZQf13C6L8Rq87r18
	Mr9Ip6/Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w5LPs-0090ZB-E4; Wed, 25 Mar 2026 10:24:48 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 25 Mar 2026 03:24:30 -0700
Subject: [PATCH v2] perf stat: Fix crash on arm64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
X-B4-Tracking: v=1; b=H4sIAN63w2kC/23Nyw6CMBCF4VdpZk1NL+KFle9hiJmWAcYFkLYSD
 em7m+LW5Un+fGeDSIEpQiM2CLRy5HmCRphKgB9xGkhyB40Ao8xJGVXLhUL/iAmTRIUG7ZmM9jV
 UApZAPb93697+dny5J/lUgFKMHNMcPvvZqkv3z1211JKO1jrlr/qC/a0jxzgd5jBAm3P+AmmPQ
 G+1AAAA
X-Change-ID: 20260205-perf_stat-a0a2a37e21c5
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>, 
 Dmitry Ilvokhin <d@ilvokhin.com>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3920; i=leitao@debian.org;
 h=from:subject:message-id; bh=c+qH9vBJ7Cy1tr9tNvd+WKnja75AJUV1J2eiRMmVjUc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpw7fq5arMfCrdAU6ifZp9sPmnoExAKkuR5rhnh
 M7UowNzspmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCacO36gAKCRA1o5Of/Hh3
 bQpvD/9wCyo8lbqFOePa+d/AIHj6723FtpOx54P2Wbrr8pOF/Jpwxc8CJ3X9Tn5wKJylon4c4HN
 lQZFawWlGRtV493EydXoxbT/hQbyf99zwHBVKLAkiY2b7qYMutOXZsVU9cYDKF/VmhxkumzJG3N
 ROq3C5dO5QimHlBZq9D+B2C6OB6D3+1IBkjxRzXIap9KAMaUU4HO2qJDtBYizF8AB+3pZ+6aenu
 aCqMiYr2RJf8j4agxEYdUKNgp/3X4t7lrSPq+hnny7F3P+ioFEsJ80JRJgzgIow6+L15uuuBsuq
 D1nwJA4tiJWIhlKQmYbNki6muFbEXoUQS4WPLsW96PMMCqWPZXGYv/nxjz87pc3NzGNIAAK4QmK
 puM353bm8OU3taFfmQwtisMHSy/Is73g5dlUppNvkBDeYSAog8GiYWjWErp/LXXIsJhAVA7VxWh
 ImZ3Y22KC+5vyrs2wmoTf+mf+uWAR07E7vQ5KGGIk3nXrnAdEpjOQyHf4NMZ6r4aPgGWH0rphaE
 zh2OqsgrOzQ2TBdpXHAgERYNsAsJfFbd5luXSLx+GlMBmDnozMiNrpURaeORFGLp3VxtRmC/mPE
 CIh6D71l6gPYVti14Mr3bzYqLOboNXuMcjBAfvTH966/54UQNUNmIkxTTMS4cN9q8hROOCqJ+o/
 Xks6Id/AOJwtcsw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Perf stat is crashing on arm64 hosts with the following issue:

	# make -C tools/perf DEBUG=1
	# perf stat sleep 1
	perf: util/evsel.c:2034: get_group_fd: Assertion `!(!leader->core.fd)' failed.
	[1]    1220794 IOT instruction (core dumped)  ./perf stat

The sorting function introduced by commit a745c0831c15c ("perf stat:
Sort default events/metrics") compares events based on their individual
properties. This can cause events from different groups to be
interleaved, resulting in group members appearing before their leaders
in the sorted evlist.

When the iterator opens events in list order, a group member may be
processed before its leader has been opened.

For example, CPU_CYCLES (idx=32) with leader STALL_SLOT_BACKEND (idx=37)
could be sorted before its leader, causing the crash when CPU_CYCLES
tries to get its group fd from the not-yet-opened leader.

Fix this by comparing events based on their leader's attributes instead
of their own attributes when the events are in different groups. This
ensures all members of a group share the same sort key as their leader,
keeping groups together and guaranteeing leaders are opened before their
members.

Reported-by: Denis Yaroshevskiy <dyaroshev@meta.com>
Fixes: a745c0831c15c ("perf stat: Sort default events/metrics")
Tested-by: Dmitry Ilvokhin <d@ilvokhin.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Cc; linux-arm-kernel@lists.infradead.org
---
Changes in v2:
- No changes from V1, just resending the exact same patch.
- Link to v1: https://patch.msgid.link/20260205-perf_stat-v1-1-e433b0c918af@debian.org
---
 tools/perf/builtin-stat.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 73c2ba7e30760..a97b9d0de3f58 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1917,25 +1917,33 @@ static int default_evlist_evsel_cmp(void *priv __maybe_unused,
 	const struct evsel *lhs = container_of(lhs_core, struct evsel, core);
 	const struct perf_evsel *rhs_core = container_of(r, struct perf_evsel, node);
 	const struct evsel *rhs = container_of(rhs_core, struct evsel, core);
+	const struct evsel *lhs_leader = evsel__leader(lhs);
+	const struct evsel *rhs_leader = evsel__leader(rhs);
 
-	if (evsel__leader(lhs) == evsel__leader(rhs)) {
+	if (lhs_leader == rhs_leader) {
 		/* Within the same group, respect the original order. */
 		return lhs_core->idx - rhs_core->idx;
 	}
 
+	/*
+	 * Compare using leader's attributes so that all members of a group
+	 * stay together. This ensures leaders are opened before their members.
+	 */
+
 	/* Sort default metrics evsels first, and default show events before those. */
-	if (lhs->default_metricgroup != rhs->default_metricgroup)
-		return lhs->default_metricgroup ? -1 : 1;
+	if (lhs_leader->default_metricgroup != rhs_leader->default_metricgroup)
+		return lhs_leader->default_metricgroup ? -1 : 1;
 
-	if (lhs->default_show_events != rhs->default_show_events)
-		return lhs->default_show_events ? -1 : 1;
+	if (lhs_leader->default_show_events != rhs_leader->default_show_events)
+		return lhs_leader->default_show_events ? -1 : 1;
 
 	/* Sort by PMU type (prefers legacy types first). */
-	if (lhs->pmu != rhs->pmu)
-		return lhs->pmu->type - rhs->pmu->type;
+	if (lhs_leader->pmu != rhs_leader->pmu)
+		return lhs_leader->pmu->type - rhs_leader->pmu->type;
 
-	/* Sort by name. */
-	return strcmp(evsel__name((struct evsel *)lhs), evsel__name((struct evsel *)rhs));
+	/* Sort by leader's name. */
+	return strcmp(evsel__name((struct evsel *)lhs_leader),
+		      evsel__name((struct evsel *)rhs_leader));
 }
 
 /*

---
base-commit: 85964cdcad0fac9a0eb7b87a0f9d88cc074b854c
change-id: 20260205-perf_stat-a0a2a37e21c5

Best regards,
--  
Breno Leitao <leitao@debian.org>

