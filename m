Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F94C2B9F7
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 12:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBF5613D3
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 12:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhEZMG3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhEZMG2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 08:06:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3FAC061574;
        Wed, 26 May 2021 05:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VdBNs2ytTzfvfdW54PZcWXWcoEeRrVfq08WZIve4SxU=; b=WmkDqhecHjXo37pNvV3cCS7kEu
        ifYaMipeE/FiGxmmSo5LYlhiVTeTsN1d2DfAfE7ZDH3e/Bwqd7b9vIqqQp0xXybqlF9KMpf0H+3Dn
        nKGdM9z7mSmX3CDVSHaPfe7hhHXa5sCC54YCD9RCJvKDTks1EYUfAgzpcE/20AjhyLc01TDzLVYC0
        h/u26ObSMq5QDQC8eV0EToVE2zuns96oy3gKJYfC8/2VldGFnd47zNj+Rmfp9h+Bi3QE1BBuZvNMQ
        lDdOXHRn3tjkYxvL+EYmgb2LlNHaHbkNUDFWRJrCrDlJuAfA+kvChlXBVQF8XiUmYnsOG+RmUR7AD
        5VyAtKug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llsH0-004Ub0-5D; Wed, 26 May 2021 12:04:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AD5630022A;
        Wed, 26 May 2021 14:04:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 168A220567627; Wed, 26 May 2021 14:04:29 +0200 (CEST)
Date:   Wed, 26 May 2021 14:04:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Haocheng Xie <xiehaocheng.cn@gmail.com>
Cc:     mingo@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf core:  Make local function
 perf_pmu_snapshot_aux() static
Message-ID: <YK45TSGv+DeuR8+X@hirez.programming.kicks-ass.net>
References: <20210526115220.19134-1-xiehaocheng.cn@gmail.com>
 <20210526115220.19134-2-xiehaocheng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526115220.19134-2-xiehaocheng.cn@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 26, 2021 at 07:52:18PM +0800, Haocheng Xie wrote:
> Fixes the following W=1 kernel build warning:
>   kernel/events/core.c:6670:6: warning: no previous prototype for 'perf_pmu_snapshot_aux' [-Wmissing-prototypes]
> 
> Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6fee4a7..0d98d6a 100644
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

Your $subject is broken (superfluous whitespace) and you've wrecked
alignment of the arguments in the core.
