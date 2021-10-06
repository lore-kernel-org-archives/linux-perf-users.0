Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3127AC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 16:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164D4610EA
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 16:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbhJFQZ2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:25:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3941 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhJFQZV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 12:25:21 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HPfnD5DnCz67Xd6;
        Thu,  7 Oct 2021 00:20:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 6 Oct 2021 18:23:27 +0200
Received: from [10.47.95.252] (10.47.95.252) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 17:23:26 +0100
Subject: Re: [PATCH 1/4] perf vendor events: Syntax corrections in Neoverse N1
 json
To:     James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andi Kleen <ak@linux.intel.com>
References: <20211004160008.21645-1-andrew.kilroy@arm.com>
 <b7a4a1b3-3d22-7a52-75b1-66c04b57a50c@huawei.com>
 <0743bf83-2e5d-8830-61bc-ed0731db108d@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <83767166-e379-a352-d920-ad8b6e923800@huawei.com>
Date:   Wed, 6 Oct 2021 17:26:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0743bf83-2e5d-8830-61bc-ed0731db108d@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.95.252]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 06/10/2021 09:43, James Clark wrote:

+ Andi

> 
> 
> On 05/10/2021 11:10, John Garry wrote:
>> On 04/10/2021 17:00, Andrew Kilroy wrote:
>>> There are some syntactical mistakes in the json files for the Cortex A76
>>> N1 (Neoverse N1).  This was obstructing parsing from an external tool.
>>
>> If the trailing comma is not allowed by standard, then maybe we should fix our parsing tool to not allow it also. However maybe there is a good reason why we allow it..
> 
> It would be nice to do, because I have also made similar fixes before. We looked at the STRICT option
> in the parser (https://github.com/zserge/jsmn), but even then it seems to allow trailing commas.
> 
> Trailing commas are not allowed in the json standard, but there is a split between parsers
> where some allow it and others don't. Specifically the Python parser doesn't allow it, and Python
> can easily be involved in some workflow that parses these files.
> 
> The only way forwards I can think of is either getting a change accepted upstream to the parser
> and then updating it in perf, switching to a different parser, or doing some hack to add an extra
> step in perf to look for commas. None of which sound ideal.
> 

Looking at the license in jsmn.c, we seem to be ok to modify it (to 
error on non-standard trailing ',') - that parser has already apparently 
been modified in mainline.

If we do that then I hope that there are not to many violations in out 
JSONs, including downstream.

Thanks,
John
