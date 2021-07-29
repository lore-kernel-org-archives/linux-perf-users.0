Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B65C432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 06:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198D261053
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 06:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhG2GZL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 02:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbhG2GZF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 02:25:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5763C0613C1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jul 2021 23:25:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q3-20020a25bfc30000b02905592911c932so5073168ybm.15
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jul 2021 23:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XQOuVrSELGecLv75iNCsOnZnEdRh9ikmmSrGWyHBLH4=;
        b=nSkAEDrWPKITHrK4aSDiZwBJfkAPN0aVDh2CLPGpHosu2Bd2cAE7zlIVI41uPPlt5C
         6O3tPn2q4hNOJ2hE5AxMrKEM3z7UJ6IfHV/DUhd/cbNL61hYRvzTv+isuu8TryoiRF4V
         PXi7S6n/GaitUC7ljhQ2NVoWu9HJaAFPZcSmQ9IiWr2zuPsVP3ErdL1qhRpH9U6WhJVo
         2dekGHrai1pxV1FKvQEt4w+Zmb4gTP9ABaV55NPGHDXm7O232hGhOiuLtD5jI/psSRIU
         2wiwnZBG8G2s32Bi/agse1e6nXYyJUK/iRHlLvmOY7P/IFrtio9xPdGzHoBrCRyL9d11
         8pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XQOuVrSELGecLv75iNCsOnZnEdRh9ikmmSrGWyHBLH4=;
        b=QzrTmvqjRm0p9Fk+Ng+sjLu4NF0WleFjvRehcC40gSFleoo2iLNm1FB/P4XUcDdNh8
         RAPxZT59J6eJb6Ytuq1FtK+ZpkoEBt3dgV2U1EbLYc8qzN3EZvwEcR+g7EZ5dApErBiS
         b1oRtNL3WSpI1dwLzEU1b6u2muHLwNsUkdezuFh2uWZyRISOsHUvUS2in6DtJs6s/+e8
         CfBQ91ZOpl2QlI4t0SsHUKJYHkzfQa0OjP18XDt3IEiFK2pMKOnjv97UonpkuRmteOUs
         pIxXZE1TNG39cteOGw+Hge7/p2bCJRziIJVDNQnoOpivWLWhU3QhZWJIDvCtFxGmJuk2
         N4NA==
X-Gm-Message-State: AOAM530rEKvC6o7Xd6Bb8MXGs2o1A5NT5JMMzPk5+QjiMReBQ03FTqpK
        I2Et8fFmyEcKIWoLEiUyvqXJOy9pkZfC
X-Google-Smtp-Source: ABdhPJwjswcBBLkrhK0DIGp23tkU3dYLX+D7HWt+ntnb3sz0/FXyNlDipDu3K888h6cxRobgzjtaapW0WWp7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8f98:bc28:73a6:e8c9])
 (user=irogers job=sendgmr) by 2002:a25:f503:: with SMTP id
 a3mr4272078ybe.501.1627539901919; Wed, 28 Jul 2021 23:25:01 -0700 (PDT)
Date:   Wed, 28 Jul 2021 23:24:50 -0700
In-Reply-To: <20210729062451.1349566-1-irogers@google.com>
Message-Id: <20210729062451.1349566-3-irogers@google.com>
Mime-Version: 1.0
References: <20210729062451.1349566-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 2/3] tools perf: Prefer exit(EXIT_*) over exit(0|1)
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Change exit code to be more intention revealing, replacing exit(0) with
exit(EXIT_SUCCESS) and exit(1) with exit(EXIT_FAILURE).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/bp-modify.c | 4 ++--
 tools/perf/bench/inject-buildid.c     | 8 ++++----
 tools/perf/bench/numa.c               | 2 +-
 tools/perf/bench/sched-messaging.c    | 6 +++---
 tools/perf/bench/sched-pipe.c         | 4 ++--
 tools/perf/bench/syscall.c            | 2 +-
 tools/perf/builtin-c2c.c              | 2 +-
 tools/perf/builtin-ftrace.c           | 2 +-
 tools/perf/builtin-mem.c              | 2 +-
 tools/perf/builtin-script.c           | 4 ++--
 tools/perf/perf.c                     | 8 ++++----
 tools/perf/ui/tui/setup.c             | 4 ++--
 tools/perf/util/dlfilter.c            | 2 +-
 tools/perf/util/help-unknown-cmd.c    | 2 +-
 14 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/perf/arch/x86/tests/bp-modify.c b/tools/perf/arch/x86/tests/bp-modify.c
index dffcf9b52153..9cf1036d0480 100644
--- a/tools/perf/arch/x86/tests/bp-modify.c
+++ b/tools/perf/arch/x86/tests/bp-modify.c
@@ -41,12 +41,12 @@ static int spawn_child(void)
 
 		if (err) {
 			pr_debug("failed to PTRACE_TRACEME\n");
-			exit(1);
+			exit(EXIT_FAILURE);
 		}
 
 		raise(SIGCONT);
 		bp_1();
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 
 	return child;
diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index 55d373b75791..8fd1ec0d371e 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -106,7 +106,7 @@ static void collect_dso(void)
 	dsos = calloc(nr_mmaps * DSO_MMAP_RATIO, sizeof(*dsos));
 	if (dsos == NULL) {
 		printf("  Memory allocation failed\n");
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 
 	if (nftw("/usr/lib/", add_dso, 10, FTW_PHYS) < 0)
@@ -305,7 +305,7 @@ static int setup_injection(struct bench_data *data, bool build_id_all)
 
 		dev_null_fd = open("/dev/null", O_WRONLY);
 		if (dev_null_fd < 0)
-			exit(1);
+			exit(EXIT_FAILURE);
 
 		dup2(dev_null_fd, STDERR_FILENO);
 
@@ -314,7 +314,7 @@ static int setup_injection(struct bench_data *data, bool build_id_all)
 
 		inject_argv = calloc(inject_argc + 1, sizeof(*inject_argv));
 		if (inject_argv == NULL)
-			exit(1);
+			exit(EXIT_FAILURE);
 
 		inject_argv[0] = strdup("inject");
 		inject_argv[1] = strdup("-b");
@@ -326,7 +326,7 @@ static int setup_injection(struct bench_data *data, bool build_id_all)
 
 		cmd_inject(inject_argc, inject_argv);
 
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 
 	pthread_create(&data->th, NULL, data_reader, data);
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index f2640179ada9..a2ee96180444 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -1551,7 +1551,7 @@ static int __bench_numa(const char *name)
 			/* Child process: */
 			worker_process(i);
 
-			exit(0);
+			exit(EXIT_SUCCESS);
 		}
 		pids[i] = pid;
 
diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 488f6e6ba1a5..d03248837777 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -149,7 +149,7 @@ static pthread_t create_worker(void *ctx, void *(*func)(void *))
 			break;
 		case 0:
 			(*func) (ctx);
-			exit(0);
+			exit(EXIT_SUCCESS);
 			break;
 		default:
 			break;
@@ -182,7 +182,7 @@ static void reap_worker(pthread_t id)
 		/* process mode */
 		wait(&proc_status);
 		if (!WIFEXITED(proc_status))
-			exit(1);
+			exit(EXIT_FAILURE);
 	} else {
 		pthread_join(id, &thread_status);
 	}
@@ -319,7 +319,7 @@ int bench_sched_messaging(int argc, const char **argv)
 	default:
 		/* reaching here is something disaster */
 		fprintf(stderr, "Unknown format:%d\n", bench_format);
-		exit(1);
+		exit(EXIT_FAILURE);
 		break;
 	}
 
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index a960e7a93aec..0f5c00a29199 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -135,7 +135,7 @@ int bench_sched_pipe(int argc, const char **argv)
 
 		if (!pid) {
 			worker_thread(threads + 0);
-			exit(0);
+			exit(EXIT_SUCCESS);
 		} else {
 			worker_thread(threads + 1);
 		}
@@ -175,7 +175,7 @@ int bench_sched_pipe(int argc, const char **argv)
 	default:
 		/* reaching here is something disaster */
 		fprintf(stderr, "Unknown format:%d\n", bench_format);
-		exit(1);
+		exit(EXIT_FAILURE);
 		break;
 	}
 
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index 9b751016f4b6..abd49c45ce3b 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -73,7 +73,7 @@ int bench_syscall_basic(int argc, const char **argv)
 	default:
 		/* reaching here is something disaster */
 		fprintf(stderr, "Unknown format:%d\n", bench_format);
-		exit(1);
+		exit(EXIT_FAILURE);
 		break;
 	}
 
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 6dea37f141b2..21ef021b8bbf 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2889,7 +2889,7 @@ static int parse_record_events(const struct option *opt,
 
 	if (!strcmp(str, "list")) {
 		perf_mem_events__list();
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 	if (perf_mem_events__parse(str))
 		exit(-1);
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 87cb11a7a3ee..2411aa4443e0 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -750,7 +750,7 @@ static int opt_list_avail_functions(const struct option *opt __maybe_unused,
 	if (ret < 0)
 		return ret;
 
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
 
 static int parse_filter_func(const struct option *opt, const char *str,
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 0fd2a74dbaca..5d96b6e15992 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -45,7 +45,7 @@ static int parse_record_events(const struct option *opt,
 
 	if (!strcmp(str, "list")) {
 		perf_mem_events__list();
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 	if (perf_mem_events__parse(str))
 		exit(-1);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8c03a9862872..f4763830c7a4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2774,7 +2774,7 @@ static int parse_scriptname(const struct option *opt __maybe_unused,
 
 	if (strcmp(str, "lang") == 0) {
 		list_available_languages();
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 
 	script = strchr(str, ':');
@@ -3175,7 +3175,7 @@ static int list_available_scripts(const struct option *opt __maybe_unused,
 			desc->half_liner ? desc->half_liner : "");
 	}
 
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
 
 static int add_dlarg(const struct option *opt __maybe_unused,
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 2f6b67189b42..ec45dd645030 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -214,11 +214,11 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				set_argv_exec_path(cmd + 1);
 			else {
 				puts(get_argv_exec_path());
-				exit(0);
+				exit(EXIT_SUCCESS);
 			}
 		} else if (!strcmp(cmd, "--html-path")) {
 			puts(system_path(PERF_HTML_PATH));
-			exit(0);
+			exit(EXIT_SUCCESS);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			use_pager = 1;
 		} else if (!strcmp(cmd, "--no-pager")) {
@@ -258,7 +258,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				printf("%s ", p->cmd);
 			}
 			putchar('\n');
-			exit(0);
+			exit(EXIT_SUCCESS);
 		} else if (!strcmp(cmd, "--list-opts")) {
 			unsigned int i;
 
@@ -267,7 +267,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				printf("--%s ", p->long_name);
 			}
 			putchar('\n');
-			exit(0);
+			exit(EXIT_SUCCESS);
 		} else if (!strcmp(cmd, "--debug")) {
 			if (*argc < 2) {
 				fprintf(stderr, "No variable specified for --debug.\n");
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index e9bfe856a5de..867c128d1f22 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -109,7 +109,7 @@ static void ui__signal_backtrace(int sig)
 	size = backtrace(stackdump, ARRAY_SIZE(stackdump));
 	backtrace_symbols_fd(stackdump, size, STDOUT_FILENO);
 
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
 #else
 # define ui__signal_backtrace  ui__signal
@@ -119,7 +119,7 @@ static void ui__signal(int sig)
 {
 	ui__exit(false);
 	psignal(sig, "perf");
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
 
 int ui__init(void)
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index ca33fbc5efde..11cf84ef30b1 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -611,5 +611,5 @@ int list_available_dlfilters(const struct option *opt __maybe_unused,
 
 	free(exec_path);
 out:
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index ab9e16123626..fac794d75b14 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -114,5 +114,5 @@ const char *help_unknown_cmd(const char *cmd)
 			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
 	}
 end:
-	exit(1);
+	exit(EXIT_FAILURE);
 }
-- 
2.32.0.432.gabb21c7263-goog

