Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9B0C38159
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 18:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjATS6m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 13:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjATS6l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 13:58:41 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC518743B7
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 10:58:39 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5028c723d28so9695507b3.15
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 10:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=68orcaC6zz4yh42URgC/a9ocEH5eMY9g7tAnmpuRu0U=;
        b=WNTK3yTY8uIAwslAVYOxaLgjPBSTBNADsLlJcs4wVM2i+mwdBi98fG+N9/9iPIS0yc
         LJKYipiY96DE871/jJLOP3SwwmvmFPqp84J33MN2EAZ2qeN5YfjPCXEi0gULzYbSNTY6
         /4ORT31UDpsWZRnmMmw7Wfzmv2BH/cokhri/PMFTqukUo5fIH14Kof+5ijzON08bA9b6
         fA6z2ycBL+DUd8C+Ik8O5Pk2AOda7/XOQOSs4XUn4LISrg8FbEm3KIU+wyHPvgr69tE2
         cz1zFUYSB8UJkHgr4t78a9r/DSw3tqQvC5q0My+SN8T+3IfpHpcJ7qiXgIpzlURBul2p
         p1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68orcaC6zz4yh42URgC/a9ocEH5eMY9g7tAnmpuRu0U=;
        b=k1XhGjv2wSi8s7pzy69fPKQ+GZX3/FazBKwmqv9dOTBPkoMRjNmPmr6wz02/BjuC8n
         +yRaDPmc6sqe94HsXEwDOF1qIQevE5zOQzX047nXYy3S3qEzRf0SgKJ31fiAX2xtwNa2
         FXrZZQ4slbQpBW/CgDYniO0YXfBS4JHiKKNm/NT4Ub8cnwcTLcFvaLDn+20sjbUb0ZYs
         33wbk8+khCa5CDtORHLH1j9sceIg5y0MxOxgSGM8OQICGgkPFEjSA2+OMtXA+m5VGAYq
         M76utwHpjW/x/X8DlSdeLnqjQE9hp0145AIBAwWuHO7zhG62rDTdWl26vz/M6E5S8XKr
         2Ujg==
X-Gm-Message-State: AFqh2koY2tHdiV2bc3OFeMBRnWTNe8mQGVP4wYKU2Sk2t0F5TtZ8vIHU
        p1JvG1ETv6p2ngiiAZmV0HyszRNINpWl
X-Google-Smtp-Source: AMrXdXuR0UGEvg0tmZsuCJFjqwMeNjP70VdhJX4rPI/yED1obovEegVXuTIVRHcRLI9m8lPABvuYksRokxPA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a736:5d8d:4ad8:4e50])
 (user=irogers job=sendgmr) by 2002:a05:690c:887:b0:500:ac2c:80fb with SMTP id
 cd7-20020a05690c088700b00500ac2c80fbmr278306ywb.90.1674241119207; Fri, 20 Jan
 2023 10:58:39 -0800 (PST)
Date:   Fri, 20 Jan 2023 10:58:28 -0800
Message-Id: <20230120185828.43231-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v2] perf buildid: Avoid copy of uninitialized memory
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
Cc:     Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

build_id__init only copies the buildid data up to size leaving the
rest of the data array uninitialized. Copying the full array during
synthesis means the written event contains uninitialized
memory. Ensure the size is less that the buffer size and only copy the
bytes that were initialized. This was detected by the Clang/LLVM
memory sanitizer.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>

v2. Avoids the potential for copying too much as suggested by Arnaldo.
---
 tools/perf/util/synthetic-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3ab6a92b1a6d..9ab9308ee80c 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2219,8 +2219,8 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
 
 	len = pos->long_name_len + 1;
 	len = PERF_ALIGN(len, NAME_ALIGN);
-	memcpy(&ev.build_id.build_id, pos->bid.data, sizeof(pos->bid.data));
-	ev.build_id.size = pos->bid.size;
+	ev.build_id.size = min(pos->bid.size, sizeof(pos->bid.data));
+	memcpy(&ev.build_id.build_id, pos->bid.data, ev.build_id.size);
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
 	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
 	ev.build_id.pid = machine->pid;
-- 
2.39.0.246.g2a6d74b583-goog

