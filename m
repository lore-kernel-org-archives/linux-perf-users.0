Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B696CCA0FFA
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Sep 2023 18:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbjIESTE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Sep 2023 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbjIESSp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Sep 2023 14:18:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA34211C
        for <linux-perf-users@vger.kernel.org>; Tue,  5 Sep 2023 11:17:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7eaffe2f99so2372485276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Sep 2023 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693937764; x=1694542564; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y07qFiYECd11N+vNvyoUjAree2R1P2rvhI0ssuxH2Wo=;
        b=5AooYeZNFOvx3uewyZLZ1QCM1ZfEoxMP6OKst4zb64nG0X8JVlR6sUzXXWNks2OFho
         PV/jBAHLGv/5sAsNbNeV3YdHXXWTx1qMRfUIlaK2/b48cffEyLVqzrMBw4YMwcT1JEbZ
         RCXA2wuayqPP1rTM8EGzVxkj6jyDpQzyaedOt9PBg1mf1ZvlcYaMA0oWr0DporGZ21gA
         V195vh9iaGZFBaTdxryJB4SNQ6r12pYTIlm2MlYHDR+ahR3BuThbFCpDOC/OdaqoGfJA
         VS7mGQFz0en0pcEE4KvA0HrzCr7Bo6lhKTgisNpIsv3jHYGCNT/OZjJ/95GBTXeHZ926
         6htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693937764; x=1694542564;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y07qFiYECd11N+vNvyoUjAree2R1P2rvhI0ssuxH2Wo=;
        b=k/GyzkmWMhQVhPS5kCHIfNv+zfkrObbFrvCbviX6SkFVG/ow6c1G8WKMcAXUN+moJh
         MvqQlPOOvbALu2iHBUMmV0sj2wSAh4XBsHun96oVElRlEMJjv53qjL/0NAWIkTm4gu4K
         Yc7P9wTE5/TtQ58lu0RsSH0jnKrJKwAGInxC3rdOeONpGEdwUUxXby59AaJEkm1VDMnJ
         gRfC5hM8xsT2wuJbAyOFoOt9Nva4An8n4oVSDJfGBce2742w2SG1ArfmaBI2OLA55hyd
         3C7sWaCDaEk5wuvLpXFB+oLS6ijgdlpJLfXyuZtvsqlK07crKi1SmoqvtywELtsQh9Cu
         0IcQ==
X-Gm-Message-State: AOJu0YytMOM6ZF2yeKfmsYc1CeeB/zBJt7Fph7At/bB3JVuRSr+b3IYN
        0+oDC0i5htsFJJAS+QgM6CLtPH8zWRk5
X-Google-Smtp-Source: AGHT+IGKRFAQrI1REpVPNXdfYLh5y8eD2YG5x0DJqWAPOVbWUocmJHtuWN0HGbLbFiPnjQkJF1YHSzpLpx7e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1e0b:753:60d0:6c22])
 (user=irogers job=sendgmr) by 2002:a05:6902:180c:b0:d0f:a0a6:8e87 with SMTP
 id cf12-20020a056902180c00b00d0fa0a68e87mr308639ybb.2.1693937764506; Tue, 05
 Sep 2023 11:16:04 -0700 (PDT)
Date:   Tue,  5 Sep 2023 11:15:52 -0700
Message-Id: <20230905181554.3202873-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 1/3] perf completion: Restrict completion of events to events
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf list will list libpfm4 events and metrics which aren't valid
options to the '-e' option. Restrict the events gathered so that
invalid ones aren't shown.

Before:
$ perf stat -e <tab><tab>
Display all 633 possibilities? (y or n)

After:
$ perf stat -e <tab><tab>
Display all 375 possibilities? (y or n)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index 978249d7868c..40cfc30ad7ad 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -164,7 +164,7 @@ __perf_main ()
 		$prev_skip_opts == @(record|stat|top) ]]; then
 
 		local cur1=${COMP_WORDS[COMP_CWORD]}
-		local raw_evts=$($cmd list --raw-dump)
+		local raw_evts=$($cmd list --raw-dump hw sw cache tracepoint pmu sdt)
 		local arr s tmp result cpu_evts
 
 		# aarch64 doesn't have /sys/bus/event_source/devices/cpu/events
-- 
2.42.0.283.g2d96d420d3-goog

