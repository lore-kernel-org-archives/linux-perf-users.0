Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D21E3784
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738340601; cv=none; b=VSlWXo5DmpD/kXtdvCtzJy0xNv3MbbSaj/UVT/1LpVtbrycp31sQMK9+N1nN2C3PQ9cyWgwxGwXsq5n+CxIbbWRpKEjRSnMBf/HNTfYCHPy/q3LRka7owSXrtTPWySrI3tT58FXGIR5vYW+elsSRIOSZcYQO5SrZ74xAY20vd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738340601; c=relaxed/simple;
	bh=XR5lx6T2OZX3TvgFfUCQ2wqoocF1737mUfcufcBWu3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixIfFtoc7lpbjfr5zO+YwEJTiO6XzKaHYqfEDT6gCrF/gIdEW9fluNDtD+hVpE0ZtLesbdtR5X4LUf/lZh8miOXV0tgeP4eymnF1Hvs2n41G3AGkIUWYPdLuFfZ7g253NE2h7pSkjIARLFIDphm4PrroOOgJaFKyaz+VSAxrKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vxxKAnKH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxxKAnKH"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1387544f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 08:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738340597; x=1738945397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccsQCvgWKqv3yygq/7Q/nlBWnWSWfZGyLmBYGuzRwP0=;
        b=vxxKAnKHC7G4bKKCD04ERw4VFCG+qDpfzIw8T5IhExw0kBfT5A3ksQ+YcPVtnAfgFK
         5Q69tOkwHXS0BQGfLl5++vpUDVqRb0vGoHxGdnSKA9yOpbhFfQer3qVAlwO91UiN68ez
         lYgOCvkiTAz0mnKl2/jWuRRyYmlnLU4o9orCRm4aPq8hq819x0SREQm8p9P4TiTEeyAv
         kvuhbnh/n/KLMIeXQPOuzb33Ub4r8RVNi7Jrf3pfn39D/nVDODSdTecNYKI3wd+C2M7x
         UuUQR+8s9T+DcTVOrJzlVTcOaYPpwyALmZA6oi9orncB2ZLwp9bPbsU/npJXJJgHYb9v
         hr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738340597; x=1738945397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccsQCvgWKqv3yygq/7Q/nlBWnWSWfZGyLmBYGuzRwP0=;
        b=ex/gTXqQXjjr8rcWmGwTOzntCQdCCtawMQDjCcxSHoCb+nObJHZEIgTq/BTbKOOFFZ
         aPBos1gAma3Mipi3GG4Wrc9YqcZVtPFU9bfxp/I8F8YXYhoBKRymbpI+gXjBYsUMY3W5
         Iql4D8RUCT+d84nrd8rej595wsD3tECgw3RRt8rme1EPbNzJmK0/DG3iWDmx4NEBXvTw
         Nd29uGyytk3IqBSMd9oBIAArtIQ4fRVaBC6MVdBhfM/IeDbURaiEg2vxNCUYZk6Ul5AG
         kN7SLoALKiVHgwtsnzWLXOsWCbPy0f9JUWNkgDOLPK3MUqHLi0vaKxYq51Wmlz58DwMf
         RWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTH9oJQDT38Z+t7VCSpZ57yH4+vzhnCW4NTWgHZMTgrPmqRZOrnf+xhCDKdyzaM8Vb4Giy/K1ulhb+Ra3bHs/s@vger.kernel.org
X-Gm-Message-State: AOJu0YzPs75GxKuTnyncOVHjRMyL3kRldmcZoFmgXAYbrgnHjwxFlujx
	kYLNlwfSENrBBihsHfGzmK0S3QsMTKADC7Fd/nDeZrqngvnel88A8u6orINjJPE=
X-Gm-Gg: ASbGncvKxJ48Qm//8BpGOtB5Q2+MgDyNJ27bp10wXoo3X8bWxBa9amohfhSUzFJqZKP
	Rpb5iBLIP6E5JUOggCwJU1OB7jJO7x8rMRef0wveKYW6XLa7BFqvvowy9dkGeFrA5IPbUzApRCg
	MyxcG7aV5KR8aJ1dVqgpBY+n8NIyB3xZTojrd16r+uTI/B2TGlbH0IwcPq56+Fe4Ke2LEf5Tfur
	oV0v+JrnHWpTgUww2DXF/wX5b4u15v/+QHh2PLggahqrsRqh7XjP0bvzoteBALmaCkGyJcaetSa
	MP2Tw0Za2DB3fAEj6MfWuzdw7Q==
X-Google-Smtp-Source: AGHT+IHjR1HpSI+OxXVo1rJx/d3HvscdknUv4GZNTW8wQmSNUAcS/oELkxUcnST2xhCMAatVE56veA==
X-Received: by 2002:a5d:59a9:0:b0:386:4244:15c7 with SMTP id ffacd0b85a97d-38c60f7788amr3570705f8f.25.1738340596916;
        Fri, 31 Jan 2025 08:23:16 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b576csm5113346f8f.63.2025.01.31.08.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 08:22:44 -0800 (PST)
Message-ID: <0ee49250-47e9-4719-898e-644b30ef8585@linaro.org>
Date: Fri, 31 Jan 2025 16:22:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2 v3] perf test: perf record tests (114) changes
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
 linux-s390@vger.kernel.org
References: <20250131102756.4185235-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250131102756.4185235-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/01/2025 10:27 am, Thomas Richter wrote:
> Change event intructions to cycles for subtests
>   - precise_max attribute
>   - Basic leader sampling
> as event instructions can not be used for sampling on s390.
> 
> Thomas Richter (2):
>    perf test: Fix perf test 114 perf record test subtest precise_max
>    perf test: Change event in perf test 114 perf record test subtest
>      test_leader_sampling
> 
>   tools/perf/tests/shell/record.sh | 53 ++++++++++++++++++++------------
>   1 file changed, 34 insertions(+), 19 deletions(-)
> 

LGTM

