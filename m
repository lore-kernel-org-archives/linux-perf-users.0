Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD016E88D;
	Wed, 31 Jul 2024 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470108; cv=none; b=fokDKkCbWgVuflRFtVgTV0/fvbH44JH8mo1w8/97a1oWqMQzV7ILkrtg09SWRcmJkG2/HbURZkxz4vggQao28XmsEjDfAhMybyCAHdFvlAirZpiMAArSLdS1E+ObW2o8FZia+/snc6N8VNqgbULGea+acs53RrSnpqap4wvVpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470108; c=relaxed/simple;
	bh=oRdg+rZVqR1NxDWvlBlQywV1YWczIkIRxIVOwxk5/fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsAj16I0RjI5Oo7y1YPy6/3I8M2/KDH8ZXrCQnUNOo2uisZ3OyeQo7xbJQ7bddUCLZ+NCW9ERrhcW80eDJt9jvvTn8Al/SRMjGN4YfE2KkofdoxeHPH18r8UNy3EGLXFEavmRe7ZcTsKKxs3olbLWV/djKbo71BuH5ciaCl02es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsmibHKx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsmibHKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892C5C4AF19;
	Wed, 31 Jul 2024 23:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470108;
	bh=oRdg+rZVqR1NxDWvlBlQywV1YWczIkIRxIVOwxk5/fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsmibHKxZ/y6eq6kWnKFu+pvRjD9cYuwPa7GsiA+GG108fXEpum840Kx97bc+0f9P
	 NexSZvS32a1oMUD+7kA5wjHk8GzlWDzGdxAele1GhGYvp/uY13cQ3nk8JWsg3OQqBA
	 uBKQKpFycxIZnTy5nrnnEbumlSt4Qf05v4dk0VvIVIISU6V4CxazAoPfBm0ZYzZMck
	 fRZK92Zx+TpCH9ARdY120JvYUvqybfJ94gOumNFQgU8WWMi8VdJ87CPPETp/uNXR/1
	 tg4xtsOM96Iwf/qYSjHtBPulpHTiBdm5EAr1N1J3VCgS7BZFBQMRfaXZpVKUBaBK/I
	 /1AWFXv7hIYWg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>
Subject: [PATCH 3/6] perf mem: Rework command option handling
Date: Wed, 31 Jul 2024 16:55:02 -0700
Message-ID: <20240731235505.710436-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240731235505.710436-1-namhyung@kernel.org>
References: <20240731235505.710436-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the common option and ones for record or report.  Otherwise -U in
the record option cannot be used because it clashes with in the common
(or report) option.  Also rename report_events() to __cmd_report() to
follow the convention and to be sync with the record part.

Also set the flag PARSE_OPT_STOP_AT_NON_OPTION for the common option so
that it can show the help message in the subcommand like below:

  $ perf mem record -h

   Usage: perf mem record [<options>] [<command>]
      or: perf mem record [<options>] -- <command> [<options>]

      -C, --cpu <cpu>       list of cpus to profile
      -e, --event <event>   event selector. use 'perf mem record -e list' to list available events
      -f, --force           don't complain, do it
      -K, --all-kernel      collect only kernel level data
      -p, --phys-data       Record/Report sample physical addresses
      -t, --type <type>     memory operations(load,store) Default load,store
      -U, --all-user        collect only user level data
      -v, --verbose         be more verbose (show counter open errors, etc)
          --data-page-size  Record/Report sample data address page size
          --ldlat <n>       mem-loads latency

Cc: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-mem.c | 79 +++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 93413cfcd585..819edaf6b1df 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -34,6 +34,8 @@ struct perf_mem {
 	bool			force;
 	bool			phys_addr;
 	bool			data_page_size;
+	bool			all_kernel;
+	bool			all_user;
 	int			operation;
 	const char		*cpu_list;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -62,33 +64,19 @@ static int parse_record_events(const struct option *opt,
 	return 0;
 }
 
-static const char * const __usage[] = {
-	"perf mem record [<options>] [<command>]",
-	"perf mem record [<options>] -- <command> [<options>]",
-	NULL
-};
-
-static const char * const *record_mem_usage = __usage;
-
-static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
+static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
+			const struct option *options)
 {
 	int rec_argc, i = 0, j;
 	int start, end;
 	const char **rec_argv;
 	int ret;
-	bool all_user = false, all_kernel = false;
 	struct perf_mem_event *e;
 	struct perf_pmu *pmu;
-	struct option options[] = {
-	OPT_CALLBACK('e', "event", &mem, "event",
-		     "event selector. use 'perf mem record -e list' to list available events",
-		     parse_record_events),
-	OPT_UINTEGER(0, "ldlat", &perf_mem_events__loads_ldlat, "mem-loads latency"),
-	OPT_INCR('v', "verbose", &verbose,
-		 "be more verbose (show counter open errors, etc)"),
-	OPT_BOOLEAN('U', "all-user", &all_user, "collect only user level data"),
-	OPT_BOOLEAN('K', "all-kernel", &all_kernel, "collect only kernel level data"),
-	OPT_END()
+	const char * const record_usage[] = {
+		"perf mem record [<options>] [<command>]",
+		"perf mem record [<options>] -- <command> [<options>]",
+		NULL
 	};
 
 	pmu = perf_mem_events_find_pmu();
@@ -102,7 +90,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 		return -1;
 	}
 
-	argc = parse_options(argc, argv, options, record_mem_usage,
+	argc = parse_options(argc, argv, options, record_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
 	/* Max number of arguments multiplied by number of PMUs that can support them. */
@@ -158,10 +146,10 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 		goto out;
 	end = i;
 
-	if (all_user)
+	if (mem->all_user)
 		rec_argv[i++] = "--all-user";
 
-	if (all_kernel)
+	if (mem->all_kernel)
 		rec_argv[i++] = "--all-kernel";
 
 	if (mem->cpu_list) {
@@ -319,6 +307,7 @@ static int report_raw_events(struct perf_mem *mem)
 	perf_session__delete(session);
 	return ret;
 }
+
 static char *get_sort_order(struct perf_mem *mem)
 {
 	bool has_extra_options = (mem->phys_addr | mem->data_page_size) ? true : false;
@@ -346,11 +335,19 @@ static char *get_sort_order(struct perf_mem *mem)
 	return strdup(sort);
 }
 
-static int report_events(int argc, const char **argv, struct perf_mem *mem)
+static int __cmd_report(int argc, const char **argv, struct perf_mem *mem,
+			const struct option *options)
 {
 	const char **rep_argv;
 	int ret, i = 0, j, rep_argc;
 	char *new_sort_order;
+	const char * const report_usage[] = {
+		"perf mem report [<options>]",
+		NULL
+	};
+
+	argc = parse_options(argc, argv, options, report_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
 
 	if (mem->dump_raw)
 		return report_raw_events(mem);
@@ -368,7 +365,7 @@ static int report_events(int argc, const char **argv, struct perf_mem *mem)
 	if (new_sort_order)
 		rep_argv[i++] = new_sort_order;
 
-	for (j = 1; j < argc; j++, i++)
+	for (j = 0; j < argc; j++, i++)
 		rep_argv[i] = argv[j];
 
 	ret = cmd_report(i, rep_argv);
@@ -475,22 +472,36 @@ int cmd_mem(int argc, const char **argv)
 	OPT_CALLBACK('t', "type", &mem.operation,
 		   "type", "memory operations(load,store) Default load,store",
 		    parse_mem_ops),
+	OPT_STRING('C', "cpu", &mem.cpu_list, "cpu",
+		   "list of cpus to profile"),
+	OPT_BOOLEAN('f', "force", &mem.force, "don't complain, do it"),
+	OPT_INCR('v', "verbose", &verbose,
+		 "be more verbose (show counter open errors, etc)"),
+	OPT_BOOLEAN('p', "phys-data", &mem.phys_addr, "Record/Report sample physical addresses"),
+	OPT_BOOLEAN(0, "data-page-size", &mem.data_page_size, "Record/Report sample data address page size"),
+	OPT_END()
+	};
+	const struct option record_options[] = {
+	OPT_CALLBACK('e', "event", &mem, "event",
+		     "event selector. use 'perf mem record -e list' to list available events",
+		     parse_record_events),
+	OPT_UINTEGER(0, "ldlat", &perf_mem_events__loads_ldlat, "mem-loads latency"),
+	OPT_BOOLEAN('U', "all-user", &mem.all_user, "collect only user level data"),
+	OPT_BOOLEAN('K', "all-kernel", &mem.all_kernel, "collect only kernel level data"),
+	OPT_PARENT(mem_options)
+	};
+	const struct option report_options[] = {
 	OPT_BOOLEAN('D', "dump-raw-samples", &mem.dump_raw,
 		    "dump raw samples in ASCII"),
 	OPT_BOOLEAN('U', "hide-unresolved", &mem.hide_unresolved,
 		    "Only display entries resolved to a symbol"),
 	OPT_STRING('i', "input", &input_name, "file",
 		   "input file name"),
-	OPT_STRING('C', "cpu", &mem.cpu_list, "cpu",
-		   "list of cpus to profile"),
 	OPT_STRING_NOEMPTY('x', "field-separator", &symbol_conf.field_sep,
 		   "separator",
 		   "separator for columns, no spaces will be added"
 		   " between columns '.' is reserved."),
-	OPT_BOOLEAN('f', "force", &mem.force, "don't complain, do it"),
-	OPT_BOOLEAN('p', "phys-data", &mem.phys_addr, "Record/Report sample physical addresses"),
-	OPT_BOOLEAN(0, "data-page-size", &mem.data_page_size, "Record/Report sample data address page size"),
-	OPT_END()
+	OPT_PARENT(mem_options)
 	};
 	const char *const mem_subcommands[] = { "record", "report", NULL };
 	const char *mem_usage[] = {
@@ -499,7 +510,7 @@ int cmd_mem(int argc, const char **argv)
 	};
 
 	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
-					mem_usage, PARSE_OPT_KEEP_UNKNOWN);
+					mem_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (!argc || !(strncmp(argv[0], "rec", 3) || mem.operation))
 		usage_with_options(mem_usage, mem_options);
@@ -512,9 +523,9 @@ int cmd_mem(int argc, const char **argv)
 	}
 
 	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
-		return __cmd_record(argc, argv, &mem);
+		return __cmd_record(argc, argv, &mem, record_options);
 	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))
-		return report_events(argc, argv, &mem);
+		return __cmd_report(argc, argv, &mem, report_options);
 	else
 		usage_with_options(mem_usage, mem_options);
 
-- 
2.46.0.rc1.232.g9752f9e123-goog

