Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDA19CC0A;
	Tue,  6 May 2025 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570196; cv=none; b=U7ZDw59vXqRGe/J/yAXj/GZOScklF5zB9AQGV7YUpkIyFHVvJY/C7OvGksagDrCvebvveKfnBN/AmZUTaN3+AMoBFN9qIc9vTwXzsWYdf0G95ca2KZ8b8O2O4AZbHHTaJx4OYPeHFr/Wa3XfP0x8dw6+I3MTOhk0l4Dg6CyBUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570196; c=relaxed/simple;
	bh=f1gO89ZL0d09uTyydG+ftfXz/arjsSP+Bz8x9XEJr1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mt2hVlmJ/DONV5meGRRAvG0xtfNqBtgewCaF9xxLq/SaAPheNTF7ldkQv3oLhnspvnT1CyDVCZpzjiUO+jyJcNvd4Qsasb7bKtKoW6oLSAI5kekI+FVLFVAPGDAqpOFLK9UvkCVZrT9zVuVWy0Zu4DvT9Yrdiu+dcV6OBts8LB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJfTAUpf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJfTAUpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3254C4CEEE;
	Tue,  6 May 2025 22:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746570195;
	bh=f1gO89ZL0d09uTyydG+ftfXz/arjsSP+Bz8x9XEJr1k=;
	h=From:To:Cc:Subject:Date:From;
	b=QJfTAUpflarLtLnstEkEJww3t3htDaKpBoYxUW/LNLiDCZJuBRfWJzF10g+SBMg2+
	 TQT/kMPqulr2jswYhZXG/rJg8cTsQaN0BDtFpUJwquneOrJIRv13hQnDR9aa2XgZj0
	 XiFGGI0ehqahDSWoeCo4/ve13BULTEXVM0etQfEkPn3NQxaQ+I2A9LKM7jPYR0DgJG
	 P+xvY+90uY35WpGDMw5ZzQi8Q9keonIpRwKZTnL/wUza1J84wsGkILQ3lU+IQS38UM
	 tEMiLTgXw9OgH+ASt2MoFWIDH8PU0pZDTktBGykpg1z8xZjJb8gnPFeY6CvzuYMR/9
	 3rzJikUVyHmBg==
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
Subject: [PATCH] perf pmu: Consider raw events as legacy events
Date: Tue,  6 May 2025 15:23:12 -0700
Message-ID: <20250506222312.1125082-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When it finds a matching pmu for a legacy event, it should look for
core pmus.  The raw events also refers to core events so it should be
handled together.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/pmus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b99292de76693dbb..0134321fc520b1fc 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -726,7 +726,8 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 	pmu = perf_pmus__find_by_type(evsel->core.attr.type);
 	legacy_core_type =
 		evsel->core.attr.type == PERF_TYPE_HARDWARE ||
-		evsel->core.attr.type == PERF_TYPE_HW_CACHE;
+		evsel->core.attr.type == PERF_TYPE_HW_CACHE ||
+		evsel->core.attr.type == PERF_TYPE_RAW;
 	if (!pmu && legacy_core_type) {
 		if (perf_pmus__supports_extended_type()) {
 			u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
-- 
2.49.0.987.g0cc8ee98dc-goog

