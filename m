Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8D21ADCC;
	Fri,  7 Mar 2025 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372184; cv=none; b=LU0WnVS1CkeezINqL8vuUe2NP8xLYhmdSF2hDJ8DJRxGI9JPOYRHEGAPebtw48WDFp7hQhpU9o/70mY3FAOXvZQ6wgtd8EvKyMy+WY+pcap9AffVqMG69LXJLokCQraPP0VZSjiHMTdYMsx4uPbY0tnpwxqLm69+rYoiz97q5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372184; c=relaxed/simple;
	bh=OlhjxOwchdWE24D9CVGPrF0rqVV67b2eg9n5uJuMMvk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=COCiQE+B9/E0fsIeGRf2m9wt39La5WqWJdx8AIpPfgsY0ExmB7m/kRs9pjp5Lgh9ZCLsvFalGEDVfWcX0FysHzJrBipXlf5tue9DDoj8OlPw90A5R4Rhxe8mNjCK9hy6dXDCA+H7MFT68n5aYPdSEhqXAqamCDnZftiqRND81DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=P+XOR+as; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="P+XOR+as"
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527ISvgt371862
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 10:28:57 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527ISvgt371862
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741372139;
	bh=Kw3Sb9QMf0XT9oIXV70XQt9+tlU01Vyy+rZ6VfEByXY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=P+XOR+ascBKH5UlIhU7GbgsYk9tqHVI5mzNuSvPKVMajt16J0Ms5atBT63dnIuPht
	 vQOP024oaeRIMKFie4ObxLtGREKd53fIGnrwUluDPng5CxqxlfoNL5MNQgChgCdby8
	 r5V6EtURoK7zChkfHZraJw9x9NIWneCvHWwSLX1OsSMTCINOT94/mtGdK7lXJOlgPW
	 IVkgslx0yQxCkm8H8te349d2lpWG8kijRZG+uqS83tI7EvWjHxrguZZ3ZS7OEHAlfX
	 P/qJs57bDniajMOJlxqBklCP9ShvFe/pjWQKqmFP1pvz1qMJyjDry+JPsS9lllPSik
	 SsWuvrn6SQ0/A==
Message-ID: <4b44eaec-2c45-4a68-80c5-6a8c0905b1ab@zytor.com>
Date: Fri, 7 Mar 2025 10:28:56 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/4] x86/cpufeatures: Automatically generate required
 and disabled feature masks
From: Xin Li <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
        brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com,
        sraithal@amd.com, philip.li@intel.com
References: <20250305184725.3341760-1-xin@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250305184725.3341760-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/2025 10:47 AM, Xin Li (Intel) wrote:
> The x86 build process first generates required and disabled feature
> masks based on current build config, and then uses these generated
> masks to compile the source code.  When a CPU feature is not enabled
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
> Link to v6:
> https://lore.kernel.org/lkml/20250228082338.73859-1-xin@zytor.com/
> 
> Changes in v7:
> * Fix build error with "make distclean; make headers" (Aithal, Srikanth)
> * Collect reviewed-bys.
> 

This version v7 can be cleanly applied on tip/x86/cpu but NOT the latest 
tip/master.

I guess I don't have to rebase on the latest tip/master and resend it?

Thanks!
     Xin

> 
> H. Peter Anvin (Intel) (2):
>    x86/cpufeatures: Add {required,disabled} feature configs
>    x86/cpufeatures: Generate a feature mask header based on build config
> 
> Xin Li (Intel) (2):
>    x86/cpufeatures: Remove {disabled,required}-features.h
>    x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET
> 
>   arch/x86/Kconfig                              |   2 +
>   arch/x86/Kconfig.cpufeatures                  | 197 ++++++++++++++++++
>   arch/x86/Makefile                             |  15 ++
>   arch/x86/boot/cpucheck.c                      |   3 +-
>   arch/x86/boot/cpuflags.c                      |   1 -
>   arch/x86/boot/mkcpustr.c                      |   3 +-
>   arch/x86/include/asm/Kbuild                   |   1 +
>   arch/x86/include/asm/cpufeature.h             |  70 +------
>   arch/x86/include/asm/cpufeatures.h            |   8 -
>   arch/x86/include/asm/disabled-features.h      | 161 --------------
>   arch/x86/include/asm/required-features.h      | 105 ----------
>   arch/x86/kernel/verify_cpu.S                  |   4 +
>   arch/x86/tools/featuremasks.awk               |  88 ++++++++
>   tools/arch/x86/include/asm/cpufeatures.h      |   8 -
>   .../arch/x86/include/asm/disabled-features.h  | 161 --------------
>   .../arch/x86/include/asm/required-features.h  | 105 ----------
>   tools/perf/check-headers.sh                   |   2 -
>   17 files changed, 311 insertions(+), 623 deletions(-)
>   create mode 100644 arch/x86/Kconfig.cpufeatures
>   delete mode 100644 arch/x86/include/asm/disabled-features.h
>   delete mode 100644 arch/x86/include/asm/required-features.h
>   create mode 100755 arch/x86/tools/featuremasks.awk
>   delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
>   delete mode 100644 tools/arch/x86/include/asm/required-features.h
> 
> 
> base-commit: 32dc26a2f55f71907af0874468298c6ab8a8f7f9

