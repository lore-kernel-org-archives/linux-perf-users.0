Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA65C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 09:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiDMJlI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 05:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiDMJlF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 05:41:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF654BF0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 02:38:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s25so1180289edi.13
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aFCR1X5dl4TH+ZeLqsX/xngViyPlfkc2WJbdobahopg=;
        b=tf3toI7aA2g5VAzh87d8G3g4HCa3rCZxOWjRNk4c/H+7XoPzDd08FEcSkrknGMkgb6
         Ta+OtY+WVXHD9KeZ+MSSXQyKpeuHsaxx08XDDJ0BPaElo4vop78aHrCInqPHdZCmq2LE
         iiXlyL367XH//npqq5yeUeTvS1Edph9BWXX/F8dhCsZgvtDwAwb/9pyGkMJJA8jHN70J
         Gp+72CVd8BtGcxpSH3r1Sed4NeuV8TJOrPZNDEbmWP8WvkZk1uXHin3Diy4tqdc7bGvT
         hGKGu+0rCtspN6uRN+unR4lawRhkP1elNprh5ZmyfKiycO10Qq8p/rK7eglE/mxRKkKP
         huIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aFCR1X5dl4TH+ZeLqsX/xngViyPlfkc2WJbdobahopg=;
        b=v8ngIWG8ify1gxKuHrz2Y3mjU66ftWhf+Hi5OJZe8Ui46ZwZ9Kts0qUbwdnc1wEB8q
         +u6/xO5CSOK+wBWRNc/OUtO/MDPTBzFIX8J1ZBPu/1/ZbD9OlQYOHbRuN4RvW2KZM5WF
         9uTNhvU4xpoFfBtkLJzCa2Hna7eJrOEQUAFNXO5WwyEK7MfVGnM6WLkElMmgAxnxAIzI
         jygwXptBcKLBaeMMTA2wx3a3uO1ilscXJGLdVOZfrslwArNe5Z2KkhBtJmQDObw98anB
         YrHofCUP4LwOAmDFYkEcCQvC01gBNrOqJeS4NVBGZYoemX3dsvk5S/4O7JVfXJy5fcAz
         LlNA==
X-Gm-Message-State: AOAM532EkMQL5xvJ/7HrZprNrj15JeC6iV0UJEsk1wc7t8WoGCD1Wmpm
        EzGpTcIoGGulluQO1GId6RDraQ==
X-Google-Smtp-Source: ABdhPJyvRVSTPcXHtAQ4UbS79WSEhRNCdoD8PYW3bwX5tQiJf/i63FprocYkMughWo4E4VlrOSyACQ==
X-Received: by 2002:a05:6402:34b:b0:41d:7026:d9e3 with SMTP id r11-20020a056402034b00b0041d7026d9e3mr20045370edw.168.1649842722588;
        Wed, 13 Apr 2022 02:38:42 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006e894144707sm3237097ejb.53.2022.04.13.02.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:38:42 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:38:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.com, German.Gomez@arm.com,
        Luke Dare <Luke.Dare@arm.com>, Al Grant <al.grant@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: docs: Add man page entry for Arm SPE
Message-ID: <20220413093837.GE521036@leoy-ThinkPad-X240s>
References: <20220413084021.2556142-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413084021.2556142-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 13, 2022 at 09:40:21AM +0100, James Clark wrote:
> The SPE integration in Perf has quite a few usability quirks that
> can't be found by just reading the reference manual. So document this
> and at the same time add a summary of the feature that is also hard to
> find elsewhere.
> 
> Co-authored-by: Luke Dare <Luke.Dare@arm.com>
> Co-authored-by: Al Grant <al.grant@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/Documentation/perf-arm-spe.txt | 218 ++++++++++++++++++++++
>  tools/perf/Documentation/perf.txt         |   2 +-
>  2 files changed, 219 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/Documentation/perf-arm-spe.txt
> 
> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
> new file mode 100644
> index 000000000000..bf03222e9a68
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-arm-spe.txt
> @@ -0,0 +1,218 @@
> +perf-arm-spe(1)
> +================
> +
> +NAME
> +----
> +perf-arm-spe - Support for Arm Statistical Profiling Extension within Perf tools
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'perf record' -e arm_spe//
> +
> +DESCRIPTION
> +-----------
> +
> +The SPE (Statistical Profiling Extension) feature provides accurate attribution of latencies and
> + events down to individual instructions. Rather than being interrupt-driven, it picks an
> +instruction to sample and then captures data for it during execution. Data includes execution time
> +in cycles. For loads and stores it also includes data address, cache miss events, and data origin.
> +
> +The sampling has 5 stages:
> +
> +  1. Choose an operation
> +  2. Collect data about the operation
> +  3. Optionally discard the record based on a filter
> +  4. Write the record to memory
> +  5. Interrupt when the buffer is full
> +
> +Choose an operation
> +~~~~~~~~~~~~~~~~~~~
> +
> +This is chosen from a sample population, for SPE this is an IMPLEMENTATION DEFINED choice of all
> +architectural instructions or all micro-ops. Sampling happens at a programmable interval. The
> +architecture provides a mechanism for the SPE driver to infer the minimum interval at which it should
> +sample. This minimum interval is used by the driver if no interval is specified. A pseudo-random
> +perturbation is also added to the sampling interval by default.
> +
> +Collect data about the operation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Program counter, PMU events, timings and data addresses related to the operation are recorded.
> +Sampling ensures there is only one sampled operation is in flight.
> +
> +Optionally discard the record based on a filter
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Based on programmable criteria, choose whether to keep the record or discard it. If the record is
> +discarded then the flow stops here for this sample.
> +
> +Write the record to memory
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The record is appended to a memory buffer
> +
> +Interrupt when the buffer is full
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When the buffer fills, an interrupt is sent and the driver signals Perf to collect the records.
> +Perf saves the raw data in the perf.data file.
> +
> +Opening the file
> +----------------
> +
> +Up until this point no decoding of the SPE data was done by either the kernel or Perf. Only when the
> +recorded file is opened with 'perf report' or 'perf script' does the decoding happen. When decoding
> +the data, Perf generates "synthetic samples" as if these were generated at the time of the
> +recording. These samples are the same as if normal sampling was done by Perf without using SPE,
> +although they may have more attributes associated with them. For example a normal sample may have
> +just the instruction pointer, but an SPE sample can have data addresses and latency attributes.
> +
> +Why Sampling?
> +-------------
> +
> + - Sampling, rather than tracing, cuts down the profiling problem to something more manageable for
> + hardware. Only one sampled operation is in flight at a time.
> +
> + - Allows precise attribution data, including: Full PC of instruction, data virtual and physical
> + addresses.
> +
> + - Allows correlation between an instruction and events, such as TLB and cache miss. (Data source
> + indicates which particular cache was hit, but the meaning is implementation defined because
> + different implementations can have different cache configurations.)
> +
> +However, SPE does not provide any call-graph information, and relies on statistical methods.
> +
> +Collisions
> +----------
> +
> +When an operation is sampled while a previous sampled operation has not finished, a collision
> +occurs. The new sample is dropped. Collisions affect the integrity of the data, so the sample rate
> +should be set to avoid collisions.
> +
> +The 'sample_collision' PMU event can be used to determine the number of lost samples. Although this
> +count is based on collisions _before_ filtering occurs. Therefore this can not be used as an exact
> +number for samples dropped that would have made it through the filter, but can be a rough
> +guide.
> +
> +The effect of microarchitectural sampling
> +-----------------------------------------
> +
> +If an implementation samples micro-operations instead of instructions, the results of sampling must
> +be weighted accordingly.
> +
> +For example, if a given instruction A is always converted into two micro-operations, A0 and A1, it
> +becomes twice as likely to appear in the sample population.
> +
> +The coarse effect of conversions, and, if applicable, sampling of speculative operations, can be
> +estimated from the 'sample_pop' and 'inst_retired' PMU events.
> +
> +Kernel Requirements
> +-------------------
> +
> +The ARM_SPE_PMU config must be set to build as either a module or statically.
> +
> +Depending on CPU model, the kernel may need to be booted with page table isolation disabled
> +(kpti=off). If KPTI needs to be disabled, this will fail with a console message "profiling buffer
> +inaccessible. Try passing 'kpti=off' on the kernel command line".
> +
> +Capturing SPE with perf command-line tools
> +------------------------------------------
> +
> +You can record a session with SPE samples:
> +
> +  perf record -e arm_spe// -- ./mybench
> +
> +The sample period is set from the -c option, and because the minimum interval is used by default
> +it's recommended to set this to a higher value. The value is written to PMSIRR.INTERVAL.
> +
> +Config parameters
> +~~~~~~~~~~~~~~~~~
> +
> +These are placed between the // in the event and comma separated. For example '-e
> +arm_spe/load_filter=1,min_latency=10/'
> +
> +  branch_filter=1     - collect branches only (PMSFCR.B)
> +  event_filter=<mask> - filter on specific events (PMSEVFR) - see bitfield description below
> +  jitter=1            - use jitter to avoid resonance when sampling (PMSIRR.RND)
> +  load_filter=1       - collect loads only (PMSFCR.LD)
> +  min_latency=<n>     - collect only samples with this latency or higher* (PMSLATFR)
> +  pa_enable=1         - collect physical address (as well as VA) of loads/stores (PMSCR.PA) - requires privilege
> +  pct_enable=1        - collect physical timestamp instead of virtual timestamp (PMSCR.PCT) - requires privilege
> +  store_filter=1      - collect stores only (PMSFCR.ST)
> +  ts_enable=1         - enable timestamping with value of generic timer (PMSCR.TS)
> +
> ++++*+++ Latency is the total latency from the point at which sampling started on that instruction, rather
> +than only the execution latency.
> +
> +Only some events can be filtered on; these include:
> +
> +  bit 1     - instruction retired (i.e. omit speculative instructions)
> +  bit 3     - L1D refill
> +  bit 5     - TLB refill
> +  bit 7     - mispredict
> +  bit 11    - misaligned access
> +
> +So to sample just retired instructions:
> +
> +  perf record -e arm_spe/event_filter=2/ -- ./mybench
> +
> +or just mispredicted branches:
> +
> +  perf record -e arm_spe/event_filter=0x80/ -- ./mybench
> +
> +Viewing the data
> +~~~~~~~~~~~~~~~~~
> +
> +By default perf report and perf script will assign samples to separate groups depending on the
> +attributes/events of the SPE record. Because instructions can have multiple events associated with
> +them, the samples in these groups are not necessarily unique. For example perf report shows these
> +groups:
> +
> +  Available samples
> +  0 arm_spe//
> +  0 dummy:u
> +  21 l1d-miss
> +  897 l1d-access
> +  5 llc-miss
> +  7 llc-access
> +  2 tlb-miss
> +  1K tlb-access
> +  36 branch-miss
> +  0 remote-access
> +  900 memory
> +
> +The arm_spe// and dummy:u events are implementation details and are expected to be empty.
> +
> +To get a full list of unique samples that are not sorted into groups, set the itrace option to
> +generate 'instruction' samples. The period option is also taken into account, so set it to 1
> +instruction unless you want to further downsample the already sampled SPE data:
> +
> +  perf report --itrace=i1i
> +
> +Memory access details are also stored on the samples and this can be viewed with:
> +
> +  perf report --mem-mode
> +
> +Common errors
> +~~~~~~~~~~~~~
> +
> + - "Cannot find PMU `arm_spe'. Missing kernel support?"
> +
> +   Module not built or loaded, KPTI not disabled (see above), or running on a VM
> +
> + - "Arm SPE CONTEXT packets not found in the traces."
> +
> +   Root privilege is required to collect context packets. But these only increase the accuracy of
> +   assigning PIDs to kernel samples. For userspace sampling this can be ignored.
> +
> + - Excessively large perf.data file size
> +
> +   Increase sampling interval (see above)
> +
> +
> +SEE ALSO
> +--------
> +
> +linkperf:perf-record[1], linkperf:perf-script[1], linkperf:perf-report[1],
> +linkperf:perf-inject[1]
> diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> index 71ebdf8125de..ba3df49c169d 100644
> --- a/tools/perf/Documentation/perf.txt
> +++ b/tools/perf/Documentation/perf.txt
> @@ -77,7 +77,7 @@ linkperf:perf-stat[1], linkperf:perf-top[1],
>  linkperf:perf-record[1], linkperf:perf-report[1],
>  linkperf:perf-list[1]
>  
> -linkperf:perf-annotate[1],linkperf:perf-archive[1],
> +linkperf:perf-annotate[1],linkperf:perf-archive[1],linkperf:perf-arm-spe[1],
>  linkperf:perf-bench[1], linkperf:perf-buildid-cache[1],
>  linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
>  linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
> -- 
> 2.28.0
> 
