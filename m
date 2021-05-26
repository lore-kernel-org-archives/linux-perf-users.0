Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2172C2B9F7
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 11:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966B4611C2
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 11:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhEZL41 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 07:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbhEZL4N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 07:56:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735DEC06138D;
        Wed, 26 May 2021 04:52:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso217327pji.0;
        Wed, 26 May 2021 04:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jG9XU2eeNR1ehF2kR/N0/vaVpfMY3ZfXw7N9zluBZsA=;
        b=DpNN6VC1bs3fqeKj96ALvgwREECNRQSVfgS0EkRGjMpX1hCxXq90a1UlVM2ETveII7
         DSyzJbJTwX4HMTYA3NndXbhr2DRBeY0Xes4GicljeMu1B1J78o3S9+WOsJaqmhmwN2h6
         Bnsns5aeYkocMbp8VcFJ2cgyIvS+oFS2X6HLvaOIDwYK8mNfl2GdV5IeD5wEPKeXT0pa
         g+0c8kFE7FxKY6iJCVuI2LA2m45EU1H+ffRP1LruD17rTAe1PAGbk1RtXtGvRx8krRa4
         n3LqegNBZVPlyTa1iEoyxHrWU5An8cU1qg2LjO5/0NOLxHDne1i4kLfO24SGeCaeDJH8
         33WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jG9XU2eeNR1ehF2kR/N0/vaVpfMY3ZfXw7N9zluBZsA=;
        b=gA0WJ6TpJpfVi/Dg6RYYzsQv4aJdx4l2GlTAZWW7LUfhwSMavISZsSNkrGo3oahOMc
         ujmtG5H3Jg1OdZ9WVcboAbp3ymHYZlGLbuf+1CXUpFcUxdijoyi2xfHoonmEt2O3mq4o
         a53wMhTACDmZP4CLEXUw7qqn+788+Muhj82f2e7m9zC20uTIHl2rbRNyAyedFoxOVxXi
         lfTWodraSl3KQNDNH+ogf43ue6T0TWCz7mLXhSaEbrl0NtLkWH8nBUzFWTVd1my8G8Q1
         LVqv7rFguoyLMAZi2WK9ZBOibP5lAiXHvUqlWyN2VPd7uAnKXv/ykiCjnk7qUSVr0nQ7
         mAWw==
X-Gm-Message-State: AOAM532NGUIFr7Jk1VDxfDUgbdacdcmJebi8GQ6ekaBUMGHxrQygBOSq
        Xhs+iD1PU6+7hq2AERnw9cQ=
X-Google-Smtp-Source: ABdhPJyV0WrPvxkmnWzMWkmPWk8JZ7w026Z3WsoWC9tdB+aQkDi09witV7LF23YvqkqFITP2WhZrXQ==
X-Received: by 2002:a17:90a:f0d2:: with SMTP id fa18mr3579345pjb.126.1622029968116;
        Wed, 26 May 2021 04:52:48 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s48sm15328843pfw.205.2021.05.26.04.52.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 04:52:47 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     mingo@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH 3/3] perf/hw_breakpoint: Fix kernel-doc warnings in perf hw_breakpoint
Date:   Wed, 26 May 2021 19:52:20 +0800
Message-Id: <20210526115220.19134-4-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210526115220.19134-1-xiehaocheng.cn@gmail.com>
References: <20210526115220.19134-1-xiehaocheng.cn@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix the following W=1 kernel build warning(s):

  kernel/events/hw_breakpoint.c:461: warning: Function parameter or member 'context' not described in 'register_user_hw_breakpoint'
  kernel/events/hw_breakpoint.c:560: warning: Function parameter or member 'context' not described in 'register_wide_hw_breakpoint'

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
---
 kernel/events/hw_breakpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index b48d703..8359734 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -451,6 +451,7 @@ int register_perf_hw_breakpoint(struct perf_event *bp)
  * register_user_hw_breakpoint - register a hardware breakpoint for user space
  * @attr: breakpoint attributes
  * @triggered: callback to trigger when we hit the breakpoint
+ * @context: context data could be used in the triggered callback
  * @tsk: pointer to 'task_struct' of the process to which the address belongs
  */
 struct perf_event *
@@ -550,6 +551,7 @@ EXPORT_SYMBOL_GPL(unregister_hw_breakpoint);
  * register_wide_hw_breakpoint - register a wide breakpoint in the kernel
  * @attr: breakpoint attributes
  * @triggered: callback to trigger when we hit the breakpoint
+ * @context: context data could be used in the triggered callback
  *
  * @return a set of per_cpu pointers to perf events
  */
-- 
2.9.5

