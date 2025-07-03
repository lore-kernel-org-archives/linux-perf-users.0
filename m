Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4718C01D;
	Thu,  3 Jul 2025 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507384; cv=none; b=YJboBieum7uxHvO8IR4ActaOYXN7zDfiWXI+0aVt7PTq463W37ZhdH6Gigj6yolWFNvmdGbtgIoRvCK8Cvh7/G6wkS35AjLhm9n0bJhl1J+0pt/o53//snu24d+UkzNAZl2PFhxuVaONThvyzCf2UtXuWfVggql7c8TVViLEvMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507384; c=relaxed/simple;
	bh=2Ecqkg2lROeWhWTABKLBvt4hqMUUv7D6JgnQACCprWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvovkGcivxad+ESZBCzI4KkS6uWwTBXzFwJk3RiY8QTHRgKeg0GAW9v2ifRqgu0YYPJA0+sMU6hjbV5z4uyNba4rLhY9MLur20/p14jS2R9zrD8rxsf05n9gtFPGZKReMpW6wHLm1vLeN+P2wlX59BmI3u169Oy2P05DCX79QNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5M249xL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5M249xL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4130DC4CEF2;
	Thu,  3 Jul 2025 01:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751507383;
	bh=2Ecqkg2lROeWhWTABKLBvt4hqMUUv7D6JgnQACCprWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5M249xLo/ROR3pgtJpOFATfsQeKehj8tID2jPeyNq/izfhmM+xd0KpCRDKP9AKgz
	 5YK+W55jwSMGQnKhof+jsj6jKt6ApLZx/LPufyWuPTntsAMDLsZ7gQjyrHsHl31JoH
	 3ezSbCXSgfg8x+2EsiHPAlWMaBxbLJm2XnlU1b+Rp0K/m9yYOsL2zGQ0pZUAmbgvyi
	 XAjPKbkVdXGqXTiVvOeGu6XCoGsKmEMU9tDYRlNA1kcIrjmPRxzIc528A5ilNTpmzC
	 tkOXc4FHNXnG+Xo7mwBZVv2WxfyL0gtu3YX09Ns1fDwXlEB5i1pW94fpmIFxeaX2we
	 vfcG2D9K4Or4w==
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
Subject: [PATCH 1/8] perf sched: Make sure it frees the usage string
Date: Wed,  2 Jul 2025 18:49:35 -0700
Message-ID: <20250703014942.1369397-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250703014942.1369397-1-namhyung@kernel.org>
References: <20250703014942.1369397-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parse_options_subcommand() allocates the usage string based on the
given subcommands.  So it should reach the end of the function to free
the string to prevent memory leaks.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 26ece6e9bfd167b3..b7bbfad0ed600eee 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3902,9 +3902,9 @@ int cmd_sched(int argc, const char **argv)
 	 * Aliased to 'perf script' for now:
 	 */
 	if (!strcmp(argv[0], "script")) {
-		return cmd_script(argc, argv);
+		ret = cmd_script(argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
-		return __cmd_record(argc, argv);
+		ret = __cmd_record(argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
 		sched.tp_handler = &lat_ops;
 		if (argc > 1) {
@@ -3913,7 +3913,7 @@ int cmd_sched(int argc, const char **argv)
 				usage_with_options(latency_usage, latency_options);
 		}
 		setup_sorting(&sched, latency_options, latency_usage);
-		return perf_sched__lat(&sched);
+		ret = perf_sched__lat(&sched);
 	} else if (!strcmp(argv[0], "map")) {
 		if (argc) {
 			argc = parse_options(argc, argv, map_options, map_usage, 0);
@@ -3924,13 +3924,14 @@ int cmd_sched(int argc, const char **argv)
 				sched.map.task_names = strlist__new(sched.map.task_name, NULL);
 				if (sched.map.task_names == NULL) {
 					fprintf(stderr, "Failed to parse task names\n");
-					return -1;
+					ret = -1;
+					goto out;
 				}
 			}
 		}
 		sched.tp_handler = &map_ops;
 		setup_sorting(&sched, latency_options, latency_usage);
-		return perf_sched__map(&sched);
+		ret = perf_sched__map(&sched);
 	} else if (strlen(argv[0]) > 2 && strstarts("replay", argv[0])) {
 		sched.tp_handler = &replay_ops;
 		if (argc) {
@@ -3938,7 +3939,7 @@ int cmd_sched(int argc, const char **argv)
 			if (argc)
 				usage_with_options(replay_usage, replay_options);
 		}
-		return perf_sched__replay(&sched);
+		ret = perf_sched__replay(&sched);
 	} else if (!strcmp(argv[0], "timehist")) {
 		if (argc) {
 			argc = parse_options(argc, argv, timehist_options,
@@ -3954,19 +3955,19 @@ int cmd_sched(int argc, const char **argv)
 				parse_options_usage(NULL, timehist_options, "w", true);
 			if (sched.show_next)
 				parse_options_usage(NULL, timehist_options, "n", true);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		ret = symbol__validate_sym_arguments();
-		if (ret)
-			return ret;
-
-		return perf_sched__timehist(&sched);
+		if (!ret)
+			ret = perf_sched__timehist(&sched);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
 
+out:
 	/* free usage string allocated by parse_options_subcommand */
 	free((void *)sched_usage[0]);
 
-	return 0;
+	return ret;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog

