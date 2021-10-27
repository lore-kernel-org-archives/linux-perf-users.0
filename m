Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CDC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F47B610A4
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbhJ0UTP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:19:15 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:37754 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240671AbhJ0UTL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Oct 2021 16:19:11 -0400
Received: by mail-oi1-f173.google.com with SMTP id o83so5112182oif.4;
        Wed, 27 Oct 2021 13:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XglJs1OrxOGXDZwQ6Z0xWT/fdEEcMb5WDcdtHAA51Ao=;
        b=3LUUhDrpVAIdEffQvEHKdYzu00qR+OQL2KM2+EqF3BPKf+jN+6KthuHdWNXih/0st6
         1aYBv39CiO2OE94D6ZUghnnjlqdb1Mf+xkuAsNC/C3eRGgbei+6dY+M4+wZR/Cil+ogf
         pbuD5tn3GgjKNQtAb+AfrJAq4MUmHuORb7DxBotHbq4PbNlld9bu2zhz+mhfGzxyNiHO
         y/yWaNsnV0dQOzJgMhHZQaEjODg1KsqUm1ajSqsq7flV7mH23N/EeJNcBG+bpurMblfv
         /FZcIoIQEde1xFsSfRi0e+NW2/JkQdKz5+tWVgl9iawe9/jpQ/uz2ZSb/1zcZjS31ZT3
         yMqQ==
X-Gm-Message-State: AOAM53152eX+7P16EyTHyMI5trtb53NSVHdk9P7k1lskP0+7yJMrSkye
        6qwzNN2GF62DhG+JKlYsKQ==
X-Google-Smtp-Source: ABdhPJxX3AiZ/vuirHgymgSIPu02dS9OiXOc1XMBNH12+W2iAg30s4MUs+CWgL849GrCzTZnN0NyYw==
X-Received: by 2002:a05:6808:238a:: with SMTP id bp10mr5367505oib.30.1635365805635;
        Wed, 27 Oct 2021 13:16:45 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id f10sm415332otc.26.2021.10.27.13.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:16:45 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH v12 2/5] perf: Add a counter for number of user access events in context
Date:   Wed, 27 Oct 2021 15:16:38 -0500
Message-Id: <20211027201641.2076427-3-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211027201641.2076427-1-robh@kernel.org>
References: <20211027201641.2076427-1-robh@kernel.org>
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

