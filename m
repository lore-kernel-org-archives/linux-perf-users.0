Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE6DC43334
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 11:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243818AbiFILbO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243826AbiFILbM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 07:31:12 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1923A3B85
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 04:31:10 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id o17-20020a50fd91000000b0042dbded81deso16843649edt.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 04:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=95dYiJC9IDZol3AtuiRZW/23v+t4OmpxxOGgsAq7Fsc=;
        b=bk/INExYMBUiLgU9B9FG9Wxis71pb98dHe4VkAA3lfm2iODhPZt7k+FVxcXk/IlJQ5
         RpFX2tLyK5ayKvJnfKSmbovwQdAQ9qChX7IVHYGLvsWE83meaJOU58o4XvSilpxs1auS
         1rHmsuprC9Lwk94yHLzDR08aqrODjpQg8nX/chmzEEDz9yCpbteM4nwzxs+w96n83IeJ
         shOx0BcOzTq3E4JF/hlMco7FAyjn60LdG7vKytD2J+ZdYsrW8rFTDNPh95b3vtUVvhsA
         nTRmG/zdlPgdhI6hDiah81kGmc0I75VpdGiTUpIkvfkfJ+tkQQEQ29pWBbEWgxA305qQ
         +ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=95dYiJC9IDZol3AtuiRZW/23v+t4OmpxxOGgsAq7Fsc=;
        b=pCGBcbgSWg9PL3YZ/i+TyrtUG4+slLyzzbgn316mqiufEi0NPCyKQVJuWOuHjAAwDD
         NRJVqEGWVxxce+irbljwNrlfnZeTH5TAtjp2KGuUiUGNzew4Tr6aYfDAtq/Vep20XKbR
         MsvP9+R/EVx/ISHjiewQ3QzaG/JrYm+cNSvU7tNDJyU2wCYAehyxdzZtopUUSf/B3co2
         slWNUyuWwuQaC5QnCA3ao+8hnxFVZU5QKPWbLYUSZak9lB7xcNa0EtUs9uBeeg7FZvch
         65DLVp0SwWcD8ym6+K+bFvGfzb35/5nps7nIZc4g7XAnYLQh8ZCH+esixqWEeDEYcyKi
         nVvA==
X-Gm-Message-State: AOAM532dOJmAjKgIEl42i7hclSTHw0b21GdemqupVzi5Q2M2O63wD6vC
        jKdhLosxvtPBSH8cBTKrRhSX3dlWhA==
X-Google-Smtp-Source: ABdhPJwVUKGw0QLiFW9XPwf2r2NLAq5BjdrToZq6AokVHC66Y8e3UeznCBqRNOYwVV+V22o7YNnBpxHjfQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dcf:e5ba:10a5:1ea5])
 (user=elver job=sendgmr) by 2002:aa7:c706:0:b0:42d:c4ad:ce0a with SMTP id
 i6-20020aa7c706000000b0042dc4adce0amr45226048edq.272.1654774268320; Thu, 09
 Jun 2022 04:31:08 -0700 (PDT)
Date:   Thu,  9 Jun 2022 13:30:42 +0200
In-Reply-To: <20220609113046.780504-1-elver@google.com>
Message-Id: <20220609113046.780504-5-elver@google.com>
Mime-Version: 1.0
References: <20220609113046.780504-1-elver@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 4/8] perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Due to being a __weak function, hw_breakpoint_weight() will cause the
compiler to always emit a call to it. This generates unnecessarily bad
code (register spills etc.) for no good reason; in fact it appears in
profiles of `perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512`:

    ...
    0.70%  [kernel]       [k] hw_breakpoint_weight
    ...

While a small percentage, no architecture defines its own
hw_breakpoint_weight() nor are there users outside hw_breakpoint.c,
which makes the fact it is currently __weak a poor choice.

Change hw_breakpoint_weight()'s definition to follow a similar protocol
to hw_breakpoint_slots(), such that if <asm/hw_breakpoint.h> defines
hw_breakpoint_weight(), we'll use it instead.

The result is that it is inlined and no longer shows up in profiles.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/hw_breakpoint.h | 1 -
 kernel/events/hw_breakpoint.c | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index 78dd7035d1e5..9fa3547acd87 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -79,7 +79,6 @@ extern int dbg_reserve_bp_slot(struct perf_event *bp);
 extern int dbg_release_bp_slot(struct perf_event *bp);
 extern int reserve_bp_slot(struct perf_event *bp);
 extern void release_bp_slot(struct perf_event *bp);
-int hw_breakpoint_weight(struct perf_event *bp);
 int arch_reserve_bp_slot(struct perf_event *bp);
 void arch_release_bp_slot(struct perf_event *bp);
 void arch_unregister_hw_breakpoint(struct perf_event *bp);
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 8e939723f27d..5f40c8dfa042 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -125,10 +125,12 @@ static __init int init_breakpoint_slots(void)
 }
 #endif
 
-__weak int hw_breakpoint_weight(struct perf_event *bp)
+#ifndef hw_breakpoint_weight
+static inline int hw_breakpoint_weight(struct perf_event *bp)
 {
 	return 1;
 }
+#endif
 
 static inline enum bp_type_idx find_slot_idx(u64 bp_type)
 {
-- 
2.36.1.255.ge46751e96f-goog

