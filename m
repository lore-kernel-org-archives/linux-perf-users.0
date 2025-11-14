Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B3C2EFD8A
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763147658; cv=none; b=Ui7n5xZtF3Wb717+Oh3ob82WvcVMwHLm7XpiGgBWgZYp9Qs5suPxDjTKrrubqlD/XM66SKbjFJwgBhffmLje6nc64lRzfinaivwQu56EqZbYb7bDOBcLv3NEUg20hMBjPKPmUaUz1F3CbjfImcE3YyJcao8ovhsQ2RHLsbE1/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763147658; c=relaxed/simple;
	bh=sqFSHDCPRksQdHdUyv1FMM63cJMW5yRb5MbRUz9Ot64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iO6AeelHTCg/Jv8imzQyVlCfQXSuwfwM0ob8pKcmDcaZAiYfwe1gQGfry85hQVPoJYy6GIlFQ4hw2hQ4lwpwRgmFACJYucSnPTDeXitlriijzM/mXj/m9JdnA6q24PDQr8SKQyUGaVmRWLJhNnMhS9+kzTSEi5sFUWapmj3Wtqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hDEK0dRz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hDEK0dRz"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso4079953a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 11:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763147651; x=1763752451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqFSHDCPRksQdHdUyv1FMM63cJMW5yRb5MbRUz9Ot64=;
        b=hDEK0dRzjwmtrRvi0fgEo2jGlsHZTDRoKQnuQZ0Pfp3pmiPC2nUmycKDUEF6JVDwaN
         7pwZdTiUiqpmWpRJLpwKAyCTYLgRavx5O7NaOa3L3hIs00A2/bVHgkSRX0IoBcVWzdo+
         aCAwbVOp0PbUYq+hdTgKmtYNVwDRPuAi7Uo3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763147651; x=1763752451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sqFSHDCPRksQdHdUyv1FMM63cJMW5yRb5MbRUz9Ot64=;
        b=PHU3VlTCDYRA2n0ZqYjvINhzJvG+cbuHbPcyw+hKiuOyQSQT/YaH1eo8Ej7Om1+VXH
         69MqONNSva6utJwWtGkdY8LyMF65cns0bvmXX7nFViReR6y+asfoRGpkqT6eg26GdKtV
         9Fh/OViq1XXg0TBvFqvBtg0Qyu5uuah8ag0nWAgWzVZhKxP+a1gHO9G3XnKTZGD55uyN
         gRoicNmfM+MYuvG7ms9+W2jVVCJySYfUQlHW4PrrqMKqPQN9noQidtcnUdedU1zkM3/Y
         9ijkTYAAo1SWAHi7t5aD9HCMHIzFvVToijQ+ILp7GCBNewKMF9sfQoeHeIRhHsZVUaEI
         dLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlD74nIskx6NI1wKffwuq9xVRyoBtCgvMMv7OAtZGWFy0HG8XMIeY11UKCndzNXjC/2aj3gFX6OLm2QYr/M+XY@vger.kernel.org
X-Gm-Message-State: AOJu0YxKtRJnd8csIfEQXq4oS7TrtygI44KKrbTCE2w68yF93e+e6kwG
	Wf4bxDvAtObyc9+WO9Zzi/SDfrVtWPFm1+idEq8qahm37RuRzcQUgmuMDdrk4WTQHpAux03ftC9
	LCGw+U61e
X-Gm-Gg: ASbGncsuU2RjpFCfKJa8fM7xwhXdXTLjRwhfO8ivGu/iaExwgXPz3d+xDVKiydi7uqT
	k2NoT2KlvB48rGoLJxpTNAqvdUjtZdZf1+0JiHD+0100/mAlUc04m8VEKumuudAWlqJvooGcXDU
	Andqkk7k+PSYW+kEPrUuDTZu+X/IxvPmCR65pumwSzmpWsmJHXWA+CvMpztmI+xAqF7i6vC1e/F
	0VlP7WkE+3jcxZykkCeXBm8DkP8qzj7bNPgwK9ZXC9pB+APNgjvaD1nvGyAVc4D8SoGOm65Rmfa
	jJJWudfB/CSNV3dVNiWAJM8nPq4LqtIVmrPwM77f2fAeVlDWSEDhptlx3tehaQ959rd59pO/wxd
	5OJmOS7ilO3/0uuiPaoevPtn5mlQc/82Ke7l7OLCdFviIGtkdur3yg113ueBV7H+MgJdpufd68i
	Q1QfjmHT5j71jhgYllGp2Hkfd3TsY9yGtYivQ8geK0VOC9CCQIFw==
X-Google-Smtp-Source: AGHT+IFQeHwsNf1SOj9Q5jMPM2CiZ0bNsHlFK6cSL8B+n1T5/wPLdkDTUHVYp1JMUmweVr9bj6DUUw==
X-Received: by 2002:a17:906:c153:b0:b73:5c12:3f8a with SMTP id a640c23a62f3a-b73678d2c5fmr503671966b.18.1763147651210;
        Fri, 14 Nov 2025 11:14:11 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad456bsm449818066b.21.2025.11.14.11.14.09
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 11:14:10 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b427cda88so1708025f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 11:14:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdZnsaATliTbleACQqVCHuB3OGZt/9OxDeNUPg7lvpXumtWKfhLujbhryN090c0Enp14NjHxEUojA50a3YL6t/@vger.kernel.org
X-Received: by 2002:a05:6000:178c:b0:429:c14f:5f7d with SMTP id
 ffacd0b85a97d-42b59367935mr4118712f8f.29.1763147649019; Fri, 14 Nov 2025
 11:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114033243.76509-1-cuiyunhui@bytedance.com>
In-Reply-To: <20251114033243.76509-1-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Nov 2025 11:13:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vh-guJS+5BAqhao9aECtkRFgoqEjpzhuDYEsRVqtVA6w@mail.gmail.com>
X-Gm-Features: AWmQ_bljLqXqDOKTQP59kORhab2-SwO6F5Qm44XiGdi2quOMGlF7tExq5Grrg24
Message-ID: <CAD=FV=Vh-guJS+5BAqhao9aECtkRFgoqEjpzhuDYEsRVqtVA6w@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add HARDLOCKUP_DETECTOR_PERF support for RISC-V
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

On Thu, Nov 13, 2025 at 7:33=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> After discussion [1],[2], hardlockup_perf cannot be completely replaced b=
y
> the hardlockup_buddy approach, so this patch is still being submitted.
>
> v1->v2:
> The contents of arch/arm64/watchdog_hld.c are directly consolidated into
> kernel/watchdog_perf.c.
>
>
> v2->v3:
> Add CONFIG_WATCHDOG_PERF_ADJUST_PERIOD to enclose the period update logic=
,
> select it by default on arm64 and riscv, without affecting other arches
> like x86 and PPC.
>
> v3->v4:
> Place the line "select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR=
_PERF && CPU_FREQ"
> in the Kconfig files for arm64 and riscv in one line, with no line breaks=
.
>
> v4->v5:
> Remove __weak from hw_nmi_get_sample_period()
>
> v5->v6:
> Removed the dependency on CPU_FREQ for WATCHDOG_PERF_ADJUST_PERIOD in Kco=
nfig, which fixes the
> issue reported at: https://lore.kernel.org/oe-kbuild-all/202510240701.eB6=
r97V3-lkp@intel.com/

I haven't tried compiling this myself, but it seems like an OK
solution for the compile-time error to me.

-Doug
