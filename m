Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B464BC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 20:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962E36052B
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 20:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhKHUmt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:42:49 -0500
Received: from foss.arm.com ([217.140.110.172]:53720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhKHUms (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 15:42:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F7072B;
        Mon,  8 Nov 2021 12:40:03 -0800 (PST)
Received: from [10.57.27.155] (unknown [10.57.27.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4BF3F718;
        Mon,  8 Nov 2021 12:40:00 -0800 (PST)
Subject: Re: [PATCH 1/1] perf arm-spe: Inject SPE samples in perf-inject
To:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211105104130.28186-1-german.gomez@arm.com>
 <20211105104130.28186-2-german.gomez@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <5163f41f-2337-6557-ca91-fb2c66738872@arm.com>
Date:   Mon, 8 Nov 2021 20:39:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211105104130.28186-2-german.gomez@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 05/11/2021 10:41, German Gomez wrote:
> Inject synthesized SPE samples during perf-inject run.
> 
> Signed-off-by: German Gomez <german.gomez@arm.com>

Reviewed-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/arm-spe.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 58b7069c5..7054f2315 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -51,6 +51,7 @@ struct arm_spe {
>  	u8				timeless_decoding;
>  	u8				data_queued;
>  
> +	u64				sample_type;
>  	u8				sample_flc;
>  	u8				sample_llc;
>  	u8				sample_tlb;
> @@ -248,6 +249,12 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
>  	event->sample.header.size = sizeof(struct perf_event_header);
>  }
>  
> +static int arm_spe__inject_event(union perf_event *event, struct perf_sample *sample, u64 type)
> +{
> +	event->header.size = perf_event__sample_event_size(sample, type, 0);
> +	return perf_event__synthesize_sample(event, type, 0, sample);
> +}
> +
>  static inline int
>  arm_spe_deliver_synth_event(struct arm_spe *spe,
>  			    struct arm_spe_queue *speq __maybe_unused,
> @@ -256,6 +263,12 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
>  {
>  	int ret;
>  
> +	if (spe->synth_opts.inject) {
> +		ret = arm_spe__inject_event(event, sample, spe->sample_type);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = perf_session__deliver_synth_event(spe->session, event, sample);
>  	if (ret)
>  		pr_err("ARM SPE: failed to deliver event, error %d\n", ret);
> @@ -920,6 +933,8 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  	else
>  		attr.sample_type |= PERF_SAMPLE_TIME;
>  
> +	spe->sample_type = attr.sample_type;
> +
>  	attr.exclude_user = evsel->core.attr.exclude_user;
>  	attr.exclude_kernel = evsel->core.attr.exclude_kernel;
>  	attr.exclude_hv = evsel->core.attr.exclude_hv;
> 
