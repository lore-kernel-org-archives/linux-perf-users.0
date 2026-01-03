Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220D221542
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Jan 2026 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767458298; cv=none; b=gwuImfIy3AvzuhgYAriv8qlCpwb81fDB7uGWNdyvVOCo0vRGkoBvTL5qaMP/cPIdjqCCQ8zdXK/M4M5sLDw4gqXb5LMDH1oXZuQqpy804cJGFDj/gb/ntPGWow55AsyGqGVjYk+a0wFm15j7+u8YohETbyax3s1gi+yDily0qkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767458298; c=relaxed/simple;
	bh=8yaO0Fajuy9b0k1nF3K3GS3z7U+4bLtrpKMKJvrsY2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9950uqQKG6+LfjiHqqpQpx15pI5FCSq4PoNeTPoeGWjnx1ys/lmth6g0FHuQ0wwXziUPcuKwkg1lSXagHgvscbTjMePHbabZ1Rmsqfm2Iigv8CXNw30q4l9C+L7s2/piCr4zk5cyV0+sudXPbDqC6AGItl5yJu2eA1B2Vo2YOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y+Uq6OKT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+Uq6OKT"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso6347469f8f.2
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Jan 2026 08:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767458294; x=1768063094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FEJdWzcgO1wWmrKO/GtACSCjJ2V1a5B/5oU/evmLnQc=;
        b=Y+Uq6OKTAruKi/awBJvDw0id7KjZZnnuU80MuUlIIsyrbhnk+LWXsYjWPDOt2NAKW4
         U2o1ybqifGr9/0zLA09RCPIWADX0KaVyUimkrF0HctyUjv470WELhf23DAgGhOPa/VsF
         SqUidHeldM/BjrY9jrD6kHyJc6f3Jp1K3OGgWiffozQN40zK0i/nLrLsdb0L5AFQer+2
         4voyqkX+ACH3NFMxq7Fb9Zpj/Gp8o9tlSPonhsZMsrVyTwUkNA8ZwNoWjxJ8pbmO6Y3K
         0zlzUrCYAnw25to8mnva9f0tMBSo5RXYWFLck0kpkV/sIPeNCcORiS9kZY3JJQxaswuS
         T28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767458294; x=1768063094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEJdWzcgO1wWmrKO/GtACSCjJ2V1a5B/5oU/evmLnQc=;
        b=aPzsaktv3G+SVWrN7ugSmBjBKO5EFcfeH6uj7l8ShRbNaVxMSf1sUo8LpcUkYcisMO
         EXe9iPaM6UnllHb3ljXg4/u3Ngxbqze0vt7Syc7cqvUwfMM3Vwi1Ni+vNBXn+fWgOvqU
         9DUcTz44FxYBoT52Ulh781c7QimyGS4PKIa1IsJ+7e3HCtRrz3zr3Z8lKuNdLNqZDU/b
         jEEctMaC1QwDwCH8Pao1drAXYLyhbPx9tKSN7d9yk8EhvRJSvp8Zcakc4DBGrfUokB0R
         YqNFQbCtd6Igxk1jFtYkkx7KEio5/qb9ex0FH6CGXg9z4XO8CuZSg3zAFtsniTBzNWNM
         MW1w==
X-Forwarded-Encrypted: i=1; AJvYcCWdcB6ZL0D7WL0QGaPxZBihUc8voku1iGzPnZgUWm5VCOkdOao3ieP5Iqpi9VhxLbfT3aDSi2lVBvrmrfp9aN4V@vger.kernel.org
X-Gm-Message-State: AOJu0YxhhdvA/udAqRaxiX050puypE35dxb1xNywjo2Qr3diVvGWjdUz
	7JXbUorj9y070/kg/D2krcRV96OfRkQ3+pyGZvyp+GO4avPXGlu9zvW9gcCJl6FxINk=
X-Gm-Gg: AY/fxX5r20CRdKkfPDRy9pg0VxMa3wPBbEN0CnI0P7PbjwRwCxTTK7ebf2FBdA3eHAx
	OAVXhJ35D1us9wtDrpnUvo+c2LYKNe3eCaVTnU3/I6Cs1qBSGKakUChp7mK/p7IguS4Yi/hmHa6
	vj17MKrlxXkRnbvycCyk6msn6tfdqI2h+zYlUikWQyoiINUNW9h3jpdV2mSWm+QVpQMns4QVk2l
	6pQSQJrYxdHfCN2wnmw0/IFncJSxjcUnhFBmPPNXcd3P8TA/97zPlbKe2cpBU577jamsjDZor2y
	DbCnYilEwRLNRpkPzgS2+53opkw5iRiln1Z7LQeotOvmGbfWxErNupFNPqFky0qsPHZ+34hDg4m
	L2bmMLlLnHeu1ybXhbqRtzeau7ZKlCcqAtsB8pvzfdzyGqibtklUzLGLe/mZExoK0BMARgV7smG
	LdJz/ZDC0+BL9QLZmB
X-Google-Smtp-Source: AGHT+IG4JAdlO0U8i+J5bpIjo4ekwqJRiQzRTsLhZBn+ylFbVsnbcAn7FdWwOfpr/LkRch/vZBHwDw==
X-Received: by 2002:a05:600c:540e:b0:479:2651:3f9c with SMTP id 5b1f17b1804b1-47d1955794dmr485976865e9.14.1767458294378;
        Sat, 03 Jan 2026 08:38:14 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6be5e2eesm19201905e9.5.2026.01.03.08.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jan 2026 08:38:13 -0800 (PST)
Message-ID: <951f10c5-e1ac-45d4-b7ca-56aa32e57cd6@linaro.org>
Date: Sat, 3 Jan 2026 16:38:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64: Remove uncountable events
To: Ian Rogers <irogers@google.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>,
 Yoshihiro Furudera <fj5100bi@fujitsu.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
References: <20251231-james-perf-uncountable-events-v1-1-f2d9932999fd@linaro.org>
 <CAP-5=fUNJLoy25rS=diSXNR9h-h4m6EFPTy8M+KpTKxm6HtDSA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUNJLoy25rS=diSXNR9h-h4m6EFPTy8M+KpTKxm6HtDSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/01/2026 3:29 pm, Ian Rogers wrote:
> On Wed, Dec 31, 2025 at 4:13 AM James Clark <james.clark@linaro.org> wrote:
>>
>> These events are never countable by the PMU and are only intended to
>> be used as external inputs to trace. Therefore showing them in 'perf
>> list' is misleading so remove them.
> 
> What does "trace" mean in this context?
> 

CPU trace, Either ETE (Embedded Trace Extension) or ETM (Embedded Trace 
Macrocell). You can select PMU events as inputs to the trace block to 
make it do things like start and stop tracing.

> Thanks,
> Ian
> 
>> The generator script doesn't emit these events when used with the new
>> telemetry-solution input files [1].
>>
>> 'perf list' should only show countable events because there are events
>> that are sometimes implemented, sometimes countable and sometimes not,
>> for example TRB_TRIG. If we always include any implemented events
>> whether they are countable or not then it's not possible to tell whether
>> they are usable in perf without going to the docs, defeating the point
>> of 'perf list'.
>>
>> It's also not useful yet to display implemented events that are not
>> countable (for help in using trace rather than perf stat), because
>> PMU_OVFS and PMU_HOVFS are practically always implemented and TRB_TRIG
>> is always implemented when there is TRBE.
>>
>> [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/tree/main/data/pmu/cpu
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json  |  8 --------
>>   tools/perf/pmu-events/arch/arm64/common-and-microarch.json | 12 ------------
>>   tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json   | 10 ----------
>>   3 files changed, 30 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
>> deleted file mode 100644
>> index d8b7b9f9e5fa..000000000000
>> --- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
>> +++ /dev/null
>> @@ -1,8 +0,0 @@
>> -[
>> -    {
>> -        "ArchStdEvent": "PMU_OVFS"
>> -    },
>> -    {
>> -        "ArchStdEvent": "PMU_HOVFS"
>> -    }
>> -]
>> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>> index 2416d9f8a83d..468cb085d879 100644
>> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>> @@ -432,24 +432,12 @@
>>           "EventName": "TRB_WRAP",
>>           "BriefDescription": "Trace buffer current write pointer wrapped"
>>       },
>> -    {
>> -        "PublicDescription": "PMU overflow, counters accessible to EL1 and EL0",
>> -        "EventCode": "0x400D",
>> -        "EventName": "PMU_OVFS",
>> -        "BriefDescription": "PMU overflow, counters accessible to EL1 and EL0"
>> -    },
>>       {
>>           "PublicDescription": "Trace buffer Trigger Event",
>>           "EventCode": "0x400E",
>>           "EventName": "TRB_TRIG",
>>           "BriefDescription": "Trace buffer Trigger Event"
>>       },
>> -    {
>> -        "PublicDescription": "PMU overflow, counters reserved for use by EL2",
>> -        "EventCode": "0x400F",
>> -        "EventName": "PMU_HOVFS",
>> -        "BriefDescription": "PMU overflow, counters reserved for use by EL2"
>> -    },
>>       {
>>           "PublicDescription": "PE Trace Unit external output 0",
>>           "EventCode": "0x4010",
>> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
>> deleted file mode 100644
>> index 65bd6cdd0dd5..000000000000
>> --- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
>> +++ /dev/null
>> @@ -1,10 +0,0 @@
>> -[
>> -    {
>> -        "ArchStdEvent": "PMU_OVFS",
>> -        "BriefDescription": "This event counts the event generated each time one of the condition occurs described in Arm Architecture Reference Manual for A-profile architecture. This event is only for output to the trace unit."
>> -    },
>> -    {
>> -        "ArchStdEvent": "PMU_HOVFS",
>> -        "BriefDescription": "This event counts the event generated each time an event is counted by an event counter <n> and all of the condition occur described in Arm Architecture Reference Manual for A-profile architecture. This event is only for output to the trace unit."
>> -    }
>> -]
>>
>> ---
>> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
>> change-id: 20251230-james-perf-uncountable-events-28adfb93b73f
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>

