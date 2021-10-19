Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942B9C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7053A610D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhJSXV0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:21:26 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45768 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhJSXVZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 19:21:25 -0400
Received: by mail-ot1-f41.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so6037590otq.12;
        Tue, 19 Oct 2021 16:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XglJs1OrxOGXDZwQ6Z0xWT/fdEEcMb5WDcdtHAA51Ao=;
        b=tDaSIetytgq3TiT3nfknOXiNTMMjkuUhcKuJ2WiZdiNokUcz9ku+QS9aRNcAI8TYMz
         qT/JQJcgHXsP0khYm8jeaRoBR01JiTXRTN12kq/s6aXr8qdFyoO9uX1CQ6pdoIo3t5Ce
         UWemz5mSYMtkVAQSJISPJWchT0O2zDyODVYqMRT/h728fiZsf45J6t+vzx0dC+hflaES
         6OqQYCmapTuSZYkJvUalf+AYSTbWWrGDqiLbmIjDJpN18VMWpIiOLTpyLzTbquoXJpUW
         vxHfwMom6d0XPY0k9/SEN+wEcLpnXsFJo6B+8RbWg++err2AgCe227NzrpacecEReXw1
         h8/g==
X-Gm-Message-State: AOAM532E5a5i8vfkypWFjcY3EsfZhqbky+D15mQL1bBjgspvY1cHDeSm
        Agr48Z14oZQ+6w9UL7Eidw==
X-Google-Smtp-Source: ABdhPJz6Og0K6t0hbldmeiQOmZTYLKfs6H7w5KWGlZmRP25TgOZuGLW8da3/Sqq3Pv/yagIKK3zWug==
X-Received: by 2002:a05:6830:1c64:: with SMTP id s4mr7856080otg.174.1634685551709;
        Tue, 19 Oct 2021 16:19:11 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id w141sm118375oif.20.2021.10.19.16.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:19:11 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v11 2/5] perf: Add a counter for number of user access events in context
Date:   Tue, 19 Oct 2021 18:19:04 -0500
Message-Id: <20211019231907.1009567-3-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211019231907.1009567-1-robh@kernel.org>
References: <20211019231907.1009567-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For controlling user space counter access, we need to know if any event
in a context (currently scheduled or not) is using user space counters.
Walking the context's list of events would be slow, so add a counter
to track this.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v10:
 - Re-added.
 - Maintain the count in the perf core
v9:
 - Dropped
v8:
 - new patch
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 34ebcc9af608..d733cac749e2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -828,6 +828,7 @@ struct perf_event_context {
 
 	int				nr_events;
 	int				nr_active;
+	int				nr_user;
 	int				is_active;
 	int				nr_stat;
 	int				nr_freq;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 744e8726c5b2..01290d150da3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1808,6 +1808,8 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 
 	list_add_rcu(&event->event_entry, &ctx->event_list);
 	ctx->nr_events++;
+	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
+		ctx->nr_user++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
 
@@ -1999,6 +2001,8 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	event->attach_state &= ~PERF_ATTACH_CONTEXT;
 
 	ctx->nr_events--;
+	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
+		ctx->nr_user--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
 
-- 
2.32.0

