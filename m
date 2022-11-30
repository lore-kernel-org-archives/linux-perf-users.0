Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE35C4321E
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Nov 2022 06:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiK3GaA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Nov 2022 01:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiK3G3z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Nov 2022 01:29:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9980D2AE29
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Nov 2022 22:29:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e11-20020a25e70b000000b006f9ae0996f2so2732013ybh.23
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Nov 2022 22:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZL18oOsNtp1Oe4BxfidvSOrYVVlN8hR4hEUrcdG9nU=;
        b=FMNA5Chj3DF5Qdu3T6hVsMlCz/3WveDed7pxt8kIBvy248lpr+zle/NeOz8oXOfs7G
         QzFUKWde6+oAcJNib3oRIUdSTXRUj1MtKsp766xkur5Dq9aq7J7VqE37bfUze29Rmhls
         mPSd4gW6vBhRteSIBUiSBF2Y3q3MeXJeK3gQ68ttOZ91G4VZfEKKVpZ+AYLZumpOqG8x
         NCMZUzM+N7HRDbW3aRPqDWpqOKispvPQVcsgHnUews4wSteZ2r3u30byQ1bLSdxfdKti
         D0Nz/YFcX8OD89x+W8paiyLLRzYaOYiAmSRhCXU1GPKhgPURjhVOcTfeXlMZc/jv7zaT
         iZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZL18oOsNtp1Oe4BxfidvSOrYVVlN8hR4hEUrcdG9nU=;
        b=g3MZrXUeqz+eI0CQGovd73r5BxWul+mx5oRrCOoDzlOeyKbrR9Q0Putt5U6Y6NGAAU
         jdvDtObnruWEsVy4ISzQDQMuCZls5ZYNmhtkmrrM+fnLi4apQS1FW3qookMAlhgzAjzc
         dETcg7NPZCKg3wysAWr8V4AYjnbA3kAB0Jlvg+HX4cL/Ae6CXU/ImwfGRS1wbORilYvj
         9fIOEO0zA5mk3JU8dhOi02xdFnAK21CBXTBt2COIa7+ix+Qo0cY3ht0aAoI5e5UYa/xJ
         fR9u/Hkq7HCvDP38yqbeHX0SYLFYtpJ4SQL2GpYhWr8eQE1iTlHpy697PwUPZl9byPeI
         nTWA==
X-Gm-Message-State: ANoB5plYrtcg9LM7LPXYRB0EQIjSa8VZ3KTGpeUlVd9gEzxhZRZ8xSe5
        dfN3Ve9p+wZ9eGnEP3Ykc0yA57Ou8cjU
X-Google-Smtp-Source: AA0mqf7GPpvxyQJHXBNtjO3h5bKWOEMpMgrvNsR3Fbh9z2AshF3dX8pyxaW9njJ/GiASZaOR5nuno1ZNdkRT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:788c:ccf4:3670:3362])
 (user=irogers job=sendgmr) by 2002:a81:38d5:0:b0:3d2:8530:f69a with SMTP id
 f204-20020a8138d5000000b003d28530f69amr3905457ywa.357.1669789793849; Tue, 29
 Nov 2022 22:29:53 -0800 (PST)
Date:   Tue, 29 Nov 2022 22:29:32 -0800
In-Reply-To: <20221130062935.2219247-1-irogers@google.com>
Message-Id: <20221130062935.2219247-2-irogers@google.com>
Mime-Version: 1.0
References: <20221130062935.2219247-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 1/4] perf util: Make header guard consistent with tool
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Remove git reference by changing GIT_COMPAT_UTIL_H to __PERF_UTIL_H.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/util.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index c1f2d423a9ec..63cdab0e5314 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef GIT_COMPAT_UTIL_H
-#define GIT_COMPAT_UTIL_H
+#ifndef __PERF_UTIL_H
+#define __PERF_UTIL_H
 
 #define _BSD_SOURCE 1
 /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
@@ -94,4 +94,4 @@ int do_realloc_array_as_needed(void **arr, size_t *arr_sz, size_t x,
 		0;						\
 	})
 
-#endif /* GIT_COMPAT_UTIL_H */
+#endif /* __PERF_UTIL_H */
-- 
2.38.1.584.g0f3c55d4c2-goog

