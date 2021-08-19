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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C49C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Aug 2021 05:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8C16112E
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Aug 2021 05:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhHSFr4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 01:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhHSFrz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Aug 2021 01:47:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF9CC061756
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Aug 2021 22:47:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v130-20020a25c5880000b0290593c8c353ffso5484865ybe.7
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Aug 2021 22:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kIKr3PeWHCp5o9v0IskWyjHjX7CDaGRAwx7+ngR9Fgw=;
        b=P9y93GFlc1h9b+cQ3SVlR5ojMjGV8R7uGtGXWPQvdgOp6FUvzz2uTOizuvve1zfKFd
         XCYi6YgIzQvfzozrtQlWYWDqQddmobUD2l15UhqDc3+gpnBrfRzg3rjaseI2tMkeeGEC
         mpguSXYtoJDcZOtj2M06/hbLLVRRhI3dQjprvagASxPXdOcw4thbWlswFK6MXcnX2Lfw
         UUsBky0w8YggKSIz1HMBArnREjfxPPv3PEEnc1LegqCR1JD3njoWQ51ZISMyNG1c/l62
         d02fOtOSyyiQwpruC+BX06nZ1Pgk+YDWeNkAOvdt1ZVzuSZUYlLGa3Te0GSASjMFh/yM
         2c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kIKr3PeWHCp5o9v0IskWyjHjX7CDaGRAwx7+ngR9Fgw=;
        b=Cv6epi3dl0er0pEicw7SerVUeaoFoXaAxlGivce+B1RHht3sxD4+pc63s9j3XuWw8U
         FMTnmQf+/yi2WfwV0gxB4QHB/DE4bFX2ML8DS7L+Ot+eSWC9zmp7ZQC32GCcAFaWizw1
         2FratBnkcH8/+Cd6GqHkLvzDkpuYOah3XZoCxRI8sjeVib45AN2koS6LniMLnHu/A5ix
         Uw3UdAgwOZF6rljqpxs9cpzwqDXB0tFCDIUu+6WDlW7p8T6N4+SkB9OOGRosnMbvN7rN
         pOZaeXxrXPeZBCU6Ygc1/kEO0DFGYoMAjCBv+oFUhErnw6G6WWOh7JJhZTyk3I6YeZmY
         oerw==
X-Gm-Message-State: AOAM532JOrFjHOlgzHdt2EMgUgFKpKO5+Xu1GTnmn3sT7oTvytyL9k8H
        79DYshJYSEOKW5yiC4dLqU8qPAu5flAM
X-Google-Smtp-Source: ABdhPJyTDqmb8WaX4ByTVhw1hyNrAVYwzY5Hnkuwd3N+Ha3kbuHUd821Bb5P8KhU7eBPhAlNWs29kbEaUOE+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:303a:65e9:2a16:99b2])
 (user=irogers job=sendgmr) by 2002:a05:6902:1144:: with SMTP id
 p4mr16625582ybu.418.1629352039406; Wed, 18 Aug 2021 22:47:19 -0700 (PDT)
Date:   Wed, 18 Aug 2021 22:47:07 -0700
Message-Id: <20210819054707.1057819-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH] libperf evsel: Make use of FD robust.
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

FD uses xyarray__entry that may return NULL if an index is out of
bounds. If NULL is returned then a segv happens as FD unconditionally
dereferences the pointer. This was happening in a case of with perf
iostat as shown below. The fix is to make FD an "int*" rather than an
int and handle the NULL case as either invalid input or a closed fd.

$ sudo gdb --args perf stat --iostat  list
...
Breakpoint 1, perf_evsel__alloc_fd (evsel=0x5555560951a0, ncpus=1, nthreads=1) at evsel.c:50
50      {
(gdb) bt
 #0  perf_evsel__alloc_fd (evsel=0x5555560951a0, ncpus=1, nthreads=1) at evsel.c:50
 #1  0x000055555585c188 in evsel__open_cpu (evsel=0x5555560951a0, cpus=0x555556093410,
    threads=0x555556086fb0, start_cpu=0, end_cpu=1) at util/evsel.c:1792
 #2  0x000055555585cfb2 in evsel__open (evsel=0x5555560951a0, cpus=0x0, threads=0x555556086fb0)
    at util/evsel.c:2045
 #3  0x000055555585d0db in evsel__open_per_thread (evsel=0x5555560951a0, threads=0x555556086fb0)
    at util/evsel.c:2065
 #4  0x00005555558ece64 in create_perf_stat_counter (evsel=0x5555560951a0,
    config=0x555555c34700 <stat_config>, target=0x555555c2f1c0 <target>, cpu=0) at util/stat.c:590
 #5  0x000055555578e927 in __run_perf_stat (argc=1, argv=0x7fffffffe4a0, run_idx=0)
    at builtin-stat.c:833
 #6  0x000055555578f3c6 in run_perf_stat (argc=1, argv=0x7fffffffe4a0, run_idx=0)
    at builtin-stat.c:1048
 #7  0x0000555555792ee5 in cmd_stat (argc=1, argv=0x7fffffffe4a0) at builtin-stat.c:2534
 #8  0x0000555555835ed3 in run_builtin (p=0x555555c3f540 <commands+288>, argc=3,
    argv=0x7fffffffe4a0) at perf.c:313
 #9  0x0000555555836154 in handle_internal_command (argc=3, argv=0x7fffffffe4a0) at perf.c:365
 #10 0x000055555583629f in run_argv (argcp=0x7fffffffe2ec, argv=0x7fffffffe2e0) at perf.c:409
 #11 0x0000555555836692 in main (argc=3, argv=0x7fffffffe4a0) at perf.c:539
...
(gdb) c
Continuing.
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_iio_0/event=0x83,umask=0x04,ch_mask=0xF,fc_mask=0x07/).
/bin/dmesg | grep -i perf may provide additional information.

Program received signal SIGSEGV, Segmentation fault.
0x00005555559b03ea in perf_evsel__close_fd_cpu (evsel=0x5555560951a0, cpu=1) at evsel.c:166
166                     if (FD(evsel, cpu, thread) >= 0)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c | 64 +++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index d8886720e83d..ede7af4d183c 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -43,7 +43,7 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 	free(evsel);
 }
 
-#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
+#define FD(e, x, y) (int *) xyarray__entry(e->fd, x, y)
 #define MMAP(e, x, y) (e->mmap ? ((struct perf_mmap *) xyarray__entry(e->mmap, x, y)) : NULL)
 
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
@@ -54,7 +54,10 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
 		int cpu, thread;
 		for (cpu = 0; cpu < ncpus; cpu++) {
 			for (thread = 0; thread < nthreads; thread++) {
-				FD(evsel, cpu, thread) = -1;
+				int *fd = FD(evsel, cpu, thread);
+
+				if (fd)
+					 *fd = -1;
 			}
 		}
 	}
@@ -80,7 +83,7 @@ sys_perf_event_open(struct perf_event_attr *attr,
 static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread, int *group_fd)
 {
 	struct perf_evsel *leader = evsel->leader;
-	int fd;
+	int *fd;
 
 	if (evsel == leader) {
 		*group_fd = -1;
@@ -95,10 +98,10 @@ static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread, int *grou
 		return -ENOTCONN;
 
 	fd = FD(leader, cpu, thread);
-	if (fd == -1)
+	if (fd == NULL || *fd == -1)
 		return -EBADF;
 
-	*group_fd = fd;
+	*group_fd = *fd;
 
 	return 0;
 }
@@ -138,7 +141,11 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 
 	for (cpu = 0; cpu < cpus->nr; cpu++) {
 		for (thread = 0; thread < threads->nr; thread++) {
-			int fd, group_fd;
+			int fd, group_fd, *evsel_fd;
+
+			evsel_fd = FD(evsel, cpu, thread);
+			if (evsel_fd == NULL)
+				return -EINVAL;
 
 			err = get_group_fd(evsel, cpu, thread, &group_fd);
 			if (err < 0)
@@ -151,7 +158,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 			if (fd < 0)
 				return -errno;
 
-			FD(evsel, cpu, thread) = fd;
+			*evsel_fd = fd;
 		}
 	}
 
@@ -163,9 +170,12 @@ static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
 	int thread;
 
 	for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
-		if (FD(evsel, cpu, thread) >= 0)
-			close(FD(evsel, cpu, thread));
-		FD(evsel, cpu, thread) = -1;
+		int *fd = FD(evsel, cpu, thread);
+
+		if (fd && *fd >= 0) {
+			close(*fd);
+			*fd = -1;
+		}
 	}
 }
 
@@ -209,13 +219,12 @@ void perf_evsel__munmap(struct perf_evsel *evsel)
 
 	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
-			int fd = FD(evsel, cpu, thread);
-			struct perf_mmap *map = MMAP(evsel, cpu, thread);
+			int *fd = FD(evsel, cpu, thread);
 
-			if (fd < 0)
+			if (fd == NULL || *fd < 0)
 				continue;
 
-			perf_mmap__munmap(map);
+			perf_mmap__munmap(MMAP(evsel, cpu, thread));
 		}
 	}
 
@@ -239,15 +248,16 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 
 	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
-			int fd = FD(evsel, cpu, thread);
-			struct perf_mmap *map = MMAP(evsel, cpu, thread);
+			int *fd = FD(evsel, cpu, thread);
+			struct perf_mmap *map;
 
-			if (fd < 0)
+			if (fd == NULL || *fd < 0)
 				continue;
 
+			map = MMAP(evsel, cpu, thread);
 			perf_mmap__init(map, NULL, false, NULL);
 
-			ret = perf_mmap__mmap(map, &mp, fd, cpu);
+			ret = perf_mmap__mmap(map, &mp, *fd, cpu);
 			if (ret) {
 				perf_evsel__munmap(evsel);
 				return ret;
@@ -260,7 +270,9 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 
 void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
 {
-	if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
+	int *fd = FD(evsel, cpu, thread);
+
+	if (fd == NULL || *fd < 0 || MMAP(evsel, cpu, thread) == NULL)
 		return NULL;
 
 	return MMAP(evsel, cpu, thread)->base;
@@ -295,17 +307,18 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 		     struct perf_counts_values *count)
 {
 	size_t size = perf_evsel__read_size(evsel);
+	int *fd = FD(evsel, cpu, thread);
 
 	memset(count, 0, sizeof(*count));
 
-	if (FD(evsel, cpu, thread) < 0)
+	if (fd == NULL || *fd < 0)
 		return -EINVAL;
 
 	if (MMAP(evsel, cpu, thread) &&
 	    !perf_mmap__read_self(MMAP(evsel, cpu, thread), count))
 		return 0;
 
-	if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
+	if (readn(*fd, count->values, size) <= 0)
 		return -errno;
 
 	return 0;
@@ -318,8 +331,13 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 	int thread;
 
 	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
-		int fd = FD(evsel, cpu, thread),
-		    err = ioctl(fd, ioc, arg);
+		int err;
+		int *fd = FD(evsel, cpu, thread);
+
+		if (fd || *fd < 0)
+			return -1;
+
+		err = ioctl(*fd, ioc, arg);
 
 		if (err)
 			return err;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

