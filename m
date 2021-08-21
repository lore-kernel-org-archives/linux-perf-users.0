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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E67C4320A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E34461101
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhHUJVk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbhHUJVQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD6BC061226;
        Sat, 21 Aug 2021 02:20:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bt14so25229171ejb.3;
        Sat, 21 Aug 2021 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K06lN51zooeraOtXEnuTstuj3NqHpgaRejWVBk4KyOk=;
        b=PGI+h7CA1GqZcp4I1rAnRgvjggxCainerJwwcK2u4W8y/JqKLtiE4yBNPAF1aLnLI2
         mzYHhOBesppnvlNDBLvrlBtZ3HtN5yViQa1qAhxvbIYbTExwoHbvwS+TzGTObAXknsuY
         I3dEfvBhLmiHg8Du7CugiOSdi0Nl7CXb1lka+gP37UJ/9muyKhKZtzg3E0saCHlLm0Pv
         bB+ljE9Ctzqllh1W08dZLQRS04IihAx7K1P0gHrJLAQFoQobCe/lr6Ku1ihCabX/KJq/
         QMe01khZWUY1Krhr75Redrn73SPJ9k7bQZplB/CkG7HPHEWStw+4Ttl990zuXQBLAjD1
         UG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K06lN51zooeraOtXEnuTstuj3NqHpgaRejWVBk4KyOk=;
        b=odLnZPLCIletJhoICxpxwB8qKKwKLve8HwzLShih8XjbbqhGnZjl/vZOXMeS5elk6i
         K5LRfaxhYE3AAUDIaEIqiozvsc5AVQJg4kNcksDzQ3NXzc3Qwiab8OUbymeuCs3hcVZD
         ZTt6n2jTMtvWdGPBpkT4lepwRdRNQ/lhQS35/uwBKqrffnqzE9cug05RjumTrYjDTym9
         wuFSFOZzxdE/tY0tjwJXqwcXS9Oqq31XGb+1pjycwnExbIKqyrU7JTCVTYXEFKeH+0TW
         LYdmM7qbV44w0Y394ubyyCeppOiXZBS9HwjPB5kBUAmpjytyceME9d9prFT9InReVbxP
         sbSg==
X-Gm-Message-State: AOAM5316VM9VVWzLMs+xh0j3YKqOUGSLtc83j4iclYafIGhEDGasXffc
        UdZalCPI80+qyM6UQ7vDFWU=
X-Google-Smtp-Source: ABdhPJwt8uU784n9hXFhioDFuLC0yISYbl4g86peqol/mnB6pyTeYBtayK+NLczWBOODuS4ItMlpYQ==
X-Received: by 2002:a17:906:e57:: with SMTP id q23mr25767665eji.483.1629537608295;
        Sat, 21 Aug 2021 02:20:08 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:08 -0700 (PDT)
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
Subject: [RFC PATCH v1 16/37] perf evsel: save open flags in evsel
Date:   Sat, 21 Aug 2021 11:19:22 +0200
Message-Id: <d9f63159098e56fa518eecf25171d72e6f74df37.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch caches the flags used in perf_event_open inside evsel, so
that they can be set in __evsel__prepare_open (this will be useful
in following patches, when the fallback mechanisms will be handled
outside the open itself).
This also optimizes the code, by not having to recompute them everytime.

Since flags are now saved in evsel, the flags argument in
perf_event_open is removed.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 24 ++++++++++++------------
 tools/perf/util/evsel.h |  1 +
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ddf324e2e17a0951..509a2970a94b3142 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1710,17 +1710,16 @@ static void display_attr(struct perf_event_attr *attr)
 }
 
 static int perf_event_open(struct evsel *evsel,
-			   pid_t pid, int cpu, int group_fd,
-			   unsigned long flags)
+			   pid_t pid, int cpu, int group_fd)
 {
 	int precise_ip = evsel->core.attr.precise_ip;
 	int fd;
 
 	while (1) {
 		pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-			  pid, cpu, group_fd, flags);
+			  pid, cpu, group_fd, evsel->open_flags);
 
-		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, group_fd, flags);
+		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, group_fd, evsel->open_flags);
 		if (fd >= 0)
 			break;
 
@@ -1788,6 +1787,10 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	    perf_evsel__alloc_fd(&evsel->core, cpus->nr, nthreads) < 0)
 		return -ENOMEM;
 
+	evsel->open_flags = PERF_FLAG_FD_CLOEXEC;
+	if (evsel->cgrp)
+		evsel->open_flags |= PERF_FLAG_PID_CGROUP;
+
 	return 0;
 }
 
@@ -1796,7 +1799,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		int start_cpu, int end_cpu)
 {
 	int cpu, thread, nthreads;
-	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
 	int pid = -1, err, old_errno;
 	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
 
@@ -1815,10 +1817,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	else
 		nthreads = threads->nr;
 
-	if (evsel->cgrp) {
-		flags |= PERF_FLAG_PID_CGROUP;
+	if (evsel->cgrp)
 		pid = evsel->cgrp->fd;
-	}
 
 fallback_missing_features:
 	if (perf_missing_features.weight_struct) {
@@ -1832,7 +1832,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.clockid = 0;
 	}
 	if (perf_missing_features.cloexec)
-		flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
+		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
 	if (perf_missing_features.mmap2)
 		evsel->core.attr.mmap2 = 0;
 	if (perf_missing_features.exclude_guest)
@@ -1866,7 +1866,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			test_attr__ready();
 
 			fd = perf_event_open(evsel, pid, cpus->map[cpu],
-					     group_fd, flags);
+					     group_fd);
 
 			FD(evsel, cpu, thread) = fd;
 
@@ -1874,7 +1874,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			if (unlikely(test_attr__enabled)) {
 				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
-						fd, group_fd, flags);
+						fd, group_fd, evsel->open_flags);
 			}
 
 			if (fd < 0) {
@@ -2012,7 +2012,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		perf_missing_features.clockid = true;
 		pr_debug2_peo("switching off use_clockid\n");
 		goto fallback_missing_features;
-	} else if (!perf_missing_features.cloexec && (flags & PERF_FLAG_FD_CLOEXEC)) {
+	} else if (!perf_missing_features.cloexec && (evsel->open_flags & PERF_FLAG_FD_CLOEXEC)) {
 		perf_missing_features.cloexec = true;
 		pr_debug2_peo("switching off cloexec flag\n");
 		goto fallback_missing_features;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index eabccce406886320..1c0057e80d080f2f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -149,6 +149,7 @@ struct evsel {
 		struct bperf_leader_bpf *leader_skel;
 		struct bperf_follower_bpf *follower_skel;
 	};
+	unsigned long		open_flags;
 };
 
 struct perf_missing_features {
-- 
2.31.1

