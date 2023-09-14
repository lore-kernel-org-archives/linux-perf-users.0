Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315A3EE0213
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Sep 2023 02:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjINCYf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Sep 2023 22:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjINCYe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2023 22:24:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0141AD
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 19:24:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8027f9dfefso642855276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 19:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694658270; x=1695263070; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mr6eRGX/mot4ysHxW2nXh0B8TIVosY14z+Vg1QOhCRI=;
        b=jEYk0O0GqLNvr7w9JKUGQI+pV7PWXZkv7SPKQ6XmSFZM+C65Os5joK590+nvWe0Lwp
         +cPeGLyn5AHJprhBXPkRPGbGVfwYK3FbRyGZW/UQwoU9d7NuSGq9cKuoVKd03FTvwDkJ
         d2kbo6e2MC/mvUhloIR9kQsQaRE5DLZfHh1ySYE8YVGqEKwV9B00o9id9KPPXIEv8H+L
         imxqA6AX8lzhDhPa67jwHIQfpIZVp5oGXgyb8DRBj8Un0hwkKW9V14eGpm5NFLgQI025
         cvzaEahlleo4OBZIMIgU/z06YjqswoIp6toq+2RBh4yGoqYp74rWesSoe8p4A4rM3uPk
         QQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694658270; x=1695263070;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mr6eRGX/mot4ysHxW2nXh0B8TIVosY14z+Vg1QOhCRI=;
        b=rIa07m5L2V5iIZz5sQ/FJXXiANQoBgzHbQx+OTBkCx6K551ljDFWMQXP34CYXMiuhO
         vbIAEZMVV3Y0lw0mQlRVgQFWfUUJZ+DVnsLrxT0W0SimUH8wyrL64IPRBt1uBTGfkSad
         brUnz/0EF8U+9h2jaok17r8cCYFXil4aW2+lN+68u4W8lraYtqHU9XDC2DyME0Gx9PpK
         rFmlOHnG7bJZFfB52smgLsWpuWI47k+GHgMZBwZANJEA9Jm+n92ilZxhGo9jQ5ZGC4In
         fGOM645Rgah0DwTMyADct25D9s1qKlaToF2K2zAV7bYp+HLN4DOqyCpI9f15DhqcVLyw
         nBAQ==
X-Gm-Message-State: AOJu0Yzx1pK+SY0Ib8haB4SndjkSTDUbcu621f8oJZeGr78et8u/43gz
        8O8EoDNuxhOwB+m30AG9HGNqWiPqL0Au
X-Google-Smtp-Source: AGHT+IG0qp2pzoQ+1PCyVwi/VCysIK1PqTEdrLS85yYQCAAqNmlaQqZSyKSExA9+ptRGctE4ca7HtSwxoZlJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7612:4bb6:bcf1:779c])
 (user=irogers job=sendgmr) by 2002:a5b:8d:0:b0:d78:245a:aac4 with SMTP id
 b13-20020a5b008d000000b00d78245aaac4mr100091ybp.1.1694658270080; Wed, 13 Sep
 2023 19:24:30 -0700 (PDT)
Date:   Wed, 13 Sep 2023 19:24:25 -0700
Message-Id: <20230914022425.1489035-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1] perf pmu: Ensure all alias variables are initialized
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
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix an error detected by memory sanitizer:
```
==4033==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x55fb0fbedfc7 in read_alias_info tools/perf/util/pmu.c:457:6
    #1 0x55fb0fbea339 in check_info_data tools/perf/util/pmu.c:1434:2
    #2 0x55fb0fbea339 in perf_pmu__check_alias tools/perf/util/pmu.c:1504:9
    #3 0x55fb0fbdca85 in parse_events_add_pmu tools/perf/util/parse-events.c:1429:32
    #4 0x55fb0f965230 in parse_events_parse tools/perf/util/parse-events.y:299:6
    #5 0x55fb0fbdf6b2 in parse_events__scanner tools/perf/util/parse-events.c:1822:8
    #6 0x55fb0fbdf8c1 in __parse_events tools/perf/util/parse-events.c:2094:8
    #7 0x55fb0fa8ffa9 in parse_events tools/perf/util/parse-events.h:41:9
    #8 0x55fb0fa8ffa9 in test_event tools/perf/tests/parse-events.c:2393:8
    #9 0x55fb0fa8f458 in test__pmu_events tools/perf/tests/parse-events.c:2551:15
    #10 0x55fb0fa6d93f in run_test tools/perf/tests/builtin-test.c:242:9
    #11 0x55fb0fa6d93f in test_and_print tools/perf/tests/builtin-test.c:271:8
    #12 0x55fb0fa6d082 in __cmd_test tools/perf/tests/builtin-test.c:442:5
    #13 0x55fb0fa6d082 in cmd_test tools/perf/tests/builtin-test.c:564:9
    #14 0x55fb0f942720 in run_builtin tools/perf/perf.c:322:11
    #15 0x55fb0f942486 in handle_internal_command tools/perf/perf.c:375:8
    #16 0x55fb0f941dab in run_argv tools/perf/perf.c:419:2
    #17 0x55fb0f941dab in main tools/perf/perf.c:535:3
```

Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info files
from sysfs")

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d85602aa4b9f..8de6f39abd1b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -520,7 +520,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		pmu_name = pe->pmu;
 	}
 
-	alias = malloc(sizeof(*alias));
+	alias = zalloc(sizeof(*alias));
 	if (!alias)
 		return -ENOMEM;
 
-- 
2.42.0.459.ge4e396fd5e-goog

