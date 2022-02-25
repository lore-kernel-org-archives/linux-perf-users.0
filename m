Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474F1C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Feb 2022 19:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiBYTiB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Feb 2022 14:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiBYTh4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Feb 2022 14:37:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5DD2BDC
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Feb 2022 11:37:20 -0800 (PST)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K50KN0cBZz67DRW;
        Sat, 26 Feb 2022 03:32:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 25 Feb 2022 20:37:17 +0100
Received: from [10.47.84.151] (10.47.84.151) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Feb
 2022 19:37:16 +0000
Message-ID: <922424c8-f668-a600-ebca-ae9d181cf8e2@huawei.com>
Date:   Fri, 25 Feb 2022 19:37:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 0/2] perf tool versioning fixes
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <olsajiri@gmail.com>, <rric@kernel.org>, <ak@linux.intel.com>
References: <1645449409-158238-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <1645449409-158238-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.151]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 21/02/2022 13:16, John Garry wrote:
> This series includes a couple of fixes I made from working on a clone of
> acme.git
> 

Hi Arnaldo,

Can you kindly check this series if you get a chance? If you try from a 
clone of your own git you may see the issue reported in 2/2.

Thanks!!

> It is based on perf/urgent @ commit b3d971ec2534.
> 
> Differences to v1:
> - Add patch to fix kernel version tag
> - Fix perf out-of-tree build
> 
> John Garry (2):
>    perf: Fix dependency for version file creation
>    perf: Fix version kernel tag
> 
>   tools/perf/Makefile.perf         |  4 ++--
>   tools/perf/util/PERF-VERSION-GEN | 13 ++++---------
>   2 files changed, 6 insertions(+), 11 deletions(-)
> 

