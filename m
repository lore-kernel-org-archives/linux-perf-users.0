Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F051CABD;
	Wed, 12 Jun 2024 02:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718160963; cv=none; b=HzR+0T1nZySV3EnK0nDY6VYSChWfsEWaY/pRopeYWI4VK0/FSTG/CLBs6XWYHKcqZxzLDuUV1XXpTrRPBOJYZMKxa6IgXULK+NgXsddBwG7WXxQONVQPwu9KUmmpuYRTLl2urT4O7MPtJK1Wrb9/J9Q82C2x09+IaQcjcVXJahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718160963; c=relaxed/simple;
	bh=Pypyq75ZCtmTZMnYwPw+81sinC2N+SOxDTQi3DsFga4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXiBlkNyL24q6x+4J8vTzdgxSbz6i2dCSLCG0ie+HOV5QG8xN2t1UAGBrjQf2gu6SmlKlTfi8i9e+tc7qd3qry4CeN3JgNcXkoTKZr5h22tXYp8SNI713+cXTsoqvjMdR3PxNclf2aGu+U7wzJs0+5nIq6/1o6GC18v+4Vf6N7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=AyZOx08C; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AyZOx08C"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45C2tURR3581319
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Jun 2024 19:55:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45C2tURR3581319
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718160932;
	bh=omP5I4jCHHygGqfmsnQTzeRs9EExzMgObol55T/+PXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AyZOx08C8GxGkYauH7CnWui6WCfuIsLKpyNOVqbrC94kv0u0Gz9uJMM5n0JG9Kp02
	 CICrf8IlCkm6A/D7MLZ+8f1k1l2SctJB8mOs8HRUpGsxzuydRtvfp6tCdwz/jE+8v3
	 uqmU6Vdk7ZBdh6nnJOBftOyepbYGBmD12Y2quVmcgdcHX8P72eAtOwef/33gQVDnvB
	 EPYLpGwJdMh3Ga5NQedRlm1trcijh/wSI/n43/gLFQPC3pzVk4VeIyL0pZlaLIxYUR
	 BT5gQIlK+0GIXh25SaVVM5T7uxp+eQtkAolMx1bkX8lSTHYAEizaU8gwOZWDBG8Lqj
	 5JowIAz3WPRSA==
Message-ID: <41287f0c-4c1c-472b-a6ef-5669c68aad76@zytor.com>
Date: Tue, 11 Jun 2024 19:55:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Sean Christopherson <seanjc@google.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
 <ZmkCFyOXDC5KfC-5@google.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <ZmkCFyOXDC5KfC-5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/2024 7:04 PM, Sean Christopherson wrote:
> On Tue, Jun 11, 2024, Jacob Pan wrote:
>> To tackle these challenges, Intel introduced NMI source reporting as a part
>> of the FRED specification (detailed in Chapter 9).
> 
> Chapter 9 of the linked spec is "VMX Interactions with FRED Transitions".  I
> spent a minute or so poking around the spec and didn't find anything that describes
> how "NMI source reporting" works.

I did the same thing when I saw NMI source was added to the spec :)

> 
>> 1.	Performance monitoring.
>> 2.	Inter-Processor Interrupts (IPIs) for functions like CPU backtrace,
>> 	machine check, Kernel GNU Debugger (KGDB), reboot, panic stop, and
>> 	self-test.
>>
>> Other NMI sources will continue to be handled as previously when the NMI
>> source is not utilized or remains unidentified.
>>
>> Next steps:
>> 1. KVM support
> 
> I can't tell for sure since I can't find the relevant spec info, but doesn't KVM
> support need to land before this gets enabled?  Otherwise the source would get
> lost if the NMI arrived while the CPU was in non-root mode, no?  E.g. I don't
> see any changes to fred_entry_from_kvm() in this series.

You're absolutely right!

There is a patch in NMI source KVM patches for this, but as you
mentioned it has to be in this NMI source native patches instead.

Thanks!
     Xin
