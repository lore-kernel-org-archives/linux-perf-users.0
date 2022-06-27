Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C9C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Jun 2022 02:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiF0C6J (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 26 Jun 2022 22:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiF0C6A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 26 Jun 2022 22:58:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F3A38B7
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Jun 2022 19:57:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-317765eb7ccso68442747b3.13
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Jun 2022 19:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tzj7ylrYrsJBExl0Lk41LyqA59fkITJKPr6Jgpr6q2Q=;
        b=XszNzJBM+rUdzKZ19YdcKNR9NIYYn4y+1xodUKsX0Vee1ppX64Wn9auhmAKV9sCZMs
         z0qmsgFZxWhHHh7Ar/OlLRr7qb/3MDl9OZz2TafV3TzYiJzLaDxvUkJ05U4mL6gSbx6H
         ogjCAFX3grIom59jr6dIHkITC8AQSD1+02mcC9fWVJR2PxfQABKztHZh6S+07TFiojjz
         unrVzUsMXHwfX0NSotudGfKxL3TZHeZa3DoWVe+dtFl+6bi4+ISNokuRBDU4ioar4mhx
         n7nOa+AeiGGFfmqCd3jAnToNkvC0RhK4tNnpRHu79frUfYM+ZMo61xPMDVZd4Zzl+lcZ
         6MkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tzj7ylrYrsJBExl0Lk41LyqA59fkITJKPr6Jgpr6q2Q=;
        b=JCC5FaqtraRHCGBJKaOS0/HHmPlEPHMxQmHmODcRA2/IMmA/wKkVTv9AuYTe0eWMdu
         SJOwG8h3rPV2Is4I1S7Y0y+ld05M6IFKwLpmHOdOPzYbWFoB0HxRRgX9nOnVjeMwlONQ
         go4X83CjpyyXFHJqYyFr97rMSy3NEU3xw1qqCv2x4tPw3bOaKWp9t6m4nRGEmaxJeOxh
         5hWDejeAXs0ZOYnrLswYQkbm4Y3wgxfVcigfIo3o+uPxPDRVRJzfsKC7YeJJJtmciLVf
         e5HzBsid+8jBY4uVi0276unUegFER3OeUi20OG2o6V4sHtCZp7/Acs9gp0bbNDQwsQyu
         S3dg==
X-Gm-Message-State: AJIora+p7U3VHTwlT95ONewZlDk7Q/ha+/e2ElZmuZNw0IJiW7nY0dr/
        50i4d1Y549l/YM1BLg/YDwg+9nw7IRGm
X-Google-Smtp-Source: AGRyM1vHjxlvtCQA8+4nTCfMsQlj70YhfLJw1dOG8555NVmuu/roe9ckJGuAuj0BzjMdSmn+PamW0rq4W84W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:646b:8b65:8f13:1c18])
 (user=irogers job=sendgmr) by 2002:a5b:c45:0:b0:66c:cbc4:45a with SMTP id
 d5-20020a5b0c45000000b0066ccbc4045amr3632113ybr.356.1656298678460; Sun, 26
 Jun 2022 19:57:58 -0700 (PDT)
Date:   Sun, 26 Jun 2022 19:57:41 -0700
In-Reply-To: <20220627025744.106527-1-irogers@google.com>
Message-Id: <20220627025744.106527-2-irogers@google.com>
Mime-Version: 1.0
References: <20220627025744.106527-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v6 1/4] perf python: Prefer python3
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <rogers.email@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Ian Rogers <rogers.email@gmail.com>

The PYTHON_AUTO code orders the preference for the PYTHON command to
be python3, python and then python2. python3 makes a more logical
preference as python2 is no longer supported:
https://www.python.org/doc/sunset-python-2/

Reorder the priority of the PYTHON command to be python2, python and
then python3.

Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/Makefile.config | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 73e0762092fe..16c1a87444b8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -241,15 +241,15 @@ endif
 # Try different combinations to accommodate systems that only have
 # python[2][3]-config in weird combinations in the following order of
 # priority from lowest to highest:
-#   * python3-config
-#   * python-config
 #   * python2-config as per pep-0394.
+#   * python-config
+#   * python3-config
 #   * $(PYTHON)-config (If PYTHON is user supplied but PYTHON_CONFIG isn't)
 #
 PYTHON_AUTO := python-config
-PYTHON_AUTO := $(if $(call get-executable,python3-config),python3-config,$(PYTHON_AUTO))
-PYTHON_AUTO := $(if $(call get-executable,python-config),python-config,$(PYTHON_AUTO))
 PYTHON_AUTO := $(if $(call get-executable,python2-config),python2-config,$(PYTHON_AUTO))
+PYTHON_AUTO := $(if $(call get-executable,python-config),python-config,$(PYTHON_AUTO))
+PYTHON_AUTO := $(if $(call get-executable,python3-config),python3-config,$(PYTHON_AUTO))
 
 # If PYTHON is defined but PYTHON_CONFIG isn't, then take $(PYTHON)-config as if it was the user
 # supplied value for PYTHON_CONFIG. Because it's "user supplied", error out if it doesn't exist.
-- 
2.37.0.rc0.161.g10f37bed90-goog

