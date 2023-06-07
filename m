Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0D1C7EE37
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 01:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbjFGBqC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jun 2023 21:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240565AbjFGBol (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52C619B9
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jun 2023 18:44:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb79a17b8so8088304276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2023 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102280; x=1688694280;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lh3ZPj+Wzo2hfjfSWit72WLXRXJmKCjosdWMK8GGHUA=;
        b=3o9qJWhUHNoQNGjubcZF65jCf+kylBRuNrh/H8uqZh8T9IE7SSsDbQdJAJqkGygZ/M
         XUmP4BGq/x9wgJBAhBViGncUpwNN2utiZ9qBzS74mgWQA9TAd1yT6PxKwrY6axXJfoka
         xLBd+y1FTCyaQ8wtCWDkY7jTYi1N/aIH8fzG2ptJwcuGV1neC/CfhkzGgXRMnmez4ToI
         7zfazA3RCOCqNCGwYQ3piafzBFPOCEl6Iiy3qDsgKJQSvSkzxH1q4Czl9Fgamm0CXqul
         SQ8P0Iql/omNg2GbZcfLUD+dqe8nJ4RmJNzdOs2uPS4ts5K1aUmvO3nFu0WoPgZ4IAnz
         QZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102280; x=1688694280;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lh3ZPj+Wzo2hfjfSWit72WLXRXJmKCjosdWMK8GGHUA=;
        b=Cy5DUhkjJpC1WTowSqqi9R/ChJGbfrD+OKejSI96hR+a5OSduElDix/4c1eoaJsniW
         QnTHedP4UH/SQcAduFFyzU9C2jQs31hqyb0iGR/s69kXXVg/+bYVsBGF2x0UyP2DxjHn
         nHJlVSyLzjAzsXWxrG/gfLss910Sw9U/ScsZdxb/frwLEeDiQ9jBsczffEN0iIE6cpq4
         CqApAWVPn0brKpuK69kfoX6+UpJZ3QVC4BcrZnmBpzXfHXNwDC+pS2ygC+iqNT0L5EOX
         CNPzm6gwi+4rxBJjdltW1ufYHjtoWu6LUK28PiNcZvlt1ORAkPxDwCXgopreCVJOUh8C
         KCYQ==
X-Gm-Message-State: AC+VfDwquceauBRmQ790loDeDLV4Ht61J1K2q8R3TqiJb46WiG/fmldi
        1oAcSxniVLykaAy97lmUModTT4+tyiLk
X-Google-Smtp-Source: ACHHUZ5k0RG8X6zpnvumVsnIGTroi8c4VO2eafr6KT17+45l3nZ2TRcZyfvFyEu2jFiCKaPHKnGy224Junv5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1206:b0:bb1:f26d:b18d with SMTP
 id s6-20020a056902120600b00bb1f26db18dmr2138419ybu.13.1686102279962; Tue, 06
 Jun 2023 18:44:39 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:46 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-14-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 13/20] perf evlist: Free stats in all evlist destruction
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There is no evsel free stats, freeing in the evlist__delete ensures
memory leaks are avoided. Issues detected with "perf stat report" and
leak sanitizer, perf stat uses perf_session__delete to free the
evlist. Add dummy symbol for python build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 2 ++
 tools/perf/util/python.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 82c0b3d0c822..7ef43f72098e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -31,6 +31,7 @@
 #include "util/pmu.h"
 #include "util/sample.h"
 #include "util/bpf-filter.h"
+#include "util/stat.h"
 #include "util/util.h"
 #include <signal.h>
 #include <unistd.h>
@@ -171,6 +172,7 @@ void evlist__delete(struct evlist *evlist)
 	if (evlist == NULL)
 		return;
 
+	evlist__free_stats(evlist);
 	evlist__munmap(evlist);
 	evlist__close(evlist);
 	evlist__purge(evlist);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8de1b759bbaa..a7b2cb05dc86 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1494,3 +1494,7 @@ void test_attr__open(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cp
                      int fd, int group_fd, unsigned long flags)
 {
 }
+
+void evlist__free_stats(struct evlist *evlist)
+{
+}
-- 
2.41.0.rc0.172.g3f132b7071-goog

