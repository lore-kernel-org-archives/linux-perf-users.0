Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B478C91;
	Wed,  2 Apr 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629851; cv=none; b=K/YRQ3snpJhLcmySVxEWB0YZbKeBGI6iSlAXcshKGjRfGz9qCtscGKwu9w96Qxk4IFb2dWIC2Qev2GrDpM/8dJYMSbFB6BIE0q7ZDTWN+fFuKAGsy0cevyuv6X0klvv5MmR05JFAVexgHo4M2fvTfr1bPR19Fv0/CMBKnNkqMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629851; c=relaxed/simple;
	bh=AUCydmqSmVOFaOQ2zh4o1+wyn38LB7IyJpt6YlS8YA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUNfUU5JWnFUd8y8SVAiS4R0WyAbSR3xgvzCZVlxNKTZzAWl3pMuf2J1XX3JmiVm5NG+nHMPJw8yWLa2Q6ABlR+ixa4V0i2D1jxtvFFuIrsScRUk9X3Tw2UmsUQGp6WV7AKxPuS5tz3vVhLtSlgRV4THpYMWLtveGVwgzOEAIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=t/ESMrOg; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="t/ESMrOg"
Received: from localhost (ip-109-42-179-236.web.vodafone.de [109.42.179.236])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 532LPLq1030794
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 2 Apr 2025 23:25:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1743629121; bh=AUCydmqSmVOFaOQ2zh4o1+wyn38LB7IyJpt6YlS8YA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t/ESMrOgBxbLcv78M+ChSoLvK0CA+TcGc58RevoTHS8y59Po0jJTRUEDwH+YlRDqX
	 jw6QDM/2nkestVDvMidjFDdqsC48vPRW7HZGI7lRSfe4qeTz8YGBRmW/6aeXFd7kA7
	 mo1I4jVsd/VUqMpAGH8A43lPY4SlOViiPdw2CyfQ=
From: Dirk Gouders <dirk@gouders.net>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Dirk Gouders <dirk@gouders.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf bench sched pipe: introduce multipliers for number of processes
Date: Wed,  2 Apr 2025 23:15:28 +0200
Message-ID: <20250402212402.15658-4-dirk@gouders.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250402212402.15658-2-dirk@gouders.net>
References: <20250402212402.15658-2-dirk@gouders.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce multipliers to specify the number of processes to run:

K|K|m|M: multiply leading number by 2^10 or 2^20, respectively

p|P: multiply intermediate result by number of online processors

Examples:

-p  2K = 2048
-p 10p = 10 * number of online processors
-p 1kp = 1024 * number of online processors

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 tools/perf/Documentation/perf-bench.txt | 14 ++++++
 tools/perf/bench/sched-pipe.c           | 32 ++++++++++++++
 tools/perf/util/string.c                | 58 +++++++++++++++++++++++++
 tools/perf/util/string2.h               |  1 +
 4 files changed, 105 insertions(+)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index c1f479de9ded..ed74532ee28d 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -149,6 +149,20 @@ make sure that the cgroups exist and are accessible before use.
 -p::
 --nprocs=::
 Number of processes to use for sending tokens along the pipes.
+This option accepts a number follwed by optional (case insensitive)
+multipliers in this order:
+
+- k, m
++
+Multipliers 1024 and 1048576 for the leading number.
+
+- p
++
+Multiplier replaced by the number of online processors.
+
+Example:
+
+        -p 1kP means: 1024 * number of online processors
 
 Example of *pipe*
 ^^^^^^^^^^^^^^^^^
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 553e5ead254f..1540cf46290a 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -47,6 +47,8 @@ struct thread_data {
 #define LOOPS_DEFAULT 1000000
 static	unsigned int		loops = LOOPS_DEFAULT;
 
+static const char *nproc_str;	/* String that specifies a number of processes. */
+
 /* Use processes by default: */
 static bool			threaded;
 static unsigned int		nr_threads = 2;
@@ -91,6 +93,8 @@ static int parse_two_cgroups(const struct option *opt __maybe_unused,
 
 static const struct option options[] = {
 	OPT_BOOLEAN('n', "nonblocking",	&nonblocking,	"Use non-blocking operations"),
+	OPT_STRING('p', "nprocs",	&nproc_str,	"2P",
+		   "Number of processes (2P := 2 * online processors)"),
 	OPT_UINTEGER('p', "nprocs",	&nr_threads,    "Number of processes"),
 	OPT_UINTEGER('l', "loop",	&loops,		"Specify number of loops"),
 	OPT_BOOLEAN('K', "Kn",		&Kn_mode,	"Send tokens in a complete graph instead of a ring."),
@@ -279,6 +283,31 @@ static void *worker_thread_ring(void *__tdata)
 /* Ring mode is the default. */
 void * (*worker_thread)(void *) = worker_thread_ring;
 
+/*
+ * Get number of processes from the given string,
+ * e.g. "1k" => 1024 or
+ *      "8p" => 8 * number of online processors.
+ */
+static unsigned int get_nprocs(const char *np_str)
+{
+	unsigned int np;
+
+	np = (unsigned int)perf_nptou(np_str);
+
+	if (np == -1U) {
+		fprintf(stderr, "Cannot parse number of processes/threads: %s\n",
+			nproc_str);
+		exit(1);
+	}
+
+	if (np < 2) {
+		fprintf(stderr, "Two processes are the minimum requirement.\n");
+		exit(1);
+	}
+
+	return np;
+}
+
 static int create_pipes(struct thread_data *tdata)
 {
 	int __maybe_unused flags = 0;
@@ -338,6 +367,9 @@ int bench_sched_pipe(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, options, bench_sched_pipe_usage, 0);
 
+	if (nproc_str)
+		nr_threads = get_nprocs(nproc_str);
+
 	if (Kn_mode)
 		worker_thread = worker_thread_kn;
 
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index c0e927bbadf6..72deb3df9c99 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <stdlib.h>
+#include <unistd.h>
 
 #include <linux/ctype.h>
 
@@ -68,6 +69,63 @@ s64 perf_atoll(const char *str)
 	return -1;
 }
 
+/*
+ * perf_nptou()
+ *
+ * Parse given string to a number of processes and return that number.
+ * Multipliers up to 'm' are accepted, and an optional final unit suffix
+ * 'p' meaning "number of online processors".
+ *
+ * str must match: (\d+)(k|K|m|M)?(p|P)?
+ *
+ * (e.g. "8P" meaning "8 * number of online processors",
+ *  or   "1k" meaning "1024",
+ *  or   "1Kp" meaning "1024 * number of online processors")
+ */
+u32 perf_nptou(const char *str)
+{
+	s32 length;
+	char *p;
+	char c;
+
+	if (!isdigit(str[0]))
+		goto out_err;
+
+	length = strtol(str, &p, 10);
+
+	switch (c = *p++) {
+		case 'p': case 'P':
+			if (*p)
+				goto out_err;
+			goto handle_p;
+		case '\0':
+			return length;
+		default:
+			goto out_err;
+
+		/* Multipliers */
+		case 'k': case 'K':
+			length <<= 10;
+			break;
+		case 'm': case 'M':
+			length <<= 20;
+			break;
+	}
+
+	if (*p == '\0')
+		return length;
+
+	if (strcmp(p, "p") != 0 && strcmp(p, "P") != 0)
+		goto out_err;
+
+handle_p:
+	length *= sysconf(_SC_NPROCESSORS_ONLN);
+	return length;
+
+out_err:
+	return -1U;
+}
+
 /* Character class matching */
 static bool __match_charclass(const char *pat, char c, const char **npat)
 {
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 4c8bff47cfd3..bca2c1687924 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -12,6 +12,7 @@ extern const char *graph_dotted_line;
 extern const char *dots;
 
 s64 perf_atoll(const char *str);
+u32 perf_nptou(const char *str);
 bool strglobmatch(const char *str, const char *pat);
 bool strglobmatch_nocase(const char *str, const char *pat);
 bool strlazymatch(const char *str, const char *pat);
-- 
2.45.3

