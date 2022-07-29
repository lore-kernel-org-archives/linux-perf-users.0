Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33213C19F2A
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 20:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiG2Ume (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiG2Umd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 16:42:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFD387343
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 13:42:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31edbd801b5so49587957b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JAvx/aPZFM84K2VRXkCj96/gkqr/BAMXs6GSNp+VJYo=;
        b=V53PMEE0lrxOpWpkbZ7I3MSGsA160CxKl8siF2oiGa7PW5vM5/pqsAHTNN2Gt+Rpte
         qY+T1os5lqgqtSd902UfCKyx0wTLCHruevYXFkvQMd5aC86+i8Q1mxBLZqO+LH/CV9pQ
         aGGeeOgmVwoSHwEfINbUeDfc/86o17CTZtiLaAY5Al64/bO6jm6kISdaay2uziNqrmTC
         xoYLllCO0Z6xMytEW7DjIKGBN3Nz8QGTxuVGUa0J0gDUs3TZLbXAu6vOJAoqLv11qRYT
         5NzczsptV05uCOrtvHC3kmGRh8KxaAk5WTxNd+240bSl9kCdf1y7KWL9LwkpkeSXTrcQ
         /6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JAvx/aPZFM84K2VRXkCj96/gkqr/BAMXs6GSNp+VJYo=;
        b=wHyy1v36W4qBg+PgQo1eG41KnYv1JCkBUNm2xk1y2nnZCIOg8MTXtlAChZ4JZvcnxe
         DgQtWNamhnkW497I4RXf1V8E5ucghMYCvmhvzDYVh9/WdLsC8ayJvW18NEGGlIjwVMgr
         soeC4ujYJbTvNu4ciVK+gmOj0Yajoy1RYk1toC+8jr1cVc4wsbrZjv5AmurHIU4rGgPv
         1mG0j5fQakdd03ZM+HxZ/36kDL+XWR61R48sm2ldP8j23BGhhcIMEG343VbP9lJD/Xdh
         W7V6knYqJon/EcwBkZvdE+oauvrh/dhDU+3gVDlgLemythhwfJKuviC78DQy0w+Gebky
         jU9g==
X-Gm-Message-State: ACgBeo2zAco06wo8d1NnrBjnqgL5I94yyrOOZoeck4iGdxTJmTmGGJ1L
        Xci7P68NeZFoNXjeKFnwgkcMYnzOR6Fp
X-Google-Smtp-Source: AA6agR7goZ0xK7lT1FUtE0B0l2MHYOZtcNWCfBwg0hQxOMoZ1IyhHxvrev0p66aRtZea+/26eX0/Puq2GP37
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a25:8c03:0:b0:66f:8a7:5a07 with SMTP id
 k3-20020a258c03000000b0066f08a75a07mr3864093ybl.272.1659127350832; Fri, 29
 Jul 2022 13:42:30 -0700 (PDT)
Date:   Fri, 29 Jul 2022 13:42:16 -0700
In-Reply-To: <20220729204217.250166-1-irogers@google.com>
Message-Id: <20220729204217.250166-2-irogers@google.com>
Mime-Version: 1.0
References: <20220729204217.250166-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 1/2] perf parse-events: Don't #define YY_EXTRA_TYPE
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding a #define to side-effect a local include isn't clean, for
example, it inhibits header precompilation. YY_EXTRA_TYPE is
defined to be void* by default, so just remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7ed235740431..8012db830814 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -24,7 +24,6 @@
 #include <api/fs/tracing_path.h>
 #include <perf/cpumap.h>
 #include "parse-events-bison.h"
-#define YY_EXTRA_TYPE void*
 #include "parse-events-flex.h"
 #include "pmu.h"
 #include "thread_map.h"
-- 
2.37.1.455.g008518b4e5-goog

