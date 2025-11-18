Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438872EA46B;
	Tue, 18 Nov 2025 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447805; cv=none; b=Y0J0ZpRD9fTtHpEN0yu5l67GXYVSaGCmcbkBZQh1775qScX6HxTulyHpq4diQ/nt/OnBABxgx8zWUAw/ZLkPcqRB8WVNRhmB7u5xCxAdC7AwyvQVUcYBvcMYI9noKMfMyuMT8J7Oy7ZhURIbXta/pU0/AO/9WwkzXMhW++2jid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447805; c=relaxed/simple;
	bh=Tj4TMLi/TFXX0IVZ9BmNxwMdy8d67QlbdBW4OboKNQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNATdtKwbZcMSJ3YObNbxefX9Lkma5vllAMNukBSjkivnO5nw6wMr1tHw4dyun5ZTDWrbieEv7FPlh157waSgbjygHld5LkGjp7bdEvCZcE/MJDENk66PzvE/xaMeVxMtp8zrpz2F94Ot5rWaVBMTQuwbOgiIw0xKxOwrX+YFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0aYJa+N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0aYJa+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC171C19424;
	Tue, 18 Nov 2025 06:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763447804;
	bh=Tj4TMLi/TFXX0IVZ9BmNxwMdy8d67QlbdBW4OboKNQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0aYJa+N/AtxG8d3UW6l5jMzzzeFP9VbtuNkhIKDxfoM4j+dhTrjYA9C1kJlUe7cO
	 R3YpIgl8yI6S9BdQacJ/PomaXsnd7BXQWVObO9vfWlHCxkkm1wyrgNQQEkx5BbYmTZ
	 2M3yH5BQmrIjwJa1txPBm/jhhE9T1o1WVSCnlvbFi7Ddc+pTLHP1qCR/7hzIHCs+FV
	 QEB02YS6diIeEdf043hTqTsYQWYjd2r/TjMxpCgKQsYKZ4aJwzRllM2PFwgLPg5sY7
	 Lh5elbxjQxO+99T8p0eO9hbGGbaAF/ePiWabEczPiVm0/jXgG1rnqpf37ioZp7l2dU
	 PQ26rVGMZSsKg==
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
Subject: [PATCH 2/3] perf list: Get rid of json_print_state
Date: Mon, 17 Nov 2025 22:36:40 -0800
Message-ID: <20251118063641.517066-2-namhyung@kernel.org>
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

The JSON print state has only one different field (need_sep).  Let's
move it to the default print state and use it.  It would waste a little
bit of more spaces but who cares? :)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-list.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 28bf1fc7f5eeff8f..1ab969ffe371c5cb 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -60,6 +60,8 @@ struct print_state {
 	bool metricgroups;
 	/** @exclude_abi: Exclude PMUs with types less than PERF_TYPE_MAX except PERF_TYPE_RAW. */
 	bool exclude_abi;
+	/** @need_sep: Should a separator be printed prior to the next item? (for JSON) */
+	bool need_sep;
 	/** @last_topic: The last printed event topic. */
 	char *last_topic;
 	/** @last_metricgroups: The last printed metric group. */
@@ -368,7 +370,7 @@ static void json_print_event(void *ps, const char *topic,
 			     const char *desc, const char *long_desc,
 			     const char *encoding_desc)
 {
-	struct json_print_state *print_state = ps;
+	struct print_state *print_state = ps;
 	bool need_sep = false;
 	FILE *fp = print_state->fp;
 	struct strbuf buf;
@@ -444,7 +446,7 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 			      const char *threshold, const char *unit,
 			      const char *pmu_name)
 {
-	struct json_print_state *print_state = ps;
+	struct print_state *print_state = ps;
 	bool need_sep = false;
 	FILE *fp = print_state->fp;
 	struct strbuf buf;
@@ -521,9 +523,6 @@ int cmd_list(int argc, const char **argv)
 		.fp = stdout,
 		.desc = true,
 	};
-	struct print_state json_ps = {
-		.fp = stdout,
-	};
 	void *ps = &default_ps;
 	struct print_callbacks print_cb = {
 		.print_start = default_print_start,
@@ -574,7 +573,6 @@ int cmd_list(int argc, const char **argv)
 
 	if (output_path) {
 		default_ps.fp = fopen(output_path, "w");
-		json_ps.fp = default_ps.fp;
 	}
 
 	setup_pager();
@@ -590,7 +588,7 @@ int cmd_list(int argc, const char **argv)
 			.print_metric = json_print_metric,
 			.skip_duplicate_pmus = json_skip_duplicate_pmus,
 		};
-		ps = &json_ps;
+		ps = &default_ps;
 	} else {
 		default_ps.last_topic = strdup("");
 		assert(default_ps.last_topic);
-- 
2.52.0.rc1.455.g30608eb744-goog

