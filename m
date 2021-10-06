Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C919C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6226361139
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbhJFIhp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:37:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3937 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbhJFIho (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 04:37:44 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HPSPK4s3Qz67Wpc;
        Wed,  6 Oct 2021 16:32:21 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 6 Oct 2021 10:35:51 +0200
Received: from [10.47.95.252] (10.47.95.252) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 09:35:50 +0100
Subject: Re: [PATCH v2 3/3] perf vendor events: Categorise the Neoverse V1
 counters
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211006081106.8649-1-andrew.kilroy@arm.com>
 <20211006081106.8649-3-andrew.kilroy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <03152b9d-2ad1-7bd3-e5a7-fc899c8c567c@huawei.com>
Date:   Wed, 6 Oct 2021 09:38:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211006081106.8649-3-andrew.kilroy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.252]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 06/10/2021 09:11, Andrew Kilroy wrote:
> This is so they are categorised in the perf list output.  The pmus all
> exist in the armv8-common-and-microarch.json and arm-recommended.json
> files, so this commit places them into each category's own file under
> 
>    tools/perf/pmu-events/arch/arm64/arm/neoverse-v1
> 
> Also add the Neoverse V1 to the arm64 mapfile
> 
> Signed-off-by: Andrew Kilroy<andrew.kilroy@arm.com>
> ---

Reviewed-by: John Garry <john.garry@huawei.com>

Note: for the other 2x patches in the series, you should have picked up 
my reviewed-by tag for v2 (unless they have changed significantly from 
when the tag was originally granted).

Thanks,
John


