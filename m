Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4988171A5;
	Tue, 11 Jun 2024 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718133083; cv=none; b=K79KoRYtv8Wdo4ehugeJycJDEOWYBM/MnAup9BFNqMfZuE+JS4RgwBDn83YQCf/9J5mcoS7C6Hhii+hhe5UQJRhgvJOhHEtD4k/qG8uGWmPsabQrexxrU45Dt14Q4ANxjq7L9BTE6FJM2FZ0udXMzNPOfLeLQamYpHQurtZL0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718133083; c=relaxed/simple;
	bh=UkGV3jViyK7CCodOiLP0I28A/W5NyyJEnNed20MNXgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMQOx+SalJpsMn05k2t0CxkWBg6Vr72RzAHZmTdndxS+elt9RQ2ASC0I2ubmEWbHE7Y8jpBEyZ+ckxKqBPAVJvWp/tQGLCxHQPVrHy2QkCtVSJmatNgatYTW5N9ekr2lKOgB1JHMCZvsRCzZtl6YDbOQ828jCROUjV/g8fHfWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FcDrKK00; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FcDrKK00"
Received: from [172.27.0.16] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45BJAqGk3450687
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Jun 2024 12:10:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45BJAqGk3450687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718133054;
	bh=d4EecACxd1/eknGJpVsdD/T6QjJbgEmemd7Uy4R2/iE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FcDrKK005edO84NlGSKCHonXnrTkE/r51KL/NMKqunVaNRui2WpfFdO/BpVgfR/fg
	 cijZ1mmQOVhjuw23X5bqb2Oh0jB6rkYWPJwvb3BDsb/MuOiehXzufVxGLN9QzvTVg7
	 G4XoWK2Jwn9L7euUvDgpOf3rRAliMH1b/lpFdsauBar7Tm2JD0UrMeRslQu9BIlDoP
	 4UiYmIsZjeiW8gb3YInrPak+NpJLz2CvDtypstU3D3xjd70JdcPQTfztHCufFebTC5
	 7SU5bOqZGM96KDK5+CghzziQPRW4TJSOgf5BzF7Ck15pAANOTa+qVRfPLacOpDa4Nq
	 kwjiOpGau0TfQ==
Message-ID: <8afef909-974e-40fe-a39c-3c1e4e6d6938@zytor.com>
Date: Tue, 11 Jun 2024 12:10:52 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] perf/x86: Enable NMI source reporting for perfmon
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>,
        Zeng Guang <guang.zeng@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
 <20240611165457.156364-6-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240611165457.156364-6-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 09:54, Jacob Pan wrote:
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 1ef2201e48ac..db8c30881f5c 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -46,6 +46,7 @@
>   
>   struct x86_pmu x86_pmu __read_mostly;
>   static struct pmu pmu;
> +u32 apic_perfmon_ctr = APIC_DM_NMI;
>   
>   DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
>   	.enabled = 1,
> @@ -1680,7 +1681,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>   	 * This generic handler doesn't seem to have any issues where the
>   	 * unmasking occurs so it was left at the top.
>   	 */
> -	apic_write(APIC_LVTPC, APIC_DM_NMI);
> +	apic_write(APIC_LVTPC, apic_perfmon_ctr);
>   
>   	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
>   		if (!test_bit(idx, cpuc->active_mask))
> @@ -1723,7 +1724,10 @@ void perf_events_lapic_init(void)
>   	/*
>   	 * Always use NMI for PMU
>   	 */
> -	apic_write(APIC_LVTPC, APIC_DM_NMI);
> +	if (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
> +		apic_perfmon_ctr |= NMI_SOURCE_VEC_PMI;
> +
> +	apic_write(APIC_LVTPC, apic_perfmon_ctr);
>   }
>
There really is no reason to not do this unconditinoally. If NMI source 
is not supported it is simply a noop.

	-hpa

