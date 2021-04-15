Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381DAC433B4
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Apr 2021 19:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11BCE61152
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Apr 2021 19:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDOTqh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhDOTqh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Apr 2021 15:46:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D06DC061574
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Apr 2021 12:46:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d8so12669700plh.11
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Apr 2021 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8WAGqUBfUJd0GpkZy+V6HKttSzokJe0JTSsCCuwPkHs=;
        b=R9zO9CKatW4qEMyRCYmo68RFsV0BTE1LqbAKLqaH0XeCALgGacLHKjGUSjVwv5LaeN
         cJzNFBVLJnM5ZuWxujf6K+6L05hyRE4K8vxerDxPfYL5i/0ztY/DAZSw0z7DDvwwD9Wq
         XCHa4EJpKKM8NfG2P7qrKi1ZxkCDmFFho2APMNdeNN3MGeGY+vJVeZZ/Intydxk93qgw
         6bY5ICvaAb4mBX1JsAV8g3szPLZRsZ4p1yozWLUcV+ECmMsMF6uuhIRyPhbDtOFaTFmg
         F1IL1Cbfv12+X11hJdncqujCRIiBWBi9JvtrWwwLglLnrUYAXjiwOCQBn43nvtQ2o/oX
         XK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8WAGqUBfUJd0GpkZy+V6HKttSzokJe0JTSsCCuwPkHs=;
        b=aZ8DVuZUNXcaZAMQxrP4tP/XQUuTRYueBmgDDKos8t9c5jP6Ph6JGJi2M9QRUXCjS2
         XH4rvTgPDSh9CQnfw0+xvP8fbJn3Gthuw8rqKFZARqbW0gCNOLy9ClFp6bmAPqT+he5F
         yDxC7Ex7OB/aXEzOtwuZzzVc3S8oqwCegSvWNPKa1mIpodART/3JlPpsn6aprUBj7IsM
         siUz7dRG69vcCFLiMLdLr4qZ3OoUIUXSndW0FSTLql65F7lGfLNvLJr1mDs1RVnhMi05
         VNnsD601tFgbOuW2i6SiADiAMeR8UutCe91Eu2v446yr5Qgc7emVAcV7VnB2FNRCz5gv
         fQzw==
X-Gm-Message-State: AOAM531mRmo936BHSlNVrpAqCAlCFonDehIPc7S//DTyrNFOcGVWJ0wS
        netxHNl5SiI6A9cvikNz7dWxZq6v2rem5w==
X-Google-Smtp-Source: ABdhPJxaH8ErDb0p/p+tIWUtMEHyLhQnBHGq/ilbtbPED2/lndGn/toYWOKjyvPi38iI2Q//WNF5XQ==
X-Received: by 2002:a17:90a:e512:: with SMTP id t18mr3403059pjy.34.1618515971633;
        Thu, 15 Apr 2021 12:46:11 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g14sm3148152pjh.28.2021.04.15.12.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 12:46:10 -0700 (PDT)
Date:   Thu, 15 Apr 2021 13:46:08 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf cs-etm: Refactor timestamp variable names
Message-ID: <20210415194608.GA937505@xps15>
References: <20210414143919.12605-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414143919.12605-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 14, 2021 at 05:39:18PM +0300, James Clark wrote:
> Remove ambiguity in variable names relating to timestamps.
> A later commit will save the sample kernel timestamp in one
> of the etm structs, so name all elements appropriately to
> avoid confusion.
> 
> This is also removes some ambiguity arising from the fact
> that the --timestamp argument to perf record refers to
> sample kernel timestamps, and the /timestamp/ event modifier
> refers to etm timestamps, so the term is overloaded.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 ++++----
>  tools/perf/util/cs-etm.c                      | 42 +++++++++----------
>  tools/perf/util/cs-etm.h                      |  4 +-
>  3 files changed, 31 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 059bcec3f651..055cb93eca59 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -276,13 +276,13 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
>  				  const uint8_t trace_chan_id)
>  {
>  	/* No timestamp packet has been received, nothing to do */
> -	if (!packet_queue->timestamp)
> +	if (!packet_queue->etm_timestamp)
>  		return OCSD_RESP_CONT;
>  
> -	packet_queue->timestamp = packet_queue->next_timestamp;
> +	packet_queue->etm_timestamp = packet_queue->next_etm_timestamp;
>  
>  	/* Estimate the timestamp for the next range packet */
> -	packet_queue->next_timestamp += packet_queue->instr_count;
> +	packet_queue->next_etm_timestamp += packet_queue->instr_count;
>  	packet_queue->instr_count = 0;
>  
>  	/* Tell the front end which traceid_queue needs attention */
> @@ -308,8 +308,8 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  	 * Function do_soft_timestamp() will report the value to the front end,
>  	 * hence asking the decoder to keep decoding rather than stopping.
>  	 */
> -	if (packet_queue->timestamp) {
> -		packet_queue->next_timestamp = elem->timestamp;
> +	if (packet_queue->etm_timestamp) {
> +		packet_queue->next_etm_timestamp = elem->timestamp;
>  		return OCSD_RESP_CONT;
>  	}
>  
> @@ -320,8 +320,8 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  	 * which instructions started by subtracting the number of instructions
>  	 * executed to the timestamp.
>  	 */
> -	packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
> -	packet_queue->next_timestamp = elem->timestamp;
> +	packet_queue->etm_timestamp = elem->timestamp - packet_queue->instr_count;
> +	packet_queue->next_etm_timestamp = elem->timestamp;
>  	packet_queue->instr_count = 0;
>  
>  	/* Tell the front end which traceid_queue needs attention */
> @@ -334,8 +334,8 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  static void
>  cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
>  {
> -	packet_queue->timestamp = 0;
> -	packet_queue->next_timestamp = 0;
> +	packet_queue->etm_timestamp = 0;
> +	packet_queue->next_etm_timestamp = 0;
>  	packet_queue->instr_count = 0;
>  }
>  
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 7e63e7dedc33..c25da2ffa8f3 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -38,8 +38,6 @@
>  #include <tools/libc_compat.h>
>  #include "util/synthetic-events.h"
>  
> -#define MAX_TIMESTAMP (~0ULL)
> -
>  struct cs_etm_auxtrace {
>  	struct auxtrace auxtrace;
>  	struct auxtrace_queues queues;
> @@ -86,7 +84,7 @@ struct cs_etm_queue {
>  	struct cs_etm_decoder *decoder;
>  	struct auxtrace_buffer *buffer;
>  	unsigned int queue_nr;
> -	u8 pending_timestamp;
> +	u8 pending_timestamp_chan_id;
>  	u64 offset;
>  	const unsigned char *buf;
>  	size_t buf_len, buf_used;
> @@ -208,7 +206,7 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
>  	 * be more than one channel per cs_etm_queue, we need to specify
>  	 * what traceID queue needs servicing.
>  	 */
> -	etmq->pending_timestamp = trace_chan_id;
> +	etmq->pending_timestamp_chan_id = trace_chan_id;
>  }
>  
>  static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
> @@ -216,22 +214,22 @@ static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
>  {
>  	struct cs_etm_packet_queue *packet_queue;
>  
> -	if (!etmq->pending_timestamp)
> +	if (!etmq->pending_timestamp_chan_id)
>  		return 0;
>  
>  	if (trace_chan_id)
> -		*trace_chan_id = etmq->pending_timestamp;
> +		*trace_chan_id = etmq->pending_timestamp_chan_id;
>  
>  	packet_queue = cs_etm__etmq_get_packet_queue(etmq,
> -						     etmq->pending_timestamp);
> +						     etmq->pending_timestamp_chan_id);
>  	if (!packet_queue)
>  		return 0;
>  
>  	/* Acknowledge pending status */
> -	etmq->pending_timestamp = 0;
> +	etmq->pending_timestamp_chan_id = 0;
>  
>  	/* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
> -	return packet_queue->timestamp;
> +	return packet_queue->etm_timestamp;
>  }
>  
>  static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
> @@ -814,7 +812,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  	int ret = 0;
>  	unsigned int cs_queue_nr;
>  	u8 trace_chan_id;
> -	u64 timestamp;
> +	u64 etm_timestamp;
>  	struct cs_etm_queue *etmq = queue->priv;
>  
>  	if (list_empty(&queue->head) || etmq)
> @@ -854,7 +852,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  
>  		/*
>  		 * Run decoder on the trace block.  The decoder will stop when
> -		 * encountering a timestamp, a full packet queue or the end of
> +		 * encountering an ETM timestamp, a full packet queue or the end of
>  		 * trace for that block.
>  		 */
>  		ret = cs_etm__decode_data_block(etmq);
> @@ -865,10 +863,10 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  		 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
>  		 * the timestamp calculation for us.
>  		 */
> -		timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
> +		etm_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
>  
>  		/* We found a timestamp, no need to continue. */
> -		if (timestamp)
> +		if (etm_timestamp)
>  			break;
>  
>  		/*
> @@ -892,7 +890,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  	 * queue and will be processed in cs_etm__process_queues().
>  	 */
>  	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
> -	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
> +	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, etm_timestamp);
>  out:
>  	return ret;
>  }
> @@ -2221,7 +2219,7 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
>  	int ret = 0;
>  	unsigned int cs_queue_nr, queue_nr;
>  	u8 trace_chan_id;
> -	u64 timestamp;
> +	u64 etm_timestamp;
>  	struct auxtrace_queue *queue;
>  	struct cs_etm_queue *etmq;
>  	struct cs_etm_traceid_queue *tidq;
> @@ -2283,9 +2281,9 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
>  		if (ret)
>  			goto out;
>  
> -		timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
> +		etm_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
>  
> -		if (!timestamp) {
> +		if (!etm_timestamp) {
>  			/*
>  			 * Function cs_etm__decode_data_block() returns when
>  			 * there is no more traces to decode in the current
> @@ -2308,7 +2306,7 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
>  		 * this queue/traceID.
>  		 */
>  		cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
> -		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
> +		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, etm_timestamp);
>  	}
>  
>  out:
> @@ -2380,7 +2378,7 @@ static int cs_etm__process_event(struct perf_session *session,
>  				 struct perf_tool *tool)
>  {
>  	int err = 0;
> -	u64 timestamp;
> +	u64 sample_kernel_timestamp;
>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
>  						   auxtrace);
> @@ -2394,11 +2392,11 @@ static int cs_etm__process_event(struct perf_session *session,
>  	}
>  
>  	if (sample->time && (sample->time != (u64) -1))
> -		timestamp = sample->time;
> +		sample_kernel_timestamp = sample->time;
>  	else
> -		timestamp = 0;
> +		sample_kernel_timestamp = 0;
>  
> -	if (timestamp || etm->timeless_decoding) {
> +	if (sample_kernel_timestamp || etm->timeless_decoding) {
>  		err = cs_etm__update_queues(etm);
>  		if (err)
>  			return err;
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 36428918411e..b300f6fa19cc 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -171,8 +171,8 @@ struct cs_etm_packet_queue {
>  	u32 head;
>  	u32 tail;
>  	u32 instr_count;
> -	u64 timestamp;
> -	u64 next_timestamp;
> +	u64 etm_timestamp;
> +	u64 next_etm_timestamp;

I find the "etm" part confusing since timestamps are generated by a specific CS
component, not the ETM itself.  As such I think it should be "cs_timestamp" and
"next_cs_timestamp".  But this is just a naming convention and won't press the
case further if you feel strongly about it.

Otherwise I think this renaming exercise is worth it.  

With or without the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	struct cs_etm_packet packet_buffer[CS_ETM_PACKET_MAX_BUFFER];
>  };
>  
> -- 
> 2.28.0
> 
