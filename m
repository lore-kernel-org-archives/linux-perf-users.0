Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22231C47082
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 15:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BF761185
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 15:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhFGP3g (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 11:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFGP3e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Jun 2021 11:29:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A464C061766;
        Mon,  7 Jun 2021 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gJrY6iiGPzs6iGJKkNIy3WHBh9VoBLb6vQTSmNqRX4M=; b=qjScuI46Voo5bgA7/vt0xcCSCz
        rpjDXQLHNoBHCEagaipTugxCf/hT9KxBbNebPYG2QYkpHaP+6X47MSVt8pLBTmMqh5Kzn+IPVCWdt
        gkAwSRco+ALgHAz3RroyqbGcvnJvVBepOjL0dOMXjGF5/EtWBsUmnVoD1fyir1uUqdYDujiJf4Qbl
        gKvFtE0JjVTHV01CqTwZenT6PKYmOrFGd562ZQEp9UdjJ7Ugs9s4McvNSBS2JNvPyK7W4g5xsFYnH
        U9zFYsap9OQWY6cvbkmlPq1N+yi8hqmzqCHQZhHxWBtJGgUknjAl+kblXvLX+UaVL+uJJinUIAX07
        HEc+ZKmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqH9t-004RfL-MR; Mon, 07 Jun 2021 15:27:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36C7F3001E3;
        Mon,  7 Jun 2021 17:27:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E67F92D6A7343; Mon,  7 Jun 2021 17:27:25 +0200 (CEST)
Date:   Mon, 7 Jun 2021 17:27:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/8] perf/ring_buffer: Add comment for barriers on AUX
 ring buffer
Message-ID: <YL463Zly9cKpSe7A@hirez.programming.kicks-ass.net>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602103007.184993-2-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 02, 2021 at 06:30:00PM +0800, Leo Yan wrote:
> AUX ring buffer applies almost the same barriers as perf ring buffer,
> but there has an exception for ordering between writing the AUX trace
> data and updating user_page::aux_head.
> 
> This patch adds comment for how to use the barriers on AUX ring buffer,
> and gives comment to ask the drivers to flush the trace data into AUX
> ring buffer prior to updating user_page::aux_head.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/events/ring_buffer.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 52868716ec35..5cf6579be05e 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -509,6 +509,15 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
>  		perf_event_aux_event(handle->event, aux_head, size,
>  				     handle->aux_flags);
>  
> +	/*
> +	 * See perf_output_put_handle(), AUX ring buffer applies the same
> +	 * barrier pairing as the perf ring buffer; except for B, since
> +	 * AUX ring buffer is written by hardware trace, we cannot simply
> +	 * use the generic memory barrier (like smp_wmb()) prior to update
> +	 * user_page::aux_head, the hardware trace driver takes the
> +	 * responsibility to ensure the trace data has been flushed into
> +	 * the AUX buffer before calling perf_aux_output_end().
> +	 */
>  	WRITE_ONCE(rb->user_page->aux_head, rb->aux_head);
>  	if (rb_need_aux_wakeup(rb))
>  		wakeup = true;
> -- 
> 2.25.1
> 
