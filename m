Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD6A179AB;
	Sat, 22 Jun 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719077720; cv=none; b=M+fg9Fkjm0lrS6PFvf6VLU9hnurDGWEm4JNlzwkgM4zK66LsL+9muVbz8xq/osSUnEmIOvb3kFWLdW/mArgeW8V+7ivkk8WEgrBPdNWLJBfRHrRn/q39fkgcotHiOirBZe5Mhom6yqxUCVGsHqHtVXsY2LkrDUG2eCm4NIOy2NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719077720; c=relaxed/simple;
	bh=sPHz6h3ONEZA1wUzi09j0Pxmu7pkzK0jwBvpM3zlYiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGXqyCAW9VxIdeKVVeIW03ibQUcbXQGpyvxNkT4JzpUhjTvCHZqnFFzvetzVLIwtGPwd53mFB5W6LflEhbaGh+6z1Byam3DECsKbsp4jdooamWMX7YBh/jz7KCDuhz0Fg+3IZfUlnGyyrxO6J9R9ZYZlnKFwSDoVaBnGyAcl1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PAvE3mIi; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PAvE3mIi"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45MHYoEZ3730912
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 22 Jun 2024 10:34:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45MHYoEZ3730912
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719077691;
	bh=VU7cbOAcW7s0UMUSdQaeZqdsO6AZuRqP2b3P0uFLK18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PAvE3mIiyW+8hgXGohzkIZx1QKtXmwcoK/M3BcUHTEVVijYM6f8uJ5wEQa6TlaxqP
	 egRhMM7QeJ7SXHhf/mvznJf1yentMOr5dKcAA6Wodel/6F5z2E7IqGlcSVELVQGK3/
	 Jia2vwPD5mUDk4SVcLC2P7ay3VfZQ0ZwDZKO3WFT7MUr7k4R3mF5NKzdX72/n2d9fq
	 K1kaHv4unL+rePLDr+lWknZ4/EA5TUb9Qd2HOEAKWRm/tmY2mjOGFqoYHC1uTKiPdg
	 sQZDSo4b8ckUL+REUW12CTxSEtH6w+yBClH+U+Ygc1dyL3HSqHHZCCtuox0VY3xOkv
	 kh+FljZaRVdog==
Message-ID: <78436d01-2e91-44ad-ac99-145ddbd5e857@zytor.com>
Date: Sat, 22 Jun 2024 10:34:49 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v1 2/3] x86/cpufeatures: Generate a feature mask header
 based on build config
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
        namhyung@kernel.org
References: <20240509205340.275568-1-xin@zytor.com>
 <20240509205340.275568-3-xin@zytor.com>
 <99208d95-d3de-44d0-8b08-f508759aabca@zytor.com>
 <8F9E89A4-B05B-493C-8BED-52AC6777D915@zytor.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <8F9E89A4-B05B-493C-8BED-52AC6777D915@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/2024 6:46 AM, H. Peter Anvin wrote:
> On June 16, 2024 12:26:48 AM PDT, Xin Li <xin@zytor.com> wrote:
>> On 5/9/2024 1:53 PM, Xin Li (Intel) wrote:
>>> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>>>
>>> Introduce an AWK script to auto-generate a header with required and
>>> disabled feature masks based on <asm/cpufeatures.h> and current build
>>> config. Thus for any CPU feature with a build config, e.g., X86_FRED,
>>> simply add
>>
>> ...
>>
>>> +
>>> +		printf "\n#define %s_MASKS ", s;
>>> +		pfx = "{";
>>> +		for (i = 0; i < ncapints; i++) {
>>> +			printf "%s \\\n\t%s_MASK_%d", pfx, s, i;
>>> +			pfx = ",";
>>> +		}
>>> +		printf " \\\n}\n\n";
>>> +
>>> +		printf "#define %s_FEATURE(x) \\\n", s;
>>> +		printf "\t((( ";
>>> +		for (i = 0; i < ncapints; i++) {
>>> +			if (masks[i]) {
>>> +				printf "\\\n\t\t((x) >> 5) == %2d ? %s_MASK%-3d : ", i, s, i;
>>> +			}
>>> +		}
>>> +		printf "0 \\\n";
>>> +		printf "\t) >> ((x) & 31)) & 1)\n\n";
>>
>> This code generates macros {REQUIRED,DISABLED}_FEATURE(x) to tell if a
>> CPU feature, e.g., X86_FEATURE_FRED, is a required or disabled feature
>> for this particular compile-time configuration.
>>
>> But they are NOT currently used, so I prefer to remove them for now.
>>
>> Thanks!
>>     Xin
> 
> The goal with these is that it can eliminate the handwritten code that tests a long list of masks. Again, automation.
> 

This piece of code is added back in the last patch of v3:

https://lore.kernel.org/lkml/20240622171435.3725548-5-xin@zytor.com/

The generated macros {REQUIRED|DISABLED}_MASK_BIT_SET are way shorter
than that in the original form:

#define REQUIRED_FEATURE(x)                             \
         ((                                              \
                 ((x) >> 5) ==  0 ? REQUIRED_MASK0 :     \
                 ((x) >> 5) ==  1 ? REQUIRED_MASK1 :     \
                 ((x) >> 5) ==  3 ? REQUIRED_MASK3 : 0   \
         ) & (1 << ((x) & 31)))

#define REQUIRED_MASK_BIT_SET(x)                        \
         (REQUIRED_FEATURE(x) || BUILD_BUG_ON_ZERO(NCAPINTS != 22))

Thanks!
     Xin



