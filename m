Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B13AC2B9F7
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 07:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62469613EC
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 07:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhEZHHA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhEZHG6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 03:06:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9724C061574;
        Wed, 26 May 2021 00:05:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p7so30952671wru.10;
        Wed, 26 May 2021 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eGAqNQ4+oIfeyWH34ul2O0oaopqnEZsSkjATZeXV824=;
        b=ivQ6EuNXRiKIUyIUgGs7x2SRgNkPbqOET6KdIuHLjbT9zv8teYOirGiz1+g5oDaDWc
         AtyKEZOCrORGb/fn+AdQPW1JXJg4spBf8DRq+fhcDt4Ay3S3wC+LSwfRRQ3sSbddbfnr
         6C6e0965XZzUSwSu7oRB+MWcBHD+Vhd2KmUbxdL11rOb8f5k0cV7DmawAJxIqImS96nS
         gMlXX+EeUr/Bd7wA4QtMgAfi3jxtxYMwI+9IfmRQNczK9ViOdfNIVG7oaaKLkhN1OSMM
         P4GuEF3E8iTSOzBG2wasx2QeE/GCHxhMd6ei4A/6sTWIFgzO8Ia1FipSVQ3Hg7kO9i5O
         bB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eGAqNQ4+oIfeyWH34ul2O0oaopqnEZsSkjATZeXV824=;
        b=hSeLHNAeV8pHX9/LJAaJhDvkyzIRvGrfmv5wweLzaP6b5mkQRf4oFxm956+0TQTgGf
         Ve/uBeYxZFLhRChWlTXI8DYO6wNXd7Stw6J6UfGV0iJpxHw+EQenT8V0XuLXUOKarSDK
         yzerbtEd5HIutifZ8beIqZjdsr5sa7Gz98yNKqLBhiIdL/QMKGSGgk5Y04UO61gZ83MR
         Bg7VlMLeBUqVuXdVrYTbYGvYiGg+brcBFLYgytRhE9ArQ7OWA7J6J27G9O6cbsE7Dc2s
         EzsISr0s2wFEJpUSGBDxqUGPqCArHAXTOwyV9s86koHi3lDXYqnlpQhcsRvH1QdSe2ku
         fCpQ==
X-Gm-Message-State: AOAM533GLDfn25jfREdmFmwINuxH8MDvCOM3rl8A2L1CBVMVV7Art5dP
        25JFH0iYV0kQ1No0GUETqtg=
X-Google-Smtp-Source: ABdhPJz2bvhrP1qZ/Qxypuy8WGX+eMj+o0ceWII92tzUzM21wcztnfU0hXr3vza4NJSuLUtHQcRxsg==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr31853645wru.348.1622012702431;
        Wed, 26 May 2021 00:05:02 -0700 (PDT)
Received: from gmail.com (0526ECF1.unconfigured.pool.telekom.hu. [5.38.236.241])
        by smtp.gmail.com with ESMTPSA id r5sm18709791wrw.96.2021.05.26.00.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 00:05:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 26 May 2021 09:05:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Haocheng Xie <xiehaocheng.cn@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf core: Fix some kernel-doc warnings.
Message-ID: <YK3zHAdIQZ9GPhfg@gmail.com>
References: <20210526033438.23640-1-xiehaocheng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526033438.23640-1-xiehaocheng.cn@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


* Haocheng Xie <xiehaocheng.cn@gmail.com> wrote:

> Fix the following W=1 kernel build warning(s):
> kernel/events/core.c:143: warning: Function parameter or member 'cpu' not described in 'cpu_function_call'
> kernel/events/core.c:11924: warning: Function parameter or member 'flags' not described in 'sys_perf_event_open'
> kernel/events/core.c:12382: warning: Function parameter or member 'overflow_handler' not described in 'perf_event_create_kernel_counter'
> kernel/events/core.c:12382: warning: Function parameter or member 'context' not described in 'perf_event_create_kernel_counter'
> 
> Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>

Even with your two patches there's still W=1 warnings remaining in 
kernel/events/:

  kernel/events/hw_breakpoint.c:461: warning: Function parameter or member 'context' not described in 'register_user_hw_breakpoint'
  kernel/events/hw_breakpoint.c:560: warning: Function parameter or member 'context' not described in 'register_wide_hw_breakpoint'

Could you please fix all of them, and send them as a 3-patch series? 

Doesn't make much sense to just partially fix W=1 warnings in a subsystem.

Thanks,

	Ingo
