Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C82E57CB5;
	Tue, 11 Jun 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131457; cv=none; b=RLTFj17pwhjpcQH9EbkiMGF69dN56F1f4TVrQP7CrNXEG8GiJvX7mfrXZllNv3grFH1OeYoyP/4enTDa3pOJZlCs6V0cGa+eb3ftQ+noKXVgGfYlyOARAjYRHom/VM4VOrkd9XQJpmc+npAqaHBV7tIFleb09o7VXOx+dBU2ESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131457; c=relaxed/simple;
	bh=Xm8ZCPzho8rIZqCfzyF8hjk0wZs1XtBrF2KhmozpXXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GypoPkHIZYHveRVmQDBZ48/onRyMgJ/ovlt4srnwqigpdYKUbNZcHVyYDC08ZZ/J8V0IRQe3NKojVCfogDotI4QYGrMJR5Jjr3vcQWtSaLBNxCSiOMhBEXZOQwWGQcA1Qa2AUhPfX+OC2p56wqRMpEcIDY972t1V7eQUVucPR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hBHrPL1d; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hBHrPL1d"
Received: from [172.27.0.16] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45BIf7Ab3441038
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Jun 2024 11:41:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45BIf7Ab3441038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718131268;
	bh=6D9Voz2hwOBjGt+fJGrKweiWjFeqphX1wDLXHwPASy8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hBHrPL1dHS+GeCKtTR0MMIhmEz86mFu3Xhxo/sUHoa6r1vNivZPqlKYOZBitRzfeU
	 l2+WmW0Nawn05BIitpBmDzNtudkJ0ARyjovgQFDcy+cIlKoA9pgm5e9Osgx36iQqOH
	 tLJ1fFPqRL76VssdVGJcPO5bRwcNIyVfaqeq6LORCPI1IHaovGVXTS0qX8R8bHTWo1
	 EUUPma1PKHSj/9MvkKXjv6WfiNux3WZNqnsGp7juYUXpzBaWBVvjmKPkk1lTvPbInM
	 5kqRYgqJ1h+Ozr952PSgJ2WZhKIAEXRBZTaW617UgkuY5LDO3imw2xBzy4VYEfdUj2
	 Bd2WEQ1P3SOWQ==
Message-ID: <b2a230b0-3f00-49b3-87fb-63622f697395@zytor.com>
Date: Tue, 11 Jun 2024 11:41:07 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] x86/irq: Process nmi sources in NMI handler
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
 <20240611165457.156364-5-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240611165457.156364-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 09:54, Jacob Pan wrote:
> +
> +	source_bitmask = fred_event_data(regs);
> +	if (!source_bitmask) {
> +		pr_warn_ratelimited("NMI without source information! Disable source reporting.\n");
> +		setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
> +		return 0;
> +	}

Is setup_clear_cpu_cap() even meaningful here?

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

You can still dispatch the known NMI handlers early before doing the 
polling.

> +	rcu_read_lock();
> +	/* Bit 0 is for unknown NMI sources, skip it. */
> +	for_each_set_bit_from(vec, &source_bitmask, NR_NMI_SOURCE_VECTORS) {
> +		a = rcu_dereference(nmiaction_src_table[vec]);
> +		if (!a) {
> +			pr_warn_ratelimited("NMI received %d no handler", vec);
> +			continue;
> +		}
> +		handled += do_handle_nmi(a, regs, type);
> +	}
> +	rcu_read_unlock();
> +	return handled;
> +}
> +

That would mean that you would also need to return a bitmask of which 
source vectors need to be handled with polling.

	-hpa
