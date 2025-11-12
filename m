Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EED7B3E1
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939295; cv=none; b=jfAZQKrC9ECQ2KIlisMiiTcktfR6buCWVMHYgGmd9w2RTKpUEKAdYIpII8i5O6/+wUowPl+WzNNLIit30sJgOdIoN5Kgtb6+6mySHRtYXR3Rm2y05ZFDjV8T4t2+rXLUB1NKdhTGNm+XLcfWhdJAQICcPnk8P9mmwNx8QjLHzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939295; c=relaxed/simple;
	bh=mHUEJ9dFxjdIsQc2ajIBdyiHVVcQa57HOEjifIA99SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dqbpt/5xun0mjChCsxPHAnPu3gb6GaLfbHxklrA05Umtdab9lHqXnSYtjVc0Z0NNl0V3x5jTKvhZkJe+J/rKALZXuxJpMdzqYjPCHFiWP4iG1FfF2ALND4EzMjSzmIV3idTB/t2jSDTlK5rblbaErHg4jl/K3C+oOaRBO0uLnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vUYXxIIo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUYXxIIo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710022571cso4853725e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 01:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762939292; x=1763544092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isJ1f7GA11vhD0tZY8DcYtbxrZ+tOnHfUKfDqQgIdJc=;
        b=vUYXxIIowwiO4tmCofem4QeembsmQjG80XV7yc2aMHR1CBEhKwOliP3OfewG8Q5TNl
         8FTRzYF0iI0qtXu8USmL5V1KUxUWo3RtttTdz0sowfYHKasPWpd4j3ocpvgtmG9l/hk/
         aVvIadVqWTPNwGtZL0mxtDHoMlQxOpVoy5vgU4p3/6fczeznrv1L5zaiVC5Y+2rPD30j
         0O59I1mZ2nToxTY3JSipEHV68MzE6UZ1rEJplrw+yqTZOso7oXzaNIkQUYOptLkcdouW
         hFhHvsWR4rOdrW7xrh6nIgp26B4JroY8GGAxeoeP5fkXqHy8jEtjI+lD2QT7BablVqU1
         Tdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939292; x=1763544092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isJ1f7GA11vhD0tZY8DcYtbxrZ+tOnHfUKfDqQgIdJc=;
        b=L/+qXRy0kkFl57dFK7ksXkIx7E5Hce5qq/S3bkeAgAMp1p0Sd1JybIbAUJTE3SzNSm
         2uplMAH+UuKi4jORsMwGu1PBLyrLyziFBB1d0Z90zSgVNTM1BmOSzN1sIeENjZev7JAm
         y5dMrxkSeG3atOUZQg/1ywmvL0p8z+t5n6XInUm20Uz6gJTDY/V0JUMkd2Z4wJw1zS1K
         2hAiDrCFkTmUjeElsUqQRycXWDL8kyHNrHw5RIAne5gxt4fPlNqDAh+mzld6kwsWWyfV
         3p2Okekuy38vdUqw8qmqDsnLXvwebOb7RCvVlPckX+N9nqPzd95FcZeLsaRFR7pp8+kJ
         zSAw==
X-Forwarded-Encrypted: i=1; AJvYcCVAkFwX4PTYwNdE92UzBj35lobw3USkk8uI+5lz5NWwgXgWunlfjXYhSDDbgA1/HVcRHvT9VR/kNEyGXqyiroLQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNIf/CZlXbZsm/T+VEy53sFJ4UcPLzCKmsnXLUlhFucPnB2Pe
	D99C2R2Jn48GbLSdtDeXT7ejwfjVZ0rBe85eVeZdSHBfBnl1WHbq82qjwGGFJwXpdwc=
X-Gm-Gg: ASbGncte4DzKLX45di54QRYdqljWpjtst6srUpu7qUdmUXhOtpiuWlhGdbh+zQgOASl
	oUrh8M7z/k/SUIgdV1sSYuSg7sIJ7lV8KSWc83jwjKohAA4yc2KzFptzF+XpUFzkGk/y0dWLjBE
	mbWIZ3ha9bpVX0u2Uvn7MziQKvxR9jaA/Kdwr8ZomYlOUDT8yEt1/DxZFlVBWplShw+Ty9u5tlw
	yOT1bSft70Kuk90Yy/XGtsNOGYjO0y9vz5KVPMbX0On7fV37v7VlJYyOzQGjRxRkDFj+DeCE10r
	079itLnDSX/aySXLuaLE4Isq1QIoObitUycC1DIQtckWaC8SP+qqC3R3wtDvQLY/5g7nF0hcXym
	YL5gbFVIEWDVLV/6ejqPqHlOKQl+9x+Y6Glim8tsC40auYrLeo4uD6D1GqhFfrarbZejmZ/Mvqj
	WHkmpi8A==
X-Google-Smtp-Source: AGHT+IH19B1p4+2J8cnMXiWHY0YRtV67T+2IEhayNx6bLOI1rTnsrziF09BOz3EDGz+wy3KJavPJ1A==
X-Received: by 2002:a05:600c:3b90:b0:477:7a1a:4b79 with SMTP id 5b1f17b1804b1-477871e9565mr17896305e9.37.1762939291619;
        Wed, 12 Nov 2025 01:21:31 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b330f6899sm21364157f8f.21.2025.11.12.01.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:21:31 -0800 (PST)
Message-ID: <9008f2e6-d2de-4765-b824-cdd6a1175794@linaro.org>
Date: Wed, 12 Nov 2025 09:21:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] Remove NO_AUXTRACE build option
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Tomas Glozar <tglozar@redhat.com>,
 Quentin Monnet <qmo@kernel.org>, Yuzhuo Jing <yuzhuo@google.com>,
 Blake Jones <blakejones@google.com>, Charlie Jenkins <charlie@rivosinc.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Athira Rajeev <atrajeev@linux.ibm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Collin Funk <collin.funk1@gmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andi Kleen <ak@linux.intel.com>, Howard Chu <howardchu95@gmail.com>,
 Zecheng Li <zecheng@google.com>, tanze <tanze@kylinos.cn>,
 Gabriele Monaco <gmonaco@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Markus Elfring <Markus.Elfring@web.de>,
 Colin Ian King <colin.i.king@gmail.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
 Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20251110013152.3099080-1-irogers@google.com>
 <aRLV50z1L9A3YRFF@google.com>
 <CAP-5=fW4XSL_tAD9-BzG9ceUJSr005bWi3Q1-kiJ_xyiHJZggg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fW4XSL_tAD9-BzG9ceUJSr005bWi3Q1-kiJ_xyiHJZggg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/2025 6:01 pm, Ian Rogers wrote:
> On Mon, Nov 10, 2025 at 10:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hi Ian,
>>
>> On Sun, Nov 09, 2025 at 05:31:47PM -0800, Ian Rogers wrote:
>>> Switch the __get_cpuid feature for intel-pt to use the provided cpuid
>>> function in perf, this removes the need for NO_AUXTRACE when the
>>> feature detection fails. Remove the now unnecessary feature
>>> detection. Remove NO_AUXTRACE as it just builds a more broken version
>>
>> Can you please elaborate what the broken part is?
> 
> Sure. I'll summarize what alters in patch 4. NO_AUXTRACE is
> controlling 3 main things:
>   * set up of aux options for PMUs (code in the arch directory)
>     * ARM: coresight and SPE
>     * Intel: BTS and PT
>     * PowerPC: VPA DTL
>     * S390: cpumsf
>   * support for decoding aux events (common code that can be
> cross-compiled assuming other library dependencies are available)
>     * ARM: coresight
>     * HiSi: PTT decoder
>     * Intel: BTS and PT
>     * PowerPC: VPA DTL
>     * S390: cpumsf
>   * Tool support for aux buffers (common shared builtin code):
>    * perf record: aux options for events, snapshot, aux-sample
>    * perf inject: aux events will fail the entire perf inject command
> 
> So somebody with a NO_AUXTRACE build would generally experience a very
> sad perf command. Having the option made sense when there were feature
> tests that could fail, but possibly that should have just controlled
> not compiling intel-pt. Having the option is extra burden on
> developers/maintainers, as shown in my comment:
> 
>> This was prompted by needing to make a v2 patch set of:
>> https://lore.kernel.org/lkml/20251107170712.2302714-1-irogers@google.com/
>> due to a broken NO_AUXTRACE configuration.
> 
> Somebody may have been using NO_AUXTRACE as a proxy for not having
> some library, but I don't see that in the code. If this is the case we
> should add the appropriate feature test, ..
> Not having NO_AUXTRACE may have been a bug work around for someone, in
> which case we should work to fix the bug. Again, I don't know of this
> case and don't see it in the code.
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Namhyung

Seems like a nice simplification even if nothing was badly broken.

Reviewed-by: James Clark <james.clark@linaro.org>

