Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F55D1B960;
	Wed, 29 May 2024 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015816; cv=none; b=aCute0yJNeucc2q2/vB0KYfHulw914IM2KTNduJT4T2ukuZIpetgoA/odYMvuBJawXIH1gslKkZaHj+91s18IhQjhEDtCF2ar/LqBEqQSvqh8cEhW4vuw7aN9HH+on9W3k8/2idGi9xKpSpdmTCShSVVUHlYln5zZt1LV6F9A/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015816; c=relaxed/simple;
	bh=Miy+kFZ2+P8ycrCWMIisuRCUzIjZxG4FVNiHwcPNP9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Atpx+MedEL2EDQlkQvmllzQLz2WuY6clReEO/ARaI5l1qwgvks6R/twtXQ02c1s5LslOqNCLpmEXG7+MIB2Kp1AbN2dHxtLmN+QKXmeQQeYT7KC/EJDcrGbsYCFSY5dfMyCE3G5ulIlmgUtUuWrgsZ3UAQ1AjjCog6YZkD6gJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Du2HtpT5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Du2HtpT5"
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 44TKnjVX3680049
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 29 May 2024 13:49:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 44TKnjVX3680049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717015787;
	bh=Dt9nvUxgAaeh3oiuSqLfDzaWvZJkj452nS/FzWKq3N0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Du2HtpT58m/CEIjc+7Sx7ZvdcbvvUpx0CvzJ51hyTt7Mx9VDh1YQLxxbH0dCX8rto
	 dDzHIWyOvI44QfQRw1qUv3r7t63s8iiagLd+PVAQfz1QSb44M+hcMqXT2jnjEy7wNt
	 B8J08zY/rmcKf1zvD3DsBmFpPl9YipZdcrB0P1Y2Vp59bwoqEE+0u0e8H2sleBizZx
	 xwmKS52J4kht975yrmilQlAEbTtd/E0reDj5lTcR6ifziINjTPlNWGqQy+pwF7rXao
	 JmXod/oQ/FBQo+JQwGz2o0+UVZYjD9Psksq8ikTqp5lQL+jHYyiGgSek5aSleWf+ro
	 OYmGBtXIQrJMQ==
Message-ID: <9dabe435-7208-4aa8-886c-a3351ee11e80@zytor.com>
Date: Wed, 29 May 2024 13:49:40 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] x86/irq: Add enumeration of NMI source reporting CPU
 feature
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
References: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
 <20240529203325.3039243-2-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240529203325.3039243-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 13:33, Jacob Pan wrote:
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index b7d9f530ae16..3f1a1a1961fa 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -84,6 +84,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>   	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
>   	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
>   	{ X86_FEATURE_FRED,			X86_FEATURE_WRMSRNS   },
> +	{ X86_FEATURE_FRED,			X86_FEATURE_NMI_SOURCE},
>   	{}
>   };
>   

This is incorrect. FRED does *not* inherently depend on NMI_SOURCE; the 
dependency is the reverse, but since it *also* depends on FRED being 
dynamically enabled, there is no need to add it to the static table; the 
dynamic test:

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 4fa0b17e5043..465f04e4a79f 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -1427,8 +1427,10 @@ early_param("fred", fred_setup);
>  
>  void __init trap_init(void)
>  {
> -	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
> +	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred) {
>  		setup_clear_cpu_cap(X86_FEATURE_FRED);
> +		setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
> +	}
>  
>  	/* Init cpu_entry_area before IST entries are set up */
>  	setup_cpu_entry_areas();

... suffices just fine on its own.

	-hpa
