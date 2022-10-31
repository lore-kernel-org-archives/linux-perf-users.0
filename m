Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992ACFA3740
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 Oct 2022 12:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiJaMkH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 Oct 2022 08:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiJaMkC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Oct 2022 08:40:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C88FF5B1
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Oct 2022 05:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+jGoj3UynYFB2Dupp2K1TkKCBa1ZcXs73ao/8pJgox8=; b=FJZBV57HrvPheTajcjOW/2uN3z
        f9h//EZDksKpyIAaqMx4g50ZvDVF3rKGWq4mLgEmHJph/7whWMsakEeZFO79lu6TIiwaTEpcLjlZq
        UYJz3qkDKxXp1fLV4ANaV1XUZ+iYmEv0oePKMlu42v7zl7pXlsAeSatTRm395qkzByz7rpTsmoIW6
        V9rdzQkS3T+A/rEAwEQMTIti5+3H53U8t4Kn5V7CTuAHHGvfTwRHPBlgO16PMshNteqqbh8ijaH6C
        6f6ZotcSJcTr3uIvGv/1KvuFv9EyxkG5+zhZPuu8BAI4Pd/2hpVyPY3RLeikky9QiDR1aV6kWHJgh
        9G7g+Cbg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opU53-007s1b-GY; Mon, 31 Oct 2022 12:39:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4669D300205;
        Mon, 31 Oct 2022 13:39:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C1F220C3AE57; Mon, 31 Oct 2022 13:39:52 +0100 (CET)
Date:   Mon, 31 Oct 2022 13:39:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-perf-users@vger.kernel.org, ravi.bangoria@amd.com
Subject: Re: [PATCH -next] perf/core: Using kfree_rcu() to simplify the code
 in put_ctx()
Message-ID: <Y1/CGIjCpWmou8nk@hirez.programming.kicks-ass.net>
References: <20221029034027.2006045-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029034027.2006045-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Oct 29, 2022 at 11:40:27AM +0800, Yang Yingliang wrote:
> After commit 983bd8543b5a ("perf: Rewrite core context handling"),
> the callback function of call_rcu() just calls a kfree(), so we
> can use kfree_rcu() instead of call_rcu() + callback function.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  kernel/events/core.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ebd9ebd53238..9bb274dd2aa6 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1157,14 +1157,6 @@ static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
>  		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
>  }
>  
> -static void free_ctx(struct rcu_head *head)
> -{
> -	struct perf_event_context *ctx;
> -
> -	ctx = container_of(head, struct perf_event_context, rcu_head);
> -	kfree(ctx);
> -}
> -
>  static void put_ctx(struct perf_event_context *ctx)
>  {
>  	if (refcount_dec_and_test(&ctx->refcount)) {
> @@ -1172,7 +1164,7 @@ static void put_ctx(struct perf_event_context *ctx)
>  			put_ctx(ctx->parent_ctx);
>  		if (ctx->task && ctx->task != TASK_TOMBSTONE)
>  			put_task_struct(ctx->task);
> -		call_rcu(&ctx->rcu_head, free_ctx);
> +		kfree_rcu(ctx, rcu_head);
>  	}
>  }

While valid; I think I prefer the explicit form. This makes it much
easier to add some debug code for example.
