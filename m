Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6DEC07E99
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 19:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD67D6141C
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 19:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhGETfv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhGETfv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jul 2021 15:35:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22C0C06175F
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jul 2021 12:33:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b12so16340794pfv.6
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jul 2021 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h01DpQmQe3AGp2rR0t6ymbwO2OdYFxzBhqKGMkgfoVM=;
        b=Mqg0UmoK8R/RMe0ChEQ1SHR/qQXn6yX26NEKytKpfMXK5ivV98jzcTicFrtAjBrvDU
         HSFqKp1COyoIOv4bcPn/Y/sCl06jkPXohcv/r76YUVgcRA/xJQthphBYBcSAPp+pBNkk
         VKXnAoUdSXyVtdN3+kjNMiaPcJq22ozL3ECb5gE5k8cQc6rdnPM4flE7XQ81iF3sl9fD
         KJNKbN9FY4WbEFCCpK0LFSZQ0y0sEaxv1oB0GPW/eb9m82eQkzJlhvagcbLLat5C2vRg
         mjyMNktlvDwWy/zLj0Pdz4Idf2/BYQ6M/jCXV0aPceuxlG/JAgh7KxYGKmmiRBZGfODg
         mxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h01DpQmQe3AGp2rR0t6ymbwO2OdYFxzBhqKGMkgfoVM=;
        b=p9DHCW6qfsML3dkiPzW/BgUmCowUKTOJJqc6umODUsoehzQEaRpeGjWt7IHlGD2sOx
         NRCTaYsIdu5khSS0ISzf5/GGcwMrGnEIXPAXR+lso2QiJpcWBky5qnOSakScej8s0WHY
         5JZvlKPTangruBo7ZqfoAw0cJmlsc0eUGOkcawpBOnGTO7SqfIxwjEzVXfF2QckNHJ0K
         CO7BGfiCPJgXcDKAvNzrauVX0uqFKvC21cAiFtwbdCF0jMkQc82wNCN3J7VjdLnhulti
         uNM2g2xkuM+mt2T2CJEDpow7tFcpg/JHgWAh70ZP6qXf16HOefCsMhYz8TnxBoDWxQGE
         0nkg==
X-Gm-Message-State: AOAM530rXW+wmB75yyH8AfchCiQ8wMMLKxCCw0QZI48FNulgy5CpqPLM
        pn25wTntnYMycENt0XkGH9179w==
X-Google-Smtp-Source: ABdhPJz/FX+OJ76e080DdzfjOB/6kUC4I6qkdWbCHXNDQqrp5qxNs8JYN5SUalsAyKsGAwIToREMMA==
X-Received: by 2002:a63:f009:: with SMTP id k9mr17165015pgh.356.1625513592318;
        Mon, 05 Jul 2021 12:33:12 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p38sm12856800pfh.151.2021.07.05.12.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 12:33:11 -0700 (PDT)
Date:   Mon, 5 Jul 2021 13:33:09 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, coresight@lists.linaro.org, leo.yan@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] perf cs-etm: Split Coresight decode by aux records
Message-ID: <20210705193309.GA1493103@p14s>
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624164303.28632-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 24, 2021 at 05:43:02PM +0100, James Clark wrote:
> Populate the auxtrace queues using AUX records rather than whole
> auxtrace buffers so that the decoder is reset between each aux record.
> 
> This is similar to the auxtrace_queues__process_index() ->
> auxtrace_queues__add_indexed_event() flow where
> perf_session__peek_event() is used to read AUXTRACE events out of
> random positions in the file based on the auxtrace index. But now we
> loop over all PERF_RECORD_AUX events instead of AUXTRACE buffers. For
> each PERF_RECORD_AUX event, we find the corresponding AUXTRACE buffer
> using the index, and add a fragment of that buffer to the auxtrace
> queues. No other changes to decoding were made, apart from populating
> the auxtrace queues. The result of decoding is identical to before,
> except in cases where decoding failed completely, due to not resetting
> the decoder.
> 
> The reason for this change is because AUX records are emitted any time
> tracing is disabled, for example when the process is scheduled out.
> Because ETM was disabled and enabled again, the decoder also needs to
> be reset to force the search for a sync packet. Otherwise there would
> be fatal decoding errors.
> 
> Testing
> =======
> 
> Testing was done with the following script, to diff the decoding results
> between the patched and un-patched versions of perf:
> 
> 	#!/bin/bash
> 	set -ex
> 
> 	$1 script -i $3 $4 > split.script
> 	$2 script -i $3 $4 > default.script
> 
> 	diff split.script default.script | head -n 20
> 
> And it was run like this, with various itrace options depending on the
> quantity of synthesised events:
> 
> 	compare.sh ./perf-patched ./perf-default perf-per-cpu-2-threads.data --itrace=i100000ns
> 
> No changes in output were observed in the following scenarios:
> 
> * Simple per-cpu
> 	perf record -e cs_etm/@tmc_etr0/u top
> 
> * Per-thread, single thread
> 	perf record -e cs_etm/@tmc_etr0/u --per-thread ./threads_C
> 
> * Per-thread multiple threads (but only one thread collected data):
> 	perf record -e cs_etm/@tmc_etr0/u --per-thread --pid 4596,4597
> 
> * Per-thread multiple threads (both threads collected data):
> 	perf record -e cs_etm/@tmc_etr0/u --per-thread --pid 4596,4597
> 
> * Per-cpu explicit threads:
> 	perf record -e cs_etm/@tmc_etr0/u --pid 853,854
> 
> * System-wide (per-cpu):
>     perf record -e cs_etm/@tmc_etr0/u -a
> 
> * No data collected (no aux buffers)
> 	Can happen with any command when run for a short period
> 
> * Containing truncated records
> 	Can happen with any command
> 
> * Containing aux records with 0 size
> 	Can happen with any command
> 
> * Snapshot mode (various files with and without buffer wrap)
> 	perf record -e cs_etm/@tmc_etr0/u -a --snapshot
> 
> Some differences were observed in the following scenario:
> 
> * Snapshot mode (with duplicate buffers)
> 	perf record -e cs_etm/@tmc_etr0/u -a --snapshot
> 
> Fewer samples are generated in snapshot mode if duplicate buffers
> were gathered because buffers with the same offset are now only added
> once. This gives different, but more correct results and no duplicate
> data is decoded any more.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 168 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 167 insertions(+), 1 deletion(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 64536a6ed10a..88e8122f73c9 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2679,6 +2679,172 @@ static u64 *cs_etm__create_meta_blk(u64 *buff_in, int *buff_in_offset,
>  	return metadata;
>  }
>  
> +/**
> + * Puts a fragment of an auxtrace buffer into the auxtrace queues based
> + * on the bounds of aux_event, if it matches with the buffer that's at
> + * file_offset.
> + *
> + * Normally, whole auxtrace buffers would be added to the queue. But we
> + * want to reset the decoder for every PERF_RECORD_AUX event, and the decoder
> + * is reset across each buffer, so splitting the buffers up in advance has
> + * the same effect.
> + */
> +static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_offset, size_t sz,
> +				      struct perf_record_aux *aux_event, struct perf_sample *sample)
> +{
> +	int err;
> +	char buf[PERF_SAMPLE_MAX_SIZE];
> +	union perf_event *auxtrace_event_union;
> +	struct perf_record_auxtrace *auxtrace_event;
> +	union perf_event auxtrace_fragment;
> +	__u64 aux_offset, aux_size;
> +
> +	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
> +						   struct cs_etm_auxtrace,
> +						   auxtrace);
> +
> +	/*
> +	 * There should be a PERF_RECORD_AUXTRACE event at the file_offset that we got
> +	 * from looping through the auxtrace index.
> +	 */
> +	err = perf_session__peek_event(session, file_offset, buf,
> +				       PERF_SAMPLE_MAX_SIZE, &auxtrace_event_union, NULL);
> +	if (err)
> +		return err;
> +	auxtrace_event = &auxtrace_event_union->auxtrace;
> +	if (auxtrace_event->header.type != PERF_RECORD_AUXTRACE)
> +		return -EINVAL;
> +
> +	if (auxtrace_event->header.size < sizeof(struct perf_record_auxtrace) ||
> +		auxtrace_event->header.size != sz) {
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * In per-thread mode, CPU is set to -1, but TID will be set instead. See
> +	 * auxtrace_mmap_params__set_idx(). Return 'not found' if neither CPU nor TID match.
> +	 */
> +	if ((auxtrace_event->cpu == (__u32) -1 && auxtrace_event->tid != sample->tid) ||
> +			auxtrace_event->cpu != sample->cpu)
> +		return 1;
> +
> +	if (aux_event->flags & PERF_AUX_FLAG_OVERWRITE) {
> +		/*
> +		 * Clamp size in snapshot mode. The buffer size is clamped in
> +		 * __auxtrace_mmap__read() for snapshots, so the aux record size doesn't reflect
> +		 * the buffer size.
> +		 */
> +		aux_size = min(aux_event->aux_size, auxtrace_event->size);
> +
> +		/*
> +		 * In this mode, the head also points to the end of the buffer so aux_offset
> +		 * needs to have the size subtracted so it points to the beginning as in normal mode
> +		 */
> +		aux_offset = aux_event->aux_offset - aux_size;
> +	} else {
> +		aux_size = aux_event->aux_size;
> +		aux_offset = aux_event->aux_offset;
> +	}
> +
> +	if (aux_offset >= auxtrace_event->offset &&
> +	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
> +		/*
> +		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
> +		 * based on the sizes of the aux event, and queue that fragment.
> +		 */
> +		auxtrace_fragment.auxtrace = *auxtrace_event;
> +		auxtrace_fragment.auxtrace.size = aux_size;
> +		auxtrace_fragment.auxtrace.offset = aux_offset;
> +		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
> +
> +		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64
> +			  " tid: %d cpu: %d\n", aux_size, aux_offset, sample->tid, sample->cpu);
> +		return auxtrace_queues__add_event(&etm->queues, session, &auxtrace_fragment,
> +						  file_offset, NULL);
> +	}
> +
> +	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
> +	return 1;
> +}
> +
> +static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf_event *event,
> +					u64 offset __maybe_unused, void *data __maybe_unused)
> +{
> +	struct perf_sample sample;
> +	int ret;
> +	struct auxtrace_index_entry *ent;
> +	struct auxtrace_index *auxtrace_index;
> +	struct evsel *evsel;
> +	size_t i;
> +
> +	/* Don't care about any other events, we're only queuing buffers for AUX events */
> +	if (event->header.type != PERF_RECORD_AUX)
> +		return 0;
> +
> +	if (event->header.size < sizeof(struct perf_record_aux))
> +		return -EINVAL;
> +
> +	/* Truncated Aux records can have 0 size and shouldn't result in anything being queued. */
> +	if (!event->aux.aux_size)
> +		return 0;
> +
> +	/*
> +	 * Parse the sample, we need the sample_id_all data that comes after the event so that the
> +	 * CPU or PID can be matched to an AUXTRACE buffer's CPU or PID.
> +	 */
> +	evsel = evlist__event2evsel(session->evlist, event);
> +	if (!evsel)
> +		return -EINVAL;
> +	ret = evsel__parse_sample(evsel, event, &sample);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Loop through the auxtrace index to find the buffer that matches up with this aux event.
> +	 */
> +	list_for_each_entry(auxtrace_index, &session->auxtrace_index, list) {
> +		for (i = 0; i < auxtrace_index->nr; i++) {
> +			ent = &auxtrace_index->entries[i];
> +			ret = cs_etm__queue_aux_fragment(session, ent->file_offset,
> +							 ent->sz, &event->aux, &sample);
> +			/*
> +			 * Stop search on error or successful values. Continue search on
> +			 * 1 ('not found')
> +			 */
> +			if (ret != 1)
> +				return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Couldn't find the buffer corresponding to this aux record, something went wrong. Warn but
> +	 * don't exit with an error because it will still be possible to decode other aux records.
> +	 */
> +	pr_err("CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
> +	       " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
> +	return 0;
> +}
> +
> +static int cs_etm__queue_aux_records(struct perf_session *session)
> +{
> +	struct auxtrace_index *index = list_first_entry_or_null(&session->auxtrace_index,
> +								struct auxtrace_index, list);
> +	if (index && index->nr > 0)
> +		return perf_session__peek_events(session, session->header.data_offset,
> +						 session->header.data_size,
> +						 cs_etm__queue_aux_records_cb, NULL);
> +
> +	/*
> +	 * We would get here if there are no entries in the index (either no auxtrace
> +	 * buffers or no index at all). Fail silently as there is the possibility of
> +	 * queueing them in cs_etm__process_auxtrace_event() if etm->data_queued is still
> +	 * false.
> +	 *
> +	 * In that scenario, buffers will not be split by AUX records.
> +	 */
> +	return 0;
> +}
> +
>  int cs_etm__process_auxtrace_info(union perf_event *event,
>  				  struct perf_session *session)
>  {
> @@ -2879,7 +3045,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	if (err)
>  		goto err_delete_thread;
>  
> -	err = auxtrace_queues__process_index(&etm->queues, session);
> +	err = cs_etm__queue_aux_records(session);
>  	if (err)
>  		goto err_delete_thread;
>  
> -- 
> 2.28.0
> 
