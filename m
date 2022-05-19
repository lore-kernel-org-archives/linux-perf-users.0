Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DEFC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 03:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiESDUf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 23:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiESDU1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 23:20:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237EC56775
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 20:20:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so3291604ybp.19
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 20:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Vw3KOirpyKTYToukj5eB9PrIoaDLrka25Tzs+xxN/h8=;
        b=Z2zErAYQFBvOZsDLGgCVtdKnayqjrK54AFt8EP2E2Oh158l/ncAdDQG5+nkAH0QlIV
         w7DnPDdy3FXOINVtVZBSOzvkUEgdfz4/+VoRyMyoOLgsr994CrD1CRg/RdsxA/GvT/Hz
         bm+Zf9z8iRcc0HpGKykfpNTndP5y04D6WwiZYddS+fKufM6Lx5V09WN5tsvU1ge+HQzY
         /qhqa3u9ZpQtKhRgjOGtsCLskUfiTO7Em0DfZMhyWFHgyQZhLF2WpF9G8TQvNeRMQtSK
         +CiaQJsSHY3iz9Kx8ES9aAG0WeS3ryGXwQ4Mkd0cqEVT1HYxMXCyp8t5FehS8WYhnB68
         Q8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vw3KOirpyKTYToukj5eB9PrIoaDLrka25Tzs+xxN/h8=;
        b=pjFrBTotiow0F9UKVuQ7FHuP+QP4dyFeEJMznuU6v1kwRMfAt9U+w7H559QXBh1hyi
         acf7zCUFJHcfpHVVp9MOmEOC/izAvYZj6tYEoFniczrESt162KRKpgvvTZSRuojJ59Ob
         yZzjt0iOpLkshglPdYPIHjLBatCZYCpBC88lSSAwuskcESKUdlvnxVyhNx1H24hCIl9C
         5r7pUz2NU9xqyqNv8CiGXVknDPFu4sDF1p8F2USyrkBufdJcPE8UUXZ94ANwYW4BOCr0
         N8nkDxhejdIdcY+IQViRrYjdEGN1PUXEGhiLSvwNYsGX607AJOFjCLNHFBaaWo11CUuG
         IMng==
X-Gm-Message-State: AOAM533/nSWGPAW+m6rT6jdW2EEUBWVHjNZkJaPQlmVP/88155JAXQtw
        KgLKxG01vMJv5lH0t6Rx/bjNSuWp9Jyw
X-Google-Smtp-Source: ABdhPJyaaIVriNuy73np/4IMrVPFn3NEblefL3EEPUZ7Ayeru4qkvqLGkIUzJ87NJEh8n9bjaM+xtdCjwHRq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a233:bf3c:6ac:2a98])
 (user=irogers job=sendgmr) by 2002:a25:2d67:0:b0:64d:a9b9:4954 with SMTP id
 s39-20020a252d67000000b0064da9b94954mr2547523ybe.5.1652930418306; Wed, 18 May
 2022 20:20:18 -0700 (PDT)
Date:   Wed, 18 May 2022 20:20:03 -0700
In-Reply-To: <20220519032005.1273691-1-irogers@google.com>
Message-Id: <20220519032005.1273691-4-irogers@google.com>
Mime-Version: 1.0
References: <20220519032005.1273691-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 3/5] perf cpumap: Add perf_cpu_map__for_each_idx
From:   Ian Rogers <irogers@google.com>
To:     Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Lv Ruyi <lv.ruyi@zte.com.cn>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A variant of perf_cpu_map__for_each_cpu that just iterates index values
without the corresponding load of the CPU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/perf/cpumap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 4a2edbdb5e2b..24de795b09bb 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -31,4 +31,7 @@ LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_c
 	     (idx) < perf_cpu_map__nr(cpus);			\
 	     (idx)++, (cpu) = perf_cpu_map__cpu(cpus, idx))
 
+#define perf_cpu_map__for_each_idx(idx, cpus)				\
+	for ((idx) = 0; (idx) < perf_cpu_map__nr(cpus); (idx)++)
+
 #endif /* __LIBPERF_CPUMAP_H */
-- 
2.36.1.124.g0e6072fb45-goog

