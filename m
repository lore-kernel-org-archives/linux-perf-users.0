Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101F2C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Nov 2021 07:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbhKYIBu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346111AbhKYH7t (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Nov 2021 02:59:49 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BC4C061748
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Nov 2021 23:54:09 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i12so5166919pfd.6
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Nov 2021 23:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Wv822/jiFy6kR7lmixyoAId5E8/Qt673Ad/6b/9Axc=;
        b=EyBk6nqeZEB4YkZczQkzU0lrvLC3eGGModtukK2alJlo+0jTFZ4Nt7pIqB6ALbzxf9
         tXJ/C0/6s6CO/HuuKBwTKG6BLEaPJ2vstMIXSpcCfl1HKvc3915ObU4lEmkZ3qOvaMK7
         FWpTSYrQB3n74QRBzmT39CH/gJ0lH1nkpMZR53mvPZ0BBUnQ5w05St7l01VeU2y7MUiJ
         CXEi7659N+6GyeJjScXO2/W2kAmVUMfVBMzGuRnCAikp1xIZufB3bcDeVUHfm+PjA9BL
         CMb1GC6hXC0ZIjrVLfsy7pJ/yM8bJeoUpsMjA7/IgyEaR0u07ISE5wxWdh3VRPUfN1b4
         wTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Wv822/jiFy6kR7lmixyoAId5E8/Qt673Ad/6b/9Axc=;
        b=EiA9Jk6AFkFstyMcQh+hKoY45aNFsh9xQj+RDw7nPdGPuCMmhW+MnsQl2Y5Y0luGS5
         fSUeGOxjykg0LUODIMVHqWjh7rx4PnuuCFaOrRenwWuyV7hdNfzuT/VKb6/4vzg6fBkm
         4Q5EFUI4moSVJczh59tEAKSJcCPPoX4pY8jtP31k6JEDsxL6tn5uHs9N192Gr86jqmSi
         qnYJHEtppvtIqak/ANCh7pwl39cbaIRoYfQeu6KoVgFIgwsLmbAGWfG/fU6ULguDw0mL
         MEjzn3zxM93wb004r83Q6XVzc3J8pOS6LtpAjX4mmtIEGLdlHWrE9J4OfeDF/Vh2dy8V
         GnbQ==
X-Gm-Message-State: AOAM530fE32/D47zo6I5LwhKCFZmovMTVddMjRQw7gp8Uiu5GcDpGCOU
        xf9IxjBXj4Bd5e4gx9a2syaLgQ==
X-Google-Smtp-Source: ABdhPJweeLGCcXw+DnNYd9KB0VW0F5kTCBoJcSRTiIoppce2exLhlc8gTsBBmnp7rSRmlhO1W+UdLQ==
X-Received: by 2002:a05:6a00:2391:b0:4a2:cb64:2e43 with SMTP id f17-20020a056a00239100b004a2cb642e43mr12694041pfc.49.1637826849228;
        Wed, 24 Nov 2021 23:54:09 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([66.23.193.248])
        by smtp.gmail.com with ESMTPSA id u30sm1483831pgo.60.2021.11.24.23.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 23:54:08 -0800 (PST)
Date:   Thu, 25 Nov 2021 15:53:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH 1/1] perf arm-spe: report all SPE records as "all"
 events
Message-ID: <20211125075358.GA1599216@leoy-ThinkPad-X240s>
References: <20211117142833.226629-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117142833.226629-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 17, 2021 at 02:28:32PM +0000, German Gomez wrote:
> From: James Clark <james.clark@arm.com>
> 
> Currently perf-report and perf-inject are dropping a large number of SPE
> records because they don't contain any of the existing events, but the
> contextual information of the records is still useful to keep.
> 
> The synthesized event "all" is generated for every SPE record that is
> processed, regardless of whether the record contains interesting events
> or not. The event can be filtered with the flag "--itrace=o".
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/Documentation/itrace.txt |  2 +-
>  tools/perf/util/arm-spe.c           | 36 +++++++++++++++++++++++++++++
>  tools/perf/util/auxtrace.h          |  2 +-
>  3 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
> index c52755481..57dc12b83 100644
> --- a/tools/perf/Documentation/itrace.txt
> +++ b/tools/perf/Documentation/itrace.txt
> @@ -6,7 +6,7 @@
>  		w	synthesize ptwrite events
>  		p	synthesize power events (incl. PSB events for Intel PT)
>  		o	synthesize other events recorded due to the use
> -			of aux-output (refer to perf record)
> +			of aux-output (refer to perf record) (all events for Arm SPE)
>  		e	synthesize error events
>  		d	create a debug log
>  		f	synthesize first level cache events
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index ce77abf90..6428351db 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -58,6 +58,7 @@ struct arm_spe {
>  	u8				sample_branch;
>  	u8				sample_remote_access;
>  	u8				sample_memory;
> +	u8				sample_other;
>  
>  	u64				l1d_miss_id;
>  	u64				l1d_access_id;
> @@ -68,6 +69,7 @@ struct arm_spe {
>  	u64				branch_miss_id;
>  	u64				remote_access_id;
>  	u64				memory_id;
> +	u64				all_id;
>  
>  	u64				kernel_start;
>  
> @@ -351,6 +353,23 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
>  
> +static int arm_spe__synth_other_sample(struct arm_spe_queue *speq,
> +				       u64 spe_events_id)
> +{
> +	struct arm_spe *spe = speq->spe;
> +	struct arm_spe_record *record = &speq->decoder->record;
> +	union perf_event *event = speq->event_buf;
> +	struct perf_sample sample = { .ip = 0, };
> +
> +	arm_spe_prep_sample(spe, speq, event, &sample);
> +
> +	sample.id = spe_events_id;
> +	sample.stream_id = spe_events_id;
> +	sample.addr = record->to_ip;

After checked the event types, I think "other" samples would include
below raw event types:

  EV_EXCEPTION_GEN
  EV_RETIRED
  EV_NOT_TAKEN
  EV_ALIGNMENT
  EV_PARTIAL_PREDICATE
  EV_EMPTY_PREDICATE

I am just wander if we can use sample.transaction to store these event
types, otherwise, we cannot distinguish the event type for the samples.

And it's good fill more sample fields for complete info, like:

  sample.addr = record->virt_addr;
  sample.phys_addr = record->phys_addr;
  sample.data_src = data_src;

Thanks,
Leo

> +
> +	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
> +}
> +
>  #define SPE_MEM_TYPE	(ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
>  			 ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
>  			 ARM_SPE_REMOTE_ACCESS)
> @@ -480,6 +499,12 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>  			return err;
>  	}
>  
> +	if (spe->sample_other) {
> +		err = arm_spe__synth_other_sample(speq, spe->all_id);
> +		if (err)
> +			return err;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1107,6 +1132,17 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  			return err;
>  		spe->memory_id = id;
>  		arm_spe_set_event_name(evlist, id, "memory");
> +		id += 1;
> +	}
> +
> +	if (spe->synth_opts.other_events) {
> +		spe->sample_other = true;
> +
> +		err = arm_spe_synth_event(session, &attr, id);
> +		if (err)
> +			return err;
> +		spe->all_id = id;
> +		arm_spe_set_event_name(evlist, id, "all");
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index bbf0d78c6..efe1bdc06 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -74,7 +74,7 @@ enum itrace_period_type {
>   * @ptwrites: whether to synthesize events for ptwrites
>   * @pwr_events: whether to synthesize power events
>   * @other_events: whether to synthesize other events recorded due to the use of
> - *                aux_output
> + *                aux_output (all events for Arm SPE)
>   * @errors: whether to synthesize decoder error events
>   * @dont_decode: whether to skip decoding entirely
>   * @log: write a decoding log
> -- 
> 2.25.1
> 
