Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3158CC433FE
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 03:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B1F60F9E
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 03:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhKFDbz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 23:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbhKFDby (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 23:31:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D389C061714
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Nov 2021 20:29:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o14so12250247plg.5
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Nov 2021 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YY2yROP/RTZn4kLLVf2pxBx6PraWK6o1QIaMf35Sqmw=;
        b=fip6mcenQtkDGEeS3eGubOC8kkjNwPGdbKl4wiy8GVwrR7+gCYDENj2vCPY6wQc0b5
         OrH5+AFy3eCMw+bkbCbS0rlTtamxK+kzOD9qHGMF8bp3q8h3m2l606GOGlLCT17VzaRC
         5L0z9A1grNoc28fW6FZlwk6u3Us/ZNjUEAZl4fkavMFI+avLVOFy3Fk7+jkXzmUpGf/+
         USp7M2KkqToanvio/zZvbcuwukj29ImxKrc1Vl7jV/APA7qLekEpq//0xYsInoOHFaR2
         vzFHnDG14UPO6h15MLtUK1psCHta+QYpoda0kubZSj0zoFx3o9QdX3M8H6rabeonap+m
         2Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YY2yROP/RTZn4kLLVf2pxBx6PraWK6o1QIaMf35Sqmw=;
        b=ab9P+8xIB2UHbImA+rIHi/NRallFuJk+RliVA27ZP9NQM6kGSjOIuD+9W3YeNUExRM
         lioDPi9wg7D+75c5caVivjVhblkVIwedtDS2GTt2CGzGiTJCebYueVPRuzorCmMbNqIH
         mf4IHlqKanKNSL+zt6YxjrTLSoLIiKbZw72ioRjbjRUYDMMGsoqX5RH3UCF+tsJNpLRi
         QTbmwM7tHQ85Z2bECAteDAgqX+4BO0RHMugY/HQrSUr+/tn5n4JH9XFIMl0rk5J5sE4V
         D0tvF3P8gcEoMFEhalEcEcn7MxkfZDgrTh/uKdzE9uvwC5tQr2pkYJoLFJchfbZYKWuU
         8hog==
X-Gm-Message-State: AOAM532ZtT1rDsQ9t0adYaELLtlMLcJQxWksZD+QIn/UoFx11hQ7mCKZ
        XIMdTwJaA8NdGc7iAYcianQoUw==
X-Google-Smtp-Source: ABdhPJzmuSoGoVBYgQIyra43AItxYUv72Azq/BtsVOdgswc5h5uUEt7+vKniItjedDFuWkd6pPzqhg==
X-Received: by 2002:a17:90a:fec:: with SMTP id 99mr35452489pjz.193.1636169353433;
        Fri, 05 Nov 2021 20:29:13 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id j3sm7695065pfc.47.2021.11.05.20.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 20:29:12 -0700 (PDT)
Date:   Sat, 6 Nov 2021 11:29:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] perf arm-spe: Track task context switch for cpu-mode
 events
Message-ID: <20211106032907.GG477387@leoy-ThinkPad-X240s>
References: <20211102180739.18049-1-german.gomez@arm.com>
 <20211102180739.18049-2-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102180739.18049-2-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi German,

On Tue, Nov 02, 2021 at 06:07:37PM +0000, German Gomez wrote:
> When perf report synthesize events from ARM SPE data, it refers to
> current cpu, pid and tid in the machine.  But there's no place to set
> them in the ARM SPE decoder.  I'm seeing all pid/tid is set to -1 and
> user symbols are not resolved in the output.
> 
>   # perf record -a -e arm_spe_0/ts_enable=1/ sleep 1
> 
>   # perf report -q | head
>      8.77%     8.77%  :-1      [kernel.kallsyms]  [k] format_decode
>      7.02%     7.02%  :-1      [kernel.kallsyms]  [k] seq_printf
>      7.02%     7.02%  :-1      [unknown]          [.] 0x0000ffff9f687c34
>      5.26%     5.26%  :-1      [kernel.kallsyms]  [k] vsnprintf
>      3.51%     3.51%  :-1      [kernel.kallsyms]  [k] string
>      3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f66ae20
>      3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f670b3c
>      3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f67c040
>      1.75%     1.75%  :-1      [kernel.kallsyms]  [k] ___cache_free
>      1.75%     1.75%  :-1      [kernel.kallsyms]  [k]
> __count_memcg_events
> 
> Like Intel PT, add context switch records to track task info.  As ARM
> SPE support was added later than PERF_RECORD_SWITCH_CPU_WIDE, I think
> we can safely set the attr.context_switch bit and use it.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: German Gomez <german.gomez@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

Note for one thing, please keep "Namhyung Kim" as the author for this
patch, thanks.

Leo

> ---
>  tools/perf/arch/arm64/util/arm-spe.c |  6 +++++-
>  tools/perf/util/arm-spe.c            | 25 +++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index a4420d4df..58ba8d15c 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -166,8 +166,12 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  	tracking_evsel->core.attr.sample_period = 1;
>  
>  	/* In per-cpu case, always need the time of mmap events etc */
> -	if (!perf_cpu_map__empty(cpus))
> +	if (!perf_cpu_map__empty(cpus)) {
>  		evsel__set_sample_bit(tracking_evsel, TIME);
> +		evsel__set_sample_bit(tracking_evsel, CPU);
> +		/* also track task context switch */
> +		tracking_evsel->core.attr.context_switch = 1;
> +	}
>  
>  	return 0;
>  }
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 58b7069c5..230bc7ab2 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -681,6 +681,25 @@ static int arm_spe_process_timeless_queues(struct arm_spe *spe, pid_t tid,
>  	return 0;
>  }
>  
> +static int arm_spe_context_switch(struct arm_spe *spe, union perf_event *event,
> +				  struct perf_sample *sample)
> +{
> +	pid_t pid, tid;
> +	int cpu;
> +
> +	if (!(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT))
> +		return 0;
> +
> +	pid = event->context_switch.next_prev_pid;
> +	tid = event->context_switch.next_prev_tid;
> +	cpu = sample->cpu;
> +
> +	if (tid == -1)
> +		pr_warning("context_switch event has no tid\n");
> +
> +	return machine__set_current_tid(spe->machine, cpu, pid, tid);
> +}
> +
>  static int arm_spe_process_event(struct perf_session *session,
>  				 union perf_event *event,
>  				 struct perf_sample *sample,
> @@ -718,6 +737,12 @@ static int arm_spe_process_event(struct perf_session *session,
>  		}
>  	} else if (timestamp) {
>  		err = arm_spe_process_queues(spe, timestamp);
> +		if (err)
> +			return err;
> +
> +		if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
> +		    event->header.type == PERF_RECORD_SWITCH)
> +			err = arm_spe_context_switch(spe, event, sample);
>  	}
>  
>  	return err;
> -- 
> 2.25.1
> 
