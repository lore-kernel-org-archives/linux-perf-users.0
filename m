Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5335EC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Mar 2022 11:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347342AbiCOLdH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Mar 2022 07:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbiCOLdG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Mar 2022 07:33:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887C24F9F9
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Mar 2022 04:31:54 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KHrmr55YNz683nW;
        Tue, 15 Mar 2022 19:30:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 15 Mar 2022 12:31:52 +0100
Received: from [10.47.84.96] (10.47.84.96) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 15 Mar
 2022 11:31:51 +0000
Message-ID: <2cad1efe-29e0-930f-de85-1911df38dde5@huawei.com>
Date:   Tue, 15 Mar 2022 11:31:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/2] perf: Fix version kernel tag
To:     Ian Rogers <irogers@google.com>, <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <olsajiri@gmail.com>, <rric@kernel.org>, <ak@linux.intel.com>
References: <1645449409-158238-1-git-send-email-john.garry@huawei.com>
 <1645449409-158238-3-git-send-email-john.garry@huawei.com>
 <CAP-5=fXT3VYB2uBXmihuruq==FENLFcFSHMLY0Fk29pRvU-wag@mail.gmail.com>
 <ebde0845-fa4b-0e6c-c9e6-6c8d27377952@huawei.com>
 <CAP-5=fUHbuhFeUPTktithxc=NR5ahhF66jWQ2xOZKA=Azj96NQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAP-5=fUHbuhFeUPTktithxc=NR5ahhF66jWQ2xOZKA=Azj96NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.96]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 14/03/2022 22:12, Ian Rogers wrote:
>> john@localhost:~/acme_test> git describe --abbrev=0 --match "v[0-9].[0-9]*"
>> v5.17-rc4
>>
>> So you can see that "git describe" gives the wrong result (v4.13-rc5)
>> before we pull in torvalds git.
>>
>> My point is that git tags are unreliable and we should avoid them.
> 
> (Plain text resend)
> 
> Got it, thanks for the detailed explanation!
> 
> Acked-by: Ian Rogers<irogers@google.com>

Great, thanks

Arnaldo, Can you kindly consider picking up this series?

Cheers,
John
