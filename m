Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34293C43219
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Feb 2022 10:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348949AbiBKKec (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:34:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244145AbiBKKeb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8375EA6
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 02:34:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g205-20020a2552d6000000b0061e1843b8edso16799934ybb.18
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 02:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wQ52+X1lVqs3NA4HQ0Y5oly0G0KrCZg9YO1xv1PXn5A=;
        b=a3hvrMFEyL/k2U8ysBuPjJnJ+Ygk9IuzMt5WdmMQmX9koGxdtYxgjRVe1l+4k8Kz+8
         13Z3YydDRdSRXaU/sf9MCqpHBy+i9m5aSw/NnjsmXsuL7/HFDACiZf2VX9kCUpttkoVx
         p+dc3kkdel5pMgKWNy+PwNAXYXubgTfW/Y+VaRnTkocNolWj1Z674DOIAwh0ozl8gt+v
         c58txNVmQQuMwB7+qt9QpQ7DIeuwdHyolkNvkdmGxK7dVAek5PLOwiiilaE3DRtckn07
         79qTmiIkiHJ8AiSApLd/ygFShczSb113Duj1eNT6rLT1hj1z5ebbdzQuzrNDxrmGav9/
         EoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wQ52+X1lVqs3NA4HQ0Y5oly0G0KrCZg9YO1xv1PXn5A=;
        b=eLm8r/5O+k1z0NLVTLIcCtR2TtzJjmYMrK/thKoyK0LELKq/aHUBDg9dKlTmBAcaRp
         AU+2wWXYvKMjAz1H2cXycRIPdhCHQs8aAWNon+lrpaC379ctuYK7yoMA8vW66HzAK/Zc
         1oNS5fWl0RzsZ5lrbXzFi1/RWnwweWtSv+JB9YL3MObsAATqq3LpATs0oPl82Ey4Ok6V
         WTNapkB6pzRcYNXPkuuW8tdKvkP2Fnt8VjoyogAgnESRtgLgX/AYHohONA36Brh3MYMP
         dLbnerXgQe39W9YcGpzrlcDcuwYE1/lkMqJwrVje6p+BGwHNLZqeAaiyYJffJhyqotft
         wHwg==
X-Gm-Message-State: AOAM5333upEJcWNJLxXPWxzOqEV6ey8omBI7MxECXtpQfWPP7npDQ/hy
        K6XiPIR9G8ljepow+DefY0K8i/bmpSgC
X-Google-Smtp-Source: ABdhPJxL1gJ1wtKPcRX3YXRp7qrePWMozQDDx5tNxxp/EendyW1MtiPytq9GoEJML/jt8+AhT8d3Ej6nzmbl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a25:7809:: with SMTP id
 t9mr606088ybc.577.1644575670099; Fri, 11 Feb 2022 02:34:30 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:33:57 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-5-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 04/22] perf dso: Hold lock when accessing nsinfo
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There may be threads racing to update dso->nsinfo:
https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
Holding the dso->lock avoids use-after-free, memory leaks and other
such bugs. Apply the fix in:
https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
of there being a missing nsinfo__put now that the accesses are data race
free.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c   | 4 ++++
 tools/perf/util/dso.c         | 5 ++++-
 tools/perf/util/map.c         | 3 +++
 tools/perf/util/probe-event.c | 2 ++
 tools/perf/util/symbol.c      | 2 +-
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index fbf43a454cba..bede332bf0e2 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -363,8 +363,10 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 	}
 
 	if (dso) {
+		BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
+		pthread_mutex_unlock(&dso->lock);
 	} else
 		nsinfo__put(nsi);
 
@@ -547,7 +549,9 @@ static int dso__read_build_id(struct dso *dso)
 	if (dso->has_build_id)
 		return 0;
 
+	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
+	pthread_mutex_unlock(&dso->lock);
 	if (filename__read_build_id(dso->long_name, &dso->bid) > 0)
 		dso->has_build_id = true;
 	nsinfo__mountns_exit(&nsc);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 6beccffeef7b..b2f570adba35 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -548,8 +548,11 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	int fd;
 	struct nscookie nsc;
 
-	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
+	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE) {
+		BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 		nsinfo__mountns_enter(dso->nsinfo, &nsc);
+		pthread_mutex_unlock(&dso->lock);
+	}
 	fd = __open_dso(dso, machine);
 	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
 		nsinfo__mountns_exit(&nsc);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 8af693d9678c..ae99b52502d5 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -192,7 +192,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			if (!(prot & PROT_EXEC))
 				dso__set_loaded(dso);
 		}
+		BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
+		nsinfo__put(dso->nsinfo);
 		dso->nsinfo = nsi;
+		pthread_mutex_unlock(&dso->lock);
 
 		if (build_id__is_defined(bid))
 			dso__set_build_id(dso, bid);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a834918a0a0d..7444e689ece7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -180,8 +180,10 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 
 		map = dso__new_map(target);
 		if (map && map->dso) {
+			BUG_ON(pthread_mutex_lock(&map->dso->lock) != 0);
 			nsinfo__put(map->dso->nsinfo);
 			map->dso->nsinfo = nsinfo__get(nsi);
+			pthread_mutex_unlock(&map->dso->lock);
 		}
 		return map;
 	} else {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 43f47532696f..a504346feb05 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1774,6 +1774,7 @@ int dso__load(struct dso *dso, struct map *map)
 	char newmapname[PATH_MAX];
 	const char *map_path = dso->long_name;
 
+	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
 	if (perfmap) {
 		if (dso->nsinfo && (dso__find_perf_map(newmapname,
@@ -1783,7 +1784,6 @@ int dso__load(struct dso *dso, struct map *map)
 	}
 
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
-	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
 
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
-- 
2.35.1.265.g69c8d7142f-goog

