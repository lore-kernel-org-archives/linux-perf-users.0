Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB32EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 11:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A822B60249
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 11:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJ1LnS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:43:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4037 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhJ1LnR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 07:43:17 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hg3Ss1wDfz67n0f;
        Thu, 28 Oct 2021 19:37:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 13:40:48 +0200
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 12:40:48 +0100
Subject: Re: [PATCH v2 2/2] perf jevents: Enable warnings through HOSTCFLAGS
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "irogers@google.com" <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "james.clark@arm.com" <james.clark@arm.com>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
 <1634807805-40093-3-git-send-email-john.garry@huawei.com>
 <YXFhr2YoVp9GPsDM@krava> <86aee893-0b6b-bce3-d1aa-3b66365592d1@huawei.com>
 <YXaXvGgvs4gr8Cgi@krava> <YXbZa8SaQta9pzHS@kernel.org>
 <32d98804-7e56-e73b-4c66-8776dbf58ddf@huawei.com>
 <YXqG0jb4qg4+x5DE@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <013643b0-a20f-eaa0-498b-44ba323a3209@huawei.com>
Date:   Thu, 28 Oct 2021 12:40:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YXqG0jb4qg4+x5DE@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 28/10/2021 12:17, Arnaldo Carvalho de Melo wrote:
>> Maybe, but then renaming back from KBUILD_HOSTCFLAGS -> HOSTCFLAGS seems odd
>> as a fix
>   
>> Anyway, now that this original series is in perf/core,
> Nope, just this one landed:
> 
> commit 342cb7ebf5e29fff4dc09ab2c8f37d710f8f5206
> Author: John Garry<john.garry@huawei.com>
> Date:   Thu Oct 21 17:16:44 2021 +0800
> 
>      perf jevents: Fix some would-be warnings
> 
> ---
> 
> The one you asked to wait for further discussion wasn't merged.

ah, at I glance I saw my name and this patch and assumed both were in.

OK, so I'll put together a new series soon and post that.

Thanks
