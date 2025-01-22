Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB67215163
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564447; cv=none; b=E6451p7P1iHWNaCR8DBc+lQdxEaa0RkWnQp+NBtru8e1Xod5g6BpzTA1vDgyc3DPhdXLSU8xCS7gpOr1XiQ7IkoS93VhbRRixMx3nlwu457lH9t6O/0nNwEXbiEJ86JdvY/O2DIpg7VcfUqtB3FqR+u+f+i22YWJWQwvFUT2psk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564447; c=relaxed/simple;
	bh=E2//rgTIluA10/JpvJzNsDpQWnlRUgYdqqiql0a8aOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGnCmJyW/r9I4asQUnxpe8QtvYVmBTG9TD+kEAYuLw+fv6Ryw05lNzM/MODAWkzfvpCctPqdikgJMbyN0chiONLGQ0nk/qAJ97KeffR7L3KWpvAmViE2Apk+M/CN9VRAneQ6mMUFgfPtwpjpmuyXLlKH5SFw75O7GJ9mvqK1GuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZxTox/az; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZxTox/az"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e06af753so3589145f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737564444; x=1738169244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSBAii7BK2gaCNHWIIUjjrclWZDFTKQN8taZzBleOGc=;
        b=ZxTox/azYSDcSyN7l8zfAsg0ypW3EnPJx6yGFa+XA8zHjdWDmQLDQ/IlXtbc7Pwkbt
         1qMWduz8cy88t9FKz7eJTv59R+O3yL3PJxudRGWeBpL1AcH+JlLnYbm1IO3GU6eAv7nP
         rXO2s/Ga27epzkAqtIm+w3aRuAeseBHoGEsopqcS6DkTNJ6LVuYl+GVbSXtFC6OXt468
         RmePYy+dbluMwWrPWWyNGdFb+Fy1bBYVWY+exXKmAwzR8B3xGSXhVnnrA6sWU98L6HYs
         SttSH4ws6RxRLoqNhcqN+HB3c9EIApMGdEDFx4KhKQHQNgKrkeCi2AAyLaf/wvhJRzME
         XV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737564444; x=1738169244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSBAii7BK2gaCNHWIIUjjrclWZDFTKQN8taZzBleOGc=;
        b=wJnb2Lwvtjy03rV/4nN8eHQEF2szaVAZBXqpfcbG9j2Ywkfe4Lg8zD8JtVEyeP2Dto
         69KIM8AWJrTPiMVRYapWIXPSHeOi1Tcn/SOMzhZRO2zEJKZI0lCaRYE8tSqF29u3ZUKC
         6p75LXuQe8KhZEEOjnuKKqBOGI5NFDMnpG8i/5M+/96IJAV7iT16LqAd79ZLEdlKfBWM
         D9QYfuCPLPHo1J+0vqAq60Vt2Q3f3u4Q4I6oSubkr7NmSA4OKKffbsiGb6uI+KESsHuh
         WC+oxFO1ankJoxJTmAQtxWgntr5znQ3p5DYK8dmb7kcoMIGq0yHngMxdn5RZ1r/1jouY
         Z2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXe4GgU8d9DMWatQPs4+MhexUnwiymIr8B0vhsiCZEFS/x6v4xWVH5s/39pXoKHrNnXMRsyoA75rmxgkypZKhgW@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfPfMD9KVWDMGnRtzDpPBdc+4uasxK6IyQ2hZ3LCDmHbFB1Pp
	uiVyFkx0tOVi7ZODZ0zKvo46RTilWhOJ54rW3lPX0+sdZYD0T57knp5o0/PSpq0=
X-Gm-Gg: ASbGnctoNKGhGMZ1E7YJGQv1WDh+PStMw9jy4iwN+nlAR6G/PF5MEsg1SYx/S2Djtg5
	x0vcXbE2FVXFORjsXUIj+nGvfqSiWHsKdI8jCHOCKGJaGYu2c5ZKt6vJXUzQnTXtT8/0CvwRIu+
	VDaxjCqwukSixE4u9yVyT2CE+IGUblH9sDEQca40WnmxtYTFtaios5Z+O49xQNBc5Qec4EzH5PC
	CGUKDyKfMDUxnio4sUOmeRs2+LbbJFksPFbxrVUGmeIVrZQBiz8/gjJxxby+Y2JyAbnrLyxGqnY
	N0ju
X-Google-Smtp-Source: AGHT+IH0bumv8/ep45dsbyJ3w/bgIbCNbZvWl8ImNKDmIS37q2b3Bybg40Q9enSZb2jM4zdqkXOTng==
X-Received: by 2002:a05:6000:156c:b0:386:1cd3:8a05 with SMTP id ffacd0b85a97d-38bf57ce963mr21812975f8f.54.1737564444187;
        Wed, 22 Jan 2025 08:47:24 -0800 (PST)
Received: from [192.168.68.163] ([212.105.145.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf328864esm17087269f8f.99.2025.01.22.08.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 08:47:23 -0800 (PST)
Message-ID: <ca8de228-68c2-4b2c-bb58-30f275afc49e@linaro.org>
Date: Wed, 22 Jan 2025 16:47:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] A mechanism for efficient support for per-function
 metrics
To: mark.barnett@arm.com
Cc: ben.gainey@arm.com, deepak.surti@arm.com, ak@linux.intel.com,
 will@kernel.org, james.clark@arm.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com
References: <20250106120156.227273-1-mark.barnett@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250106120156.227273-1-mark.barnett@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/01/2025 12:01 pm, mark.barnett@arm.com wrote:
> From: Mark Barnett <mark.barnett@arm.com>
> 
> This patch introduces the concept of an alternating sample rate to perf
> core and provides the necessary basic changes in the tools to activate
> that option.
> 

[...]

> Changes since v1:
>   - Rebased onto perf-tools-next, as per request from Ian Rogers.
>   - Removed unnecessary code that truncated period_left to 0 and restarted
>     the PMU.
>   - Renamed variables to use the shorter 'alt_period' instead of
>     'alterantive_period'.
>   - Added patch #5 that addresses an issue in the x86 and PowerPC drivers that
>     caused the opposite period to be reported in the sample record.
>     

It sounds like it would be better if patch 5 comes first otherwise the 
feature is introduced as broken.


