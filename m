Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED98C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 14:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D76B610E9
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 14:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhKFPAr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Nov 2021 11:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhKFPAr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Nov 2021 11:00:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B49C061570
        for <linux-perf-users@vger.kernel.org>; Sat,  6 Nov 2021 07:58:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so5411412pji.5
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Nov 2021 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MocImPNzBj/te/rH5DIhKsqDP9k0g3D8Pxj9skocwwQ=;
        b=EIyULtb6dIuL82h9nB/PyTpo+Wrc4hNwD5mGr+oSH5pj9LH27gW2f0abd5pfoG3oi3
         XuLOEVX2OVMhAZmLkledXYGCv37Y+0S50h4ZT/2cie5ZijVNUtiS8gxEQScFd7GqEfpV
         sUAqwXC9k5QFMRSt/xFbfVbOzYnrMuuaNcUlVeJwcO2LOy9j/fovWGEy4/224kgGPBWW
         v/WyrCuXlTG0LYtTg2mh6BSls7VzrClxcJk+ReSrT0fcC6yrHffqsVPlBjunL38ixk82
         /LIvjAsz9uAvTezBsCpka0WjyopgL/20JmxdW7HvD4JEK7YrW+RZYquqkyD/4WkYsYxN
         wCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MocImPNzBj/te/rH5DIhKsqDP9k0g3D8Pxj9skocwwQ=;
        b=t9tpzTT1XXgIvkCUjitCbWAnNPCvAkSPzUI4rKVoBCeMswk6BJ6iKYAg6CCAkFnz+n
         J7XWhaVRJg6ch1DD6Do8srXTkoG2lzLOSh7wi0R3gORoV1HRT+Lsms6ozyhOk30VNpZU
         YrELj5fGiHT5HawL+zbisyeLiCTchSGNydE2gm/x0rfem+CCRWLwpfl6EWhznox/2PSq
         Uf0v047csHTJpQONluCElCAZnR76Y0mD4EG+C5CL+24dvH18LHHysk04e9j8TXWTeUWE
         U27tQ6ReX4M+APHkwLCMyhGGKMk9NE5Gfo1lPolQGcLmK3zOIgUxhTiJKOlw/shNmHAs
         auOg==
X-Gm-Message-State: AOAM532DGRywzUBO17RGepCKDAv7v7cvNWOAnC22XLQsep67DpOWATOb
        NAoKGQg+MuJdcfQZ1UrxbXasBQ==
X-Google-Smtp-Source: ABdhPJz1w0bwOM+yxx8ucawI2qT9jc8DwbGefq+5B2DnoMYxgpMKTkJ7dr5XQW5ZcNpVkO3jMWb5Aw==
X-Received: by 2002:a17:90a:a78f:: with SMTP id f15mr37971634pjq.106.1636210685240;
        Sat, 06 Nov 2021 07:58:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id x2sm7713602pfd.144.2021.11.06.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 07:58:04 -0700 (PDT)
Date:   Sat, 6 Nov 2021 22:57:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] perf arm-spe: Support hardware-based PID tracing
Message-ID: <20211106145758.GJ477387@leoy-ThinkPad-X240s>
References: <20211102180739.18049-1-german.gomez@arm.com>
 <20211102180739.18049-4-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102180739.18049-4-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi German,

On Tue, Nov 02, 2021 at 06:07:39PM +0000, German Gomez wrote:
> If Arm SPE traces contain CONTEXT packets with PID info, use these
> values for tracking pid of samples. Otherwise fall back to using context
> switch events and display a message warning the user of possible timing
> inaccuracies [1].
> 
> [1] https://lore.kernel.org/lkml/f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com/

First of all, I'd like to clarify one thing:

The pid/tid has been supported for 'per-thread' mode, the function
arm_spe_process_timeless_queues() invokes arm_spe_set_pid_tid_cpu() to
initialize 'speq->tid' and assign auxtrace_queue's tid to it.

Thus, in this patch set we only need to consider support context packet
for CPU wide tracing and system wide tracing.  The following comments
are heavily based on this assumption.

> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/util/arm-spe.c | 123 ++++++++++++++++++++++++++++----------
>  1 file changed, 92 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 230bc7ab2..00a409469 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -71,6 +71,7 @@ struct arm_spe {
>  	u64				kernel_start;
>  
>  	unsigned long			num_events;
> +	u8				use_ctx_pkt_for_pid;
>  };
>  
>  struct arm_spe_queue {
> @@ -226,6 +227,44 @@ static inline u8 arm_spe_cpumode(struct arm_spe *spe, u64 ip)
>  		PERF_RECORD_MISC_USER;
>  }
>  
> +static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
> +				    struct auxtrace_queue *queue)
> +{
> +	struct arm_spe_queue *speq = queue->priv;
> +	pid_t tid;
> +
> +	tid = machine__get_current_tid(spe->machine, speq->cpu);
> +	if (tid != -1) {
> +		speq->tid = tid;
> +		thread__zput(speq->thread);
> +	} else
> +		speq->tid = queue->tid;
> +
> +	if ((!speq->thread) && (speq->tid != -1)) {
> +		speq->thread = machine__find_thread(spe->machine, -1,
> +						    speq->tid);
> +	}
> +
> +	if (speq->thread) {
> +		speq->pid = speq->thread->pid_;
> +		if (queue->cpu == -1)
> +			speq->cpu = speq->thread->cpu;
> +	}
> +}
> +
> +static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
> +{
> +	struct arm_spe *spe = speq->spe;
> +	int err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
> +
> +	if (err)
> +		return err;
> +
> +	arm_spe_set_pid_tid_cpu(spe, &spe->queues.queue_array[speq->queue_nr]);
> +
> +	return 0;
> +}
> +
>  static void arm_spe_prep_sample(struct arm_spe *spe,
>  				struct arm_spe_queue *speq,
>  				union perf_event *event,
> @@ -460,6 +499,13 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
>  		 * can correlate samples between Arm SPE trace data and other
>  		 * perf events with correct time ordering.
>  		 */
> +
> +		if (spe->use_ctx_pkt_for_pid) {
> +			ret = arm_spe_set_tid(speq, speq->decoder->record.context_id);
> +			if (ret)
> +				return ret;
> +		}
> +

If trace contains context packet, we can give it the priority.  So at
here we can always update tid based on the latest context_id from the
context packet.

And for 'per thread' mode, we should not set pid/tid for it.  The
reason is arm_spe_set_tid() will return error for 'per thread' mode,
because the 'speq->cpu' is -1, so it cannot set tid/pid for CPU '-1'.

And if we detect there have context packet is incoming, we should set
the flag 'spe->use_ctx_pkt_for_pid' true.

How about below code:

        /* Update pid/tid info */
        record = &speq->decoder->record;
        if (!spe->timeless_decoding && record->context_id != (u64)-1) {
                ret = arm_spe_set_tid(speq, record->context_id);
                if (ret)
                        return ret;

                spe->use_ctx_pkt_for_pid = 1;
        }

>  		ret = arm_spe_sample(speq);
>  		if (ret)
>  			return ret;
> @@ -586,31 +632,6 @@ static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
>  	return timeless_decoding;
>  }
>  
> -static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
> -				    struct auxtrace_queue *queue)
> -{
> -	struct arm_spe_queue *speq = queue->priv;
> -	pid_t tid;
> -
> -	tid = machine__get_current_tid(spe->machine, speq->cpu);
> -	if (tid != -1) {
> -		speq->tid = tid;
> -		thread__zput(speq->thread);
> -	} else
> -		speq->tid = queue->tid;
> -
> -	if ((!speq->thread) && (speq->tid != -1)) {
> -		speq->thread = machine__find_thread(spe->machine, -1,
> -						    speq->tid);
> -	}
> -
> -	if (speq->thread) {
> -		speq->pid = speq->thread->pid_;
> -		if (queue->cpu == -1)
> -			speq->cpu = speq->thread->cpu;
> -	}
> -}
> -
>  static int arm_spe_process_queues(struct arm_spe *spe, u64 timestamp)
>  {
>  	unsigned int queue_nr;
> @@ -641,7 +662,13 @@ static int arm_spe_process_queues(struct arm_spe *spe, u64 timestamp)
>  			ts = timestamp;
>  		}
>  
> -		arm_spe_set_pid_tid_cpu(spe, queue);
> +		/*
> +		 * Here we only consider PID tracking based on switch events.
> +		 * For tracking based on CONTEXT packets, the pid is assigned in the function
> +		 * arm_spe_run_decoder() in order to support timeless decoding.
> +		 */
> +		if (!spe->use_ctx_pkt_for_pid)
> +			arm_spe_set_pid_tid_cpu(spe, queue);

Yeah, this is right; if without context packet, we need to update thread
context at this point.

Could you refine the comment like something:

"The switch events has set pid/tid in the machine's context, here we
update the thread and pid/tid info for spe queue."

>  		ret = arm_spe_run_decoder(speq, &ts);
>  		if (ret < 0) {
> @@ -740,8 +767,9 @@ static int arm_spe_process_event(struct perf_session *session,
>  		if (err)
>  			return err;
>  
> -		if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
> -		    event->header.type == PERF_RECORD_SWITCH)
> +		if (!spe->use_ctx_pkt_for_pid &&
> +		    (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
> +		     event->header.type == PERF_RECORD_SWITCH))
>
>  			err = arm_spe_context_switch(spe, event, sample);
>  	}
>  
> @@ -805,10 +833,16 @@ static int arm_spe_flush(struct perf_session *session __maybe_unused,
>  		return ret;
>  
>  	if (spe->timeless_decoding)
> -		return arm_spe_process_timeless_queues(spe, -1,
> +		ret = arm_spe_process_timeless_queues(spe, -1,
>  				MAX_TIMESTAMP - 1);
> +	else
> +		ret = arm_spe_process_queues(spe, MAX_TIMESTAMP);
>  
> -	return arm_spe_process_queues(spe, MAX_TIMESTAMP);
> +	if (!spe->use_ctx_pkt_for_pid)
> +		ui__warning("Arm SPE CONTEXT packets not found in the traces.\n\n"
> +			    "Matching of TIDs to SPE events could be inaccurate.\n\n");

I think we only need to report the warning for no timeless case and
it's not necessary to change code for timeless decoding, thus the
change could be:

        ret = arm_spe_process_queues(spe, MAX_TIMESTAMP);
        if (!spe->use_ctx_pkt_for_pid)
        ui__warning("Arm SPE CONTEXT packets not found in the traces.\n"
                    "Matching of TIDs to SPE events could be inaccurate.\n");

> +
> +	return ret;
>  }
>  
>  static void arm_spe_free_queue(void *priv)
> @@ -1056,6 +1090,22 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  	return 0;
>  }
>  
> +static bool arm_spe_is_ctx_pkt_enabled(struct arm_spe *spe)
> +{
> +	struct auxtrace_queues *queues = &spe->queues;
> +	unsigned int i;
> +
> +	for (i = 0; i < queues->nr_queues; i++) {
> +		struct auxtrace_queue *queue = &spe->queues.queue_array[i];
> +		struct arm_spe_queue *speq = queue->priv;
> +
> +		if (speq)
> +			return speq->decoder->record.context_id != (u64) -1;
> +	}
> +
> +	return false;
> +}
> +
>  int arm_spe_process_auxtrace_info(union perf_event *event,
>  				  struct perf_session *session)
>  {
> @@ -1131,9 +1181,20 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	if (err)
>  		goto err_free_queues;
>  
> -	if (spe->queues.populated)
> +	if (spe->queues.populated) {
>  		spe->data_queued = true;
>  
> +		/*
> +		 * Ensure the first record of every queue can be read in the function
> +		 * arm_spe_is_ctx_pkt_enabled()
> +		 */
> +		err = arm_spe__update_queues(spe);
> +		if (err)
> +			goto err_free_queues;
> +
> +		spe->use_ctx_pkt_for_pid = arm_spe_is_ctx_pkt_enabled(spe);

I don't think this change is needed.

arm_spe__setup_queue() will start to decode and it returns back the
first record; then function arm_spe_run_decoder() will check
'record->context_id', if detect 'context_id' is not '-1' it will set
'spe->use_ctx_pkt_for_pid' as true.

So here we don't need to invoke arm_spe__update_queues().  And I have
some concern that this might introduce other potential issue,
especially the callback process_auxtrace_info() usually is only used
for early initializatoin rather than trace data decoding.

Thanks,
Leo

> +	}
> +
>  	return 0;
>  
>  err_free_queues:
> -- 
> 2.25.1
> 
