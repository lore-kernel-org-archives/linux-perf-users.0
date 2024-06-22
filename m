Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CD1DDDB;
	Sat, 22 Jun 2024 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719076625; cv=none; b=GJ1HpE6ENHVZrvKppE7v4LoknmAuzzaxaLxQ99QB+98pQKnrgA05E5iUI+nV09xA5ak6kHrDIHTE4DTGxRR040DahjCANU3SOtyl5fpQvb3XMseKHWyCUnz/knNumKzS1rl48FvcYtgKj+6YtC50COdxqnk62YxnV/VveHs8/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719076625; c=relaxed/simple;
	bh=xP5TP7JzEvS4korFT0KEJ+odHfxfenKgSNo8TAtLZL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8Jm6JE3LMvLOHHQYKRoWOkkLBm28Wmyb2wQxI88waFCE704Lv9jzv/ugrZC2j41vNq2hkeQ/SNdZvdgNdz/6cUaBJ69/Ij2NlJrQ8TTEe4Kx8z8HZROfj/6IFOl7zmmPubY6JVsJpi/8DMuLfT6mvhMF6HrdVaPfq2MRrnKOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=RsDtmFlm; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RsDtmFlm"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45MHGXaw3726020
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 22 Jun 2024 10:16:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45MHGXaw3726020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719076594;
	bh=VeDY+dPeyofTHM2+mxPHpETyZv44QrHDgsksiVZIdTc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RsDtmFlmABmwcjCOM+url5ljwnkpe4hpzUHgNkFTDNFUF6w9XvAdfwydjGx98FM49
	 JjVehblaLor3bv4MlSYRiC1j9P/0kkGngwLft+2oVymO6p0TZdx1eOPmSJYkO9F2JT
	 zmI0Erhr2E64RQB1csKPTgVjDa/KyOv+J0VGrBtFIKDFKH1xJzJT64K4LGy/wyD1ZP
	 x3FCIKBxBZvsbz+P9epk1xNhXTvYmJLwEG/F57OmQQGih6lkugvdReSnmo9slscfeB
	 Sj9Qa/GzM1NdzycXuOOjh7bMn4jOyTLrWezyUsLAlB/AWxnpaAIZdka1IAmvfhkS5F
	 je2bu6Qjpz0kw==
Message-ID: <cdeb6742-5bbb-4b06-8f6d-f53eb1e3cac5@zytor.com>
Date: Sat, 22 Jun 2024 10:16:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] x86/cpufeatures: Add {required,disabled} feature
 configs
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org
References: <20240616085743.1100704-1-xin@zytor.com>
 <20240616085743.1100704-2-xin@zytor.com>
 <20240621173245.GKZnW5PVnf4ota5pL4@fat_crate.local>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240621173245.GKZnW5PVnf4ota5pL4@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/2024 10:32 AM, Borislav Petkov wrote:
> On Sun, Jun 16, 2024 at 01:57:41AM -0700, Xin Li (Intel) wrote:
>> diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
>> new file mode 100644
>> index 000000000000..5ed24e45df87
>> --- /dev/null
>> +++ b/arch/x86/Kconfig.cpufeatures
>> @@ -0,0 +1,197 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# x86 feature bits (see arch/x86/include/asm/cpufeatures.h) that are
>> +# either REQUIRED to be enabled, or DISABLED (always ignored) for this
>> +# particular compile-time configuration.  The tests for these features
>> +# are turned into compile-time constants via the generated
>> +# <asm/featuremasks.h>.
>> +#
>> +# The naming of these variables *must* match asm/cpufeatures.h, e.g.,
>> +#     X86_FEATURE_ALWAYS <==> X86_REQUIRED_FEATURE_ALWAYS
>> +#     X86_FEATURE_FRED   <==> X86_DISABLED_FEATURE_FRED
>> +#
>> +# And these REQUIRED and DISABLED config options are manipulated in an
>> +# AWK script as the following example:
>> +#
>> +#                          +----------------------+
>> +#                          |    X86_FRED = y ?    |
>> +#                          +----------------------+
>> +#                              /             \
>> +#                           Y /               \ N
>> +#  +-------------------------------------+   +-------------------------------+
>> +#  | X86_DISABLED_FEATURE_FRED undefined |   | X86_DISABLED_FEATURE_FRED = y |
>> +#  +-------------------------------------+   +-------------------------------+
>> +#                                                        |
>> +#                                                        |
>> +#     +-------------------------------------------+      |
>> +#     | X86_FEATURE_FRED: feature word 12, bit 17 | ---->|
>> +#     +-------------------------------------------+      |
>> +#                                                        |
>> +#                                                        |
>> +#                                     +-------------------------------+
>> +#                                     | set bit 17 of DISABLED_MASK12 |
>> +#                                     +-------------------------------+
>> +#
> 
> Look ma, a picture. :-)
> 
> But yeah, this is better.
> 

We are better in intercepting pictures :)

Thanks!
     Xin
