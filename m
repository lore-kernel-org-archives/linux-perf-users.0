Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153C1DE2CF;
	Fri, 22 Aug 2025 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874922; cv=none; b=DTh+ii5J8q2cRkBgN4XAMHSVj6CVZlU4CdeksPTjBANp2hixXUbbWcXgubRiuxImeyLblkv9nQKbWUAyupidwGXs5oTmMuvOs/9BNvrL59wePltdUKoB0CSS5koaUnuwirdgVQ0Sd7sdwxGVeHVSRr076Bw/cZrgftcTdLbBNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874922; c=relaxed/simple;
	bh=NEjLvM63WPR4tRkhy+QvBCaZwu3UNCdXTXo/KqMRCdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLmWenKTiR2cJak1gjXrxWgD7pQ12fKmOTaf1liCZEeBiT6uIOAr3y8+QuZRdyVXlMTivoA3//8EFR3LNzhessqZceUSLeQ8wZ+lHQGwMQ4XpyfARE13GXo2nvj/7OSBbFwkmIcnNL3A+D7v9Fkz6GaVjNiAAn6wOOlogrCChcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2462ae29714so1610035ad.0;
        Fri, 22 Aug 2025 08:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755874920; x=1756479720;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQxFfMbVY694nwqT/Zr69fBeRewrLZzBFyNEZe7ythI=;
        b=SychvEMZncV6ydR6l1D+PipMfRtYDRqz8bOKnm7hwy99a9k1uzqrp0Pau8kP7YIJ+6
         O2fiWSjSISjKv9/UTmC6sgLYM3uNszHUhrhh7vURFQ2EYWGeHd1adzwl2RJC4/CrtcZ9
         XIBAS62BoYA4KtnGsR8v1DTEfMddkj1UHVcdSdYAgwSC81EujXfdT2O2Hix69aCCewAX
         SUfkZPYwbjFRIy7xjtCYgtURi++CrJ6EJM3c+XFgE0FtmArYUKDdCyaTac+XTFZuFwK6
         yQ2yrbB7TOC72qv1kmI1eYGC3ydeXQJ9Mqw+CXCG0hMFaYt5UV52tc3UcJtOwh5b0DAh
         /1cg==
X-Forwarded-Encrypted: i=1; AJvYcCUBOHzbYvcl4lCB6UcSOA71X9IebpS7hOLiagr7UwD6egy7BMLuVVT3kCEG9BfLBu9jUnt3II2t5OaiPyuXO2zEIg==@vger.kernel.org, AJvYcCV1fj3wNPboCZz1ewR3PLLgfw+/td5gx8G0URho7EH4e/vC6UXNnFKpbdaeawtecuvY6YX81tvfbqidRQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzeTSMi1v+fYaY+BMrsAGonlq2OoUJxhQgaO00kxD+6IBWY4My
	KodXRS6wAXneatS7xCVdEnoAtnlfFvMgBD813TyVxOe34upOU36+sAx3
X-Gm-Gg: ASbGncs77/wRA23WuZJTQ15I/KlkQMTzDC/AzJo5/HfsZqUrjwkCmC9aFJJoGBN1iGy
	XDQUJ/+t/zflEXH534lJEKWOHAZviFZ5wtykMjzEdUwA0M8yUTxTgI9I0yvePWtOaPuqz6zGmLg
	isItHyjezkWQ4mkNy06m8/J5TbsguoEt3DMBxJBASJUD9oCP4PUnB70dBHRhTEx9ldQN5zQyBiv
	pPrc0HevPUKvf5TF6NveXxrKp65TCcTbc4WLKZp3LlhMcztZ30fj8D+Sd/gRBXocgM6ngkrZX5K
	hFntO6YUqkgxfPiOSOgUtWytbv1IcxRBgSxMnhVH7Al3jf6U5f0ELmMlcdvZtaBTQCRGc5ET3fG
	3vg/cYqrt3YIg1q+++COZDT0A1ueuRjs3G6AoI175XJK7xA9IWUK2fouW5vuurt4sLpeFp9Prwz
	0cQEycfMNTn2RE7i1bmA==
X-Google-Smtp-Source: AGHT+IG8h+rTjIYpDUhkLX0FKz+yq6EYhXDcqOADp2zpIy/mkPHlai6jtgygN4ifJj/kHfxfd3C9eg==
X-Received: by 2002:a17:902:e5c8:b0:245:f5fd:8eea with SMTP id d9443c01a7336-2462ef8af80mr24163935ad.8.1755874918990;
        Fri, 22 Aug 2025 08:01:58 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm85642335ad.160.2025.08.22.08.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 08:01:58 -0700 (PDT)
Message-ID: <e935e36a-1c5f-4706-830c-95cf6d9e6dc7@kzalloc.com>
Date: Sat, 23 Aug 2025 00:01:51 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm64: Sync ESR_ELx_EC_* macros in
 arm64_exception_types.h with esr.h
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250814151452.618765-2-ysk@kzalloc.com>
 <20250821113825.GA745271@e132581.arm.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250821113825.GA745271@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thank you for the review Leo!

On 8/21/25 8:38 PM, Leo Yan wrote:
> Hi,
> 
> On Thu, Aug 14, 2025 at 03:14:53PM +0000, Yunseong Kim wrote:
>> Update perf util arm64_exception_types.h to match the exception class
>> macros defined in tools/arch/arm64/include/asm/esr.h. This ensures
>> consistency between perf tooling and the kernel header definitions for
>> ESR_ELx_EC_* values.
>>
>> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> 
> Thanks for working on this.
> 
> This patch still misses couple macros, please see below.

I nearly missed that. Appreciate your checking.

>> ---
>>  tools/perf/arch/arm64/util/arm64_exception_types.h | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm64/util/arm64_exception_types.h b/tools/perf/arch/arm64/util/arm64_exception_types.h
>> index 27c981ebe401..29931bf19062 100644
>> --- a/tools/perf/arch/arm64/util/arm64_exception_types.h
>> +++ b/tools/perf/arch/arm64/util/arm64_exception_types.h
>> @@ -33,7 +33,7 @@
>>  #define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
>>  /* Unallocated EC: 0x0A - 0x0B */
> 
> #define ESR_ELx_EC_OTHER	(0x0A)
> 
>>  #define ESR_ELx_EC_CP14_64	(0x0C)
>> -/* Unallocated EC: 0x0d */
>> +#define ESR_ELx_EC_BTI		(0x0D)
>>  #define ESR_ELx_EC_ILL		(0x0E)
>>  /* Unallocated EC: 0x0F - 0x10 */
>>  #define ESR_ELx_EC_SVC32	(0x11)
>> @@ -46,7 +46,10 @@
>>  #define ESR_ELx_EC_SYS64	(0x18)
>>  #define ESR_ELx_EC_SVE		(0x19)
>>  #define ESR_ELx_EC_ERET		(0x1a)	/* EL2 only */
>> -/* Unallocated EC: 0x1b - 0x1E */
>> +/* Unallocated EC: 0x1B */
>> +#define ESR_ELx_EC_FPAC		(0x1C)	/* EL1 and above */
>> +#define ESR_ELx_EC_SME		(0x1D)
>> +/* Unallocated EC: 0x1E */
>>  #define ESR_ELx_EC_IMP_DEF	(0x1f)	/* EL3 only */
>>  #define ESR_ELx_EC_IABT_LOW	(0x20)
>>  #define ESR_ELx_EC_IABT_CUR	(0x21)
>> @@ -55,7 +58,7 @@
>>  #define ESR_ELx_EC_DABT_LOW	(0x24)
>>  #define ESR_ELx_EC_DABT_CUR	(0x25)
>>  #define ESR_ELx_EC_SP_ALIGN	(0x26)
>> -/* Unallocated EC: 0x27 */
>> +#define ESR_ELx_EC_MOPS		(0x27)
>>  #define ESR_ELx_EC_FP_EXC32	(0x28)
>>  /* Unallocated EC: 0x29 - 0x2B */
>>  #define ESR_ELx_EC_FP_EXC64	(0x2C)
> 
> #define ESR_ELx_EC_GCS		(0x2D)
> 
> Thanks,
> Leo
> 
>> -- 
>> 2.50.0
>>

I’ve sent out patch v2, Thanks everyone!

Best regards,
Yunseong Kim


