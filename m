Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA713C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Apr 2021 15:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F986124B
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Apr 2021 15:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350898AbhDNPza (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 11:55:30 -0400
Received: from foss.arm.com ([217.140.110.172]:58278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352498AbhDNPzV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Apr 2021 11:55:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E4A11B3;
        Wed, 14 Apr 2021 08:54:59 -0700 (PDT)
Received: from [10.57.27.217] (unknown [10.57.27.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12BFB3F73B;
        Wed, 14 Apr 2021 08:54:56 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210414143919.12605-1-james.clark@arm.com>
 <20210414143919.12605-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d6b39eca-4f19-bace-ca3d-f36549caa51c@arm.com>
Date:   Wed, 14 Apr 2021 16:54:55 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414143919.12605-2-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 14/04/2021 15:39, James Clark wrote:
> The following attribute is set when synthesising samples in
> timed decoding mode:
> 
>      attr.sample_type |= PERF_SAMPLE_TIME;
> 
> This results in new samples that appear to have timestamps but
> because we don't assign any timestamps to the samples, when the
> resulting inject file is opened again, the synthesised samples
> will be on the wrong side of the MMAP or COMM events.
> 
> For example this results in the samples being associated with
> the perf binary, rather than the target of the record:
> 
>      perf record -e cs_etm/@tmc_etr0/u top
>      perf inject -i perf.data -o perf.inject --itrace=i100il
>      perf report -i perf.inject
> 
> Where 'Command' == perf should show as 'top':
> 
>      # Overhead  Command  Source Shared Object  Source Symbol           Target Symbol           Basic Block Cycles
>      # ........  .......  ....................  ......................  ......................  ..................
>      #
>          31.08%  perf     [unknown]             [.] 0x000000000040c3f8  [.] 0x000000000040c3e8  -
> 
> If the perf.data file is opened directly with perf, without the
> inject step, then this already works correctly because the
> events are synthesised after the COMM and MMAP events and
> no second sorting happens. Re-sorting only happens when opening
> the perf.inject file for the second time so timestamps are
> needed.
> 
> Using the timestamp from the AUX record mirrors the current
> behaviour when opening directly with perf, because the events
> are generated on the call to cs_etm__process_queues().

I would add the following here to clarify the situation :

"The ETM trace could optionally contain time stamps, but there is
no way to correlate this with the kernel time. So, the best available
time value is that of the AUX_RECORD header. This patch uses
the timestamp from the header for all the samples. The ordering of the
samples are implicit in the trace and thus is fine with respect to
relative ordering."


> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Co-developed-by: Al Grant <al.grant@arm.com>
> Signed-off-by: Al Grant <al.grant@arm.com>

nit: The preferred order is your S-o-B at the end (i.e of the sender)

> ---
>   tools/perf/util/cs-etm.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index c25da2ffa8f3..d0fa9dce47f1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -54,6 +54,7 @@ struct cs_etm_auxtrace {
>   	u8 sample_instructions;
>   
>   	int num_cpu;
> +	u64 latest_kernel_timestamp;
>   	u32 auxtrace_type;
>   	u64 branches_sample_type;
>   	u64 branches_id;
> @@ -1192,6 +1193,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>   	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
>   	event->sample.header.size = sizeof(struct perf_event_header);
>   
> +	if (!etm->timeless_decoding)
> +		sample.time = etm->latest_kernel_timestamp;
>   	sample.ip = addr;
>   	sample.pid = tidq->pid;
>   	sample.tid = tidq->tid;
> @@ -1248,6 +1251,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>   	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
>   	event->sample.header.size = sizeof(struct perf_event_header);
>   
> +	if (!etm->timeless_decoding)
> +		sample.time = etm->latest_kernel_timestamp;
>   	sample.ip = ip;
>   	sample.pid = tidq->pid;
>   	sample.tid = tidq->tid;
> @@ -2412,9 +2417,10 @@ static int cs_etm__process_event(struct perf_session *session,
>   	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
>   		return cs_etm__process_switch_cpu_wide(etm, event);
>   
> -	if (!etm->timeless_decoding &&
> -	    event->header.type == PERF_RECORD_AUX)

Might want to add a comment here ,

	/*
	 * Record the latest kernel timestamp available in the header
	 * for samples.
	 */

> +	if (!etm->timeless_decoding && event->header.type == PERF_RECORD_AUX) {
> +		etm->latest_kernel_timestamp = sample_kernel_timestamp;
>   		return cs_etm__process_queues(etm);
> +	}
>   
>   	return 0;
>   }
> 

This is the best effort thing we could do to get things working.

With the comments addressed:

Acked-by: Suzuki K Poulos <suzuki.poulose@arm.com>
