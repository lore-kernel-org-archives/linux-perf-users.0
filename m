Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD77C47080
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 17:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0F561108
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 17:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhEaRZh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 May 2021 13:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhEaRZ1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 May 2021 13:25:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469BFC0610EC;
        Mon, 31 May 2021 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fLx9o42NgDmYQ9T0R4vm13NnGiIWmnmmUmKH29M1lgE=; b=uQUmUueCLEMAe52ML3MgGtPMvJ
        MtUD3E2fFFeyXxBtpEMB3qZI2giE9fVtPHprgVt6AP7OfJ6efWrE0xP0BGqbEsKVEKruNpkILZ8+I
        ozj/EnPtdEVXoQoKFiadDs0TPrRNzXacDMsYwyQJTWFRQSnsJ5ma23GkePYUucrkbELWpa06zle40
        5LhbrMMAnPy/X3dDnaa/w1TX/kWe7bbSmal27sMrJxiloJt9iuFkFkuxUL6xjBvdG1GYMuvMJRGQc
        KjYbLZ98ptBsEqgVI0O5OX09x4ZnUcBigfqCI8ZCCJZ2190k94XWgJOnsVeLg33T0HI3EkBQnoVlT
        y+p32p8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lnkGD-009Ak1-Tn; Mon, 31 May 2021 15:55:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57396300223;
        Mon, 31 May 2021 17:55:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18A392011CA24; Mon, 31 May 2021 17:55:25 +0200 (CEST)
Date:   Mon, 31 May 2021 17:55:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with
 load-acquire and store-release
Message-ID: <YLUG7f3D4deX0/BF@hirez.programming.kicks-ass.net>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
 <20210531151049.GE9324@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531151049.GE9324@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 31, 2021 at 11:10:49PM +0800, Leo Yan wrote:
> Hi Peter, Adrian,
> 
> On Wed, May 19, 2021 at 10:03:19PM +0800, Leo Yan wrote:
> > Load-acquire and store-release are one-way permeable barriers, which can
> > be used to guarantee the memory ordering between accessing the buffer
> > data and the buffer's head / tail.
> > 
> > This patch optimizes the memory ordering with the load-acquire and
> > store-release barriers.
> 
> Is this patch okay for you?

Not without actual numbers; that's some terrible ifdef soup.

> Besides this patch, I have an extra question.  You could see for
> accessing the AUX buffer's head and tail, it also support to use
> compiler build-in functions for atomicity accessing:
> 
>   __sync_val_compare_and_swap()
>   __sync_bool_compare_and_swap()
> 
> Since now we have READ_ONCE()/WRITE_ONCE(), do you think we still need
> to support __sync_xxx_compare_and_swap() atomicity?
> 
> I checked the code for updating head and tail for the perf ring buffer
> (see ring_buffer_read_head() and ring_buffer_write_tail() in the file
> tools/include/linux/ring_buffer.h), which doesn't support
> __sync_xxx_compare_and_swap() anymore.  This is why I wander if should
> drop __sync_xxx_compare_and_swap() atomicity for AUX ring buffer as
> well.

I'm not sure wth that code is even trying to do, that's some seriously
dodgy code.


