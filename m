Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624FAC7EE45
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jun 2023 23:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFKXgj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jun 2023 19:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjFKXgh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jun 2023 19:36:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC976191
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jun 2023 16:36:36 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5488dccfbdfso2593866a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jun 2023 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686526596; x=1689118596;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQ7dtGpCj1vKIn1MUVA2v5/9SJwzoX7naJdqhcByVkI=;
        b=jEgUrY4kEVtjeziBJfMRsOXP9p7miFhh0NqERxOwbhzWWQtmli2+Hoz3jquLp8JodJ
         bjH0SyVOzgVCwKLF9AcxmeSv6is1ooUjnBiEOtfljkArEtLAVN8mfwT/pmDuIpS9BTkN
         gG2rf9C9wBqDXFnvBCRsJ+ASYPVS9OlrGpD7QjxsU7+9K7X+jO+ssbnkYaW1Nx+zIF6r
         OrpEH6kU3nU869sU0aW8YV639FwcCUQ4dBboXcdZOF3r4c7nw5XcItOO42+DTQky2t4s
         NUtyFbzqCnKqImWu01nE1M7/uTPbS1CIseccSnQG4WNC3xBFO06D49MpbzR0nH51+sKA
         j9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686526596; x=1689118596;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ7dtGpCj1vKIn1MUVA2v5/9SJwzoX7naJdqhcByVkI=;
        b=St2iVogGYox5qZGreW/waT/SIuzQ5axmTDCt6s3oa0P4YEKCDIT0ieMu5c/TLaRBaM
         vtUUrVgXuJEJBjldbUfid4Qe4EgYZnFbX6rSzTahSrFGZ0y3tCOdJK72tElGUgi6bfdk
         Y6JTUJltcuGOsnUY0DqxFDEskptUn/N8H0i+/BSfWKqrApp4pj9v9dCxCBiMihkYcxrM
         M4UcywuWJwfBatOl5D8O+66RJQFE48HQjY8AqWqdR+9NCG3pOCI2rj1USClkqteMP7CF
         islJQJMRkJKzYnqYIEuXeqVR3cFulhiVJNt9JmkhvXPJLEsVrS0xAMqd3+bz32qUQTxf
         LajQ==
X-Gm-Message-State: AC+VfDxMD60C04BaJk18Y6/iaKEgaAUutAZow9pPePqSgXLf7jiJELX/
        2+W7ZDlkfLcOVgYJDvfnTxLodXE1nkoM
X-Google-Smtp-Source: ACHHUZ6sqXaQ+/hnbbQI/i5tF0I9L3nbpl7Um13O7xwaQeTAtPD515Sa3VFg2BACuxwpvKkZUMy9LwqPp8sw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:aca9:d7c7:ed17:e760])
 (user=irogers job=sendgmr) by 2002:a63:db02:0:b0:53f:6f7c:554e with SMTP id
 e2-20020a63db02000000b0053f6f7c554emr1022251pgg.12.1686526596403; Sun, 11 Jun
 2023 16:36:36 -0700 (PDT)
Date:   Sun, 11 Jun 2023 16:36:08 -0700
In-Reply-To: <20230611233610.953456-1-irogers@google.com>
Message-Id: <20230611233610.953456-3-irogers@google.com>
Mime-Version: 1.0
References: <20230611233610.953456-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 3/5] perf bench epoll: Fix missing frees/puts
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Issues detected by leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/epoll-ctl.c  | 5 +++++
 tools/perf/bench/epoll-wait.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index 521d1ff97b06..6bfffe83dde9 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -421,6 +421,11 @@ int bench_epoll_ctl(int argc, const char **argv)
 	print_summary();
 
 	close(epollfd);
+	perf_cpu_map__put(cpu);
+	for (i = 0; i < nthreads; i++)
+		free(worker[i].fdmap);
+
+	free(worker);
 	return ret;
 errmem:
 	err(EXIT_FAILURE, "calloc");
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index c1cdf03c075d..cb5174b53940 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -549,6 +549,11 @@ int bench_epoll_wait(int argc, const char **argv)
 	print_summary();
 
 	close(epollfd);
+	perf_cpu_map__put(cpu);
+	for (i = 0; i < nthreads; i++)
+		free(worker[i].fdmap);
+
+	free(worker);
 	return ret;
 errmem:
 	err(EXIT_FAILURE, "calloc");
-- 
2.41.0.162.gfafddb0af9-goog

