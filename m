Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACC9221F11;
	Thu, 14 Aug 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186010; cv=none; b=oUbQDc+iXbLRIvmg91A8xSz+9JsM8obqDo7hBrPKpdVkiaTadNEsELfYhNA5DKztzld/z5UwYiak/VFCDGmigeOG6ondmTIeV57tSzRd9EDsn1vz7YOuMftA6qp6Ua+fMSRqLLNYrMR/w4BvGBiVc1/DUViqJ69YCoW3XRdYlr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186010; c=relaxed/simple;
	bh=ZXGUYhzt1VUdgKBWFHoGfMvtYQGXd2TgUb5VX/wC7PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLrABj5QAJE/NWqXUJLO8P5WEzlX7ycILhYTNdX3j+7lvXIWnyqWh1OxPK48cXnC6GitFgKh2uSDMZXCx2+JGniGDzN4s8NrEASXGMiXBu2++cNQTy+bo+Oh3voMDRCwjs2bjHoiqwxxdl+1nhXV/UOkWuZF2h6nL7DCHSiGF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOOOEQ6t; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOOOEQ6t"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b47174edb2bso743939a12.3;
        Thu, 14 Aug 2025 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186008; x=1755790808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mBHs3tZTa/z7QKa1vW09fgwDqXxY/YWMdhLXeWTfw9k=;
        b=lOOOEQ6tMg+bLZIAfQ7obUaKBZt9oDRAOnvJ3M8npIFHa80rYu/pDJ/Gse0tknNrVX
         KLU9fhBYfuVAZy2QfF3Iv4bVklYwDQm7sVZrn6thfwWoXznEIT06uwLt/nC+gFD9DpzJ
         oROWIqcdH3+ljodmW/R78DcphT8yerFxH5ucBs5RGG/ASh3fsSQu5xa3eEt9CZO+2osE
         3lwgivEPoLPO6EEpNg16fgJeV3PVx9vvp8+DG3c9hMO6nYrXxe618NLNkhb/N/HwHBWI
         w2B6hrZsZ9A1FuwcplirqM6E1+77yeZLSgksix+Zcq6U3Fwm3qZeJzxVtGMutOC+JhS+
         mGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186008; x=1755790808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBHs3tZTa/z7QKa1vW09fgwDqXxY/YWMdhLXeWTfw9k=;
        b=Rr/g71DUM5vzMquI9oE24ZR0/7KQfLdaY3XFE2DWQIzQZZ2KVEKINLUr13vDiPsobs
         P0mZ/pTFnAH9dEPQSSh8Wcnyu6NCI9mt1eIhP8cZcPDv9rjVh0xJNsINpcRz742GkXvY
         kR4TGrOZ37t8we/39tT3xejI79TD75+yiWv1pEKy0R4cZLNt5rwO3rshVJVfOvZS/CKr
         3A7AteXsxbNhgEVHmn9Tpt+kNUGqyrZ1NTN2jMXcT2lOGTSNsLTIlRW3xejjCvDZBRux
         tmb2z76efNbv+NwCWh4Vnc/O9NifQqHXWc4yr1X5mf/NHM8SaAjoExPvVFGNoJCNtcXJ
         ohUw==
X-Forwarded-Encrypted: i=1; AJvYcCWeAG06kSc1oBw5B0XfUNppEgQ/67V4eNExFi1DxzRL7V5ostdL3Tmc38/nVPK7s4Yapndt2S0FA3/D2SdpWR3kHw==@vger.kernel.org, AJvYcCXVYWS+uAEIf/YE4ZXKbdLeSxeME/7Qwgjnx9mQeWt0ckphY/1uwRu7L0FrYEcRE7z6nNtJXM653CCplA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC2qHpgM+RviYGijxe+GkmwqZHKm965DenROMo1mWAeyKktPfL
	zk7ZJNVcdO+1JPqorXgoRW9Dv8Udx7lg8eZp1COtxuVWZDfIjKJghV6/
X-Gm-Gg: ASbGnctKmyctn+so+fvNl4MFechIiksWdHqeR6ZMXZtaGNh/za6D6V9/LTTqjWr3+cD
	ufn439+ryajTlH/ukSRbL8WN9Tkx36Ut/kBwgBeEDBPov8Xo57WhAFVRycvkQ9RZzxw0AxIVP9B
	7EgsX2yECFWTezVyzp7t3E9LVU3aVjxrHeV0nP3JMUc4eaaNDV9fnq4WyOJrjQkQjZe32htOfM+
	TGJ+x5mLTToep1f31Rbyy0q/cclm5uOe01vzz/BB9vc1TDQBpPPucpEGbAKySIKtaq+hcrjheGu
	KNjFVCGew/xvCSTdfm8Nubnzr1IwK5ZpUmgf2t55l2w2Sr9I3K1QBbIdYLdX5udK+cYMkwto1p1
	obO+qkFnd
X-Google-Smtp-Source: AGHT+IF6sZWbal1ps5VoVoCJdklaMfP+Xu1/4uvgtaG+zDgi1W0yrHZyjTNjGfZ4lavi7gHShEcWng==
X-Received: by 2002:a17:902:cccb:b0:23f:f065:f2be with SMTP id d9443c01a7336-244586a0e5bmr50115645ad.26.1755186008243;
        Thu, 14 Aug 2025 08:40:08 -0700 (PDT)
Received: from gmail.com ([2406:5900:2:f21::2a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21b69sm357717545ad.71.2025.08.14.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:40:07 -0700 (PDT)
Date: Fri, 15 Aug 2025 00:40:00 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] event/core.c: fix warning format specifier to use %llu
 instead of %lld for u64 values.
Message-ID: <aJ4DUJD8SXdB3gjn@gmail.com>
References: <20250729070620.527482-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250729070620.527482-1-seokwoo.chung130@gmail.com>

Hi all,

Just wondering if there’s any feedback on this patch.

Thanks,
Ryan Chung

On Tue, Jul 29, 2025 at 04:06:03PM +0900, Ryan Chung wrote:
> Updates the perf duration warning to use the unsigned 64‑bit format specifier `%llu` instead of `%lld`, ensuring the format matches the `u64` types.
> 
> No functional change intended.
> 
> Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> ---
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 22fdf0c187cd..b8d7c4a64c44 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -602,7 +602,7 @@ static u64 __report_allowed;
>  static void perf_duration_warn(struct irq_work *w)
>  {
>  	printk_ratelimited(KERN_INFO
> -		"perf: interrupt took too long (%lld > %lld), lowering "
> +		"perf: interrupt took too long (%llu > %llu), lowering "
>  		"kernel.perf_event_max_sample_rate to %d\n",
>  		__report_avg, __report_allowed,
>  		sysctl_perf_event_sample_rate);
> @@ -655,7 +655,7 @@ void perf_sample_event_took(u64 sample_len_ns)
>  	perf_sample_period_ns = NSEC_PER_SEC / sysctl_perf_event_sample_rate;
>  
>  	if (!irq_work_queue(&perf_duration_work)) {
> -		early_printk("perf: interrupt took too long (%lld > %lld), lowering "
> +		early_printk("perf: interrupt took too long (%llu > %llu), lowering "
>  			     "kernel.perf_event_max_sample_rate to %d\n",
>  			     __report_avg, __report_allowed,
>  			     sysctl_perf_event_sample_rate);
> -- 
> 2.43.0
> 
