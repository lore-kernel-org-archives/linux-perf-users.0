Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88201C68AE;
	Wed, 29 May 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717016426; cv=none; b=EQxsn2a3JfX6Q6qhCEjFc0pzpmQbZJjkc1ABiX67pKhleEFPwb3R4J8CZPXoc3oDJG5id/1lDsoJ40FYAAcSD9N72h/ZdOHtpGp0olPhe5ztzXZUHEjojEDeu/JFz5kamhJkLsAva64Xxul6ElqKjmWkN+Znr5myn/lN1G1t6A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717016426; c=relaxed/simple;
	bh=hhUIEFW6clsqHfXWPi43BFltxUFJorc+dCRnW5g87yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkvwLF4FRjaW+WtBxS5mWHkhss+PoBy/mM369EOBbxWmg8ifMcC4yaK90h/uqtGmtq0UFctVQJhontExnPKZuztT6z/qfb8SC7VjN19v8Rp8mdicoctlv5rC9UJiKqBnbsYIKqAEaa5d5+0iDyr+3Vhc47zMllpmcOitWaLL5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=MvKoFnd5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MvKoFnd5"
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 44TKxuet3698639
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 29 May 2024 13:59:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 44TKxuet3698639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717016399;
	bh=dCTZ0kTcw9gD6nzityX2P8p7to8LRjQC6Tvw6Gljs0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MvKoFnd5IATi0F+TV49dchN/2fatIVl9nWMkBtN15640BXlfO8q2YWF+9NMfGkuy3
	 3rls21dVKglZXKLPpoeL3RXa3fCc/LqTju1wEWU0I799xkxnbs5idrte6CH9IZ34TW
	 1XkAtlVsu/syoEnR+n1vsUiXvWP1ro7QlowrvenTwQ9cD+oglqbxT9n/+mpSSKoHpV
	 GUqq0oWlZzrGUx1cF6+OVhuriA7U3/7z0q8IZDAt2m6yVmbpl037bLr3/os1St3qGC
	 c/6/0wFM2woWDfBLS4d/9vabx/HdyO7Np9Jac+IxpaogeuLPCqJCfQ64YlEpFHh60w
	 uiEgnY25fzkeQ==
Message-ID: <746fecd5-4c79-42f9-919e-912ec415e73f@zytor.com>
Date: Wed, 29 May 2024 13:59:51 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] x86/irq: Extend NMI handler registration interface to
 include source
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
References: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
 <20240529203325.3039243-3-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240529203325.3039243-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 13:33, Jacob Pan wrote:
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
> index 13aea8fc3d45..b8388bc00cde 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -105,6 +105,27 @@
>   
>   #define NR_VECTORS			 256
>   
> +/*
> + * The NMI senders specify the NMI source vector as an 8bit integer in their
> + * vector field with NMI delivery mode. A local APIC receiving an NMI will
> + * set the corresponding bit in a 16bit bitmask, which is accumulated until
> + * the NMI is delivered.
> + * When a sender didn't specify an NMI source vector the source vector will
> + * be 0, which will result in bit 0 of the bitmask being set. For out of
> + * bounds vectors >= 16 bit 0 will also be set.
> + * When bit 0 is set, system software must invoke all registered NMI handlers
> + * as if NMI source feature is not enabled.
> + */
> +#define NMI_SOURCE_VEC_UNKNOWN		0
> +#define NMI_SOURCE_VEC_PMI		1	/* PerfMon counters */
> +#define NMI_SOURCE_VEC_IPI_BT		2	/* CPU backtrace */
> +#define NMI_SOURCE_VEC_IPI_MCE		3	/* MCE injection */
> +#define NMI_SOURCE_VEC_IPI_KGDB		4
> +#define NMI_SOURCE_VEC_IPI_REBOOT	5	/* Crash reboot */
> +#define NMI_SOURCE_VEC_IPI_SMP_STOP	6	/* Panic stop CPU */
> +#define NMI_SOURCE_VEC_IPI_TEST		7	/* For remote and local IPIs*/
> +#define NR_NMI_SOURCE_VECTORS		8
> +

I would avoid using vector 2; it is at least remotely possible that some 
third-party chipset sends NMI messages with a hardcoded vector of 2. As 
long as you don't actively need that slot, it is better to avoid it.

Even better is to set the LINT1 (= external NMI) vector to 2 and treat 
bit 2 as "other"; use vector 2 for anything that you don't have an 
explicit vector for. You can treat a received bit 2 the same as bit 0, 
except that you can explicitly trust that any event assigned an explicit 
vector number is *NOT* triggered and so do not need to be polled.

I would also recommend sorting these in order of decreasing importance 
(other than 0 and 2). Although the current intent is there to be 16 
vectors indefinitely, defensive design would be to consider that number 
to be potentially variable (up to 64, obviously). Since any out-of-range 
vector will set bit 0, the code will still Just Work[TM].

	-hpa
