Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74731BC9E
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830383; cv=none; b=QkaGQQGp9nvzrjBR0zP8s471wC0Pvv4wqZ5nYVAum4N0EO7blVZF2fuI2QrYXuYEvcjSnsMKshXAa2TyJ4lP8ckFeJFpJWNpTVDWuWB02a6kDvmDuHZZ1hQshg7yY1MLXNPmhH746KrO1hahHe40m/UX7hnqntdpUBxsvpJ3Lm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830383; c=relaxed/simple;
	bh=vMyMrttkJU70UcU5kNCp5ltRt/PfbQM9ak0dhNmn2aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mp0iuCFC0KUEScLGr3TvlFh0UKGEYRJz0fuLa6mulhSXCe/e+Z02I2Iega+f5gkvYy3IbxyhUPCpL+pxl1LnYTcQIMgx+rHer3auG1cvinfVRxl9f1UXFaSXRYYXVkHjhvC79dFe10gx5O7/jNRkIZVYxLRztkugn/rd2vAbVBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TjHiyIwA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TjHiyIwA"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso1292086a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758830381; x=1759435181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOzyRe+3fMSMSulDoCd/U8Ee2YvY46RKA0vukyO785o=;
        b=TjHiyIwArsAvIZbUTLSYnqpSmAtAQfcttw2pOHLhAydYrrZ8f3OkXcMh/mObYoDU2n
         uoCxL60u0n2AIfwfRR3lx6JdpEKMzGmBLRpZsKN/PossQWbzVVOehp6ax1t5eUg24g6j
         LlJbqyt1QlpRAqy+EGoaTHDQGRxAvHuu4pqDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758830381; x=1759435181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOzyRe+3fMSMSulDoCd/U8Ee2YvY46RKA0vukyO785o=;
        b=EJk3NzPFtq/1hFQ8ulrAuK/rMV1NyXXrxpSs0yfP4xylEV105JwUZsNm3fQz4+BDUk
         GUW0BUuGF9XQTzTInYGnYXnZCSBvJKM6DMWq4i7zjWASVKp3m14/V5DKcdyOm01YRWMb
         x/5xjKa0wB8SNnru6pRGpyS3lrbxvRwcSp+/zu4IT+xn3NWG8CKj6SdCaICZzaTak9dy
         8RDPMXUacbj50fGTvu0NlLBvTgO7xqhwl3wECC5JtPdWZrKOZzUsNCN8RBpvlutPIVNc
         zWFDrHH76gB+rH+shWaHfzhzvOD50YHOfEnBKCbgKpC15u6CTnedLvFIKrfML3Xh1m3G
         I8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUPeou/XRcXVg2b7ckcZG+y6PASRtXEbwcWWwgyYTFnQjhSJuY3EXTT/5PluczOl7hpa9FaiENM9+d13Yw0idGA@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTAHowMJpzghjeiptu0OiuSH4DAALq2RjrlrTk9JN7sfS8v7V
	J/NrWHEsPanlnrBgAEAOFx23rqzzWr36xIkyNmL+wZ2XxDUZEwqKHciLo02wNVOBONBlZMZf+UD
	9lI0=
X-Gm-Gg: ASbGnct5ydc7bhTiYl5/1pZIkf7jQMnzYd4QCDu6IzYmmnRrIDc8/7prPQspjBhv6m2
	sP7GBNJFj1LtVzt4wg8SiM1ZSbiLC6nAe6Y+U9mESR3CBPo9pXmHb6nPFmm1xZD/wyXylr8Hl0a
	aFnxwGELH5dXGhCBHzF8fgCSI/ON486r7Xk+eRbdE1U8NE1zlZdzs9hiCdRhwap6npZyCWrh85w
	SUU0LpV+BzFyjvqtXDBcA4vI07Leg+GWHBUdmNssX9TSijVH2nt5CD8JNcMoY1XdfaoNIGTdaiR
	UYlDOUQj3PcIDlHmS7PGFY4Q74+9TWyTWJ6rJO/TjXOFaj3W9rachR5nMyzFvoilJ4lWJovSCTt
	HwwgQpWkme3wHvkBBkvElOUp/iwRx4L+voahAzNvn7kLHkigLjnEUHusMcZO5MOsM22EM6Ip8
X-Google-Smtp-Source: AGHT+IHG6UBg870870Z0IfPjs7OMY+8F1MhnYBIpV3g3VXrA84ykWMIb4P+nwdkHv27QtxYBtkCwkA==
X-Received: by 2002:a17:902:face:b0:268:db2:b78f with SMTP id d9443c01a7336-27ed4a6e9fbmr33198855ad.44.1758830381328;
        Thu, 25 Sep 2025 12:59:41 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33473f7bebasm3134664a91.13.2025.09.25.12.59.40
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:59:41 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so1613683a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 12:59:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyNTDTIkiZfpoqyUeLTfXIAFQh5gvJqgQolkMl+Go+fhGmXCkqxkYVm1be6uNEduJHLSp8R2SUJEGaSRESKb89@vger.kernel.org
X-Received: by 2002:a17:90b:538e:b0:32e:18b2:5a45 with SMTP id
 98e67ed59e1d1-3342a20b94dmr4932192a91.5.1758830380238; Thu, 25 Sep 2025
 12:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com> <20250925084806.89715-2-cuiyunhui@bytedance.com>
In-Reply-To: <20250925084806.89715-2-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Sep 2025 12:59:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
X-Gm-Features: AS18NWBiujTv-FGvPpgY3gBOBVEPrJ77epiIZ9CDp8xRQDwQ7FOMR9gCNXwR3xI
Message-ID: <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld into common code
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	johannes@sipsolutions.net, lihuafei1@huawei.com, mark.rutland@arm.com, 
	masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> @@ -17,6 +17,7 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>
> +#include <linux/nmi.h>
>  #include <linux/perf/arm_pmu.h>
>  #include <linux/slab.h>
>  #include <linux/sched/clock.h>
> @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, =
int cpu)
>         return per_cpu(hw_events->irq, cpu);
>  }
>
> -bool arm_pmu_irq_is_nmi(void)
> +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> +bool arch_perf_nmi_is_available(void)
>  {
>         return has_nmi;
>  }
> +#endif

Should the previous comment move here, AKA:

/*
 * hardlockup_detector_perf_init() will success even if Pseudo-NMI turns of=
f,
 * however, the pmu interrupts will act like a normal interrupt instead of
 * NMI and the hardlockup detector would be broken.
*/


> +static int __init init_watchdog_freq_notifier(void)
> +{
> +       return cpufreq_register_notifier(&watchdog_freq_notifier,
> +                                        CPUFREQ_POLICY_NOTIFIER);

I think you need to do something to prevent this from happening on any
platforms that override hw_nmi_get_sample_period(), right? These
cpufreq notifiers will be useless in that case...


-Doug
