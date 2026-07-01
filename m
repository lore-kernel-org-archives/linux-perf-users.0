Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304833AD8B
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870210; cv=none; b=G5S2viuDnlZ6CuU/PbCwywTKuD3REdSIWujCjNu4RMfwlG44KVxJMq5CjW5tPc2EcUUoJdQSQgrDqk3BvTJQ4T10Jxk+HzCvQn0Ge0Drk6gfOrCCltqi+KUmlEbzguzNUhlPr1AOsoWhi+P0krNRNkNk1P4Mj8Ow/pOcwgUB+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870210; c=relaxed/simple;
	bh=Tr/ognelDwnn+tppC96yXVE7WDS+dq6NSuJqOhWuVNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zy3+611nM5UUVwDUHgNXKZ0fuzb1bmPThMgdXh7EWlSl0k3fUQj1WjtdrGaHnzPhk47/9pwatoQnvtb8rz5mBkKKfQjTJJ0b4hE0YiDgLrm91icIrGv0Tyi5OhvYdUAMrllrJhjHvK1cnGrw0xCTTR35VNfQqIvJdRbnJ+yzxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUh2xsP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUh2xsP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B3D1F0155A
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 01:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782870207;
	bh=pgwo5Y2YVtSU5NJkiPPhD+usOSDvizU2sfk4E7Z4ajQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lUh2xsP7XV2H7rUr1KR28PmQbzhA2WM9r7gPWMLbUkWpcU9DUD0h+YFbmbJ95+C+0
	 O8lGO22mRrFTqwW53h0Ri3YMZWPtektXcmtOyAp37lRpVSnXKJbcaoXF7qi5YZkv+t
	 y5qnKIx1PW8fPqma7HfpJY53VCfAdcBzzE/fBFoYkhg0TBFZCCjB8+HjY2a92+PhCq
	 7sDdyGIfMpiq/QxyDWh4O17YZMVXVZqyddEbObXUzAlEO0lTqwduRlvEJZ8L8o99dB
	 1smK7PQNIE8fAMtK5QNCCt1vpAaV8fc4mS3IW8CY07/IgkgP4eKRp1N1Qneo6o9x95
	 7zbcxJl5fsSPw==
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47248615e4dso59716f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 18:43:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqbOB2o7xE2b2bbS0aPLQIjHwm8Afa8hLiHvuh6Qtc3FfZwA+N20GKmuJTtxOrqdh0vk9h2qENVTBwGS6GUa2dB@vger.kernel.org
X-Gm-Message-State: AOJu0YzqGj1SeXxsQVUbE4KJhkyNYIPoY9SRz0s+mDa0Q1H7ocEgOFvf
	vilHrH862H8mTAmZkVc8MrXMBTOexDEQaqYicVaYGmUsuNT2BCOxf1AADywlLweLTeXWMrxekIQ
	SdbLeXlj8Y0LuGaEUhseXqCfvgZFVbTU=
X-Received: by 2002:adf:e011:0:10b0:46e:8226:96ba with SMTP id
 ffacd0b85a97d-476582f5260mr3272401f8f.13.1782870205832; Tue, 30 Jun 2026
 18:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630083833.1275837-1-zong.li@sifive.com> <20260630083833.1275837-3-zong.li@sifive.com>
In-Reply-To: <20260630083833.1275837-3-zong.li@sifive.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 1 Jul 2026 09:43:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQfFEHp5BZtKRE4on-FMRuwBHZEtDn=g=L8=GaPH0uEyQ@mail.gmail.com>
X-Gm-Features: AVVi8Cfcy5cWO9H4sDPMuveM9pp9eeEvl4ZKMfbR2jpOIiJoFwyXdryNTJq0UMs
Message-ID: <CAJF2gTQfFEHp5BZtKRE4on-FMRuwBHZEtDn=g=L8=GaPH0uEyQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iommu/riscv: create a auxiliary device for HPM
To: Zong Li <zong.li@sifive.com>
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, david.laight.linux@gmail.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 4:38=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> Create an auxiliary device for HPM when the IOMMU supports a
> hardware performance monitor.
>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index cec3ddd7ab10..36ad4aa81465 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -14,6 +14,7 @@
>
>  #include <linux/acpi.h>
>  #include <linux/acpi_rimt.h>
> +#include <linux/auxiliary_bus.h>
>  #include <linux/compiler.h>
>  #include <linux/crash_dump.h>
>  #include <linux/init.h>
> @@ -565,6 +566,21 @@ static irqreturn_t riscv_iommu_fltq_process(int irq,=
 void *data)
>         return IRQ_HANDLED;
>  }
>
> +/*
> + * IOMMU Hardware performance monitor
> + */
> +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> +{
> +       struct auxiliary_device *auxdev;
> +
> +       auxdev =3D __devm_auxiliary_device_create(iommu->dev, KBUILD_MODN=
AME,
> +                                               "pmu", iommu, 0);

Using an auxiliary device makes sense here =E2=80=94 it keeps perf PMU logi=
c
out of the IOMMU driver and lets a dedicated driver handle
perf_pmu_register() independently. The devm-managed creation also ties
the auxiliary device lifetime to the parent IOMMU device, so no
explicit teardown is needed.

Reviewed-by: Guo Ren <guoren@kernel.org>


> +       if (!auxdev)
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
>  /* Lookup and initialize device context info structure. */
>  static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_devi=
ce *iommu,
>                                                  unsigned int devid)
> @@ -1613,6 +1629,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iom=
mu)
>                 goto err_remove_sysfs;
>         }
>
> +       if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> +               riscv_iommu_hpm_enable(iommu);
> +
>         return 0;
>
>  err_remove_sysfs:
> --
> 2.43.7
>


--=20
Best Regards
 Guo Ren
