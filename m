Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B74931E0FB
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830391; cv=none; b=SiEytQjPOxQN1XPBWvAfrt7C64ArsY/XtVQsJCZZBsg+sUG0fZd6aaEQjEtQXbL52ymIL8XdKyuh3h65u5EBKCeH24oyp3ivCbH2BSoS8QQC5fjdxYl2lFy8spme4wBQUVnY2Rv+2hgGpubMHie+8935332FouTddjjXZ1eaK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830391; c=relaxed/simple;
	bh=iVx06PTeCxzGYx2jF50RHht/e08nwcSbQkNnRSnRuvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJ1QHdmnwAmLeCkORfF0HxjuZuaXN0FYtzmTKr/iEgOnd/j48pLpUD5ht/S95eJqOppq0cxfpzfHYvtS5uNoTW6fOyVZziLDYo9y6aL9vHYkRtRIuShKAs0QM7Z3yupCmvsZTQR852LXGvy/CtNWFRunCWHHKpa3TSqALKFPNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oQ91uZYG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oQ91uZYG"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-780fc3b181aso900159b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758830389; x=1759435189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAdEQBdz9dDV+qB/r+6Q6b9tiykVbAuQh1lcreO6d6U=;
        b=oQ91uZYGzKT4wsjTBrpBn7m28uoPGv4kTw9cxeaPsx4S4LpGIlrBJB49r7KiyUUJ/d
         roEBIlEbm4GROYo8lLS7PSAs5OKzS3rk9xLFZjzx7ryBkYmgMG5V3Y6DBomRWFS9O6iJ
         0J0+OEss55eDvIzt1Cxu5/zAB2skNwQpg9C0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758830389; x=1759435189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAdEQBdz9dDV+qB/r+6Q6b9tiykVbAuQh1lcreO6d6U=;
        b=LLU+h1eIH7g7zTYjANF/h6g1vEfhDp1MaT0LBWNlQ8rcRILvK+6swu6TJJxQB4KIVu
         DiR/a9lfFUlVpFBsnSUeOyXi4p4wsNZOctW3XzUkHv5Qy1aKPPK2S6PnlYzOvWK8/IGp
         mWHzvnL5dNBYBEPm8IYO+tQwPVZVKicKY2KpF8QmmqF9uFP7jacuRniaS7CcJ3HkcnUS
         DL0xs+hWR/6reEai0VpK3NHXZHej/Yglohe65RWWTnfJq1rCmvT8zbONVnujpzG9Gati
         aUTcQBp7i0Mca/5pLIRmRcNuEva4xoPrkTCNpZ2XtygOmTUaJACsriw2Ef77iQ10JcPW
         EI7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaLLTgBG3TRGoxb7vOOhLjk3eDgMvFxBpazvEZVZck1BmqJynATKlWwapR9UnApkowzwlPnhaFHlJw3A2aMyCr@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPdKu/Yr6rDQYYGULGIg/yTOXJ7tYEYZj04yEM7/sHa0bewHX
	jZgT14slufnHeJw1LQ8Ylmh+nC9jhattX5VyYtTj4XDfUYkobx5P++uU8wWPMMpaVzeNdeh/7VF
	MKqY=
X-Gm-Gg: ASbGncuE38A/EKvt4vItDEP+pr9p2YI38bB74IbOtOpPTtIrIrWYJLxdaZ+4qIBz4WM
	FX3urCrmU0JgL5R4LFtPPKtd/5erYW4cSkXGGpPih0/0jzmpkBp9SFp9hRM2FgMeASE+oKqTs8A
	wifOKkAJsO7cYSf44MSUYoc5P7jTha9G1TqTXED+XrYC/a1Evbjkr2QSDPu6Ss7KDjq0BueP9Ct
	m6MG9sgrVU4vcVsbp+V7VNGuKJwgQ9nMMWexMfgMTPofwWRZ+qHWqn8zRtLXVghreyqoxCTJQwE
	d0knOOdXOrC9i1jIGAh1Rz6PN6nwB+6aS8UqkMmEedzwJQ/t3lB+HNbXJ9pUHRD9qA5TpiXggpo
	9pjwVnVHOikmL7UmN578W1ECQ4Jtj/2ttvBzrbUc7ebkICISzGaVN2KnsE6qh5UD0DXDMvnYLX6
	ca
X-Google-Smtp-Source: AGHT+IHwx8hsr/g2cVQBL6lqYvfm1BbEVqwIcvSqAIhqVdmFOQM3xIDiW96ciTykh7gv2eXyJHJ4uA==
X-Received: by 2002:a05:6a21:6da9:b0:2b9:b64:5a9e with SMTP id adf61e73a8af0-2e7c5090403mr4681961637.9.1758830388958;
        Thu, 25 Sep 2025 12:59:48 -0700 (PDT)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com. [209.85.214.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a1bafsm2851454a12.43.2025.09.25.12.59.48
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:59:48 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2681660d604so13643435ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 12:59:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5/Z+4N7Rld9DjYVr+gSiJGdYN2yMFYtqOJJa7v0JLoiRMXr6Ori3rhiFjLqAjtoRtYns+JaMZcdKfrgzqj6BN@vger.kernel.org
X-Received: by 2002:a17:902:ec8b:b0:26a:f6e6:ef4f with SMTP id
 d9443c01a7336-27ed4a78d67mr40499335ad.60.1758830387808; Thu, 25 Sep 2025
 12:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com> <20250925084806.89715-3-cuiyunhui@bytedance.com>
In-Reply-To: <20250925084806.89715-3-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Sep 2025 12:59:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VpCZzw24VH4DAvt5UhZHJD1TMO-t5HB8Kfw3pw+jO7sA@mail.gmail.com>
X-Gm-Features: AS18NWCOLLpqvX90nBBWu9Muo_va5K9CeZWn93TLpPGzigEq33VTJanz9wj8IRk
Message-ID: <CAD=FV=VpCZzw24VH4DAvt5UhZHJD1TMO-t5HB8Kfw3pw+jO7sA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
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
> Enable the HARDLOCKUP_DETECTOR_PERF function based on RISC-V SSE.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/Kconfig           |  3 +++
>  drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index badbb2b366946..bb4e8c5a18717 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -186,6 +186,9 @@ config RISCV
>         select HAVE_PAGE_SIZE_4KB
>         select HAVE_PCI
>         select HAVE_PERF_EVENTS
> +       select PERF_EVENTS

I don't think you want to select this, do you? Just depend on it?

Other than that, this looks good to me.


-Doug
