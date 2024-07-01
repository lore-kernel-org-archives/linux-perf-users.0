Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896BC166306
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844314; cv=none; b=RU05JbcTROqhtRU2FxNBIA7BZn4XJgHxV4UJTFlPBTavAhrmRkr/djFuLUzEKGKT2YRjYPEnHpI4ZoowEnDvvAHd8ynZrigvZhBZBiWBcTkv55ln1tXpNbvxqY5TdNh/Mr1VD+N3xhDMqwR7yrWbc5uCEqrYS09udk4u5A6mplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844314; c=relaxed/simple;
	bh=48h6l1zqWC6FAJcR5Dg+eeuW3TP8qzIz9t1AHIzUnPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNhx3aIKIkDc3OqbsNwXmGayQzWLH7KdvWUyg7LxE76XqcLWRZVB740ltOOXrTfGIUpIa24zzlXpqIRAd75qQsFbB3Y4a+zr1ZM0picneSGBjZ6DN3dqqrlbtZv51P0Pm/5Xui9pOI6TCj+WDDwY5veeA9AsEOdGfv8OCfoThns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d+E9lBws; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d+E9lBws"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-424acfff613so28090885e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Jul 2024 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719844311; x=1720449111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VOCRwVG01ecQmSR0hkjoMDkRKTxz6h3UW2kuLbhAUQ=;
        b=d+E9lBws2cx75TB+TaLSLqzLM1rvntU+F8jKagodNo1QdVI7cjZ1kT4Vjizkm/wKkU
         S1+VSm1rTVD2TJ69ihAIbyLwZBlLIUor1NezWV4iTlYXQ/1MkKS8WhopuSirLW8TTvZu
         q/8wAEYiGUeUYPZ1LcBW4Jc2AUjQL3X64ZQL5pWFb0zAgrtz6TSdmH+BkVPMJk9jb5ht
         mUbbPDDnbSWY7bPY/kzVMm4UmnKCBlnGIMql+i4VY5xpS4gSIhfkCqzGHcE7jZLqHnNu
         veUkAnNT8JBwMQ+DBHsx3S5Ood8IEKKH7V9LtccdXrQ1TPt+nxVk2EPj5MuzSoMdWj+y
         cwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719844311; x=1720449111;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VOCRwVG01ecQmSR0hkjoMDkRKTxz6h3UW2kuLbhAUQ=;
        b=wIVnBFYniiRTQOAYZ92uKjffYNR+lwm/uldszM7RDzeETciqGEiB+JBy68VC+JTWnw
         vpdkuZVMQhEgoEj+d2A4Mp2qWliA7JToZ3mfGX+ZPfMYHFU3i6CN7nlXzOZXlwG8EQsk
         BMFD2Ef69x72KD2DK/ouNkScKSjSx8IG2oLdG5SPRtT8TGRnVvMRwJXn3qglktzohT+9
         7IgvFdBb6hKEswMgkC+ZxQBO7C5SOoMjIs38Iz6dAPU89XLCL0vFdgOGy4XlcfvQc3JH
         F7RdwdzM+Jnq/w436+W/IoUt5ZS5aBOaweOQoVq/sS6U5FmCm55RlfeeNBF1kE1Ufwqp
         gKtg==
X-Forwarded-Encrypted: i=1; AJvYcCXanawrpzGEqMh0ogqsj+98CaA5uPg2zw/agrw4zh7RTs8IosPSTmYscmSr+DbkFo0Sjupcac15xwpFbcHZwPl3riL1olPAaZx3IjFRhHoBqA==
X-Gm-Message-State: AOJu0Yxc3zw0qUfPxExll7sEEDCCRZoOqfta/gR0F5jo7T8MOCSfuCX5
	uw7bQ7DoftBDV9H64juntjrUOSGpmAzL2zMaURlD7xR09iJ/e/y1FC+10Y9ORPw=
X-Google-Smtp-Source: AGHT+IF3+BYcdFigO1y2gkrvWkoFIz9aCZgiw8OoaoL+u9AB3PBsKVkxQgR/E5Y41MvXpCL0Vo/80Q==
X-Received: by 2002:a05:600c:198e:b0:424:8dba:4a43 with SMTP id 5b1f17b1804b1-42579ffccd2mr46453395e9.5.1719844310885;
        Mon, 01 Jul 2024 07:31:50 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:e371:949e:c782:9f94? ([2a10:bac0:b000:7579:e371:949e:c782:9f94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c18cfsm158644635e9.45.2024.07.01.07.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 07:31:50 -0700 (PDT)
Message-ID: <9cf3eef6-79d9-4969-be94-e5089a0d625b@suse.com>
Date: Mon, 1 Jul 2024 17:31:48 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] x86/irq: Process nmi sources in NMI handler
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
 Sean Christopherson <seanjc@google.com>, LKML
 <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Andy Lutomirski <luto@kernel.org>, acme@kernel.org,
 kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>,
 "Mehta, Sohil" <sohil.mehta@intel.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
 <20240628201839.673086-6-jacob.jun.pan@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240628201839.673086-6-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.06.24 г. 23:18 ч., Jacob Pan wrote:
> With NMI source reporting enabled, NMI handler can prioritize the
> handling of sources reported explicitly. If the source is unknown, then
> resume the existing processing flow. i.e. invoke all NMI handlers.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> ---
> v3:
>     - Use a static flag to disable NMIs in case of HW failure
>     - Optimize the case when unknown NMIs are mixed with known NMIs(HPA)
> v2:
>     - Disable NMI source reporting once garbage data is given in FRED
> return stack. (HPA)
> ---
>   arch/x86/kernel/nmi.c | 73 +++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 639a34e78bc9..c3a10af7f26b 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -149,23 +149,90 @@ static inline int do_handle_nmi(struct nmiaction *a, struct pt_regs *regs, unsig
>   	return thishandled;
>   }
>   
> +static int nmi_handle_src(unsigned int type, struct pt_regs *regs, unsigned long *handled_mask)
> +{
> +	static bool nmi_source_disabled;
> +	bool has_unknown_src = false;
> +	unsigned long source_bitmask;
> +	struct nmiaction *a;
> +	int handled = 0;
> +	int vec = 1;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) ||
> +	    type != NMI_LOCAL || nmi_source_disabled)
> +		return 0;
> +
> +	source_bitmask = fred_event_data(regs);
> +	if (!source_bitmask) {
> +		pr_warn("NMI received without source information! Disable source reporting.\n");
> +		nmi_source_disabled = true;
> +		return 0;
> +	}
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
> +		has_unknown_src = true;
> +	}
> +
> +	rcu_read_lock();
> +	/* Bit 0 is for unknown NMI sources, skip it. */
> +	for_each_set_bit_from(vec, &source_bitmask, NR_NMI_SOURCE_VECTORS) {
> +		a = rcu_dereference(nmiaction_src_table[vec]);
> +		if (!a) {
> +			pr_warn_ratelimited("NMI received %d no handler", vec);
> +			continue;
> +		}
> +		handled += do_handle_nmi(a, regs, type);
> +		/*
> +		 * Needs polling if unknown source bit is set, handled_mask is
> +		 * used to tell the polling code which NMIs can be skipped.
> +		 */
> +		if (has_unknown_src)
> +			*handled_mask |= BIT(vec);
> +	}
> +	rcu_read_unlock();
> +
> +	return handled;
> +}
> +
>   static int nmi_handle(unsigned int type, struct pt_regs *regs)
>   {
>   	struct nmi_desc *desc = nmi_to_desc(type);
> +	unsigned long handled_mask = 0;
>   	struct nmiaction *a;
>   	int handled=0;
>   
> -	rcu_read_lock();
> +	/*
> +	 * Check if the NMI source handling is complete, otherwise polling is
> +	 * still required. handled_mask is non-zero if NMI source handling is
> +	 * partial due to unknown NMI sources.
> +	 */
> +	handled = nmi_handle_src(type, regs, &handled_mask);
> +	if (handled && !handled_mask)
> +		return handled;

How about renaming handled_mask to "partial_handled_mask" ? Because in 
addition to it being a mask it's also used as a boolean to signal that 
an unknown NMI source was encountered.

>   
> +	rcu_read_lock();
>   	/*
>   	 * NMIs are edge-triggered, which means if you have enough
>   	 * of them concurrently, you can lose some because only one
>   	 * can be latched at any given time.  Walk the whole list
>   	 * to handle those situations.
>   	 */
> -	list_for_each_entry_rcu(a, &desc->head, list)
> +	list_for_each_entry_rcu(a, &desc->head, list) {
> +		/* Skip NMIs handled earlier with source info */
> +		if (BIT(a->source_vec) & handled_mask)
> +			continue;
>   		handled += do_handle_nmi(a, regs, type);
> -
> +	}
>   	rcu_read_unlock();
>   
>   	/* return total number of NMI events handled */
