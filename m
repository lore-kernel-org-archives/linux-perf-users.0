Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C7330BB85
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416726; cv=none; b=FmHhLCiXv3ErB2d6xi08Y+2g4vRGzWJ3XrT1Z55PtBljGdU4UASVWtRNx545UmI05bVTcMlqbLpi1r/xhUPfZyGBTFI+aL2W5BOMjB55oDRgfEWP82zcSXTWrjL6BUOM5b+lUl0wOrSb6PDrmYVbgzORen1u7XE0zsim9baDaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416726; c=relaxed/simple;
	bh=4dzqlAY6Jwfn5UZRMxqibkJ/WzReutE/CulfgusKL0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XqlQY/CVItPLLdP5eeALJV2cX6bQmvIQRUEW0BbR0QwHxp7Xizod1hPczhHj2g20+sYc+RwtIAOp5ym/yxYRAgOADVteiZPEGgCNR7kn3oWzkb6qv5uXsnoQOP5qIIhWI0IB+kXzz/nsfpEYY6GMqDg3uNQx7tp9icS4isNnCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKyI1YMZ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKyI1YMZ"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124a95d580cso19959538c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 14:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770416726; x=1771021526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNGV+9W9psENt274mz6PMhj6c8c5MewbEM3NGZmHhlM=;
        b=jKyI1YMZU8KbTKscOXZfdYZu4iM6Y+wucv0aNSVZL2q667YcK6+dF92c3RMhRV9W2m
         qOmtvaD0ur+uLDDJN7xT9sNbS6Lz305e8BrSOCGvIBsj0hjgI0kSnuiPD7ofOnyruFDL
         RDf6U+eX54DrEdc8Yiz10Ou80TQTSxNoN6q6z3DV5nxhELEGbe3HApZNgHIPO/eHWOnJ
         pmNXCv2DUqa00yeJWgecuN2uRHV6ThHRXOhzomMbNQGI2cYPVbQNhsgY3TQ2Kf/wQwXY
         wC7c9W5oGUIPFJCc/tcICBsyPJfrpZQaRUyhaBcpxTpth3LSKysbWip+4SWbBYW9W1BV
         xpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770416726; x=1771021526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNGV+9W9psENt274mz6PMhj6c8c5MewbEM3NGZmHhlM=;
        b=B8FLjbSAxvzD08IQI9ytmLm7ZdtUC/a3I38rFc4sBVEDgdL7JsbXnZlz2Zf/i066k3
         VwB86boWHblPToNmcXDT+6+f/ru9KilGVvL2DQTFhRq/YzS9uns536VaV7vF199l2a1F
         hjJJIUwshyR6X7kCZ9MYiRbOfItNwBV43nUASvIVzp07IgPQxmO9S44mSl0ZygVtzOGn
         eAIPeF54z9YXU777kaSksf/3RHEDsGanVpu4htp+AcTXiuzWVM4k9KfJHcY3MkhGsDFr
         idUMiYcfL8kASnuHP6d0jb/+NsZMPju+iIUNGemSFNn9SCBsHfIUhKA0kl/2DTqRdc1n
         vrsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvURc6oJfR01lePkeDbiyygY2uswviNkPtd1TYTZB0TRjenjiobX95A6gFbJKO2GFjibwxRB2zxNTKbSOgqHmU@vger.kernel.org
X-Gm-Message-State: AOJu0YzgtN6I8/UXIGiTDK0aq0NmRGBcCNw5tRvKzDhqvYaDroeEvXJ9
	0LegYOBe7I38z9RCMhdytzEOBNrB1Gh6N4RkmJuRwM2cEIjOShr1tfHVBqxzrg7HH0HFA5WJUdA
	UL1C9y3R2rA==
X-Received: from dlbur6-n2.prod.google.com ([2002:a05:7022:ea46:20b0:127:c76:21ec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:618f:b0:11b:9386:a3cc
 with SMTP id a92af1059eb24-1270419f22amr1886234c88.45.1770416725561; Fri, 06
 Feb 2026 14:25:25 -0800 (PST)
Date: Fri,  6 Feb 2026 14:25:09 -0800
In-Reply-To: <20260206222509.982489-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYZnkYqWXnKpHd3h@x1> <20260206222509.982489-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206222509.982489-7-irogers@google.com>
Subject: [PATCH v8 6/6] perf stat: Add no-affinity flag
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, thomas.falcon@intel.com, 
	tmricht@linux.ibm.com, yang.lee@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Add flag that disables affinity behavior. Using sched_setaffinity to
place a perf thread on a CPU can avoid certain interprocessor
interrupts but may introduce a delay due to the scheduling,
particularly on loaded machines. Add a command line option to disable
the behavior. This behavior is less present in other tools like `perf
record`, as it uses a ring buffer and doesn't make repeated system
calls.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-stat.txt | 4 ++++
 tools/perf/builtin-stat.c              | 6 ++++++
 tools/perf/util/evlist.c               | 6 +-----
 tools/perf/util/evlist.h               | 1 +
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 1a766d4a2233..1ffb510606af 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -382,6 +382,10 @@ color the metric's computed value.
 Don't print output, warnings or messages. This is useful with perf stat
 record below to only write data to the perf.data file.
 
+--no-affinity::
+Don't change scheduler affinities when iterating over CPUs. Disables
+an optimization aimed at minimizing interprocessor interrupts.
+
 STAT RECORD
 -----------
 Stores stat data into perf data file.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c1bb40b99176..8bbdea44c3ba 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2426,6 +2426,7 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
+	bool affinity = true, affinity_set = false;
 	struct option stat_options[] = {
 		OPT_BOOLEAN('T', "transaction", &transaction_run,
 			"hardware transaction statistics"),
@@ -2554,6 +2555,8 @@ int cmd_stat(int argc, const char **argv)
 			"don't print 'summary' for CSV summary output"),
 		OPT_BOOLEAN(0, "quiet", &quiet,
 			"don't print any output, messages or warnings (useful with record)"),
+		OPT_BOOLEAN_SET(0, "affinity", &affinity, &affinity_set,
+			"don't allow affinity optimizations aimed at reducing IPIs"),
 		OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
 			"Only enable events on applying cpu with this type "
 			"for hybrid platform (e.g. core or atom)",
@@ -2611,6 +2614,9 @@ int cmd_stat(int argc, const char **argv)
 	} else
 		stat_config.csv_sep = DEFAULT_SEPARATOR;
 
+	if (affinity_set)
+		evsel_list->no_affinity = !affinity;
+
 	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
 		argc = __cmd_record(stat_options, &opt_mode, argc, argv);
 		if (argc < 0)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 45833244daf3..591bdf0b3e2a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -369,11 +369,7 @@ static bool evlist__use_affinity(struct evlist *evlist)
 	struct perf_cpu_map *used_cpus = NULL;
 	bool ret = false;
 
-	/*
-	 * With perf record core.user_requested_cpus is usually NULL.
-	 * Use the old method to handle this for now.
-	 */
-	if (!evlist->core.user_requested_cpus ||
+	if (evlist->no_affinity || !evlist->core.user_requested_cpus ||
 	    cpu_map__is_dummy(evlist->core.user_requested_cpus))
 		return false;
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 30dff7484d3c..d17c3b57a409 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -59,6 +59,7 @@ struct event_enable_timer;
 struct evlist {
 	struct perf_evlist core;
 	bool		 enabled;
+	bool		 no_affinity;
 	int		 id_pos;
 	int		 is_pos;
 	int		 nr_br_cntr;
-- 
2.53.0.rc2.204.g2597b5adb4-goog

