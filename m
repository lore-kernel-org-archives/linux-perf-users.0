Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47C9C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Nov 2022 04:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKCEz2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Nov 2022 00:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiKCEzX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Nov 2022 00:55:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBA183B2
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 21:55:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so1189094ybr.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Nov 2022 21:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRVFGWePvwNmlXm2BOJFvtaMGSMXy8LREl0rrvfBjVA=;
        b=esd73Ew1HyHI7NYFtpnPAP9jY/cbc550EHnRTY8Ws6yN4OalaXE9EODfDf/NdUi/lS
         MY37wQkTs7e5rqXiIPuDVqbRrm84uW8eutX7Gp+H/Ao5NSNjHdhovqInJBCiGgQTFfNt
         rw0bb/XU1WYVN/2ilg5cPKz62ThFN1HUPfv4dwg8iRygeLv7OqzfNApFDDj/v/iQA6eQ
         uEn4TQfVYd8H/IzkWqefkA00nNq49wdvmVfBzHp5N76GmXQ9H2l9XCofEXtrCqH+hqgg
         dFgYuqIHPz8aF++8Vg1hlMtPrVxuYfhNxLhgFeu2ECVu/rJzGmm8pDYYFgHrLSDgWEMm
         RpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRVFGWePvwNmlXm2BOJFvtaMGSMXy8LREl0rrvfBjVA=;
        b=pjRSuExXb6TomUPpGxMUIG3RcQCwhs30PaVHxJRcw0s2fOrqCyBhZerqtL1lbHP8Zj
         pSsPa2lVj7rifTR6afRBP3Clot8mBI7l9/4qp7z5FY1swCSEcvhzrPG6WvyH3ZJd0X9+
         lo8QTiXH3CH8I9EOeC32e4JjW/FygxvNZqCuSkSsXxjKdCTS5bRBYNMV+UxBQUyv0C+5
         H9tIutXAj6IlmxGyGgsJV6SiB258/719tY0UvLU1EzXTbDBbNkrVtE4oZSOEWQRTwXA9
         P8h/E/ym3gjU9lG0hBNhJbDk4vzTlKRsQnU/NQnVsdoUj77DwIaSujSKiCvCgKOc8Bzt
         GkAA==
X-Gm-Message-State: ACrzQf1RpmHv3lUqL/gO/TR8ZcSFw8oy5fpLZ93pruDE0fTYk7qPNrGG
        VGOt1RKvSI7Q6AObblEk3ugkB3/y2uyp
X-Google-Smtp-Source: AMsMyM4xeZfFWcIYHW7+VZ8bY5fEr0eMPQ3tVpLlB+nDmZ1z/3e6KwT36FpXWpzSq473i2iaq3+ly/BFyBcw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8a9d:7f38:6465:2d7b])
 (user=irogers job=sendgmr) by 2002:a05:6902:4d:b0:6cb:9135:29d7 with SMTP id
 m13-20020a056902004d00b006cb913529d7mr23783827ybh.208.1667451318415; Wed, 02
 Nov 2022 21:55:18 -0700 (PDT)
Date:   Wed,  2 Nov 2022 21:54:34 -0700
In-Reply-To: <20221103045437.163510-1-irogers@google.com>
Message-Id: <20221103045437.163510-5-irogers@google.com>
Mime-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Subject: [PATCH v1 4/7] perf trace: hello fix libbpf 1.0+ compatibility
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Don't use deprecated and now broken map style. Avoid use of
tools/perf/include/bpf/bpf.h and use the more regular BPF headers.
Switch to raw_syscalls:sys_enter to avoid the evlist being
empty and fixing generating output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/examples/bpf/hello.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/perf/examples/bpf/hello.c b/tools/perf/examples/bpf/hello.c
index cf3c2fdc7f79..e9080b0df158 100644
--- a/tools/perf/examples/bpf/hello.c
+++ b/tools/perf/examples/bpf/hello.c
@@ -1,9 +1,27 @@
-#include <stdio.h>
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
 
-int syscall_enter(openat)(void *args)
+struct __bpf_stdout__ {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, int);
+	__type(value, __u32);
+	__uint(max_entries, __NR_CPUS__);
+} __bpf_stdout__ SEC(".maps");
+
+#define puts(from) \
+	({ const int __len = sizeof(from); \
+	   char __from[sizeof(from)] = from;			\
+	   bpf_perf_event_output(args, &__bpf_stdout__, BPF_F_CURRENT_CPU, \
+			  &__from, __len & (sizeof(from) - 1)); })
+
+struct syscall_enter_args;
+
+SEC("raw_syscalls:sys_enter")
+int sys_enter(struct syscall_enter_args *args)
 {
 	puts("Hello, world\n");
 	return 0;
 }
 
-license(GPL);
+char _license[] SEC("license") = "GPL";
-- 
2.38.1.273.g43a17bfeac-goog

