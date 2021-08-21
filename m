Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B73C4320A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8C461208
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhHUJWe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbhHUJV5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756ECC0619F6;
        Sat, 21 Aug 2021 02:20:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn28so17630741edb.6;
        Sat, 21 Aug 2021 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMAiSLL3U1jyvlQA9M+E1LVvAf3sYZBM8G7KKzsRxEw=;
        b=R/Nu8Hs7Nh8VZ5uWGXwqsgYSXL1QalbBBKbTuIa7JnSO9SxAkh03StMI4O01ReV9+G
         1WX8RFCrD+54OyISTKzPpq5oRzu0tLB6m5X3P53TqUpEWgpQoSWqvn+fhrMFAtwoInt+
         NuWRzqIWcHU3C0xN6lQEExxycTLzEgN821IIb7GDl1J0GZSSrMBbVfdaWE7oxCWevK3e
         D46mA55ycfKzpKkOteIlh0DDlj9NqGIKpSm0d2D+hsITN3R5qdIBDNxVYx5n+9uuOTuB
         0ipkplqBC5aMw7CpMoArrhOhpnbrtYIQ1d1lDRD1bkeYyK87qrA4LBlghVYfMuRxUVh1
         xGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMAiSLL3U1jyvlQA9M+E1LVvAf3sYZBM8G7KKzsRxEw=;
        b=WP1E3MWx6ew4QqIf8AEdX7tFqtcBJLwUftrWROFUiLrhz6ZHftwaK6xuFJ0H9C38JW
         6INZSKTr1FrotKRpEPkW22odT5UU3A2Pen47zHrOSlKwanB+tZNquS/HfKb5tUsvdEfw
         /K8LpUuw7ZK3MWooLsVVkLvFrEVRRB0sxI9oDcUHaASLS6/CRv9yNGNFt9UOwiOJ13Dj
         JjsneKjSOOWS26sGxkoBRO+F+/LgPszlw+O61/01MhXknf1GK13y8bNB7+r0ji0QwoKM
         aJtWH7ws6USOu2ueNI+5GlWYT4ioAqR1V/I24wfpvgvVRD7CVcNqoo+v2ag5pg94IYQq
         9F/Q==
X-Gm-Message-State: AOAM5332qFea4p6sIwMJGvyJ4NfyEpj2wmBFFpWK2ksegG2kUSg+TrwV
        3yVw1MwY4FFFYe/f2sYi4Bc=
X-Google-Smtp-Source: ABdhPJwmTRM2Neqq23Iu4eU7f7r0wc55lJAm3U2C4EOlBsf+qDotJ69e5MxiRXwNacrhjbv98/EYVA==
X-Received: by 2002:aa7:c78e:: with SMTP id n14mr26409224eds.381.1629537619936;
        Sat, 21 Aug 2021 02:20:19 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:19 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 25/37] perf evsel: move event open in evsel__open_cpu to separate function
Date:   Sat, 21 Aug 2021 11:19:31 +0200
Message-Id: <74ac2eea14f45b2cbecffb509dd5f3cd523d4a9b.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is the final patch splitting evsel__open_cpu.
This patch moves the entire loop code to a separate function, to be
reused for the multithreaded code.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 142 ++++++++++++++++++++++++----------------
 tools/perf/util/evsel.h |  12 ++++
 2 files changed, 99 insertions(+), 55 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2e95416b8320c6b9..e41f55a7a70ea630 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1945,6 +1945,82 @@ bool evsel__increase_rlimit(enum rlimit_action *set_rlimit)
 	return false;
 }
 
+static struct perf_event_open_result perf_event_open(struct evsel *evsel,
+					pid_t pid, int cpu, int thread,
+					struct perf_cpu_map *cpus,
+					struct perf_thread_map *threads)
+{
+	int fd, group_fd, rc;
+	struct perf_event_open_result res;
+
+	if (!evsel->cgrp && !evsel->core.system_wide)
+		pid = perf_thread_map__pid(threads, thread);
+
+	group_fd = get_group_fd(evsel, cpu, thread);
+
+	test_attr__ready();
+
+	pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
+			pid, cpus->map[cpu], group_fd, evsel->open_flags);
+
+	fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[cpu],
+				group_fd, evsel->open_flags);
+
+	FD(evsel, cpu, thread) = fd;
+	res.fd = fd;
+
+	if (fd < 0) {
+		rc = -errno;
+
+		pr_debug2_peo("\nsys_perf_event_open failed, error %d\n",
+				rc);
+		res.rc = rc;
+		res.err = PEO_FALLBACK;
+		return res;
+	}
+
+	bpf_counter__install_pe(evsel, cpu, fd);
+
+	if (unlikely(test_attr__enabled)) {
+		test_attr__open(&evsel->core.attr, pid,
+			cpus->map[cpu], fd,
+			group_fd, evsel->open_flags);
+	}
+
+	pr_debug2_peo(" = %d\n", fd);
+
+	if (evsel->bpf_fd >= 0) {
+		int evt_fd = fd;
+		int bpf_fd = evsel->bpf_fd;
+
+		rc = ioctl(evt_fd,
+				PERF_EVENT_IOC_SET_BPF,
+				bpf_fd);
+		if (rc && errno != EEXIST) {
+			pr_err("failed to attach bpf fd %d: %s\n",
+				bpf_fd, strerror(errno));
+			res.rc = -EINVAL;
+			res.err = PEO_ERROR;
+			return res;
+		}
+	}
+
+	/*
+	 * If we succeeded but had to kill clockid, fail and
+	 * have evsel__open_strerror() print us a nice error.
+	 */
+	if (perf_missing_features.clockid ||
+		perf_missing_features.clockid_wrong) {
+		res.rc = -EINVAL;
+		res.err = PEO_ERROR;
+		return res;
+	}
+
+	res.rc = 0;
+	res.err = PEO_SUCCESS;
+	return res;
+}
+
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
 		int start_cpu, int end_cpu)
@@ -1952,6 +2028,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	int cpu, thread, nthreads;
 	int pid = -1, err, old_errno;
 	enum rlimit_action set_rlimit = NO_CHANGE;
+	struct perf_event_open_result peo_res;
 
 	err = __evsel__prepare_open(evsel, cpus, threads);
 	if (err)
@@ -1979,67 +2056,22 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	for (cpu = start_cpu; cpu < end_cpu; cpu++) {
 
 		for (thread = 0; thread < nthreads; thread++) {
-			int fd, group_fd;
 retry_open:
 			if (thread >= nthreads)
 				break;
 
-			if (!evsel->cgrp && !evsel->core.system_wide)
-				pid = perf_thread_map__pid(threads, thread);
-
-			group_fd = get_group_fd(evsel, cpu, thread);
-
-			test_attr__ready();
-
-			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				pid, cpus->map[cpu], group_fd, evsel->open_flags);
+			peo_res = perf_event_open(evsel, pid, cpu, thread, cpus,
+						threads);
 
-			fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[cpu],
-						group_fd, evsel->open_flags);
-
-			FD(evsel, cpu, thread) = fd;
-
-			if (fd < 0) {
-				err = -errno;
-
-				pr_debug2_peo("\nsys_perf_event_open failed, error %d\n",
-					  err);
+			err = peo_res.rc;
+			switch (peo_res.err) {
+			case PEO_SUCCESS:
+				set_rlimit = NO_CHANGE;
+				continue;
+			case PEO_FALLBACK:
 				goto try_fallback;
-			}
-
-			bpf_counter__install_pe(evsel, cpu, fd);
-
-			if (unlikely(test_attr__enabled)) {
-				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
-						fd, group_fd, evsel->open_flags);
-			}
-
-			pr_debug2_peo(" = %d\n", fd);
-
-			if (evsel->bpf_fd >= 0) {
-				int evt_fd = fd;
-				int bpf_fd = evsel->bpf_fd;
-
-				err = ioctl(evt_fd,
-					    PERF_EVENT_IOC_SET_BPF,
-					    bpf_fd);
-				if (err && errno != EEXIST) {
-					pr_err("failed to attach bpf fd %d: %s\n",
-					       bpf_fd, strerror(errno));
-					err = -EINVAL;
-					goto out_close;
-				}
-			}
-
-			set_rlimit = NO_CHANGE;
-
-			/*
-			 * If we succeeded but had to kill clockid, fail and
-			 * have evsel__open_strerror() print us a nice error.
-			 */
-			if (perf_missing_features.clockid ||
-			    perf_missing_features.clockid_wrong) {
-				err = -EINVAL;
+			default:
+			case PEO_ERROR:
 				goto out_close;
 			}
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0a245afab2d87d74..8c9827a93ac001a7 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -282,6 +282,18 @@ int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 int evsel__disable_cpu(struct evsel *evsel, int cpu);
 
+enum perf_event_open_err {
+	PEO_SUCCESS,
+	PEO_FALLBACK,
+	PEO_ERROR
+};
+
+struct perf_event_open_result {
+	enum perf_event_open_err err;
+	int rc;
+	int fd;
+};
+
 int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu);
 int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
-- 
2.31.1

