Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCBFC77B73
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 20:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjEVUlg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 16:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjEVUlf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 16:41:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6830B7
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 13:41:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56536e25aafso4260027b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 13:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684788092; x=1687380092;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDof+QoJIpcW+bcC8mIq1dIhSy6Tx4m7myi7gPf3qCM=;
        b=hL4XZqmAmsZBqISb5cs2SY76dW2m/n3/dRqTTMYPVdlAsjXvYxhCKl/wYIuYN5dH1y
         M/Zgkcj29Ps7yZkdxvqlqLB071q0vvvwDPGSr8posF4+n+m/gUhclexIkD3Olk2KeqQV
         pTVYcM1HHnrL4uS435VahAb4o4/PTyTyKImzzctxQZvjJGnw4XTMrdTRjjKdnyjt0ZLi
         TIAogLgYmgvk031sY5cMg+7HCGNuWb8K3lzAN+pNqd33I//tCNpkQTjvyPsw67LorTaF
         hdFLUxCf9oAxG+uLPCDIzzVkbJwxtYLshP/HM2YZJzL+KgSUM1yh/o0jmt3XpS5ll4w6
         ztZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788092; x=1687380092;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDof+QoJIpcW+bcC8mIq1dIhSy6Tx4m7myi7gPf3qCM=;
        b=Pb8/0RtkOncN2wHiZBFGsk7d8umDwh8z5f03C9FVbQV7BM+RDaigY/LNjJsaHjlPqM
         2APw3fM7sjT9pXJNCA29gBtc+3ldEcZGaDVUsRRYdbRW7z6WVkPAmnJdhBI7nFx9dJgp
         QFggBzsiOFHqKWIWklMdRTTcMjWtYhOC1pe4BZ5h3na4Dy4u1Q8n+EWOD1krCig4fPmY
         nTsPKFhibXpDIpaCf9MjFzYaT1Xh15rPmnVascWj9ebrdypVaPM7g2Bf/ihP0StlTaNY
         tpn1PBb1yw50ElNahfXIGwGdZbu2q4B28eVzdVyXOiHWnY9bpEtKHfbSzIwQEM6qXWgV
         poSg==
X-Gm-Message-State: AC+VfDy0Vh7VCHm6JqvzVyOHH+NTuGkIBvhIR7N1MKe1/+tPxbsNZ5UV
        d6ENVNSd2QGscUSdVn0u0cOwQRUzsjg6
X-Google-Smtp-Source: ACHHUZ6Ij6MmJUxaDx9xqk58WsfpUW60Sf6BCP5q+Vjx4RkK5eARDpLpq/+ExNmPLc2gquPDbKFREdVnHLrA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:33a6:6e42:aa97:9ab4])
 (user=irogers job=sendgmr) by 2002:a81:ad09:0:b0:559:e97a:cb21 with SMTP id
 l9-20020a81ad09000000b00559e97acb21mr7115495ywh.9.1684788092608; Mon, 22 May
 2023 13:41:32 -0700 (PDT)
Date:   Mon, 22 May 2023 13:40:47 -0700
In-Reply-To: <20230522204047.800543-1-irogers@google.com>
Message-Id: <20230522204047.800543-4-irogers@google.com>
Mime-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 3/3] perf test: Add build tests for BUILD_BPF_SKEL
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
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add tests with and without generating vmlinux.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 8dd3f8090352..775f374d9345 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -69,6 +69,8 @@ make_clean_all      := clean all
 make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_nondistro      := BUILD_NONDISTRO=1
+make_bpf_skel       := BUILD_BPF_SKEL=1
+make_gen_vmlinux_h  := BUILD_BPF_SKEL=1 GEN_VMLINUX_H=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
 make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
@@ -136,6 +138,8 @@ endif
 run += make_python_perf_so
 run += make_debug
 run += make_nondistro
+run += make_build_bpf_skel
+run += make_gen_vmlinux_h
 run += make_no_libperl
 run += make_no_libpython
 run += make_no_scripts
-- 
2.40.1.698.g37aff9b760-goog

