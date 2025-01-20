Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3153C1DF244
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jan 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368052; cv=none; b=NaQqJUhRS1p2Av8PWBP2THjRrBsDU3N4WQ6Owicmqk8U8lfCMOfuNAkBMQcLTauMe6QMEupy6VNcBUPoh4PUzQuwzd+7pXxtcj2brNlSJ1zy+Hha3r4sQiVgZ+8YudP8m6gAKIwRW9huzAEvxFMwFNIArziHzcZyt37Aa7hZaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368052; c=relaxed/simple;
	bh=tmLPNb0QjV0neePXR0TLKSlDtDzLuSdeonr4XEPD5Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1i4Eweh6jQY9H1a+iPWpBFN2drvl8XJqEEZ2IoTZOvsk5sN1FHwQ7wr2Wc+3Gk2MHWi5BtOgwzEj2+xAIm/NXyY9L8NRd6DN2aS5RWBDKJxriHKxvzaSmR3TUguHeKrqQiKbSgc7eoWKc5TrdHBHdrJvbqiGSRNcOs1M5ADaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LjhT6btr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LjhT6btr"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862d161947so2251695f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jan 2025 02:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737368048; x=1737972848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYfPY3uHWPDRjBBvUAyHNjZ+LPl2Pcpq4JSbzBPDOM8=;
        b=LjhT6btriFAorbJ4smgiofMymFz2J0VDEFf1UGMldnPzsCbbjWuYe3SrpK7ztYnxaH
         Z/rDvsUSdxj92Wr2ZPs+zf3289hh5/INYQdo08QtPFc+4jXnN44xODOpCVplbr/xOCxY
         gb7uI2uR9XiaQF2/VM+PFtKgyDq/va+wRtNidgZo5LL0HN1tqXci4Ca9HG6iUyi2Ggbb
         hSTJw0clQSCKnJk+wfrFO+BLhCKMzuMNsNiTsBrGvVovcZ9jlEmfIaM9J4fdY0xrfDxN
         s8sZQB1VMeY+65MM86n84Go89i6FgXbOByE+jyZ93+Wgu2ioPnlGIBMeVoj77BHRkIe2
         Mvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737368048; x=1737972848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYfPY3uHWPDRjBBvUAyHNjZ+LPl2Pcpq4JSbzBPDOM8=;
        b=jpTdEuvrlSfW4eDGWwqNFNsAOnaVKksNT77LvKmRqCIaZNeegMSzltPIRr42i72Ifh
         Uqecb6mwOq9bEm2GxN+SRPtNElA7xy1AsNQ74sFx4r0jwo+A9+jB1MlaeFeZ3C2kjowt
         KEY1UHTGkFbg1mSdduU1/i+HQpUYepT1Xr0zEiCRKeR/n8T+XECeoXPTLzzJpxQcbIFi
         /DlJ+S6tiyLlVq0G6NPxfJW45fmnUvAu5b4CSy92o69tNG1vUBSCjgsYZr3ae5oDVsR5
         W7hkGd6x+X98IDAY3EPfTwz9DA+j/nWFqyGxmFWwxS6AaJAz8NOM8JE8xBj2it4wS5TU
         CKmw==
X-Forwarded-Encrypted: i=1; AJvYcCU3IvmZu4PaWxk91UZAtSdYYk6k9kivsY58/jOl3J7QsIHP7XebIoUQ6e7g5gObSDDjEbV+7fKRthma602QdK31@vger.kernel.org
X-Gm-Message-State: AOJu0YwvrOGupLGsyq3HSDgWhQPpPkdGl69sFUusVzVkbUaf1Ivc0kLu
	sn0QOQbK76M1sR9mpQeVDQf2o/obm3MI7eyX6Inzf60HfAhWO0EgTOom3XhC2xU=
X-Gm-Gg: ASbGncvr0uN2UMPJdNO/AVFgd2+/t42WdJTUIr89InNgA6dvQecdUj/No9asA4yKHXE
	BsNFIo2sOYMu5L/jbW9t7Wp5Dfb8L5uf3zuUWrBVMx/kZ1wkJvYWaOJFqsQCj5JsMmiPlbEyTxh
	KR4U+oEXCUipUXhzDGkAnseYAaqoQeIu8FzEpVyvmT1scAmzpDa+ayruHSyhBKUZA3/MpqGkZwh
	eNPLSZgZVs6EF88bE9cwcpmpdDx6njSv6AlzUb5RBRxrVQn0/nT5R1AkH/1PpG+bKDKf0GXXFe0
	LYOP
X-Google-Smtp-Source: AGHT+IE7vzlr91GTWyVQ2uFuiGjH2pXvFzm6Et3XtZumjCMhoeA+okGxgS/WDqvFvtDygaCrq/tOqQ==
X-Received: by 2002:a5d:6c63:0:b0:385:fdc2:1808 with SMTP id ffacd0b85a97d-38bf57a65b6mr12761968f8f.40.1737368047070;
        Mon, 20 Jan 2025 02:14:07 -0800 (PST)
Received: from [192.168.68.163] ([212.105.145.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275755sm9797579f8f.80.2025.01.20.02.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 02:14:06 -0800 (PST)
Message-ID: <1db0c4db-5e63-46f3-9bb9-898cb8312aae@linaro.org>
Date: Mon, 20 Jan 2025 10:14:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf vendor events arm64: Add N3 events/metrics
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 Nick Forrington <nick.forrington@arm.com>
References: <20250110172006.680753-1-irogers@google.com>
 <da5792c3-8f53-4be8-8f53-e1cf6660feab@linaro.org>
 <CAP-5=fXyVtZChi1fkochiyKw6AztdhEE_rfpJUsz_P9po5bhXA@mail.gmail.com>
 <d0ebae42-99b6-42be-beaa-947160da3b88@linaro.org>
 <Z4vxZj2YzfwU-m46@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z4vxZj2YzfwU-m46@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/01/2025 6:22 pm, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Jan 13, 2025 at 04:48:06PM +0000, James Clark wrote:
>>
>>
>> On 13/01/2025 3:51 pm, Ian Rogers wrote:
>>> On Mon, Jan 13, 2025 at 4:35 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 10/01/2025 5:20 pm, Ian Rogers wrote:
>>>>> Using the scripts at:
>>>>> https://gitlab.arm.com/telemetry-solution/telemetry-solution/
>>>>>
>>>>> Generate perf json for neoverse-n3 using the following command:
>>>>> ```
>>>>> $ telemetry-solution/tools/perf_json_generator/generate.py \
>>>>>      tools/perf/ --telemetry-files \
>>>>>      telemetry-solution/data/pmu/cpu/neoverse/neoverse-n3.json:neoverse-n3
>>>>> ```
>>>>>
>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>> ---
>>>>>     .../arm64/arm/neoverse-n3/core-imp-def.json   | 930 ++++++++++++++++++
>>>>
>>>> I assume you got warnings about missing groups, if one is missing that
>>>> results in everything being dumped in core-imp-def.json. I have an
>>>> internal ticket open about it which is why I didn't post N3 and V3 jsons
>>>> yet, I'll check on it again.
>>>
>>> I was testing with JEVENTS_ARCH=all. I'm not sure what the group
>>> warning is, do you have a link?
>>>
>>
>>  From the perf_json_generator:
>>
>>   $ telemetry-solution/tools/perf_json_generator/generate.py \
>>     tools/perf/ --telemetry-files \
>>     telemetry-solution/data/pmu/cpu/neoverse/neoverse-n3.json:neoverse-n3
>>
>>   Warning: Not writing events which do not have a group (note that the
>>   mnemonic printed may differ to the one in the source json if it differs
>>   in the common Perf files):
>>
>>   IMP_CT_FLUSH: Counts flushes including architectural,
>>   microarchitectural, and branch redirects.
>>   ...
>>
>>>> Up to you whether you want to continue with it like this and I can send
>>>> a fix up later but there's also a conflict with the recent Fujitsu
>>>> Monaka events.
>>>
>>> I'm happy to let you push the updates. An alternative, that may work
>>> around the group issue, is just to push the event updates. Any chance
>>> on an ETA?
>>>
>>> Thanks,
>>> Ian
>>
>> Can't say on an eta. There was a fix already done but not made live yet, but
>> now it turns out maybe we don't want to put these particular events into
>> Perf because they're not in the TRM. Could be several weeks before anything
>> goes live.
>>
>> It's a bit of a hack but I can regenerate them without these particular
>> events in a V2, and then whatever the outcome is from above will be an
>> incremental change later.
>   
> So what's the final decision?
> 
> James, do you want to publish the metrics later at once or are you ok
> with this patch for now (and do the incremental change later)?
> 
> Thanks,
> Namhyung
> 

I'm just finishing off some changes to the generator script and the 
change will end up a bit different. Turns out it wasn't updating the 
common events properly either.

I think it's best to leave this one out and I'll send a v2 this week.


