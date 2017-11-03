From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/19] perf tools: Add struct perf_data_file
Date: Fri,  3 Nov 2017 10:54:54 -0300
Message-ID: <20171103135503.4921-11-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756408AbdKCN4K (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Nov 2017 09:56:10 -0400
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, Changbin Du <changbin.du@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Add struct perf_data_file to represent a single file within a perf_data
struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Changbin Du <changbin.du@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-c3f9p4xzykr845ktqcek6p4t@git.kernel.org
[ Fixup recent changes in 'perf script --per-event-dump' ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c      |  4 ++--
 tools/perf/builtin-buildid-cache.c |  4 ++--
 tools/perf/builtin-buildid-list.c  |  8 ++++---
 tools/perf/builtin-c2c.c           |  4 ++--
 tools/perf/builtin-diff.c          | 12 +++++-----
 tools/perf/builtin-evlist.c        |  8 ++++---
 tools/perf/builtin-inject.c        | 12 ++++++----
 tools/perf/builtin-kmem.c          |  2 +-
 tools/perf/builtin-kvm.c           |  8 ++++---
 tools/perf/builtin-lock.c          |  8 ++++---
 tools/perf/builtin-mem.c           |  8 ++++---
 tools/perf/builtin-record.c        |  6 ++---
 tools/perf/builtin-report.c        |  6 ++---
 tools/perf/builtin-sched.c         | 16 ++++++++-----
 tools/perf/builtin-script.c        | 14 ++++++-----
 tools/perf/builtin-stat.c          |  6 ++---
 tools/perf/builtin-timechart.c     |  8 ++++---
 tools/perf/builtin-trace.c         |  8 ++++---
 tools/perf/tests/topology.c        | 14 +++++++----
 tools/perf/util/data-convert-bt.c  |  8 +++----
 tools/perf/util/data.c             | 48 +++++++++++++++++++-------------------
 tools/perf/util/data.h             | 10 +++++---
 tools/perf/util/header.c           |  2 +-
 23 files changed, 127 insertions(+), 97 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 2d06be81a109..2d5c87578f83 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -356,7 +356,7 @@ static int __cmd_annotate(struct perf_annotate *ann)
 	}
 
 	if (total_nr_samples == 0) {
-		ui__error("The %s file has no samples!\n", session->data->path);
+		ui__error("The %s file has no samples!\n", session->data->file.path);
 		goto out;
 	}
 
@@ -482,7 +482,7 @@ int cmd_annotate(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
-	data.path  = input_name;
+	data.file.path = input_name;
 
 	annotate.session = perf_session__new(&data, false, &annotate.tool);
 	if (annotate.session == NULL)
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 9fceae47a02e..cb2453b29365 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -352,8 +352,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 		nsi = nsinfo__new(ns_id);
 
 	if (missing_filename) {
-		data.path = missing_filename;
-		data.force = force;
+		data.file.path = missing_filename;
+		data.force     = force;
 
 		session = perf_session__new(&data, false, NULL);
 		if (session == NULL)
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 72bdc0eba990..00099a830b0d 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -51,9 +51,11 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.path  = input_name,
-		.mode  = PERF_DATA_MODE_READ,
-		.force = force,
+		.file      = {
+			.path = input_name,
+		},
+		.mode      = PERF_DATA_MODE_READ,
+		.force     = force,
 	};
 
 	symbol__elf_init();
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 87a52d09da29..9590fdcc6484 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2572,8 +2572,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (!input_name || !strlen(input_name))
 		input_name = "perf.data";
 
-	data.path  = input_name;
-	data.force = symbol_conf.force;
+	data.file.path = input_name;
+	data.force     = symbol_conf.force;
 
 	err = setup_display(display);
 	if (err)
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 5292e3d13cec..67570e6417e5 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -707,7 +707,7 @@ static void data__fprintf(void)
 
 	data__for_each_file(i, d)
 		fprintf(stdout, "#  [%d] %s %s\n",
-			d->idx, d->data.path,
+			d->idx, d->data.file.path,
 			!d->idx ? "(Baseline)" : "");
 
 	fprintf(stdout, "#\n");
@@ -778,14 +778,14 @@ static int __cmd_diff(void)
 	data__for_each_file(i, d) {
 		d->session = perf_session__new(&d->data, false, &tool);
 		if (!d->session) {
-			pr_err("Failed to open %s\n", d->data.path);
+			pr_err("Failed to open %s\n", d->data.file.path);
 			ret = -1;
 			goto out_delete;
 		}
 
 		ret = perf_session__process_events(d->session);
 		if (ret) {
-			pr_err("Failed to process %s\n", d->data.path);
+			pr_err("Failed to process %s\n", d->data.file.path);
 			goto out_delete;
 		}
 
@@ -1288,9 +1288,9 @@ static int data_init(int argc, const char **argv)
 	data__for_each_file(i, d) {
 		struct perf_data *data = &d->data;
 
-		data->path  = use_default ? defaults[i] : argv[i];
-		data->mode  = PERF_DATA_MODE_READ,
-		data->force = force,
+		data->file.path = use_default ? defaults[i] : argv[i];
+		data->mode      = PERF_DATA_MODE_READ,
+		data->force     = force,
 
 		d->idx  = i;
 	}
diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index cd79c26e16a4..93b85dc857b6 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -22,9 +22,11 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 	struct perf_session *session;
 	struct perf_evsel *pos;
 	struct perf_data data = {
-		.path = file_name,
-		.mode = PERF_DATA_MODE_READ,
-		.force = details->force,
+		.file      = {
+			.path = file_name,
+		},
+		.mode      = PERF_DATA_MODE_READ,
+		.force     = details->force,
 	};
 	bool has_tracepoint = false;
 
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ac7486f6c46f..91e65093d3c2 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -145,7 +145,7 @@ static s64 perf_event__repipe_auxtrace(struct perf_tool *tool,
 	if (!inject->output.is_pipe) {
 		off_t offset;
 
-		offset = lseek(inject->output.fd, 0, SEEK_CUR);
+		offset = lseek(inject->output.file.fd, 0, SEEK_CUR);
 		if (offset == -1)
 			return -errno;
 		ret = auxtrace_index__auxtrace_event(&session->auxtrace_index,
@@ -775,8 +775,10 @@ int cmd_inject(int argc, const char **argv)
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
 		.output = {
-			.path = "-",
-			.mode = PERF_DATA_MODE_WRITE,
+			.file      = {
+				.path = "-",
+			},
+			.mode      = PERF_DATA_MODE_WRITE,
 		},
 	};
 	struct perf_data data = {
@@ -789,7 +791,7 @@ int cmd_inject(int argc, const char **argv)
 			    "Inject build-ids into the output stream"),
 		OPT_STRING('i', "input", &inject.input_name, "file",
 			   "input file name"),
-		OPT_STRING('o', "output", &inject.output.path, "file",
+		OPT_STRING('o', "output", &inject.output.file.path, "file",
 			   "output file name"),
 		OPT_BOOLEAN('s', "sched-stat", &inject.sched_stat,
 			    "Merge sched-stat and sched-switch for getting events "
@@ -836,7 +838,7 @@ int cmd_inject(int argc, const char **argv)
 
 	inject.tool.ordered_events = inject.sched_stat;
 
-	data.path = inject.input_name;
+	data.file.path = inject.input_name;
 	inject.session = perf_session__new(&data, true, &inject.tool);
 	if (inject.session == NULL)
 		return -1;
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index d45740a3e5f1..abcab75cc5b9 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1949,7 +1949,7 @@ int cmd_kmem(int argc, const char **argv)
 		return __cmd_record(argc, argv);
 	}
 
-	data.path = input_name;
+	data.file.path = input_name;
 
 	kmem_session = session = perf_session__new(&data, false, &perf_kmem);
 	if (session == NULL)
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 4301fc34f23c..0af4c092b471 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1068,9 +1068,11 @@ static int read_events(struct perf_kvm_stat *kvm)
 		.ordered_events		= true,
 	};
 	struct perf_data file = {
-		.path = kvm->file_name,
-		.mode = PERF_DATA_MODE_READ,
-		.force = kvm->force,
+		.file      = {
+			.path = kvm->file_name,
+		},
+		.mode      = PERF_DATA_MODE_READ,
+		.force     = kvm->force,
 	};
 
 	kvm->tool = eops;
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 2e281f7b0fca..81af29400b64 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -865,9 +865,11 @@ static int __cmd_report(bool display_info)
 		.ordered_events	 = true,
 	};
 	struct perf_data data = {
-		.path = input_name,
-		.mode = PERF_DATA_MODE_READ,
-		.force = force,
+		.file      = {
+			.path = input_name,
+		},
+		.mode      = PERF_DATA_MODE_READ,
+		.force     = force,
 	};
 
 	session = perf_session__new(&data, false, &eops);
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 5a4a6f8e614d..f09fd1a1b813 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -237,9 +237,11 @@ static int process_sample_event(struct perf_tool *tool,
 static int report_raw_events(struct perf_mem *mem)
 {
 	struct perf_data data = {
-		.path = input_name,
-		.mode = PERF_DATA_MODE_READ,
-		.force = mem->force,
+		.file      = {
+			.path = input_name,
+		},
+		.mode      = PERF_DATA_MODE_READ,
+		.force     = mem->force,
 	};
 	int ret;
 	struct perf_session *session = perf_session__new(&data, false,
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0ab7dd0e4f2b..f4d9fc54b382 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -618,7 +618,7 @@ record__switch_output(struct record *rec, bool at_exit)
 
 	if (!quiet)
 		fprintf(stderr, "[ perf record: Dump %s.%s ]\n",
-			data->path, timestamp);
+			data->file.path, timestamp);
 
 	/* Output tracking events */
 	if (!at_exit) {
@@ -1118,7 +1118,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 		fprintf(stderr,	"[ perf record: Captured and wrote %.3f MB %s%s%s ]\n",
 			perf_data__size(data) / 1024.0 / 1024.0,
-			data->path, postfix, samples);
+			data->file.path, postfix, samples);
 	}
 
 out_delete_session:
@@ -1482,7 +1482,7 @@ static struct option __record_options[] = {
 	OPT_STRING('C', "cpu", &record.opts.target.cpu_list, "cpu",
 		    "list of cpus to monitor"),
 	OPT_U64('c', "count", &record.opts.user_interval, "event period to sample"),
-	OPT_STRING('o', "output", &record.data.path, "file",
+	OPT_STRING('o', "output", &record.data.file.path, "file",
 		    "output file name"),
 	OPT_BOOLEAN_SET('i', "no-inherit", &record.opts.no_inherit,
 			&record.opts.no_inherit_set,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0dc323772b5e..3c2d9d4932f3 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -637,7 +637,7 @@ static int __cmd_report(struct report *rep)
 		rep->nr_entries += evsel__hists(pos)->nr_entries;
 
 	if (rep->nr_entries == 0) {
-		ui__error("The %s file has no samples!\n", data->path);
+		ui__error("The %s file has no samples!\n", data->file.path);
 		return 0;
 	}
 
@@ -940,8 +940,8 @@ int cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
-	data.path  = input_name;
-	data.force = symbol_conf.force;
+	data.file.path = input_name;
+	data.force     = symbol_conf.force;
 
 repeat:
 	session = perf_session__new(&data, false, &report.tool);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cb5410511f69..47e54348b5ed 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1701,9 +1701,11 @@ static int perf_sched__read_events(struct perf_sched *sched)
 	};
 	struct perf_session *session;
 	struct perf_data data = {
-		.path = input_name,
-		.mode = PERF_DATA_MODE_READ,
-		.force = sched->force,
+		.file      = {
+			.path = input_name,
+		},
+		.mode      = PERF_DATA_MODE_READ,
+		.force     = sched->force,
 	};
 	int rc = -1;
 
@@ -2903,9 +2905,11 @@ static int perf_sched__timehist(struct perf_sched *sched)
 		{ "sched:sched_migrate_task", timehist_migrate_task_event, },
 	};
 	struct perf_data data = {
-		.path = input_name,
-		.mode = PERF_DATA_MODE_READ,
-		.force = sched->force,
+		.file      = {
+			.path = input_name,
+		},
+		.mode      = PERF_DATA_MODE_READ,
+		.force     = sched->force,
 	};
 
 	struct perf_session *session;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8f8fa952b506..89975e30c0ba 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -222,7 +222,7 @@ static struct perf_evsel_script *perf_evsel_script__new(struct perf_evsel *evsel
 	struct perf_evsel_script *es = malloc(sizeof(*es));
 
 	if (es != NULL) {
-		if (asprintf(&es->filename, "%s.%s.dump", data->path, perf_evsel__name(evsel)) < 0)
+		if (asprintf(&es->filename, "%s.%s.dump", data->file.path, perf_evsel__name(evsel)) < 0)
 			goto out_free;
 		es->fp = fopen(es->filename, "w");
 		if (es->fp == NULL)
@@ -2591,8 +2591,10 @@ int find_scripts(char **scripts_array, char **scripts_path_array)
 	DIR *scripts_dir, *lang_dir;
 	struct perf_session *session;
 	struct perf_data data = {
-		.path = input_name,
-		.mode = PERF_DATA_MODE_READ,
+		.file      = {
+			.path = input_name,
+		},
+		.mode      = PERF_DATA_MODE_READ,
 	};
 	char *temp;
 	int i = 0;
@@ -2982,8 +2984,8 @@ int cmd_script(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, options, script_subcommands, script_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	data.path = input_name;
-	data.force = symbol_conf.force;
+	data.file.path = input_name;
+	data.force     = symbol_conf.force;
 
 	if (argc > 1 && !strncmp(argv[0], "rec", strlen("rec"))) {
 		rec_script_path = get_script_path(argv[1], RECORD_SUFFIX);
@@ -3206,7 +3208,7 @@ int cmd_script(int argc, const char **argv)
 			goto out_delete;
 		}
 
-		input = open(data.path, O_RDONLY);	/* input_name */
+		input = open(data.file.path, O_RDONLY);	/* input_name */
 		if (input < 0) {
 			err = -errno;
 			perror("failed to open file");
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 85af6d291c06..fa5896270022 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2412,7 +2412,7 @@ static int __cmd_record(int argc, const char **argv)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (output_name)
-		data->path = output_name;
+		data->file.path = output_name;
 
 	if (run_count != 1 || forever) {
 		pr_err("Cannot use -r option with perf stat record.\n");
@@ -2585,8 +2585,8 @@ static int __cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
-	perf_stat.data.path = input_name;
-	perf_stat.data.mode = PERF_DATA_MODE_READ;
+	perf_stat.data.file.path = input_name;
+	perf_stat.data.mode      = PERF_DATA_MODE_READ;
 
 	session = perf_session__new(&perf_stat.data, false, &perf_stat.tool);
 	if (session == NULL)
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 0f79ea5e2f0f..813698a9b8c7 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1602,9 +1602,11 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 		{ "syscalls:sys_exit_select",		process_exit_poll },
 	};
 	struct perf_data data = {
-		.path = input_name,
-		.mode = PERF_DATA_MODE_READ,
-		.force = tchart->force,
+		.file      = {
+			.path = input_name,
+		},
+		.mode      = PERF_DATA_MODE_READ,
+		.force     = tchart->force,
 	};
 
 	struct perf_session *session = perf_session__new(&data, false,
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7def6947ad61..c373f9a3e4a9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2533,9 +2533,11 @@ static int trace__replay(struct trace *trace)
 		{ "probe:vfs_getname",	     trace__vfs_getname, },
 	};
 	struct perf_data data = {
-		.path  = input_name,
-		.mode  = PERF_DATA_MODE_READ,
-		.force = trace->force,
+		.file      = {
+			.path = input_name,
+		},
+		.mode      = PERF_DATA_MODE_READ,
+		.force     = trace->force,
 	};
 	struct perf_session *session;
 	struct perf_evsel *evsel;
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 7536782e8495..9bbfed51f1d6 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -30,8 +30,10 @@ static int session_write_header(char *path)
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.path = path,
-		.mode = PERF_DATA_MODE_WRITE,
+		.file      = {
+			.path = path,
+		},
+		.mode      = PERF_DATA_MODE_WRITE,
 	};
 
 	session = perf_session__new(&data, false, NULL);
@@ -46,7 +48,7 @@ static int session_write_header(char *path)
 	session->header.data_size += DATA_SIZE;
 
 	TEST_ASSERT_VAL("failed to write header",
-			!perf_session__write_header(session, session->evlist, data.fd, true));
+			!perf_session__write_header(session, session->evlist, data.file.fd, true));
 
 	perf_session__delete(session);
 
@@ -57,8 +59,10 @@ static int check_cpu_topology(char *path, struct cpu_map *map)
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.path = path,
-		.mode = PERF_DATA_MODE_READ,
+		.file      = {
+			.path = path,
+		},
+		.mode      = PERF_DATA_MODE_READ,
 	};
 	int i;
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 9fdae383a58c..5744c12641a5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1578,9 +1578,9 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.path = input,
-		.mode = PERF_DATA_MODE_READ,
-		.force = opts->force,
+		.file.path = input,
+		.mode      = PERF_DATA_MODE_READ,
+		.force     = opts->force,
 	};
 	struct convert c = {
 		.tool = {
@@ -1650,7 +1650,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 
 	fprintf(stderr,
 		"[ perf data convert: Converted '%s' into CTF data '%s' ]\n",
-		data.path, path);
+		data.file.path, path);
 
 	fprintf(stderr,
 		"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples",
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index a6eea3df4c10..07ef56a4123c 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -28,16 +28,16 @@ static bool check_pipe(struct perf_data *data)
 	int fd = perf_data__is_read(data) ?
 		 STDIN_FILENO : STDOUT_FILENO;
 
-	if (!data->path) {
+	if (!data->file.path) {
 		if (!fstat(fd, &st) && S_ISFIFO(st.st_mode))
 			is_pipe = true;
 	} else {
-		if (!strcmp(data->path, "-"))
+		if (!strcmp(data->file.path, "-"))
 			is_pipe = true;
 	}
 
 	if (is_pipe)
-		data->fd = fd;
+		data->file.fd = fd;
 
 	return data->is_pipe = is_pipe;
 }
@@ -46,13 +46,13 @@ static int check_backup(struct perf_data *data)
 {
 	struct stat st;
 
-	if (!stat(data->path, &st) && st.st_size) {
+	if (!stat(data->file.path, &st) && st.st_size) {
 		/* TODO check errors properly */
 		char oldname[PATH_MAX];
 		snprintf(oldname, sizeof(oldname), "%s.old",
-			 data->path);
+			 data->file.path);
 		unlink(oldname);
-		rename(data->path, oldname);
+		rename(data->file.path, oldname);
 	}
 
 	return 0;
@@ -64,13 +64,13 @@ static int open_file_read(struct perf_data *data)
 	int fd;
 	char sbuf[STRERR_BUFSIZE];
 
-	fd = open(data->path, O_RDONLY);
+	fd = open(data->file.path, O_RDONLY);
 	if (fd < 0) {
 		int err = errno;
 
-		pr_err("failed to open %s: %s", data->path,
+		pr_err("failed to open %s: %s", data->file.path,
 			str_error_r(err, sbuf, sizeof(sbuf)));
-		if (err == ENOENT && !strcmp(data->path, "perf.data"))
+		if (err == ENOENT && !strcmp(data->file.path, "perf.data"))
 			pr_err("  (try 'perf record' first)");
 		pr_err("\n");
 		return -err;
@@ -81,13 +81,13 @@ static int open_file_read(struct perf_data *data)
 
 	if (!data->force && st.st_uid && (st.st_uid != geteuid())) {
 		pr_err("File %s not owned by current user or root (use -f to override)\n",
-		       data->path);
+		       data->file.path);
 		goto out_close;
 	}
 
 	if (!st.st_size) {
 		pr_info("zero-sized data (%s), nothing to do!\n",
-			data->path);
+			data->file.path);
 		goto out_close;
 	}
 
@@ -107,11 +107,11 @@ static int open_file_write(struct perf_data *data)
 	if (check_backup(data))
 		return -1;
 
-	fd = open(data->path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
+	fd = open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
 		  S_IRUSR|S_IWUSR);
 
 	if (fd < 0)
-		pr_err("failed to open %s : %s\n", data->path,
+		pr_err("failed to open %s : %s\n", data->file.path,
 			str_error_r(errno, sbuf, sizeof(sbuf)));
 
 	return fd;
@@ -124,7 +124,7 @@ static int open_file(struct perf_data *data)
 	fd = perf_data__is_read(data) ?
 	     open_file_read(data) : open_file_write(data);
 
-	data->fd = fd;
+	data->file.fd = fd;
 	return fd < 0 ? -1 : 0;
 }
 
@@ -133,21 +133,21 @@ int perf_data__open(struct perf_data *data)
 	if (check_pipe(data))
 		return 0;
 
-	if (!data->path)
-		data->path = "perf.data";
+	if (!data->file.path)
+		data->file.path = "perf.data";
 
 	return open_file(data);
 }
 
 void perf_data__close(struct perf_data *data)
 {
-	close(data->fd);
+	close(data->file.fd);
 }
 
 ssize_t perf_data__write(struct perf_data *data,
 			      void *buf, size_t size)
 {
-	return writen(data->fd, buf, size);
+	return writen(data->file.fd, buf, size);
 }
 
 int perf_data__switch(struct perf_data *data,
@@ -162,30 +162,30 @@ int perf_data__switch(struct perf_data *data,
 	if (perf_data__is_read(data))
 		return -EINVAL;
 
-	if (asprintf(&new_filepath, "%s.%s", data->path, postfix) < 0)
+	if (asprintf(&new_filepath, "%s.%s", data->file.path, postfix) < 0)
 		return -ENOMEM;
 
 	/*
 	 * Only fire a warning, don't return error, continue fill
 	 * original file.
 	 */
-	if (rename(data->path, new_filepath))
-		pr_warning("Failed to rename %s to %s\n", data->path, new_filepath);
+	if (rename(data->file.path, new_filepath))
+		pr_warning("Failed to rename %s to %s\n", data->file.path, new_filepath);
 
 	if (!at_exit) {
-		close(data->fd);
+		close(data->file.fd);
 		ret = perf_data__open(data);
 		if (ret < 0)
 			goto out;
 
-		if (lseek(data->fd, pos, SEEK_SET) == (off_t)-1) {
+		if (lseek(data->file.fd, pos, SEEK_SET) == (off_t)-1) {
 			ret = -errno;
 			pr_debug("Failed to lseek to %zu: %s",
 				 pos, strerror(errno));
 			goto out;
 		}
 	}
-	ret = data->fd;
+	ret = data->file.fd;
 out:
 	free(new_filepath);
 	return ret;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index a1f9d70426b1..1797bed3aa4b 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -8,9 +8,13 @@ enum perf_data_mode {
 	PERF_DATA_MODE_READ,
 };
 
+struct perf_data_file {
+	const char	*path;
+	int		 fd;
+};
+
 struct perf_data {
-	const char		*path;
-	int			 fd;
+	struct perf_data_file	 file;
 	bool			 is_pipe;
 	bool			 force;
 	unsigned long		 size;
@@ -34,7 +38,7 @@ static inline int perf_data__is_pipe(struct perf_data *data)
 
 static inline int perf_data__fd(struct perf_data *data)
 {
-	return data->fd;
+	return data->file.fd;
 }
 
 static inline unsigned long perf_data__size(struct perf_data *data)
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d7be552b21c8..6e59dcca9df2 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2889,7 +2889,7 @@ int perf_session__read_header(struct perf_session *session)
 	if (f_header.data.size == 0) {
 		pr_warning("WARNING: The %s file's data size field is 0 which is unexpected.\n"
 			   "Was the 'perf record' command properly terminated?\n",
-			   data->path);
+			   data->file.path);
 	}
 
 	nr_attrs = f_header.attrs.size / f_header.attr_size;
-- 
2.13.6
