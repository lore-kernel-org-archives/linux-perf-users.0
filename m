Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140C72D77F3
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Jul 2025 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578112; cv=none; b=f6nfk5m8FIfmT43rSW2HyZbCgzzIvOm49WdlDtrs34AFc1iykWefU+T4pMWTaA1XOLJzyq09Ot4+87965Wb0GdYHz/WFNfywVkamNNL/MgIqI4vUQkurrETXNwRNllYWNWtKAZHMBOPSxpeFm557Q6LhE+/J5XMBmEJTIjlhMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578112; c=relaxed/simple;
	bh=/OTrZ6TKh/glz/18H5tew0pP6QtymeeEOVKpkPtgJiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdGQYBefgMLBfuoI+wS1RdwzAPKTTFgYcyybI+ZnZ+dzmqoGKW+DJMAOxOQ04WsMYR3Mx67nSCz6pK6kz7+9ilpC+1I/vDf219ZwWpwk6smUNRSOk+8qyaVzdfSEuLdDmM4+U4HvVvgodnDEKp2WgYz4LxbLAFUlfY1I1iAiPSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pOwUovDM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOwUovDM"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a528243636so2925183f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Jul 2025 04:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752578109; x=1753182909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KeD4qvnpOAgIBY4Q5KTmpBQo8WVRBjthWxr3P8XIcks=;
        b=pOwUovDMrQ4TqB/vCsIlscKsOoYqz85Aw6KbjNfJEvOuP2p5d1Mg15GJkj7Ry+krLz
         XY0jNyUFqlvZNlWjuA8C+kDWREhGaNQclmZIGpRB5QFMbhNL75zgecqBKVLMeA3LP0fy
         xxQycGadQwFREk+3AayGDC8Z64ns3D6JzNzLgW/i+czZfUQb/FkHzJP5615x9mwbFvuq
         UKEfxHR0PR2WvxzyeDhC3TGy8cGRJfQRcfz/Y3b6uPHPHclhr3d39rruvc7CGdmvm1HE
         8N0Yydxxt88UTjqnQ8pXSwQj4in/FOkeWbwEnI7jNsy24izUblu6L7V4/S2js+Wlyd7c
         W8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578109; x=1753182909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeD4qvnpOAgIBY4Q5KTmpBQo8WVRBjthWxr3P8XIcks=;
        b=v+dLTRRaB4OHe2s0ENp0ThDmuxaEYYIx917/ul5jNNc0v7OsCT8iAA31DV73JkUlKq
         4zG9KAvyi/isxBZmnkdJbs/P5vLHe3FAkeI0mO8+p9DS9vorVQUFYxTANmgFD6wqYchc
         bpTl6PjVfEoCYMZEC+lP3DIthDXXcqmnRhqLzYrA+WYUMDSA2X2WqQ8jpsmFiCwHWm2Z
         kXf8HCp7o1HDzhW/r825aIeTDWu5g21GK/APOSi+LLqi70JFtkEt/vqQ/TnX10UzoMl2
         HVnrj3hLubmPRfTmAcMNbo8T+iP7repnnC26U61k4/bKCTkbqTKcCXV+6B8OfY5PO3sW
         Wmmw==
X-Forwarded-Encrypted: i=1; AJvYcCUxQ4gq21pip09BvvjA1dlIF3ZurtSeQ9Q1mbtKNp8XRvfJUAjkpcpvWd/2jIr+q8dHvkN3CnmHU7FOFB+SBnJa@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpS9rodq0Ker/CQfxe5lJenKLac8JRMTD5SNaEcjTiZQbDl1y
	jFERJnhH6herW3LRnZT1rbjLZzqw5GeDevjPABffkg0wPC4k5J4r56M/JkrCv3JV29IhiFhSYkg
	XJjpgk5w=
X-Gm-Gg: ASbGncvVFDZNC19pRN5xnI4/KiL9ZaJnxbkcdAAeWu78Xs/PSJxWLeL+Tg5AfBEgbeg
	mWR51DHLcblZK+NZX/Gebp7okGGafQ9LJ0Y0oqB+WlvudTzPL+dQQw5h0H71L02kPEhu6VPbfDY
	CFkcLuXCAvLBsjYjW7AvPFxR/obCvJqBAfaacvTFLLVd/mKYDpPTx6alKdSisSdqKzAthZVDyvo
	3qJ2x3aGUqXPZKHU/Mr1X+UCjvwlwoFfAjdB8s19tDFt+OVOMZxgSt5NBtJWsP4/ZouBlmmJ7PE
	nWWgHfjpaqgitxZYcAiCQn6FuUrDp0ci/HrNjtWcXIzNHa6mtfd3V1qmIGsTsK1rAQIp9ODCglh
	ENYsyK/xBKdgRy0HKy18UW4CiHHs=
X-Google-Smtp-Source: AGHT+IG8+RnncnWrWqe5aRURSefY3HnfmihLhWZ4TxPEcnqaK//NeNt6YcFH1RHEdf9sGBw4B0HHaA==
X-Received: by 2002:adf:e191:0:b0:3b6:c88:7b74 with SMTP id ffacd0b85a97d-3b60c887b83mr622884f8f.59.1752578109392;
        Tue, 15 Jul 2025 04:15:09 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1a2bsm15131107f8f.14.2025.07.15.04.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 04:15:09 -0700 (PDT)
Message-ID: <f3393b26-a1ca-4d8f-9c22-0330956090b4@linaro.org>
Date: Tue, 15 Jul 2025 12:15:07 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] drivers/perf: arm_spe: Expose event filter
To: Leo Yan <leo.yan@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, German Gomez
 <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
References: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
 <20250707-arm_spe_support_hitm_overhead_v1_public-v3-1-33ea82da3280@arm.com>
 <aHUBFGPck-O3vs9b@willie-the-truck>
 <20250714150921.GE1093654@e132581.arm.com>
 <aHUerfpLyAPEc9R_@willie-the-truck>
 <20250714154251.GF1093654@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250714154251.GF1093654@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/07/2025 4:42 pm, Leo Yan wrote:
> On Mon, Jul 14, 2025 at 04:13:49PM +0100, Will Deacon wrote:
> 
> [...]
> 
>>>> In other words, remove arm_spe_pmsevfr_res0() and the two checks that
>>>> use it in arm_spe_pmu_event_init(). If userspace tries to filter events
>>>> that aren't implemented, then it gets to keep the pieces.
>>>
>>> Then the question is: what information should be exposed to userspace
>>> so that tools can decide which events are valid?
>>>
>>> I would suggest to expose a new entry, "caps/version", to indicate the
>>> SPE version number. Tools can use this to apply the appropriate event
>>> validation. Please let me know if this works for you.
>>
>> I thought userspace typically had midr-based json files to figure this
>> stuff out?
> 
> Yes, the perf tool records the CPU MIDR in the metadata.
> 
> However, I deliberately tried to avoid relying on this approach,
> because the perf would then need to maintain a mapping between:
> 
>    MIDR -> Arm SPE version -> Events
> 
> Given the large number of CPU variants, maintaining this relationship
> between CPU ID and SPE version, and subsequently mapping it to supported
> events, would be quite complex. Additional effort would be required each
> time a new CPU variant is introduced.
> 
>> The supported events aren't probe-able afaict so I don't
>> think the driver can help.
> 

If the RAZ/WI for not implemented is guaranteed, can we not discover the 
supported filter by writing all ones and reading back what stuck?

> Although the events are not probe-able, some events are specific to
> certain Arm SPE versions. For example, E[23]:
> 
>    | Data snooped.
>    | When FEAT_SPEv1p4 is implemented
> 
> With SPE version information, the perf tool can decode E[23] == 0 as:
> 
>    "No snooping" for SPEv4
> 
>    "No available information for snooping" for earlier SPE versions
> 
> Without SPE version information, it's impossible to distinguish
> between these two cases.
> 
> Thanks,
> Leo
I think Leo has a point that some of these shouldn't require any MIDR 
mappings, and if we're using a filter for some builtin part of the Perf 
tool then it would be good to have that work everywhere, rather than 
having to update for every new CPU.

We're already publishing the SPE version in dmesg so if we decide to not 
publish the filters we'd probably go and try to parse that instead. At 
that point maybe we should publish the SPE version in sysfs properly. At 
least that's scalable unlike having to update the filters all the time.

James

