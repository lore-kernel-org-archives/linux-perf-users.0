Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3D1C331B
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787002; cv=none; b=N8aqqS1umrriOTtw3wdJnbOaLrhgkM+pHRQ2wo63zOYLntiRpSpzGY+pAT7iBOjWOP8l88AQAKpQ+lFYa0Gxt3fiH3ALbnMVDygrhe/Yd73fLdSxI+x0BdSAP0vwHHb/ZgOoYvCB7wr44cR7jWG18Yy0luSNN1ZO6ENtX1jANU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787002; c=relaxed/simple;
	bh=dMWgDxinhyELd+my5lxRfhxyKCtnWT4+UUHhJErQs9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KohlzSq0vdt5BIf44WyGVC9snMK+MDVlHLiRLn3s3vaPW+EvEiPorzAvlYw6qXo9+JALBE9zZmUEQ4s+EQ+96HqpXXiov1SjY2iujko+NH71dX8Re2X00IVsgbAL0mO5OQe/98zJiyCWyay8Em89GVJI9GB8aKIicIfhPBLFj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LtmwPqCs; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtmwPqCs"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so911590966b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727786999; x=1728391799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLoYvgWCVL1X9kwUefO+SBEoQ3L03bwKiyOMzcp/QeM=;
        b=LtmwPqCs4KBME24qEo5zH5LqRz/vIKEbt/NCk5GGF8gpXiDJpQEd0WSgo919kCsG7h
         BZe3TY/RnofiaXxn7jqR0hw5mp8Au1uplgQ2f0bHt3me2khLxi3M5qI48+xFl6OBCBXy
         lw3fsPkX9sAeBZRhCp+gGUKekc2nKuDcmVAcm/RuyLMn+Ws3mi7SOGH1hNnWSa0iusXN
         JJS3kPNI1ASUU/AWD/mKyosC4VUFfDOqxJKgQQN2SIDBNrueVcaRniBBJr8B5WEgFplV
         M6hsvK1FtEhlErPwcIdIZomesDR18NUpIeaZmNdm8AySzXflJQK2s4UBYdMIjgxc6SgY
         kd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786999; x=1728391799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLoYvgWCVL1X9kwUefO+SBEoQ3L03bwKiyOMzcp/QeM=;
        b=kJC9l59teAdbDA/yyKR8cSD2/T2KdrKSjsJnLy4f4j5AKsX3iRZIktyCkRDEpVRTvq
         3P3AWxKxB12z/9MIQrDeOreApRNGzj9Ocp/sIN6vXE9m1AxayRZ7iszrbUOY5mQjytxu
         du5UM9iP4nVa1foAqskH1bdsYdzCGarKSzSx2ueCiVeqITSCdxR4J4QU5CaOqgzE5Z8u
         U3EeiQf6JdLqEJzSqPrUB6V+JZLzaFoFjCvQIeTejs2kS1YtkIbG3GBpF0cpUNn5d7TE
         7v8eMwletHAMhByK0apT4IH42JW4NNAO25fmoRanarxPzzFhBJMEtqLquUCqKZXMOwm6
         YR5g==
X-Forwarded-Encrypted: i=1; AJvYcCWC2HGN8/3C0dH960cR/s/1x+u5UaKM1+w5Xl4g06ol6Dd8jtc7nVXPt+z8G9PqM3QHMAwSapL0BZOLbMUpGSod@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkguXMiEsm8r9CZlMz9iQoAgK5sBcMXYSocZPI97r1zJsUooK
	cdnsaV/7EFE22xA1bnA9TkEsPIZ/CE2HCeWPtGICacTGAE/BIwwseLTkDKfgUyQ=
X-Google-Smtp-Source: AGHT+IHl2oBqaAwBRV4qjD7Nc+oA3RpJI+cBeVu715RW9PQz4RtQVLl03U98vCDU5j6Md/SPQfafeg==
X-Received: by 2002:a17:907:74d:b0:a90:1904:9a87 with SMTP id a640c23a62f3a-a93c4ac93b6mr1534746266b.60.1727786999018;
        Tue, 01 Oct 2024 05:49:59 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297a357sm709920066b.151.2024.10.01.05.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 05:49:58 -0700 (PDT)
Message-ID: <d0b29526-1a4a-4bb3-9cfd-9097f8ba7ef7@linaro.org>
Date: Tue, 1 Oct 2024 13:49:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf python: Remove python 2 scripting support
To: Andi Kleen <ak@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 Zixian Cai <fzczx123@gmail.com>, Paran Lee <p4ranlee@gmail.com>,
 Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240918225418.166717-1-irogers@google.com>
 <20240918225418.166717-2-irogers@google.com> <Zut-iM3v9rJHehxJ@tassilo>
 <CAP-5=fWS-xOPurApZpMA=Zzukt5PQDYjF_7otCPTAL33PYmXAQ@mail.gmail.com>
 <ZvsXl2g6kYDi6F9o@google.com> <ZvvbiY1NjTZxWvG7@tassilo>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZvvbiY1NjTZxWvG7@tassilo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/10/2024 12:22 pm, Andi Kleen wrote:
> On Mon, Sep 30, 2024 at 02:26:47PM -0700, Namhyung Kim wrote:
>> On Thu, Sep 19, 2024 at 06:45:23AM +0200, Ian Rogers wrote:
>>> On Thu, Sep 19, 2024 at 3:29 AM Andi Kleen <ak@linux.intel.com> wrote:
>>>>
>>>> On Thu, Sep 19, 2024 at 12:54:17AM +0200, Ian Rogers wrote:
>>>>> Python2 was deprecated 4 years ago, remove support and workarounds.
>>>>
>>>> Nacked-by: Andi Kleen
>>>>
>>>> I don't see any advantages of breaking perfectly fine existing setups
>>>> for no benefits.
>>
>> Well, I think the benefit is in the maintenance.  The EOL of Python 2
>> was 2020/1/1 [1] and we are targeting this release (v6.13) in 2025.  So
> 
> AFAIK it's still widely used, and supported by third parties. And even
> if not it's not that the python usage in perf needs any external support.
> 
> In Linux deprecation is generally tied to nobody using something
> anymore, and that is clearly not the case here.
> 
>> I think it's reasonable to consider removing Python 2 support now.
> 
> That's code that practically never changes, so I don't see any
> maintenance benefit. I mean it needs to be compile tested / perf tested,
> but Arnaldo's container collection will do that practically
> for free.
> 
> -Andi
> 

630af16 was quite painful to do and was related to supporting both 
python versions, so there is some ongoing cost. If we do this removal we 
could remove that one too. Plus Arnaldo could drop the python2 
containers and get a faster iteration time.

I think I'm neutral to in favor of removing python2 support. People on 
ancient systems would more likely be using an old branch anyway.

James


