Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4E5C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 00:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DC761042
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 00:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhJHAFV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 20:05:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:57364 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233133AbhJHAFU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 20:05:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="225174146"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="225174146"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 17:03:26 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="440455701"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.19.60]) ([10.209.19.60])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 17:03:25 -0700
Message-ID: <b24041af-1c92-3855-9659-133e73a0c241@linux.intel.com>
Date:   Thu, 7 Oct 2021 17:03:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/4] perf vendor events: Syntax corrections in Neoverse N1
 json
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211004160008.21645-1-andrew.kilroy@arm.com>
 <b7a4a1b3-3d22-7a52-75b1-66c04b57a50c@huawei.com>
 <0743bf83-2e5d-8830-61bc-ed0731db108d@arm.com>
 <83767166-e379-a352-d920-ad8b6e923800@huawei.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <83767166-e379-a352-d920-ad8b6e923800@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 10/6/2021 9:26 AM, John Garry wrote:
> On 06/10/2021 09:43, James Clark wrote:
>
> + Andi
>
>>
>>
>> On 05/10/2021 11:10, John Garry wrote:
>>> On 04/10/2021 17:00, Andrew Kilroy wrote:
>>>> There are some syntactical mistakes in the json files for the 
>>>> Cortex A76
>>>> N1 (Neoverse N1).  This was obstructing parsing from an external tool.
>>>
>>> If the trailing comma is not allowed by standard, then maybe we 
>>> should fix our parsing tool to not allow it also. However maybe 
>>> there is a good reason why we allow it..
>>
>> It would be nice to do, because I have also made similar fixes 
>> before. We looked at the STRICT option
>> in the parser (https://github.com/zserge/jsmn), but even then it 
>> seems to allow trailing commas.
>>
>> Trailing commas are not allowed in the json standard, but there is a 
>> split between parsers
>> where some allow it and others don't. Specifically the Python parser 
>> doesn't allow it, and Python
>> can easily be involved in some workflow that parses these files.
>>
>> The only way forwards I can think of is either getting a change 
>> accepted upstream to the parser
>> and then updating it in perf, switching to a different parser, or 
>> doing some hack to add an extra
>> step in perf to look for commas. None of which sound ideal.
>>
>
> Looking at the license in jsmn.c, we seem to be ok to modify it (to 
> error on non-standard trailing ',') - that parser has already 
> apparently been modified in mainline.
>
> If we do that then I hope that there are not to many violations in out 
> JSONs, including downstream.


Sure we can modify the file. I already did some minor changes when I 
submitted it originally.

-Andi


