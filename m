Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E5406287
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963244; cv=none; b=n9uhuFlUkluIKMvXS7eMGqVRho3LqI4gSlEVbWAyuWro51sUP/yixCl/GeiAt8CReAlC1WQqsgy7DHZt7dhBqw8HPBgVtGWpSWDgsZvNCWs3v0mSXRw/mAQI4voSktkBXD27HlsaJSFm7cJuwYGG6UO184N3jBpp+eyehxy4tFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963244; c=relaxed/simple;
	bh=ZVI7lUOBiwAFnMOccGMzQnunQyI6azt//6BMcUoPEpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W1Tp6c0RB1aItt0jBEytVLG12xVqBn4j31lNtFIv1Sy6bmWtJFHXADQu8YhPAXTRAtbxlyfsfs9I1IdAT5WiPSlHutFsyQ0V82DwRJdvk7TN2etf5ZMAQbwq1bUi1Xp70o4wda2cs2d841y00NIkZm528l2a2mi4jUMWbAQh1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxYEGOw+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxYEGOw+"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so1277226eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773963241; x=1774568041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iaJx40HSOTCt1/KOzD7q4UNl8EKa5dhkwoMARV9qT0M=;
        b=HxYEGOw+pgLl0C5Y505oWNP6NyZNGBIYUB6ktkXEl/HGIgxhAUyAoC9T7Z8ypzvOfv
         LAlsUvGIEteCGst9US9K6BPO8rjc5tzGUvEyQS8e+FPbOio1n3AVRS0Ck5rYNK2tmN6e
         V4ZSDN28GOnL4Xjoms5AHAqBtnMWtVoyQR3/EiC9Lvczu2RidMWaBRD1I3HmiaBYM52k
         d/Xg4eSK2b5ATHkxmR21LJECKBhDatId+R+Eyv3fhhsiDhGV7MJnWxQed5GMOmLvcNaZ
         OTnWfFvSiN/fjQYwbmewEhyN0x5W2CUab5DKXAvau6JrXoMQH0/heieCBpAP1LhE0Vza
         9wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773963241; x=1774568041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaJx40HSOTCt1/KOzD7q4UNl8EKa5dhkwoMARV9qT0M=;
        b=TRKULX8cnJygeQhOaKj1kNQeHqk/i9NjQy4CcVqphMr+O0Xw/twLEKw0IHXu3fsS+u
         AqZTcqVxchGZnmeu+DgQEU534O4AYORjZruAk5mCTMqR/prcKy9/YTnWlMG2az7JDBPu
         RnC2nrEh0rxADfY69EBqhTcIAHjfB/PGbfniKZH79Uok06jLwnyQXEyCkj6zLpB0aNqH
         mJ28rOfQJIJEXQF8QjFp51qcg7eNc8PbwErXPn2BRNLbOrxMOYeBznRrRUHl6edmjKWN
         Zu3wKGAKpAgUDADeeNE+Zr+FZdhWtb3wW4KYaF4AI11ParoNMjCK1F5AMYTYDzSm7n91
         xfuw==
X-Forwarded-Encrypted: i=1; AJvYcCWBZvkzOonbjbQ3tAUlxaAZJBNOGdAA9IpjAYAfcYS1pSdSJ1QssDo380sIsRU7cwELNX+yQ0PZDFQCPtb8tGBB@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFy3tqgsO4MymK8ITuYncKMfmu3hIUnLmhrE4zoZY+TsERmWi
	5prKLD1+ya2WJbipRtpHiKQPDwdDP+qK0KLjZqZDC+sKWHrNvE7zcLtOFDAxkOfpRl22MXCulQw
	FK2b+Nip7Aw==
X-Received: from dled13-n2.prod.google.com ([2002:a05:701b:42cd:20b0:12a:7349:f4f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:45a1:b0:124:9acd:3c4b
 with SMTP id a92af1059eb24-12a726d5e91mr440182c88.42.1773963240905; Thu, 19
 Mar 2026 16:34:00 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:33:49 -0700
In-Reply-To: <20260319233349.306012-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319221215.207951-1-irogers@google.com> <20260319233349.306012-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319233349.306012-2-irogers@google.com>
Subject: [PATCH v2 2/2] perf stat: Fix opt->value type for parse_cache_level
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
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
v2: Add in fixes suggested by Sashiko.
---
 tools/perf/builtin-stat.c | 43 +++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 73c2ba7e3076..02c1c02d4b27 100644
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
+	OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode.cache, &perf_stat.aggr_level,
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
@@ -2330,6 +2329,10 @@ static int __cmd_report(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, options, stat_report_usage, 0);
 
+	perf_stat.aggr_mode = opt_aggr_mode_to_aggr_mode(&opt_mode);
+	if (perf_stat.aggr_mode == AGGR_GLOBAL)
+		perf_stat.aggr_mode = AGGR_UNSET; /* No option found so leave unset. */
+
 	if (!input_name || !strlen(input_name)) {
 		if (!fstat(STDIN_FILENO, &st) && S_ISFIFO(st.st_mode))
 			input_name = "-";
@@ -2506,7 +2509,7 @@ int cmd_stat(int argc, const char **argv)
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

