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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA767C47089
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 03:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A8A613C1
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 03:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhE0DVw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 23:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhE0DVu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 23:21:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00DC061763;
        Wed, 26 May 2021 20:20:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lr4-20020a17090b4b84b02901600455effdso371637pjb.5;
        Wed, 26 May 2021 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sONGP+MuZvr2rIV5XDT1+R28NlOPicY3nXSExBdaw0o=;
        b=Hkv/NmoQvKQWtlenHmBV9JoQCiqyo9aOsCJRHbKEV0nu5goUOGkrQCcruSjFZQ2JCJ
         p5Ty6dBju/kHGXaoPO1ImqgI0tGLgh5OgC6HUxwFpQYoxp8J8EysD3qPc5Y+fncn5FXn
         xrvWyWvus+wvhhOcmUU3muIf+YR3qHnUK3caOKFzVJ5+r5HHECG5+eF8ApVcRY+4/8jy
         YQsDtjvXzaZXzhW+a93arZdupX8T2AtdaL/N01winQKS+oizddxXNkGlWLHXepPVZg3z
         OypP3Txnc6ZuWyDU44BV1HIh44SUxUvSMrQkEPgifEsYrYClboAPDeHc2CFoj2MmoMB0
         wnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sONGP+MuZvr2rIV5XDT1+R28NlOPicY3nXSExBdaw0o=;
        b=BfpDAdzTkIW3VmVG4nWmGsWx45xgQrCdAC+hPUzT7i0druEG32F5bp5y/O6Q6tMhHz
         8gkCzfxQpQLrNTmIXafoi0qGWi84Mv4LVpNqSLs7M4BIiVrUOR7tBRlFVl95CLFe+PYm
         8NgKxRHWjWwEm+oKPwEAvk3GDvdwaqb3g8pgXwhj1rs7P1UZVwzguiTjShG6MRwRILqB
         /LhvrpDrRJzJTFJMnxRcsPiZnwVT0p+sWxcQ3jTfZ51ZyxNavnPypNSVBNFnmD05SlwY
         ujf+zIDGJ8kY6smVgI4Nfn6Dm5IjHzEU8nqXyBVTqaJ6PjVuc9J4mQml2TWEz5bJJw0V
         32+w==
X-Gm-Message-State: AOAM532r293LY9/msJeDsgmNpA0ubq2FczzlwW9rj5Sg1utFPzMQFdtP
        ybWxcRaNOMsiDVFCYLbdLZM=
X-Google-Smtp-Source: ABdhPJylZ/zELefoVndPoXgreNohKxqMS5IENlbc3AUitj0GRxEtx/wlWzyopdobWf/TrPvX+pOgFQ==
X-Received: by 2002:a17:90a:2a02:: with SMTP id i2mr6974798pjd.148.1622085617148;
        Wed, 26 May 2021 20:20:17 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id l6sm554716pjf.28.2021.05.26.20.20.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 20:20:16 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     mingo@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH v2 2/3] perf core: Fix some kernel-doc warnings.
Date:   Thu, 27 May 2021 11:19:46 +0800
Message-Id: <20210527031947.1801-3-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210527031947.1801-1-xiehaocheng.cn@gmail.com>
References: <20210527031947.1801-1-xiehaocheng.cn@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix the following W=1 kernel build warning(s):

  kernel/events/core.c:143: warning: Function parameter or member 'cpu' not described in 'cpu_function_call'
  kernel/events/core.c:11924: warning: Function parameter or member 'flags' not described in 'sys_perf_event_open'
  kernel/events/core.c:12382: warning: Function parameter or member 'overflow_handler' not described in 'perf_event_create_kernel_counter'
  kernel/events/core.c:12382: warning: Function parameter or member 'context' not described in 'perf_event_create_kernel_counter'

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e1a80e1..acfd0b4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -132,6 +132,7 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 
 /**
  * cpu_function_call - call a function on the cpu
+ * @cpu:	target cpu to queue this function
  * @func:	the function to be called
  * @info:	the function call argument
  *
@@ -11917,6 +11918,7 @@ __perf_event_ctx_lock_double(struct perf_event *group_leader,
  * @pid:		target pid
  * @cpu:		target cpu
  * @group_fd:		group leader event fd
+ * @flags:		perf event open flags
  */
 SYSCALL_DEFINE5(perf_event_open,
 		struct perf_event_attr __user *, attr_uptr,
@@ -12373,6 +12375,8 @@ SYSCALL_DEFINE5(perf_event_open,
  * @attr: attributes of the counter to create
  * @cpu: cpu in which the counter is bound
  * @task: task to profile (NULL for percpu)
+ * @overflow_handler: callback to trigger when we hit the event
+ * @context: context data could be used in overflow_handler callback
  */
 struct perf_event *
 perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
-- 
2.9.5

