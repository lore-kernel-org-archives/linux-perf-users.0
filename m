Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF801171650;
	Thu, 21 Nov 2024 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185089; cv=none; b=UW40bfn5CPeomNmlYb/T3pJk2WQkvElhAhjR7K5E8P+ROh9kgrzPwqtaQeX3ICGyJskIEUO9wJStCbHBif8O9rpJTt8e/k2dLPGgJ5/of/t0CRXFCwF2TCb2WowmIqUKUhXGWptV0n0XsSgdFKcSwjhImnvTDcDllvu+74sw/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185089; c=relaxed/simple;
	bh=x8taLnZsBUghNuHkVQ7/oPeHVAKtgFa3NgX+bOdHZqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRLR6IRGj+gFvpa+kal58IGqJmtFlmCJiMIND1E/5pEBN2IDCpE9kAHMIGS5QPB/LWz96ozqPWZKEwpSHAk4jmuqBguoj+CZnQ+DM+SyMEY5gu12RklzuFbbrdzJEkpLSXT+rONrEZWaSKXxelZ27dXVSWi6EQ6lrF9mN9d1ez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1673f0bf48ed-2f204;
	Thu, 21 Nov 2024 18:31:22 +0800 (CST)
X-RM-TRANSID:2ee1673f0bf48ed-2f204
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.155.44] (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2673f0bfa6d0-cf824;
	Thu, 21 Nov 2024 18:31:22 +0800 (CST)
X-RM-TRANSID:2ee2673f0bfa6d0-cf824
Message-ID: <94663eed-e5a7-4263-ab96-bf16fa94eb58@cmss.chinamobile.com>
Date: Thu, 21 Nov 2024 18:31:21 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf intel-pt: cleanup unneeded return variable
 inintel_pt_text_poke()
To: Adrian Hunter <adrian.hunter@intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, algonell@gmail.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241121100047.25318-1-guanjing@cmss.chinamobile.com>
 <820e9b6b-16eb-446a-b524-adc8129726ec@intel.com>
From: guanjing <guanjing@cmss.chinamobile.com>
In-Reply-To: <820e9b6b-16eb-446a-b524-adc8129726ec@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for clarifying the proper usage of the Fixes tag. I understand 
now that it should only be applied when there is an actual fix to 
functionality. I will ensure to use it correctly in future submissions.

Thanks a lot!

On 2024/11/21 18:18, Adrian Hunter wrote:
> On 21/11/24 12:00, guanjing wrote:
>> Removed Unneeded variable: "ret"
>>
>> Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
> A Fixes tag is not for patches that don't fix some functionality.
>
>> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
>> ---
>>   tools/perf/util/intel-pt.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
>> index 30be6dfe09eb..6c0234acc669 100644
>> --- a/tools/perf/util/intel-pt.c
>> +++ b/tools/perf/util/intel-pt.c
>> @@ -3402,7 +3402,6 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
>>   	struct machine *machine = pt->machine;
>>   	struct intel_pt_cache_entry *e;
>>   	u64 offset;
>> -	int ret = 0;
>>   
>>   	addr_location__init(&al);
>>   	if (!event->text_poke.new_len)
>> @@ -3443,7 +3442,7 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
>>   	}
>>   out:
>>   	addr_location__exit(&al);
>> -	return ret;
>> +	return 0;
> Should just drop the return value entirely, since it is
> always zero.
>
>>   }
>>   
>>   static int intel_pt_process_event(struct perf_session *session,


