Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FC8C001E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Aug 2023 18:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjHJSJu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 14:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjHJSJu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Aug 2023 14:09:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1A1703
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2023 11:09:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58667d06607so15404367b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2023 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691690989; x=1692295789;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nykc+Kyyh1+8m1DKPGBWNjKw48feUTxYe7ZnBfqGNo0=;
        b=SDdl8aJg4mXyp8R19oy/uvE3JdkPqurz8XeUyM6WDyjHBw3NfVAxYv6lFd1LfaGtrO
         M9EBkXlSebuLnFcNDVfcg3G7WRrkhahXNTQI/eb7099wZsSyEzIzlOg6Sc1hpQ3ZHCgJ
         4eAQA4V0hNa9z7OSwOs2BRoLVDaPYGhCt3yfRO7tsGskTplb6SV1BUusTNbKe4qRYXxK
         wvooAEy9gOX1gv9o7nL/dbH60nM0IEaNeEmfJdBd1kg48kkofExkoEfAgYOgLGFA1Rfg
         oC4He/il4f4WtFaLi5jHOUfQKFdna0FQ6FaAmJCV41z2csPeoil9k43q08v0nbvmqFi4
         6KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690989; x=1692295789;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nykc+Kyyh1+8m1DKPGBWNjKw48feUTxYe7ZnBfqGNo0=;
        b=k3WWvRuXvHp+z3DqVpPjhtJ31I+BnDzO+pFTbOb2U12TfJb3FhsGp1o0nEoWiV012c
         wyM0BXmgn32lqsNWWRPmRQsDKjvvthoDFeiIeCdcf4yoCZEbRSU1PiBn6C0+pKtqfu0D
         6sFCEGRIZrfAe9pDaiAVRscQkSw0B0/rsTGB+EVCZ55o0gZRli/Oy2/aYbrYFD84zHpH
         GpTdyEtz5F8YYsWjfOspiLtp4ypaQeJmVjKguDajmgObUXfLWQwHvAdprcK32GoYEJ+z
         Q95nMPtipkeuhHWPE14lZJYlUXFZbzPN613VjXWTG534JCLwYOi2rJf0j5AP+vEjGvnj
         02rw==
X-Gm-Message-State: AOJu0YzMJ33XyF7XLpAumfto5rByUQW57bHzMFRx2wV6jZYML+hQIc8N
        xK8TKDo1URj+/kxcJESuOC4azkHzjeCK
X-Google-Smtp-Source: AGHT+IHsDqiFQ83RfjseHv4SyvYwvf32issTCGV6LfFt41q7SQay0B9zQzK2Hlga9OqAvGFDAuEXfmOdDuxL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:797f:302e:992f:97f2])
 (user=irogers job=sendgmr) by 2002:a25:7404:0:b0:d04:d397:352d with SMTP id
 p4-20020a257404000000b00d04d397352dmr52070ybc.4.1691690988871; Thu, 10 Aug
 2023 11:09:48 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:09:44 -0700
Message-Id: <20230810180944.2794188-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v1] perf script python: Fix python execution
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
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix missing symbol seen in:
```
 19: 'import perf' in python                                         :
--- start ---
test child forked, pid 2640936
python usage test: "echo "import sys ; sys.path.insert(0, 'python'); import perf" | '/usr/bin/python3' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: tools/perf/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: perf_pmus__supports_extended_type
test child finished with -1
---- end ----
'import perf' in python: FAILED!
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4eed8ec23994..c29f5f0bb552 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -113,6 +113,11 @@ bool evsel__is_aux_event(const struct evsel *evsel __maybe_unused)
 	return false;
 }
 
+bool perf_pmus__supports_extended_type(void)
+{
+	return false;
+}
+
 /*
  * Add this one here not to drag util/metricgroup.c
  */
-- 
2.41.0.640.ga95def55d0-goog

