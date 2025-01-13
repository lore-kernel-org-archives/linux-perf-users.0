Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B04C13C8F3
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786892; cv=none; b=DzxlsMRlRsX4Gvqmw5s4zb7+TNpwECNbh/HKmbZvrbk8hFN67bcn2YHoLb8/eAGQW9Hb8qqBL8+0rUtrrdnao0trn7cg5fX6eGdtV5pv8CA7PqsZx0qhvHgCtJDlJlDt6ykMycEMVKSVZNJm8h0JiYlh2mR1zsgxFu4nneTUdjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786892; c=relaxed/simple;
	bh=uawQNnVORCsCtDVNK5OjHXpZvyzfrQp2eZ2UhpxZEaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlTP57ztGUEltrxS+QH3QD3xxRen0PJW9n8wICmy+TFiL3hKiN5tY8XxsUu4klSddsujFeMwl6QWoTfo4Q9GcaBTtRukK7foimeic8UYRh6G/mk+uIsiq2TkNBLlHj/W9RDaJ5Aar4hfOKpPWCyLIrf8A/DwyiYRMD/pSQNhfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yAQmWZCE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAQmWZCE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso32681845e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 08:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736786888; x=1737391688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCDwiC2ChTMIMuF5sErsTKTOGH/i2ual/aPVMi/EvR4=;
        b=yAQmWZCE5sXqFIu3g6KT4nV/bF7qOdZuEUvdQ7flwDGivtti2gl3L2/Z1OPiwTY47p
         VIDVk51mzhw0ozt41pWMNV+PbhQG1aR8ajIl4FnVRuKsryUVVIzAkofs2frBobUMLeDs
         OQIgnyhKCl8LY7UdPMq1PtMEg+y3M0qQs5Esse9A8Kbdk00hzzUrqfw7l12Decsg19kt
         KPyUNX3WnELJiNuMA6x/EeSv4HloYckkD3SBJfQ5XsgmN/RFWyCCbQwrdNECu9AqpGtD
         L6yXuGRQXaSZasXxRYod/rsV65/YLfNOxrPLfivBKGmlKeyZdLkTrJxfh1LDzlOKSKEL
         rugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736786888; x=1737391688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCDwiC2ChTMIMuF5sErsTKTOGH/i2ual/aPVMi/EvR4=;
        b=Lw+rdgANn0NsLNhV7s9jNkX/OKEFr9vCHlMxR7KVWpDSEe5H4bhJQmcfdIplsc/cca
         PiWCM1NgrX6yRxU4+sC1Qkwcec2hbZz8IYhBw/fzm0S69unwmWp+6FLk+G2MgptoKebA
         BRDfX6Hu2Px5QCol31k66FJbpAZWESzOMEq+UWkfrJoX++HMhngKffy9Uw5nC2ybhp1q
         wjd846rxr13vLeIW09x9OefFNYfw7U9F+kksS1F2+qyODJKjgAG3SX9fPqIcddBUkvV9
         CuCUYR5ka8+kqi+V1kKUP9Pcur9zcZOWJofSBjPBfne2xEIfiubFHexrvdks45jvKxq/
         8RwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4rZ+Lph1ZxTQAHq5P8GD8GuX/S/hkhmcWNmR03xRoozQy89tdqn62AvG2exQr9DxtOkFNkQFZjedy1z2bfKHu@vger.kernel.org
X-Gm-Message-State: AOJu0YwFyRtzJhSHT+QXOPRiwPBHxwLOAKROcmFoPv2TQt8sCL61ZBOn
	mi9GFYnWFTl32K0iLUXzyZbHW+3isR8wz4ttyaTy9a+mDEDjQnljLjtat5eleDQ=
X-Gm-Gg: ASbGncuQvWjmbpQG0myY33zc96Oq3P/udNuWpmc4I09aupCh9UHRAgH9PVHIXamAtDn
	PORMV9GSvtG3OiezBD1nxdrgnt64phzPBRz8PpMsMzVa98LPIqQM9A1h/20dcEOWiLmwDwW6jNs
	laFDrZ7FIGUiqm6lkS26wwMvrUcKTy23xqQlPAH2aD2B0eISoRWB03kyDj5ti/hy8TsAl/K33Xf
	92Fi7u6a6J1aip1QvoSwL52nEVV/lGq9uT5YDfdCe5LWn6MsUAjZNQl43NCBHmdg6h5
X-Google-Smtp-Source: AGHT+IER6KYF6RQvQUMNV9juLdwNdllc6fPKkCHKfac+vsy4zTDSEgoZ/Ee/dPPZGpy7n4GhLF2KjA==
X-Received: by 2002:a05:600c:1987:b0:434:a386:6ae with SMTP id 5b1f17b1804b1-436e267850cmr200788085e9.7.1736786888373;
        Mon, 13 Jan 2025 08:48:08 -0800 (PST)
Received: from [192.168.68.163] ([212.105.145.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fb99sm150640805e9.3.2025.01.13.08.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 08:48:08 -0800 (PST)
Message-ID: <d0ebae42-99b6-42be-beaa-947160da3b88@linaro.org>
Date: Mon, 13 Jan 2025 16:48:06 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf vendor events arm64: Add N3 events/metrics
To: Ian Rogers <irogers@google.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 Nick Forrington <nick.forrington@arm.com>
References: <20250110172006.680753-1-irogers@google.com>
 <da5792c3-8f53-4be8-8f53-e1cf6660feab@linaro.org>
 <CAP-5=fXyVtZChi1fkochiyKw6AztdhEE_rfpJUsz_P9po5bhXA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXyVtZChi1fkochiyKw6AztdhEE_rfpJUsz_P9po5bhXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/01/2025 3:51 pm, Ian Rogers wrote:
> On Mon, Jan 13, 2025 at 4:35 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 10/01/2025 5:20 pm, Ian Rogers wrote:
>>> Using the scripts at:
>>> https://gitlab.arm.com/telemetry-solution/telemetry-solution/
>>>
>>> Generate perf json for neoverse-n3 using the following command:
>>> ```
>>> $ telemetry-solution/tools/perf_json_generator/generate.py \
>>>     tools/perf/ --telemetry-files \
>>>     telemetry-solution/data/pmu/cpu/neoverse/neoverse-n3.json:neoverse-n3
>>> ```
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>    .../arm64/arm/neoverse-n3/core-imp-def.json   | 930 ++++++++++++++++++
>>
>> I assume you got warnings about missing groups, if one is missing that
>> results in everything being dumped in core-imp-def.json. I have an
>> internal ticket open about it which is why I didn't post N3 and V3 jsons
>> yet, I'll check on it again.
> 
> I was testing with JEVENTS_ARCH=all. I'm not sure what the group
> warning is, do you have a link?
> 

 From the perf_json_generator:

  $ telemetry-solution/tools/perf_json_generator/generate.py \
    tools/perf/ --telemetry-files \
    telemetry-solution/data/pmu/cpu/neoverse/neoverse-n3.json:neoverse-n3

  Warning: Not writing events which do not have a group (note that the
  mnemonic printed may differ to the one in the source json if it differs
  in the common Perf files):

  IMP_CT_FLUSH: Counts flushes including architectural,
  microarchitectural, and branch redirects.
  ...

>> Up to you whether you want to continue with it like this and I can send
>> a fix up later but there's also a conflict with the recent Fujitsu
>> Monaka events.
> 
> I'm happy to let you push the updates. An alternative, that may work
> around the group issue, is just to push the event updates. Any chance
> on an ETA?
> 
> Thanks,
> Ian

Can't say on an eta. There was a fix already done but not made live yet, 
but now it turns out maybe we don't want to put these particular events 
into Perf because they're not in the TRM. Could be several weeks before 
anything goes live.

It's a bit of a hack but I can regenerate them without these particular 
events in a V2, and then whatever the outcome is from above will be an 
incremental change later.

