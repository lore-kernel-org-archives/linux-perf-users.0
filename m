Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32279CA0EC2
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Sep 2023 21:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbjIKV2J (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243343AbjIKRGV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Sep 2023 13:06:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB8012A
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Sep 2023 10:06:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b6083fa00so32002947b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Sep 2023 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451976; x=1695056776; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRCYGoTjjcBophstCTgDgCPllSE9scm8ZFVfCDuwbMQ=;
        b=4EHxcPJv77hNl+7rXblAISOV1A5jk322xPjjLWmpMWPApLC5mtbFAJjcNlH/Cfg0CV
         O4Jx8u2UoxHzmuqKrimsynrN06cQkxtX9fXVdOuG9E/J532NH6RydHBMGQY+rkPG+3oV
         QoxZLzbBaS13lijfJ3LnmNyuamfwOYCRAEXIFm0FqN8XcR2ig4nOfKPAzoZ9+kXJ4LlV
         V+dfaqvgUx9ZjdZxbMIatpcOgN2WIxC+N9C1zcBsPvrLDZecvVNpXcKhf890rtMsPmoZ
         KtaiiEx1kJQHQoIH1if+RJy+7cRTz+g2OMSdGauz2KRabhBA7SBJa7mXVt8034MJDPN6
         r5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451976; x=1695056776;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRCYGoTjjcBophstCTgDgCPllSE9scm8ZFVfCDuwbMQ=;
        b=pamL+OgWc2vr0DQt4CkbXZqFPyBfxzl8doXJmu2SqG4JNWHU3qywEjarBDCeizEfpP
         /1P3p6CxJ6MKWzk6+4B45g3Ignuiz7N4U1O+bp9imKPNdMP+FmWYHzwgxl83xlLVRJhb
         jPJacybniM70Kqb/FYr4YBbPy0CjhVuOaKiDITQ9zQMexQfWB7dNwX3zcp6eWeZQJloQ
         nIoqISq8S8BJ0rpEhWxC8EmXEzn0zXUYUZR7OZod4no2ENtngPY1VfavKIYim+GiC+43
         e7VYpJQrGoxDI91rYdRJMAvxs+2fDIJnPXSfhoYBEjUouBw+soDZ+Bs1j+XOhgu4ujPq
         AUFA==
X-Gm-Message-State: AOJu0YwvlLX5z9EyNKp1keX/bkiQurJTAHLzTVwRet29rrZaPr9Rdpz4
        mb7wTf4aNNWcOBqKrus19CnDe412aIag
X-Google-Smtp-Source: AGHT+IEYtgLkZOmrsQVv+5dnEAGGCmzF/e5/Bc/ESvtcLe0YzUoWzx6RXlKagJYsvqgnlYoolnqNvo6bX6Qr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a25:aa73:0:b0:d72:8661:ee25 with SMTP id
 s106-20020a25aa73000000b00d728661ee25mr214482ybi.2.1694451976506; Mon, 11 Sep
 2023 10:06:16 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:05:59 -0700
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
Message-Id: <20230911170559.4037734-5-irogers@google.com>
Mime-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 5/5] perf bpf-filter: Add YYDEBUG
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
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

YYDEBUG enables line numbers and other error helpers in the generated
bpf-filter-bison.c. Conditionally enabled only for debug builds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.y | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 5dfa948fc986..0e4d6de3c2ad 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -3,6 +3,10 @@
 
 %{
 
+#ifndef NDEBUG
+#define YYDEBUG 1
+#endif
+
 #include <stdio.h>
 #include <string.h>
 #include <linux/compiler.h>
-- 
2.42.0.283.g2d96d420d3-goog

