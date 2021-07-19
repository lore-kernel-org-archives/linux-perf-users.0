Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1650BC12002
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA17D61181
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349260AbhGSWgD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385442AbhGSTAg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 15:00:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5DBC0613EF
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jul 2021 12:31:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so760482pjo.3
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jul 2021 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3fQ0/8opxa5eTEpUI81rDdB2xwZHkoVdhIb6AztpE4o=;
        b=Ez8/M1Y8KoeVMRupkhnhEhqxtXH8Fobthjhr3wkjHPeZTaDyqU9MXjZUblW2CnVe5k
         rxFWF/uNAcvR/IWviLOUb7K1OlkWcJJ36m+iHElBbqjN7MVi+tJHFKwlZ39jxr1EaaAi
         4+8mEyWGmMcfvppmI+YsgIwM/hy+3eaRwbrpPqQ4T+iRTjOwWS5JL/vULaanpH3QxUrJ
         jV9FdJFl8rohb1n1/d7KGw3qrXXeC2zzAqLt+ihq+F9T3z6FRK1c6BQXELfyRMkeLD4K
         DeKP7SyO2ZhYEJ+VSnWqRnnON0y8pnYZxd/8d2qvjGB/29LHRLOtLTo+gYyglmvbXWrW
         AVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3fQ0/8opxa5eTEpUI81rDdB2xwZHkoVdhIb6AztpE4o=;
        b=kyrjXrg1VnVchWeOCiFjWPhueApZJRCxK2bJVuliLL74HIb9DlxFmTXEEpxo1sb9rG
         DgWVM4VnCrH6DPrpp/pXz47dA6XwkE1IArWtuttRxzoJXTquPDjByZTCtnJTvZWdrgos
         acSqH+bFYnLEjQY/svoBlAkG588SWxpdRkBQ15sq7Tp5wMO8s/2E4WnHh8BJ2q8O+6z+
         ABu7Te5fprsQQb6lBYu6QoY0Bnd7l1WYY9tJrohikMnF5dVWFhCGs2UiKqfoxCUMyehw
         5L10RGzHbpKJswfSZoiFYuc/l62cSvfHoLTearRO7NSsp7xgkce+1WULPqrqlBRx6dL3
         G2NA==
X-Gm-Message-State: AOAM531SxL6J5OgNWOCXFMxuZyM82+WvTsXjOg1AgZpDiGuJpH4+EEY6
        E/ubwpv/hG4lDhgAi7t9MfhP0w==
X-Google-Smtp-Source: ABdhPJxeDiRxmPFQO7MkbukI7BzskK2Pl8HItF6a69T2Ie5YyAJ71yF2ngNEYNiGBz3GupXPzO5YyQ==
X-Received: by 2002:a17:902:bd02:b029:12b:1c90:eb65 with SMTP id p2-20020a170902bd02b029012b1c90eb65mr20457139pls.81.1626723536616;
        Mon, 19 Jul 2021 12:38:56 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n14sm22080043pfq.177.2021.07.19.12.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:38:55 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:38:53 -0600
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
Subject: Re: [PATCH 3/6] perf cs-etm: Only setup queues when they are modified
Message-ID: <20210719193853.GD2255168@p14s>
References: <20210713154008.29656-1-james.clark@arm.com>
 <20210713154008.29656-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713154008.29656-4-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 13, 2021 at 04:40:05PM +0100, James Clark wrote:
> Continually creating queues in cs_etm__process_event() is unnecessary.
> They only need to be created when a buffer for a new CPU or thread is
> encountered. This can be in two places, when building the queues in
> advance in cs_etm__process_auxtrace_info(), or in
> cs_etm__process_auxtrace_event() when data_queued is false and the
> index wasn't available (pipe mode).
> 
> This change will allow the 'formatted' decoder setting to applied when
> iterating over aux records in a later commit.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 54 +++++++++++-----------------------------
>  1 file changed, 14 insertions(+), 40 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 426e99c07ca9..2d07e52ffd3c 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -96,7 +96,6 @@ struct cs_etm_queue {
>  /* RB tree for quick conversion between traceID and metadata pointers */
>  static struct intlist *traceid_list;
>  
> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
>  static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
>  static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>  					   pid_t tid);
> @@ -564,7 +563,6 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
>  static int cs_etm__flush_events(struct perf_session *session,
>  				struct perf_tool *tool)
>  {
> -	int ret;
>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
>  						   auxtrace);
> @@ -574,11 +572,6 @@ static int cs_etm__flush_events(struct perf_session *session,
>  	if (!tool->ordered_events)
>  		return -EINVAL;
>  
> -	ret = cs_etm__update_queues(etm);
> -
> -	if (ret < 0)
> -		return ret;
> -
>  	if (etm->timeless_decoding)
>  		return cs_etm__process_timeless_queues(etm, -1);
>  
> @@ -898,30 +891,6 @@ static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
>  	return ret;
>  }
>  
> -static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
> -{
> -	unsigned int i;
> -	int ret;
> -
> -	for (i = 0; i < etm->queues.nr_queues; i++) {
> -		ret = cs_etm__setup_queue(etm, &etm->queues.queue_array[i], i);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
> -{
> -	if (etm->queues.new_data) {
> -		etm->queues.new_data = false;
> -		return cs_etm__setup_queues(etm);
> -	}
> -
> -	return 0;
> -}
> -
>  static inline
>  void cs_etm__copy_last_branch_rb(struct cs_etm_queue *etmq,
>  				 struct cs_etm_traceid_queue *tidq)
> @@ -2395,7 +2364,6 @@ static int cs_etm__process_event(struct perf_session *session,
>  				 struct perf_sample *sample,
>  				 struct perf_tool *tool)
>  {
> -	int err = 0;
>  	u64 sample_kernel_timestamp;
>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
> @@ -2414,12 +2382,6 @@ static int cs_etm__process_event(struct perf_session *session,
>  	else
>  		sample_kernel_timestamp = 0;
>  
> -	if (sample_kernel_timestamp || etm->timeless_decoding) {
> -		err = cs_etm__update_queues(etm);
> -		if (err)
> -			return err;
> -	}
> -
>  	/*
>  	 * Don't wait for cs_etm__flush_events() in per-thread/timeless mode to start the decode. We
>  	 * need the tid of the PERF_RECORD_EXIT event to assign to the synthesised samples because
> @@ -2476,6 +2438,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>  		int fd = perf_data__fd(session->data);
>  		bool is_pipe = perf_data__is_pipe(session->data);
>  		int err;
> +		int idx = event->auxtrace.idx;
>  
>  		if (is_pipe)
>  			data_offset = 0;
> @@ -2490,6 +2453,11 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>  		if (err)
>  			return err;
>  
> +		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> +					  idx);
> +		if (err)
> +			return err;
> +
>  		if (dump_trace)
>  			if (auxtrace_buffer__get_data(buffer, fd)) {
>  				cs_etm__dump_event(etm, buffer);
> @@ -2732,6 +2700,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  	struct perf_record_auxtrace *auxtrace_event;
>  	union perf_event auxtrace_fragment;
>  	__u64 aux_offset, aux_size;
> +	__u32 idx;
>  
>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
> @@ -2793,8 +2762,13 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  
>  		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64
>  			  " tid: %d cpu: %d\n", aux_size, aux_offset, sample->tid, sample->cpu);
> -		return auxtrace_queues__add_event(&etm->queues, session, &auxtrace_fragment,
> -						  file_offset, NULL);
> +		err = auxtrace_queues__add_event(&etm->queues, session, &auxtrace_fragment,
> +						 file_offset, NULL);
> +		if (err)
> +			return err;
> +
> +		idx = auxtrace_event->idx;
> +		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx);
>  	}
>  
>  	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
> -- 
> 2.28.0
> 
