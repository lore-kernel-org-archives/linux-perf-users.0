Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5D218580
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716272; cv=none; b=LloTlb6nHCzxxmRHbWfowGwzq9xR/gyPkLr5Q1pK8+lCsK69sg8PZS1fV2YMSclG/8Qyu5olO0449tMUzmILNgO0+EC306znNYx61Y49ZbPQ3o4ikle/RMvHgilGC4lCGhP0FUHfeZJkY8rOtH9292NIib5PQLZbHdhPIWH57KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716272; c=relaxed/simple;
	bh=f/UyJP6vQx4TVd+AM6JjhbEHevJGuFxqlVA/YhTlF/s=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JPbb4DClVRQdPgm25JQIlMV5leiIT1H2BkjW2NVbYyJ46suLMOFlAGijSBFGR9Xen5xdCAOGpt+65ICSr6j+ZN+H4Ykrc+LlqqVMEXaqYzdwv8xAvFxUSd01FYZ/Zt16n7UCQi/aOXfvmDSG6cZqkBGvG5YU15lr3IlF8z3oyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kdkluDbA; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdkluDbA"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-735a5ec8f40so3056574a34.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750716270; x=1751321070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XtLVtTxbmHrCBpSNsrNTm3SDGLbs218ttvI0elQ1Q/A=;
        b=kdkluDbArgNgkRJ9UQa0FcY0rvsUfKvnWgKyOKKrgFK+AysFb7/iP6Q6CiA8slKsXA
         5x5eb/bYkegQTMqTkmyrf1NxsekalXIglSISfByGQgouT30DsOJ67VrNN10ZWIIkp91j
         J8BZqg4tdYzzzcVqY1t+D3pImCn+aNRGKhfxixRVyQmtrAdg9zNV1jKPdhyw1G/Jzd84
         NZYKv3XbD2Os8yLpS9iyoJ5hPzRksAt7K32PGfmZAknMje/nFlJYr6YmvHEz8/ljiFYM
         308m+AqQPgYY6/tTogxh4qcf5+GHwZgI9+zxIL5Qk9PW7pYZGg4FatxaIXbLcIw8kCd0
         z4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750716270; x=1751321070;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtLVtTxbmHrCBpSNsrNTm3SDGLbs218ttvI0elQ1Q/A=;
        b=Sfj9H6+IawcQFUbN6pCEJCoFr2q7nLdIds8gEBPQryAx8uYN4RloBvEQVch3NVgEhC
         k/csCwSM6uDsVbABo72C18PW7As7DOwecI+q3TdX0bYGUG7QerP7tXvyTnZdmNl2wou8
         m5G2UeCorew+HZ4O5wv0FzL6RlzxZw5pGAqy0jF3pcc8N96gtN0aFhnzv/cgGksYjuYu
         fXejL6WAmVahLZl27bC6imuZ66B00ucv+5onXNISLbGVsHleqN5Vl/p2v0zXN73MUiXf
         IpCVj4Fme9z9hlOIdEOsoUqEI3YrFWU/5xCy0Ha7I4xrSdB9AHmLrcINDs7oSbEJR1zF
         xvWg==
X-Forwarded-Encrypted: i=1; AJvYcCVCrf5FDPRiEpHaM2cSzqzkQOZc35OGN8prRmyE04XUcir5+WvYnoiV2FzfU/C7P7uQyD36HV5ezIf0nzzkW1Nm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0/NvazmrbwvLQc34Bi8Uf9736Rjzvrfim+RAP9SheE/OabM0H
	jF9KH1jFHxQ8xSGIaTUeAnpA5vy9mXEogOv7BbATbo+R74JU+0fZIqpZWnBZYdz0/LnSt6NzQyQ
	kWx0a2EZld+BcHX6iJpLgxbmpeg==
X-Google-Smtp-Source: AGHT+IFkDmfiUvq4ze8ArvjRNaiH+ZXYtlXJVVDDWXvRxwvqUxfAjNMLJj1dksngCu/MtTNVejcjEvPTGswxYjYzFQ==
X-Received: from otbbx10.prod.google.com ([2002:a05:6830:600a:b0:72b:88be:33e6])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:d8a:b0:73a:8d4d:426f with SMTP id 46e09a7af769-73acbd8e287mr1029204a34.2.1750716270304;
 Mon, 23 Jun 2025 15:04:30 -0700 (PDT)
Date: Mon, 23 Jun 2025 22:04:29 +0000
In-Reply-To: <202506212205.NmAR3sAH-lkp@intel.com> (message from kernel test
 robot on Sat, 21 Jun 2025 22:56:09 +0800)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntjz529ksy.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 05/23] KVM: arm64: Cleanup PMU includes
From: Colton Lewis <coltonlewis@google.com>
To: kernel test robot <lkp@intel.com>
Cc: kvm@vger.kernel.org, oe-kbuild-all@lists.linux.dev, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

>     drivers/perf/arm_pmuv3.c: In function 'armv8pmu_enable_event_counter':
>>> drivers/perf/arm_pmuv3.c:680:2: error: implicit declaration of  
>>> function 'kvm_set_pmu_events' [-Werror=implicit-function-declaration]
>       680 |  kvm_set_pmu_events(mask, attr);
>           |  ^~~~~~~~~~~~~~~~~~
>     drivers/perf/arm_pmuv3.c: In function 'armv8pmu_disable_event_counter':
>>> drivers/perf/arm_pmuv3.c:702:2: error: implicit declaration of  
>>> function 'kvm_clr_pmu_events' [-Werror=implicit-function-declaration]
>       702 |  kvm_clr_pmu_events(mask);
>           |  ^~~~~~~~~~~~~~~~~~
>     drivers/perf/arm_pmuv3.c: In function 'update_pmuserenr':
>>> drivers/perf/arm_pmuv3.c:757:6: error: implicit declaration of  
>>> function 'kvm_set_pmuserenr' [-Werror=implicit-function-declaration]
>       757 |  if (kvm_set_pmuserenr(val))
>           |      ^~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors

Looks like some dummy definitions didn't make it into a non-KVM config.

I fixed this and a similar problem I found with kvm_host_pmu_init().
