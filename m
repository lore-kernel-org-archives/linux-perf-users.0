Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BB0C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 13:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE39D60F6E
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 13:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJUNFB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:05:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4016 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJUNFB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 09:05:01 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HZncn4yNdz67jnC;
        Thu, 21 Oct 2021 20:59:37 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Thu, 21 Oct 2021 15:02:43 +0200
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 14:02:42 +0100
Subject: Re: [PATCH v2 0/2] perf jevents: Enable build warnings
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <mingo@redhat.com>, <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kjain@linux.ibm.com>, <james.clark@arm.com>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
 <YXFjSR6ZRQbMjiG3@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9075dc5c-25a2-c977-a1c2-675e972115e7@huawei.com>
Date:   Thu, 21 Oct 2021 14:02:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YXFjSR6ZRQbMjiG3@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 21/10/2021 13:55, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 21, 2021 at 05:16:43PM +0800, John Garry escreveu:
>> Currently jevents builds without any complier warning flags enabled. So
>> use newly-defined HOSTCFLAGS, which comes from EXTRA_WARNINGS.
>>
>> Changes for v2:
>> - Add Werror, Wall, and Wextra (James Clark suggestion)
> 
> Thanks, applied.
> 

Hi Arnaldo,

Can you please wait until I check the review response from jirka?

Thanks

> - Arnaldo
> 
>   
>> Baseline is acme perf/core + mainline commit b94729919db2 ("perf jevents:
>> Free the sys_event_tables list after processing entries"):
>>
>> 680453e63302 perf jevents: Free the sys_event_tables list after processing entries
>> be8ecc57f180 (origin/perf/core) perf srcline: Use long-running addr2line per DSO
>> 2b775152bbe8 perf tests vmlinux-kallsyms: Ignore hidden symbols
>>
>> John Garry (2):
>>    perf jevents: Fix some would-be warnings
>>    perf jevents: Enable warnings through HOSTCFLAGS
>>
>>   tools/perf/Makefile.config      |  5 +++++
>>   tools/perf/Makefile.perf        |  2 +-
>>   tools/perf/pmu-events/Build     |  2 +-
>>   tools/perf/pmu-events/jevents.c | 10 ++++------
>>   4 files changed, 11 insertions(+), 8 deletions(-)
>>
>> -- 
>> 2.17.1
> 

