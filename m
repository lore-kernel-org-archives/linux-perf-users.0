Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFC42236E0
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333705; cv=none; b=qztiuWs4imRaUzWB1i0ltBJqerSSfP3TPQZMB4/Mhc9m9V1JYAonPAO8VXQc+zV/ikXzqAbeW6tOkObq1TmWv5kWA2Ts0APwM9co/7cfavTwsK8P9NQWywB4trVW4zmzuMHWxkIDPMThHq001ISHU87N8fDvh610YTKewEV4oKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333705; c=relaxed/simple;
	bh=aQrU+SlZhKihLrlFpQQQT6TjJOACS1gGhsITIhYIznw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMO+9m2Oa11tMg215OwZgGgQw1gKnTOjo+k7MYvJLwIWoHTUE0L2jEShIoKYLVexri667Z0ZmpX+yOp92IQDweYnm4mXBohwXvy3bv+Csk/6VFg9vzWhcXm8+Nv1OHAcLtEAgDEoRvR8y/nnUG8Z72CnK5WIPf5I/rH1+1GO+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y0IJAohh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y0IJAohh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB6D2454;
	Mon,  6 Jul 2026 03:28:18 -0700 (PDT)
Received: from [10.57.82.104] (unknown [10.57.82.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 584373F85F;
	Mon,  6 Jul 2026 03:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783333702; bh=aQrU+SlZhKihLrlFpQQQT6TjJOACS1gGhsITIhYIznw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y0IJAohhsjEaePvuSwntVbuCsrEHaIiins8ebwXRwXsmunGwtLGT/t8S19iJNRoRi
	 ct5GZFZBX7EW2xFu6Do1/m6NeiKec4SD1mjrmD/Msfjs29Z5jjVCsS8YrKM3ReU3p1
	 NtbZLbEmV1kF5KHMi/z6mR33bPit28OYOdpe6Ch4=
Message-ID: <f5541259-cb61-46fc-bd76-a1a07f625e04@arm.com>
Date: Mon, 6 Jul 2026 11:28:13 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] perf/arm-cmn: Refactor event filter data
To: Leo Yan <leo.yan@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 ilkka@os.amperecomputing.com
References: <cover.1782830759.git.robin.murphy@arm.com>
 <d638212f5a5993eae5e262dd5be596b8d2b8fa5f.1782830759.git.robin.murphy@arm.com>
 <20260705154438.GA710301@e132581.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260705154438.GA710301@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-07-05 4:44 pm, Leo Yan wrote:
> On Tue, Jun 30, 2026 at 04:19:18PM +0100, Robin Murphy wrote:
> 
> [...]
> 
>> +struct arm_cmn_filter_attr {
>> +	enum cmn_filter_select sel;
>> +	u8 val;
>> +};
> 
>> -#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _filter, _fsel)\
>> +#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _filter, ...)	\
>>   	(&((struct arm_cmn_event_attr[]) {{				\
>>   		.attr = __ATTR(_name, 0444, arm_cmn_event_show, NULL),	\
>>   		.model = _model,					\
>>   		.type = _type,						\
>>   		.eventid = _eventid,					\
>> -		.filter = _filter,					\
>> -		.fsel = _fsel,						\
>> +		.filter = {{_filter}},					\
> 
> This patch might break as the "val" field is never initialized. Should
> it use two parameters "_fa, _fb" instead?

Ah, you're right - this evolved through several different designs, and 
this line is still from when "_filter..." was the whole varargs, but 
then I brought forward more of the changes from patch #5 to try to 
minimise intra-series churn, and I guess the fact that it didn't 
completely fail to compile (as I was accustomed to by that point...) 
meant I missed this subtlety.

> #define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _fa, _fb, ...) \
>        (&((struct arm_cmn_event_attr[]) {{                              \
>                ...                                                      \
>                .filter = {{_fa, _fb}},                                  \
> 
> Although the issue is fixed by a later patch, I think it is good to
> correct this patch for bisection.

Agreed, I'll fix that for a v2.

Thanks,
Robin.
