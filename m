Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE29AC12002
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C69261175
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhGUITK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:19:10 -0400
Received: from foss.arm.com ([217.140.110.172]:48564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236024AbhGUHza (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 03:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 585421FB;
        Wed, 21 Jul 2021 01:35:57 -0700 (PDT)
Received: from [10.57.38.215] (unknown [10.57.38.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB5173F694;
        Wed, 21 Jul 2021 01:35:54 -0700 (PDT)
Subject: Re: [PATCH 6/6] perf cs-etm: Pass unformatted flag to decoder
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
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
References: <20210713154008.29656-1-james.clark@arm.com>
 <20210713154008.29656-7-james.clark@arm.com> <20210720154539.GC2296792@p14s>
From:   James Clark <james.clark@arm.com>
Message-ID: <2af8d1ee-6dd0-42b5-6882-2396df8c07bc@arm.com>
Date:   Wed, 21 Jul 2021 09:35:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210720154539.GC2296792@p14s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 20/07/2021 16:45, Mathieu Poirier wrote:
> On Tue, Jul 13, 2021 at 04:40:08PM +0100, James Clark wrote:
>> The TRBE (Trace Buffer Extension) feature allows a separate trace buffer
>> for each trace source, therefore the trace wouldn't need to be
>> formatted. The driver was introduced in commit 3fbf7f011f24
>> ("coresight: sink: Add TRBE driver").
>>
>> The formatted/unformatted mode is encoded in one of the flags of the
>> AUX record. The first AUX record encountered for each event is used to
>> determine the mode, and this will persist for the remaining trace that
>> is either decoded or dumped.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/util/cs-etm.c | 42 +++++++++++++++++++++++++++-------------
>>  1 file changed, 29 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 760050ea936d..62769a84a53f 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -461,13 +461,14 @@ static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
>>  }
>>  
>>  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>> -				     struct cs_etm_auxtrace *etm)
>> +				     struct cs_etm_auxtrace *etm,
>> +				     int decoders_per_cpu)
>>  {
>>  	int i;
>>  	u32 etmidr;
>>  	u64 architecture;
>>  
>> -	for (i = 0; i < etm->num_cpu; i++) {
>> +	for (i = 0; i < decoders_per_cpu; i++) {
>>  		architecture = etm->metadata[i][CS_ETM_MAGIC];
>>  
>>  		switch (architecture) {
>> @@ -488,7 +489,8 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>>  
>>  static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
>>  				       struct cs_etm_queue *etmq,
>> -				       enum cs_etm_decoder_operation mode)
>> +				       enum cs_etm_decoder_operation mode,
>> +				       bool formatted)
>>  {
>>  	int ret = -EINVAL;
>>  
>> @@ -498,7 +500,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
>>  	d_params->packet_printer = cs_etm__packet_dump;
>>  	d_params->operation = mode;
>>  	d_params->data = etmq;
>> -	d_params->formatted = true;
>> +	d_params->formatted = formatted;
>>  	d_params->fsyncs = false;
>>  	d_params->hsyncs = false;
>>  	d_params->frame_aligned = true;
>> @@ -720,11 +722,13 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>>  	return len;
>>  }
>>  
>> -static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>> +static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>> +						bool formatted)
>>  {
>>  	struct cs_etm_decoder_params d_params;
>>  	struct cs_etm_trace_params  *t_params = NULL;
>>  	struct cs_etm_queue *etmq;
>> +	int decoders_per_cpu = formatted ? etm->num_cpu : 1;
> 
> I really tripped on the name "decoders_per_cpu", to a point where I had to
> review the current code before looking at this patch.  I find the "_per_cpu"
> part especially puzzling.  In the end the variable determines the amount of
> decoders to instantiate for a specific queue...  
> 
> Couldn't it be just "decoders"?  Or maybe it just needs a little comment to
> disambiguate things?
> 

Yeah I think just decoders will be good if I add a comment explaining why there is
a difference with formatted vs unformatted. I will re-submit with the change.

Thanks for the reviews.

James

> Thanks,
> Mathieu
> 
>>  
>>  	etmq = zalloc(sizeof(*etmq));
>>  	if (!etmq)
>> @@ -735,21 +739,23 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>>  		goto out_free;
>>  
>>  	/* Use metadata to fill in trace parameters for trace decoder */
>> -	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
>> +	t_params = zalloc(sizeof(*t_params) * decoders_per_cpu);
>>  
>>  	if (!t_params)
>>  		goto out_free;
>>  
>> -	if (cs_etm__init_trace_params(t_params, etm))
>> +	if (cs_etm__init_trace_params(t_params, etm, decoders_per_cpu))
>>  		goto out_free;
>>  
>>  	/* Set decoder parameters to decode trace packets */
>>  	if (cs_etm__init_decoder_params(&d_params, etmq,
>>  					dump_trace ? CS_ETM_OPERATION_PRINT :
>> -						     CS_ETM_OPERATION_DECODE))
>> +						     CS_ETM_OPERATION_DECODE,
>> +					formatted))
>>  		goto out_free;
>>  
>> -	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
>> +	etmq->decoder = cs_etm_decoder__new(decoders_per_cpu, &d_params,
>> +					    t_params);
>>  
>>  	if (!etmq->decoder)
>>  		goto out_free;
>> @@ -777,14 +783,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>>  
>>  static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>>  			       struct auxtrace_queue *queue,
>> -			       unsigned int queue_nr)
>> +			       unsigned int queue_nr,
>> +			       bool formatted)
>>  {
>>  	struct cs_etm_queue *etmq = queue->priv;
>>  
>>  	if (list_empty(&queue->head) || etmq)
>>  		return 0;
>>  
>> -	etmq = cs_etm__alloc_queue(etm);
>> +	etmq = cs_etm__alloc_queue(etm, formatted);
>>  
>>  	if (!etmq)
>>  		return -ENOMEM;
>> @@ -2430,8 +2437,14 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>>  		if (err)
>>  			return err;
>>  
>> +		/*
>> +		 * Knowing if the trace is formatted or not requires a lookup of
>> +		 * the aux record so only works in non-piped mode where data is
>> +		 * queued in cs_etm__queue_aux_records(). Always assume
>> +		 * formatted in piped mode (true).
>> +		 */
>>  		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
>> -					  idx);
>> +					  idx, true);
>>  		if (err)
>>  			return err;
>>  
>> @@ -2678,6 +2691,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>>  	union perf_event auxtrace_fragment;
>>  	__u64 aux_offset, aux_size;
>>  	__u32 idx;
>> +	bool formatted;
>>  
>>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>>  						   struct cs_etm_auxtrace,
>> @@ -2745,7 +2759,9 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>>  			return err;
>>  
>>  		idx = auxtrace_event->idx;
>> -		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx);
>> +		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
>> +		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
>> +					   idx, formatted);
>>  	}
>>  
>>  	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
>> -- 
>> 2.28.0
>>
