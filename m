Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D81C68B0;
	Wed, 29 May 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717017175; cv=none; b=fcWWyKnxqnjhrqNvaSEw1Rpv45RrAp039MfQJUtFfkYJGJNpl2f7AnQ0Rd4+ip2TgqnNatNfmp7ys2cVCCSgMTW5k6IQlxYLp8pdv0RkJlX6k077cGYjTzNYmF1csoewS8NBjDrjh3jyexx9xtYTPfiI7MyoniAwEfQKo8FmaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717017175; c=relaxed/simple;
	bh=WyvJEaiV7vktTeJBx3VE7SviCdnt2j0L8vmtJoH9v9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYBbsndIDXJAgmy10P75sXalXB41br4uVSjPq96SBXYpnBXK0xY9O5nZe35UVY29m03zLcPJfwEvz9q7+ShE/sBGTb/802xyet3zBv5DYzw3n0Vk3oHKexlcOnZUQNXcu7F5cIY4xQkgnhTwTcCA3v7pPmR/4UrCb8uFKWww3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=V94eJpoK; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="V94eJpoK"
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 44TLCPAl3724046
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 29 May 2024 14:12:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 44TLCPAl3724046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717017146;
	bh=dXiIrmdSV6YGWgsb6HsVTYKu3Nn4eD0Hhuc5MMdf2M0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V94eJpoK7Pauzv0PihWtJ9ZIjlxhYhPW3LzJ4ZdUYEZ5x2JJpvu2AER8MjThSsV+5
	 aWZkE6hqhCjBlYbJNlpCblhjdAGnNNmSuDYDimD6KZpsqo2jBglOso0H1ViDKxYJFQ
	 pOwWgWCnA1nEY88n8C85KfBqvFfOSiW5a2jgc+yinW0WkEPWAmE4VXLcS44dil/OyY
	 XwwdyFTQP2uzrlGYqwd5/YTkLOPgXLAaqrcQyAFzlQyQCN8mSTpdKdTOfcgXJRgxC6
	 B149MVWVAK2wZqsTEaQbZyAJCCDM1oxloJ8lXqT3DeDoG6NMDHGX93Y5IilCdg/34V
	 B8FUZ3CKwM94Q==
Message-ID: <ae870a38-e7ee-4334-ba4d-ca3e4e17a53d@zytor.com>
Date: Wed, 29 May 2024 14:12:19 -0700
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
> +	rcu_read_lock();
> +	/* Bit 0 is for unknown NMI sources, skip it. */
> +	for_each_set_bit_from(vec, &source_bitmask, NR_NMI_SOURCE_VECTORS) {
> +		a = rcu_dereference(nmiaction_src_table[vec]);
> +		if (!a) {
> +			pr_warn_ratelimited("NMI received %d no handler", vec);
> +			continue;
> +		}

In this case, you should assume some chipset hardware or VMM is giving 
you garbage in the event bitmask, and treat it as if bit 0 were set.

	-hpa
