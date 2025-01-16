Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BC1DB951
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024051; cv=none; b=DCMl5SVzyWU5dOsFAF6faFrS/On3cCqlPDX+dPfOi8HdyV3rXBCeJDcezDK2R0UwZGxb4mTSfxop35HMPIZpJDO2Ro1UbTz46jhbTLw7uf5LiuosnXYqqW8obbEIJAT8JGIAmrfdXOvm6e8al4hGfr+/yqBkXvtVi3bIrUi7l58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024051; c=relaxed/simple;
	bh=FXr/R/ASTh37z1sRowGMoD+KS4XfQ1KUY2lWIB+fsm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpOT1goQdz3rSxGOuPOfCSDO+WFJ4JDdI73iFKFTHpS2JsRgFDLIbuwdxaO4q2ybrite9uqQa6Y/L3ZRq7XyU1xN0rm3jLa4/DDARAr4MhIm1cBKYIk4jUfT+ZhMSV/qa+lJTEYhwAcic5SXWp8YqM7i+/DVOj5Pe9spr1IwqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S2uuhxG8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2uuhxG8"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3863494591bso399683f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737024047; x=1737628847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EO66lMiXI/Sfgw5U/SYlAlVA9b1JkDl1ZV2cUjyfDeo=;
        b=S2uuhxG8t3yRx9fYZgNa9BD6J7CV86GcTgAG7JnUuLOxGuO0kVeeesWIBLOtIQVJ+N
         8HMpXlEf0IAZFtIfrRQRgfbyZfr3bBUsgE8gJBKCUO5Ck8Uoz45UbkjkjzOVzql3OTvz
         rRYJAZgj81jFnj6Z30H0SP1cdwadJkRn8ys0i0oqayUDaxreaGDZK6PuU2KoMlbiyupM
         7EVofZb+6maXvdYiNbWE6uE2IvP5UdJSa8idBDWNmwDs0689nc4tJ2sejP6PhJ4wrGds
         OksisIUBPHEbtiqzGnmkrxWWH0fcqPoG0Z9AzjlYf7e0gkLFgUMYrgAJzZtxRdI5kdqF
         xmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737024047; x=1737628847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EO66lMiXI/Sfgw5U/SYlAlVA9b1JkDl1ZV2cUjyfDeo=;
        b=RndzF8qH1fpBw9HIY1j2q/ANKQhVM9MHl9lgHKbk+70b772IdInSBDHBNGQaH2npqH
         T+mUMwEwFLfKIwM9EfM1R7uD9eAI8bsQcwu92ILQJZlTY/qklJ4vgtm2tjMUIiMVa2/2
         PlEFknpvZSlRzDkiGZC9nSWtkoZaF7Z7/xnKiKHLXvmdGlyvLrN8V6BPxZ7QGWk+7Pxj
         rsadVrtHci+D1GwKv9XRp9B//Nekon2Lw/zz7s2B9rl6fTfJBi0RQTUPlydhfSL4uMcq
         jLK8lC6aBcErIbRw3oX55/YQ3nFmeegOPGsopX8vBfD+AwaVtlQO67oiJy1InYVnmxK3
         1Bag==
X-Forwarded-Encrypted: i=1; AJvYcCUf8c/JMH4TwIrDLDupuiaBK+FySKkbk8eDzlqCkomfX/52MKhWbkYqXg/4yEIK+NiGxO2mnlRMojoJUGoA1+HC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rOKDR6fC8ikdmYO/RdwkUkH+QVeUw9/xI1uHjxPwoKgM2gGw
	yvS1VXsHKig+D6kB/+y6PhOhxDjfnASsaP81EumHVfEPWSapeD3WaO5jemcMxuc=
X-Gm-Gg: ASbGncvOF97NhfPIpzQoo431G94Oj8lo+ZMZzOxZtLNPnfXUZzuUoXr0dVsRmA48w6Q
	0aXyCP/j+tFSxaYP6+aZZMlrLjVhMl7wBMA1vAtemWJoY2b63npXuJogfEygqCiCFoLRqMG94dA
	HUEso/jsQdfIbkwTC/yA4CoycmBLpIlhim0Pvt+Pl6V2Vtg8+kxMJi/TaKSRrU3K+64ZQFipYRB
	UKA/YJE6qbWJHL00MuukNIPGI5H13eSDf1TpUW6FJZmTeo04WSM9mx/JdybpnT9mQ==
X-Google-Smtp-Source: AGHT+IENhP2degD2HSgnG/QrAKOGnMF+zY05b1bOVZLzbMSLYYZMykC89gMNgsoBqQE6xISFPPiCKA==
X-Received: by 2002:adf:a411:0:b0:38a:87cc:fbee with SMTP id ffacd0b85a97d-38a87ccfd10mr22019911f8f.14.1737024047135;
        Thu, 16 Jan 2025 02:40:47 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bec32b96dsm1625787f8f.21.2025.01.16.02.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 02:40:46 -0800 (PST)
Message-ID: <d90e130c-984a-4b9f-8297-ead2857ab361@linaro.org>
Date: Thu, 16 Jan 2025 10:40:45 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf bench: Fix undefined behavior in cmpworker()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 kan.liang@linux.intel.com, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chun-Ying Huang <chuang@cs.nycu.edu.tw>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
References: <20250107073906.3323640-1-visitorckw@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250107073906.3323640-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/01/2025 7:39 am, Kuan-Wei Chiu wrote:
> The comparison function cmpworker() violates the C standard's
> requirements for qsort() comparison functions, which mandate symmetry
> and transitivity:
> 
> Symmetry: If x < y, then y > x.
> Transitivity: If x < y and y < z, then x < z.
> 
> In its current implementation, cmpworker() incorrectly returns 0 when
> w1->tid < w2->tid, which breaks both symmetry and transitivity. This
> violation causes undefined behavior, potentially leading to issues such
> as memory corruption in glibc [1].
> 
> Fix the issue by returning -1 when w1->tid < w2->tid, ensuring
> compliance with the C standard and preventing undefined behavior.
> 
> Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
> Fixes: 121dd9ea0116 ("perf bench: Add epoll parallel epoll_wait benchmark")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v2:
> - Rewrite commit message
> 
>   tools/perf/bench/epoll-wait.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> index ef5c4257844d..4868d610e9bf 100644
> --- a/tools/perf/bench/epoll-wait.c
> +++ b/tools/perf/bench/epoll-wait.c
> @@ -420,7 +420,7 @@ static int cmpworker(const void *p1, const void *p2)
>   
>   	struct worker *w1 = (struct worker *) p1;
>   	struct worker *w2 = (struct worker *) p2;
> -	return w1->tid > w2->tid;
> +	return w1->tid > w2->tid ? 1 : -1;

I suppose you can skip the 0 for equality because you know that no two 
tids are the same?

Anyone looking at this in the future might still think it's still wrong 
unless it does the full comparison. Even if it's not technically 
required I would write it like a "normal" one now that we're here:

   if (w1->tid > w2->tid) return 1;
   if (w1->tid < w2->tid) return -1;
   return 0;

