Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13F8C54EBD
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Jan 2023 18:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjAMS5w (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAMS5v (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Jan 2023 13:57:51 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7618DFD39
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Jan 2023 10:57:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4b34cf67fb6so235742507b3.6
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Jan 2023 10:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s0i2zZBdrCWRI9lmKA/36c64wVimSwf1CiL2+om4mgI=;
        b=e6pfazQiYivaHP9XqMCP5fL6vnwPvriEHQad3NVSdxFMeQuXIIff+6pWflu0WlYXdC
         QSJgNpOHrcy2L8irdpn2EEuVQOOZcA7dXwJzAFkLPCKJaDSdw9yU64m5hu3zqlX79ZDt
         wEJ1B3RaFiU+7nsE57mp1uu/psdWgbR+JAoxPekkl0pishgP5Y2rD7ajxh5VZpC6fc8N
         XI9lzEk+uKqwbSqSUE/aN9LI4a92Vaw51ACQQjTd1r8/Z94PCWvKZXPn95CupEv1GTyL
         LqpE41JbjiwNh+sOCn4MCi4IbTXXv9aXkhuzaqxEmbWytJZNEhJJ8HZQlxdbQBCeBN05
         6cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0i2zZBdrCWRI9lmKA/36c64wVimSwf1CiL2+om4mgI=;
        b=Pny6+JCy8sxrAZ8t8RX7iCqeyC01IsS2OwVTCSMPRV69FwWo985xmWuB5/D9E+zBDE
         NkfGqXnC//6e4uHWPpIFqvZvTIolNbg3ZF0677xUV+T9bncTXiDiWcOQl3dsu2UUSdv7
         OjZc2xB2i1UPA+OgmNXpLnZJ4WbTchFzTLxHMWhdDZUH9UcqCGHFqofk4coI0YvJXiDr
         epWzNdVnil0zXCjdxaZ34x8IWLcjDbX9iZ4/T6hntIhc5cLJDdAilKs+RM880W09KctR
         WXZLtmqHkKIVqDuV3nRrsPseXGShHY6k3PUBGm1NsrAsPq4V4RlPkUyq+I/ucTgSlQxb
         4hZw==
X-Gm-Message-State: AFqh2kqpxSbzY5nX5qHof58HZAXv3FbaDti17LXdvZ8Kpws40VjvYK9U
        xnm9u2IHgNRluse9PqGDFTMUVMlSzJ4N
X-Google-Smtp-Source: AMrXdXuIfeiMj4FfTSA3IXDlo2QLb1EWzOITknF00Kz9b9grv9RndDgACvilj1UWEWIPTzvvj7mN5CvRe4Ft
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fa4e:1fbc:95a:3ea6])
 (user=irogers job=sendgmr) by 2002:a25:dd84:0:b0:756:35b9:e2de with SMTP id
 u126-20020a25dd84000000b0075635b9e2demr9383227ybg.117.1673636269620; Fri, 13
 Jan 2023 10:57:49 -0800 (PST)
Date:   Fri, 13 Jan 2023 10:57:32 -0800
Message-Id: <20230113185732.134861-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH] perf buildid: Avoid copy of uninitialized memory
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

build_id__init only copies the buildid data up to size leaving the
rest of the data array uninitialized. Copying the full array during
synthesis means the written event contains uninitialized memory.  This
was detected by the Clang/LLVM memory sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3ab6a92b1a6d..348d05e4ec03 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2219,7 +2219,7 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
 
 	len = pos->long_name_len + 1;
 	len = PERF_ALIGN(len, NAME_ALIGN);
-	memcpy(&ev.build_id.build_id, pos->bid.data, sizeof(pos->bid.data));
+	memcpy(&ev.build_id.build_id, pos->bid.data, pos->bid.size);
 	ev.build_id.size = pos->bid.size;
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
 	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
-- 
2.39.0.314.g84b9a713c41-goog

