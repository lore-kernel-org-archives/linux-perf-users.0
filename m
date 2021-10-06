Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D38C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7DB61152
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhJFIpe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:45:34 -0400
Received: from foss.arm.com ([217.140.110.172]:33206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhJFIpd (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 04:45:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50EB86D;
        Wed,  6 Oct 2021 01:43:41 -0700 (PDT)
Received: from [10.57.43.98] (unknown [10.57.43.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C7D83F766;
        Wed,  6 Oct 2021 01:43:38 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] perf vendor events: Categorise the Neoverse V1
 counters
To:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211006081106.8649-1-andrew.kilroy@arm.com>
 <20211006081106.8649-3-andrew.kilroy@arm.com>
 <03152b9d-2ad1-7bd3-e5a7-fc899c8c567c@huawei.com>
From:   Andrew Kilroy <andrew.kilroy@arm.com>
Message-ID: <f657b6e5-3fc2-0ec2-68f8-bc196afface7@arm.com>
Date:   Wed, 6 Oct 2021 09:43:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <03152b9d-2ad1-7bd3-e5a7-fc899c8c567c@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 06/10/2021 09:38, John Garry wrote:
> On 06/10/2021 09:11, Andrew Kilroy wrote:
>> This is so they are categorised in the perf list output.  The pmus all
>> exist in the armv8-common-and-microarch.json and arm-recommended.json
>> files, so this commit places them into each category's own file under
>>
>>    tools/perf/pmu-events/arch/arm64/arm/neoverse-v1
>>
>> Also add the Neoverse V1 to the arm64 mapfile
>>
>> Signed-off-by: Andrew Kilroy<andrew.kilroy@arm.com>
>> ---
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
> Note: for the other 2x patches in the series, you should have picked up 
> my reviewed-by tag for v2 (unless they have changed significantly from 
> when the tag was originally granted).
> 
> Thanks,
> John
> 
> 

Thanks, I wasn't aware of that, quite new to this.  :-)

Andrew
