Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07476C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 13:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhKVNt4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:49:56 -0500
Received: from foss.arm.com ([217.140.110.172]:41664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhKVNtz (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 08:49:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C65481063;
        Mon, 22 Nov 2021 05:46:48 -0800 (PST)
Received: from [10.1.35.125] (e127744.cambridge.arm.com [10.1.35.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A40F3F66F;
        Mon, 22 Nov 2021 05:46:46 -0800 (PST)
Subject: Re: [PATCH 1/1] perf arm-spe: extend Arm SPE test script with
 regression testing
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     James Clark <james.clark@arm.com>, leo.yan@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20211112162005.11876-1-german.gomez@arm.com>
 <20211112162005.11876-2-german.gomez@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <f5abae0b-acf8-f674-30f1-4b5c1fe6a49e@arm.com>
Date:   Mon, 22 Nov 2021 13:46:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211112162005.11876-2-german.gomez@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 12/11/2021 16:20, German Gomez wrote:
> Extend the test_arm_spe.sh script to test for regressions in the
> decoding flow of Arm SPE samples. In order to support the tests, a set
> of perf.data files has been generated offline and is being hosted under
> tools/perf/tests/shell/test_arm_spe.tgz:
>
> (See perf report --header-only to see the actual commands used)

Looking back at this patch, I don't think it can be applied as is. I
notice that the docs for the --itrace argument aren't up to date (it
says the default is --itrace=ibxwpe but lately it has changed ([1] &
[2]). The value of --itrace should be locked in the test script.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/itrace.txt?id=136057256686de39cc3a07c2e39ef6bc43003ff6#n26
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/auxtrace.c?id=136057256686de39cc3a07c2e39ef6bc43003ff6#n1335

>
>   - test_arm_spe.tgz
>     `- arm_spe_decode_contextidr.data
>     `- arm_spe_decode_contextidr.data.inject
>     `- arm_spe_decode_switch_events.data
>     `- arm_spe_decode_switch_events.data.inject
>
> [...]
