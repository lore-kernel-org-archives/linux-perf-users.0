Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B713126D3
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676418; cv=none; b=DMk9KG3I51Gk+wnHY2XRGyLe2xx25cLfvpPUn4UPOEXVkGUl8m1FnK5LXygcf0BJoV2CKSTiUAm7fNyi62XV3sAemN/1/pdDK29Cb4pTVjDqYo2OUbVWqMbNP4MpeELEzevnqspZ1xmz1ZEMvY/7N88qfIJ8A4ohGMJvXNs+74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676418; c=relaxed/simple;
	bh=KersN2Y51szKaNs6c2hAWq7FbhaDJbeLs4PotwdSdZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fY3dXqy+T036jMcHrkaHOE7gtiyo/P40W6ti8q08zcxK/41I9vYpRsySYCEPCnXtxOkJ1yKGj7LCTWjOTpqtU2+8RE5EEJFYWtoMPU7xxrUO4CwaCiwH7NGuQGFN6Ux/Syio45ptaBBBPjIwaz5guqELihw4Ji/yUG7niR1WhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nEfrQSWO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEfrQSWO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47789cd2083so31489825e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 03:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764676414; x=1765281214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ky2w92Omxf/9BARxmiNxHekw/fnnKDmtTcKK+1HQF10=;
        b=nEfrQSWO2LhLevI0EBJ7XAKbmoWOcOawPH2dzorQU72njzmxar5A9vf3P1ILAmpQKL
         9a6RzOhS2jSXf4Ozi8p6qnocvePeT/jN1DxoaPzPoZFv4u7wrW0jKlB/TsFfy+awNwbU
         mazyhbB4K3nwPS1HkwCvBmWIRWzKRowrWTAoaPMYhRsJ5fV/tN2iV7KK9Xmz/M6CG24J
         A+mZrgOelkAsTYcRMlR7h3PlzR1j6WqXMmhXfDSerREVv4kp11n+qftGpM1s1Upl+ti0
         JXED/aepSg80fZ9Ymrel4F2Xe3P2uVk3z6tO32TxrV8FIS02wjfKOLEhn09S/0MhmuJ5
         VdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676414; x=1765281214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ky2w92Omxf/9BARxmiNxHekw/fnnKDmtTcKK+1HQF10=;
        b=RTFYBQtCXUIqwoJExAogkxo6n4ppWCYaLfqyoGx+zYasZYz+gIibGiuzQ0ODCq06ni
         vpnZP3/DYOx7VheB57xsvKIhYL4FwpxlromOZFFQ7N+Xdr4PEhjn7zDVHaFhQuLYXOV7
         RK6tdsODhVuhNUo/27j4S/A1IzTbQxKISBTZCfEXXS9NWRHdRacQ/JmbWHnJ3yha10EX
         mfZGwqYDZDz/l+eFlgTrrnpH5cSu3kQA8yPPwv+3OXjye5xI23PbSDiVU355vEMG1UG4
         quGtTNDjl82mLG8d6c8977WQ9SdA5G+F2qDq0OFQUwQ2oKOgnWD0uu81dUpj6r8NEVdj
         0x9A==
X-Forwarded-Encrypted: i=1; AJvYcCXGeYro5eE8gkzh96bHlq7l9ssRChCvF/UI2mJIE/vGbJ/2O6DUX2Cr2RcFvN2zJgIHMMHnSnWFcq531TqpyfYr@vger.kernel.org
X-Gm-Message-State: AOJu0YwhbM7tU6T1nLQd4BM+lHT3wCuuIasobnSvTA7jO5Kc5ovmJste
	MHAg8WEJ9907Qu41q7l97Ac560I3wLhHdq/fOq0JajOocZtKSEFxZmY+ycwvOv1bp+0=
X-Gm-Gg: ASbGncsZvze5tsP2ShgR7A1Yff+vL4Hihtr4TORmI7MdDXAtTN9hHm5zztGfjr80+Sj
	5/xBg/Io9rElMEGptkA50gHX7SX7cjbfNEUoAr59T1NGUfVQki3hHrz2UFDW3Sgpzxu+Ue5gNwD
	NFhk7m4dwOL7q9ozs45wNYd/O1yQBDheJKTHZTyl5LFhxTiAWdFzDJtbOIQoIThgTleDEjz719q
	HGUT2egwCDeX5Lpj0+x6rebJ1Ky+aPromV+BgOH/OKzyjaBffl+30XwtU96AcRe3AB4FvPXiq9E
	H14LXW4EAoCrhnIj+L08gsKbM5oC+QmT8gjEtMoqw/gDmVD/vgLWGi8N9GpOG9sZt7aVr19qT81
	0B3e6v9Ww8WeJuiWgWVFOcIDz05H7+qQGUlTqIsk2iigoIOExuxxgFCjpSJwhvTsuFQmSxHj30Q
	CPSlgIupupygH6O2ldkOpNfwb5UL8=
X-Google-Smtp-Source: AGHT+IFqrU0V5kVs+TCC64I17yPQZPoR+/rmB0ZAiKwFTKFWsdVaHH9xBGMrsABLHFk1fUDVIMmffg==
X-Received: by 2002:a05:600c:4f46:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-477c1103099mr430150565e9.2.1764676413790;
        Tue, 02 Dec 2025 03:53:33 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790ade13ddsm353207785e9.8.2025.12.02.03.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 03:53:33 -0800 (PST)
Message-ID: <53b24702-eb3b-4e08-bca3-70402eaf4db5@linaro.org>
Date: Tue, 2 Dec 2025 11:53:32 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] perf cs-etm: Don't use hard coded config bits when
 setting up ETMCR
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-4-22ecbbf8007c@linaro.org>
 <20251202114300.GV724103@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251202114300.GV724103@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/12/2025 11:43 am, Leo Yan wrote:
> On Mon, Dec 01, 2025 at 04:41:07PM +0000, Coresight ML wrote:
> 
> [...]
> 
>> @@ -746,7 +779,7 @@ static void cs_etm_get_metadata(struct perf_cpu cpu, u32 *offset,
>>   	case CS_ETMV3:
>>   		magic = __perf_cs_etmv3_magic;
>>   		/* Get configuration register */
>> -		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
>> +		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_guess_etmcr(itr);
> 
> I still think cs_etm_get_config() is better than cs_etm_guess_etmcr().
> 
> For ETMv3, we directly pass CONFIG to the kernel, and after validation
> in the dirver, then the value will be set to ETMCR.  If we already know
> the config value is consistent between user space and kernel, why
> introduce a redundant "guess" operation here?
> 
> Thanks,
> Leo

Because userspace doesn't always come up with the same value as the 
driver. For example right now in ETM3, ETMCR_RETURN_STACK isn't set 
depending on certain conditions that userspace doesn't know about.  ETM4 
has the same for TRCCONFIGR_RS and maybe some others. In the future, 
other versions of the driver could do different things as long as we 
don't break decoding.

I didn't want the function name to imply it was doing something it 
wasn't as that confused me a little bit. It's definitely not "getting" 
the value. Maybe "guess" isn't the best it could be, but it's not far off.

