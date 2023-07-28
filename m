Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04943C001E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 00:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjG1ANC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Jul 2023 20:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjG1ANA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Jul 2023 20:13:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A1CBF
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 17:12:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942442eb0so16906047b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 17:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690503176; x=1691107976;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6neUT/Z5ZxqZSvjTzsd3t4vT8zLu+ilqjGFbF/BwHo=;
        b=p3UY5OrtqjoAHr4YStHKi65rVDwgAEV7PTWNIAzOHMRRHlj/Q7SO5SS/iWoKuNGKNQ
         q3KH8pM5awvIVnWOT63BFHtZwwa9Eg1ijQC251g+h0PH1+pOncYTEvnlR8HJPVc1e9Zw
         zy2Bs+axgBATCD+3uHBG/x3UhoysgCIiCEISgdeClzUhp3C4K/PSNQXAIfZ/egs9XtIc
         LNUaKQbzbgSGfpDnqiWt7O2TA6OSyg3VFwMTP/o3zYgJ1HL654KUYJIiINd3H+rL9i+4
         quOk3i/9iHtGRcOE3yKsB9jhMKECdvcp+GKr49ZFChLE+XmKDMnN3oxeiRt5QV5mIeUn
         dLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503176; x=1691107976;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6neUT/Z5ZxqZSvjTzsd3t4vT8zLu+ilqjGFbF/BwHo=;
        b=jwnoesk4vsfLEjSy1lxp/+yLqz+BnnxWtj1qP3zSjX3eN0vAvTIfoZs9wLIWzBy3NS
         +C/R+R3OWjsQrxbW+lHkSiN+X1U0exXwSZw3E8q2vzektbkohGb3nY9ijtTttx5r0qNG
         DUbLbB529y0De678IBRkTyA5LUODYxHU/FpTEh4HvYiDxhlvn6tC0rf8a+Z2tF5VFEiL
         X08pdjl7ufZ87jCbWzFbAPHcYjnls/A7pOpxSViOLcDD8O4HgIQOBerGIqaUIxMLO3W/
         uFDRANypN1NVN6rEmnRbD3qKLs0CpIsPsjEa4BZT1RV9YRi7GmOlq6eTDFYgpWMn+JX0
         xMOA==
X-Gm-Message-State: ABy/qLY14QkLqZlSu7uz1NpSbW8RI56jNZ91wMXt0H4ymP14UZJICcih
        GREAKYZlPtlYd3af8g6ImN/WqNXooJEk
X-Google-Smtp-Source: APBJJlEt4iXxJP8WryqVeJzhMdGPpRqxcb6Ce1vKD99ePr2ibeCxFflRmitKYAp0ZponEC0d5cc+brXqHo0W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a05:690c:72b:b0:57a:118a:f31 with SMTP id
 bt11-20020a05690c072b00b0057a118a0f31mr1109ywb.7.1690503176098; Thu, 27 Jul
 2023 17:12:56 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:12:10 -0700
In-Reply-To: <20230728001212.457900-1-irogers@google.com>
Message-Id: <20230728001212.457900-2-irogers@google.com>
Mime-Version: 1.0
References: <20230728001212.457900-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 1/3] perf parse-event: Avoid BPF test segv
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

loc is passed as NULL in tools/perf/tests/bpf.c do_test, meaning
errors trigger a segv when trying to access. Add the missing NULL
check.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 926d3ac97324..02647313c918 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -758,7 +758,7 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 
 	return 0;
 errout:
-	parse_events_error__handle(parse_state->error, param.loc->first_column,
+	parse_events_error__handle(parse_state->error, param.loc ? param.loc->first_column : 0,
 				strdup(errbuf), strdup("(add -v to see detail)"));
 	return err;
 }
-- 
2.41.0.487.g6d72f3e995-goog

