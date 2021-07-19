Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1541C07E95
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97696113B
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347206AbhGSWgA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385432AbhGSTAd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 15:00:33 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C538C0613AD
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jul 2021 12:30:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id u14so20107251pga.11
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jul 2021 12:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IeosqyxZlkBHUUEoKqwVxM/isG0gC3YMq8teSxiBUHY=;
        b=RX/yDidJamxqLcAAsTSeOznvtLBzErsJdlhHPV3vFKEil91YBw1hVk53DDTU8eLLdN
         BwgE49ZC3yGr1s0d9vRjv+vsQYuSLX47B9lyb8SFd8BebKeu/Hatxudc3xkMEkUYJMYa
         pOrDTVu2rMtlV9T1kbgQKZ3j75oO4WJKeGlIXLkjHrXom5DMFTx5MX7bUm/8D9r0aBTt
         WSKVe4XjMgGZINj7UxmWM/KsFapbKhBr5S4WUsVrQfQTqvUN+LfG7UbfyY0K8cb22Twj
         0dvt8WrBObyXG8lreYnrwzAAgXAQ2ECPRdXj81U119/+7a/slz7W1VvB2H/uPof6u7+D
         zIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IeosqyxZlkBHUUEoKqwVxM/isG0gC3YMq8teSxiBUHY=;
        b=BASizohadwSuUUlKrQ3QM3mwGTG61f4J0I+Hj/RwbAWkUblVl/gSOUjUvXyQriI9XF
         rm/wwULTpCjwllNobU6CKYqbHPutEnd3Crg1p65PW/qXURocttK5RtiaxiqiO4RmR0Qx
         1l3J9pztAY24Pxaez15m6S5nJhozVSzuBXUus4++ZvWf6QoJMDNLMKJ6ccmqi3/xrdET
         PieZyBJU65ugapf3WP1jUYxlChxcxF6zPdYtLrKAc4JqV0Smciuys7YQMQSTjS+CYuOh
         0Ls3bgn63Fon0kh26TCwuZT5MFtr0eFqjimNPwrfPbmvcbK0//4aVSdcjcqWWPzoI7+U
         z6+Q==
X-Gm-Message-State: AOAM5337hXBGxIvE52Xjrm38FgvExH7KjUqv4f+igFuxekYXMkrjHteN
        93eWK/RiESZhqV0TPKUoSVUHZQ==
X-Google-Smtp-Source: ABdhPJz0F/gSV8rMzQotOiv22Mztp5lFpf4O6is+gp5LUg/869qeRCFfT+aqAP3WavnjyRbe72C05Q==
X-Received: by 2002:aa7:97a3:0:b029:341:36e5:61d0 with SMTP id d3-20020aa797a30000b029034136e561d0mr11899341pfq.8.1626723504497;
        Mon, 19 Jul 2021 12:38:24 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m19sm21046578pfa.135.2021.07.19.12.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:38:23 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:38:21 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, coresight@lists.linaro.org, leo.yan@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] perf cs-etm: Split setup and timestamp search
 functions
Message-ID: <20210719193821.GC2255168@p14s>
References: <20210713154008.29656-1-james.clark@arm.com>
 <20210713154008.29656-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713154008.29656-3-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 13, 2021 at 04:40:04PM +0100, James Clark wrote:
> This refactoring has some benefits:
>  * Decoding is done to find the timestamp. If we want to print errors
>    when maps aren't available, then doing it from cs_etm__setup_queue()
>    may cause warnings to be printed.
>  * The cs_etm__setup_queue() flow is shared between timed and timeless
>    modes, so it needs to be guarded by an if statement which can now
>    be removed.
>  * Allows moving the setup queues function earlier.
>  * If data was piped in, then not all queues would be filled so it
>    wouldn't have worked properly anyway. Now it waits for flush so
>    data in all queues will be available.
> 
> The motivation for this is to decouple setup functions with ones that
> involve decoding. That way we can move the setup function earlier when
> the formatted/unformatted trace information is available.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 41 ++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 4c69ef391f60..426e99c07ca9 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -809,29 +809,32 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  			       struct auxtrace_queue *queue,
>  			       unsigned int queue_nr)
>  {
> -	int ret = 0;
> -	unsigned int cs_queue_nr;
> -	u8 trace_chan_id;
> -	u64 cs_timestamp;
>  	struct cs_etm_queue *etmq = queue->priv;
>  
>  	if (list_empty(&queue->head) || etmq)
> -		goto out;
> +		return 0;
>  
>  	etmq = cs_etm__alloc_queue(etm);
>  
> -	if (!etmq) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!etmq)
> +		return -ENOMEM;
>  
>  	queue->priv = etmq;
>  	etmq->etm = etm;
>  	etmq->queue_nr = queue_nr;
>  	etmq->offset = 0;
>  
> -	if (etm->timeless_decoding)
> -		goto out;
> +	return 0;
> +}
> +
> +static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
> +					    struct cs_etm_queue *etmq,
> +					    unsigned int queue_nr)
> +{
> +	int ret = 0;
> +	unsigned int cs_queue_nr;
> +	u8 trace_chan_id;
> +	u64 cs_timestamp;
>  
>  	/*
>  	 * We are under a CPU-wide trace scenario.  As such we need to know
> @@ -2218,13 +2221,27 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>  static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
>  {
>  	int ret = 0;
> -	unsigned int cs_queue_nr, queue_nr;
> +	unsigned int cs_queue_nr, queue_nr, i;
>  	u8 trace_chan_id;
>  	u64 cs_timestamp;
>  	struct auxtrace_queue *queue;
>  	struct cs_etm_queue *etmq;
>  	struct cs_etm_traceid_queue *tidq;
>  
> +	/*
> +	 * Pre-populate the heap with one entry from each queue so that we can
> +	 * start processing in time order across all queues.
> +	 */
> +	for (i = 0; i < etm->queues.nr_queues; i++) {
> +		etmq = etm->queues.queue_array[i].priv;
> +		if (!etmq)
> +			continue;
> +
> +		ret = cs_etm__queue_first_cs_timestamp(etm, etmq, i);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	while (1) {
>  		if (!etm->heap.heap_cnt)
>  			goto out;
> -- 
> 2.28.0
> 
