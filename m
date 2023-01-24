Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0ADC25B4E
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 11:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjAXLIo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Jan 2023 06:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjAXLIj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Jan 2023 06:08:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC1B530B06;
        Tue, 24 Jan 2023 03:08:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12F571FB;
        Tue, 24 Jan 2023 03:09:18 -0800 (PST)
Received: from [10.1.32.60] (FVFF763DQ05P.cambridge.arm.com [10.1.32.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B7E3F64C;
        Tue, 24 Jan 2023 03:08:34 -0800 (PST)
Message-ID: <1dbd558a-92b7-77ed-1bbe-0f421547bf54@arm.com>
Date:   Tue, 24 Jan 2023 11:08:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] perf: cs-etm: Improve missing sink warning message
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
References: <20230124110220.460551-1-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230124110220.460551-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 24/01/2023 11:02, James Clark wrote:
> Make the sink error message more similar to the event error message that
> reminds about missing kernel support. The available sinks are also
> determined by the hardware so mention that too.
> 
> Also, usually it's not necessary to specify the sink, so add that as a
> hint.
> 
> Now the error for a made up sink looks like this:
> 
>    $ perf record -e cs_etm/@abc/
>    Couldn't find sink "abc" on event cs_etm/@abc/.
>    Missing kernel or device support?
> 
>    Hint: An appropriate sink will be picked automatically if one isn't is specified.
> 
> For any error other than ENOENT, the same message as before is
> displayed.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


