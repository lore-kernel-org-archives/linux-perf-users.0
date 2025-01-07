Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFC0134A8;
	Tue,  7 Jan 2025 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736214927; cv=none; b=MtimmE8uLd6C5lzrCWTdfSikbBV/ZivrReCOlIOdknkNTmuxCoYCrKTVdyOpEikhGpyhZ1nXe7MhRFJxzoHLG4e4R/Ub1G6SFsPKwhQ7Dr5y7+VLNjrrYDjpp1XdRfoWcwCD2KeXf3tsyaoaAdblrXRVjWwpEbmvo4WHA8ZVgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736214927; c=relaxed/simple;
	bh=zewPI5j9ExE79CPGvELetfrIleGdFuipl9c3NiYz3Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJ0DrmTW6IRUkgp84AcqocsjNsso0sBgGzyULrMiNKjgXaVrS9rhVlje+afwCkPoBhEo6ioRn1pI37TlMpGQs6lMu6e+ZBLu3D9o6TGO0xW48QLGrLY9/L6OweW+Db14eA6PdsNsbRjjSAHr3r5+BfY+PbUP93ku9IvNSjyn06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nHQABdFV; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nHQABdFV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736214916; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Rj+iSTFS+UIzhnEVr62aissj/wuOi4mm3ec0OjVEjfA=;
	b=nHQABdFVRcpY6mY0qt7KoAklhRiefpUjEH9gfAgTyVbErjZpLzny4Cu4QksiHQjNNASNTBC/1ubQCg2GVWkGgexgKSlka/gmaftSvtZ1VGIEcsY1rN5FsKranK2GD9HbqmFMdInHZbBckL7XJtbwa0MoQNamNv+v5GsOpq1WMLE=
Received: from 30.221.147.177(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0WN8uKQ4_1736214914 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jan 2025 09:55:15 +0800
Message-ID: <bff44127-73ec-469a-b82b-e8aa9062fe8e@linux.alibaba.com>
Date: Tue, 7 Jan 2025 09:55:12 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix the lack of ch_mask format for
 SPR
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>
References: <1735542672-113067-1-git-send-email-renyu.zj@linux.alibaba.com>
 <7e5376f1-ee87-458b-b55e-759125d251a2@linux.intel.com>
 <9f233d6e-ee4b-4ea3-96ee-397bba1b73b0@linux.alibaba.com>
 <a6218176-965e-4d69-992b-15d7cc5482ec@linux.intel.com>
From: Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <a6218176-965e-4d69-992b-15d7cc5482ec@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/1/6 下午9:44, Liang, Kan 写道:
> 
> 
> On 2025-01-05 9:16 p.m., Jing Zhang wrote:
>>
>>
>> 在 2025/1/3 上午3:02, Liang, Kan 写道:
>>>
>>>
>>> On 2024-12-30 2:11 a.m., Jing Zhang wrote:
>>>> perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL event
>>>> because of lack of ch_mask format in drivers, and perf test "104: perf
>>>> all PMU test (exclusive)" failed.
>>>>
>>>> $perf stat -e perf stat -e UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
>>>> sleep 1
>>>>
>>>> Initial error:
>>>> event syntax error: 'UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL'
>>>>                                 \___ unknown term 'ch_mask' for pmu 'uncore_cha_0'
>>>>
>>>> 104: perf all PMU test (exclusive)                                   : FAILED!
>>>>
>>>> Add ch_mask format for SPR to fix it.
>>>>
>>>
>>> I don't think there is a ch_mask. It should be extended umask.
>>> The issue of the CHA extended umask should has been fixed by
>>> https://lore.kernel.org/lkml/172052531679.2215.16140288595428337453.tip-bot2@tip-bot2/
>>>
>>
>> I think it is not the same issue. I have this patch but still error.
>>
>> in "tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json",
>> the event "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL" is described as:
>> {
>>         "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL",
>>         "Counter": "0,1,2,3",
>>         "EventCode": "0x35",
>>         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL",
>>         "Experimental": "1",
>>         "PerPkg": "1",
>>         "PortMask": "0x000",
>>         "UMask": "0x10c0008101",
>>         "Unit": "CHA"
>> },
>>
>> the PortMask is ch_mask, but driver not output ch_mask on SPR, it causes error.
> 
> There is no ch_mask on SPR. It should be Extended Umask.
> The convertor tool should avoid generating the PortMask and FCMask for
> SPR/EMR/GNR.

Oh, I see. Maybe the event description is inaccurate.

Thanks,
Jing

> 
> + Thomas
> 
> Could you please take a look? We may have to re-generate the event list.
> 
> Thanks,
> Kan
> 
>>
>> Thanks,
>> Jing
>>
>>> Thanks,
>>> Kan
>>
>>
>>
>>
>>>> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
>>>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>>>> ---
>>>>  arch/x86/events/intel/uncore_snbep.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>>>> index ca98744..e537623 100644
>>>> --- a/arch/x86/events/intel/uncore_snbep.c
>>>> +++ b/arch/x86/events/intel/uncore_snbep.c
>>>> @@ -5967,6 +5967,7 @@ static int spr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
>>>>  	&format_attr_inv.attr,
>>>>  	&format_attr_thresh8.attr,
>>>>  	&format_attr_filter_tid5.attr,
>>>> +	&format_attr_ch_mask.attr,
>>>>  	NULL,
>>>>  };
>>>>  static const struct attribute_group spr_uncore_chabox_format_group = {
>>
> 
