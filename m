Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68095C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 23:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F46D61206
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 23:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhIJXYX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 19:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhIJXYI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 19:24:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE14CC061756
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Sep 2021 16:22:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a62-20020a254d410000b0290592f360b0ccso4543118ybb.14
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Sep 2021 16:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A/ezR4Ofeh4QWbDFg8gsprJ3lNIyVX/YPJuv/wW2Gu0=;
        b=PmML4m6yioSdQsuVAS57iaRzPFYLUZB+JA1EnNTkKm3JgmkyHmSzznPo8jIrWBranS
         +J76FA9CQbtyJKeHVFSLtByZi9HIfG9yv1XTbh4E0krjQwWPi+VDi8FZqcZuYgra1H4W
         yXOk+aY1Vx51COkhHTCDqSEfhtwPPpn82bj1G+kb992++/b+L1F/JrjbwUD3vpMDRHZI
         6AhF3/Z0003ABiOqjz27pxEybEsQ4I7VxFNo3unT2EeW6TrzGg0K+vWuO+xqRh6hI1/z
         TcIT2sYgPEhUMJ9ZN44VoOvMQPch5eQCNQRL1WM2Mfkb+x3urGTJzyIpDhzSSalgoPSM
         FzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A/ezR4Ofeh4QWbDFg8gsprJ3lNIyVX/YPJuv/wW2Gu0=;
        b=7tE9ueqYPdg/pk1ZVR2FtZ8Ij5s2mq55meDsOg5FVSK6SiPu5g8uFfm5KXFlkCbr7L
         cW3uhpzkzYoR1BmJrX9ROxBB+b4IDwGn8VUsV4NoP7SD/+MyGRt7XUv4Ws93knnr1Yyw
         hBi8taKek/egLhWJEG67AKjBb7XnyTeqL2pGOEJ3yKD56Z7VFEm3hWAjGvdNmzym23OZ
         jYdtEFF2Tj5YTF0plRMsHBzLj+fLu1GT+T71eFlUJawXIRxlQjMqgeVXsE+pPZFZ7EeC
         xOYGyP8qj7A/7/NR7ocKwnOFhnsEnCCvVu5Pw0C2ejfaSUUuprxciAE0oOd+KKBAvCYB
         QqKw==
X-Gm-Message-State: AOAM530ItYcAslMBrV1ZfzXcOQM2Lb4qgN9XOZ5nmH7V/tr+AQevG7QK
        CvcINj1F1neQ6L8mOV4ipB26CNBm4onx
X-Google-Smtp-Source: ABdhPJwcxpjPWnvKHsOhaNyaVrgUPsC18bqDB+wPG9fEOtT1cU7h4Cq+ZDJ0DcJU0xQeEc+dszZhbWBByfTB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:245:160a:d9eb:a3dc])
 (user=irogers job=sendgmr) by 2002:a05:6902:150d:: with SMTP id
 q13mr275812ybu.515.1631316175887; Fri, 10 Sep 2021 16:22:55 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:22:49 -0700
Message-Id: <20210910232249.739661-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] perf tools: Ignore Documentation dependency file
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: a81df63a5df3 ("perf doc: Fix doc.dep")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index e555e9729758..8e0163b7ef01 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -39,3 +39,4 @@ pmu-events/jevents
 feature/
 fixdep
 libtraceevent-dynamic-list
+Documentation/doc.dep
-- 
2.33.0.309.g3052b89438-goog

