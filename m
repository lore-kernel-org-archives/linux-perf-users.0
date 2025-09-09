Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5772417F0
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Sep 2025 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420470; cv=none; b=nEAtLH4IDWdjWuCNi/iy2tC/9tf7W4MhopJYpvIFSq2m9C7NKxEOHgLB/U63KDnu7839DNsz+D6FNWpmiEK5jWOK2/sp0rP1HGHD6IEEeThNDtFeV7T4bUm2lcEXj4ZmSbjmjbzNEwG3K2GrhN+CN/aI24jEddkAhJyT7zJPv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420470; c=relaxed/simple;
	bh=BdA/OQv8n239DFtVYhXJBlllkimTnSdhMzIasDl7km0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sB38yauEJ0t7SfcuSthCG3pXSP0txbsO3/XuH+HTD4uDK+gkJptegl/EuNEw8+mrxGLlML4ssH4H8DaeYQ3SSoWAb6/eNHYIPKl9T+t4Hjl/r0xBJsJ2Fz+2mhao8M+jtFic+JXIMBXowRQT2rKD9KS3joljLy0o1KAwP3zl/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N8wVxcKL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8wVxcKL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45de6415102so18720515e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Sep 2025 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757420465; x=1758025265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e9aAVIFTB9yAV+GQAaHBwR0TWklKYdkWkTVHPifGbM8=;
        b=N8wVxcKLYTcDq3MXozROg+/vovEbENqpWGVHHMsi+PQtLLV9+hgsGhjUwZgL8nOxnc
         NC0V+vuvH2ah8VQCxAqmm5olcU91Bq8KL3HnTitmUOaYe7DAIxBfEQtk2pnBmDD8/VeV
         mKEJXJVNYR01pxNNPTyEHI6dpp/oMsNKXyGPJRnAZ9Gzy6AWTOUYGEb9flzN9jLDmR9Y
         YQD15atyKRarq4OD4ympINH+690AU06Om4+LkWALbYnTuA+SKw0G4UNmrKzxHXA9cjs0
         YitQ1GB5zRgo4p1EKpqFygkTRnqmgmtXRtQRmgG7PCOebWfp52LPPFCRj15k6CK9/vkG
         LZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757420465; x=1758025265;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9aAVIFTB9yAV+GQAaHBwR0TWklKYdkWkTVHPifGbM8=;
        b=H7KRrAS9GY9iMAqGLWGmfzgkiOdQpudM/E4vaaMh6oBuc/FNaBi0430ST0Vyqt13pQ
         eJlmIul69DHFqwZY/p9sXagIHwWmsZUKvlgri6eORI7GFP3i+CjY1gI5F+fu1JtfveYh
         bjp3K/UWIn9qoaziM+lm70UJD/Lp/OoylcTUmVTSC/iQLI/K/fAxDNUTnnRMZDR9ileZ
         w1p5NJM9Za2goEkhcFak6Hzk6s5EVjtfCapFk1pBLbAJwn3ByWAzzrv01cbc9mvbtvvD
         jXZulNHcQhxqMfwOQMRjbAvGwTrm2jvuG3eIkcHYUQSb21cFSfCva7eqDutCRjNbD1J6
         CA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoNqSWdaKSjVFLWJdJE74MGMJT91PJHQZHmW0IxQiwcNMm0e4bC+ouULfAAJqVsziu7J7SFtmYyufXXY26RyNB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LlZ78qaOCY8pB9mSJRkJDNdmymrcSSaVD8vrmF0mZs2578wp
	McpnvjqFbd7WmgkJwjVeFO+mMS+zbFU/4LOqeJD+C3tPeRPvleT2Lkqf55II7n9UGN0=
X-Gm-Gg: ASbGnctRuuD5fGkt9ZDPiu+NvYV8nsFl7b99Ml9HyEKESrcoUI6QL6/XDu45LoKhoDs
	hPxrE+fDX33tefO2fNcdom4UM7iVEeckta7gYIAOkRxhPsw4+GuFDEQeO1VB8vEG33ngbcgE52Y
	3vvfyRVkbPGik6f6NswoZWD4yGWsCtC7sdC/IWhCjqfaIZOtV9s2f0MJTv5KqMwtS3WLwLi6plW
	MamyqTSQY46kLhMzUCRA4wL1lCefItJ/pWvw3YKdO3dQCXsF02O5N6MWqk4tOKrE9U6C0TiztxB
	4ixQVRZ6pDDImLrS9SGTGL8tBjeGTa9qg8ecW1+qLD+4nPe8RCdw9ANM6Q1CGFpaHu1ZmzHj2Yw
	HkUuS21vWe2cU8tEVWx6wRL9VFzGlRG70RRJ6Kw==
X-Google-Smtp-Source: AGHT+IHaBOAGTfkhgFhbVLu/wHVI1hhtSVll6EktX5UfFmRzOFzoL5bcSBkBdIXzZP80OpbBKg72qA==
X-Received: by 2002:a05:600c:45cd:b0:456:1dd2:4e3a with SMTP id 5b1f17b1804b1-45ddde6ad13mr106581125e9.3.1757420465378;
        Tue, 09 Sep 2025 05:21:05 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9c5c89f2sm298074835e9.14.2025.09.09.05.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 05:21:04 -0700 (PDT)
Message-ID: <9f84d9e1-9404-4151-9c5e-d3a1c018aa03@linaro.org>
Date: Tue, 9 Sep 2025 13:21:03 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] perf arm-spe: Improve --itrace options
From: James Clark <james.clark@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, George Wort <George.Wort@arm.com>,
 Graham Woodward <Graham.Woodward@arm.com>, Ben Gainey <Ben.Gainey@arm.com>,
 Michael Williams <Michael.Williams@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
 <aL9HvOl-n_IM0qiB@x1> <02cba58e-86f6-48de-a59c-6d31a29258df@linaro.org>
Content-Language: en-US
In-Reply-To: <02cba58e-86f6-48de-a59c-6d31a29258df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/09/2025 10:51 am, James Clark wrote:
> 
> 
> On 08/09/2025 10:16 pm, Arnaldo Carvalho de Melo wrote:
>> On Mon, Sep 08, 2025 at 01:10:17PM +0100, James Clark wrote:
>>> Most people also want all the SPE samples (instructions group), not just
>>> the flagged samples that are put into the various memory groups. These
>>> should have been shown by default but weren't because the default
>>> interval type wasn't supported.
>>>
>>> Also when looking at this, it appears that the downsampling was behaving
>>> in a way that would discard samples from one group but not another.
>>> Improve that and the warning messages.
>>>
>>> I don't want to put fixes tags on these because it's only changing the
>>> defaults and the behavior, but I don't think the previous behavior was
>>> incorrect necessarily, just copied from tracing techs but not ideal for
>>> SPE.
>>
>> I keep trying to find some hardware to have in my homelab to test these
>> series, but till then I depend on people having access to such hardware
>> for acks or better, tested-by, so waiting a bit for those to appear.
>>
>> - Arnaldo
> 
> Unfortunately I don't have any good homelab suggestions. Radxa Orion O6 
> are the only not-super-expensive boards that have it, but it's not 
> currently working due to some ACPI issue. AWS Gravitons also have it, 
> but you currently need a metal instance so that's expensive too.
> 
> Leo should be able to have a look at this one until the hardware 
> trickles down further.
> 
> Thanks
> James
> 

Forgot to mention that everything is available on the FVP model, but 
unless the tests are specifically written to run there, they're too 
slow. The BRBE branch stack test has been, but SPE and Coresight tests 
haven't. So not very useful either unfortunately.

>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>> James Clark (4):
>>>        perf arm-spe: Show instruction sample types by default
>>>        perf arm-spe: Downsample all sample types equally
>>>        perf arm-spe: Display --itrace period warnings for all sample 
>>> types
>>>        perf docs: Update SPE doc to include default instructions group
>>>
>>>   tools/perf/Documentation/perf-arm-spe.txt | 14 +++++---
>>>   tools/perf/util/arm-spe.c                 | 53 +++++++++++++++ 
>>> +---------------
>>>   2 files changed, 37 insertions(+), 30 deletions(-)
>>> ---
>>> base-commit: 75a7b9d29215c5aa813b9620f3c56817918f9f8c
>>> change-id: 20250908-james-perf-spe-period-4711a566cba4
>>>
>>> Best regards,
>>> -- 
>>> James Clark <james.clark@linaro.org>
>>>
> 

