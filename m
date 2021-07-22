Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4754C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA54560EE6
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 21:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhGVUUO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhGVUUO (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jul 2021 16:20:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A46E460EB5;
        Thu, 22 Jul 2021 21:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626987649;
        bh=lAP/pYgBUvFwv2o+B17C9qM7AFYaCQ7N2qkjjh82T+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPU7EksBYf91NuieodeCxZCV+IzLRCvrd/hUhHNKfn0mrSlztoc5DrXctSQOOmi/J
         V5TEMTILl7nmR/MtxWAP5jX9/lAfiya0hm81TXbje4nLg4FQW7rrVQLt16JDJnWyxu
         u3U8Tx83n7gxnUmb4yd1eEcyPAAkkz1FOsYm8hWIWUayPbK0Ndqg32yrmfPlJXWSY+
         FUk4grmMnxex9UA+Rnd1oju/yVgLyIZ5uFjEOu6FPpcwVAL0gaW7iYlyYy8cBKxof5
         IQ56iUgJ2MqokQTgZQdWKRUoZuHmquyo6Bbc63yhaTTGlrtrvibKjsFQfdzDTQYqRt
         TDNjR23AJoaBQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF6F1403F2; Thu, 22 Jul 2021 18:00:44 -0300 (-03)
Date:   Thu, 22 Jul 2021 18:00:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        leo.yan@linaro.org, al.grant@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] perf cs-etm: Pass unformatted flag to decoder
Message-ID: <YPncfIyzvzj4v/rx@kernel.org>
References: <20210721150202.32065-1-james.clark@arm.com>
 <20210721150202.32065-7-james.clark@arm.com>
 <20210721160523.GA2377909@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721160523.GA2377909@p14s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jul 21, 2021 at 10:05:23AM -0600, Mathieu Poirier escreveu:
> On Wed, Jul 21, 2021 at 04:02:02PM +0100, James Clark wrote:
> > The TRBE (Trace Buffer Extension) feature allows a separate trace buffer
> > for each trace source, therefore the trace wouldn't need to be
> > formatted. The driver was introduced in commit 3fbf7f011f24
> > ("coresight: sink: Add TRBE driver").
> > 
> > The formatted/unformatted mode is encoded in one of the flags of the
> > AUX record. The first AUX record encountered for each event is used to
> > determine the mode, and this will persist for the remaining trace that
> > is either decoded or dumped.
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  4 +-
> >  tools/perf/util/cs-etm.c                      | 53 ++++++++++++++-----
> >  2 files changed, 42 insertions(+), 15 deletions(-)
> > 
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Arnaldo, please consider adding this set to your tree.

Thanks, applied to perf/core.

- Arnaldo
 
> Thanks,
> Mathieu
> 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index ed1f0326f859..9c9039ae6989 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -687,7 +687,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
> >  }
> >  
> >  struct cs_etm_decoder *
> > -cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
> > +cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
> >  		    struct cs_etm_trace_params t_params[])
> >  {
> >  	struct cs_etm_decoder *decoder;
> > @@ -732,7 +732,7 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
> >  	/* init raw frame logging if required */
> >  	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
> >  
> > -	for (i = 0; i < num_cpu; i++) {
> > +	for (i = 0; i < decoders; i++) {
> >  		ret = cs_etm_decoder__create_etm_decoder(d_params,
> >  							 &t_params[i],
> >  							 decoder);
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 760050ea936d..f4b2bff533f3 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -461,13 +461,14 @@ static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
> >  }
> >  
> >  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
> > -				     struct cs_etm_auxtrace *etm)
> > +				     struct cs_etm_auxtrace *etm,
> > +				     int decoders)
> >  {
> >  	int i;
> >  	u32 etmidr;
> >  	u64 architecture;
> >  
> > -	for (i = 0; i < etm->num_cpu; i++) {
> > +	for (i = 0; i < decoders; i++) {
> >  		architecture = etm->metadata[i][CS_ETM_MAGIC];
> >  
> >  		switch (architecture) {
> > @@ -488,7 +489,8 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
> >  
> >  static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
> >  				       struct cs_etm_queue *etmq,
> > -				       enum cs_etm_decoder_operation mode)
> > +				       enum cs_etm_decoder_operation mode,
> > +				       bool formatted)
> >  {
> >  	int ret = -EINVAL;
> >  
> > @@ -498,7 +500,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
> >  	d_params->packet_printer = cs_etm__packet_dump;
> >  	d_params->operation = mode;
> >  	d_params->data = etmq;
> > -	d_params->formatted = true;
> > +	d_params->formatted = formatted;
> >  	d_params->fsyncs = false;
> >  	d_params->hsyncs = false;
> >  	d_params->frame_aligned = true;
> > @@ -720,11 +722,17 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
> >  	return len;
> >  }
> >  
> > -static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
> > +static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
> > +						bool formatted)
> >  {
> >  	struct cs_etm_decoder_params d_params;
> >  	struct cs_etm_trace_params  *t_params = NULL;
> >  	struct cs_etm_queue *etmq;
> > +	/*
> > +	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
> > +	 * needed.
> > +	 */
> > +	int decoders = formatted ? etm->num_cpu : 1;
> >  
> >  	etmq = zalloc(sizeof(*etmq));
> >  	if (!etmq)
> > @@ -735,21 +743,23 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
> >  		goto out_free;
> >  
> >  	/* Use metadata to fill in trace parameters for trace decoder */
> > -	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
> > +	t_params = zalloc(sizeof(*t_params) * decoders);
> >  
> >  	if (!t_params)
> >  		goto out_free;
> >  
> > -	if (cs_etm__init_trace_params(t_params, etm))
> > +	if (cs_etm__init_trace_params(t_params, etm, decoders))
> >  		goto out_free;
> >  
> >  	/* Set decoder parameters to decode trace packets */
> >  	if (cs_etm__init_decoder_params(&d_params, etmq,
> >  					dump_trace ? CS_ETM_OPERATION_PRINT :
> > -						     CS_ETM_OPERATION_DECODE))
> > +						     CS_ETM_OPERATION_DECODE,
> > +					formatted))
> >  		goto out_free;
> >  
> > -	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
> > +	etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
> > +					    t_params);
> >  
> >  	if (!etmq->decoder)
> >  		goto out_free;
> > @@ -777,14 +787,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
> >  
> >  static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
> >  			       struct auxtrace_queue *queue,
> > -			       unsigned int queue_nr)
> > +			       unsigned int queue_nr,
> > +			       bool formatted)
> >  {
> >  	struct cs_etm_queue *etmq = queue->priv;
> >  
> >  	if (list_empty(&queue->head) || etmq)
> >  		return 0;
> >  
> > -	etmq = cs_etm__alloc_queue(etm);
> > +	etmq = cs_etm__alloc_queue(etm, formatted);
> >  
> >  	if (!etmq)
> >  		return -ENOMEM;
> > @@ -2430,8 +2441,14 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
> >  		if (err)
> >  			return err;
> >  
> > +		/*
> > +		 * Knowing if the trace is formatted or not requires a lookup of
> > +		 * the aux record so only works in non-piped mode where data is
> > +		 * queued in cs_etm__queue_aux_records(). Always assume
> > +		 * formatted in piped mode (true).
> > +		 */
> >  		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> > -					  idx);
> > +					  idx, true);
> >  		if (err)
> >  			return err;
> >  
> > @@ -2678,6 +2695,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
> >  	union perf_event auxtrace_fragment;
> >  	__u64 aux_offset, aux_size;
> >  	__u32 idx;
> > +	bool formatted;
> >  
> >  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
> >  						   struct cs_etm_auxtrace,
> > @@ -2745,7 +2763,9 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
> >  			return err;
> >  
> >  		idx = auxtrace_event->idx;
> > -		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx);
> > +		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
> > +		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> > +					   idx, formatted);
> >  	}
> >  
> >  	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
> > @@ -3034,6 +3054,13 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >  		goto err_delete_thread;
> >  
> >  	etm->data_queued = etm->queues.populated;
> > +	/*
> > +	 * Print warning in pipe mode, see cs_etm__process_auxtrace_event() and
> > +	 * cs_etm__queue_aux_fragment() for details relating to limitations.
> > +	 */
> > +	if (!etm->data_queued)
> > +		pr_warning("CS ETM warning: Coresight decode and TRBE support requires random file access.\n"
> > +			   "Continuing with best effort decoding in piped mode.\n\n");
> >  
> >  	return 0;
> >  
> > -- 
> > 2.28.0
> > 

-- 

- Arnaldo
