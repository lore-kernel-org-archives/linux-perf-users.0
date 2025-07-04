Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DC61F4615;
	Fri,  4 Jul 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620831; cv=none; b=ZV+VxcSiu3PuulzsltSFPb/l5Lf7zsxu/bpohRoXUbkZWVg7INAaP9FuZDA9x9ddcDCsF6Ho4HF7ltiUCWehKxF6eJ4XbBeGdv0c5wrWJtFjTExvnYs0jq5i9RxOtTutbbuLsxPGnkMejaMA4FINv8eORuCvDpfYDCWF0+lglps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620831; c=relaxed/simple;
	bh=M4kyxHF27eymEVDJwIeVmNTutyHMh9udlF6lQLdU9Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLFxrjL7yptDv2PMp9pDXp1rGcgwt+/TKuP9vXbHFlajHdmPDikSdKNBPPXfeXSnMkb45a3KGXnKwuYJBGY9jg348ve6MMzp4+6f6tr0NWUozQdgRWWpFVod4i4GUwI43h5IjXvkSfkaxqeL1ZCPBBmYdAnYNTZcmInS369qXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es+woNO6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es+woNO6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a54700a463so411603f8f.1;
        Fri, 04 Jul 2025 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751620828; x=1752225628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+Ik9FB2BHF2LFVVV6mpBekWZ6EW7mXHVXys5mfnlr0=;
        b=Es+woNO6tQpICoQbnhYpe59Qe81Z3PG4yOB3pKuvcIwMwKwkhYBxeoDm69VXY3bLJR
         FXducSH9xq9W5wPjkNM13J2Bj1wIbs5ggw3JXRGyUI9aysCwiT3oJwyuFW+/dXCRvk1P
         FNnVA0BQVr1W4wvxKuGIxnJGirzrSdiYidaDlPpg14lo4yGMTNwC4PNRy/AHJD5tUunA
         46H9IrUSLP2+PM78gorOoCoHr10X7HUofLIHsvUusxTJjhe+tfdVq6KakikreDdoMqsH
         fijjacw5Rjjx3rqAPsJmsqBx+FkLLFMPqpp7huzKLxjlUaNy3jehHx9g4umYa2BapWej
         Twxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751620828; x=1752225628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+Ik9FB2BHF2LFVVV6mpBekWZ6EW7mXHVXys5mfnlr0=;
        b=G70TNj8YtYgKWrtOAsOhU8zRaoWPARVaiMoly4TkmVLFsv6QJrQpZxBteF0tNVqUPB
         1zU/UZk1yZgyXExeCqlTlcsEiJCG7MQh3QyHehXc8JfigauL7Iq5336mhVHc+XWs/cuX
         NAcR04pJK0QoNuJKxtLdjJTyGogkWJKa3/z3UAumUCLOuz5YpZeXkpgSMzI8WFfKaP48
         jBHSzcO5KrhkRCuBvdt0U4/7R8QMN3liPYelvbrIl4AFBwPfvnmgXgEkJGQOaErvQ7jZ
         NnXn0OoY88OHr4ohv7FzL9Uqp7D1+uJobJwg4YxHlSCXnsi3GTyhWuhtAadpInQywXk9
         Rkpw==
X-Forwarded-Encrypted: i=1; AJvYcCWjAWvksgnoRYiPmo1rYaL+Pi6I1p46NKIENe8tTLoMgVbos31s7CHQRzgiYl2vHIdBFe46KAGPQOgvWKc=@vger.kernel.org, AJvYcCXcuy6Vt/5RZ9j0N8nYy2/hiC2aTyt6JAt1XN8he6Tr/YCCUJqddwSNygNZclr1DpxaN0guqS3iEaPBpQ3SMLcLEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxjFcnnnbd3q8k9fCBmVPTySN/v2lawQiHksDtOQOCCuoFc9q5
	/d1PV9V+J1y23nAX4HrzrS1gpKc9jxNm78je50YY+3bIL4Xoxag9m5xJ
X-Gm-Gg: ASbGncu7HXkr34jvCEn0L1BlO6qntSMs7rgJY9e8/M5aa/190rknYV8d2gqNnN5PP6a
	2jhYHU/JfebBiEu3RQyWiTkya+Ga48x8/gY5yxSr3JbjiG1brnuT2sWt0gScJakrDBSUPI+ldRZ
	45aOeYxlihpnaBuvZfpDv2CrnShlIgYm6IYL1CbaZYKSBB2724quco0TQAerJUiFMrEQjJdyjBF
	hz/DtHMCluaZcUFSKKZ61Hq8N6/V9su8Z/YTE1vavN/+v8GjjwCK3TYJdPSkqPnP36pcxfD7uhQ
	j7AR4/8RVRgGlRgn47CnjLk1TQ8MwG++ItUNToUs3vm1U8CTlzGLTd4MTPLVH/E/JckPnCToW+y
	FhYt21fxesLdR/xHyTQ==
X-Google-Smtp-Source: AGHT+IFrlNc7sZqyAZg5GPKF/fl2jdn72qDl3Dccv12xQ9nx91zaIVbtMctI2uw/u5xVcuxpGQSwcw==
X-Received: by 2002:a05:6000:4601:b0:3a3:64b9:773 with SMTP id ffacd0b85a97d-3b495b9442fmr1765994f8f.10.1751620827681;
        Fri, 04 Jul 2025 02:20:27 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c4f9sm1945049f8f.88.2025.07.04.02.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 02:20:27 -0700 (PDT)
Date: Fri, 4 Jul 2025 10:20:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] perf/x86: Replace strncpy() with memcpy() for vendor
 string
Message-ID: <20250704102007.6354ce9f@pumpkin>
In-Reply-To: <20250618215843.109941-1-usmanakinyemi202@gmail.com>
References: <20250618215843.109941-1-usmanakinyemi202@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 03:28:43 +0530
Usman Akinyemi <usmanakinyemi202@gmail.com> wrote:

> strncpy() is unsafe for fixed-size binary data as
> it may not NUL-terminate and is deprecated for such
> usage. Since we're copying raw CPUID register values,
> memcpy() is the correct and safe choice.
> 
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  tools/perf/arch/x86/util/header.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
> index 412977f8aa83..43ba55627817 100644
> --- a/tools/perf/arch/x86/util/header.c
> +++ b/tools/perf/arch/x86/util/header.c
> @@ -16,9 +16,9 @@ void get_cpuid_0(char *vendor, unsigned int *lvl)
>  	unsigned int b, c, d;
>  
>  	cpuid(0, 0, lvl, &b, &c, &d);
> -	strncpy(&vendor[0], (char *)(&b), 4);
> -	strncpy(&vendor[4], (char *)(&d), 4);
> -	strncpy(&vendor[8], (char *)(&c), 4);
> +	memcpy(&vendor[0], (char *)(&b), 4);
> +	memcpy(&vendor[4], (char *)(&d), 4);
> +	memcpy(&vendor[8], (char *)(&c), 4);

Why not:
	cpuid(0, 0, lvl, (void *)vendor, (void *)(vendor + 8), (void *)(vendor + 4));


>  	vendor[12] = '\0';
>  }
>  

