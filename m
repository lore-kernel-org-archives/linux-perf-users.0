Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE6126F1D;
	Thu, 13 Jun 2024 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247464; cv=none; b=lklrBU9lAx6okyrqawuBdJmYLoo1gMLC3WiGtEK/QjPnk7D9H5fqtLfk0frVEKtmWco/xpZHRCQnPv0/fLR7QAz4cZGCGEK8Kn6PL17Ek3/UcOmnsqeCJV9DQiWd9uRGvCBf+zsf64+zmwROxwTZGxRKJr32iRy2SgTtxiCRCWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247464; c=relaxed/simple;
	bh=TLL7Vi4AXjbV0h+Rp+oTDPJbtBaUErrOe9Swh52bSwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+R4jv2xqZjKxZbpVjqpS0aM0CpjU5EBuvQRTY/rSgvgsoH05pM0VH/1SfwNMR7CwSkBSl1mOV0t6wKpq5t2Pe06A8ksq4RXziE6I1wab94qtIrV9AEW6rUbiIhkCkvroANG3jY7EI0Nqhm0alJ/2HYvV135c5XuL4i7XkmglAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BXBg2aSC; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BXBg2aSC"
Received: from [0.0.0.0] ([134.134.137.76])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45D2uYQl3987160
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Jun 2024 19:56:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45D2uYQl3987160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718247397;
	bh=vQd3vUyfsayygHgkM5vM2MNlvWp19CaBHld+FXf7POM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BXBg2aSCEhzk2RvuSnVO0dJBYl4slJiiWnlYi4TuGGDOoze45N+zfoscff9daak2V
	 DfThAqiqZwkTySyJ4/LN9SQYQVXgL7MkIYPzNUllsL629ysmcVZBvZfiX7bYQUanp2
	 Ku9nxoPOLH8u5Zpp9zej6hpAQNKsZASwXvOMNVOdr7GzUJuFYZDPan14Ad/YF2DgeQ
	 vadXv3MSroQfyBFL2QHM3nQ3QZBeLNYY4TLJLTGQhvvrZtyILLD9vHNfcDp586q4zB
	 KObZ0/Xq4iiFpiN8Cwq26xUJu4LNTnlkddHfhPtC4Mpq9TYhzYORGujpPUmeAK8j50
	 5UIGU/oHdxDdQ==
Message-ID: <7bf64b12-ea59-470c-ac31-8226be4eb496@zytor.com>
Date: Wed, 12 Jun 2024 19:56:28 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v1 1/3] x86/cpufeatures: Add {required,disabled} feature
 configs
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org
References: <20240509205340.275568-1-xin@zytor.com>
 <20240509205340.275568-2-xin@zytor.com>
 <20240612133340.GBZmmjtD40dzhsWVyg@fat_crate.local>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240612133340.GBZmmjtD40dzhsWVyg@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/2024 6:33 AM, Borislav Petkov wrote:
> On Thu, May 09, 2024 at 01:53:38PM -0700, Xin Li (Intel) wrote:
>> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
>> index 2a7279d80460..719302d37053 100644
>> --- a/arch/x86/Kconfig.cpu
>> +++ b/arch/x86/Kconfig.cpu
>> @@ -358,6 +358,10 @@ config X86_P6_NOP
>>   	depends on X86_64
>>   	depends on (MCORE2 || MPENTIUM4 || MPSC)
>>   
>> +config X86_REQUIRED_FEATURE_NOPL
> 
> Can we keep the X86_{REQUIRED,DISABLED}_ prefixes solely in
> arch/x86/Kconfig.cpufeatures and not spill them out into the rest of the tree?

Good point, let me try.

> 
> This way there will be no confusion between X86_FEATURE_, X86_REQUIRED_FEATURE_,
> X86_DISABLED_FEATURE_ and so on, and which one I am supposed to use where...

Currently X86_DISABLED_FEATURE_ macros are defined only in:
arch/x86/Kconfig.cpufeatures. But X86_REQUIRED_FEATURE_ macros are not.


>> diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
>> new file mode 100644
>> index 000000000000..326a8410ff06
>> --- /dev/null
>> +++ b/arch/x86/Kconfig.cpufeatures
>> @@ -0,0 +1,153 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# x86 feature bits (see arch/x86/include/asm/cpufeatures.h) that are
>> +# either REQUIRED to be enabled, or DISABLED (always ignored) for this
>> +# particular compile-time configuration.  The tests for these features
>> +# are turned into compile-time constants via the generated
>> +# <asm/featuremasks.h>.
>> +#
>> +# The naming of these variables *must* match asm/cpufeatures.h.
> 
> I presume they must match X86_FEATURE_<name>?

Right, let me add this.

> 
> And REQUIRED and DISABLED is manipulated in by the script?
> 
> I guess I'll see later.

Yep!

Thanks!
     Xin

