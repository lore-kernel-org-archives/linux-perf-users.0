Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B305DC11F69
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 13:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C306143C
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 13:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhGBN7X (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhGBN7W (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jul 2021 09:59:22 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229EC061762
        for <linux-perf-users@vger.kernel.org>; Fri,  2 Jul 2021 06:56:49 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w15so9581404pgk.13
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jul 2021 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=prR9MMxJFXYg7tQTmUSy0zU77pkSRzPHwNGdQsurfnw=;
        b=jJGc9dbBI79E5l/z1HwBg5pD9bdMDr690Yr/8fEtdU0rp8GXs4gIwfR8JOGiOCFAxY
         zBCJFA0o7fUuLPLu6aHlt2mLAURxadrVpyKySr7JB39yCT74INAJTuBJBrC9SnW+hmaC
         7NbGZGuXwIb3F8BKVzAmlw0W1E0NmHtBIwAaa4+meTVZRDJM1ZS1Idjp3/teipQ7K3wC
         AKkN1cD6EVwQv/If/iEw4CFjpeNJAKrrqTU8vaWmlGOJ9gQcDAv7mg+wjp77jenrV07N
         KVKhMiYi8e1gCceb6H3zYtN2pScQ2g7y8d92ub6JRXyi1WhVpGuWQB4mWUKfey2AobjT
         85Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=prR9MMxJFXYg7tQTmUSy0zU77pkSRzPHwNGdQsurfnw=;
        b=DBrVwq+2wrGt4/3buzW507qlnBEwXydy1ZW6nVxUwLZPywXVmljpts3NwC5cn+TbUQ
         tW/GLNFFJwq64n/Vhy6W8mGVeIDPRTHbe8lmicH7/I6kAY1EfYcwf3wAD+iPB5ieoCdM
         sRdmFqFWpqXFpJrLiILLUNqNiOKDfgy+SB3SgerwwSMDDvE+aAUdkn84S7kpF/XYKY4l
         i7SnNBRqcEqx745+T2QydZv1I/aWtzIfcQdODfSmNlV+iKazB7LmgJrZK5UqvhvzaLtT
         Wdp7xkJZgZDremIHwAL1CwTxttoxZnwVB4E9djK8ihHmCMUWprHxfkysNI3nFwJtY3Wh
         bRkQ==
X-Gm-Message-State: AOAM533+eOf2pX4NLYbcSMhu7HKLohvdHwQNcJ4lLneY3kkSxjvXOi18
        Nw94h5BzCSnnzZGVP28/oWqn1w==
X-Google-Smtp-Source: ABdhPJxfsV4JttWkQ7T3rEm/HugUDpjN+Gb23ibpjWkUF7ReB/JxrJk4ZFHrkD5tF+MTf8AKfxjCEQ==
X-Received: by 2002:a65:6412:: with SMTP id a18mr115669pgv.445.1625234208439;
        Fri, 02 Jul 2021 06:56:48 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id g2sm3217396pjd.55.2021.07.02.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:56:47 -0700 (PDT)
Date:   Fri, 2 Jul 2021 21:56:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     gushengxian <gushengxian507419@gmail.com>, will@kernel.org,
        mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] perf: tests: fix some mmemory leak issues
Message-ID: <20210702135641.GA22592@leoy-ThinkPad-X240s>
References: <20210702040955.631618-1-gushengxian507419@gmail.com>
 <YN8NjJLHoB+wzLXa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN8NjJLHoB+wzLXa@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Fri, Jul 02, 2021 at 09:58:52AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 01, 2021 at 09:09:55PM -0700, gushengxian escreveu:
> > From: gushengxian <gushengxian@yulong.com>
> > 
> > Some memory leak issues should be fixed by free().
> > Reported by cppcheck.

I don't think this patch does the right thing.  You could see that the
memory is allocated in arch specific function sample_ustack(), and the
"buf" pointer is assigned to sample->user_stack.data; and the memory
actually is released in the caller function test_dwarf_unwind__thread:

noinline int test_dwarf_unwind__thread(struct thread *thread)
{
        struct perf_sample sample;
        unsigned long cnt = 0;
        int err = -1;

        memset(&sample, 0, sizeof(sample));

        if (test__arch_unwind_sample(&sample, thread)) {
                pr_debug("failed to get unwind sample\n");
                goto out;
        } 

        [...]

 out:
        zfree(&sample.user_stack.data);
        zfree(&sample.user_regs.regs);
        return err;
}

So this patch will break the testing and doesn't fix any memory leak
issue.

Thanks,
Leo
