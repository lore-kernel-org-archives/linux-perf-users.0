Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B8BC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Feb 2022 10:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348975AbiBKKfC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:35:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349001AbiBKKe6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55297EB1
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 02:34:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f32-20020a25b0a0000000b0061dad37dcd6so17757978ybj.16
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 02:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S56WfI2GmhqdGh7gnwplme1j2hJlUSzhW1pk4BgzSzk=;
        b=mBkM8iq3Hm5tOajbE77+PviE5ArQ7pZGE+5Ugb0NOHm0qOpTY+9CzOUeDRPjsBJZa2
         XJAyZiH/DGLk/fw3OkYbhHRo3Nx0liPl4cSn3x0QdlwM0c0KpMjrtdDGyGa1EMkpIqME
         9Jx1vrj11uenDjxwXLm/INJHnwFHZ5Ia4t5dTqw5hgpfyeERydmin5IUyHNvdxqbhAeK
         hXvaHL/HrL+JzFLtcVIcGrfojqASbRU9DWQ3sQd3f8jWVZddxTXnYlKGD1w/4b6xqbPS
         tHkgYuRdz76CtqpUZ3Gn+T3ujyG6QqmtyezxT5mZc4up9glakdspspm5XNcUt3pzDfPL
         VKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S56WfI2GmhqdGh7gnwplme1j2hJlUSzhW1pk4BgzSzk=;
        b=qQ/YC/WrZbYOKX9fhwGzrgQmo4mk4eoCUJildx2I+ZrvRHLYu9v+SXxzweWPod9TAG
         U+TfGH7IwiMosUMPRM4IqnHEq85ZyILP0DOlexRy5Q9PCuW6zv6zHpIPaKSrC0Ig/dbS
         9bLyIv4PGyD3LWK/qlZ0ZIsNVJQIpHs/z5dm1BXuwnqL4kvmlBDRIc0g6N1DXubpgNec
         eESvrlZgER3qbF+cGqM+8jEfzkdgTGeZUvNcSgpiCchatkND7f5IqsRVce1h4mRcuVNx
         7zf6DO8dxeMhs+PqMEYsALjGozJ0XdDdrmRxBAosCgza2sjOyR+3nmLCQNvvSuWvUoRf
         kn4w==
X-Gm-Message-State: AOAM53333ZNC4FYWqxSQUQZquZ29G7tmQwzkiNH/DflPrfnMVLdb87Ly
        AqXYTuUl+l0IoUIPR/9S8pBmEHoltDGV
X-Google-Smtp-Source: ABdhPJwprkLTWbcxJ/B2s7VtdaP+tgOQI2HcM/4+/pcP3Xw9gTr6wdo4zZnOZa29xxTuN1Ogb2EvP4dhCDHL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a05:6902:49:: with SMTP id
 m9mr660615ybh.104.1644575685585; Fri, 11 Feb 2022 02:34:45 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:03 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-11-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 10/22] perf map: Make map__contains_symbol args const
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

Now unmap_ip is const, make contains symbol const.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.c | 2 +-
 tools/perf/util/map.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index b98fb000eb5c..8bbf9246a3cf 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -516,7 +516,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 	return ip + map->reloc;
 }
 
-bool map__contains_symbol(struct map *map, struct symbol *sym)
+bool map__contains_symbol(const struct map *map, const struct symbol *sym)
 {
 	u64 ip = map->unmap_ip(map, sym->start);
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 212a9468d5e1..3dcfe06db6b3 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -152,7 +152,7 @@ static inline bool __map__is_kmodule(const struct map *map)
 
 bool map__has_symbols(const struct map *map);
 
-bool map__contains_symbol(struct map *map, struct symbol *sym);
+bool map__contains_symbol(const struct map *map, const struct symbol *sym);
 
 #define ENTRY_TRAMPOLINE_NAME "__entry_SYSCALL_64_trampoline"
 
-- 
2.35.1.265.g69c8d7142f-goog

