Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EA7C11F68
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 17:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C666140E
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 17:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhGBSA1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jul 2021 14:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhGBSA1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jul 2021 14:00:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F090760E0C;
        Fri,  2 Jul 2021 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625248675;
        bh=zM86ilOMJ34NHEAC7D/6ndvhtKKr1f/qz5+h4JAAl7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEYTwUdyp7chib8XCkQNNrFL4dqMjx7fwsRLGbVlHK7fqPtpjaxxiYnVoLn7khNDR
         6ym9aNbGFhKnTefPNC5sPRlYojCJ+W/AdpcoOa6HioI2g8xz+wQXdwS38HZTUirWwk
         R/TEUumYOKXDo2tyisO4tGNcz9pC+Q8yroxoOH1xQPQdnk89NhX0OJWB2F4KZZRJc1
         JlqaCA3Enb2Fr8CHNPj8x0+yY6rWKn8L8Nk+I92AhZ0Dsvt0wPV+i4wDHUBFI7kG4G
         V12c2RSM+E/IHgKfolCGIaixzMGpZj81DEHGIrOfLeUTLNhhgUR6xD3FCrJepF671N
         uRutPekGpMcpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 89C8E40B1A; Fri,  2 Jul 2021 14:57:51 -0300 (-03)
Date:   Fri, 2 Jul 2021 14:57:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     gushengxian <gushengxian507419@gmail.com>, will@kernel.org,
        mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] perf: tests: fix some mmemory leak issues
Message-ID: <YN9TnyUMd0VesywP@kernel.org>
References: <20210702040955.631618-1-gushengxian507419@gmail.com>
 <YN8NjJLHoB+wzLXa@kernel.org>
 <20210702135641.GA22592@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702135641.GA22592@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jul 02, 2021 at 09:56:41PM +0800, Leo Yan escreveu:
> Hi Arnaldo,
> 
> On Fri, Jul 02, 2021 at 09:58:52AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jul 01, 2021 at 09:09:55PM -0700, gushengxian escreveu:
> > > From: gushengxian <gushengxian@yulong.com>
> > > 
> > > Some memory leak issues should be fixed by free().
> > > Reported by cppcheck.
> 
> I don't think this patch does the right thing.  You could see that the
> memory is allocated in arch specific function sample_ustack(), and the
> "buf" pointer is assigned to sample->user_stack.data; and the memory
> actually is released in the caller function test_dwarf_unwind__thread:
> 
> noinline int test_dwarf_unwind__thread(struct thread *thread)
> {
>         struct perf_sample sample;
>         unsigned long cnt = 0;
>         int err = -1;
> 
>         memset(&sample, 0, sizeof(sample));
> 
>         if (test__arch_unwind_sample(&sample, thread)) {
>                 pr_debug("failed to get unwind sample\n");
>                 goto out;
>         } 
> 
>         [...]
> 
>  out:
>         zfree(&sample.user_stack.data);
>         zfree(&sample.user_regs.regs);
>         return err;
> }
> 
> So this patch will break the testing and doesn't fix any memory leak
> issue.

You are right, those buffers are allocated in those functions and then
_returned_ via sample->user_stack, the tool (and myself, ugh) got
fooled, I'll remove that from my local tree.

Thanks Leo!

- Arnaldo
