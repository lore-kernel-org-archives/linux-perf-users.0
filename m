Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D17F5250;
	Wed, 12 Jun 2024 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159653; cv=none; b=AA07LoH3BDHL/U5DRj4zpsVSbiF+JLvAEJ8R3Crl3ocnnIhxlCjyJSj1xECX4oPj/WcHNYVk1Ax+ysrFDydAtjnXtbl9bj6J/tM9OabdT+xhpHHxyP/Qwmu8e0nl5C8or62Sh3GB03pgHB3O+iJ3mSkagcUYwUBswZ9L2LTzKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159653; c=relaxed/simple;
	bh=i+BQvAZ+MeyKroQIuv7sTUuzgiOhIFBjEq7ANr3eFLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PK8iDZvnKlgv6wyyxlS0wjP0TipZ2fepNAzTuz/u8OWwA1szmsZ0IRb7aZu1UBA5qBURkYvpyZJUCCbCCJKuGfneaW8SieGuD2Dzr5TCe2hbN8aTRLIoRI7oGw8rb7TPOAsDnVMlRKX9/gcXl70UUmjOc4zhuXUS1n7xuVrEfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=jm90+YKu; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jm90+YKu"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45C2WtNW3575967
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Jun 2024 19:32:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45C2WtNW3575967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718159577;
	bh=zjJ8XWfulk9qeCo8A6OisWPp4DLMy3LwREsJNs7gAAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jm90+YKu30jkepNKCGaYeKs+h2MpJbxK0fsVepXbgmx/BuAEJ/EPZCgLAMbzIIVZd
	 +vAtS/K7nYH530s/Y2Vdnq2rjIJEU2ncYKOjR1j2S4Zl8jP7pjz9ZQhB37gVJhGtbT
	 wla9M/WWXBgd9rUPkqL7MbHryqtg+/e1xqyTMPTZu0gf/EPWLQ8SSOQ3PrA9LK/3mF
	 EvdR5VA8ldu41f/agVXUs9Fc5oR0v42MVm2/2RtnAEXO19dejW/nYbXtUV4dkwr5bW
	 IIv65lsdSUsIXAs2P+BUzzPvSjin2AhHHUN2w0jJgbnmiqTDXX6X0Yq6A9o4huvf1f
	 q2dCIo6nQKV1g==
Message-ID: <de99f490-8b8d-4ae9-9f87-e0336e563aba@zytor.com>
Date: Tue, 11 Jun 2024 19:32:54 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] x86/irq: Add enumeration of NMI source reporting
 CPU feature
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
 <20240611165457.156364-2-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240611165457.156364-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/2024 9:54 AM, Jacob Pan wrote:
> The lack of a mechanism to pinpoint the origins of Non-Maskable Interrupts
> (NMIs) necessitates that the NMI vector 2 handler consults each NMI source
> handler individually. This approach leads to inefficiencies, delays, and
> the occurrence of unnecessary NMIs, thereby also constraining the potential
> applications of NMIs.
> 
> A new CPU feature, known as NMI source reporting, has been introduced as
> part of the Flexible Return and Event Delivery (FRED) spec. This feature
> enables the NMI vector 2 handler to directly obtain information about the
> NMI source from the FRED event data.
> 
> The functionality of NMI source reporting is tied to the FRED. Although it
> is enumerated by a unique CPUID feature bit, it cannot be turned off
> independently once FRED is activated.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v2: Removed NMI source from static CPU ID dependency table (HPA)
> ---
>   arch/x86/Kconfig                         | 9 +++++++++
>   arch/x86/include/asm/cpufeatures.h       | 1 +
>   arch/x86/include/asm/disabled-features.h | 8 +++++++-
>   arch/x86/kernel/traps.c                  | 4 +++-
>   4 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1d7122a1883e..b8b15f20b94e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -511,12 +511,21 @@ config X86_CPU_RESCTRL
>   config X86_FRED
>   	bool "Flexible Return and Event Delivery"
>   	depends on X86_64
> +	select X86_NMI_SOURCE
>   	help
>   	  When enabled, try to use Flexible Return and Event Delivery
>   	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
>   	  ring transitions and exception/interrupt handling if the
>   	  system supports it.
>   
> +config X86_NMI_SOURCE

Lets reuse X86_FRED instead of adding another hard config option. See
below.

> +	def_bool n
> +	help
> +	  Once enabled, information on NMI originator/source can be provided
> +	  via FRED event data. This makes NMI processing more efficient in that
> +	  NMI handler does not need to check for every possible source at
> +	  runtime when NMI is delivered.
> +
>   config X86_BIGSMP
>   	bool "Support for big SMP systems with more than 8 CPUs"
>   	depends on SMP && X86_32

...

> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
> index c492bdc97b05..3856c4737d65 100644
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -123,6 +123,12 @@
>   # define DISABLE_FRED	(1 << (X86_FEATURE_FRED & 31))
>   #endif
>   
> +#ifdef CONFIG_X86_NMI_SOURCE
> +# define DISABLE_NMI_SOURCE	0
> +#else
> +# define DISABLE_NMI_SOURCE	(1 << (X86_FEATURE_NMI_SOURCE & 31))
> +#endif
> +
>   #ifdef CONFIG_KVM_AMD_SEV
>   #define DISABLE_SEV_SNP		0
>   #else
> @@ -145,7 +151,7 @@
>   #define DISABLED_MASK10	0
>   #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
>   			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
> -#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
> +#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM|DISABLE_NMI_SOURCE)
>   #define DISABLED_MASK13	0
>   #define DISABLED_MASK14	0
>   #define DISABLED_MASK15	0
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 4fa0b17e5043..465f04e4a79f 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -1427,8 +1427,10 @@ early_param("fred", fred_setup);
>   
>   void __init trap_init(void)
>   {
> -	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
> +	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred) {
>   		setup_clear_cpu_cap(X86_FEATURE_FRED);
> +		setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
> +	}

With this, no need to add DISABLE_NMI_SOURCE to disabled-features.h:

1) If FRED is not available, NMI source won't be too.
2) If FRED is available but not enabled, all features relying on FRED
should be cleared. We probably should move the feature bits clearing
code into a static function when more such features are added in future.

>   
>   	/* Init cpu_entry_area before IST entries are set up */
>   	setup_cpu_entry_areas();

Thanks!
     Xin
