Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F90DC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBFA61042
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbhJGRVg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:21:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3942 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243264AbhJGRVb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:21:31 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HQHzz5BJqz67nPb;
        Fri,  8 Oct 2021 01:16:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 7 Oct 2021 19:19:34 +0200
Received: from [10.47.80.141] (10.47.80.141) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 7 Oct 2021
 18:19:33 +0100
Subject: Re: [PATCH 1/3] perf vendor-events: Fix all remaining invalid JSON
 files
To:     James Clark <james.clark@arm.com>, <acme@kernel.org>,
        <ak@linux.intel.com>, <linux-perf-users@vger.kernel.org>
CC:     <Nick.Forrington@arm.com>, <Andrew.Kilroy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211007110543.564963-1-james.clark@arm.com>
 <20211007110543.564963-2-james.clark@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c73a8d30-a2ed-fec7-1537-c0ec79c1ad6f@huawei.com>
Date:   Thu, 7 Oct 2021 18:22:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211007110543.564963-2-james.clark@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.141]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 07/10/2021 12:05, James Clark wrote:
> Remove trailing commas. A later commit will make the parser more strict
> and these will not be valid anymore.
> 
> Signed-off-by: James Clark<james.clark@arm.com>
> ---
>   .../arch/arm64/ampere/emag/bus.json           |  2 +-
>   .../arch/arm64/ampere/emag/cache.json         | 20 +++++++++----------
>   .../arch/arm64/ampere/emag/clock.json         |  2 +-
>   .../arch/arm64/ampere/emag/exception.json     |  4 ++--
>   .../arch/arm64/ampere/emag/instruction.json   | 10 +++++-----
>   .../arch/arm64/ampere/emag/memory.json        |  4 ++--
>   .../arch/arm64/hisilicon/hip08/metrics.json   |  2 +-
>   .../pmu-events/arch/nds32/n13/atcpmu.json     |  2 +-
>   .../pmu-events/arch/s390/cf_z10/basic.json    |  2 +-
>   .../pmu-events/arch/s390/cf_z10/crypto.json   |  2 +-
>   .../pmu-events/arch/s390/cf_z10/extended.json |  2 +-
>   .../pmu-events/arch/s390/cf_z13/basic.json    |  2 +-
>   .../pmu-events/arch/s390/cf_z13/crypto.json   |  2 +-
>   .../pmu-events/arch/s390/cf_z13/extended.json |  2 +-
>   .../pmu-events/arch/s390/cf_z14/basic.json    |  2 +-
>   .../pmu-events/arch/s390/cf_z14/crypto.json   |  2 +-
>   .../pmu-events/arch/s390/cf_z14/extended.json |  2 +-
>   .../pmu-events/arch/s390/cf_z15/basic.json    |  2 +-
>   .../pmu-events/arch/s390/cf_z15/crypto.json   |  2 +-
>   .../pmu-events/arch/s390/cf_z15/crypto6.json  |  2 +-
>   .../pmu-events/arch/s390/cf_z15/extended.json |  2 +-
>   .../pmu-events/arch/s390/cf_z196/basic.json   |  2 +-
>   .../pmu-events/arch/s390/cf_z196/crypto.json  |  2 +-
>   .../arch/s390/cf_z196/extended.json           |  2 +-
>   .../pmu-events/arch/s390/cf_zec12/basic.json  |  2 +-
>   .../pmu-events/arch/s390/cf_zec12/crypto.json |  2 +-
>   .../arch/s390/cf_zec12/extended.json          |  2 +-
>   .../arch/test/test_soc/cpu/uncore.json        |  2 +-
>   .../arch/x86/icelakex/icx-metrics.json        |  2 +-


This seems fine. But, as mentioned earlier, I do worry that some of 
these JSONs are copied from some downstream repositories, and now they 
will go out of sync. That could cause problems, so need to check with 
respective owners.

Apart from that caveat, it seems ok:

Reviewed-by: John Garry <john.garry@huawei.com>


