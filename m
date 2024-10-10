Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC71CBE84
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568444; cv=none; b=u1BrI400BlZDOZ5cgKDkHTo6m61dfjagw6oKoRJxF+gKe1KLnw63wcO4hMwPoDTz2ZwELbFHMeObNHrimJOoGOV+J0UDl2fIdcCd6QF2B28xvi9YGs4mh3qj9fCeaQRCxb7m8IMtp1HPwrBSr3IFhJtKCAoG1Fj0IdOEceZMlPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568444; c=relaxed/simple;
	bh=dTGt2bI0gyh+oBaFQS/4t8rtm86wQQ3TxyuWTkzVfZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Ao6uTniJG3gp6UZB4FkiZS84A2/l9pM/ckvVo7WwaypbQ2MsQE1UKC8DMDcvD7GiefZaXjUQR80nv4d2ZspyFUl5+qIjZxLDEI/TmzOiCls3nkGme9kPGQUl5t1qfP/ycsEAPDjNas51F65eYO+oR35UTYvihp0A+gDwt2kMUVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ulp3W3BW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ulp3W3BW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431126967d6so8403645e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728568441; x=1729173241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FQ+lXA1ihTUNLFfhxZGOzBQbePHSGXZjeXL0lolEF3I=;
        b=Ulp3W3BWvejVKJHOQCiKTGV2HerPmcOjujJN/05yBf7xxMhN7U5QkexjwNW3N7YIWJ
         X/lKaJRM6Yas22BTbqUJbY9D32ok1Cmfk2iEy8Wuc7gnvIElNBgWFPEJ5WmQkmF39oQL
         2iU3kgOEKRrpuHKwARbhYlymZh7mMrBRMcvZSgoMHVXYyt5bh8XEEUfkZL4j9Jx51aba
         agHOsbG+CYyDRZsGFIkABLyuo0ILf2B64DL1bOWiXcRCLa/8OpGoIO43HI9haNdVqnq7
         9IYCMYwmVbr4VUdxRrj/8gxQBUEQDnQsCt3t/VqF9hO2/WZbgN/GCTvcnuW3ckWnMaXO
         CcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568441; x=1729173241;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ+lXA1ihTUNLFfhxZGOzBQbePHSGXZjeXL0lolEF3I=;
        b=Z6is2RsHOdN41XeR/lcjo5MMeAGJ9Cdxz4pIDns62Fl7bD/TxWP8cLTXSYiIMPag6v
         2fhIdQzmByldD+HR4k+tW1jgByj+ZH0N+8hYWCIlv+1YDhjhFnz5w3GDVlCk1cV8+HgD
         QE3qEs6iFEqzMXMn9HBJUZgr0HHTdU+cl1T69CVjxXGpqQK0DDcUgC7jHCwHTGbVnKFM
         zuyaf1m64Z9yZ3HnBYi1WxIGynfiFFyZ16YOKqZYUsyvCfHU2YB3Iciouv4BET0KiNSv
         M3ORRPfsrocX2PwSpi4MpXWklsUJv5jVbfpeN8KHCHyRDtwpIjdaFIjFOlCMyGBooroC
         Aq4A==
X-Forwarded-Encrypted: i=1; AJvYcCX+YJTGTcx6tirv/Stv0rJDE/SsXhxz454uxpj8fVYoAqb8JBtW9hwF2M1lhUKE2qayi4kLi0jDhe91D1AoC2ML@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3aroujy9Pk+OP2Je4aCIdwdUULZxuPuZ0Bdj8Ah3YRt+OP3J
	zjMQ0R+dJXCSEYFTBhA7n+swT3ICbLFoyQNw8WXTUpex5AsScFIAEzM5odUIey0=
X-Google-Smtp-Source: AGHT+IEdRXm02gGLxzgcUClMQgQcHA1G5Jkg12qeADvg1mlzE0X3heEKupNW6VgMBZK9gKBRD6jzJg==
X-Received: by 2002:a05:600c:444c:b0:42c:b037:5f9d with SMTP id 5b1f17b1804b1-430ccef633fmr58186915e9.3.1728568441321;
        Thu, 10 Oct 2024 06:54:01 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd03fsm1622763f8f.34.2024.10.10.06.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:54:01 -0700 (PDT)
Message-ID: <58043fbb-81e7-4cf6-bde3-0464df9f6050@linaro.org>
Date: Thu, 10 Oct 2024 14:54:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] perf arm-spe: Refactor data source encoding
To: Leo Yan <leo.yan@arm.com>
References: <20241003185322.192357-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Besar Wicaksono <bwicaksono@nvidia.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241003185322.192357-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/10/2024 7:53 pm, Leo Yan wrote:
> As more Arm CPU variants (not only Neoverse CPUs) support data source
> encoding, they share the same format for the data source packet.
> 
> To extend supporting these CPU variants for Arm SPE data source, this
> series refactors the code. It converts the Neoverse specific naming to
> the common naming, and then based on the MIDR stored in the metadata to
> decide if the CPU follows up the common encoding format.
> 
> At the last, it extends CPU list for Neoverse-V2 and Cortex CPUs.
> 
> This patch series is dependent on the metadata version 2 series [1] for
> retrieving CPU MIDR. It has been verified for per CPU mode and per
> thread mode on Cortex-A725 CPUs.
> 
> [1] https://lore.kernel.org/linux-perf-users/20241003184302.190806-1-leo.yan@arm.com/T/#t
> 
> Changes from v2:
> - Rebased on the latest metadata version 2 series [1].
> 
> Changes from v1:
> - Dropped LDS bit checking in data source parsing.
> 
> 
> Besar Wicaksono (1):
>    perf arm-spe: Add Neoverse-V2 to common data source encoding list
> 
> Leo Yan (6):
>    perf arm-spe: Rename arm_spe__synth_data_source_generic()
>    perf arm-spe: Rename the common data source encoding
>    perf arm-spe: Introduce arm_spe__is_homogeneous()
>    perf arm-spe: Use metadata to decide the data source feature
>    perf arm-spe: Remove the unused 'midr' field
>    perf arm-spe: Add Cortex CPUs to common data source encoding list
> 
>   .../util/arm-spe-decoder/arm-spe-decoder.h    |  18 +--
>   tools/perf/util/arm-spe.c                     | 135 +++++++++++++++---
>   2 files changed, 121 insertions(+), 32 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

