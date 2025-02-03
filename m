Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DAF1D95B4
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611867; cv=none; b=EuXCdv6R5jGbS8+OVX4Scemmi3irzqnqrkQBlpxXA50Qrcwi415+8fvspV+eY7Oveq5urteqUSk3/TmXpGa6NRag6Nf+0omjk3MAb/YjMy/JiRdocFsZEv+hX4d6UJQk/y+8/MUDScsWm/KooXI7991x19YAFXJUfBt6RqTR7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611867; c=relaxed/simple;
	bh=nrAlE666rFAn1ngWhdaEaAsW5DAnVjyGQuoCKVEqwgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TV9IIuUminezY51ALUCtYTqJsbzBJTxC+eCbUOQy1SZJ099J8VtFpMfi/ifRGITcrMJb9MrEcCdXX07vY/+XV53nzUiaReBn+D+CMnqtdqSKUYIlip235lwVgzl95Z5yHjxXC474Dz+buTR4nI+mdYcT3cigWCsBODJzLltlgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nwf/Gmxo; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwf/Gmxo"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso17085ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 11:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738611864; x=1739216664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ArIi6EcPdEJOdtVrxaQGxMJGADVRBcROw3Hql8dm4k=;
        b=nwf/GmxometKYcz119XGZe22PdcJgKnlqv/4zwZSkBYbdK27aHtl3ooZv+kv8Mf/XW
         ZDvhkEtfYA4z/CV2zjxCNRYijQYaHfC95JYT0uF+c06dW0qsEYWrSJ2Har2tcjItYOvh
         iRs2hgb812xNx6Ml2Ny6sBZT08GYYZuWDxr0KKl7zW7zaxzP6UM9ZuB1HCmrFvSL5HOT
         ltRkfPMDvT+PNeKjYpf7DvFIWPqaHATjlwDlaxzJHwivHWpgKJPo2MBwwb38PANqpMtZ
         6kEWUSpYSaggTX912Tr8DuWGoazzkffPp6xmqCRZg+TGHtwqLae6aoMWenwcp0YqUX8W
         v99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738611864; x=1739216664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ArIi6EcPdEJOdtVrxaQGxMJGADVRBcROw3Hql8dm4k=;
        b=DbqdXpOFO/mEYsXMe8KPQqGHSCZMy1yiRM8//7qChESM2R9JoSswez5SpV5zN7ZhHj
         8sf6THjQBFL+FgLf6IyFBdM0lbkXeSnWaIy8XR7orTQ+NHfIc7R6dtDkbf21Rsl9WLoT
         jCglilGSbQ5y+Zvo1qyhLY28LU+xb1W6Mx2Mb95BNsoaPe6EqkePpt0iArgM6eOKP1DT
         YILq/q8/2vClXiLNl62OckCxKDrzu081mpt2oLMxcS5Fv/++59MBD/8tmGvC0DXaDAtm
         QjbKRTTF/7hMY5ripOcjroRdlcEWVud3ZooPIraZgJFCnsrTSbxXcr6drhM9VMZv3V89
         a87Q==
X-Gm-Message-State: AOJu0Yyb7egXJbvevfmPBM8uNT0r16FVJcWeoLGJxl7kg5m+QoQsiBm7
	uigLBEwuXwcDVmmpcWkbeMdZ+VodvTe5Tmac7LdAwg5iQprmgtRBUzW749V16l/07v8fR0KXn2k
	QRX3jpO+7aRQ4G9nYGdro78L7wkl9JcJ7KX9N
X-Gm-Gg: ASbGnctqVJqM1iakT9VD9d7OPx/ch3Y+F+0/+fwhQw9bHS0LPd60gDiBfxkimU+X+6x
	Fg/M1ls35pSTmyfpg2A/ACPhlRt26fcvmA03xICPADS1YhW1Qsok+PlDlwfOCyqgjYhCPPb91Yc
	RRxzgdRvD8aNODFIIGpV8ejYw=
X-Google-Smtp-Source: AGHT+IEAmexK7LtMhHP5yPwIjwGzN/4IYmaeMLcEzOJUJ5x3CNal4YKNr7gDAk2rntJ7Myd9EoKGnFGBTf6Ew5YrrCQ=
X-Received: by 2002:a05:6e02:1b03:b0:3d0:a9b:bf4b with SMTP id
 e9e14a558f8ab-3d03fbc124emr431565ab.12.1738611864470; Mon, 03 Feb 2025
 11:44:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025020304-chip-trench-4e56@gregkh>
In-Reply-To: <2025020304-chip-trench-4e56@gregkh>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Feb 2025 11:44:13 -0800
X-Gm-Features: AWEUYZnP0BxdeiIlpIvjMP_0h8pDl8-n2R3WbSzT7UXkDfCMvuT3h9jntgd4m88
Message-ID: <CAP-5=fXwprvLc3ubPmAuyUaTL2aD1frqL+RHJzkp8oe5z85oRw@mail.gmail.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own location
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 11:25=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> In sysfs, for some reason, all pmu devices seem to show up in the "root"
> of /sys/devices/ making for a confusing mess as these devices are not
> really at the root of the system at all.
>
> Create a fake root devices, "pmu_bus" and place them all under there if
> they do not already have a parent device set, cleaning up sysfs to look
> more sane.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: "Liang, Kan" <kan.liang@linux.intel.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>
> Note, if you all don't like "pmu_bus" for the name, that's fine, please
> let me know and I can rename it to something else, but it should be
> something to get these objects out of the root sysfs directory.

Excuse my ignorance, does the event_source bus already provide a
similar solution?
```
$ ls /sys/bus/event_source/devices
breakpoint   i915       msr         uncore_arb     uncore_cbox_3
uncore_cbox_7              uprobe
cpu          intel_bts  power       uncore_cbox_0  uncore_cbox_4  uncore_cl=
ock
cstate_core  intel_pt   software    uncore_cbox_1  uncore_cbox_5
uncore_imc_free_running_0
cstate_pkg   kprobe     tracepoint  uncore_cbox_2  uncore_cbox_6
uncore_imc_free_running_1
$ ls /sys/devices
breakpoint   intel_pt     platform    uncore_arb     uncore_cbox_5
         uprobe
cpu          isa          pnp0        uncore_cbox_0  uncore_cbox_6
         virtual
cstate_core  kprobe       power       uncore_cbox_1  uncore_cbox_7
cstate_pkg   LNXSYSTM:00  software    uncore_cbox_2  uncore_clock
i915         msr          system      uncore_cbox_3  uncore_imc_free_runnin=
g_0
intel_bts    pci0000:00   tracepoint  uncore_cbox_4  uncore_imc_free_runnin=
g_1
```

Thanks,
Ian

>  kernel/events/core.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index bcb09e011e9e..786537faed2c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11767,6 +11767,11 @@ static const struct attribute_group *pmu_dev_gro=
ups[] =3D {
>  };
>
>  static int pmu_bus_running;
> +
> +static struct device pmu_bus_root =3D {
> +       .init_name      =3D "pmu_bus",
> +};
> +
>  static struct bus_type pmu_bus =3D {
>         .name           =3D "event_source",
>         .dev_groups     =3D pmu_dev_groups,
> @@ -11790,7 +11795,10 @@ static int pmu_dev_alloc(struct pmu *pmu)
>
>         dev_set_drvdata(pmu->dev, pmu);
>         pmu->dev->bus =3D &pmu_bus;
> -       pmu->dev->parent =3D pmu->parent;
> +       if (pmu->parent)
> +               pmu->dev->parent =3D pmu->parent;
> +       else
> +               pmu->dev->parent =3D &pmu_bus_root;
>         pmu->dev->release =3D pmu_dev_release;
>
>         ret =3D dev_set_name(pmu->dev, "%s", pmu->name);
> @@ -14232,9 +14240,17 @@ static int __init perf_event_sysfs_init(void)
>
>         mutex_lock(&pmus_lock);
>
> -       ret =3D bus_register(&pmu_bus);
> -       if (ret)
> +       ret =3D device_register(&pmu_bus_root);
> +       if (ret) {
> +               put_device(&pmu_bus_root);
>                 goto unlock;
> +       }
> +
> +       ret =3D bus_register(&pmu_bus);
> +       if (ret) {
> +               device_unregister(&pmu_bus_root);
> +               goto unlock;
> +       }
>
>         list_for_each_entry(pmu, &pmus, entry) {
>                 if (pmu->dev)
> --
> 2.48.1
>
