Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9EFC08;
	Mon, 24 Jun 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250987; cv=none; b=PNCVucMfwbpn2OF9sCsjHLLiSKnXBkPuzkH0Fg/RgMkrmwdIDGUlqhjfqDeietDu6Bnw+qujHIV2r85OmiQ6M/pMiIWcBGjKAb9YhpOD0Z6JaiLEO10NksWDFaG2atd+F0vQ4Rk01iyjB0ydGncvvuRSTedhEIomPnx2x+xzux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250987; c=relaxed/simple;
	bh=E/gu9u7ZLLQazfZ4SQnaSwWJ5mcVXtD47iTbEJDJdyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+zsjUpFRmZlBd23R195a32KlfVJGRxRXGtDsdY/Kk6muZbyqhAepIBDJiyiNptXzXzeprrADti81a/Fe7iHTBWfPnZxYh4UplG2CRxgYEjkR5t6SqVLCe6bsAvMCX8Ap7YaB+ebDXi22jNKS8PAzyDV+F5ta8XOtepK0wVYTMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Y9Rgcd4O; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y9Rgcd4O"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45OHgSUq326194
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 24 Jun 2024 10:42:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45OHgSUq326194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719250950;
	bh=p2kWuofh7HFs++zpd3+v7XzawjOGkCd/5NnKdZqeuM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y9Rgcd4Od3FdqAlA8IISallEi2NL4/4QJv8djaC/sCPbHvXMgOtUFf7jcp7FC1elS
	 WKejtp/MZdRLZ5Nul8Rmii1fZ5i6EaoxnAk1MA/nr9fbfqKawS8a22HmXhqf6KqlUI
	 lVENAHpsZQCizlTVXLIUCjx/TIrMdWTSX97uegrWubYLog3oCd1B4UX7Sx0k4Gte3t
	 6BgUL0WrwR4JHQPW3ETV+dRAJP35DkpMaoxTORtr8LWPqYw5h+oEO24wtDR6Xvct3t
	 2zRREElxESbM4tjis4191mCsonim4ypl09p+9wT2/YrEOazLDNZGCbPiPAt/RhXkbj
	 E2gj57fob44lA==
Message-ID: <590a828f-8008-45d8-ae10-c9099108da0b@zytor.com>
Date: Mon, 24 Jun 2024 10:42:27 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] x86/cpufeatures: Use AWK to generate
 {REQUIRED|DISABLED}_MASK_BIT_SET
To: Andrew Cooper <andrew.cooper3@citrix.com>, Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org
References: <20240622171435.3725548-1-xin@zytor.com>
 <20240622171435.3725548-5-xin@zytor.com>
 <CAMzpN2hMP8c9PXy=0YV4Ln+u_1n1spJP2jaYXKzEABWLh0+hkQ@mail.gmail.com>
 <bd08fb59-600a-4dc6-8157-2c432f209df4@zytor.com>
 <d0083546-f945-45e4-a0c3-96794ef76caa@citrix.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <d0083546-f945-45e4-a0c3-96794ef76caa@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/24/2024 3:24 AM, Andrew Cooper wrote:
> On 24/06/2024 8:29 am, Xin Li wrote:
>> On 6/23/2024 1:28 PM, Brian Gerst wrote:
>>> On Sat, Jun 22, 2024 at 1:14 PM Xin Li (Intel) <xin@zytor.com> wrote:
>>>> -               printf "#define %s_MASK_CHECK
>>>> BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
>>>> +               printf "\n#define %s_FEATURE(x)\t\t\t\t\\\n", s;
>>>> +               printf "\t((\t\t\t\t\t";
>>>> +               for (i = 0; i < ncapints; i++) {
>>>> +                       if (masks[i])
>>>> +                               printf "\t\\\n\t\t((x) >> 5) == %2d
>>>> ? %s_MASK%d :", i, s, i;
>>>> +               }
>>>> +               printf " 0\t\\\n";
>>>> +               printf "\t) & (1 << ((x) & 31)))\n";
>>>
>>> The original macro had 1UL here.  I don't know if it is strictly
>>> necessary in this case since we're using 32-bit masks, but it would
>>> probably be safer.
>>
>> I did notice it, but don't think UL is needed.
> 
> You do need 1U, or you'll trip UBSAN every time you test feature 31 in a
> word.

This is so obvious, how come I totally missed it!

> I'll note that the hypervisor bit is one such example.

What's more, generally bit 31 is nothing special, I find:
#define X86_FEATURE_PBE		( 0*32+31) /* Pending Break Enable */
#define X86_FEATURE_3DNOW	( 1*32+31) /* 3DNow */
#define X86_FEATURE_TSC_KNOWN_FREQ	( 3*32+31) /* TSC has known frequency */
...

Definitely I must append "U".

Thanks!
     Xin





