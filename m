Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E622541D;
	Thu, 17 Apr 2025 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880762; cv=none; b=MON6nGSEFWch/p3TWn73kaVAEIn6R45idyfdfM1ykAibeFyhIwrTw8G/peEWsqXvOmni16kJ7S2HwL4Kt/JzddG42Ixj7TcHNrfV/RuO9X1L2S/C7FE9cHvTRgKRxEMvk2G7YI0nhUB85QLM5IIPYjl/Kem9Tf0Ts2Za6/EUR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880762; c=relaxed/simple;
	bh=7/CNDQRHe36v8RmqIV4xRN/kf7wuRIF3PTjvFYwy/MU=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eKlUPUnIKIOzSQCGoLsVqlLSzb+405LOgHek3Ic8lBmFf7paZgUVRi1F5yv3T6kBlqHVKNP5/28JQCm423GhRRe+MUdJCBpwoCKL1kvOvy/q6eUcUUyPSZkRGoGKzDBjqRCLJXFlvbctboIW42QDbBvvy+eHwzLb1mZhN96HHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZdX1t52wyzvWvY;
	Thu, 17 Apr 2025 17:01:22 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3278114010D;
	Thu, 17 Apr 2025 17:05:29 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 17:05:28 +0800
Received: from [10.67.120.218] (10.67.120.218) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 17:05:27 +0800
Subject: Re: [PATCH 1/2] perf vendor events arm64: Fill up Desc field for Hisi
 hip08 hha pmu
To: James Clark <james.clark@linaro.org>
References: <20250416020216.3377959-1-hejunhao3@huawei.com>
 <20250416020216.3377959-2-hejunhao3@huawei.com>
 <9f562c23-f790-4d82-b51e-79e63d04890a@linaro.org>
CC: <linuxarm@huawei.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <leo.yan@arm.com>, <john.g.garry@oracle.com>,
	<will@kernel.org>, <mike.leach@linaro.org>, <yangyicong@hisilicon.com>,
	<jonathan.cameron@huawei.com>, hejunhao <hejunhao3@huawei.com>
From: hejunhao <hejunhao3@huawei.com>
Message-ID: <4c2ddb5f-0d84-7b9e-7b0e-5fa1159b4be0@huawei.com>
Date: Thu, 17 Apr 2025 17:05:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9f562c23-f790-4d82-b51e-79e63d04890a@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn500004.china.huawei.com (7.202.194.145)


On 2025/4/16 21:17, James Clark wrote:
>
>
> On 16/04/2025 3:02 am, Junhao He wrote:
>> In the same PMU, when some JSON events have the "BriefDescription" field
>> populated while others do not, the cmp_sevent() function will split 
>> these
>> two types of events into separate groups. As a result, when using perf
>> list to display events, the two types of events cannot be grouped 
>> together
>> in the output.
>>
>
> Hi Junhao,
>
> I think just the first patch here [1] might have helped for this 
> issue. It would result in them being grouped together, although one 
> would still be missing the description so your change is ok either way.
>
> [1]: 
> https://lore.kernel.org/lkml/20250304-james-perf-hybrid-list-v1-1-a363ffac283c@linaro.org/
>

Hi James,

Thanks for the comments.

In the cmp_sevent() function [2], the comparison begins with checking 
sevent->desc.
Thus, the issue cannot be resolved by the patch [1].

Perhaps the simultaneous occurrence of hisi_sccl1_hha2 and hisi_sccl,hha 
is making this
commit hard to understand. This is part of the optimization I'm working 
on next, so
please ignore it for now. I will correct the PMU name and Unit in the 
next version.

[2]: 
https://elixir.bootlin.com/linux/v6.15-rc1/source/tools/perf/util/pmus.c#L435

>> before patch:
>>   $ perf list
>>   ...
>>   uncore hha:
>>     hisi_sccl1_hha2/sdir-hit/
>>     hisi_sccl1_hha2/sdir-lookup/
>>   ...
>>   uncore hha:
>>     edir-hit
>>        [Count of The number of HHA E-Dir hit operations. Unit: 
>> hisi_sccl,hha]
>>
>> after patch:
>>   $ perf list
>>   ...
>>   uncore hha:
>>     edir-hit
>>        [Count of The number of HHA E-Dir hit operations. Unit: 
>> hisi_sccl,hha]
>>     sdir-hit
>>        [Count of The number of HHA S-Dir hit operations. Unit: 
>> hisi_sccl,hha]
>>     sdir-lookup
>>        [Count of the number of HHA S-Dir lookup operations. Unit: 
>> hisi_sccl,hha]
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> ---
>>   .../arm64/hisilicon/hip08/uncore-hha.json     | 32 +++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git 
>> a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json 
>> b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
>> index 9a7ec7af2060..5ac8f919b498 100644
>> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
>> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
>> @@ -30,15 +30,21 @@
>>      {
>>           "ConfigCode": "0x4",
>>           "EventName": "rx_wbi",
>> +        "BriefDescription": "Count of the number of WriteBackI 
>> operations that HHA has received",
>> +        "PublicDescription": "Count of the number of WriteBackI 
>> operations that HHA has received",
>
> You only need BriefDescription if both are going to be the same. It 
> will be used for both short and long form output.
>
> With that:
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>

Ok, i will drop this PublicDescription.
I will append one new patch to drop other hip08 uncore PMU 
PublicDescriptions.

Best regards,
Junhao.

>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x5",
>>           "EventName": "rx_wbip",
>> +        "BriefDescription": "Count of the number of WriteBackIPtl 
>> operations that HHA has received",
>> +        "PublicDescription": "Count of the number of WriteBackIPtl 
>> operations that HHA has received",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x11",
>> +        "BriefDescription": "Count of the number of WriteThruIStash 
>> operations that HHA has received",
>> +        "PublicDescription": "Count of the number of WriteThruIStash 
>> operations that HHA has received",
>>           "EventName": "rx_wtistash",
>>           "Unit": "hisi_sccl,hha"
>>      },
>> @@ -87,66 +93,92 @@
>>      {
>>           "ConfigCode": "0x23",
>>           "EventName": "bi_num",
>> +        "BriefDescription": "Count of the number of HHA BackInvalid 
>> operations",
>> +        "PublicDescription": "Count of the number of HHA BackInvalid 
>> operations",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x32",
>>           "EventName": "mediated_num",
>> +        "BriefDescription": "Count of the number of Mediated 
>> operations that the HHA has forwarded",
>> +        "PublicDescription": "Count of the number of Mediated 
>> operations that the HHA has forwarded",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x33",
>>           "EventName": "tx_snp_num",
>> +        "BriefDescription": "Count of the number of Snoop operations 
>> that the HHA has sent",
>> +        "PublicDescription": "Count of the number of Snoop 
>> operations that the HHA has sent",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x34",
>>           "EventName": "tx_snp_outer",
>> +        "BriefDescription": "Count of the number of Snoop operations 
>> that the HHA has sent to another socket",
>> +        "PublicDescription": "Count of the number of Snoop 
>> operations that the HHA has sent to another socket",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x35",
>>           "EventName": "tx_snp_ccix",
>> +        "BriefDescription": "Count of the number of Snoop operations 
>> that the HHA has sent to CCIX",
>> +        "PublicDescription": "Count of the number of Snoop 
>> operations that the HHA has sent to CCIX",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x38",
>>           "EventName": "rx_snprspdata",
>> +        "BriefDescription": "Count of the number of SnprspData flit 
>> operations that HHA has received",
>> +        "PublicDescription": "Count of the number of SnprspData flit 
>> operations that HHA has received",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x3c",
>>           "EventName": "rx_snprsp_outer",
>> +        "BriefDescription": "Count of the number of SnprspData 
>> operations that HHA has received from another socket",
>> +        "PublicDescription": "Count of the number of SnprspData 
>> operations that HHA has received from another socket",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x40",
>>           "EventName": "sdir-lookup",
>> +        "BriefDescription": "Count of the number of HHA S-Dir lookup 
>> operations",
>> +        "PublicDescription": "Count of the number of HHA S-Dir 
>> lookup operations",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x41",
>>           "EventName": "edir-lookup",
>> +        "BriefDescription": "Count of the number of HHA E-Dir lookup 
>> operations",
>> +        "PublicDescription": "Count of the number of HHA E-Dir 
>> lookup operations",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x42",
>>           "EventName": "sdir-hit",
>> +        "BriefDescription": "Count of the number of HHA S-Dir hit 
>> operations",
>> +        "PublicDescription": "Count of the number of HHA S-Dir hit 
>> operations",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x43",
>>           "EventName": "edir-hit",
>> +        "BriefDescription": "Count of the number of HHA E-Dir hit 
>> operations",
>> +        "PublicDescription": "Count of the number of HHA E-Dir hit 
>> operations",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x4c",
>>           "EventName": "sdir-home-migrate",
>> +        "BriefDescription": "Count of the number of HHA S-Dir read 
>> home migrate operations",
>> +        "PublicDescription": "Count of the number of HHA S-Dir read 
>> home migrate operations",
>>           "Unit": "hisi_sccl,hha"
>>      },
>>      {
>>           "ConfigCode": "0x4d",
>>           "EventName": "edir-home-migrate",
>> +        "BriefDescription": "Count of the number of HHA E-Dir read 
>> home migrate operations",
>> +        "PublicDescription": "Count of the number of HHA E-Dir read 
>> home migrate operations",
>>           "Unit": "hisi_sccl,hha"
>>      }
>>   ]
>
> .
>

