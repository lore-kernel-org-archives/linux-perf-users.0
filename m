Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD27EE0200
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Sep 2023 18:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjIMSuH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Sep 2023 14:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjIMSuF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2023 14:50:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1001B8
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 11:50:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58cb845f2f2so1648677b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694631000; x=1695235800; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qPAgyrXwVifCgs8YcSIJJHY71Xaauw3uUQtmqIC6VZw=;
        b=VC/aUfJSLUD322l8VLNpCyQBoOLkyS/EaUegtC7OA5mGf6zxDGSl/T+jsdBFcXH5UP
         8MueJJnfn/JizBtldwcYxCKzV2JGRQ3vR4q3cUP7TYTQ2YB9DTxLOEX29i8iwOdFc8Gt
         Z57uzqrcRP+Qey81gBp33dFPP2+N0xBZXL1Xe/SpsZp4mOxTEBuBT1OjCQ/26CWnZqp+
         CYg/wGPkzRobbYm9q8ayw6vEG+fA+lcn2T99xuOk08YP8YQBMcSYZfuV1vd9SKMgG1EX
         Ro9YEA+ym66bCKTL4eu80Jvro0rzpbCZByWqWYdyvcVKfrbr57DPCtQyU/ZQn2qebi2J
         RJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631000; x=1695235800;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPAgyrXwVifCgs8YcSIJJHY71Xaauw3uUQtmqIC6VZw=;
        b=olO7KpqPGXwUroLWY/fmH5QT47/6fP5YkfAa8pSUSwDLVUS1tJ2X+Ov+P8JmRdCvBv
         9RLL+61MP6cZY1g0022AeH0wPj/T1ucbYitiQVSQVzGDk5wxpLnFy+pQRPcjHgpOqwye
         TPMDzMJ68c0g/EY8cxU7wpIoWjdm7RGLIqKPQJgLrqrdC8Fk0+ixZIOdzUoCbmkl9ZtL
         6aDiBxHnf9VN/K0ZKnCC62vb8D1nhY4tAvy+7EGYlYB7qeWY0gWDCLd5MtzhGVj0I2VY
         ZNQ0sC5F4QSWrgmHnAfeKrLnXL/H1W1cHEmPZV1yTpyhJ0NyzvOnOGAc/ZhHAdZ+0LcY
         tH4g==
X-Gm-Message-State: AOJu0YzjE/I5Au4u/3NCO47qgs9pvM3RcifdKmTtAKc9BCDZIPng61fr
        wdlHnOHJiiI24pfnexlXvYiP0/IJG7bl
X-Google-Smtp-Source: AGHT+IGsHx+kaHfl63g3U+7aSP4ap1F2ajOv98JBdUwuZaW3YgiloBSxM9+4YpOZlykSC2AeodbWFKOxMdI7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f3b:42d0:4853:6022])
 (user=irogers job=sendgmr) by 2002:a25:6c03:0:b0:d80:2916:c3eb with SMTP id
 h3-20020a256c03000000b00d802916c3ebmr72569ybc.12.1694631000618; Wed, 13 Sep
 2023 11:50:00 -0700 (PDT)
Date:   Wed, 13 Sep 2023 11:49:57 -0700
Message-Id: <20230913184957.230076-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1] perf trace: Avoid compile error wrt redefining bool
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
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Make part of an existing TODO conditional to avoid the following build
error:
```
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:26:14: error: cannot combine with previous 'char' declaration specifier
   26 | typedef char bool;
      |              ^
include/stdbool.h:20:14: note: expanded from macro 'bool'
   20 | #define bool _Bool
      |              ^
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:26:1: error: typedef requires a name [-Werror,-Wmissing-declarations]
   26 | typedef char bool;
      | ^~~~~~~~~~~~~~~~~
2 errors generated.
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 90ce22f9c1a9..939ec769bf4a 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -23,7 +23,9 @@
 #define MAX_CPUS  4096
 
 // FIXME: These should come from system headers
+#ifndef bool
 typedef char bool;
+#endif
 typedef int pid_t;
 typedef long long int __s64;
 typedef __s64 time64_t;
-- 
2.42.0.283.g2d96d420d3-goog

