Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24111AB6D8
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149091; cv=none; b=Ud11MMcsydUSukaAbDgKhtOLkVrD7SE/S3Bk0EtDGRD1Xrgf9h369ATal+w/tfBTIwaWGzUfXvxaJEoNzqEBMDqjlx/1+0okUexQYSnePa9RNQ5y8ZhAirThI+WQDq//ZL9Ehtnc9NI4DaP3wYs7+uIoO5pNbnQxbCFyeIUxxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149091; c=relaxed/simple;
	bh=gya3ROjPc6Xcv9OxmCa/y0ywXdCeEgTScRlfInQVYQw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XOK2kdTvaRaIy9eVSVK6Cn3B8YMj2uC9s6+Em8hJrEioSn2T6TiFPiWawbzRWxmU07LCy4zENp4F2j67E6xceXUbLlpJFetqXcLr80JQnhZ6W2Az+45JrUI9mYx91HWbhk8AKpaCLfSPBywqxAh1Y4yCdOj3KfCAMCLKswxCrgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WbkIt/Bo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbkIt/Bo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso45668395e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 03:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738149088; x=1738753888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qDBbwVh3J9uSm9rgekPSCuO+iinsLFNzIr1VWB6driQ=;
        b=WbkIt/BoEHjTpXW3OUNQxs5My8rt3Wkp0U+UR5qyDArYB/vVBAkWiVOAxTevgqTykO
         t1IxcQoQS0jJIdNoRBbHuhUE08cRFGCVDMsMv87olZAwIMsm/57Y1L3/aRU7bJGUMxRy
         61i25CWDqxrgERJ40My7JKd6rXFMLNHgVLIY2nf1YVGuclaHZCzIXWVaRBrNox8X7PYP
         PB7VUExOpUsDWn1rRn0W4SsuVWOWlo6L8x/xIqVktAOdrb2Y8CR+yoY9GnHYeY93RHy7
         6yQTWKHRJuTNdMEFtiZnVsjnGbH+m/ktyIBTvE07QzwoELWN6rt4iXD+SWg9e8evuI5/
         hsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738149088; x=1738753888;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDBbwVh3J9uSm9rgekPSCuO+iinsLFNzIr1VWB6driQ=;
        b=ZgceVacYHZKzDSrHrdgR09M1A/uvW/Kcw8Si8AIcQgLvAfwRiHWTFe2VEq1d9cnlSY
         coR2abLiJXWz8+7AUBhyS2yy5ajXRKD7mbGTeU4+jGg1U5bYmsfFNLRGVkuQL8l2vPND
         8kKXqQQBd6AzKvluUBq7RplZItDgXGajGsiQ7vN1n7aoiyT8AEVnqtNZvK5LzgTyuj2W
         QDeH6NZAnlzdwQ25TxwWcBPl1YaVDzlR9jzqZQJTrGezVY5JVkmt9Ks6KHh1jwpfs32S
         KLze2eFFCfaAmzg1Dcqpb1vsgmf0FGRy/TJy47YB1C2TZYuf/DXxOgltSSF7/JP6puiH
         i3DA==
X-Forwarded-Encrypted: i=1; AJvYcCXRjCViUqiOLP77I/Jtfbm7ZmXOVknCLjb/4q22k4E2v5OVRKkv95vXWUIrf85fsMIktgXBNmroPEkGANPhmY1v@vger.kernel.org
X-Gm-Message-State: AOJu0YznFChUw5YTStBQtSY+dNzka1A4IeZ1mLtyU2XB3uchvbEGNdnr
	kGhE7yshtQ4EEVGeAEA++fTOZRI6+0AKypDWwesEkM1DTri6vRKXVB53J5q6nK0=
X-Gm-Gg: ASbGnctilk/GNT5hK+ObpHLJ2Cjuc0OcSmaZfNwIPwF8MpxFHT8hvspujplM/pYiRwI
	0QZs9TCVtfaR3Voa0oBZpcMTqoDMlm8u80NoEZFxo/uNz1HC+2Hroep4A7gGNt8R+M0A9vK6hvd
	N1bldf5M3blvTt7kR2oFsB/OBVPWb9tYuoauC+W0asOt1KTS1RjqBkm1qEHVqFLVL4B0jTtd6/A
	c6YvjvQCbnXkbZS8CSx2pGztFMosEl2dKWsJcrkSPVm9+mz0zy9f/fOjV5HBJ1/ympXBGJZ4RQO
	zaIucOrNzgEDWnlvSQKBkNEduQ==
X-Google-Smtp-Source: AGHT+IG5+JkKOc+EXDV/Cw7kZ6DmBAfY+BlQJGrRo97tUXfJxB0XIVUewg0H3IiXe4E/hgTqL/ZbHw==
X-Received: by 2002:a05:600c:1f15:b0:434:f335:83b with SMTP id 5b1f17b1804b1-438dc3a84aamr23697505e9.5.1738149087917;
        Wed, 29 Jan 2025 03:11:27 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2a8e9sm18713315e9.18.2025.01.29.03.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 03:11:27 -0800 (PST)
Message-ID: <a39b5e6c-4096-4d0f-8c1a-8fcc5678c012@linaro.org>
Date: Wed, 29 Jan 2025 11:11:26 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] perf test: Fix perf test 114 perf record test
 subtest precise_max for s390
From: James Clark <james.clark@linaro.org>
To: Thomas Richter <tmricht@linux.ibm.com>, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org
References: <20250129071134.4024430-1-tmricht@linux.ibm.com>
 <30865b2c-c58d-4974-9a88-dc13b8ad1195@linaro.org>
Content-Language: en-US
In-Reply-To: <30865b2c-c58d-4974-9a88-dc13b8ad1195@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29/01/2025 9:57 am, James Clark wrote:
> 
> Is this a v2 of "[PATCH] perf test: Fix perf test 114 perf record test 
> for s390"? Or maybe the v2 is a typo?
> 

Nevermind, the CC list is different on the two patches that's why I got 
confused.

> On 29/01/2025 7:11 am, Thomas Richter wrote:
>> On s390 the event instructions can not be used for recording.
>> This event is only supported by perf stat.
>>
>> Change the event instruction to cycles for subtest test_precise_max
>> as suggested by James Clark.
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Suggested-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/tests/shell/record.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/ 
>> shell/record.sh
>> index 0fc7a909ae9b..957ee10aff44 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -287,9 +287,9 @@ test_precise_max() {
>>       return
>>     fi
>>     # On AMD, cycles and instructions events are treated differently
>> -  if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/ 
>> null
>> +  if ! perf record -o "${perfdata}" -e "cycles:P" true 2> /dev/null
> 
> I'm not sure if this is the right fix. Doesn't this make the test test 
> cycles:P twice now?
> 
> I think the fix is to first test if cycles can be sampled, then test 
> cycles:P. Then test if instructions can be sampled, then test 
> instructions:P.
> 
> At the moment it checks the events with perf stat, and it checks them 
> both at the same time. Obviously that doesn't work if an event works for 
> perf stat but not perf record. And checking them both at the same time 
> doesn't allow for one existing and not the other.
> 
>>     then
>> -    echo "precise_max attribute [Failed instructions:P event]"
>> +    echo "precise_max attribute [Failed cycles:P event]"
>>       err=1
>>       return
>>     fi
> 

