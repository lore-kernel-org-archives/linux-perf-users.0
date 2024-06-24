Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD879DE;
	Mon, 24 Jun 2024 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214230; cv=none; b=aA4g4tbP82wAH9Ao2vrRDFW45bOsROXyaRLjDH7Lsze1ZgzVl09VxOtKvG3MPF2KMQVoVbAq/QZmqMWeEGcmhak/yG7jFUQHJLanFuJqlkleV7Mjd64PlFvMnEXTXfo+Pcl0gmfOeS6SpYLotXA//KnUBgAR9Ph8CAb5baCX3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214230; c=relaxed/simple;
	bh=ynRYMtPADK8VRITpBQRnva/MiSkd15kmJ7lBis0ul9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Udfh2JnaQdveaCqHU3ydQrwaMO0vF5Ca4AmGGfGcio7dIciZPDiDVaBXdkmeUU4nXw8phciIxOH167VEWdjvX2JgQgK9OABYYA2+6+ZAAhjL6RqUryQg+avkkEueB8DWi2IGQbSLYlcyR7YUCaK9VmsbUOpLz0lH6nx0/RWPcmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=EwfG/jU7; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EwfG/jU7"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45O7TSkL121621
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 24 Jun 2024 00:29:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45O7TSkL121621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719214170;
	bh=iAwJb7cjBRqYyohDh+qEg0sdRnD3nc0LDZ5X2diH884=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EwfG/jU7GHMqFBbhZZN5ggtklFnP4eFih/fKVFwkW2VeVBrWSDnqmfssaH8H9g7R7
	 +Z84qCDMQT9FpH4ClM53y/yQr/bxVBLFhhV1LT8MiJXJCn0teDmZOKFBgTROROR3d6
	 XzvUZqeFsVza9qO1HsiKEznDan+J+aBwNiiC2LJLjD3sM8/HxoO0KGsdwQoev9ExL6
	 RJHJjS6wMKPqbgQDMOl+XXDVETfFV9u97XSIDeOgOWsB6a6OzqFCyMqyLctHYlURDn
	 Cx96eVAUsb5FPGo0ReseGpMDR1rYpkSdmPRg29QKNnIm17wiDRYduuXBQZqdXUeaev
	 IbuYXiVowDcVw==
Message-ID: <bd08fb59-600a-4dc6-8157-2c432f209df4@zytor.com>
Date: Mon, 24 Jun 2024 00:29:27 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] x86/cpufeatures: Use AWK to generate
 {REQUIRED|DISABLED}_MASK_BIT_SET
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org
References: <20240622171435.3725548-1-xin@zytor.com>
 <20240622171435.3725548-5-xin@zytor.com>
 <CAMzpN2hMP8c9PXy=0YV4Ln+u_1n1spJP2jaYXKzEABWLh0+hkQ@mail.gmail.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <CAMzpN2hMP8c9PXy=0YV4Ln+u_1n1spJP2jaYXKzEABWLh0+hkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/2024 1:28 PM, Brian Gerst wrote:
> On Sat, Jun 22, 2024 at 1:14 PM Xin Li (Intel) <xin@zytor.com> wrote:
>>
>> Generate macros {REQUIRED|DISABLED}_MASK_BIT_SET in the newly added AWK
>> script that generates the required and disabled feature mask header.
>>
>> Suggested-by: Brian Gerst <brgerst@gmail.com>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> ---
>>   arch/x86/include/asm/cpufeature.h | 69 -------------------------------
>>   arch/x86/tools/featuremasks.awk   | 12 +++++-
>>   2 files changed, 11 insertions(+), 70 deletions(-)
>>

>> -               printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
>> +               printf "\n#define %s_FEATURE(x)\t\t\t\t\\\n", s;
>> +               printf "\t((\t\t\t\t\t";
>> +               for (i = 0; i < ncapints; i++) {
>> +                       if (masks[i])
>> +                               printf "\t\\\n\t\t((x) >> 5) == %2d ? %s_MASK%d :", i, s, i;
>> +               }
>> +               printf " 0\t\\\n";
>> +               printf "\t) & (1 << ((x) & 31)))\n";
> 
> The original macro had 1UL here.  I don't know if it is strictly
> necessary in this case since we're using 32-bit masks, but it would
> probably be safer.

I did notice it, but don't think UL is needed.

>> +
>> +               printf "\n#define %s_MASK_BIT_SET(x)\t\t\t\\\n", s;
>> +               printf "\t(%s_FEATURE(x) || BUILD_BUG_ON_ZERO(NCAPINTS != %d))\n\n", s, ncapints;
> 
> Checking NCAPINTS isn't necessary anymore.  It was needed when these
> macros had to be manually updated, but now if cpufeatures.h changes
> this header will be regenerated.

Right, it's no longer needed.  Let me update this patch.

Thanks!
     Xin
