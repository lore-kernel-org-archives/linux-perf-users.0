Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608A352037
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296251; cv=none; b=VNQsC4i6KqAMpfGCOMcW4S51rV0R+Txy1gz1Iq0XiTYsTOgGZeM8iANiusstM28rz25WmXZLEW03tNC7jtLCNc/VxBKIFDJ6PELbmUdfJXFCtFmaMjlAtpz1Ri8ei6+KLV9vyrzjHA+PAuFjFcipQVXNAoPzUCDeqMZQEQp01hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296251; c=relaxed/simple;
	bh=Oi7Qxu056bvNIzFiLz7D83uWGjKfFm2x3Z+JR+5A/XQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGuLM7lbUR+3youZzZOQVr0oudspNBlDH24eweWDtmdPejpQl76dEjKSzFhiRM6GvS80lzCJvoY/ydaQwPBjz3YRU4EaqTC/BAew3Ib2fMwtHEoaKczV4bAkKnd5Mk/aGGyw8TfrBJBQESxVxfRt/swHfHE+Z4H9Ms7O1Y94QMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZyh9rPY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZyh9rPY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780296250; x=1811832250;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oi7Qxu056bvNIzFiLz7D83uWGjKfFm2x3Z+JR+5A/XQ=;
  b=iZyh9rPYoTrol8twH9BQp9R0KqLjHjN8pfRPG+0FaGGzTfSLkX217XWr
   fwr3QulBHDQ2IgXwMqrl92IkhMkFDWRAXQiZrP62IHCLHBUJyQKUhnh6c
   S2QkgyDEVuNKbbhw+bz5224lyRGmReUAXbjtV0Nhb7JvHDZpQMDOUD9mh
   JuaXCtZlMTgxtX4CZql1zA3I2Umt06ZbCOs/FVDfjwq0VPCxdX/oJnHpf
   SKJK2M+9LrkcBCvCIICftX9NFeU1ZATy83xJD1dy6TZaRDUXxrYQLk/k/
   TRV1mql1O1KY134xl367OoS0x3CTsF870UL21DxlAk2g2TbukqztooPvP
   A==;
X-CSE-ConnectionGUID: EtPAJbp5T1q9znMr0r79VQ==
X-CSE-MsgGUID: KIUEpQG+R7CmMElQiuITPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="92429261"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="92429261"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 23:44:09 -0700
X-CSE-ConnectionGUID: ETFhjMNNQTOqLaAqnVN0QA==
X-CSE-MsgGUID: 0FBgRlrwQ5KZ5bNKwmuITQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="248401546"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 23:44:08 -0700
Message-ID: <1e083472-4ea9-48bf-b353-61d90f513213@linux.intel.com>
Date: Mon, 1 Jun 2026 14:44:05 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 12/23] perf: Add sampling support for SIMD registers
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-13-dapeng1.mi@linux.intel.com>
 <20260529083604.21AA31F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529083604.21AA31F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/29/2026 4:36 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Missing bounds checking on user-provided SIMD `qwords` fields allows an integer overflow of the 16-bit perf event header size, leading to ring buffer corruption and potential NMI lockups.
> - [High] SIMD register parameters are evaluated and validated outside of their respective flag gates, which can falsely reject valid syscalls due to uninitialized memory.
> --
>
> commit eeb01562d09b920ab2f41841dd6b7a879ed10465
> Author: Kan Liang <kan.liang@linux.intel.com>
>
> perf: Add sampling support for SIMD registers
>
> This commit introduces support for sampling SIMD registers during profiling
> by adding new attribute fields to struct perf_event_attr. It adds a new ABI
> format to dump the width and values of the requested SIMD registers, using
> bitmasks and qword sizes configured by the user.
>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 2ce553db4dcb8..94bb034da9b9d 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
> [ ... ]
>
>> @@ -8596,6 +8664,33 @@ static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
>>  	return d * !!(flags & s);
>>  }
>>  
>> +static u64 perf_update_xregs_size(struct perf_event *event, bool intr)
>> +{
>> +	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
>> +	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
>> +	u64 pred_mask;
>> +	u64 mask;
>> +	int size;
>> +
>> +	if (intr) {
>> +		mask = event->attr.sample_simd_vec_reg_intr;
>> +		pred_mask = event->attr.sample_simd_pred_reg_intr;
>> +	} else {
>> +		mask = event->attr.sample_simd_vec_reg_user;
>> +		pred_mask = event->attr.sample_simd_pred_reg_user;
>> +	}
>> +
>> +	/* nr_vectors, vector_qwords, nr_pred, pred_qwords */
>> +	size = sizeof(u64) * 4;
>> +	size += (hweight64(mask) * vec_qwords +
>> +		 hweight64(pred_mask) * pred_qwords) * sizeof(u64);
>> +
> [Severity: Critical]
> Is there any bounds checking on the user-provided vec_qwords and pred_qwords
> fields here?
>
> If userspace provides large values, could the multiplication with the bitmask
> weights overflow the 16-bit perf event header size? 
>
> If the size overflows, would perf_output_begin() allocate a smaller ring buffer
> space than what perf_output_sample_simd_regs() subsequently writes, leading to
> an out-of-bounds memory regression in NMI context?

The next patch '27a8ae0bac36 ("perf/x86: Support XMM sampling using
sample_simd_vec_reg_* fields")' would add x86 specific
perf_simd_reg_validate() which would validate if the size overflow could
happen.

```

    size = ((vec_qwords * hweight64(vec_mask_intr)) +
        (vec_qwords * hweight64(vec_mask_user)) +
        (pred_qwords * hweight32(pred_mask_intr)) +
        (pred_qwords * hweight32(pred_mask_user))) * sizeof(u64);
    if (size > U16_MAX)
        return -EINVAL;

```


>
>> +	/* Warn if exceeding perf_event_header.size (u16). */
>> +	WARN_ON_ONCE(size > U16_MAX);
>> +
>> +	return size;
>> +}
> [ ... ]
>
>> @@ -13634,6 +13746,15 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>>  		ret = perf_reg_validate(attr->sample_regs_user);
>>  		if (ret)
>>  			return ret;
>> +		ret = perf_simd_reg_validate(attr->sample_simd_regs_enabled,
>> +					     attr->sample_simd_vec_reg_qwords,
>> +					     attr->sample_simd_vec_reg_intr,
>> +					     attr->sample_simd_vec_reg_user,
>> +					     attr->sample_simd_pred_reg_qwords,
>> +					     attr->sample_simd_pred_reg_intr,
>> +					     attr->sample_simd_pred_reg_user);
>> +		if (ret)
>> +			return ret;
>>  	}
> [Severity: High]
> When attr->sample_type & PERF_SAMPLE_REGS_USER is true but
> PERF_SAMPLE_REGS_INTR is not set, does this validate the _intr fields that
> might contain uninitialized garbage from userspace?
>
> Since flag-gated syscall parameters are not required to be zero-filled when
> the flag is absent, could evaluating these parameters outside their respective
> flag gates falsely reject valid syscalls due to uninitialized memory?

IMO, all fields should be initialized to 0 even if it's not used. currently
many perf code checks these fields even it's unused, like below code in
perf_copy_attr(),

```

    if (attr->__reserved_1 || attr->__reserved_2 ||
        attr->__reserved_3 || attr->__reserved_4)
        return -EINVAL;

```

Thanks.


>
> [ ... ]
>
