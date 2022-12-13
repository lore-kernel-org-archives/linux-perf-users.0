Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F900C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Dec 2022 23:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiLMX1d (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Dec 2022 18:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiLMX1Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Dec 2022 18:27:25 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDBC193E7
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Dec 2022 15:27:24 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-352e29ff8c2so189601587b3.21
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Dec 2022 15:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nto1ePcvoNdo0gJd4FRIsAa3aTl5xw4C0we0lXrYi4o=;
        b=oaxFlW2ge9haPbT6hCAVVmPuTox9DW+MdJNbZ0iwTokh/4XBkQYtfdusDGVsroQCBm
         9cjRzTm2cTtoTugbzyCsz2kAHTjET5PTm0Qk0Vytd93WKj/92dwBthyYMEWpJ4MTqXXZ
         Kgspw5ZoKtAmQTgags/2mTbzHSF1im/xe5z7xwqmMxY+MpgtR2QCiepGpC+pSAjeR62r
         af+wkR/DSxLYLJ6v8UzQYo8yEedKseMcvnt7JbQHB+veoq0VjssEp6Vl9Tr9PuxO2F17
         A3OnHm0NqQzzvD7NNSu2YgWdnWtZRBASIIw6rkBU4yPgO0G6Iw9CrmSsI4xx9udJ5Lje
         3Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nto1ePcvoNdo0gJd4FRIsAa3aTl5xw4C0we0lXrYi4o=;
        b=uWPYiLfEl/5AaO35M3fQ+Hm6A7fMBIPo4qenm5XKBcSx/5zOUPoAD/0Yr8pD8+1qBf
         Pt09LdDqVIj61zbjLQte7jhJ6AgUQ08XDf/cZrBCCJkO4OlzqBvY+Fc+8vq+HecKNGQH
         lPtbsetimBaYmz0oi3mJAUG/UuT7AY77T0btxmvvap2xpRmHbxPb947ITZ9vIycspw/A
         wYfuNeqmr+mwbL6B7lDsXzRvxP+0U9BdnN82wyvMti2SO0+YlGKt9XFGOS+RqPuR57l7
         AoasYNDfJXHgtJw2ICXjwhCPwge/otIB1oLcx/pUBuFS+vvZ4URsVlVPw7jWKpSdmuWr
         echg==
X-Gm-Message-State: ANoB5pnqLqYy3ayGte8u8hyQQbOYpJIhHkCVJPoraRp+T7QoSWc7EuGs
        xYFxNfcdqMSA8AVxN7+idGWmDGYADrkq
X-Google-Smtp-Source: AA0mqf7zKBCVtwi4aB0KEabefvL0KR/RBin8ahJp49ddNoCoU3ThDFo9mNYaPbpMu1R7lGgciCKfGEWA/gYy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6268:b448:f7f4:4c2])
 (user=irogers job=sendgmr) by 2002:a5b:f42:0:b0:6fd:e4ef:5b1d with SMTP id
 y2-20020a5b0f42000000b006fde4ef5b1dmr25692919ybr.99.1670974043252; Tue, 13
 Dec 2022 15:27:23 -0800 (PST)
Date:   Tue, 13 Dec 2022 15:26:48 -0800
In-Reply-To: <20221213232651.1269909-1-irogers@google.com>
Message-Id: <20221213232651.1269909-3-irogers@google.com>
Mime-Version: 1.0
References: <20221213232651.1269909-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 2/5] perf trace-event: Add libtraceevent version tools to header
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Timothy Hayes <timothy.hayes@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Allow comparisons like:
\#if MAKE_LIBTRACEEVENT_VERSION(1, 3, 0) <= LIBTRACEEVENT_VERSION

Based on previously reverted:
https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index add6c5d9531c..1fbf4c3f8809 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -6,6 +6,19 @@
 #include <stdio.h>
 #include <linux/types.h>
 
+#ifdef HAVE_LIBTRACEEVENT
+#include <traceevent/event-parse.h>
+#endif
+
+#define MAKE_LIBTRACEEVENT_VERSION(a, b, c) ((a)*255*255+(b)*255+(c))
+#ifndef LIBTRACEEVENT_VERSION
+/*
+ * If LIBTRACEEVENT_VERSION wasn't computed then set to version 1.1.0 that
+ * previously shipped with the Linux kernel tools.
+ */
+#define LIBTRACEEVENT_VERSION MAKE_LIBTRACEEVENT_VERSION(1, 1, 0)
+#endif
+
 struct evlist;
 struct machine;
 struct perf_sample;
-- 
2.39.0.314.g84b9a713c41-goog

