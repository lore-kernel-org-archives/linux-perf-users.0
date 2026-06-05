Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7C3F9F5B;
	Fri,  5 Jun 2026 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701117; cv=none; b=TI8IRYxJwfuFsBwATIwewFSHDphj9D/bAPy1/nJnjDHqQFNGpMcRD9vrLJH7z3o+LfDemY2gRSnrkijleK1p0m00p1c2dn611mw9rRAKbp+UJH0Q/jAs+iBAcWWW+ruC5TnjEoCa64DiVoQnCgl9TRA/EWgDGElzIEfAlzmfXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701117; c=relaxed/simple;
	bh=zzZxP5dL3VYdAtHIfBjTCt5UciWrf0qX9ZIJRBQFogo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/Q/j4xe+rTYlVkrCkziWV0ecE86720YB7JQjAQhsZEtt+TDg2hnWid9HlaaR0FiYqHCZX2zeVH/VcKPcjGSbRZG74eatKOiAZetjQ/ufFJew5gvG9e9RTYnV8H5Ut3N/2PLeDCO5RXHAy5H7rWpEFzh9LomfAjEiBNjUMiyoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxyEpJ9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxyEpJ9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720611F0089C;
	Fri,  5 Jun 2026 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701116;
	bh=4UKnr9aeBspxTmKS1xV7DqZNI5XVC2ZtAsPnopJVUwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QxyEpJ9Q5241Ob/PnG/hPnu22aPnSgJyzkJyp2+OnoBLYJgT1jQqpN5JVxQfIgtDI
	 Fg8ni44ViRUNWhfFQ2TNMCYOK1Gav+6jjP4ZFfCmRwzBAyo7K5Ww0KMOSokk2n2m0j
	 i5J5tC+5BmrSJXjEbO1q/Z7Pq8aplaZyGkilxTlF2DTtlb+4jm3nQQTAU5tqkAP53Q
	 TmxS1dU72TXGbJFTH2cEcwjtZ4SVvJU7W5oWsAHgIr+ZyH1Z4Qo3tCRgav7Hu116eZ
	 M86SzXTmYZuDee3ZtJS1mKZn7z6qwBcR7K5zzf815FOI39LuP4v8/ajgrJr4QJUwaA
	 EOHJbGg65AGmw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] perf timechart: Fix memory leaks during record
Date: Fri,  5 Jun 2026 16:11:53 -0700
Message-ID: <20260605231155.2415760-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605231155.2415760-1-namhyung@kernel.org>
References: <20260605231155.2415760-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command line options can be passed without copy as their lifetime is
limited within the same function.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 7c4ace51302e260c..d56adb41dcf9bb69 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1582,6 +1582,8 @@ static void timechart__release(struct timechart *tchart)
 			free(c);
 			c = next_comm;
 		}
+
+		free(p);
 		p = next_pid;
 	}
 
@@ -1820,6 +1822,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		"syscalls:sys_exit_select",
 	};
 	unsigned int poll_events_nr = ARRAY_SIZE(poll_events);
+	int ret;
 
 	rec_argc = common_args_nr +
 		disk_events_nr * 4 +
@@ -1838,7 +1841,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 
 	p = rec_argv;
 	for (i = 0; i < common_args_nr; i++)
-		*p++ = strdup(common_args[i]);
+		*p++ = common_args[i];
 
 	for (i = 0; i < disk_events_nr; i++) {
 		if (!is_valid_tracepoint(disk_events[i])) {
@@ -1847,7 +1850,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		}
 
 		*p++ = "-e";
-		*p++ = strdup(disk_events[i]);
+		*p++ = disk_events[i];
 		*p++ = "--filter";
 		*p++ = filter;
 	}
@@ -1858,7 +1861,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		}
 
 		*p++ = "-e";
-		*p++ = strdup(net_events[i]);
+		*p++ = net_events[i];
 		*p++ = "--filter";
 		*p++ = filter;
 	}
@@ -1869,7 +1872,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		}
 
 		*p++ = "-e";
-		*p++ = strdup(poll_events[i]);
+		*p++ = poll_events[i];
 		*p++ = "--filter";
 		*p++ = filter;
 	}
@@ -1877,7 +1880,11 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 	for (i = 0; i < (unsigned int)argc; i++)
 		*p++ = argv[i];
 
-	return cmd_record(rec_argc, rec_argv);
+	ret = cmd_record(rec_argc, rec_argv);
+
+	free(rec_argv);
+	free(filter);
+	return ret;
 }
 
 
@@ -1888,6 +1895,7 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
 	const char **rec_argv;
 	const char **p;
 	unsigned int record_elems;
+	int ret;
 
 	const char * const common_args[] = {
 		"record", "-a", "-R", "-c", "1", "-o", output_data,
@@ -1952,24 +1960,27 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
 
 	p = rec_argv;
 	for (i = 0; i < common_args_nr; i++)
-		*p++ = strdup(common_args[i]);
+		*p++ = common_args[i];
 
 	for (i = 0; i < backtrace_args_no; i++)
-		*p++ = strdup(backtrace_args[i]);
+		*p++ = backtrace_args[i];
 
 	for (i = 0; i < tasks_args_nr; i++)
-		*p++ = strdup(tasks_args[i]);
+		*p++ = tasks_args[i];
 
 	for (i = 0; i < power_args_nr; i++)
-		*p++ = strdup(power_args[i]);
+		*p++ = power_args[i];
 
 	for (i = 0; i < old_power_args_nr; i++)
-		*p++ = strdup(old_power_args[i]);
+		*p++ = old_power_args[i];
 
 	for (j = 0; j < (unsigned int)argc; j++)
 		*p++ = argv[j];
 
-	return cmd_record(rec_argc, rec_argv);
+	ret = cmd_record(rec_argc, rec_argv);
+
+	free(rec_argv);
+	return ret;
 }
 
 static int
-- 
2.54.0.1032.g2f8565e1d1-goog

