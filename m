Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33CA70809;
	Mon,  3 Feb 2025 04:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738555669; cv=none; b=Gw+kkI7YTHGJPbpA2HimOn4rG7kLpZGa2r0GBgZY27rDWiJ/MQsETHJI0nYb3+yKf/gvWzAq3gaS0LWL6mAeXwtNqNCLcEgbJef7kdS9q59vDSp0cVhUuWw04Jm0XiB3MU+F+UF4gyMZTkEHQztfz9FaGQ4LUpnBkBwJJ142zqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738555669; c=relaxed/simple;
	bh=WiErfKDTIO2GUE6Pb3PkwOPEVJSvmC7PZ0BfyEI2FZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQGSH3ClotoyboO002mYyWiChWKgadlt5I3CNNwswCs3kMXoUhrg7PsoFl4zLCIV9FgNQb969xLlLjq3NMiDElScB0cPe4aXFYc/kB4btcQEqO1sI0DQyPaV2GJsY88dKtmiq+TRZuboMWD5rbbRqe3oMKP28Achp/OA7zR+tC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A751A1476;
	Sun,  2 Feb 2025 20:08:03 -0800 (PST)
Received: from [10.162.16.79] (unknown [10.162.16.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C29863F63F;
	Sun,  2 Feb 2025 20:07:34 -0800 (PST)
Message-ID: <1910b0da-68fe-4161-b7bb-f0d5ac8d5fe7@arm.com>
Date: Mon, 3 Feb 2025 09:37:31 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 01/11] perf: arm_pmuv3: Call kvm_vcpu_pmu_resync_el0()
 before enabling counters
To: "Rob Herring (Arm)" <robh@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20250202-arm-brbe-v19-v19-0-1c1300802385@kernel.org>
 <20250202-arm-brbe-v19-v19-1-1c1300802385@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250202-arm-brbe-v19-v19-1-1c1300802385@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/3/25 06:12, Rob Herring (Arm) wrote:
> Counting events related to setup of the PMU is not desired, but
> kvm_vcpu_pmu_resync_el0() is called just after the PMU counters have
> been enabled. Move the call to before enabling the counters.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/perf/arm_pmuv3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 0e360feb3432..9ebc950559c0 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -825,10 +825,10 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
>  	else
>  		armv8pmu_disable_user_access();
>  
> +	kvm_vcpu_pmu_resync_el0();
> +
>  	/* Enable all counters */
>  	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
> -
> -	kvm_vcpu_pmu_resync_el0();
>  }
>  
>  static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
