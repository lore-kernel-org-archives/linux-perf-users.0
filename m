Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9EF3538AB
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461444; cv=none; b=O1XEDcUdoPDSE2aS1UEyUEMalLl7r3zuqHf2qd4W3Jz2Ci6T+RjMigpbj+AM+KJP5Pi9HlK6G2Sijur1B3YgVWi6OBVY/UUpjc6QnWaB7EuQMz5QSb7pjJseXrFtXE6+CNbl3FOFEp6SNE6/ZEOS2OWkbiROAG4dpBPgZJJ3W50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461444; c=relaxed/simple;
	bh=WhMRrCkmpgc2rk9+kbhIqGkcR1BcKiKDN8A9eEcBf5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0uWges/TeNWKNn4vFglzsDEAS2C+dhpyf7NIn4TYGHo46LIZBgaK1Fu3PpgNrdDDzH9FaMVZgMr8uAjOc0p2P2whHvLbWM26GFh2SBmQKH0ljAZxrY3Wmcj4TTx4FvJPyMR1DKHiHDBruBT3KWyShSNUYLNRKeVK0+tPNgxUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovvtER+X; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovvtER+X"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso20582235e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 02:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763461439; x=1764066239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IRe7Y8ocCSJA6puSivlnRO41KrL1icg2QDSVsxKnu1E=;
        b=ovvtER+XC8z3MA9cH8n/AoyX1wrQIirHYDSVLf30CnvrWjMSq1VfuesHk4R7lbLiMX
         P0d5tQnGWFAIVndDQLxa0WGzzsz1OeC96trZoZuq+2jxA2ileX8DePOreae8aFymS4pe
         tlU/lrnuSmU1/bfNOoCfY1Wbrj25OouZ4/vWz/9hgjk/1uh1H8B4Lg2s09C3FMnuVwNc
         kzotpe2LzjBde/lHbOrVfyYttGBZQsZgQH/XCfhldFmgW1/+wmK90bGBGeHUq8WrH/Wq
         xgT002A73ChOXr22t99J9npTpeLW4Zikfx9Aevq8eRWo3QD5AJARZ3Np+PmpRi/5aVij
         bqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461439; x=1764066239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRe7Y8ocCSJA6puSivlnRO41KrL1icg2QDSVsxKnu1E=;
        b=KJRWcXJkwp2j/7FIKyNC8kJ18X4x78tkYBNoIuutbYEOULVyXsa+sV2q3l51WPuLdh
         zzflvndyHbyEVBQtrA1wO2CGHFSYmWBjRHt9dRASzlYo9SCET/ftyL+1ql4zbotaEgkM
         4Umk8baKmpUTLGIbG2PF9fyVczlhLtNGTAjFcouHITS5/PPdoIfVGDgbSfTXVBBgd/no
         gN38HFlYHICceeEjUywtI30B90P5QTQns2dwm17Fi1fkX7XIhzdSiJvC8H4XTPXp92XV
         YsWB9YdJyAAR2Zlpo7SCpif2RC2uF77LIXCSzi46nTqPMAawfMcbY343qwHWtENkdRFK
         TxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNOuRDom3W4Jovk1VCIwOyo/71JNdlC5j+E/fjvLmgyMrDA33Kz+P7pLRokfTiUV8zp9g+CFy6RwoRI+I6XDcP@vger.kernel.org
X-Gm-Message-State: AOJu0YzswI609dREigQsOocrVbH0Qu+3/MvFrf6/+YbilBuekrzwJoRh
	/Z7smNxp+0xfoG8yONtjjKjsOv4RrCXnr8idCj8fDrUZEHvhdwJS97z+uGNpIfpT6Cw=
X-Gm-Gg: ASbGncuabEskgM+101jh0KrzFDk7pbNvQP3v9VGvsBM+y2DxmyrjAnQWXTTKELMRDKU
	+a0ULZMSxiZ3gcsPPunb8+ZZEk07veldD32SDQhAaCkT0oJHcFjwFNcihkLFhVmdIr/eNndLXb0
	S8yoo8ZYB46sYRvxDYyMSB+7G7xeG+7XWsoA7h3GhZjMjgTJZFEbfk3wZHscy/ZpFfNLiCoNQEu
	n+THDSNexXF74zsdk8NVhQuaNzvSCmkAKQ7HuDRUw8+R8+Tb0FbdXHbdeggnhDIFwwB/jljegLm
	Qo44iQRb9JyHrHKICpP2jCK2UdT3TmD5I6oE1gsQZqO6j79P3ox4iYFtp+y2SN1F9eSLrrBbtPL
	RCYL+uafEwXlrxGrjSKKSFjFjKC7W1AtwD0oOuGVJEEiyTZ/ynsGHxDVeKdyXUPSUL3ruanK9IH
	eD/YKt7Apxs+z94Zr714wqWnQncfm1wXQrTeCMow==
X-Google-Smtp-Source: AGHT+IHByaXCWxWKXsSKTnDrpBen1+oA5DT4UG+T31+rRD84A47jeCA8TubUZjv9qKUynHDVgn28Yg==
X-Received: by 2002:a05:600c:4695:b0:477:7b9a:bb1b with SMTP id 5b1f17b1804b1-4778fea681fmr136415065e9.32.1763461439369;
        Tue, 18 Nov 2025 02:23:59 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206e2sm31548043f8f.41.2025.11.18.02.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 02:23:58 -0800 (PST)
Message-ID: <ed4a5e23-f2f0-4f02-8b0a-e97329cb313f@linaro.org>
Date: Tue, 18 Nov 2025 10:23:57 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/25] perf arm_spe: Extend operations
To: Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
 <CAP-5=fXiiWRDPzONNNZQZc4QOBQoz=kRnJq77on5r4w9aDx-XA@mail.gmail.com>
 <aRrM2y4O_3aaa2Ee@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aRrM2y4O_3aaa2Ee@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/11/2025 7:20 am, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Nov 13, 2025 at 09:01:47AM -0800, Ian Rogers wrote:
>> On Wed, Nov 12, 2025 at 10:24 AM Leo Yan <leo.yan@arm.com> wrote:
>>>
>>> This series enhances tooling to support new operations:
>>>
>>>    - Support for MTE tag since Arm SPE v1.3;
>>>    - Support for Advanced SIMD extension and SVE operations;
>>>    - Support memcpy, memset and GCS operations;
>>>    - Support extended operations for atomic, Acquire/Release and
>>>      Exclusive instructions.
>>>    - Enhance the data source for associated info, like floating-point,
>>>      conditional, data processing, etc.
>>>
>>> This series is divided into three parts:
>>>
>>>    Patches 01 ~ 06: Support raw dump for new operations;
>>>    Patches 07 ~ 17: Export the operation info into records, so that the
>>>                     information can be later consumed by samples.
>>>    Patches 18 ~ 25: Set the operation info into sample's data source and
>>>                     SIMD flag, and updated the document.
>>>
>>> This patch series is tested on FVP for native parsing and x86_64 for
>>> cross parsing.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>>
>> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Can I get some comments from ARM folks?  I think I can merge part 1 and
> 2 before changing the kernel interface.
> 
> Thanks,
> Namhyung
> 

Reviewed-by: James Clark <james.clark@linaro.org>


