Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8310EC5479D
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Jan 2023 15:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjAKPOU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjAKPOL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Jan 2023 10:14:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D866411C05;
        Wed, 11 Jan 2023 07:14:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 671DFFEC;
        Wed, 11 Jan 2023 07:14:52 -0800 (PST)
Received: from [10.57.45.242] (unknown [10.57.45.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 543903F71A;
        Wed, 11 Jan 2023 07:14:07 -0800 (PST)
Message-ID: <974e7d1e-45c1-217f-1331-8cb498b187eb@arm.com>
Date:   Wed, 11 Jan 2023 15:14:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/7] perf: Use perf_pmu__open_file() and
 perf_pmu__scan_file()
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        mike.leach@linaro.org, sgoutham@marvell.com, gcherian@marvell.com,
        lcherian@marvell.com, bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230103162042.423694-1-james.clark@arm.com>
 <20230103162042.423694-3-james.clark@arm.com>
 <Y75gXmBZXQueCuvO@leoy-yangtze.lan>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Y75gXmBZXQueCuvO@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/01/2023 07:09, Leo Yan wrote:
> On Tue, Jan 03, 2023 at 04:20:36PM +0000, James Clark wrote:
>> Remove some code that duplicates existing methods. This requires that
>> some consts are removed because one of the existing helper methods takes
>> a struct perf_pmu instead of a name which has a non const name field.
>> But except for the tests, the strings were already non const.
>>
>> No functional changes.
> 
> [...]
> 
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 2f2bb0286e2a..8f39e2d17fb1 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -2,6 +2,7 @@
>>  #ifndef __PMU_H
>>  #define __PMU_H
>>  
>> +#include <bits/types/FILE.h>
> 
> Nitpick: it's good to use <stdio.h> to replace <bits/types/FILE.h>.
> 
> Either way, this patch looks good to me:

Looks like I also forgot to update the commit message about removing the
consts after the last change. Will update both in the next change.

Thanks for the review!

> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
