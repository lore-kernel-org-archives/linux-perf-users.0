Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBF1DF962;
	Sat,  5 Apr 2025 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854529; cv=none; b=Lkrzq9yC9sA39KjYKqVqDgw3LgxxkyDbT9rXo6S47oODGRuIQnExElv+YN5D7Cc1gde/HVEKEYR7vAI7DKDfN9bFS6V9Yq28aJ+6zYNUZ4xD5dG3RA/YIbTif7RUe4+spX9SoKbDhdSAF+9Z/Y3ivwCyLufpzPQaZyoTlH21UI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854529; c=relaxed/simple;
	bh=mvmvEdDAeeh44vcA+nPRYycDzVnRUY/MTVaMYBnRGo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1UmKszZHUC/7PYjHVLhVi/5i5yCRyaCHro4P+Kte7nKmNQWpFEHgGow0jcuaZZ0KQffR5T4FP25OEOi2eQp1MS7jcL+BbgBi/KZsAnIIscNDgwCQ5vB/FYFAz292inI0Zv79x+7KGD1LhkePzqCOf8lC8AELX71VfkskZtGzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=m4LbBUnA; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="m4LbBUnA"
Received: from localhost (ip-109-42-179-132.web.vodafone.de [109.42.179.132])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 535C1jnB022465
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 5 Apr 2025 14:01:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1743854506; bh=mvmvEdDAeeh44vcA+nPRYycDzVnRUY/MTVaMYBnRGo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m4LbBUnAbUYxVZhwSr2U3Ut+UXqhFJOjBnLJxbh/R19vXIdGZdzx5EkPst2G0Qzf/
	 q70svt0QoFtADIw+MPgg2iMgnHJU3r51p4teRDIzbChk9NiFCEZL4UKckv+kjYV8+C
	 Sso9FzKUkSfx58mPS2JDPcMAA+7mhxWpaVdpCr8k=
From: Dirk Gouders <dirk@gouders.net>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Dirk Gouders <dirk@gouders.net>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Subject: [PATCH v2 3/3] perf bench sched pipe: introduce multipliers for number of processes
Date: Sat,  5 Apr 2025 14:00:08 +0200
Message-ID: <20250405120039.15953-4-dirk@gouders.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250405120039.15953-1-dirk@gouders.net>
References: <20250402212402.15658-2-dirk@gouders.net>
 <20250405120039.15953-1-dirk@gouders.net>
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
 tools/perf/bench/sched-pipe.c           | 36 ++++++++++++++-
 tools/perf/util/string.c                | 58 +++++++++++++++++++++++++
 tools/perf/util/string2.h               |  1 +
 4 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 6f7df3d47821..a2a44d80ee26 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -159,6 +159,20 @@ by
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
index 3c76e8249a9b..a1fa7ad7ed67 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -12,7 +12,8 @@
 #include <subcmd/parse-options.h>
 #include <api/fs/fs.h>
 #include "bench.h"
-#include "util/cgroup.h"
+#include <util/cgroup.h>
+#include <util/string2.h>
 
 #include <unistd.h>
 #include <stdio.h>
@@ -45,6 +46,8 @@ struct thread_data {
 #define LOOPS_DEFAULT 1000000
 static	unsigned int		loops = LOOPS_DEFAULT;
 
+static const char *nproc_str;	/* String that specifies a number of processes. */
+
 /* Use processes by default: */
 static bool			threaded;
 static unsigned int		nr_threads = 2;
@@ -90,7 +93,8 @@ static int parse_two_cgroups(const struct option *opt __maybe_unused,
 
 static const struct option options[] = {
 	OPT_BOOLEAN('n', "nonblocking",	&nonblocking,	"Use non-blocking operations"),
-	OPT_UINTEGER('p', "nprocs",	&nr_threads,    "Number of processes"),
+	OPT_STRING('p', "nprocs",	&nproc_str,	"2P",
+		   "Number of processes (2P := 2 * online processors)"),
 	OPT_UINTEGER('l', "loop",	&loops,		"Specify number of loops"),
 	OPT_BOOLEAN('K', "Kn",		&Kn_mode,	"Send tokens in a complete graph instead of a ring."),
 	OPT_BOOLEAN('T', "threaded",	&threaded,	"Specify threads/process based task setup"),
@@ -281,6 +285,31 @@ static void *worker_thread_ring(void *__tdata)
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
+	np = perf_nptou(np_str);
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
 static struct thread_data *create_thread_data(void)
 {
 	struct thread_data *threads;
@@ -329,6 +358,9 @@ int bench_sched_pipe(int argc, const char **argv)
 
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

