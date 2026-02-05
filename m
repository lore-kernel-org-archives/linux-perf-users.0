Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5278F4A;
	Thu,  5 Feb 2026 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292022; cv=none; b=HC3LU5BtDq30sxUsPhxn5iBj/ofqyonm6drjSuyMe7T6WQ4XPMghymZVkFp9yoUEi4FqtZgX/vFwSWfJNFp5yCeVeSyUXVNZI6KQFbfo5TEIdljnbF8jLPcZIyU+rfidNjiRhMaSgvV2TX6OXoM9XKSaalMiW0BCpZRlByYRmks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292022; c=relaxed/simple;
	bh=XcqGgdvjX2aXI0wyu2WLiXCVUg8vTcbSwT5yWerg91Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nA9cKTT4oHlmp43uSNeW8tFUWNhQW/WROPezp8nUTfSxF4ibcmUJ/IvBsHXqrY08U2MDXXowtQiJRx96j3r2JQzbDtmFCs1BbJDwQEOxusdNxOubqogNFaK3ayE71lv2LAh4K1Ubv+bI0erU5mUEE3pzyo32x/y8uPp8RfioFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=s0I0GfRA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="s0I0GfRA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=HnPpbTNwkoyYRGgfr4kZh4Qh7P5Vq2UEa9UskL1ThFY=; b=s0I0GfRAJ0d425x7l8PqTuELIf
	0q6Nc1frU82M+UXyzGICG08qTC6SMYjb1Dg320z3lda5teLUA2XF/5DEosykK7eQPgCczE5GhFCfV
	VjBx77JNR0Mf0njIGliDWONGz5pXB+nbyMTn2AoZetRvn84oOF3uZQ9cosi1kZma8HMjOxSfc+0m8
	vaeNcSDChMOQJx0pk9quRTqswVHW4J2TRc8vIrJv19xxjmbAsrdjEfNsLYq8ia05lOqJVTo6e3fxW
	eUUIE9djoGNAnGU+yUbd4Om1AbqvSBcBktEgJpbGb0cwoad39NLO74WF52W7VDP4sw91zVvflDDeG
	vGvhKN0A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vnxop-006Ly3-TX; Thu, 05 Feb 2026 11:46:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 05 Feb 2026 03:46:31 -0800
Subject: [PATCH] perf stat: Fix crash on arm64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
X-B4-Tracking: v=1; b=H4sIABeDhGkC/yXMwQqCQBAG4FcZ/rML64QJ+yoRMW2jjgeTnTUC8
 d2jOn6Xb4drMXUk2lH0ZW7PBYnahpAnWUYN9kAicORz5NiFVctw8yo1SBSWU6/c5g4NYS062Pt
 3Xa5/+3afNddvgOP4AIXskGttAAAA
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
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=3706; i=leitao@debian.org;
 h=from:subject:message-id; bh=XcqGgdvjX2aXI0wyu2WLiXCVUg8vTcbSwT5yWerg91Y=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBphIMeG+Dsw4jKLZ+a3gkyv+M1gCPIZngABF9tx
 ZUygS7meS2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYSDHgAKCRA1o5Of/Hh3
 bS0PD/9FJdQwr/nOQDFyBMDyuGCTjhCgk/ITYjO/LqdrRuUIx+A99XRRqmE183iB6/M+uQmmqXA
 1BoAzH/GLpAMwH9hGaRHtUv+pE66Z0r3MIYGoDTFqaWuW8Nd0hCWNoDap2wEOpt144iLNRHZe0N
 W0YLS/es1pFqjfLmMsupy6chuCL8KaAwR1yVkgCN4ySyO9SE9yAGcrknpkgFLmLlr2PzRSsk/ax
 ys8Nz3uN7gv8TKAw9wUtNOnSE0Mx420b7rO7bdnepTOhR9it5Ip/p2hzDWeCcfUFIG6AQ+eTIp9
 LSr76JyW9inMiKwWb9hVCigRNQ2hCilzKFGLYHocwie+qhOVA+xyYWTJBge4SYHEbiiQ48uB6t/
 t3vaPIJqJwzq3SdFlRX+dXClEi21o/BT4yXZCTVJZ0SxvWIHlyKAdN+jA/9ETmqiLSuWipPScEF
 J//QMJ0cz2W0f9TvtNF9VUrKMpiowVc93/uUzjlAsM6DjEZ8IzR5Rk8X3pHxmHiOx/3ySiUcwM6
 4lL3dw3oQwoj6i7cp9Ly0LrPOKXYwy0474I8LvGdFAbqo4bkpOsJ0vO/psGZm0bazuCjL/HpU1G
 FiiEk18+hfg2rinnoATtv+9T8yNi6rgHY5H68uP7FDdNTdXwFfFLM+fYHGycBMol/ywSfXxVCGr
 zKMc5PMgWIxwohA==
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
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Cc; linux-arm-kernel@lists.infradead.org
---
 tools/perf/builtin-stat.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ab40d85fb1259..3a423ca31d8d3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1938,25 +1938,33 @@ static int default_evlist_evsel_cmp(void *priv __maybe_unused,
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
base-commit: 5fd0a1df5d05ad066e5618ccdd3d0fa6cb686c27
change-id: 20260205-perf_stat-a0a2a37e21c5

Best regards,
--  
Breno Leitao <leitao@debian.org>

