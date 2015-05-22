From: =?UTF-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>
Subject: [RFC] Add --show-total-period for perf annotate
Date: Fri, 22 May 2015 16:39:06 +0200
Message-ID: <555F3F8A.6000204@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090100050401060707090305"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40354 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756809AbbEVOjI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 22 May 2015 10:39:08 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>

This is a multi-part message in MIME format.
--------------090100050401060707090305
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

I've been working on a new feature for perf annotate, which should be able to annotate
instructions with total spent time (compared to percentage usage).

Let's consider following use-case. You want to compare two different compilers
on the same code base and let's assume 90% of wall-time is spent in a single function.
Moreover, let's say that these compilers produce assembly of a totally different size.

In such case, it's very useful to get an approximation of spent time on a bunch of instructions,
which can be compared among other compilers. Otherwise, one has to somehow sum percentages and compare
it to size of a function.

Mail contains my experimental patch.

However, last missing thing is that I need to calculate portion of cycles a function
utilizes. May I ask you for help as perf annotate does not count these portions.

Thanks,
Martin

--------------090100050401060707090305
Content-Type: text/x-patch;
 name="0001-First-semi-working-version.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-First-semi-working-version.patch"

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index b57a027..cce19d6 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -326,6 +326,8 @@ int cmd_annotate(int argc, const char **argv, const char *prefix __maybe_unused)
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
 		    "Show event group information together"),
+	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
+		    "Show a column with the sum of periods"),
 	OPT_END()
 	};
 	int ret = hists__init();
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5dfe913..dfd0c8c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -484,6 +484,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_session *session;
 	bool disabled = false, draining = false;
 	int fd;
+	unsigned long long t0, t1;
 
 	rec->progname = argv[0];
 
@@ -623,6 +624,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (!target__none(&opts->target) && !opts->initial_delay)
 		perf_evlist__enable(rec->evlist);
 
+	t0 = rdclock();
+
 	/*
 	 * Let the child rip
 	 */
@@ -692,6 +695,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	t1 = rdclock();
+	walltime_nsecs = t1 - t0;
+
 	if (!quiet)
 		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
 
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index aa79fb8..0acdf4c 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -35,6 +35,8 @@ extern const char *input_name;
 extern bool perf_host, perf_guest;
 extern const char perf_version_string[];
 
+extern unsigned long long walltime_nsecs;
+
 void pthread__unblock_sigwinch(void);
 
 #include "util/target.h"
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e5250eb..e7af8ec 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -113,7 +113,12 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		for (i = 0; i < ab->nr_events; i++) {
 			ui_browser__set_percent_color(browser, bdl->percent[i],
 						      current_entry);
-			slsmg_printf("%6.2f ", bdl->percent[i]);
+
+			if (symbol_conf.show_total_period)
+			  slsmg_printf("%7.0f ", bdl->percent[i] *
+				       walltime_nsecs / (100 * 1e6));
+			else
+			  slsmg_printf("%7.2f ", bdl->percent[i]);
 		}
 	} else {
 		ui_browser__set_percent_color(browser, 0, current_entry);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7f5bdfc..263e1bf 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -753,7 +753,12 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		for (i = 0; i < nr_percent; i++) {
 			percent = ppercents[i];
 			color = get_percent_color(percent);
-			color_fprintf(stdout, color, " %7.2f", percent);
+
+			if (symbol_conf.show_total_period)
+			  color_fprintf(stdout, color, " %7.0f",
+					percent * walltime_nsecs / (100 * 1e6));
+			else
+			  color_fprintf(stdout, color, " %7.2f", percent);
 		}
 
 		printf(" :	");
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3f0d809..a1d254b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -47,6 +47,8 @@ struct perf_file_attr {
 	struct perf_file_section	ids;
 };
 
+unsigned long long walltime_nsecs;
+
 void perf_header__set_feat(struct perf_header *header, int feat)
 {
 	set_bit(feat, header->adds_features);
@@ -883,6 +885,14 @@ static int write_auxtrace(int fd, struct perf_header *h,
 	return err;
 }
 
+static int write_total_wall_time(int fd, struct perf_header *h __maybe_unused,
+			   struct perf_evlist *evlist __maybe_unused)
+{
+	do_write (fd, &walltime_nsecs, sizeof (walltime_nsecs));
+	return 0;
+}
+
+
 static void print_hostname(struct perf_header *ph, int fd __maybe_unused,
 			   FILE *fp)
 {
@@ -1171,6 +1181,13 @@ static void print_auxtrace(struct perf_header *ph __maybe_unused,
 	fprintf(fp, "# contains AUX area data (e.g. instruction trace)\n");
 }
 
+static void print_total_wall_time(struct perf_header *ph, int fd __maybe_unused,
+			    FILE *fp)
+{
+	fprintf(fp, "# total wall-time: %.9f second\n",
+		ph->env.total_wall_time / 1e9);
+}
+
 static void print_pmu_mappings(struct perf_header *ph, int fd __maybe_unused,
 			       FILE *fp)
 {
@@ -1857,6 +1874,23 @@ static int process_auxtrace(struct perf_file_section *section,
 	return err;
 }
 
+static int process_total_wall_time(struct perf_file_section *section __maybe_unused,
+			     struct perf_header *ph, int fd,
+			     void *data __maybe_unused)
+{
+	ssize_t ret;
+
+	ret = readn(fd, &walltime_nsecs, sizeof(walltime_nsecs));
+	if (ret != sizeof(walltime_nsecs))
+		return -1;
+
+	if (ph->needs_swap)
+		walltime_nsecs = bswap_64(walltime_nsecs);
+
+	ph->env.total_wall_time = walltime_nsecs;
+	return 0;
+}
+
 struct feature_ops {
 	int (*write)(int fd, struct perf_header *h, struct perf_evlist *evlist);
 	void (*print)(struct perf_header *h, int fd, FILE *fp);
@@ -1898,6 +1932,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPP(HEADER_PMU_MAPPINGS,	pmu_mappings),
 	FEAT_OPP(HEADER_GROUP_DESC,	group_desc),
 	FEAT_OPP(HEADER_AUXTRACE,	auxtrace),
+	FEAT_OPP(HEADER_TOTAL_WALLTIME,	total_wall_time),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index d4d5796..f47571a 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -31,6 +31,7 @@ enum {
 	HEADER_PMU_MAPPINGS,
 	HEADER_GROUP_DESC,
 	HEADER_AUXTRACE,
+	HEADER_TOTAL_WALLTIME,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
@@ -88,6 +89,7 @@ struct perf_session_env {
 	char			*sibling_threads;
 	char			*numa_nodes;
 	char			*pmu_mappings;
+	unsigned long long	total_wall_time;
 };
 
 struct perf_header {
-- 
2.1.4


--------------090100050401060707090305--
