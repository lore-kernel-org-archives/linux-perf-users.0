Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA492E542;
	Wed, 29 May 2024 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717017523; cv=none; b=Ngpj74LhIV8cndjmqkYCLbwRemGqnaD9EnhRjSbqBDDvnRjTi3jbFcB3k2skBSo8QKXnJe9hXLSzwxz18c1a/jL7XM5V4tw4nGPjSTKcFK+jOYWl7qboTTpBWgrfjVOChUu0+AnFJzmvCCacqaVOvEF8W9B0l7QBSTIhiqOmams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717017523; c=relaxed/simple;
	bh=IZs/q09ZSn8BsUKn+kP79Ja3nU3BdmRd1qnp4hkcDZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/vPm+WWKfT7pntlCK++UmVghCDV3jwvyMG3q+1UUrG3NRs9diL798e3PMCDa2lKaE0uwOZ+jXbvpb2cuc595xYRcSoonEqIBPGFByY1jjFIf1PuAF3ezfQBKF5ROsaOWlSL8DcwyvJuBS+qNY9pXdDiUmndepOi8jswlA6TN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=X4vBdwdj; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X4vBdwdj"
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 44TKlFsV3675299
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 29 May 2024 13:47:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 44TKlFsV3675299
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717015638;
	bh=UTZRyfMUuP5zS7iBwBnR/t/GyMms6oWolz/gvkj2lLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X4vBdwdjffJ1eKtTy2dt0kWp97rh4Wc8HRRGLer35GOgEHtYahwODGMXrUA/II+1c
	 j2EY/HFjjUxZy3YAGlTAF1904FsflttIQXW8KQn/DTC78/7FoC5dlitgfPBQ52u/rV
	 owUpPjZ5pP/lEQnOTNz79zAGLjHxzoVAZ9L5OCBMvD8HAPe74RIfLpoD2lQajrpeLl
	 Y5ksF5PCYx8aE7FKpASRU1qT8DMsutfalxo6A5XCW0WNo4FLN8MwZcLnI3olN13M10
	 j9Ge9aJSHK7on7ZJ39E8PdbphfGtsE72Sv43VjvzPWYxU01ik2oxC2jIv/tyNl2w03
	 HK62Q6lsBdkrQ==
Message-ID: <0bac819f-fdbe-4de2-8a5f-30ded87bb036@zytor.com>
Date: Wed, 29 May 2024 13:47:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] x86/irq: Process nmi sources in NMI handler
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
References: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
 <20240529203325.3039243-5-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240529203325.3039243-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 13:33, Jacob Pan wrote:
> +
> +	/*
> +	 * Per NMI source specification, there is no guarantee that a valid
> +	 * NMI vector is always delivered, even when the source specified
> +	 * one. It is software's responsibility to check all available NMI
> +	 * sources when bit 0 is set in the NMI source bitmap. i.e. we have
> +	 * to call every handler as if we have no NMI source.
> +	 * On the other hand, if we do get non-zero vectors, we know exactly
> +	 * what the sources are. So we only call the handlers with the bit set.
> +	 */
> +	if (source_bitmask & BIT(NMI_SOURCE_VEC_UNKNOWN)) {
> +		pr_warn_ratelimited("NMI received with unknown source\n");
> +		return 0;
> +	}
> +

Note: if bit 0 is set, you can process any other bits first (on the 
general assumption that if you bother with NMI source then those events 
are performance sensitive), and you could even exclude them from the 
poll. This is an optimization, and what you have here is correct from a 
functional point of view.

> +	source_bitmask = fred_event_data(regs);
> +	if (!source_bitmask) {
> +		pr_warn_ratelimited("NMI received without source information!\n");
> +		return 0;
> +	}

If the event data word is 0, it probably should be treated as a 
*permanent* failure, as it is a Should Not Happen[TM] situation, and 
means there is an implementation (or, perhaps more likely, 
virtualization!) bug, and as such it may not be safe to trust the NMI 
source information in the future.

> +	if (!cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) || type != NMI_LOCAL)
> +		return 0;

I'm not sure I understand why you are requiring type to be NMI_LOCAL here?

	-hpa
