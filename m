Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B063346B6
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637021; cv=none; b=BICIEIiTfUn34RIqJuoErbe+Pmf9TXTRKN6Zcc1vP9jDayHa5j/EUqwjcW64Fd5cDMtYD+4AxwmkP+73houBPjr3GD392OO1Pf6GYsqULTxz8PuueUICpOrCqzUmhy0m7Yz3csbQulA+RNVgYfA2g86KQ989P/2lTijYsZbHFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637021; c=relaxed/simple;
	bh=Uwecva4dbuiF9S0m5wshcYD9Oa8avTRdAbqv4Ynlbs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atWShmwZf05QY4AkKs2H/+8t3QmXG9OTBdmHma5Gp1Jc9WHHpO+fCC84UiHfMKPFU2ZLwCFVM4DhmpbWjQ8x3ul5iYiFiEYCmlASkGwW3/1uf6ae5+7dqVBy+xpOjMQJxx4B0IiMQwuEeli4fVPvgL4O4zRVJ4VrNQmbCCuRzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ee8KSWX5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ee8KSWX5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so9828565e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760637018; x=1761241818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmtrNPsG0xLQVLEkpyMXhfs+pjUSEP8NlJW0XJwqMwk=;
        b=ee8KSWX5o7NmQOfBU//+6PNOsbRpdsts8ztbX62VHhI7+jMBVe/SP2gAA6dfoDoFPm
         boSQXpSqOTJk9Z9hqIP9RdME7mMoBd/e5Rms5cCLa865nG8Fd3PymeOAJsYSakQpuaAy
         5nljoIJI8Z6BFgbuzwuni7icYtp8enDY6bGqwcsaqpP/LkC+NmAHIlmejLXggbr3yZtg
         VKEl3bw7dz2cESqU1R9aU/h7e+zobld45eAJkLyQzk6euJh2NvAX9TIu6H3S/3y6SbbY
         2FQ3y64rBniv3umd4nEV3M+tj2iZntHYl82YjXOD8PHdmfNH57sjPl7CPstB3CZSGT1O
         OUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637018; x=1761241818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmtrNPsG0xLQVLEkpyMXhfs+pjUSEP8NlJW0XJwqMwk=;
        b=w5hZJ5ITRnuF3tNRXYla0juWT86Fl5qb1EslNfhP7+HB3NGkWm4JiDLzw4GIGN/3ef
         HbY6nmqRdyyBPTtWfjPxkl23H0O4nD7yPicjaM35OIF6OsDYnc9Zi5/aj6aJdk8lll52
         +JszVHqPk6zUijCP7hpQmRt6FeK/x140WVuVenE7Av3vDiP6mF8fjogORhGww8Ce7hlO
         6A1q0XHxPCTOFC0rZZWz8eV5I4pnndfAPLLruqC0e6tghkq2gbW/mj19yUSGzPDyagm/
         QmZDi2Tk5nhUP3GDBeHUclNxNwXK13IzP/4nERMTxRBR9B86xXpjS7y5MdmsrhL0dmZJ
         mkpw==
X-Forwarded-Encrypted: i=1; AJvYcCUOOBhlOim6IMIut8oZwmRPYhkul2z6dBtXNODpCRUccBJ85pWn00iYpkyDVCRz8vBOHRDxoy4qoYgc+cUfHkiL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0P4bKRwP1BlbreJuIzAB2W3CZQKZf3EWj0uHrYv3HwxIs2SHq
	dMD6FDQc6G36Vl9tyqNPP2xjSfjIzj7hJwHy1QQ2AoNdRS8vjl9Ggn0o4MnVE1bDk4Q=
X-Gm-Gg: ASbGnctuUXC9DlXY+BcP3yT01Iv0pLtBYl5EkiZ8HWpHKf3LoKo3C2QhSpsLZXj07OU
	OljOBwv2rrE29DAQhqaYh4Y5LtB8lXLe1tM2SeWKSCf0eMuwUMK6ELhbotm3mPvWm+HnFigLeoP
	w7WWqHyjkx8I/McPVkct78d0Mj+6d0A9vy4gG+slvBjDbRMktW1R5Man9on/bNIzn39HeqsOh13
	G3vRKgAwEjfhkhUotRFOmNUaMlaegDe5PXDVJc9iJoGgO+rHF+9L72rEasaE/faZPYCFqMelR6Y
	BUabh2cO5NFhtdcCCmB4KfxVejLqx0Z68eQuSX23BJF8BzIi0Yj5NwV58taNtI/TYDMgviZJgjg
	bukkTmHf843MeH5rpQqqJTPFBWCXcMV8m7Yp3FMgzU67P0c0v6sLgcgxhtjqRzFpqC8E96jEu1E
	HL5m+rt6liOn7QqFL1
X-Google-Smtp-Source: AGHT+IHKthcGXs3C1tZqF5NlhckDQgMEr3FVHkAQk73l048mHOUAoRlCuk7a0BZxEc4BC81U90bstg==
X-Received: by 2002:a05:600c:3513:b0:46f:b42e:e38c with SMTP id 5b1f17b1804b1-47117925e9fmr6135845e9.39.1760637018153;
        Thu, 16 Oct 2025 10:50:18 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ff84cbb7sm4604532f8f.23.2025.10.16.10.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 10:50:16 -0700 (PDT)
Message-ID: <dcd20146-bb88-442a-9bd6-e35fe816dcd1@linaro.org>
Date: Thu, 16 Oct 2025 18:50:15 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Anubhav Shelat <ashelat@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Thomas Richter <tmricht@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
 mpetlan@redhat.com, irogers@google.com, linux-perf-users@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com
References: <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
 <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com>
 <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
 <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
 <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
 <f4eba834-e45c-4eba-9650-5b6720fcd30f@linaro.org>
 <CA+G8DhKQkTKoNer5GfZedPUj4xMizWVJUWFocP2eQ_cmPJtBOQ@mail.gmail.com>
 <58801744-44e4-4182-ab4e-bfcf8e2bfc69@linaro.org> <aO0ci1wX-J3au0-p@x1>
 <9e4d4f05-0c34-46b0-aad9-1431bf8cf9f4@linaro.org>
 <CA+G8DhJnRB=d+pv0k=uzM18EmhFiQ+AiVu3rb8w=anNgJ=dr2g@mail.gmail.com>
 <abc1cb61-8169-4a26-9daf-264a6d94cc84@linaro.org>
 <CA+G8DhKDeg61ZM+Pzurnbvvs0L=mdxYhZZTMqfri1wf3AnFaeQ@mail.gmail.com>
 <d207997c-bd73-4dd0-ba0f-93b994b14196@linaro.org>
 <CA+G8DhKUsbL1q_Av0MzKmJ2XdSpOJiAamrcqYjRekjMbcGtwDg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+G8DhKUsbL1q_Av0MzKmJ2XdSpOJiAamrcqYjRekjMbcGtwDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/10/2025 4:50 pm, Anubhav Shelat wrote:
> Yes. I had built perf manually from linux/tools/perf v6.17 so the
> patch was definitely included.

But the patch is for the kernel, not for Perf. So building Perf isn't 
enough, you need to run the test on a 6.16+ kernel too.

> 
> On Thu, Oct 16, 2025 at 4:03 PM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 16/10/2025 3:59 pm, Anubhav Shelat wrote:
>>> On Thu, Oct 16, 2025 at 3:46 PM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> But the throttling fix was in 6.16, so I wouldn't expect it to work in 6.12.
>>>
>>> This is using perf built from the upstream source so the patch is included.
>>>
>>
>> The throttling fix that was linked previously in the thread [1] was in
>> the kernel though. Unless you are talking about a different patch than
>> that one? And that patch is in Perf?
>>
>> [1]:
>> https://lore.kernel.org/lkml/20250520181644.2673067-2-kan.liang@linux.intel.com/
>>
> 

