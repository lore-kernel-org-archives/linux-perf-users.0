Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46AA2EA754
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jun 2026 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781997338; cv=none; b=OSln2K1r4H1SpN7Ji+dxtyibHBCZ9iP0sOqT160fOusNA8VxRANd3ne/CvJbI+2wUN+mHTK5sa7ub7E1hWqo094x0rx0q11qtlEfuAWNX0Na4H16wnWTh6aazGrR3kCTPcfgibjjD/haAWPEsF3H+BvFKoXZST8HnbkLsBr+cSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781997338; c=relaxed/simple;
	bh=c55u9JRxfeVF5+lIje4TMCUBZ0laNtO3MJ5wSzOs+SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+XtImTTxYKMoUXHpHiL2hDrYIwndXPZ8JWzZ5pXUcK7Xz0uH8IEsw3UU/X6xjLp6dC8SGi8s+mYU90pngd7dbSLP57tHgCEIroL0sbsdL6UKZgN4H7/9mjMcds2dZKCjut5+F+7R5gUEE6aJ8jeR8e3jUOCMG9IixlpR09NoGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v3wkx8vG; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v3wkx8vG"
Message-ID: <bebea55d-6f39-41af-b838-22e030b2a66c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781997334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEuPlCv52nwo/gWF/w3ejVnuRDQuHOF1oyVFidnviJY=;
	b=v3wkx8vGIeU4QuFQVyrdSpesGGjauu1sXFQYpIKoVlQyF7JA3RGBhPMJkhMukyf3J/j8+n
	GFX27PN3z9+lpigeIBNUVtH/j0ymUOWJva6tpJM60MDdYEZRgC7akAjxLY71Tn5Tt1t8Wb
	iNRahysUw3rVAMjkSB/+4AJPiO7SM34=
Date: Sat, 20 Jun 2026 16:15:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 14/21] RISC-V: perf: Skip PMU SBI extension when not
 implemented
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-riscv@lists.infradead.org
References: <20260608-counter_delegation-v6-14-285b72ed65a9@meta.com>
 <20260609063329.66D801F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260609063329.66D801F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 11:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] Missing perf_pmu_unregister() on error paths leads to Use-After-Free of the pmu struct.
> - [High] Unconditional cpuhp_state_remove_instance() on an uninitialized hlist_node causes a kernel panic.
> --
>
> commit bd51c5655be0902a2fc1fd90b8d692c299e7265b
> Author: Charlie Jenkins <charlie@rivosinc.com>
>
> RISC-V: perf: Skip PMU SBI extension when not implemented
>
> When the PMU SBI extension is not implemented, sbi_v2_available should
> not be set to true. The SBI implementation for counter config matching
> and firmware counter read  should also be skipped when the SBI extension
> is not implemented.
+linux-riscv
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 1f16df9d0dd00..5bfcd3821f572 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
> [ ... ]
>> @@ -2045,12 +2052,13 @@ static int __init rvpmu_devinit(void)
>>   	int ret;
>>   	struct platform_device *pdev;
>>   
>> -	if (sbi_spec_version >= sbi_mk_version(0, 3) &&
>> -	    sbi_probe_extension(SBI_EXT_PMU))
>> -		static_branch_enable(&riscv_pmu_sbi_available);
>> +	if (sbi_probe_extension(SBI_EXT_PMU)) {
>> +		if (sbi_spec_version >= sbi_mk_version(0, 3))
>> +			static_branch_enable(&riscv_pmu_sbi_available);
>> +		if (sbi_spec_version >= sbi_mk_version(2, 0))
>> +			sbi_v2_available = true;
>> +	}
>>   
>> -	if (sbi_spec_version >= sbi_mk_version(2, 0))
>> -		sbi_v2_available = true;
>>   	/*
>>   	 * We need all three extensions to be present to access the counters
>>   	 * in S-mode via Supervisor Counter delegation.
> [Severity: Critical]
> This is a pre-existing issue, but I noticed a potential use-after-free in the
> error handling path of rvpmu_device_probe() when allocating or registering
> fails after perf_pmu_register() succeeds.
>
> If an error occurs, such as pmu_sbi_snapshot_alloc() failing, the code jumps
> to out_unregister:
>
> out_unregister:
> 	riscv_pmu_destroy(pmu);
>
> out_free:
> 	kfree(pmu);
> 	return ret;
>
> However, neither the error path nor riscv_pmu_destroy() calls
> perf_pmu_unregister(&pmu->pmu).
>
> This leaves the PMU registered in the perf core subsystem while its backing
> memory is freed via kfree(). Any subsequent access to the PMU could result
> in a use-after-free.
>
> Should perf_pmu_unregister() be called during teardown to avoid memory
> corruption?

Yes. Same comment as other patches. Fixed.


> [Severity: High]
> This is a pre-existing issue, but the error teardown path in
> rvpmu_device_probe() seems to have a bug that could trigger a kernel panic.
>
> If rvpmu_device_probe() fails before successfully calling
> cpuhp_state_add_instance(), it jumps to out_unregister and calls
> riscv_pmu_destroy(pmu).
>
> Inside riscv_pmu_destroy(), it unconditionally removes the hotplug instance:
>
> static void riscv_pmu_destroy(struct riscv_pmu *pmu)
> {
> 	...
> 	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
> }
>
> Because the pmu struct is allocated with kzalloc() and the node hasn't been
> added to the hotplug list yet, its hlist_node is zero-initialized.
>
> When hlist_del() is called internally by cpuhp_state_remove_instance(), it
> attempts to dereference node->pprev (which is NULL), causing a NULL pointer
> dereference.
>
> Would it be better to check if the node is actually hashed before attempting
> to remove the hotplug instance?
Fixed in v7.
