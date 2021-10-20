Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB49BC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961E0613AC
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJTOnW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:43:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4009 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTOnW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 10:43:22 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HZCrn313Rz67YrM;
        Wed, 20 Oct 2021 22:38:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 16:41:05 +0200
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 15:41:05 +0100
Subject: Re: [PATCH 0/2] perf jevents: Enable build warnings
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <mingo@redhat.com>, <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "James Clark" <James.Clark@arm.com>
References: <1634316507-227751-1-git-send-email-john.garry@huawei.com>
 <YXAoOgRVfkzr5vcS@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <744e6d05-eaec-49d9-1e3d-2f96d4e01e1a@huawei.com>
Date:   Wed, 20 Oct 2021 15:41:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YXAoOgRVfkzr5vcS@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 20/10/2021 15:31, Arnaldo Carvalho de Melo wrote:
> Em Sat, Oct 16, 2021 at 12:48:25AM +0800, John Garry escreveu:
>> Currently jevents builds without any complier warning flags enabled. So
>> use newly-defined HOSTCFLAGS, which comes from EXTRA_WARNINGS. I am not
>> 100% confident that this is the best way, but sending out for review.
>>
>> Baseline is be8ecc57f180 (HEAD, acme/perf/core) perf srcline: Use
>> long-running addr2line per DSO
> 
> Thanks, applied.
> 

Hi Arnaldo,

I was going to send a v2, with changes according to James Clark's review 
  - that was to add -Wall & -Werror, but they caused a problem on your 
perf/core branch as they triggered the warn fixed in commit b94729919db2.

I suppose the best thing now is to send a patch on top once perf/core 
contains that commit. Let me know otherwise.

Thanks
