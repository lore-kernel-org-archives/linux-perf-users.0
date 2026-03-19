Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C440710D
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958344; cv=none; b=V3o9R2vBkRpsTkBPQ/Z1zt//zWygxmzn77l2cqEVH931+qKvgjZgHtcJng/6ict5+EurKD1Wvwe0oB1aohZv2U72EiiNyVzkNfZ0XDoWnzUXmon+fJfFFCu+QmKPhgDqCpGhz3CFshzvwtEcieHN1J3ajj3uqHNiW1iwdNgyPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958344; c=relaxed/simple;
	bh=XmLbLrRjceSwXv6zJQ8+KYhU8L/1jbSWQDQH19D3wEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=W4eyNNxx3eX7koy66/Ey0hE1KfSecqA37Doj6k4QavIDey/J/Muk4J6/waC2j5O0dUZl8Yo3j7t5Jq0w+bIRmttjvHr1BD5jJwSwaNHmPJ87UJbBVA1rM68Rvvqyinez8BFHyYkBfwsmcqZ8ErNL3kWcD+VorHEMk3gTbS1gkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkxKgDBV; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkxKgDBV"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0ba59a830so70940eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 15:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773958341; x=1774563141; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0I922xoaPU5hhzRGRg2d7tZLIGlSXmrSaPuYFLhDEl0=;
        b=RkxKgDBV1oGfWTf9AFstu+hyThXjZzhnChB0Ry77TeVZVwX83VZdspsiH55Xr429yJ
         Vdaw0xcxGKT6khII83uJSXZORNtvl2nhWL25/M2uY+9Sdop8a/UGWenSct8SKgXSMh4q
         Tg6wAWPsS4oPZZiAYlsoAfcIL45phSudTIGixsHefE2eqar5Y4d2H7VBiLFP+PkozRe5
         8SXYxRErWeeLLTmbEMZFQQi0dneMIXdmWxZspi7m3WTv5xu/UAYPD3vdUAXdqHrVtyOu
         ZbIm/seCjgPAkKUUM1hisHpKtTaRfE0CwMZX1ju4gw4dRpGx45oI6lvNwU9fa4ub6Xmi
         Zi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773958341; x=1774563141;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0I922xoaPU5hhzRGRg2d7tZLIGlSXmrSaPuYFLhDEl0=;
        b=rRrF1DDzppWRsr3WDnIeda59F7rD/R65wZgDJz0cfymZ9kZML4+TAp3DLxWFyYxd39
         8KcO4Xc8ul0mvz5uvi/0yJ/mqaEPbkONnN8AIHH7SxiwEKutOMM726Kux4wbGN5J9n0j
         qoDCp+raiK08acpmN45kYUVwlNsc+S2ItSEO19M7Koz6JrWZly2xajbvgozvGwy6UEdv
         ptfSuxqI0HBMlkriQlG/aPCsRFyesQ6wLAZKq2aJ3UHRsAIb3waDBrioI9Peu1vPpHj4
         x+Zxw3oxwz0BUmHMvDPvhTISe8VO8QpQdzlSSe1Z8rnDXUVmONv6/Grj5q8ZaN+bBMQ5
         OYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+QWEwdl+gBZtkINiO5bx9zoQmcM0nNBv54NubrTftzZayu43C84FhPw3nDE34N1UNNWCbVIMSRHDUyhpIhfSA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4x4Iq/LgeYR8/s1Lhh8U4ojAbnl22K7000thVlNZj3h3GKpa
	q9mLk15X5lXiiXNU6ayN5TPYNW1X0ZfXCI8/4NHwIPxwb4lRwbF7Z/IMWpZVEWMaES6zvbuGmpx
	DyZjLjwjSfQ==
X-Received: from dlbvv26.prod.google.com ([2002:a05:7022:5f1a:b0:128:f012:2b7f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:43a4:b0:128:d5bd:3572
 with SMTP id a92af1059eb24-12a726f5b50mr438145c88.31.1773958340689; Thu, 19
 Mar 2026 15:12:20 -0700 (PDT)
Date: Thu, 19 Mar 2026 15:12:15 -0700
In-Reply-To: <20260319221215.207951-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319221215.207951-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319221215.207951-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf stat: Fix opt->value type for parse_cache_level
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit f5803651b4a4 ("perf stat: Choose the most disaggregate command
line option") changed aggregation option handling for `perf stat` but
not `perf stat report` leading to parse_cache_level being passed a
struct in the `perf stat` case but erroneously an aggr_mode enum value
for `perf stat report`. Change the `perf stat report` aggregation
handling to use the same opt_aggr_mode as `perf stat`. Also, just pass
the boolean for consistency with other boolean argument handling.

Fixes: f5803651b4a4 ("perf stat: Choose the most disaggregate command line option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 41 ++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 73c2ba7e3076..a00af7cfd50e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -164,7 +164,7 @@ struct opt_aggr_mode {
 };
 
 /* Turn command line option into most generic aggregation mode setting. */
-static enum aggr_mode opt_aggr_mode_to_aggr_mode(struct opt_aggr_mode *opt_mode)
+static enum aggr_mode opt_aggr_mode_to_aggr_mode(const struct opt_aggr_mode *opt_mode)
 {
 	enum aggr_mode mode = AGGR_GLOBAL;
 
@@ -1219,8 +1219,8 @@ static int parse_cache_level(const struct option *opt,
 			     int unset __maybe_unused)
 {
 	int level;
-	struct opt_aggr_mode *opt_aggr_mode = (struct opt_aggr_mode *)opt->value;
-	u32 *aggr_level = (u32 *)opt->data;
+	bool *per_cache = opt->value;
+	u32 *aggr_level = opt->data;
 
 	/*
 	 * If no string is specified, aggregate based on the topology of
@@ -1258,7 +1258,7 @@ static int parse_cache_level(const struct option *opt,
 		return -EINVAL;
 	}
 out:
-	opt_aggr_mode->cache = true;
+	*per_cache = true;
 	*aggr_level = level;
 	return 0;
 }
@@ -2305,24 +2305,23 @@ static struct perf_stat perf_stat = {
 static int __cmd_report(int argc, const char **argv)
 {
 	struct perf_session *session;
+	struct opt_aggr_mode opt_mode = {};
 	const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
-	OPT_SET_UINT(0, "per-socket", &perf_stat.aggr_mode,
-		     "aggregate counts per processor socket", AGGR_SOCKET),
-	OPT_SET_UINT(0, "per-die", &perf_stat.aggr_mode,
-		     "aggregate counts per processor die", AGGR_DIE),
-	OPT_SET_UINT(0, "per-cluster", &perf_stat.aggr_mode,
-		     "aggregate counts perf processor cluster", AGGR_CLUSTER),
-	OPT_CALLBACK_OPTARG(0, "per-cache", &perf_stat.aggr_mode, &perf_stat.aggr_level,
-			    "cache level",
-			    "aggregate count at this cache level (Default: LLC)",
+		OPT_BOOLEAN(0, "per-thread", &opt_mode.thread, "aggregate counts per thread"),
+	OPT_BOOLEAN(0, "per-socket", &opt_mode.socket,
+		    "aggregate counts per processor socket"),
+	OPT_BOOLEAN(0, "per-die", &opt_mode.die, "aggregate counts per processor die"),
+	OPT_BOOLEAN(0, "per-cluster", &opt_mode.cluster,
+		    "aggregate counts per processor cluster"),
+	OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode.cache, &stat_config.aggr_level,
+			    "cache level", "aggregate count at this cache level (Default: LLC)",
 			    parse_cache_level),
-	OPT_SET_UINT(0, "per-core", &perf_stat.aggr_mode,
-		     "aggregate counts per physical processor core", AGGR_CORE),
-	OPT_SET_UINT(0, "per-node", &perf_stat.aggr_mode,
-		     "aggregate counts per numa node", AGGR_NODE),
-	OPT_SET_UINT('A', "no-aggr", &perf_stat.aggr_mode,
-		     "disable CPU count aggregation", AGGR_NONE),
+	OPT_BOOLEAN(0, "per-core", &opt_mode.core,
+		    "aggregate counts per physical processor core"),
+	OPT_BOOLEAN(0, "per-node", &opt_mode.node, "aggregate counts per numa node"),
+	OPT_BOOLEAN('A', "no-aggr", &opt_mode.no_aggr,
+		    "disable aggregation across CPUs or PMUs"),
 	OPT_END()
 	};
 	struct stat st;
@@ -2330,6 +2329,8 @@ static int __cmd_report(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, options, stat_report_usage, 0);
 
+	perf_stat.aggr_mode = opt_aggr_mode_to_aggr_mode(&opt_mode);
+
 	if (!input_name || !strlen(input_name)) {
 		if (!fstat(STDIN_FILENO, &st) && S_ISFIFO(st.st_mode))
 			input_name = "-";
@@ -2506,7 +2507,7 @@ int cmd_stat(int argc, const char **argv)
 		OPT_BOOLEAN(0, "per-die", &opt_mode.die, "aggregate counts per processor die"),
 		OPT_BOOLEAN(0, "per-cluster", &opt_mode.cluster,
 			"aggregate counts per processor cluster"),
-		OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode, &stat_config.aggr_level,
+		OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode.cache, &stat_config.aggr_level,
 				"cache level", "aggregate count at this cache level (Default: LLC)",
 				parse_cache_level),
 		OPT_BOOLEAN(0, "per-core", &opt_mode.core,
-- 
2.53.0.959.g497ff81fa9-goog

