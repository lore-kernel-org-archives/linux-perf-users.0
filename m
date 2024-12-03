Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF11F706B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Dec 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236625; cv=none; b=L3f9BX8rxhIO2nuWFQZtB+P5P3UnM4AAA9e4Djxn/BgdaqA/v0zEjXidvTKH5q0U+YdxiOgebwfEMwU8XRtvAU6BYbXJ28jh3iUiUvfwV2TERAqMGHB4uOV5vHy0a7up9WeSj0+u9jOpNzhzdnLbwusS0ru2+pJ9kbkCCQllYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236625; c=relaxed/simple;
	bh=bpRIxTujv7Q2Gp3OWlV89fp/ycxERqxYMWMleI8UkMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djJBWbGMEDOwMUSiOp3exGFTppUbjwLkm2HJePmScin09+WJUjBKDUIRVFdoqKdq2tSnOBa8oJJort+bjV1PCN7Yo4YsW2iKmZJGS0WGOdoREliNIKlvyynylB2UMw3i+n6aI+XLiTZ2K02JTxlA/r9v5r6k9R5AcvVhYoN4imI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ykvZ4U0u; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykvZ4U0u"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa545dc7105so874159166b.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Dec 2024 06:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733236621; x=1733841421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBs2bqNxoIZaAZ+QacZkhFhyWnJZa9yQ3yMuyWrLncQ=;
        b=ykvZ4U0uq96p/NeSE7FnvhiHlb/rNhj5meCsLoUljrq5n1YESKc0EZya9EHSJmtubz
         cVkxB7cIhN11srGYVc5daLZ/0MUQmUCnEAsrI1wohUzUWZa2kdxGZsMw+W6tyoy7cEWi
         LUGevnAMKhp4HZtJvUksfvW/cKZY0506N41wtmeP/1qU6J9c+LfQFlyxg96L6P0XhWUI
         2hUozs7B50JUt4nKUemrBQBzc1sFOd8V92qlUBkHkESY9CXvmz3pr2Ra8u2KGBayshT1
         KbICRg6C/TK38oBPWQhTLhPXtBv9bpVJz0s8Dky9L/WNx6CBVMF9aMRLDAhe+cqfwvmJ
         YZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236621; x=1733841421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBs2bqNxoIZaAZ+QacZkhFhyWnJZa9yQ3yMuyWrLncQ=;
        b=TXj9a1zY2bIpZZE9LjZZwNZjLWsvfifyDqUOqkY5iiH2xSzcfU8O8rjnk/Swn96f6Z
         tlu4ZF1zgSZJ2DWxgoWqLlnBdr/uus5g803r4j4ybAJi1cdsQ+GOCeMx4hfSJ1wwiMyH
         zeEgZbS7JePm22o55wSKkMbM6GT9io370ak7BaAvWxVlcifiCCmvuqBSOp5yfryrJWWL
         It4gxKkFPAf9eoDyVjEuQsdZC+IKyuCVVIl6x/effrnWTjKgWh0OHDT1a+RetJIPqgqK
         +Cw3Cfp6/YHGv2LReMG5xPHsSOvislewOpZjN1emuPMkTv9E8C3P5g3056TNY9mMuls2
         B8dg==
X-Forwarded-Encrypted: i=1; AJvYcCUayhGuZ1c2e16D+4gcsedHCTpc1irc+AyjbYAWU8pTZqxNh6IZShW7L4LLF3ZbOlmXd6UVz6M5kADksXj5Ylts@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2XzWeq/9vTTV/28D+53yXKlP3cN191OcVlsEGZ2MI+FMRCMk
	LXdAZaq1UG1a9q1rkxYqzNUx/SAOsX37vEMPpVDMU4JCi2zzHIWcG1Rp5L5LYxs=
X-Gm-Gg: ASbGncso/K3uj1tOjEmTxKf6ARz/vGJxlXVJ2tiQ0b05NTznQxWdhr9IoGKw0OgCAQW
	F3DEl3oB7wwdnXeDXGPoj0+ix8N1oP54LfxnhZuRQudGSdK4U0YoTrUis1u3RR7NVQaEbgmthU2
	R+eCozj5oraioST18rPCzZZdMH2nyFx0GGRv7ieYgqf2BgC1hYntV3OhYa6XaYfQZ5YK5EWH4wM
	+I+R+bfY6LrllWyB5PwTFO/Cy0wXjb1Zw7fSaxXXJadzqVGt9uRTqJee6PM
X-Google-Smtp-Source: AGHT+IFWFXisc3O0IBOI5cxiXdMDO/YH4vVbsBolwektVRaIz+49XfjW5X6tzAj6IAAVLBD7MYDeoA==
X-Received: by 2002:a17:907:7854:b0:aa5:358c:72a7 with SMTP id a640c23a62f3a-aa5f7d4f3bfmr241397966b.21.1733236621435;
        Tue, 03 Dec 2024 06:37:01 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d55fdsm616522766b.55.2024.12.03.06.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:37:01 -0800 (PST)
Message-ID: <8d6d43d1-51be-4412-829a-ef5875321f5b@linaro.org>
Date: Tue, 3 Dec 2024 14:37:00 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Perf test 7 fails on s390 since 6.12.0
To: Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>,
 "linux-perf-use." <linux-perf-users@vger.kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Leo Yan <leo.yan@arm.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>
References: <12338ec9-51a0-44ef-b2e6-4a95d3bf0e4d@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <12338ec9-51a0-44ef-b2e6-4a95d3bf0e4d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/12/2024 2:53 pm, Thomas Richter wrote:
> I just downloaded the latest kernel tree 6.13.0rc1 and observed several
> failures of the perf test suite.
> 
> This test case is the first one:
> # ./perf test -F 7
> Unrecognized literal '#system_tsc_freq'  7: Simple expression parser  : FAILED!
> #

Hi Thomas,

Did you see this thread: 
https://lore.kernel.org/linux-perf-users/0F805B2F-35CC-4E0C-BD2F-84552C4C528E@linux.vnet.ibm.com/

Is that related to your issue? I looked but I couldn't find a V2 from 
Athira.

The same test was also mentioned on "[GIT PULL] perf-tools changes for 
v6.13", but I can't tell if it's the same type of failure or not.

James



> 
> # ./perf test -Fvv 7
> --- start ---
> Using CPUID IBM,9175,705,ME1,3.8,002f
> parsing metric: 1+1
> parsing metric: FOO+BAR
> lookup(FOO): val 1.000000
> lookup(BAR): val 2.000000
> ...
> 
> parsing metric: #num_cpus
> literal: #num_cpus = 8.000000
> parsing metric: #num_cores
> literal: #num_cores = 4.000000
> parsing metric: #num_dies
> literal: #num_dies = 0.000000
> parsing metric: #num_packages
> literal: #num_packages = 1.000000
> parsing metric: #system_tsc_freq
> Unrecognized literal '#system_tsc_freq'literal: #system_tsc_freq = nan
> FAILED tests/expr.c:252 #system_tsc_freq == 0
> ---- end ----
>    7: Simple expression parser         : FAILED!
> [root@b83lp65 perf]#
> 
> I bisectred this to
> 
> # git bisect good
> 609aa2667f67c1588d4e741110265f74b7713177 is the first bad commit
> commit 609aa2667f67c1588d4e741110265f74b7713177
> Author: Ian Rogers <irogers@google.com>
> Date:   Tue Oct 1 20:20:12 2024 -0700
> 
>      perf tool_pmu: Switch to standard pmu functions and json descriptions
>      
>      Use the regular PMU approaches with tool json events to reduce the
>      amount of special tool_pmu code - tool_pmu__config_terms and
>      tool_pmu__for_each_event_cb are removed. Some functions remain, like
>      tool_pmu__str_to_event, as conveniences to metricgroups. Add
>      tool_pmu__skip_event/tool_pmu__num_skip_events to handle the case that
>      tool json events shouldn't appear on certain architectures. This isn't
>      done in jevents.py due to complexity in the empty-pmu-events.c and
>      when all vendor json is built into the tool.
>      
>      Signed-off-by: Ian Rogers <irogers@google.com>
>      Acked-by: Namhyung Kim <namhyung@kernel.org>
>      Link: https://lore.kernel.org/r/20241002032016.333748-10-irogers@google.com
>      Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> 
> Note this test used to work before on s390.
> It now also fails on the 6.13.0-rc1.
> 
> Any hints on how to fix this? Thanks.
> 

