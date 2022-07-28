Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54F5C04A68
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Jul 2022 22:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiG1W3K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 18:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiG1W25 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Jul 2022 18:28:57 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D647A51C
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 15:28:53 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u4-20020a170902e5c400b0016d6a70a282so1897281plf.10
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C+isQDTjfYgwoBdi8ZF1+k8jnCvyTTKgCTIA0bNoRsE=;
        b=rZ/t808b2UAp/pVT4tYGxfTi7iCGP/oyXOCx8jlW88r1aeWuTSeysum/+L/bQ077sw
         kS8lEciYjUXgC/Ljtz18ghG1lJYYhmcTqIhdTf6oL46WSDQcQ39P//q7VQ+D/wSiKbEy
         N5ldsPWWMMhjzLPG9C1uydL98QE03DIDZt/tyYnNN4REU7xTJP+JYECAk5kJkXJafezt
         W0SEG5jK11XAopleSM5Ups0rJwo+n0GzY1g/EDBeJWMliEHqvUl4isep3hKcK+Lrp1At
         i2I9J0wWbfhCEv4XQv4Yv1cEvqxocV7Od+QI8UYBpyKLq2ZnfORqLkos4J2i/DnKsaOZ
         0btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C+isQDTjfYgwoBdi8ZF1+k8jnCvyTTKgCTIA0bNoRsE=;
        b=KihGqGqt1pToAARvFCS64zNO8pMN1qXNtoEfNNwPxjBbEgO1KTbHZx0TEJEbN+305k
         AJx7zFM9b73LQUAxZzntlfJgIAXYIz690fXk3MHDz2DqRRoEfaj0Tj3RHfRnegwwHJjv
         cFivtxGUHEpM1V4HMjNbFBaCkfmwxvCsR6W+Kj1caX9FfD41N8iKuAVEqhs/8dOABu6e
         O8JjI5WNhAckOkR288+izgzj0kRDwzGqRnYlh9044mWrRKRFbvgUS/tECbs2wr3qMz2U
         4mzcLM44mP+mEGZap53l969HyThZ3Dp360sjlj7qicU5qbuMkQS14iD+evd5QWmHEnv+
         G52w==
X-Gm-Message-State: ACgBeo0JIeqCxdrkc8ptWJJwPPtzPH1UHJM3k0hYiX+NQ+mIrn3JHAbC
        WzYRz/268tOk91yPiEZos9Mq0q0VvbFK
X-Google-Smtp-Source: AA6agR6UiT7KBmhevKE2QVNBEvxGz11GM1uIdmF0gIoZZatsNkzcDpY4c2jHUQlh5S59qr+9zsF2ChGDAeYi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fd09:96c3:28af:b08f])
 (user=irogers job=sendgmr) by 2002:a17:90b:10e:b0:1f1:f3b0:9304 with SMTP id
 p14-20020a17090b010e00b001f1f3b09304mr55590pjz.1.1659047332452; Thu, 28 Jul
 2022 15:28:52 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:28:24 -0700
In-Reply-To: <20220728222835.3254224-1-irogers@google.com>
Message-Id: <20220728222835.3254224-6-irogers@google.com>
Mime-Version: 1.0
References: <20220728222835.3254224-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2 05/16] perf jevents: Provide path to json file on error
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
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
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If a JSONDecoderError or similar is raised then it is useful to know the
path. Print this and then raise the exception agan.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index c53c744da56b..7d5110327468 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -225,7 +225,12 @@ class JsonEvent:
 
 def read_json_events(path: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
-  return json.load(open(path), object_hook=lambda d: JsonEvent(d))
+
+  try:
+    return json.load(open(path), object_hook=lambda d: JsonEvent(d))
+  except BaseException as err:
+    print(f"Exception processing {path}")
+    raise
 
 
 def preprocess_arch_std_files(archpath: str) -> None:
-- 
2.37.1.455.g008518b4e5-goog

