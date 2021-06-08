Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB1AC47082
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E909461363
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 17:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhFHRWP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhFHRWP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 13:22:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F325EC061574;
        Tue,  8 Jun 2021 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+IWvpG5hCKUWZQmnEzLCRWCcfGQvqOrsw12/5A36hCg=; b=TwufXCSeDtThjAt6H5ZakBd7rz
        4+NUEF1M+HhNi3F1CkM3XJRef0YOo3kIYB0dunzeMvMppZu9TTs/mAHIoZOYCUDazolPXuFRngLSp
        YlUZchN+i8hYGQCQvvGkJjsdhwdrCdClH6jrZ2wNPxnW6GGNqHnrN7hVrZxuU0nAu3emW0xuZ77Pl
        p8rKYRrufWepwCvLWcJcJaa/w4ZWN1fy9U2BbMjpLv79nacUIpu6lUCWWmUAPCOFxvTYD49uBdibb
        ya9RU0Of4Atho6a5ncmfH38nJMvjMREQSh0uRRoJDk/HSce1SrzvnBVHl3DxBUGYTCitXyjnlgdht
        XZECbwJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqfOb-004oqU-2T; Tue, 08 Jun 2021 17:20:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 839A53001E3;
        Tue,  8 Jun 2021 19:20:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DC55201E7ED3; Tue,  8 Jun 2021 19:20:14 +0200 (CEST)
Date:   Tue, 8 Jun 2021 19:20:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] events: core: make perf_pmu_snapshot_aux static
Message-ID: <YL+mziX+UU4MHQyZ@hirez.programming.kicks-ass.net>
References: <20210608162253.23351-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608162253.23351-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 08, 2021 at 07:22:53PM +0300, Pavel Skripkin wrote:
> Sparse says:
>   warning: symbol 'perf_pmu_snapshot_aux' was not declared. Should it be static?
> 
> Since perf_pmu_snapshot_aux() is not used outside this file,
> it can be made static
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6fee4a7e88d7..0d98d6a6f949 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6667,7 +6667,7 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
>  	return data->aux_size;
>  }
>  
> -long perf_pmu_snapshot_aux(struct perf_buffer *rb,
> +static long perf_pmu_snapshot_aux(struct perf_buffer *rb,
>  			   struct perf_event *event,
>  			   struct perf_output_handle *handle,
>  			   unsigned long size)

You've just ruined the alignment of the arguments, also you subject has
the wrong prefix, see to git log for suggestions.
