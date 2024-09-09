Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E318C92C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919902; cv=none; b=TbfE6nfQEwjYMdF0J+z5SWJ3GrjFiXW/qCQcKXsR1WH2SXVpmX80flYZ0N1CVdY5c2MTqNLXZfY4d59xDNGt8FK4iKXHeVSZlsqSAaio1AVDE20qlZ1iVAfLMDy64MHglFU2VBgGFZCVD9tU7EMTo7gf9yq5TiWsZIQFrn2a+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919902; c=relaxed/simple;
	bh=+uIaSjx7tpFHnGMRaarBn8DWXOxfz418oPiwr2T98Xo=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=bLp/yGpjWnR4ANeyhiv8Y4wl7G1rw5eUzkP1vk8qbZYBhjXPWBzMChBIFFKIPEY9y9NscSwe10H8y5XgfsE50R+b5JAsfAYareZFGyDIttwwy3g9PeD8FtcygulzVofP9169iuyn2C8HfIJi3x3TshbDstSGN1/3DZAytViOFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EK8pale8; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EK8pale8"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-82aac437083so592480239f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Sep 2024 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725919900; x=1726524700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c2pACaTK9nt0Rc3BheIIfZV1ckivGrvcSLjBPbKaYU4=;
        b=EK8pale8K29N4Fq1If5YBI/g2bRom/MctNtTqlpnZ2aC9TmPWilw9PJ6BL/xYS+k57
         APyN19Ur6PAKu8qtFkAiuxK5eqUdDlRXry3IqZxhzjCyTeAb+Dsr7aLQKWG62gwbLibc
         v5GbmPsNz9VAREAnOHlxPFBeXqX4wb6AiOEYC/u8W2aaz4m2VIrWfb6/0hHj0OGy6RG+
         SBhhTWv2FXWxM15NibHCdcSgLjRfT4OI0ZGY66IXTvj8Pw8DyXjBHq85RsZyqie+g5OI
         8r2iQyTXZbYT5RiKQjdWnw/a6GzXVhVjauc0+H6qhW3AwDVKrMunfGCLxeOg/ibT0gkV
         Xsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725919900; x=1726524700;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2pACaTK9nt0Rc3BheIIfZV1ckivGrvcSLjBPbKaYU4=;
        b=Ctv2nCj0Aq/dUPEAhhXiajVqB4LKCE2nstoMikYt8txH7JvbcIz3ZNVmv8/2woZ18n
         IdiW38eXnKJKbeS9z9GEN3jyjopFrOtRU95VQRh/dlPP1BKKnguzo6OXLu2O7rfN2eQe
         PMf9BQQahtciil8tEvXT/m0+KJ1oY8vmBrjymK0uou67TZq0yPuLqDmCPs5Ers/odbEG
         JQISq+JfmwVuCAQiSK70yx9cVI9bTRsVF5vhOTj+bT3SSsieKMdKJdG+8yZC63F7UiDK
         p0+bSmgT2HPVfBd2DmY9Fqhi+5AskQkUMO3DSAHjwLDmNzXDAiQyls+J9o5Zm1aVekF6
         b8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCV3O5TJwMDPh0JEREZqzxReQBrBjEWno6vG47hw+bdOCWxT81J8GJ2p3MTuznCj4TvILEPKqwyzru+x8HjP47mr@vger.kernel.org
X-Gm-Message-State: AOJu0YzY4XK4HK2Um+Wx8AjhtE8Zy5PapdiMNqI6k5j9LrXrLRTY9fez
	XQhy1wYn3XN0G52ZdVPbMuOtXuVAeyhsbib+U9YGuUikRmZMf87gDCvbyTqjSpD7v33KY3vZReG
	V4NzAOCsSMY8AB1VeCg5tjQ==
X-Google-Smtp-Source: AGHT+IHumdyf8RGWX3ScsIDrd53c+f7QJveB+hxSaPOpbEO5ESD9I/7HvQQf8wQXYzJAZ6+8WW7qN/Hn1QRzMOohHg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:8707:b0:4ca:7128:6c70 with
 SMTP id 8926c6da1cb9f-4d08506dd17mr722531173.6.1725919900003; Mon, 09 Sep
 2024 15:11:40 -0700 (PDT)
Date: Mon, 09 Sep 2024 22:11:39 +0000
In-Reply-To: <20240801045907.4010984-16-mizhang@google.com> (message from
 Mingwei Zhang on Thu,  1 Aug 2024 04:58:24 +0000)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt5xr4eauc.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [RFC PATCH v3 15/58] perf/x86: Support switch_interrupt interface
From: Colton Lewis <coltonlewis@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: seanjc@google.com, pbonzini@redhat.com, xiong.y.zhang@intel.com, 
	dapeng1.mi@linux.intel.com, kan.liang@intel.com, zhenyuw@linux.intel.com, 
	manali.shukla@amd.com, sandipan.das@amd.com, jmattson@google.com, 
	eranian@google.com, irogers@google.com, namhyung@kernel.org, 
	mizhang@google.com, gce-passthrou-pmu-dev@google.com, samantha.alt@intel.com, 
	zhiyuan.lv@intel.com, yanfei.xu@intel.com, like.xu.linux@gmail.com, 
	peterz@infradead.org, rananta@google.com, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Mingwei Zhang <mizhang@google.com> writes:

> From: Kan Liang <kan.liang@linux.intel.com>

> Implement switch_interrupt interface for x86 PMU, switch PMI to dedicated
> KVM_GUEST_PMI_VECTOR at perf guest enter, and switch PMI back to
> NMI at perf guest exit.

> Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>   arch/x86/events/core.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 5bf78cd619bf..b17ef8b6c1a6 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2673,6 +2673,15 @@ static bool x86_pmu_filter(struct pmu *pmu, int  
> cpu)
>   	return ret;
>   }

> +static void x86_pmu_switch_interrupt(bool enter, u32 guest_lvtpc)
> +{
> +	if (enter)
> +		apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_GUEST_PMI_VECTOR |
> +			   (guest_lvtpc & APIC_LVT_MASKED));
> +	else
> +		apic_write(APIC_LVTPC, APIC_DM_NMI);
> +}
> +

Similar issue I point out in an earlier patch. #define
KVM_GUEST_PMI_VECTOR is guarded by CONFIG_KVM but this code is not,
which can result in compile errors.

>   static struct pmu pmu = {
>   	.pmu_enable		= x86_pmu_enable,
>   	.pmu_disable		= x86_pmu_disable,
> @@ -2702,6 +2711,8 @@ static struct pmu pmu = {
>   	.aux_output_match	= x86_pmu_aux_output_match,

>   	.filter			= x86_pmu_filter,
> +
> +	.switch_interrupt	= x86_pmu_switch_interrupt,
>   };

>   void arch_perf_update_userpage(struct perf_event *event,
