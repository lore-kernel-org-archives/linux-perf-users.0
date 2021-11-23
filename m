Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64A7C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 11:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbhKWLoy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:44:54 -0500
Received: from foss.arm.com ([217.140.110.172]:51418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229939AbhKWLox (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 06:44:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4D671063;
        Tue, 23 Nov 2021 03:41:45 -0800 (PST)
Received: from [10.1.38.165] (e127744.cambridge.arm.com [10.1.38.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 202913F5A1;
        Tue, 23 Nov 2021 03:41:43 -0800 (PST)
Subject: Re: [PATCH 1/1] perf arm-spe: extend Arm SPE test script with
 regression testing
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20211112162005.11876-1-german.gomez@arm.com>
 <20211112162005.11876-2-german.gomez@arm.com>
 <20211123051924.GE124250@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <4ab0260a-3acb-e515-c963-91de35385d07@arm.com>
Date:   Tue, 23 Nov 2021 11:41:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123051924.GE124250@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

Thanks for the comments.

On 23/11/2021 05:19, Leo Yan wrote:
> Hi German,
>
> On Fri, Nov 12, 2021 at 04:20:03PM +0000, German Gomez wrote:
>> Extend the test_arm_spe.sh script to test for regressions in the
>> decoding flow of Arm SPE samples. In order to support the tests, a set
>> of perf.data files has been generated offline and is being hosted under
>> tools/perf/tests/shell/test_arm_spe.tgz:
> Seems to me it's not a good idea to upstream perf data binaries into the
> mainline kernel.  I understood you want to test the perf data with
> different context tracing modes (using contextidr vs switch events),
> since these two different modes we cannot capture them with the same
> kernel Image, I think this is the main reason you upstreamed the perf
> data binaries in this patch.

For this patch I wanted to test the decoding of SPE events, given fixed
inputs, in order to lock the current implementation of the decoder.

>
> On the other hand, like CoreSight smoke testing, by default we can give
> priority for testing root PID namespace, so you could do the test with
> below commands, which is assumed that tracing PID in contextidr:
>
>   perf record -e arm_spe_0// -- test_program
>   perf report
>   perf script
>
> Then, for testing non-root PID namespace, can we use the command
> "unshare" to create a namespace and run perf tool in a non-root
> PID namespace?  In this way, you could record Arm SPE trace data and
> decode it on the fly.  Finally we can avoid to upstream perf data
> binaries.

I think adding additional smoke testing is a good idea. We could also
check if CONTEXTIDR is enabled in the config (either /boot/config... or
/proc/config.gz).


Thanks,
German

>
> Thanks,
> Leo
