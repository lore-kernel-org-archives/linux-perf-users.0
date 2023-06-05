Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A73DC77B73
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jun 2023 20:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjFEU2a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jun 2023 16:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjFEU2Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jun 2023 16:28:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA810C
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jun 2023 13:28:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a33c35f6so65134627b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jun 2023 13:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685996900; x=1688588900;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UB6gpBiBcnU1jnjPiiDD9uKRun1xokaVYhpMqOiKGIk=;
        b=YUoH34gluOcnMLglRERlvpfebD23yZUoPErPS/I1cj+IF71agxYfnW69JOXkdO3EsV
         o/pfQ8mxsGVjwmVDoU2v8PV3XSPhfWAAdeMI6H7xLKhZgRwz1yjYGmPt4NPn1VlUbP3K
         pFQsJsvCGnU1imCD1kANm012jDtFB81Q1sgGDlCggxYu0NrlLb/P6tquBY1BearYf/Lm
         eqHDSdTLYLZzBnQALPShfMgjweFGm2D7SpazBT/hIG98+9Lp6VSbv4i3577Ku+whecrm
         AzsgWRq44ntdwAHpIisf049UP73S8UyElEQ2DiCcoCqseACVXTcxxlxgpRxfwpziyPlL
         Gr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996900; x=1688588900;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UB6gpBiBcnU1jnjPiiDD9uKRun1xokaVYhpMqOiKGIk=;
        b=atuJZ0CeelTSd5X5GVMxnb/uyv5OaI8LtzGVRtLb7I4VC8au1rEcxjkwZV39Cp3LK6
         2NCSFf0/fI9PFG+tN6zTjlZMB74TrGnKhWYW/DikkrFM9k83woL1j03px/pYj05gbyn3
         bL9rT12R32BYbn1WehMwRlFOi8gclSPRappvaqzc/S6B7YxFdQCeKDJVYmKwWDwG2woM
         OEiqhC2y1jkt5AxRmReBImlSOgYKDC9U/NtMRB0tMV0on0mnUsknQIILaX5Fxj/WKUQ6
         Uyty5xRhIxGHacKYsXsYEsOzCbyIGU+vT94om+I2gnHBjZL1OwpK+wGqDGflOc8Uaufc
         zGlg==
X-Gm-Message-State: AC+VfDy8F7ExZVjDjRcWTAWgEt6krnvKiQTz80TkO6xnIBLIhOpheQD/
        /TEO7NgghF0UXKqmNLECjN2BeO6VpMv1
X-Google-Smtp-Source: ACHHUZ4Z96ssNiqfTAzkaosiR+Pm5gOogVdYbFM7wBcCqqZ5osHLe80aD+5fi03vIM1WvuTtzxh+zYefiZeu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bed9:39b9:3df1:2828])
 (user=irogers job=sendgmr) by 2002:a81:4043:0:b0:568:c4ea:ce66 with SMTP id
 m3-20020a814043000000b00568c4eace66mr4723849ywn.5.1685996900158; Mon, 05 Jun
 2023 13:28:20 -0700 (PDT)
Date:   Mon,  5 Jun 2023 13:27:11 -0700
In-Reply-To: <20230605202712.1690876-1-irogers@google.com>
Message-Id: <20230605202712.1690876-4-irogers@google.com>
Mime-Version: 1.0
References: <20230605202712.1690876-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 3/4] perf test: Add build tests for BUILD_BPF_SKEL
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
Cc:     Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add tests with and without generating vmlinux.h.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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
2.41.0.rc0.172.g3f132b7071-goog

