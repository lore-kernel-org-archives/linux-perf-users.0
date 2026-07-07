Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E133DEAC0;
	Tue,  7 Jul 2026 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419940; cv=none; b=HOU/sQIALcZB0Wrpyp3vFAr3ukZY0zWu9fNWgIgffD75OYxCdsyJ+uvLNTWgwCAfsbMqC6RzTZJlgsj7cqU/UH/JeNrfrOmPV7gcz0PcL0M8o4m5nO7IeSwBakEHq5r+edZWUdtq07bSXArjX9afBDjU2NVLYYMkJ2F/+Wu4m74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419940; c=relaxed/simple;
	bh=/JKGvZAek80JgMohRPNx5B4QlkcpbDcffOkLSxtkIqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pon422ZvWnLlJxc+LB1gWMstcPVvrxZqUO5wj9XvtCLDM0GY76PX3o0HtWYLo1OBKovcvQ2Empmx0+SA3HKsIAHj+m+wnlGRr8PndHhxhw68LS84SXC7siDU0qYXnV00KTKoHCPD3BAk7sIvUVXlpNiUdVBuAyczFuexSf/Inh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gvcms1PtVz297jS;
	Tue,  7 Jul 2026 18:25:17 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gvcmq4rZTz297jF;
	Tue,  7 Jul 2026 18:25:15 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id DC98D30125A8;
	Tue,  7 Jul 2026 18:23:04 +0800 (CST)
Received: from [172.25.61.61] (172.25.61.61) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 7 Jul
 2026 18:25:16 +0800
Message-ID: <1afcacd3-1be0-40f5-9b3b-adac8c2cb95b@hygon.cn>
Date: Tue, 7 Jul 2026 18:25:16 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] perf/x86/amd/uncore: Add common helpers and Hygon
 support
To: Sandipan Das <sandipan.das@amd.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>, <peterz@infradead.org>, <mingo@redhat.com>,
	<namhyung@kernel.org>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <x86@kernel.org>
References: <20260701093417.1312443-1-liuqi@hygon.cn>
 <44959c7f-fedd-413e-bb2f-07f97142aef8@amd.com>
Content-Language: en-US
From: Qi Liu <liuqi@hygon.cn>
In-Reply-To: <44959c7f-fedd-413e-bb2f-07f97142aef8@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Hi Sandipan,

Sorry for the late reply, and thanks for the review.

On 7/3/2026 4:41 PM, Sandipan Das wrote:
> On 01-07-2026 15:04, Qi Liu wrote:
>> This series adds initial Hygon uncore PMU support.
>>
>> Hygon uncore PMUs use a programming model close to the AMD uncore PMU,
>> so this series factors out a small set of common helpers for perf event
>> handling, counter assignment and per-CPU context management.
>>
>> The Hygon-specific support is kept in the Hygon driver. This series
>> supports the Hygon DF and DF IOD PMUs. No Hygon-specific logic is
>> added to the AMD driver.
>>
>> Changes since RFC:
>>    - Address sashiko bot review.
>> Changes since v1:
>>    - Rename the helper namespace to amd_uncore_common_* to avoid
>>      an generic uncore_common_* prefix, and to keep it distinct
>>      from the existing amd_uncore_* names.
>>
>>
>> Qi Liu (3):
>>    perf/x86/amd/uncore: Add common PMU helper functions
>>    perf/x86/amd/uncore: Convert AMD driver to common PMU helpers
>>    perf/x86/amd/uncore: Add Hygon uncore PMU support
>>
>>   arch/x86/events/Kconfig                 |  17 +
>>   arch/x86/events/amd/Makefile            |   4 +
>>   arch/x86/events/amd/amd_uncore_common.c | 403 +++++++++++++++++
>>   arch/x86/events/amd/amd_uncore_common.h | 114 +++++
>>   arch/x86/events/amd/hygon_uncore.c      | 556 +++++++++++++++++++++++
>>   arch/x86/events/amd/uncore.c            | 578 +++---------------------
>>   arch/x86/include/asm/msr-index.h        |   2 +
>>   arch/x86/include/asm/perf_event.h       |  20 +
>>   include/linux/cpuhotplug.h              |   3 +
>>   9 files changed, 1192 insertions(+), 505 deletions(-)
>>   create mode 100644 arch/x86/events/amd/amd_uncore_common.c
>>   create mode 100644 arch/x86/events/amd/amd_uncore_common.h
>>   create mode 100644 arch/x86/events/amd/hygon_uncore.c
>>
> I am trying to understand if the code movement is necessary.
> Wouldn't it be sufficient to just add the following?
>   - new UNCORE_TYPE_HYGON_DF and UNCORE_TYPE_HYGON_DF_IOD types
>   - Hygon-specific attr_groups, pmu->event_init(), pmu->add(),
>     amd_uncore->init() and amd_uncore->scan() implementations

Yes, Use UNCORE_TYPE_HYGON_DF and UNCORE_TYPE_HYGON_DF_IOD would help 
minimize code movement, but Hygon uncore will likely grow more 
Hygon-specific L3/DF/UMC support over time. If we put these PMUs into 
arch/x86/events/amd/uncore.c now, that file may need more Hygon-specific 
types and checks later. So for now, it may be better to keep a separate 
copy in hygon_uncore.c first, as suggested in the earlier review.

> Using new PMU names will also require tools-side changes. Additionally,
> to make the PMUs actually useful, new JSON events and metrics need to
> be added. Are there plans for that?

yes, new PMU names will need perf updates. New JSON events and metrics 
are also needed,  I'll add them later. Thanks!


Qi Liu


