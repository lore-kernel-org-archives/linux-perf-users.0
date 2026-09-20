Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C930233134;
	Sun, 20 Sep 2026 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789872751; cv=none; b=RsYMv1PwMnoByjgtnmqqjF1dk7X1n6lvjow9G6JF8sElMEWL4xQBy0NkUJhCAxGeRi3J9foQEbh8vD7RUnM74VUgtEshhvSywQcKR9iesIwG5O7myk17US//HEPTMD0lSPADW4YYtbs3RBtMgYiqmsmj9CgP7hLDjF4cB4DxWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789872751; c=relaxed/simple;
	bh=Ce2u0hqKcwLOve3UfRfzdJzS9nPp2PpK0WL5gWGvjhY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YjIjjzU7h2lTfu8RooEf1uJpAMVD+MhfH4DBuBkHQBi/aRdj2S+yQGnbzyphpVJ5SCdwAn9F70YiH0wtwzIgqs07H33ThxWY1sepSg/hRBeqflClkYzjbSRN+KUXT8f2z7ECTS1EnlcctvjMUmA1/ywegoWmORJmtoHx0X75hM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1046899|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0365619-0.00717008-0.956268;FP=7332737672707408792|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=fuhao@open-hieco.net;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.jHm56Jf_1789872728;
Received: from 172.25.21.212(mailfrom:fuhao@open-hieco.net fp:SMTPD_---.jHm56Jf_1789872728 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 10:52:17 +0800
Message-ID: <114fd759-07c4-4001-b20f-517e596ebe25@open-hieco.net>
Date: Sun, 20 Sep 2026 10:52:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Fu Hao <fuhao@open-hieco.net>
Subject: Re: [PATCH v5 4/5] perf/x86/uncore: Add L3 PMU support for Hygon
 family 18h model 6h
To: Sandipan Das <sandipan.das@amd.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, tglx@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 james.clark@linaro.org, hpa@zytor.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 tingyin.duan@gmail.com
References: <cover.1788404433.git.fuhao@open-hieco.net>
 <d45936ac077e5a62dae6f40edcafa13644620ed5.1788404433.git.fuhao@open-hieco.net>
 <4240334a-621a-4ac3-91d3-294fddf1f05e@amd.com>
Content-Language: en-US
In-Reply-To: <4240334a-621a-4ac3-91d3-294fddf1f05e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/2026 10:08 PM, Sandipan Das wrote:
> On 04-09-2026 08:42, Fu Hao wrote:
>> Adjust the L3 PMU slicemask and threadmask for Hygon family 18h
>> model 6h processor.
>>
>> Signed-off-by: Fu Hao <fuhao@open-hieco.net>
>> Tested-by: Tingyin Duan <tingyin.duan@gmail.com>
>> ---
>>   arch/x86/events/amd/uncore.c      | 48 ++++++++++++++++++++++++++++++-
>>   arch/x86/include/asm/perf_event.h |  8 ++++++
>>   2 files changed, 55 insertions(+), 1 deletion(-)
>>
> 
> There was a proposal to have separate uncore PMU drivers for AMD and Hygon.
> The latest version of that series can be found at
> https://lore.kernel.org/lkml/20260818100118.12944-1-liuqi@hygon.cn/
> 
> Can these changes be adapted to that?

Hi Sandipan Das,

    Thanks for your guidance. I will implement the Hygon L3 PMU support
on top of the Hygon uncore PMU driver (hygon_uncore.c) that is currently
under discussion on the list, rather than growing the Hygon bits further
inside the AMD uncore code. The goal is to finish the separation between
AMD and Hygon for uncore PMU drivers.

-- 
Regards,
Fu Hao

