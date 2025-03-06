Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188120C478;
	Thu,  6 Mar 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266524; cv=none; b=Cj1w7MIRF8TpMrAQq0RbIXB3jhvnIENThnlru+Nq6FHMjCrprJBQeRbsaOa4Ej7addzi6ozNgK6EPBh1pLHOXXdy4cNlURfsYeA/gECR4odj9eXYghXwdqw9jjShw2XI3jTpMkH9Gar156jzzZjrSqAUJk9utZe+noA1afcYOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266524; c=relaxed/simple;
	bh=UQxOtCyjjeVSI1OL9Qw+dMxFi11CeViW/vaw3V+RlBw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa1TH/HN3nOMBAXPWznHgPeoPyBZyZ58eqNNkCX7N3tLMy6WSWE+4D6Gf/e5ay0MGAtp5F1n3Q8CZ3EhGroT3SZGCs5eXQ0TJG1g4e9/Sy57KEN81YWlLiV07s5Me4T1Ybcm/B+Cwso1uUSVVJU7JUcKVC9a+Iiv3qDoE3JYQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvQEo0ku; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvQEo0ku"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab771575040so349206266b.1;
        Thu, 06 Mar 2025 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741266521; x=1741871321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBpr4q0/AOycCkUAiZa/BjvQ502X7W3qJqBvzu0mmtU=;
        b=UvQEo0kuvnODkwMZ4sFiRY7sFAlsG7r1AjSkfC1QnDyU1Hs/Vhul7aWcDR8H6+Zutp
         jAKMwGnDFK8tXZP0/g1HDLnnd82SfBJu/9mBn3jnnbmfpR9Rtq1zOl7LjSzYyGGiIl1a
         gU6v4jM2qyBglY9TmcDC7V7KzIMHQncUtNBj+bim93cIc0LG3N5nzk/q5gbV+9zFR5Ds
         +xvldXQk6Gsrzy9HDb6u57Pm4VrXoxpECXcqyA9sRtZ7//yyvEXZU0OA97TqgYaUQY2G
         a2eiYhwm5awfx1Xs2zOpEBCA+SstXhGwuZYtBOdfxuXuuAWk3u/inP3y3FEHCoXObay1
         Kr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741266521; x=1741871321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBpr4q0/AOycCkUAiZa/BjvQ502X7W3qJqBvzu0mmtU=;
        b=ZnxnrvXkpvTGMwEw5ryaClllTYGPwXAKBNP4oQUn4oK33p6jmSmKwr73RbGWxEEc1x
         tJzYqMNit5zrZimOSKpmuRuWxB+EUD+FVC8QSQ0YE0BdRwnKow/QuJTbz+FV5bQsujw7
         4vRY28DZ55ZYA44W1Y8vmrchGSA3APdqmmHjMBUT1PSmfJYCXZGtChJ3NTMJo8KU+1tP
         2xT5VPfwGDSu18VFdgYxx+ZweKKLgTQ5MoiJHNMKbJrewJq/TVdFZIoTnIthKo3h0lk8
         dwvb8KIfIpv5XUtuPzXuEYuPdjfj9xMtKjTh+OqqFTvnfBQgclzyN5eHtvp57Y/mZCq1
         WQUw==
X-Forwarded-Encrypted: i=1; AJvYcCX3+vfJPe9LY3FvQMyLTu0MAa58ZJaNUyWU49EKhPyod5nm/Rtp0BMV0fbJgWwFdgXpBmmD76XHlEqSHL+VspK8pw==@vger.kernel.org, AJvYcCXB6P0BkHFR9qhZpHcg3wtgJuL96gSSRiL1YGTF+rW8nYkO9fBySR6P0ev0+mYnjm1JxHfbF2D/LECBCl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPpd6UyzlvvFUYjCEe/slSGrjJ4XsLkqGl5CNWPu5X+MFjcO7
	NSPL/fL8F2D/AZZzzgyDJCjcNwGUxhYNNrHFmgCVxAi+z6lLmytt
X-Gm-Gg: ASbGncsNam8/gKbDP1IQRHiqTwI+psWwxyE7mFJO8OaUs7vKeLVhog6XBw07a89ULHc
	BZP03VOFB5JMWlzhNg+JWr+vkLHsMHb8HTl+DZnB1lsAijxW6F92+LVyYZC5ljUbD/nj7V4rjk0
	HWP2vCmtuR8pjkLJD06ppX8WyqofKgGhOVat9tbbN04PEBk55VM1+jCCa6qvOrcIgmWoeIVyxiL
	uFxYRgK+KYjvcXE1fN/2I8HB9mYKPXBKLIgf/Idov1MtPKpoxnzEUHVb/LH7WxNSkFjBTerlQas
	B3K63DaGM19yKvF/kgvuzR/8xN+Yjy1KEt+oHg==
X-Google-Smtp-Source: AGHT+IH4d/pbcgd8COO6M8KiuoS/WI/geAVKNETRj+9XKo2UQlZOoHE8m0iodn3MMHoQ0Ft5DwTynQ==
X-Received: by 2002:a17:907:72ce:b0:abf:48df:bf07 with SMTP id a640c23a62f3a-ac22cb3dd85mr336391466b.15.1741266521096;
        Thu, 06 Mar 2025 05:08:41 -0800 (PST)
Received: from krava ([2a00:102a:401e:9b3a:b228:9e66:580a:3bc8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768c798sm930867a12.66.2025.03.06.05.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:08:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 6 Mar 2025 14:08:38 +0100
To: lirongqing <lirongqing@baidu.com>
Cc: olsajiri@gmail.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf/x86/intel/bts: check if bts_ctx is allocated
 when call bts functions
Message-ID: <Z8meVrqd-F7tf44j@krava>
References: <20250306051102.2642-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306051102.2642-1-lirongqing@baidu.com>

On Thu, Mar 06, 2025 at 01:11:02PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> bts_ctx maybe not allocated, for example if the cpu has X86_FEATURE_PTI,
> but intel_bts_disable/enable_local and intel_bts_interrupt are called
> unconditionally from intel_pmu_handle_irq and exploding on accessing
> bts_ctx
> 
> so check if bts_ctx is allocated when call bts functions
> 
> Fixes: 3acfcefa795c "(perf/x86/intel/bts: Allocate bts_ctx only if necessary)"
> Reported-by: Jiri Olsa <olsajiri@gmail.com>

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  arch/x86/events/intel/bts.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 8e09319..e8b3e7b 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -338,9 +338,14 @@ static void bts_event_stop(struct perf_event *event, int flags)
>  
>  void intel_bts_enable_local(void)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
> -	int state = READ_ONCE(bts->state);
> +	struct bts_ctx *bts;
> +	int state;
>  
> +	if (!bts_ctx)
> +		return;
> +
> +	bts = this_cpu_ptr(bts_ctx);
> +	state = READ_ONCE(bts->state);
>  	/*
>  	 * Here we transition from INACTIVE to ACTIVE;
>  	 * if we instead are STOPPED from the interrupt handler,
> @@ -358,7 +363,12 @@ void intel_bts_enable_local(void)
>  
>  void intel_bts_disable_local(void)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
> +	struct bts_ctx *bts;
> +
> +	if (!bts_ctx)
> +		return;
> +
> +	bts = this_cpu_ptr(bts_ctx);
>  
>  	/*
>  	 * Here we transition from ACTIVE to INACTIVE;
> @@ -450,12 +460,17 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
>  int intel_bts_interrupt(void)
>  {
>  	struct debug_store *ds = this_cpu_ptr(&cpu_hw_events)->ds;
> -	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
> -	struct perf_event *event = bts->handle.event;
> +	struct bts_ctx *bts;
> +	struct perf_event *event;
>  	struct bts_buffer *buf;
>  	s64 old_head;
>  	int err = -ENOSPC, handled = 0;
>  
> +	if (!bts_ctx)
> +		return 0;
> +
> +	bts = this_cpu_ptr(bts_ctx);
> +	event = bts->handle.event;
>  	/*
>  	 * The only surefire way of knowing if this NMI is ours is by checking
>  	 * the write ptr against the PMI threshold.
> -- 
> 2.9.4
> 
