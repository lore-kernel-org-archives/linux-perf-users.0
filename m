Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F4A50;
	Wed, 12 Feb 2025 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324807; cv=none; b=ciBSxGD0lOpGgQAAgsZeA2c4vAv+nvKKmEP01rvDMgbr5c2OjEXFg3yukv+1y3zS5LGc9+2XwM3AmwfWjuj5tI1TutoDUEk1NQzi0R5gG2np8We3FEgoiy8U3BC3P8+THtxp3k4YezLnNWgsaYaKsi24D3CKZHGHgn2bNkc1tW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324807; c=relaxed/simple;
	bh=PSCzs3ngD+C1yXihEL4cFezGLCaJyzWjlhrxKXNCgrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V595FYSg8xIZybJhU8xAtImPcvtLB7aXjy8PlfQLFblP16G9F4+KXVFMdzFLoDjd89nA07Cs/olNDv7XRckqHhQ2v6e22JKl7IYcoxIexMSJ6vh7MNi3vNd1w6nDtTkraTii+Ro33FRCKtxC0OOFQuQo2YbEtX7UA4+Xdt+AxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NM59lqKm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM59lqKm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f44e7eae4so105384935ad.2;
        Tue, 11 Feb 2025 17:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739324803; x=1739929603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1PecfJ/ulEmOVAcJ2BrU2idsARRJ75dqEtuR45WJos=;
        b=NM59lqKm70LVrrNltM9UP2xw4Hn+I6rN/LaUGueXGidU/eas7CD7MwLkdb7aGuqvfm
         8eGRv48Y5yb7hKRdEWOKHyRnF1o4HtYulLjUsUBrTx3PvoWOgD7JCPpLvwUbfsGruL65
         OIgtW/z3wzA4F1qNohxBHaAbt1adDFRCNEFmd3mGe2y7pqElD1abwQBvOGtCDcmqUB1Y
         fR7HoRfEi6T/XDeu4ncnnmb3wNjGdf2RlBY4/je9qOprfRJ+oMXtSxMb40zlW7lVRKs6
         rLWVDZM+3czatuAgfsrORH09b+H5Ly/gHQ5FkNO/T0hWDxFCn521QZHbPIXdJXFzKTVs
         K9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739324803; x=1739929603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1PecfJ/ulEmOVAcJ2BrU2idsARRJ75dqEtuR45WJos=;
        b=bU71n85bHXEB76ilT7uO0QcY1pjn4OZnoHkzSQdNT1qwidtgOdZw42Ve/K2cBtNHs1
         pblzD9kxuDrdnDrEpRUXxmUgTmPZtAA+QrH3sCvAXCUJmchi3AUxI7i/vwC6p607HMob
         7plYFV02LKXWozbiJZ03QuZXqS+Fsu8Tgc7JDaG7pO7Hct1p36WEvWrSag8gNBUa9pDb
         ky7z/oeAiZV6qwEvJGzxTB2AcRkMXp36iL/5IGMupQ/LvVnBz3xx2dqTq6tyHaKHG4W3
         y90vjTXNMH3AHJmgeDU95ZIgJo4EvrA/mawW1x0JDN7M7spX28E45m+KOX2Rz/bD0IzQ
         74Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUaO6idz8cPOHnmFWsJXF0ZcOaCCQoQti3kQF5bUcq816afPMgI60kqqYcJ2X0Yp3eXVRnebjI38P1XIkdFYpOVtw==@vger.kernel.org, AJvYcCVyk5ZJ2Gp598qK0DO0MReHi/7BSiA7TVGYz+Z3lKgIeYYJdAyXC8MofJXsMcLkm8+1pT0JQbZTrwdRTxae@vger.kernel.org, AJvYcCXjBsZizoK2hhTr19Q/TSGVnbjBZSoLQRxEcijsPW1mI0dhQOlZJC4Z2OUKNlOvwbujOT3Xk0gIZJrf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2YGW8tWyDi8LmFEwrqwDf0MSpt9X6gLX1Pz1vWW6kTFsWVbl
	sZWTPf7Z6SYjjdOahCUyCCo41kmVDX2I1JSe/b0aZKxikdIcWLFs
X-Gm-Gg: ASbGncv59UvoVFedp8HaaLp35/P++oujlF/AKBAdmqSiGuFni7NzxDkxZNwCb3AWF0y
	WsQYxx5fmrn8KMJT2u1urfY10rLRI4tGWZV+cX1gH6B7s1fEBwRSdBDQv3ywgjC1atSezvpIJ9k
	7L8ET65du1xWjyi2AAHp9fKVKEY1F2OME7SdJ8V8ZxzcEaGkbTQ9vV5yV/ocfbo6sCCsFbrRAiw
	lTG3gKetFG4DXakvl6TdIsLEesss3Ej7yHCvmNYjGssHWhMiXmTklSm5a+q4Otmz6eyI64ijzVl
	5xsVroEu7U9hjPCLwtkhvUkgnoDNAko4fkn0aW1JiWfMIKCyHOU=
X-Google-Smtp-Source: AGHT+IHynglCW7bmaS/rFXo/7iC4aLmIduuaHZeoNU0TbMyLvmCKS9G7NEptuYzgov+wProVrfEplQ==
X-Received: by 2002:a17:903:234e:b0:216:282d:c69b with SMTP id d9443c01a7336-220bbca3a8dmr19893075ad.50.1739324802807;
        Tue, 11 Feb 2025 17:46:42 -0800 (PST)
Received: from [10.89.236.32] (wf126-032.ust.hk. [175.159.126.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687bde1sm102872645ad.195.2025.02.11.17.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 17:46:42 -0800 (PST)
Message-ID: <23db2d80-cfc4-4c15-a4fe-11e677185344@gmail.com>
Date: Wed, 12 Feb 2025 09:46:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] drivers/perf: apple_m1: Support per-implementation
 event tables
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com>
 <20250212-apple-cpmu-v1-2-f8c7f2ac1743@gmail.com>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250212-apple-cpmu-v1-2-f8c7f2ac1743@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Nick Chan 於 2025/2/12 凌晨12:07 寫道:
> Use per-implementation event tables to allow supporting implementations
> with a different list of events and event affinities.
>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  drivers/perf/apple_m1_cpu_pmu.c | 65 +++++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
> index 06fd317529fcbab0f1485228efe8470be565407c..1bf7ce5c09846c699d66bdfcca129f418a9dad9e 100644
> --- a/drivers/perf/apple_m1_cpu_pmu.c
> +++ b/drivers/perf/apple_m1_cpu_pmu.c
[...]
>  static void m1_pmu_reset(void *info)
> @@ -572,25 +588,16 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
>  	return 0;
>  }
>  
> -static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
> +static int apple_pmu_init_common(struct arm_pmu *cpu_pmu, u32 flags)
>  {
>  	cpu_pmu->handle_irq	  = m1_pmu_handle_irq;
>  	cpu_pmu->enable		  = m1_pmu_enable_event;
>  	cpu_pmu->disable	  = m1_pmu_disable_event;
>  	cpu_pmu->read_counter	  = m1_pmu_read_counter;
>  	cpu_pmu->write_counter	  = m1_pmu_write_counter;
> -	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
>  	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
>  	cpu_pmu->start		  = m1_pmu_start;
>  	cpu_pmu->stop		  = m1_pmu_stop;
> -
> -	if (flags & ARMPMU_EVT_47BIT)
> -		cpu_pmu->map_event = m1_pmu_map_event;
> -	else if (flags & ARMPMU_EVT_63BIT)
> -		cpu_pmu->map_event = m2_pmu_map_event;
> -	else
> -		return WARN_ON(-EINVAL);
> -
>  	cpu_pmu->reset		  = m1_pmu_reset;
>  	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;

[...]

The flags parameter is no longer used, so I will send a v2 with the parameter dropped.

Nick Chan

