Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FFDC4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Nov 2022 04:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKCEze (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Nov 2022 00:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiKCEzb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Nov 2022 00:55:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E217E20
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 21:55:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3691846091fso8585877b3.9
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Nov 2022 21:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aytaF9VJiZ59kp8/UqWu1XpON56xoCf/kQCMxXol+VU=;
        b=kEyteBHALJtRTPCwr3TZEqux/nFBzmqZ8z83EVjNVsVjV8geGkB546cSN8DcWAK3xx
         /8shHqXyw5Yq7GzzLxX7kaoQiW7lV6WRAAtknxyu4kv6jpU8KPoyUAZSRnCwp6xhn59U
         G/SKDZ32p4ES1uJKV6NbORrmpTcpfRSLhr/9IO3f8sXFgMAreer+RDjj+YoKp+KSh5CK
         YkNEXYD2qTEpKqpH/vhU0mvi7Fwl9qJnICFYdyyM8YslYE/Tag2jAJJVd0wDOocFLGQ9
         xggyXpeHeV6ZBmx1CXgffPDeVODayjtgvfMrzUpT/6E+JoEWw1HtFv83jLOYakqalFif
         oJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aytaF9VJiZ59kp8/UqWu1XpON56xoCf/kQCMxXol+VU=;
        b=pwXp1cowgTD3zYUdDC4f/jNUn4NEYjIFSfRfy0tPZ/H+qziPFmxuqsludL7Gq9jvOl
         74+MpkYT9d30bRu//+IIxF4twalOMThWXZSWDz7x640yVRNSpQxuLhA7vNzarpJWdo2S
         01ABqn9f6U86A2TqcQuBdpOCMg0L7BblANc6a7/RlLlbGT2dBx3z/tRNSKgXLt+GOjEn
         R8hds4w3p4VlTOQ4nnXWmhXMWzdJbzpLuOaZk5VVDI1rCZz5+NPghztufTYfsatJwr63
         K8Qb92uCMpa/M3Nj+n6EqQH4aF92D3uTHGwkLQhC4QC7U5XLWIMNQt7PVuId9NKcgLOn
         XhTA==
X-Gm-Message-State: ACrzQf2s5cTLDj4vnJmsD2D34TBnMmCvnvLln5Oz93OyWNDgkiw3oGAD
        FkIlHVh5Tjxnidq8ioSgFaz/QV4VqVZa
X-Google-Smtp-Source: AMsMyM7AUCs27q2zSxplxe1yi+Xzo6Vjq3rCThtq/3CxXMtYOH8jSxY5fbFRQ+Je3I9c8ngMwAGpB4AQA9oK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8a9d:7f38:6465:2d7b])
 (user=irogers job=sendgmr) by 2002:a0d:ddd2:0:b0:367:27b6:db71 with SMTP id
 g201-20020a0dddd2000000b0036727b6db71mr185334ywe.432.1667451327234; Wed, 02
 Nov 2022 21:55:27 -0700 (PDT)
Date:   Wed,  2 Nov 2022 21:54:35 -0700
In-Reply-To: <20221103045437.163510-1-irogers@google.com>
Message-Id: <20221103045437.163510-6-irogers@google.com>
Mime-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Subject: [PATCH v1 5/7] perf trace: empty fix libbpf 1.0+ compatibility
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

Avoid use of tools/perf/include/bpf/bpf.h and use the more regular BPF
headers.  Add raw_syscalls:sys_enter to avoid the evlist being empty.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/examples/bpf/empty.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/examples/bpf/empty.c b/tools/perf/examples/bpf/empty.c
index 7d7fb0c9fe76..3e296c0c53d7 100644
--- a/tools/perf/examples/bpf/empty.c
+++ b/tools/perf/examples/bpf/empty.c
@@ -1,3 +1,12 @@
-#include <bpf/bpf.h>
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
 
-license(GPL);
+struct syscall_enter_args;
+
+SEC("raw_syscalls:sys_enter")
+int sys_enter(struct syscall_enter_args *args)
+{
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
-- 
2.38.1.273.g43a17bfeac-goog

