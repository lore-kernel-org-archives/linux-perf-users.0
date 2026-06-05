Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9E30BBB9;
	Fri,  5 Jun 2026 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703494; cv=none; b=toWW8TXl+nzG9akH1RRWS+gyeM9j2z6kRQhjlyxRs++s5zY48l9kVIuX6RGzP4WkaVOIhEsCF5LEQaIODzqwJCgSyqw+0HpMHyLNZ0rIZ2jj9jGzln0lSuO0nxDYX7qS4yIiiJU4N+GcIEhGmqdO/MNZhHLV6M9pp6szZxjJ6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703494; c=relaxed/simple;
	bh=a2UYEhuEvWJ/JEF/kW1P1dd0ZjwgDyUXGOvPckwwzN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+5Ge4w8Tf9VF1x75R11gY2UR79QyuWRj/9PIa7Rb6K3tMq5MgqRIR9KBadYckR6vVwP5atXWpbM8Z9J1DICJSNMuagMHoD5m9fh0BZLorQoS6lBMzlye+9fpjHB5VH0cy4hcBpW+FJMqxYF3j+9eN63H/J9c6qr1qZVlKh8sFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSyyjuLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSyyjuLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B730B1F0089A;
	Fri,  5 Jun 2026 23:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780703493;
	bh=FSIDH5ze8xd03i1gbY7CFmVriqWx9rWe6/9QW2Pwny0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QSyyjuLr37mMAZHBvBuFiYxDb0oXSzas7HZkuWTydJa2ZnK7y/JWvo6tdREb3KnxS
	 ZmXR8OhYyu8WuEFM35FjUfP801aFPgF1AZ4iulO4t2earV+8QXbKWN1R5uWR0K4aI8
	 KyTbswnQ30UAb9ZYZIWaLYP0huCKQD2zSooStn5vrSwY4FBpjCi2bnx4b2h7mlxWP+
	 2Z6gBoub7kbhX+Gggpdiet9umUuU8sSfJr5qIQTgNNtJbZ2TxWLyyR5OwhVlIjN2mw
	 Me8pDYI+MvFm8jKuY39wvUSvzCBTvssdGfwpn9fgzpE/3teeMkkaofcrQVO1uYFzWY
	 +pBhVRaOdgvUg==
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
Subject: [PATCH v2 2/4] perf timechart: Fix memory leaks during record
Date: Fri,  5 Jun 2026 16:51:29 -0700
Message-ID: <20260605235131.2440270-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605235131.2440270-1-namhyung@kernel.org>
References: <20260605235131.2440270-1-namhyung@kernel.org>
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
 tools/perf/builtin-timechart.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 27d17268395ed760..a73f0ab22fd64241 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1834,6 +1834,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		"syscalls:sys_exit_select",
 	};
 	unsigned int poll_events_nr = ARRAY_SIZE(poll_events);
+	int ret;
 
 	rec_argc = common_args_nr +
 		disk_events_nr * 4 +
@@ -1852,7 +1853,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 
 	p = rec_argv;
 	for (i = 0; i < common_args_nr; i++)
-		*p++ = strdup(common_args[i]);
+		*p++ = common_args[i];
 
 	for (i = 0; i < disk_events_nr; i++) {
 		if (!is_valid_tracepoint(disk_events[i])) {
@@ -1861,7 +1862,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		}
 
 		*p++ = "-e";
-		*p++ = strdup(disk_events[i]);
+		*p++ = disk_events[i];
 		*p++ = "--filter";
 		*p++ = filter;
 	}
@@ -1872,7 +1873,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		}
 
 		*p++ = "-e";
-		*p++ = strdup(net_events[i]);
+		*p++ = net_events[i];
 		*p++ = "--filter";
 		*p++ = filter;
 	}
@@ -1883,7 +1884,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		}
 
 		*p++ = "-e";
-		*p++ = strdup(poll_events[i]);
+		*p++ = poll_events[i];
 		*p++ = "--filter";
 		*p++ = filter;
 	}
@@ -1891,7 +1892,11 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 	for (i = 0; i < (unsigned int)argc; i++)
 		*p++ = argv[i];
 
-	return cmd_record(rec_argc, rec_argv);
+	ret = cmd_record(rec_argc, rec_argv);
+
+	free(rec_argv);
+	free(filter);
+	return ret;
 }
 
 
@@ -1902,6 +1907,7 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
 	const char **rec_argv;
 	const char **p;
 	unsigned int record_elems;
+	int ret;
 
 	const char * const common_args[] = {
 		"record", "-a", "-R", "-c", "1", "-o", output_data,
@@ -1966,24 +1972,27 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
 
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

