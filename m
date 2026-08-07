Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E582F549F;
	Fri,  7 Aug 2026 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099454; cv=none; b=QkVamuAEoAZ1Hhi25m15FttsFAbpDYCIKK8v5qWeWfn4eDHKaXKe4SkVjOFCORV0dnlh2XKTGmbLrEChAMs0LbwESXM03mXjrFY5vzIHGN0fa5TcRZXKwRVb9M2y1tTyq84o/bYixGNwCwUkgC2bNd+pJU1nqapbunZNOPE3aig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099454; c=relaxed/simple;
	bh=H6QklSp20s1FluH6ItvMPvplOqv4OzntIAnvR7AekVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqfTBL8SW3RFlvScvN9oRMKx5apEXox0oS+9oR7+1smiczFFhdygUq8H/i6K43+JFLlyps5tVv5YpWHJWwnk7Ia1kUzaFDmbWHPUCDjhW9xVlMvGskju3sbVALiNpn7smDeABum4fTJ++dZfJG+lYorVTXRiAulNjAs5BieggLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kFegugyW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kFegugyW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C855B1516;
	Fri,  7 Aug 2026 03:44:08 -0700 (PDT)
Received: from [10.163.136.85] (unknown [10.163.136.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 127223F9A2;
	Fri,  7 Aug 2026 03:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786099452; bh=H6QklSp20s1FluH6ItvMPvplOqv4OzntIAnvR7AekVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kFegugyW/+3TwpOSan2jwjrL6LgXDEDGRFeECumYEpuzVVyQhLJOkFiCxMiXom+Y4
	 cxEbO4A25HWzJPTO34KgxL9MjdViIobcoS48A2aA7fft4XfJsaI2AqzFzPDBOiwcxD
	 XooV5+b6NgXHkqOt45CVsBII0APd+Rh8RfJZuTDk=
Message-ID: <a985a304-b399-4e84-99e3-0c6200ae518a@arm.com>
Date: Fri, 7 Aug 2026 16:14:06 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_pmuv3: Zero initialize hw_id branch stack field
To: James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, "Rob Herring (Arm)" <robh@kernel.org>,
 Leo Yan <leo.yan@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260807-james-brbe-init-hw-idx-v1-1-009d1843960a@linaro.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260807-james-brbe-init-hw-idx-v1-1-009d1843960a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/26 2:44 PM, James Clark wrote:
> PERF_SAMPLE_BRANCH_HW_INDEX is supported by BRBE so hw_id is passed to
> userspace, but it's never set by the BRBE driver. Zero initialize it as
> it should be according to the docs:
> 
>    * For the architectures whose raw branch records are
>    * already stored in age order, the hw_idx should be 0.

The in code documentation while defining perf_branch_stack.
Probably a good idea to specify the same above.

 * For the architectures whose raw branch records are
 * already stored in age order, the hw_idx should be 0.
 */
struct perf_branch_stack {
	u64				nr;
	u64				hw_idx;
	struct perf_branch_entry	entries[];
};

> 
> It's probably too risky to remove PERF_SAMPLE_BRANCH_HW_INDEX from BRBE
> now in case anyone is setting it and reading the value, but zero
> initializing the whole struct also protects against the same issue with
> new fields that are added in the future.

Agreed. Because PERF_SAMPLE_BRANCH_HW_INDEX is supported in BRBE,
hw_idx pushed to the userspace should be zero if HW never updates.
This is definitely better than dropping PERF_SAMPLE_BRANCH_HW_INDEX
flag all together to avoid breaking current users (if any).
> 
> Fixes: 58074a0fce66 ("perf: arm_pmuv3: Add support for the Branch Record Buffer Extension (BRBE)")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> Very small fix spotted by Sashiko. It was probably always zero during
> testing or never looked at.
> ---
>  drivers/perf/arm_pmuv3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 8014ff766cff..b9a8592bf112 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1361,7 +1361,7 @@ static int branch_records_alloc(struct arm_pmu *armpmu)
>  		struct pmu_hw_events *events_cpu;
>  
>  		events_cpu = per_cpu_ptr(armpmu->hw_events, cpu);
> -		events_cpu->branch_stack = kmalloc(size, GFP_KERNEL);
> +		events_cpu->branch_stack = kzalloc(size, GFP_KERNEL);
>  		if (!events_cpu->branch_stack)
>  			return -ENOMEM;
>  	}
> 
> ---
> base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
> change-id: 20260807-james-brbe-init-hw-idx-53dec54fe266
> 
> Best regards,
> --  
> James Clark <james.clark@linaro.org>
> 

