Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4814C00144
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 07:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiG2Hoe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiG2HoT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC19665666
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n184-20020a2540c1000000b0067691de454cso2499661yba.11
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mqNHYsVWGj0fcO4+XKl+I9RLjcmp/sKEanarsLP2wxg=;
        b=RJcVJE+hnyZrLqpNeLhiP9SbUZi5PF1h2Xz8hG5gfDrto2ZQvRbIcC6+pAXjRuhbXS
         hxf5W34jXcMzU2CSQeY4iX89QrtXGzGakLrL+jut524o4UiZznud+g/U7dnxxAqrqlQT
         pzXDXlpBwMSb0l3uxn+/I7DzOr+PXPhV5f2aefc12bYS8AsaCHGNI7SYJli4tevGjywb
         sjAke3+r/1BZzyPlQMjKvu4ZlUqYoJZIcGX2HFRv2ByMovs9934a832sOvC4E/EY360c
         Z9KwuNdsFQwBBf5wGlduUlXAcoWQRtqSha80ussn7tI3v6pjtpcTMvkdeP2C/mBzt5DT
         vnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mqNHYsVWGj0fcO4+XKl+I9RLjcmp/sKEanarsLP2wxg=;
        b=bWmGstyYXCKnmk6e15IQ0WJKsChqMtqpNw5V2f9Wh7V+U0uHI11upfyuMUNyqByou/
         n6ZKxYMa0hcgH9q+ZSOEuF8KAr6UiD6IhNR9IhN1E7GM52oxg7WghA4kjFSyVO5Rm3Hf
         Nkw+G3AtY7tqYz9iFaLpKaSKjaWEOHeKlLDAGPQdakNa3+4zIWXul2QRvAJsQLx1eWPr
         OVQls/ANlfS+Lx/GhWovkaEyXypRqGK87gvocnXTnPGLt/34+6JpU9r4matoclbRwPrY
         ibYhZDneyEPuGnxcgkEchUnkkm1kITaXXawaXpyUd8LeElOzrhVx0bsq6rPBxtkHl4jw
         fb1A==
X-Gm-Message-State: ACgBeo2CfL+HSXYQY8F0hTq2BqOxzhu/o31sAApflonJCGLIUc0eePuo
        3lx9Vea3TdknS+Tm9Tw8qyz0pX4OXrKV
X-Google-Smtp-Source: AA6agR5bkDJ5EE78BgJwxPU+WAXWDt1bh9VDrLedHC8RwnOPxWMaMu2tKQ6y1risxyc6dYbK0QDT6tXW0iKG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a0d:c602:0:b0:31c:822a:c168 with SMTP id
 i2-20020a0dc602000000b0031c822ac168mr2198798ywd.134.1659080657058; Fri, 29
 Jul 2022 00:44:17 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:40 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-7-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 06/17] perf jevents: Provide path to json file on error
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
index 98d18d5c3830..12d2daf3570c 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -224,7 +224,12 @@ class JsonEvent:
 
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

