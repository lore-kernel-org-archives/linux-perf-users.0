Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E7C07E96
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 15:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 730FB61C23
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 15:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhGFPUh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232754AbhGFPUe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 11:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625584675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Y33i+uSFsLOB+NUbcpIV2KAt1WulzlUDozIH51BtmQ=;
        b=LpU3rthvjPm8leIOOf63s7+TgnJdkBIpfZGWAXV4OsvwrMrG8xs9uIn1AnxztykLvei+g4
        NGDu8zub3IC6FHxWEb8JPueYdJ/p506BIsynjnJPoL1dRLqCovKNqdU50i5rT0Ra2VHwGa
        NuA8q+6Ee6G5m3OcgWegkrF8XOsYA+w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-19eMnXcmMC6BPz6xYuv9YQ-1; Tue, 06 Jul 2021 11:17:52 -0400
X-MC-Unique: 19eMnXcmMC6BPz6xYuv9YQ-1
Received: by mail-wr1-f69.google.com with SMTP id x8-20020a5d54c80000b029012583535285so7282878wrv.8
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jul 2021 08:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Y33i+uSFsLOB+NUbcpIV2KAt1WulzlUDozIH51BtmQ=;
        b=fLUiZ0urxA2564SBtXrQzhSq5cJEvPMPX6zlEuTx4jVyl6Gr3/iFKYFviOezyP52OY
         6AxBvjdO0tJyagrwkcs9gaXByYm2mx9Uj/yJeYQVBkdyeT+j1I+AavJfJ+8NLM5UslAi
         djnYwCDtT5Nq0LGN6WRm43+iIgE2pWP1V9O2vMiUKD4pmOx0/eJ8ZpPhA6Thy2Iuppaf
         AMquGolxhOWtIZFDMq9g3Zzsy6RdCnOwOgl8OksvokULdICsv9mZKG75kAIbq4dl8Wjq
         lufu3NnVTMwXwdrCdSRraHT90tXt4c4+LZHnsx4NE570Z4oQ7XnZMdZRDCVxCqh/DVgz
         pvNg==
X-Gm-Message-State: AOAM531tk2Rb8zdyHOrEf58kom4REcE0jV8tJsuhkLhzdd6mrLu5qBeP
        e0hmrXNiSGsoH9QxkjOBabZBNi3nZadA1lN9oPqjMjXMQ35qD3cKNrerNu+ehr0OfaCxxJLE/9g
        +QVMLM1g2lRBueH24PklKKMJYewDZmQ==
X-Received: by 2002:a5d:400a:: with SMTP id n10mr22624247wrp.268.1625584671296;
        Tue, 06 Jul 2021 08:17:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6Z4DnxZmw93z5YgcDJUqtdkicaLdBMg0wkfh/AVp4Be2+ob8pTpwKNe7gFTjPu2GEMj5htA==
X-Received: by 2002:a5d:400a:: with SMTP id n10mr22624226wrp.268.1625584671116;
        Tue, 06 Jul 2021 08:17:51 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id a4sm16868490wru.55.2021.07.06.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:17:50 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 6/7] libperF: Add group support to perf_evsel__open
Date:   Tue,  6 Jul 2021 17:17:03 +0200
Message-Id: <20210706151704.73662-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706151704.73662-1-jolsa@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding support to set group_fd in perf_evsel__open
call and make it to follow the group setup.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/evsel.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 3e6638d27c45..9ebf7122d476 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <asm/bug.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx)
@@ -76,6 +77,25 @@ sys_perf_event_open(struct perf_event_attr *attr,
 	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
 }
 
+static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread)
+{
+	struct perf_evsel *leader = evsel->leader;
+	int fd;
+
+	if (evsel == leader)
+		return -1;
+
+	/*
+	 * Leader must be already processed/open,
+	 * if not it's a bug.
+	 */
+	BUG_ON(!leader->fd);
+
+	fd = FD(leader, cpu, thread);
+	BUG_ON(fd == -1);
+	return fd;
+}
+
 int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 		     struct perf_thread_map *threads)
 {
@@ -111,11 +131,13 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 
 	for (cpu = 0; cpu < cpus->nr; cpu++) {
 		for (thread = 0; thread < threads->nr; thread++) {
-			int fd;
+			int fd, group_fd;
+
+			group_fd = get_group_fd(evsel, cpu, thread);
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
-						 cpus->map[cpu], -1, 0);
+						 cpus->map[cpu], group_fd, 0);
 
 			if (fd < 0)
 				return -errno;
-- 
2.31.1

