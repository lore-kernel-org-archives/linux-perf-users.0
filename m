Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6761799F
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jun 2026 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781915851; cv=none; b=DdsfUAKkYXB0IeNeCzXRRs9FgeeTbgqxysMRTpU/y0dZYQ6rpiAIsmvWe9o6JXyE48b38/pCzdbPwvsQ5PQv3XCowahYxjpXRLflsP2qE2xGf+tGGD06rxnkb71DMYOUMcMOsCYmlxSA2hQCg/DVgxsbOU/R7OIyc5+ERCO5WcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781915851; c=relaxed/simple;
	bh=zlVRYtTX0IMSiEplXwHZftLFto6fUpYN9sipcBlMMT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvkWIXshn1SBagoGc0Z89P8Jpt4VzRQnl0cKaKEz1F/ekQmKudRErjhUnA4+QDPoAY6AQAGh6qOhnPm1RCT6p0lYKd94viIhYnHGkw5lkQ/5CYSlMlgARLwaw8oqY6lmgGcM4sMx9zv106L5BXdlGB2nSb1CFeiY3DjxGTJzjHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mPB+xqiz; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mPB+xqiz"
Message-ID: <45c4f50d-46d1-4111-b0a1-d4da386bba66@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781915848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6Ws2e3pGATryWc6/hsprSzAgwSCbcpOlE9xtcnLeMg=;
	b=mPB+xqiz75neW2047tYmRmI2dMRxaCpTphKtLfW1HQsYCJp1Mvh5Qb0beyurzKtAnm0sjk
	KESv+s6HbixTAvz2yslqKIJ8U64FRysQ3sNgMTGISXC88ZqsdNXerUusSqg4XR0gCiM6J2
	3mapRiWgq5uNsWXogQIm0ys+FepT564=
Date: Fri, 19 Jun 2026 17:37:22 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 17/21] RISC-V: perf: Add Qemu virt machine events
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
References: <20260608-counter_delegation-v6-17-285b72ed65a9@meta.com>
 <20260609062221.D90C81F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260609062221.D90C81F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 11:22 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch incorrectly overloads the generic 'unimplemented' or 'non-commercial' CPU IDs (`mvendorid=0`, `marchid=0`, `mimpid=0`) to uniquely identify the QEMU virt machine, applying QEMU-specific PMU events globally to any minimal or academic RISC-V core.
> --
>
> commit 61b476b524390d76a4db3dcbab4b57114ff0ebc8
> Author: Atish Patra <atishp@rivosinc.com>
>
> RISC-V: perf: Add Qemu virt machine events
>
> This patch adds a minimal set of legacy perf events for the QEMU virt
> machine to the vendor table, allowing users to use them when counter
> delegation is enabled.
>
>> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
>> index 7f5030ee1fcf8..603aa2b21c0ba 100644
>> --- a/arch/riscv/include/asm/vendorid_list.h
>> +++ b/arch/riscv/include/asm/vendorid_list.h
>> @@ -11,4 +11,8 @@
>>   #define SIFIVE_VENDOR_ID	0x489
>>   #define THEAD_VENDOR_ID		0x5b7
>>   
>> +#define QEMU_VIRT_VENDOR_ID		0x000
>> +#define QEMU_VIRT_IMPL_ID		0x000
>> +#define QEMU_VIRT_ARCH_ID		0x000
>> +
> [Severity: Medium]
> Do these definitions overload the generic "unimplemented" or "non-commercial"
> CPU IDs to uniquely identify the QEMU virt machine?
>
> According to the RISC-V Privileged Architecture specification, a value of 0
> in the mvendorid, marchid, and mimpid CSRs indicates that the ID is either
> unimplemented or represents a non-commercial implementation.

That's what virt machine exposes. We need actually what is being exposed 
in virt machine
as it still remains one of the most commonly used platforms in RISC-V.

>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 00b84b28117a8..74acac54328e0 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
> [ ... ]
>
>> @@ -453,7 +454,42 @@ struct riscv_vendor_pmu_events {
>>   	  .hw_event_map = _hw_event_map, .cache_event_map = _cache_event_map, \
>>   	  .attrs_events = _attrs },
>>   
> [ ... ]
>
>>   static struct riscv_vendor_pmu_events pmu_vendor_events_table[] = {
>> +	RISCV_VENDOR_PMU_EVENTS(QEMU_VIRT_VENDOR_ID, QEMU_VIRT_ARCH_ID, QEMU_VIRT_IMPL_ID,
>> +				qemu_virt_hw_event_map, qemu_virt_cache_event_map,
>> +				qemu_virt_event_group)
>>   };
> [Severity: Medium]
> By binding the 0x000 ID tuple to QEMU's specific PMU event maps here, will
> the kernel mistakenly assume any generic core returning 0 is a QEMU virt
> machine?
>
> If that non-QEMU core implements PMU counter delegation (Ssccfg/Smcdeleg) but
> uses standard or different raw event encodings, this could unconditionally
> program QEMU's arbitrary raw event values into the core's PMU configuration
> registers, silently corrupting performance monitoring statistics.

N/A


