Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6D2C47088
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDD061437
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 09:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhEZJs1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 05:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhEZJs0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 05:48:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304A9C06138A;
        Wed, 26 May 2021 02:46:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e15so347371plh.1;
        Wed, 26 May 2021 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zDvvvwoqfQvYWmKc028Jp9K1qZ09FScRwPlW+6bVp/o=;
        b=A0ygh7lvV2Ydcn8B1xGJgcOzAJpbASE5IpheAVAIrPYALaZIT+VTUne9U9SFZbGvwv
         mbsHQqQuFhT7sEEGg1fAe0qi7sUIFLKWBnEwnZDUWlfvqpT+cqkephAo09NSnaqzhBKw
         ngApBasi1JRzrKX0DRiqmOr+zZcxQU8YKYxp3NQxemG+nT84bDCIMv2hqL+2bU1HMrVe
         xvUQUbn+c8+7EG9WcDCujeOokFbYh2GiWVj+/Sf+WBulJw9xD6fTGT4A9M/Izl4Bcxvp
         sreJUOtqa3/0bHgXTjchSoguJDhmNyGzCett3c5U+86F3wJo1+1Jr0OLjbe5rsk3BGug
         KLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDvvvwoqfQvYWmKc028Jp9K1qZ09FScRwPlW+6bVp/o=;
        b=YXgYpVLOhvQ2beN1tZy8cCWPfcEOC/AO+tr/jsDZhT4nt1D8Ptjn3AdpkBxJNbtL3T
         rczgorV9oiQMk+pUNbIwdsUg6rbCJiuvzX/BTG0VYz0vTQ7p8mADlvV1cisDF/OuKtOP
         5wvjYILXo0dHgu3BaGtMlKJsxWRmybudBzS+WUOD8KJcleN2Ogzbi9xAvvnZULqldFL3
         9Jr7D3d/e3CXY4wgxiyNY5Ny5vcympCO16dSdYpbzSviYeMOJBk7Jx3CDPfOF/26foeC
         MN4n1tQjnChF2qdKN3Ctu2k2z43S2puCuvtgNFVMiUfxaR2erQvt9dLc5a3EykgXtX4J
         6Hew==
X-Gm-Message-State: AOAM533bgZWAinncu8PEd+7BTFRdDO8XyCA1OLjd3g6/qN/4mwjuxNan
        CT5XoCKYtxPryYOggwQnX5M4TPqRstM1AQ==
X-Google-Smtp-Source: ABdhPJxiBe7vms+t7rGUo8i6E7Wmw0BcpiZszBF1p+7mQ1P/7X2Bw6Ujmy6UzveU0gUB/v0UGt8p4Q==
X-Received: by 2002:a17:90a:5b17:: with SMTP id o23mr20634260pji.14.1622022413669;
        Wed, 26 May 2021 02:46:53 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id b1sm18248708pgf.84.2021.05.26.02.46.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 02:46:53 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     mingo@kernel.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        xiehaocheng.cn@gmail.com
Subject: Re:[PATCH] perf core: Fix some kernel-doc warnings.
Date:   Wed, 26 May 2021 17:46:42 +0800
Message-Id: <20210526094642.16119-1-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <YK3zHAdIQZ9GPhfg@gmail.com>
References: <YK3zHAdIQZ9GPhfg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Ingo Molnar <mingo@kernel.org> wrote：
>
>
> * Haocheng Xie <xiehaocheng.cn@gmail.com> wrote:
>
> > Fix the following W=1 kernel build warning(s):
> > kernel/events/core.c:143: warning: Function parameter or member 'cpu' not described in 'cpu_function_call'
> > kernel/events/core.c:11924: warning: Function parameter or member 'flags' not described in 'sys_perf_event_open'
> > kernel/events/core.c:12382: warning: Function parameter or member 'overflow_handler' not described in 'perf_event_create_kernel_counter'
> > kernel/events/core.c:12382: warning: Function parameter or member 'context' not described in 'perf_event_create_kernel_counter'
> >
> > Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
>
> Even with your two patches there's still W=1 warnings remaining in
> kernel/events/:
>
>   kernel/events/hw_breakpoint.c:461: warning: Function parameter or member 'context' not described in 'register_user_hw_breakpoint'
>   kernel/events/hw_breakpoint.c:560: warning: Function parameter or member 'context' not described in 'register_wide_hw_breakpoint'
>
> Could you please fix all of them, and send them as a 3-patch series?

OK, I will fix these warnings and resend the 3-patch series later.

>
> Doesn't make much sense to just partially fix W=1 warnings in a subsystem.
>
> Thanks,
>
>         Ingo

Thanks for your kind advice.

Best regards,

Haocheng Xie
