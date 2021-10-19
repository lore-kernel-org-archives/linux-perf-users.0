Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9DCC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 17:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D90C6135F
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 17:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhJSRgn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 13:36:43 -0400
Received: from foss.arm.com ([217.140.110.172]:52354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234670AbhJSRgl (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 13:36:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66331D6E;
        Tue, 19 Oct 2021 10:34:28 -0700 (PDT)
Received: from [10.57.73.194] (unknown [10.57.73.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25CB03F694;
        Tue, 19 Oct 2021 10:34:26 -0700 (PDT)
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        James Clark <james.clark@arm.com>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20211017120546.GB130233@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <0661828d-f7d9-fd8f-2a57-19364d2e5218@arm.com>
Date:   Tue, 19 Oct 2021 18:34:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211017120546.GB130233@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

On 17/10/2021 13:05, Leo Yan wrote:
> On Thu, Sep 16, 2021 at 04:46:34PM +0100, German Gomez wrote:
>
> [...]
>
> If run a test case (the test is pasted at the end of the reply), I
> can get quite different AUX trace data with passing different wait
> period before sending the first USR2 signal.
>
>   # sh test_arm_spe_snapshot.sh 2
>   Couldn't synthesize bpf events.
>   stress: info: [5768] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
>   [ perf record: Woken up 3 times to write data ]
>   [ perf record: Captured and wrote 2.833 MB perf.data ]
>
>   # sh test_arm_spe_snapshot.sh 10
>   Couldn't synthesize bpf events.
>   stress: info: [5776] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
>   [ perf record: Woken up 3 times to write data ]
>   [ perf record: Captured and wrote 24.356 MB perf.data ]
>
> The first command passes argument '2' so the test will wait for 2
> seconds before send USR2 signal for snapshot, and the perf data file is
> 2.833 MB (so this means the Arm SPE trace data is about 2MB) for three
> snapshots.  In the second command, the argument '10' means it will wait
> for 10 seconds before sending the USR2 signals, and every time it records
> the trace data from the full AUX buffer (8MB), at the end it gets 24MB
> AUX trace data.
>
> The issue happens in the second command, waiting for 10 seconds leads
> to the *full* AUX ring buffer is filled by Arm SPE, so the function
> arm_spe_buffer_has_wrapped() always return back true for this case.
> Afterwards, arm_spe_find_snapshot() doesn't respect the passed old
> header (from '*old') and assumes the trace data size is 'mm->len'.

Returning the entire contents of the buffer once the first wrap-around
was detected was the intention of the patch, so I don't currently see it
as wrong. What were the values you were expecting to see in the test?

If the handling of snapshot mode by the perf tool can be improved after
upstreaming the changes to the driver, we could submit a followup patch
after that has been fixed.

>
> To allow arm_spe_buffer_has_wrapped() to work properly, I think we
> need to clean up the top 8 bytes of the AUX buffer in Arm SPE driver
> when start the PMU event (please note, this change has an assumption
> that is meantioned in another email that suggests to remove redundant
> PERF_RECORD_AUX events so the function arm_spe_perf_aux_output_begin()
> is invoked only once when start PMU event, so we can use the top 8
> bytes in AUX buffer to indicate trace is wrap around or not).
>
>
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index d44bcc29d99c..eb35f85d0efb 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -493,6 +493,16 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>         if (limit)
>                 limit |= BIT(SYS_PMBLIMITR_EL1_E_SHIFT);
>
> +       /*
> +        * Cleanup the top 8 bytes for snapshot mode; these 8 bytes are
> +        * used to indicate if trace data is wrap around if they are not
> +        * zero.
> +        */
> +       if (buf->snapshot) {
> +               void *tail = buf->base + (buf->nr_pages << PAGE_SHIFT) - 8;
> +               memset(tail, 0x0, 8);
> +       }
> +
>         limit += (u64)buf->base;
>         base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
>         write_sysreg_s(base, SYS_PMBPTR_EL1);
>
> Thanks,
> Leo

I will try these and the other driver changes and discuss them with the
team internally, thanks!

>
> ---8<---
>
> #!/bin/sh
>
> ./perf record -e arm_spe/period=148576/u -C 0 -S -m8M,8M -- taskset --cpu-list 0 stress --cpu 1 &
>
> PERFPID=$!
>
> echo "sleep $1 seconds" > /sys/kernel/debug/tracing/trace_marker
>
> # Wait for perf program
> sleep  $1
>
> # Send signal to snapshot trace data
> kill -USR2 $PERFPID
> sleep .03
> kill -USR2 $PERFPID
> sleep .03
> kill -USR2 $PERFPID
>
> echo "Stop snapshot" > /sys/kernel/debug/tracing/trace_marker
>
> kill $PERFPID
> wait $PERFPID
