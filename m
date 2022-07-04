Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A104EC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Jul 2022 10:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiGDKDZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Jul 2022 06:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiGDKDK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Jul 2022 06:03:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E93FADEE6;
        Mon,  4 Jul 2022 03:02:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2CE23A;
        Mon,  4 Jul 2022 03:02:08 -0700 (PDT)
Received: from [10.1.39.147] (e127744.cambridge.arm.com [10.1.39.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A13183F792;
        Mon,  4 Jul 2022 03:02:05 -0700 (PDT)
Subject: Re: [PATCH v3] perf test: Add ARM SPE system wide test
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
References: <20220701230932.1000495-1-namhyung@kernel.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <88d3ad86-2a9c-a179-8ff7-c1e1a75ba2ea@arm.com>
Date:   Mon, 4 Jul 2022 11:01:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220701230932.1000495-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 02/07/2022 00:09, Namhyung Kim wrote:
> In the past it had a problem not setting the pid/tid on the sample
> correctly when system-wide mode is used.  Although it's fixed now it'd
> be nice if we have a test case for it.
>
> Cc: German Gomez <german.gomez@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: German Gomez <german.gomez@arm.com>

> ---
> * skip if system-wide record was failed
> * use dummy event for testing

Thanks,
German
