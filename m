Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2C13C9A9
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835026; cv=none; b=N7zFiqQqUhIhHGLSfezmKxL4MqbLEifRyUo3GU8ACB44JwhbN6npuLfGAWotUD5vqpxwo0Pm39CcTDreHq/Hwth4DbqGJVnH0ilHKI1dV9gb3SGCe2iPcakqb8bIT3oEq/zSeeqrBEp+NkRQP1RmTAVjrwappg3nfUdWyJMWEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835026; c=relaxed/simple;
	bh=nQkUCEyoNucsphDLXWSe/1YShtMDQlZ8d9pl7pAPNk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRliaz/wlxQZ9GsLB1DuOHNKZE/c+UM5FG3NLQ92gzLLF1aVMfSOsIlGbaiq5hiTkWfBkZYvL8vf0oxFQpnIN2efnFGBuWe7OuC4Q4jGbSXXrWywTM7asdRSYzYCWsBAMnX5rNzlHnmvuUVboYjBrGAHr1lSuQXKMcX604Fb1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FYJ331cX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FYJ331cX"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4256eec963eso20867925e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Jul 2024 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719835023; x=1720439823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qM6ozT6ipWpUx8fDizJzb5G2gQBWPUGL9xe3Ichxpek=;
        b=FYJ331cX8EE44WCXWueM5+E44vSdkIbfP728djFFGh/c5jQMlAuPPSMu6dnjlluqbj
         HOVEx7vUSDsMk6tRbrIFEO+uTahI8uc4Hz0Ez3nJRUu8vp8LFGXMa1XL/7VdeKyqsXJf
         Tq2+1XH/qZjpum7JOIlk43YwdfuYltUsRi+PN8fsQX2fwvddOTywkwSKO7yhLH6SoxYz
         YSWSED9t+mbzhrjB79Fhij1moae5TdP0aKjKohTG5LsqlGPElKmhogkMa01nGf4GOdez
         EaRZlQlfaPPg2ZhDWtDddd/im7a7I2P7b6I5Y1A4tigDgkR+MBILg9h94AOEbcPlb7u8
         1NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719835023; x=1720439823;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qM6ozT6ipWpUx8fDizJzb5G2gQBWPUGL9xe3Ichxpek=;
        b=kOq/lhSLiIrhhYUwrJt4rDJKS08P7V7Dotq4alfR1T2jC/fXFO1NHVjYH1euag7r5t
         c/oi2etI2L3eU4JfMGfNrSGxSbfYsvrtcUit3vbCVVkg0ZQwigs4Zb5t/nRQnN0dfPbl
         OJvA7JEyoXzqWbH5NfrJsE7LASg7mYojZvuniSm8JespvKEmC/SofIzV1qQdbzXzLReF
         W3WZxF98WET52uJQpqykeEvZnZN6r9fvCDDP/YYixNEHHDrjlxtAsExIUTfvHtVZHAJQ
         SqZTEUNq3Lg5s7MmVk3hjCXwIGKb0Y5LHA2Jdr3j+S+aIbpHnH4s5Vq9nldVAmohWnl+
         9CPg==
X-Forwarded-Encrypted: i=1; AJvYcCV068+PTTV3YwPpGPfMR8+Www+ZfehWbxfSOIouKlkSntnbE1L+6hPRbMC8NUChtADRk1xy/JdtHaOOiBKqWpfZf0Sa5Z/zQUgHulyNoGIZLw==
X-Gm-Message-State: AOJu0YyY31b5gsf+xr9K8KFiqeZrgkyKHFUUdQF6P0/sY7zVtbndHuXi
	X1ndFKJJI3JyNKTckt73vNJyNJ8A/Ak+LIM6B8tYWB7Mg4W/w+tP1q+DmuOlZbY=
X-Google-Smtp-Source: AGHT+IFYVSdRcV9MLSYbS5/vmHR/G4uYFaK3YDbIt8yGK5agQ58wvuLvzBnOMK0fuQtCapDBq2tqBA==
X-Received: by 2002:adf:f6c2:0:b0:364:3ba5:c5af with SMTP id ffacd0b85a97d-3677572827amr3273332f8f.61.1719835023153;
        Mon, 01 Jul 2024 04:57:03 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7471:9e35:9ca5:4e8a:d8cb? ([2a10:bac0:b000:7471:9e35:9ca5:4e8a:d8cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d90casm9755883f8f.32.2024.07.01.04.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 04:57:02 -0700 (PDT)
Message-ID: <e1c4fae6-dbc9-4b79-8dd6-9ca00bf2bf6e@suse.com>
Date: Mon, 1 Jul 2024 14:57:01 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] x86/cpufeatures: Remove
 {disabled,required}-features.h
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
 namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com
References: <20240628174544.3118826-1-xin@zytor.com>
 <20240628174544.3118826-4-xin@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240628174544.3118826-4-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.06.24 г. 20:45 ч., Xin Li (Intel) wrote:
> The functionalities of {disabled,required}-features.h are replaced
> with the auto-generated header cpufeature_masks.h. Thus they are no
> longer needed. So delete them.
> 
> None of the macros defined in {disabled,required}-features.h is used
> in tools, delete them too.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
