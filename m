Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB1BC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Jan 2022 06:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiANGvL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Jan 2022 01:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiANGvK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Jan 2022 01:51:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863D5C06161C
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jan 2022 22:51:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g6-20020a25db06000000b00611ca09ecd0so6302194ybf.6
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jan 2022 22:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LDwm4hnT7Bk0Sbi/T1/8Yk0x2iaTja6ZT3of8YSmJeU=;
        b=XPw44X2fTrMNJiw8DtD81VSxYEHznaWrOMYhAqhnKENIrDnI2ZOwKWuFDbYybuJNMO
         wwpkbhM+3xjm9kV4oF+24DgQoduuwR5nRbgDi+xsy2hYZbnACROcTjjij5n7KLQQg05V
         sOtX47QqVDZ1uIlpirCPy9h+6tYUFUrxL+MdApk9G2dIGLii+hpqiF2keRdeHfMq3KGm
         hTssq+cIHPz6d5RE+t/2U3OUzANWn4sO4BcYXk2MpSigpRNfrfWGmNqBIQ1MAqMx9iEh
         TeCJLApid4xAcs/x0kmGFORzwav2sVvD4aM/qOat0XRabrx4MOk8Zv8xjGe6w5ihv3e4
         H5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LDwm4hnT7Bk0Sbi/T1/8Yk0x2iaTja6ZT3of8YSmJeU=;
        b=fOS53buguJHdQCEXcdQeDNtu4vvVjGAeIh39dLXhgMMKlq3Sbg5Dtp+E28xZOQjeRC
         GvNLJm2yQb1p0mj6JDBuNGxEBWTnQXibL8/+zqnX41fBAYg6SKpK5qe1RoBjkFCPuNJ9
         ZRCyKEjK67FzCJJnPSXye5XYGVgItLC0LwzrtAPD9N1v9z1oRQjdYMsUMGpqgBDc7i1K
         Si3Lu70pJ9NRvkcfvZmv8Y9zPK+WPfh0N5pBJTav0XYYyWT+JANUigPjPSW0+DVp4gx7
         8imQTGSCtxGPtSdcnUegSFkOHRsnwU6AzeZqchSCBJHOGkxpA0nhxZHrluxD+ok68NLj
         aYTQ==
X-Gm-Message-State: AOAM533gOeDOgqEydMDxZMmf8hw5KnUeb8b8VE2mKCfiYjwiMvJTnf5e
        ixDGRJe59rdH+/3u3YcOlNI/jIQJ4upo
X-Google-Smtp-Source: ABdhPJwFeqSCtfOlYXdrcLc5Y8RJDAM3kwLMD0StphbD7/oIG+kCDuB1Q+cEqG0wNfBfli2R9A2Ixv7mqsYD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:de36:7cc:6c7a:b7cd])
 (user=irogers job=sendgmr) by 2002:a25:2cc7:: with SMTP id
 s190mr4039605ybs.186.1642143069821; Thu, 13 Jan 2022 22:51:09 -0800 (PST)
Date:   Thu, 13 Jan 2022 22:51:05 -0800
Message-Id: <20220114065105.1806542-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] libperf tests: Update a use of the new cpumap api.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fixes a build breakage.

Fixes: 6d18804b963b ("perf cpumap: Give CPUs their own type")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/tests/test-evlist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index e7afff12c35a..b3479dfa9a1c 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -334,7 +334,8 @@ static int test_mmap_cpus(void)
 	};
 	cpu_set_t saved_mask;
 	char path[PATH_MAX];
-	int id, err, cpu, tmp;
+	int id, err, tmp;
+	struct perf_cpu cpu;
 	union perf_event *event;
 	int count = 0;
 
@@ -377,7 +378,7 @@ static int test_mmap_cpus(void)
 		cpu_set_t mask;
 
 		CPU_ZERO(&mask);
-		CPU_SET(cpu, &mask);
+		CPU_SET(cpu.cpu, &mask);
 
 		err = sched_setaffinity(0, sizeof(mask), &mask);
 		__T("sched_setaffinity failed", err == 0);
-- 
2.34.1.703.g22d0c6ccf7-goog

