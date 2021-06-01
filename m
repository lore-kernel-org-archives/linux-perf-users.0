Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E0DC4708F
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120E1613AB
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhFAJyz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:54:55 -0400
Received: from foss.arm.com ([217.140.110.172]:45498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhFAJyz (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 05:54:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DBD011D4;
        Tue,  1 Jun 2021 02:53:14 -0700 (PDT)
Received: from [10.57.9.215] (unknown [10.57.9.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B215B3F73D;
        Tue,  1 Jun 2021 02:53:11 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] coresight: etm-perf: Correct buffer syncing for
 snapshot
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <20210528161552.654907-2-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <f29d2d68-2735-dddf-b872-6163d1dbc8f0@arm.com>
Date:   Tue, 1 Jun 2021 12:53:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210528161552.654907-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 28/05/2021 19:15, Leo Yan wrote:
> The perf tool records the Arm CoreSight trace data with snapshot mode
> with the option '-S', when receiving USR2 signal, it is observed the
> captured trace data size is very varied: from several MBs to ~20MBs.
> This can be reproduced with the command:
> 
>   perf record -e cs_etm// -S \
> 	-- dd if=/dev/zero of=/dev/null > /dev/null 2>&1 &
>   PERFPID=$!
>   sleep 1
>   kill -USR2 $PERFPID
> 
> It's different for only specifying option '-S' than options '-a -S'.  If
> without option '-a', perf tool creates separate AUX buffers for every
> CPU, but the tracer will be enabled only when the profiled program is
> scheduled onto the corresponding CPU, this might lead to record very
> old trace data when snapshot.
> 
> Let's see below diagram:
>                                                             snapshot
>   CPU0: ______###P1###__________________________________________|
>   CPU1: __________________________###P3###____________###P5###__|
>   CPU2: ____________________________________###P4###____________|
>   CPU3: ________________###P2###________________________________V
> 
> In this diagram, the program runs for 5 periods (from P1 to P5), these 5
> periods show the task run on different CPUs, e.g. during P1 period the
> program runs on CPU0, and during P2 period the program is migrated to
> CPU1, and so on.  At the end of P1 period when the program is switched
> out from CPU0, the ETR trace data is saved into AUX trace buffer, this
> AUX buffer is a dedicated buffer for CPU0's tracer.  With the same
> logic, P2's trace data is saved into CPU3's tracer buffer, P4's trace
> data is saved into CPU2's buffer, P3 and P5's trace data is saved into
> CPU1's.  Therefore, when snapshot, it saves the trace data from all AUX
> ring buffers (in this case, it have total 4 AUX ring buffers) into perf
> data file.

Hi Leo,

I was testing out snapshot mode (without your patch) and I noticed that it
only ever collects from the last CPU. For example on a 4 core system,
the CPU ID of the AUX records and the AUXTRACE buffers is always 3.

This is with systemwide tracing, and running "stress -m 2 -c 2".
Is this something that your patch fixes, or am I doing something wrong, or
is it just a coincidence?

Here's a snippet of the output:

	./perf report -D | grep AUX
	0 0 0x200 [0x168]: PERF_RECORD_AUXTRACE_INFO type: 3
	0 0 0x152248 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0  ref: 0x75e0bdc44ea1bb65  idx: 3  tid: -1  cpu: 3
	3 583600975364460 0x152160 [0x40]: PERF_RECORD_AUX offset: 0x400000 size: 0x400000 flags: 0x2 [O]
	0 0 0x55c950 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0x400000  ref: 0x6f506d2d02841da4  idx: 3  tid: -1  cpu: 3
	3 583602209157460 0x55c908 [0x40]: PERF_RECORD_AUX offset: 0x800000 size: 0x400000 flags: 0x2 [O]
	0 0 0x9624d8 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0x800000  ref: 0x2d83d30161e1117a  idx: 3  tid: -1  cpu: 3
	3 583602526365800 0x962490 [0x40]: PERF_RECORD_AUX offset: 0xc00000 size: 0x400000 flags: 0x2 [O]
	0 0 0xd65f00 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0xc00000  ref: 0x5013e6e2a3c97c9  idx: 3  tid: -1  cpu: 3
	3 583602714310320 0xd65eb8 [0x40]: PERF_RECORD_AUX offset: 0x1000000 size: 0x400000 flags: 0x2 [O]
	0 0 0x1169be8 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0x1000000  ref: 0x67b37e157f843269  idx: 3  tid: -1  cpu: 3
	3 583602874193840 0x1169ba0 [0x40]: PERF_RECORD_AUX offset: 0x1400000 size: 0x400000 flags: 0x2 [O]
	0 0 0x156d550 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0x1400000  ref: 0x3cb268b926f22d41  idx: 3  tid: -1  cpu: 3
	3 583603044203980 0x156d508 [0x40]: PERF_RECORD_AUX offset: 0x1800000 size: 0x400000 flags: 0x2 [O]
	0 0 0x1971238 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0x1800000  ref: 0x4905e0a21d5d35d7  idx: 3  tid: -1  cpu: 3
	3 583603211393440 0x19711f0 [0x40]: PERF_RECORD_AUX offset: 0x1c00000 size: 0x400000 flags: 0x2 [O]
	0 0 0x1d747e0 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0x1c00000  ref: 0x4f8f48007f7d70e7  idx: 3  tid: -1  cpu: 3
	3 583603362643100 0x1d74798 [0x40]: PERF_RECORD_AUX offset: 0x2000000 size: 0x400000 flags: 0x2 [O]
	0 0 0x2178368 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0x2000000  ref: 0x770d07213be2d29a  idx: 3  tid: -1  cpu: 3
	3 583603526029900 0x2178320 [0x40]: PERF_RECORD_AUX offset: 0x2400000 size: 0x400000 flags: 0x2 [O]
	0 0 0x257bfb0 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0x2400000  ref: 0x2e4ed1454815c13e  idx: 3  tid: -1  cpu: 3
	3 583603687951260 0x257bf68 [0x40]: PERF_RECORD_AUX offset: 0x2800000 size: 0x400000 flags: 0x2 [O]
	0 0 0x297fb18 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0x2800000  ref: 0x644eba01d391129  idx: 3  tid: -1  cpu: 3

Thanks
James
