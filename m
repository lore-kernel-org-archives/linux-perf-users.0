Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D07F477
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560894; cv=none; b=uw3eV0bWqu7SdSVp8cXfbJoIaIQNrDLQEvo3iqcpHfxqY1mw2TQ440sIWf2QS0ggfcYn2z9KHiS5UDss5yRKNdCPvCzj3jLNuR5FaYOyzQ9Ejm9QirKY8UvvJDANUP4RCg+Chy7CdONwixyEcu9ft+RNkSoDhBGvsjQov+0h2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560894; c=relaxed/simple;
	bh=fuBX73Jn0IJmQMm2EvxwdHma5rP78BJNFL3nGkoIlPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEc86KUjRHmCi5Z24qr0S1EDjMUuI2pJBQ4ACjIW3jyftJSvfy3BvCcUQQsJkrQN0iUMj1SJL5fh4v8mRFLbw6E5Q/xp8roGzi4jNjl36bjEQrJvuOjQ0MUyVTUwK8ydDGZM80lw/qXvOvcqrokU2QqpYmNu8rwBvCg6zwAAIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ktTTSwq/; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktTTSwq/"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f762de00e5so59807181fa.3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726560891; x=1727165691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40MhPp2saeHTiRrc06dNphqLdj+mKjYaNVOr8gOga8U=;
        b=ktTTSwq/fmQFuBexJRrnvFsK8s9nuzk/ro2KR0ji8EP1Kd9yOOucHNcExc5g1FTD6m
         E6H82y6FVg3oUHTdYQtUMLb06ldDapXA3+nXahnv5WNOuvx4evB3qYEjDvGHuuL+IHIn
         VKd5VplhtXx9OF0V2XtNv9xq1gG5z9uIJ2/92MecckTHij815i62TM2s0pRsjP/Osa2/
         ++NCDefw7lctDL70NVmJzSBhocaPK/Rj9HLcPa0AqFpgWZstPmBWuFrugGf0B4NeMBHw
         x80EqIQNQJcm41lW5AZtqTRYqQAgRCHDlSEw29DLEibtRxBJ0BczXPtJJuOpJoqxmW7U
         hj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726560891; x=1727165691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40MhPp2saeHTiRrc06dNphqLdj+mKjYaNVOr8gOga8U=;
        b=MWicTR2Ar+ZQMX7vTV/xU1N3IWxBK9DIL3wCkJCmYtdAKsuilx7Jokak8oHlX5AzdG
         Utr2GE78hwtcUXLoLvXT6nCuKlyxoV97gLMHGOIfTICUZGKwko0KfQhPJLFqUXklQ/vO
         Ac5EJrYwrODxYel5llnc5jsK689WvjAw3c2HGQdVzwQ2917VR9fhK9s4rJgsZRELHInX
         klg5T15mV8/lfZcO5cpfaWzNxJhj6lWTi5PrszA9fV+uZXGGfGPT3Q9MMUW7VvPa+DBq
         pbDWmXkAYLNzfjOqZVnm3/aaGEyeAokAI6AXulgFSWZHiCs8zgcMdWsN5kUbTsVu005m
         yNMw==
X-Gm-Message-State: AOJu0YxTY69Fxr8PRnp1Oyr6We/sX6J5On977KtPRxQWK1a1/EdX9qYr
	zFsdx26LKJdgQt8RnAwY1ZRGG/MriLDGDWaXgox4i1BNdG+oN2eV/m7r4/xIVcM=
X-Google-Smtp-Source: AGHT+IGhMCNStijW6BvOu47nwjvS+9s5k0vizVA+NhP22vD89NPpE8po+GWqjAVPIR6eOIhd42007g==
X-Received: by 2002:a2e:e0a:0:b0:2f7:5c58:cc7c with SMTP id 38308e7fff4ca-2f787f6a8f5mr74583591fa.44.1726560890867;
        Tue, 17 Sep 2024 01:14:50 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9aff579asm134462235e9.0.2024.09.17.01.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 01:14:50 -0700 (PDT)
Message-ID: <a6439ec3-27dd-4e1a-b4ee-b9d4650c98ca@linaro.org>
Date: Tue, 17 Sep 2024 09:15:11 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] perf: cs-etm: Coresight decode and disassembly
 improvements
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com,
 coresight@lists.linaro.org, leo.yan@arm.com,
 scclevenger@os.amperecomputing.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240912151143.1264483-1-james.clark@linaro.org>
 <ZuM_oMuODcF0WVza@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZuM_oMuODcF0WVza@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/09/2024 20:23, Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 12, 2024 at 04:11:31PM +0100, James Clark wrote:
>> A set of changes that came out of the issues reported here [1].
>>
>>   * First 2 patches fix a decode bug in Perf and add support for new
>>     consistency checks in OpenCSD
>>   * The remaining ones make the disassembly script easier to test
>>     and use. This also involves adding a new Python binding to
>>     Perf to get a config value (perf_config_get())
>>
>> [1]: https://lore.kernel.org/linux-arm-kernel/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
> 
> Looks ok from a quick look, but I can't test it, so since there are
> reporters for problems that are being fixed, it would be great to have a
> Tested-by: from the reporters and probably from someone with access to
> the hardware where this can be tested.
> 
> - Arnaldo
>   

I pinged Ganapat, hopefully he has some time to test it. But we can wait 
a bit and maybe find someone else if not.
