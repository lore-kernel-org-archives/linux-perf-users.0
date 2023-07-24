Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1268EB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jul 2023 20:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjGXUM6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jul 2023 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGXUM5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2023 16:12:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A2F188
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 13:12:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc68c4e046aso3983547276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 13:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690229575; x=1690834375;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGj2kfysUV4g0RCVNKokJtTz3uk6e/9iDcRIi02L+1I=;
        b=xfSlkQOsI3qPMDrf1nEk8lyQFBv+EIRpIaJyGMyR8weYJio1zxThHihc/jxp9zAOjd
         J+/G2FuQkT2HJYSV87vaVdZB0SpRldwcE8nbLypaCaNcXX4Zs4OgEs691Vcn/5/82wPv
         r6z6f1alHnhcHuFHHg0zl0pDNrW7IZSRrubQyKRQ1/bQ0uD1MrMZuQ2o30+jwbjPbEHv
         I3p2plZt2TCD480+dwdthrgFj/Be1npcPzMl42aNPfhOAgSXtnK0NcTgo4AWNRDrvcum
         zKr9t/I+eDdWeyqrRaNZeH7bSjELF0HRbRZZQofoJVnuJl8aN+eM8uAElrd8XwWwGGqm
         gPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229575; x=1690834375;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGj2kfysUV4g0RCVNKokJtTz3uk6e/9iDcRIi02L+1I=;
        b=B/NEGgFOa6IU5EhFagywN1ywxQGmCoTkSxAkhyiliZAYenhAznFXy9zbD6vtk/dC2+
         DFGcMgnK3ce17gLzFVaFQgPMvtnfyF27LBWzP6iFXpE+vJObR1AMQGg/xxwxntCKvCF0
         MOI8rMzcbKMiKmB8+8LKqZ/Sbrg7bZ06h9Acq6WOx0u85H8ieBsm59ZmZyNSypaWLCxr
         SmGCFlSQy6Iw46dfm+5lE1WPxYZa/81zUL2lsGVI85mrcXOUoymQQTZQd+t3jVqJqaX2
         gNLZPrMaUvU1o4oVWt4VTh9CvZjy7pDqDx3VJAEL7FHQXUxkPjUwBsThL1XzCM3c13Oh
         7X8A==
X-Gm-Message-State: ABy/qLaqkDJWSmNL1rf3DSX8Q98WBse2EOvdfIULLJyJ2voSpPq9h9Qk
        68YGhjCXmmFOUAVx44xMuohc8HEevisp
X-Google-Smtp-Source: APBJJlE8mCdXmPG/yyxLopo+wcpvOgjYepWOuOYy8z2DmCTuLGVU9NCM2altTV0Kc3Op9Sjqzy62LFCO40FX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5724:8dc0:46f0:f963])
 (user=irogers job=sendgmr) by 2002:a25:bf91:0:b0:d11:b0d5:cd09 with SMTP id
 l17-20020a25bf91000000b00d11b0d5cd09mr20400ybk.8.1690229575692; Mon, 24 Jul
 2023 13:12:55 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:12:44 -0700
In-Reply-To: <20230724201247.748146-1-irogers@google.com>
Message-Id: <20230724201247.748146-2-irogers@google.com>
Mime-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 1/4] perf stat: Avoid uninitialized use of perf_stat_config
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_event__read_stat_config will assign values based on number of
tags and tag values. Initialize the structs to zero before they are
assigned so that no uninitialized values can be seen.

This potential error was reported by GCC with LTO enabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/stat.c | 2 +-
 tools/perf/util/stat.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
index 500974040fe3..706780fb5695 100644
--- a/tools/perf/tests/stat.c
+++ b/tools/perf/tests/stat.c
@@ -27,7 +27,7 @@ static int process_stat_config_event(struct perf_tool *tool __maybe_unused,
 				     struct machine *machine __maybe_unused)
 {
 	struct perf_record_stat_config *config = &event->stat_config;
-	struct perf_stat_config stat_config;
+	struct perf_stat_config stat_config = {};
 
 #define HAS(term, val) \
 	has_term(config, PERF_STAT_CONFIG_TERM__##term, val)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 967e583392c7..ec3506042217 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -729,7 +729,7 @@ size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp)
 {
-	struct perf_stat_config sc;
+	struct perf_stat_config sc = {};
 	size_t ret;
 
 	perf_event__read_stat_config(&sc, &event->stat_config);
-- 
2.41.0.487.g6d72f3e995-goog

