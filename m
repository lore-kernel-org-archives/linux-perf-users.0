Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7FEC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiAEGPh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiAEGPI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED34EC0613B4
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:15:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s84-20020a254557000000b0060ac37f4bb1so58179011yba.5
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=awNrzmXXwhgHegLo/XT1TXhJodtpZbEQSRhdkuOAA7A=;
        b=QFLce7E7aw2wwlYSdhG76Mpmen0FL+9PXvm2nIZ1r2kh35f/ju+N1FCwEycFEVF+HA
         j9L20RILujNFaYcOFh3OooBobOOyomezKdufRMIeJnH7G5n2P1cLqvQZIF9ZiHsYsRqr
         R19Trg4sfEvg87wq53ikPM7oBHSTNvu9sdTPNK7Pc+0o0AeewmBgYa7ekaORz6gpmiAN
         n6FKnJZWOP3wyF2OE6rVCjXIBgrqGYfz8Qkwoc7VBNe7E+Xav0mef4br/KP4tYrivEWB
         TCpU708CTEvJLltlNr2zSKirA/ckTIphnNdqI5JgZQGcUz7m4m7yRcEEOJMZ8dv1tS8q
         N6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=awNrzmXXwhgHegLo/XT1TXhJodtpZbEQSRhdkuOAA7A=;
        b=z2ds9RSrVi1jsSbq6Yy5FzuvfP7pH2RfzbFzl+RuxhEQ2LD+q7qnoTwe5rL6iK46Pj
         zPdZGfldy/WHNWxZDwA4n3l7PwD+n07U4QEwqc2a4ZDs0N+MvRFkHfHn1LcgeGUDBevL
         l4kmRZHB+VXeZMlS9Hr+c+6bNj4QU56J25hqtjzfTGm0cfqKNXv59iZvDVeAT9v28w82
         vxYOY73iTzFvQTinblbpAUcXykY1sZnC4ZnDjQPWULz8RWSz87pX0HjGHP7F0PMMeWhQ
         oIJ+sL+4XF5AsOlFR7lmut4tp+WEDOwtouvy4HToK9rDufBmojwhb8YRgIObFPRlLkQI
         J3KQ==
X-Gm-Message-State: AOAM533psF2XGZAJj+7uEt9nzh/4Iuxu75T+hNfUhCPUV7xpx33ScEAj
        +LmPKg8mHzxKrA+52jt1G6mVP+WeYCiL
X-Google-Smtp-Source: ABdhPJw47VEO8qrbLlvO3Iqg8kT9Hr62ZveuqAWJWNul5pXD8VWdsG+ExLGh23eaZ4TCVNC/10WgF1m3m/qA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:2c05:: with SMTP id
 s5mr51759848ybs.402.1641363307149; Tue, 04 Jan 2022 22:15:07 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:31 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-29-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 28/48] libperf: Use cpu not index for evsel mmap
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix issue where evsel's CPU map index was being used as the mmap cpu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 8028b5a4da69..f1e1665ef4bd 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -252,6 +252,7 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
 			int *fd = FD(evsel, idx, thread);
 			struct perf_mmap *map;
+			int cpu = perf_cpu_map__cpu(evsel->cpus, idx);
 
 			if (fd == NULL || *fd < 0)
 				continue;
@@ -259,7 +260,7 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 			map = MMAP(evsel, idx, thread);
 			perf_mmap__init(map, NULL, false, NULL);
 
-			ret = perf_mmap__mmap(map, &mp, *fd, idx);
+			ret = perf_mmap__mmap(map, &mp, *fd, cpu);
 			if (ret) {
 				perf_evsel__munmap(evsel);
 				return ret;
-- 
2.34.1.448.ga2b2bfdf31-goog

