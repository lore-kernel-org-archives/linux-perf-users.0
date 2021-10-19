Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6330BC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 09:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4409A6113D
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 09:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhJSJZT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 05:25:19 -0400
Received: from foss.arm.com ([217.140.110.172]:46546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234897AbhJSJZT (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 05:25:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67118D6E;
        Tue, 19 Oct 2021 02:23:06 -0700 (PDT)
Received: from [10.57.73.194] (unknown [10.57.73.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4A163F73D;
        Tue, 19 Oct 2021 02:23:03 -0700 (PDT)
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        James Clark <James.Clark@arm.com>
References: <20210923135016.GG400258@leoy-ThinkPad-X240s>
 <20210923144048.GB603008@leoy-ThinkPad-X240s>
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
 <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
 <20211006095124.GC14400@leoy-ThinkPad-X240s>
 <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
 <20211013003916.GA130842@leoy-ThinkPad-X240s>
 <20211013075125.GA6701@willie-the-truck>
 <35209d5c-6387-5248-ab61-a1e1cb0553de@arm.com>
 <20211017061305.GA130233@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <5e59784e-3f09-cfbc-1692-f3a5d85b0995@arm.com>
Date:   Tue, 19 Oct 2021 10:23:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211017061305.GA130233@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

Yeah I agree the redundant AUX events are adding unnecessary bloat to
the perf.data file... We actually cam across this when doing one of the
test cases. Sorry for not reporting it!

Could we patch the driver in a separate patch set? Or do you think this
is critical for the purposes of this one?

Thanks,
German

On 17/10/2021 07:13, Leo Yan wrote:
> Hi German, Will,
>
> On Fri, Oct 15, 2021 at 01:33:39PM +0100, German Gomez wrote:
>
> [...]
>
>> $ ./perf record -vvv -e arm_spe/period=148576/u -S1000 -m16,16 -- taskset --cpu-list 0 stress --cpu 1 &
> When testing Arm SPE snapshot mode with the command (it's quite
> similiar with up command but not exactly same):
>
> # ./perf --debug verbose=3 record -e arm_spe/period=148576/u -C 0 -S1000 -m16,16 \
>     -- taskset --cpu-list 0 stress --cpu 1 &
> # kill -USR2 [pid_num]
>
> ... then I wait for long time and didn't stop the perf program, then
> I observed the output file contains many redundant events
> PERF_RECORD_AUX.  E.g. in the shared perf data file [1], you could use
> below commands to see tons of the events PERF_RECORD_AUX which I only
> send only one USR2 signal for taking snapshot:
>
>   # perf report -D -i perf.data --stdio | grep -E 'RECORD_AUX' | wc -l
>   2245787
>
>   # perf report -D -i perf.data --stdio | grep -E 'SPE'
>   . ... ARM SPE data: size 0x3e8 bytes
>   Binary file (standard input) matches
>
> I looked into the Arm SPE driver and found it doesn't really support
> free run mode for AUX ring buffer when the driver runs in snapshot
> mode, the pair functions perf_aux_output_end() and
> perf_aux_output_begin() are invoked when every time handle the
> interrupt.  The detailed flow is:
>
>   arm_spe_pmu_irq_handler()
>     `> arm_spe_pmu_buf_get_fault_act()
>          `> arm_spe_perf_aux_output_end()
>               `> set SPE registers
>               `> perf_aux_output_end()
>     `> arm_spe_perf_aux_output_begin()
>          `> perf_aux_output_begin()
>          `> set SPE registers
>
> Seems to me, a possible solution is to add an extra parameter 'int
> in_interrupt' for functions arm_spe_perf_aux_output_end() and
> arm_spe_perf_aux_output_begin(), if this parameter is passed as 1 in
> the interrupt handling, these two functions should skip invoking
> perf_aux_output_end() and perf_aux_output_begin() so can avoid the
> redundant perf event PERF_RECORD_AUX.
>
>   arm_spe_pmu_irq_handler()
>     `> arm_spe_pmu_buf_get_fault_act()
>          `> arm_spe_perf_aux_output_end(..., in_interrupt=1)
>               `> set SPE registers
>     `> arm_spe_perf_aux_output_begin(..., in_interrupt=1)
>          `> set SPE registers
>
> P.s. I think Intel-PT has supported free run mode for snapshot mode,
> so it should not generate interrupt in this mode.  Thus Intel-PT can
> avoid this issue, please see the code [2].
>
> Thanks,
> Leo
>
> [1] https://people.linaro.org/~leo.yan/spe/snapshot_test/perf.data
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/pt.c#n753
