Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4E6C678D5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 00:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCHAa3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Mar 2023 19:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCHAa1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Mar 2023 19:30:27 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA05DA42C7
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Mar 2023 16:30:26 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id t12-20020aa7938c000000b005ac41980708so7946527pfe.7
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Mar 2023 16:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678235426;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SWmklWyVCwxXFF6wO6v9mDT+U/6Przz0XnTBbNzMl+M=;
        b=nEPr6VECvGe6NhTwzmP8wSYxHm/jEvwAdt6Nf1V10+vi5IktT6GFHvL8rBdGLMnVtH
         9lA2h/IYUoP3jBX6WWElTHI28Ll7lRZpsuo/iN+946s3pGgW8IH5X0WzAmyLsaeYeFjD
         JCMpdubtNGDzR7yfOd+tLfjak8QNM3m1nluDeA/Brik+UdUV9BeeuGYos6isWHWX8I87
         GpRsHlkDi92tuWY/LiBIZpdf4kHZqGw34elLw5/0XQ0iLfRINdoTLZ8HM/gsQsvh0mYA
         eNiKnTlXCP+v2Vt5cYtPZgdfKABpjBrhH0f8n/Spi/spBYNhIGzyFRwfDz2CMqEC9vh6
         4wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235426;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWmklWyVCwxXFF6wO6v9mDT+U/6Przz0XnTBbNzMl+M=;
        b=uJwEuVpHaCn7OahCmnTCU015JXDsOSL7j5fDR300ZXobtvlbtlwdEgq1zPguhU8vP0
         cBNBnk9jZ+GqO1XAVxbZCg4AoyJ4ME6kADYo3DOGY5qENbOGPbr7wSkZSmK6jvxRlCUl
         PozXMOVHn7rsWZCkSa7N60CjTNTOl+yZuwK8hQqU3hiGHnj1H9Ok5SckjTvajvQABneb
         SqdZ/v83xba1309ggN8xxTKwYHHsBmWYilkULQOYJ7vdocqI8wwSLNBI17FGcDnSv7om
         ZRlsxfohHf91+nyH1wqgb+MYQ3CD/GPe09R1YN+Uxw61u0jEtrM6vriEp0Y+IkGWliXq
         aByQ==
X-Gm-Message-State: AO0yUKVaR7R4BGhs0TzgDGL5V11at4rDR9CWKsYhljOq+yBwawjn/ytp
        wuP5a+EikYfN+X36omGqa385QmC0tXUc
X-Google-Smtp-Source: AK7set/1oCu95AivzYKa9M4rxRkuUVpCxglBFgFEVUNGKBoNg8a61V4ubQnwxHaL2KN3ig51ffUXkYCuLGTn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a17:90b:3594:b0:234:bcb5:2a5f with SMTP id
 mm20-20020a17090b359400b00234bcb52a5fmr6097010pjb.5.1678235426354; Tue, 07
 Mar 2023 16:30:26 -0800 (PST)
Date:   Tue,  7 Mar 2023 16:30:20 -0800
Message-Id: <20230308003020.3653271-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2] perf lock contention: Fix builtin detection
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

__has_builtin was passed the macro rather than the actual builtin
feature. The builtin test isn't sufficient and a clang version test
also needs to be performed.

Fixes: 1bece1351c65 ("perf lock contention: Support old rw_semaphore type")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index e6007eaeda1a..141b36d13b19 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -182,7 +182,13 @@ static inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
 		struct mutex *mutex = (void *)lock;
 		owner = BPF_CORE_READ(mutex, owner.counter);
 	} else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
-#if __has_builtin(bpf_core_type_matches)
+	/*
+	 * Support for the BPF_TYPE_MATCHES argument to the
+	 * __builtin_preserve_type_info builtin was added at some point during
+	 * development of clang 15 and it's what is needed for
+	 * bpf_core_type_matches.
+	 */
+#if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
 		if (bpf_core_type_matches(struct rw_semaphore___old)) {
 			struct rw_semaphore___old *rwsem = (void *)lock;
 			owner = (unsigned long)BPF_CORE_READ(rwsem, owner);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

