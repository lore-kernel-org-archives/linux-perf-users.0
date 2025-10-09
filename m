Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8B20487E
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004160; cv=none; b=fHxEEN5znAs1zlzi78U0e49R1iaEMcv6kgukBzklkcDp2ICr0uvp1B/4WQngeUh3GzgpdumqDpkUimpux/Q0MmqzEBHZ1b0WepHQCPQIa0umR4TepQBjsJKJwZchD0agbQKbfxorA7ZBnQaKtRVOSLL+49AWY3PG64Olrv1mufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004160; c=relaxed/simple;
	bh=ah+BfafXi9ITpFPYOA7bDiAscAPKh7Rya18c8W5nnHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwR/LJitm+3sGBj3UmcADD/0kv+jmVQw+LnsJ5D9ftQAcjSN++DxAlzcldzNJOwxbudPbAuuuoakmbKbbwz8xcnovvTT6qnsa99p2LD8RcTDWfFbtyWkkCEKAeyKR6/Jr78H3O2T4FUi5RlMOlClYQpbCQwPO1XigTJAklJGIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PZo/c23h; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZo/c23h"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so8147085e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760004157; x=1760608957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2f/p58u5XFxpYSTCQRjfs244nlXyY9vgCtx1ygfs+Y=;
        b=PZo/c23hXy9OEttPMZfhWEcFsmKOvGDYpvmHdJKNr5kd2zYIt/rxHT48a/tb+f0usr
         m/buoeOAYxIBMf5SnPsS1G+WYaHWdZqoXDPtyAgSQneqzJF4ntATxlJlCSQ6EDrDTFBs
         AIfXdp4qOwngA3JK4n3Kli2bNZSRiQ57jIwH7acSkOs9X39w/VK1TQ1od8E9Htiqmox+
         la7yYy/sIbIhVlEifBU9wRbGiyMz2Kluc9XNZ4N3HfO2q4aZIXrAEWSC0X8vY1w7j8ur
         hewuKCYV9idRQDMHhJgeThDBQKbT24gCv0rdA7FLLkRl9QRkmjt1AvLFuq554shZ/63T
         9M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760004157; x=1760608957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2f/p58u5XFxpYSTCQRjfs244nlXyY9vgCtx1ygfs+Y=;
        b=dJTWTpKeDBA3eecFu1b23ARU7X/n3r0BCYMIK3JtdJ49hA+L9ubke041glRpyoOkBq
         VSG5vpP/a0S/W5QRMY4mCAuZy82uRwWxiyS8Xu1tCP8ZFOXn3v1XHvgO1Lil+LFIKVCz
         de6PQIHXg8kkNshPBf1h1K3DX2sXkI8nbIeP+RBJKJwx2C5vCbjuPkqFalA0woIVRw4N
         u5+RmfX2tsSelt2NVLX18FlYA0z7IEgB8Oox++uFTamZli0eElkkOO3PgPTdKjVXhYEs
         KsZFVB3aAM59w4D/hmo4c3TjzZdsl6twplNWhBP6p4Yz+ghsCJkhODawhm0fAJeu2Goz
         6ydw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Yw29BGl0+tVPB1qCjroOWXE5jk4YVp8lbWqm2pTIucjIj3rjrGi1GRjajqJF3VgfuFjI39UFtV13LqNS7+6o@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJI3RRAE0w94s866TO0Kle+OeOHGe1hsCbKDbD1P+kx4P53rt
	PzwBMAsL04O1bfwVtne5OH376waOY3cdujfRaPmeSyl+XXa/CeMa73hcqwzPvaKRBls=
X-Gm-Gg: ASbGncvfFSKiPSqiiCL/KaS9akfwoM8nXooWv7oTWX1HdjG0PJggDsdnW0aJUlPiV59
	Yt1FAu8bD+uT0na4gW49LutJrF33pDavszmTeePKMPj9cF+cf2BVMGFxpGiacRNNSmwWHglCOle
	O+mj1+CiZwWPPa4Oc6wQTyH09jZErReUKYfcHGmoO39ONViusAU5VD6ivOlJM2UluIJHiLbwKWH
	CewxCleAxMi3Xuel+sj/gg2I6I+UNnnaWr60s3gdfAe4/o0bDrzwOBtb52gq85UBdG7PYCxUQZg
	dCx/gDrsSwh0eH0N/yIaKG3VXfo3EYbO9TBHu9sUCOtaQdCFUWRKXD6FPyjheSRNnSKvTXiRYCo
	hfCrumPicRYKFh1vCRRFXVY6BMvr9Inlw3tRJZW+iph8ihUQBCPzqXHps
X-Google-Smtp-Source: AGHT+IGNBWZE6yne9v48Z53CH7yGDHH0Iq06THCD8hpUzG/jH90CPJxfETiLH2576v4ksUx86k7hqw==
X-Received: by 2002:a05:600c:4ed4:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-46fa9b08be6mr49207985e9.26.1760004157473;
        Thu, 09 Oct 2025 03:02:37 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8fdsm33519201f8f.15.2025.10.09.03.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 03:02:36 -0700 (PDT)
Message-ID: <10332b1f-f73c-4bfb-a4d4-74e1953b75ff@linaro.org>
Date: Thu, 9 Oct 2025 11:02:35 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/25] perf mem: Print extended fields
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
 <20250929-perf_support_arm_spev1-3-v1-20-1150b3c83857@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-20-1150b3c83857@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/09/2025 5:37 pm, Leo Yan wrote:
> Print the extended operation types and affiliate info.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/include/uapi/linux/perf_event.h | 28 +++++++++++++++--
>   tools/perf/util/mem-events.c          | 58 +++++++++++++++++++++++++++++++++--

Minor nit: I would separate the commit to update the header and the 
tools change. That way you can describe that it's a straight header 
copy, rather than something else.

