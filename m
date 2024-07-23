Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCDF15572F
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745701; cv=none; b=BHPww4M3KUrBItJJA88UljoveFOz5+z9q40OTM1jF05vmhq87yV1SknIo2C9XkLQqFBjSLJAiL3NnJrg3+HJUV8gCcfIPnNCMR7MwwChF+i/ahol20v1K15OUdOrYz/NKbh2M0WH6gvQIrM83n6xYQAhZ/8/eDZZjwdZ9Z/QR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745701; c=relaxed/simple;
	bh=NbEaiDQst4g8UDjxWI6M6LdJiePjTUEZujWHMsKuSZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=nd+LtB/WXxWDqF//wcZnQuiW2jISP2vudX37zfri78XbSv2sfSEPdgRzkpbsXx+Z8Ge/0nI/JEloPvZCf/qPJ0A66kJWBMCaAu/rSk6EVBXW+eZcFPZzf/Ery9msQ28dtwHIQ59lUOBmqU6RF5jUXDyZZdVJSDq5enDWptkQsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UUlZ607y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUlZ607y"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-368313809a4so2647873f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721745697; x=1722350497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIOexr2HK5dM1ecCil6EL5sbgVo35QTVfvVcIKxiQ/M=;
        b=UUlZ607yV65uI8Gr6d01gvsaP+fqUHUjq7laCrSaeh+V4lggYCCEX5tLBvdqUeHNZd
         q0JKbXiYtd4lg+DiYWSs/VxnOaoS8+OyNzVeJpkw/s6OMGVy6ksTNDgOfwHlIdIFfR8N
         fA+O/pzfsrNmXZa+58q4rdZwNnkUt+qgjleAzQkVHj64qZ2iMi0TCSFaoYkb0GuMye/2
         F2CDfIB2dl5rpIBIHiZ4NVgnK/zM76lkgmL+Z1e5CrDzBaErhu7T7xaSuPXGjS+K7+q1
         unDMb0OGW74XXdAJaxKlY9CN5tleMhYXxjO6/3qGcMmu7/EV2EvZApq8VIgmRx9B5tcF
         n0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745697; x=1722350497;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIOexr2HK5dM1ecCil6EL5sbgVo35QTVfvVcIKxiQ/M=;
        b=k+CXmxwYuxM5WCW9RHNrrDzhxsHGLJf4PBmDaF0icr4JOlqnMv7Zjl2ju/7KEyGGcL
         aOs3imBgvXFasTPeSTZGaOlAWnt7ISSoV5WD4cwsYPMa/vVY8SiA4CxmiSCzX8IVGPyi
         Xr6a3itt9PBLgSjA3kfD45yXUe4vrGvQmKEzmqnVe2nnsdbnfIGY7E+vMYZAvU/qauoz
         tEIyYtKyMwejDhpk4HIpg6Ncz9omyYEXP1L7MpzxAjXYeiWTijn8mNxclXIq00uPErjH
         GMvB6FMmzLnjqJXKfPu7ihQWPkQUHL8u+oxfAPaCr8U9sv6c5at9O6lmnS27R/SRBXoW
         RUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1lIg02g0Dsw0omBoEpP35nFFqNT6U/3LsF1n0kPlXlgML5NkUes5HNRrMGgD67OpJzHKUDcUapqJUGYNfv3bmQnmT7Z/mIoje6hLRQwHhIw==
X-Gm-Message-State: AOJu0Yx6eHrsP3dc1WiJHxGce17Hz2lCi5/DwuUrdD7J+8EuAd6ybQTe
	0e0iHfgm3HEGgiaEZG5RLquwBPeQAV6FSjzJZpnJTlG4NLXoKNF07mn98r0gpFw=
X-Google-Smtp-Source: AGHT+IFPo5g+XdIEqYzhL4PIJUoZJy8jgWDPHXQqC/+9lVWbvrAPNGr37qJ8eSbuaPLMzMxmKNtB/A==
X-Received: by 2002:a05:6000:4021:b0:367:8f89:f7c9 with SMTP id ffacd0b85a97d-369e3f2f62bmr1803268f8f.33.1721745697448;
        Tue, 23 Jul 2024 07:41:37 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ebd50sm11670456f8f.93.2024.07.23.07.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 07:41:37 -0700 (PDT)
Message-ID: <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org>
Date: Tue, 23 Jul 2024 15:41:35 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
To: Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>
References: <20240720074552.1915993-1-irogers@google.com>
 <20240720074552.1915993-2-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240720074552.1915993-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/07/2024 8:45 am, Ian Rogers wrote:
> Andi Kleen reported a regression where `perf script +F metric` would
> crash. With this change the output is:
> 
> ```
> $ perf record -a -e '{cycles,instructions}:S' perf bench mem memcpy
> 
>        21.229620 GB/sec
> 
>        15.751008 GB/sec
> 
>        16.009221 GB/sec
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.945 MB perf.data (294 samples) ]
> $ perf --no-pager script -F +metric
>              perf 1912464 [000] 814503.473101:       6325       cycles:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
>              perf 1912464 [000] 814503.473101:   metric:    0.06  insn per cycle
>              perf 1912464 [000] 814503.473101:        351 instructions:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
>              perf 1912464 [000] 814503.473101:   metric:    0.03  insn per cycle
> ...
> ```

For some reason I only get the metric: lines when I record with -a. I 
noticed this because Andi's test doesn't use -a so it fails.

I'm not sure if that's expected or it's related to your disclaimer below?

> 
> The change fixes perf script to update counts and thereby aggregate
> values which then get consumed by unchanged metric logic in the shadow
> stat output. Note, it would be preferential to switch to json metrics.
> 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Closes: https://lore.kernel.org/linux-perf-users/20240713155443.1665378-1-ak@linux.intel.com/
> Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than saved_value")'
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> The code isn't well tested nor does it support non-leader sampling
> reading of counts based on periods that seemed to present in the
> previous code. Sending out for the sake of discussion. Andi's changes
> added a test and that should certainly be added.
> ---
>   tools/perf/builtin-script.c | 114 +++++++++++++++++++++++++++++-------
>   1 file changed, 93 insertions(+), 21 deletions(-)
> 
