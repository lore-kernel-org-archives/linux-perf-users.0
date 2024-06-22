Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E3B669;
	Sat, 22 Jun 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719077529; cv=none; b=WUIcmq7RevlqN5UHnTMke/O9YhhZJm5ERM2ooYAAVb41GxriAeEtKuKT/15qjkCQfBP/gayZ2+nxypU7e3Kx3Km5zWAmkqOHV9vXEfpDBInCeZ/vlxRB4jf47o/yP7iODx5CuUsAYFRKdg6P1+teQv4O3q8zvt6dfFbDFXNoF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719077529; c=relaxed/simple;
	bh=rdpXsBDLIYTbLtsmOfxpJQSAf96xXh7ure4E0EpktNY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fl+36E0HkX870+tgRWtMG+yzJj+o7QToIpGZmwIskH0DE4EhemsAN3C7RK5tRLIYwxWkPeM4dkeHkxtTRqAb0Fzg5cfH/ttOU8+pFper+7tJYEGgdHvpQguzzEE5A0jnpdBDssv9kdJ2Tl+253tl3IqmWB4RAhyLbFxymkjVJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=dwJjtC4c; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dwJjtC4c"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45MHVXVf3730522
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 22 Jun 2024 10:31:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45MHVXVf3730522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719077495;
	bh=rJeCMU4o9YGVYOVeuZ8Zeiz30iEMnUk9V2/VJeXZa0U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=dwJjtC4cb0pSATF4pYR5wnyO502lTzPKBu38EHi8kvqmFJ+BojuDl1X+COhod5Ict
	 /juzDTzmCSvF34XXFhG/86cSRjkegvGLU5sdz/M/9moYoL9w+EZ/MrAyF3daiG3Soj
	 +rEhq+M7F/COvzCzjk/faIUW4C33D8u27ufE0dRO3HEOYrx5rb1gxxZ18I2E4WWe/3
	 66bVznLuEe6z1GJnqi5x9wBGtJ5XFUx2zG/Tmz29yhYaI9oDP5L18pDpCbrWMKFHvo
	 BOaA2MSR0VYkisklOOjxbD0Ht7gzvH39a4bFqabGwiMEWuFpO18gs8sFHjCfLhpIWE
	 wNIf11TtF2pVw==
Message-ID: <aaca293d-568f-4c5e-84dc-313bf36786bb@zytor.com>
Date: Sat, 22 Jun 2024 10:31:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] x86/cpufeatures: Automatically generate required
 and disabled feature masks
From: Xin Li <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com
References: <20240622171435.3725548-1-xin@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240622171435.3725548-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/22/2024 10:14 AM, Xin Li (Intel) wrote:
> The x86 build process first generates required and disabled feature
> masks based on current build config, and then uses these generated
> masks to compile the source code. When a CPU feature is not enabled
> in a build config, e.g., when CONFIG_X86_FRED=n, its feature disable
> flag, i.e., DISABLE_FRED, needs to be properly defined and added to
> a specific disabled CPU features mask in <asm/disabled-features.h>,
> as the following patch does:
> https://lore.kernel.org/all/20231205105030.8698-8-xin3.li@intel.com/.
> As a result, the FRED feature bit is surely cleared in the generated
> kernel binary when CONFIG_X86_FRED=n.
> 
> Recently there is another case to repeat the same exercise for the
> AMD SEV-SNP CPU feature:
> https://lore.kernel.org/all/20240126041126.1927228-2-michael.roth@amd.com/.
> https://lore.kernel.org/all/20240126041126.1927228-23-michael.roth@amd.com/.
> 
> It was one thing when there were four of CPU feature masks, but with
> over 20 it is going to cause mistakes, e.g.,
> https://lore.kernel.org/lkml/aaed79d5-d683-d1bc-7ba1-b33c8d6db618@suse.com/.
> 
> We want to eliminate the stupidly repeated exercise to manually assign
> features to CPU feature words through introducing an AWK script to
> automatically generate a header with required and disabled CPU feature
> masks based on current build config, and this patch set does that.
> 

Here is an example of the auto generated feature masks header:

ifndef _ASM_X86_FEATUREMASKS_H
#define _ASM_X86_FEATUREMASKS_H

/*
  * REQUIRED features:
  *
  *    FPU PSE MSR PAE CX8 PGE CMOV FXSR XMM XMM2 LM NOPL ALWAYS CPUID
  */

#define REQUIRED_MASK0  0x0700a169
#define REQUIRED_MASK1  0x20000000
#define REQUIRED_MASK2  0x00000000
#define REQUIRED_MASK3  0x02300000
#define REQUIRED_MASK4  0x00000000
#define REQUIRED_MASK5  0x00000000
#define REQUIRED_MASK6  0x00000000
#define REQUIRED_MASK7  0x00000000
#define REQUIRED_MASK8  0x00000000
#define REQUIRED_MASK9  0x00000000
#define REQUIRED_MASK10 0x00000000
#define REQUIRED_MASK11 0x00000000
#define REQUIRED_MASK12 0x00000000
#define REQUIRED_MASK13 0x00000000
#define REQUIRED_MASK14 0x00000000
#define REQUIRED_MASK15 0x00000000
#define REQUIRED_MASK16 0x00000000
#define REQUIRED_MASK17 0x00000000
#define REQUIRED_MASK18 0x00000000
#define REQUIRED_MASK19 0x00000000
#define REQUIRED_MASK20 0x00000000
#define REQUIRED_MASK21 0x00000000

#define REQUIRED_FEATURE(x)                             \
         ((                                              \
                 ((x) >> 5) ==  0 ? REQUIRED_MASK0 :     \
                 ((x) >> 5) ==  1 ? REQUIRED_MASK1 :     \
                 ((x) >> 5) ==  3 ? REQUIRED_MASK3 : 0   \
         ) & (1 << ((x) & 31)))

#define REQUIRED_MASK_BIT_SET(x)                        \
         (REQUIRED_FEATURE(x) || BUILD_BUG_ON_ZERO(NCAPINTS != 22))

/*
  * DISABLED features:
  *
  *    VME K6_MTRR CYRIX_ARR CENTAUR_MCR XENPV TDX_GUEST UNRET LAM SEV_SNP
  */

#define DISABLED_MASK0  0x00000002
#define DISABLED_MASK1  0x00000000
#define DISABLED_MASK2  0x00000000
#define DISABLED_MASK3  0x0000000e
#define DISABLED_MASK4  0x00000000
#define DISABLED_MASK5  0x00000000
#define DISABLED_MASK6  0x00000000
#define DISABLED_MASK7  0x00000000
#define DISABLED_MASK8  0x00410000
#define DISABLED_MASK9  0x00000000
#define DISABLED_MASK10 0x00000000
#define DISABLED_MASK11 0x00008000
#define DISABLED_MASK12 0x04000000
#define DISABLED_MASK13 0x00000000
#define DISABLED_MASK14 0x00000000
#define DISABLED_MASK15 0x00000000
#define DISABLED_MASK16 0x00000000
#define DISABLED_MASK17 0x00000000
#define DISABLED_MASK18 0x00000000
#define DISABLED_MASK19 0x00000010
#define DISABLED_MASK20 0x00000000
#define DISABLED_MASK21 0x00000000

#define DISABLED_FEATURE(x)                             \
         ((                                              \
                 ((x) >> 5) ==  0 ? DISABLED_MASK0 :     \
                 ((x) >> 5) ==  3 ? DISABLED_MASK3 :     \
                 ((x) >> 5) ==  8 ? DISABLED_MASK8 :     \
                 ((x) >> 5) == 11 ? DISABLED_MASK11 :    \
                 ((x) >> 5) == 12 ? DISABLED_MASK12 :    \
                 ((x) >> 5) == 19 ? DISABLED_MASK19 : 0  \
         ) & (1 << ((x) & 31)))

#define DISABLED_MASK_BIT_SET(x)                        \
         (DISABLED_FEATURE(x) || BUILD_BUG_ON_ZERO(NCAPINTS != 22))

#endif /* _ASM_X86_FEATUREMASKS_H */
