Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB752EBDD3;
	Tue, 18 Nov 2025 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447806; cv=none; b=qVQYu5ny5XcuF1H7pMTx3kN0RdZHv2WunkfURr1ci2hDW6TXbFYSR8Ur6g3QPVUHyH82fD82mIL0dKYRFz9+nwiC/Lm/faCv8IoKk4Vpf6l6PQj7CAMW710W9EbibfeKljCbusKj8bYlqeMPZtRvkC141Zj/Wc16liben6o45Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447806; c=relaxed/simple;
	bh=DlfTk+amN39mXZxQimGbXQGH5jUf0bdvLtPvcZDVxfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4MjAHcqqmY4CS1Lq/XAS5Of0nG3PgBgZ7vMjDmao7pANvPukLtiGz0U45l2zCotUbZUj4+POwLKd2BiSm9AE6j+wQVJhpeSKrhvYP6LgZj/csSl8fiP2tBL3DSxEL6SGvpCM3kL1N6GUFw/ggj2nIJtZ1aevADxJCgDCleQV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhNhBg/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhNhBg/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057BAC2BCAF;
	Tue, 18 Nov 2025 06:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763447806;
	bh=DlfTk+amN39mXZxQimGbXQGH5jUf0bdvLtPvcZDVxfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhNhBg/1ihljIYLDSaRUaKUT/hh4SNOd33cPtwwbK2ObEpRodJaNQb6p4nCCrzrsW
	 yeNi+/uM7KgjLgYFWFsB+XbedjuTSUT7dnfO0+0JmZ5xoXWUTlXNRKHMY2vhDdTgE7
	 SFlALQSegeJFHlTzWJPUaeOcLcpcj2iQzM1KPbSo4+GVwSfzfRPf58h7Vu1bBZkFfk
	 G2Kdsx+eoaGVqDzLhfUjDHPNqElPicgtxDP/Id9KRLypho+WYM33OSKza4x3Xt2+EB
	 ULnuwu20YbmzMx8hbg1mFxRY/CibNGE2Vc9mR8PB+IVOwDfp2ZOg02agvlm55LODtW
	 ZEiCN0wXzh6JA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf list: Support filtering in JSON output
Date: Mon, 17 Nov 2025 22:36:41 -0800
Message-ID: <20251118063641.517066-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251118063641.517066-1-namhyung@kernel.org>
References: <20251118063641.517066-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like regular output mode, it should honor command line arguments to
limit to a certain type of PMUs or events.

  $ perf list -j hw
  [
  {
          "Unit": "cpu",
          "Topic": "legacy hardware",
          "EventName": "branch-instructions",
          "EventType": "Kernel PMU event",
          "BriefDescription": "Retired branch instructions [This event is an alias of branches]",
          "Encoding": "cpu/event=0xc4\n/"
  },
  {
          "Unit": "cpu",
          "Topic": "legacy hardware",
          "EventName": "branch-misses",
          "EventType": "Kernel PMU event",
          "BriefDescription": "Mispredicted branch instructions",
          "Encoding": "cpu/event=0xc5\n/"
  },
  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-list.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 1ab969ffe371c5cb..48c799007414bf6e 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -375,6 +375,21 @@ static void json_print_event(void *ps, const char *topic,
 	FILE *fp = print_state->fp;
 	struct strbuf buf;
 
+	if (deprecated && !print_state->deprecated)
+		return;
+
+	if (print_state->pmu_glob && (!pmu_name || !strglobmatch(pmu_name, print_state->pmu_glob)))
+		return;
+
+	if (print_state->exclude_abi && pmu_type < PERF_TYPE_MAX && pmu_type != PERF_TYPE_RAW)
+		return;
+
+	if (print_state->event_glob &&
+	    (!event_name || !strglobmatch(event_name, print_state->event_glob)) &&
+	    (!event_alias || !strglobmatch(event_alias, print_state->event_glob)) &&
+	    (!topic || !strglobmatch_nocase(topic, print_state->event_glob)))
+		return;
+
 	strbuf_init(&buf, 0);
 	fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
 	print_state->need_sep = true;
@@ -451,6 +466,11 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 	FILE *fp = print_state->fp;
 	struct strbuf buf;
 
+	if (print_state->event_glob &&
+	    (!print_state->metrics || !name || !strglobmatch(name, print_state->event_glob)) &&
+	    (!print_state->metricgroups || !group || !strglobmatch(group, print_state->event_glob)))
+		return;
+
 	strbuf_init(&buf, 0);
 	fprintf(fp, "%s{\n", print_state->need_sep ? ",\n" : "");
 	print_state->need_sep = true;
-- 
2.52.0.rc1.455.g30608eb744-goog

