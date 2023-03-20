Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CAEC7618A
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 03:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCTDkG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Mar 2023 23:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCTDjk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Mar 2023 23:39:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4309621A3B
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Mar 2023 20:39:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i11-20020a256d0b000000b0086349255277so11807287ybc.8
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Mar 2023 20:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283555;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp06SaO3sEqKpsudj2OEFM6hmtCSHDlmEVrT0Oyh9g0=;
        b=oVlLy7C6zk07uvV078+G3tAiOSzYAnnphvIKsGkr7X87lY7rdXejY5aqdAZhnZqurU
         NLmHm30WqEW3T4Ohz83AZNdwIWA6BqcBR51g66JhSdnUB7xRaQw7PU2zYgMibh7YrqIq
         9ZpEBh7W7VfsRswyeQNnDf7VnFEPy0zWYb+cMafP1CKpk/2l3eQRqA1CnuX1SzUIaMWr
         r63nsFVxf5KF2TKfTYcpNWMAD4DyXgcYuzFT/9jJUuHF6VK6HrQ07RrMtoOuAL/ZjWKt
         zoWMGS/5DkjqASK2ZdZrIcQmSSRA/BLLQIk4M7DZAHsdX88Ep1WdRiCCP8rADhVeSBRx
         70KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283555;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp06SaO3sEqKpsudj2OEFM6hmtCSHDlmEVrT0Oyh9g0=;
        b=tu5F88eEeG1fKIPIvqL7nDnqFv/RyUlQMVvNhmG5U+vVmwPz2WM98r/v0GyXFGbhV9
         8Gw4bGGaCsgfXxdlWnPpIsbxc8INZT2/E4OjZbO+cPL/kQJlWnOuNrtvDyLLOe9hOyjx
         bfO85VNah45HzI6apgwvo3BYqutqdvnWjkgk3FiPrguG8ajRhwML0nvpSeTCWazyvDr/
         l8ZG87aLA6UIketKEX629UA8HjUUc4dbumzrW+P7dfDf6El6TxNRlQAYMO87gFsBTLqQ
         m/nC5YgC+HejotMMR1lbGUBIHCpFafUQ3E+X+nv2W2eNb/zYF2aQTPbeugTY+8FUinNI
         Iomw==
X-Gm-Message-State: AO0yUKUJxky2RaVSpdyt0oSMA9Z9UUL/CyUm6aJm3HQGiO1buegFQq76
        PQdHMU0z4COAUqEKFkzu9JXnzeiiYMIa
X-Google-Smtp-Source: AK7set8DXFIYSHJXW7PIqklNOFVLXkRtk81Ryce9utE5CyGINekjemf91kZj1GKnU0xUvk3YNr67AY0kdQGO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a81:b649:0:b0:541:8995:5334 with SMTP id
 h9-20020a81b649000000b0054189955334mr9279059ywk.3.1679283555031; Sun, 19 Mar
 2023 20:39:15 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:37:53 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-6-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 05/22] perf symbol: Sort names under write lock
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
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If finding a name doesn't find the sorted names then they are
allocated and sorted. This shouldn't be done under a read lock as
another reader may access it. Release the read lock and acquire the
write lock, then release the write lock and reacquire the read lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 317c0706852f..a458aa8b87bb 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2018,6 +2018,9 @@ static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 	if (maps_by_name == NULL)
 		return -1;
 
+	up_read(&maps->lock);
+	down_write(&maps->lock);
+
 	maps->maps_by_name = maps_by_name;
 	maps->nr_maps_allocated = maps->nr_maps;
 
@@ -2025,6 +2028,10 @@ static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 		maps_by_name[i++] = map;
 
 	__maps__sort_by_name(maps);
+
+	up_write(&maps->lock);
+	down_read(&maps->lock);
+
 	return 0;
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

