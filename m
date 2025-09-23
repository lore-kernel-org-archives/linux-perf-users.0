Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7730E829
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758607938; cv=none; b=QHRj2dq7e2D/UckjKKGrzZQNMq/bhjyass2VA0viw7LXUGw8pUbN/pfySBbGsuefA21Ns/cy0r4jQfloGlWEoMXA9Az1eMz9PQojZasM752gvroDfORMeagUiL4ZPRi6eN7BwrrBAyZb+vD8eunJTjhyHuBDMhACjSsBSj71BM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758607938; c=relaxed/simple;
	bh=JS+mgHQ2vIQQdgKuXUmiMSrAVGDj2DfRWQZOWqaCyyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaM4i7p+mkzMUoXYcSw4fSwUPC8Og+KiiZBNzB6Y5fQjtQfL0/FC9DPi3E/+pTvce0WYDgO+zIWwsKu2ftbB4LDlX8bpgU+ULT9GLn+2HxlrUvJYwley8qam1nlYWZC2dC0+jr5e3IsYVch0aI9szP29zSBaYJqIlqf06BOnot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h5wx1SZd; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h5wx1SZd"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-34049023e98so734966fac.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 23:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758607934; x=1759212734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otbxpskZQ2jszr6scN/t0l115iHPynAVTy5cD9xe/9s=;
        b=h5wx1SZdIeKttxtB+tEtrI3HytRNqgOnqG5NlWKmtaftTIAQL/ZaTWrrSgITugT/7l
         p+VwwNHcNYL/SYYCVdrMX1jE+DEgeW5WbGjf4a5zaggN1bwVL7tnNetxjkBE9MAxfvhk
         GeeYZwVynbyVWCw2bbTFXtkGQGiHMHC05OrC7oNZkz9dq9z3yl2lzmzP2a9soXTzmbC0
         yQUNIurtnxDRZ69dzdEf7Pp2tDRedIjrEg1SJDVWP48c0G3dfUQ7BFnndiYWBk5SGd5g
         2bUQNc+oE439X4RVo7YJuE47E1yq1fnh9zzpeP5t2W6R5Dtvya7/F7GNk39+Go9kPkAU
         nGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758607934; x=1759212734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otbxpskZQ2jszr6scN/t0l115iHPynAVTy5cD9xe/9s=;
        b=rykXiCgC4rp7tmYp9hlTqLUeSaLXsPYvHh5Wo1Gk6yByw6GvmZcd/qX07cPTZvGj0d
         tBK4t6zpCbXNkmDOvlSPsZU++YoWG+SeMO3Y2fltomrL5DZCpV69lSjJGsSjMKGl2qK2
         sU6k87lUlvkXmnuc+5W4qSDlPpEns+j6KR3bIpTMkP4iRJSCkldaZJnwypgCsbXdat3j
         YaFq56/Pv292bw0mhVfhxIDPVD4ljZwCakNuu2JOwKPnY9bsi28xjcm03Vcffm7uyD88
         kSypwByZdFuEZVYvIKQO196aMHp4KP7YcWzr3VMib1dkop7oQDUvKhhb6LX6uNF8UTOa
         ED7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvSHFX8nQcxGGXLYSETbAUQJoy5u5fKZ8plDhx9vht+ws9IS50SsxvzjpBNH3Oa8UTE5e26vBLTVZH+z9fYkY9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyth9CGF4TVRWmU9m+rFbrlcYn7hu+ek30g60dAL+HjpaYNpoud
	cn6iAGLdpeLYj1Prlrnubyj23AmMUQkzMW1K5tEiIaCYxmWO1mfq86SbZnRS0t4gc18CfB4azn4
	zePyg/Qo1iurJz+w3pmzOEENcTGOfoPaohF7fxKTfKg==
X-Gm-Gg: ASbGncvsZTRv0/5R2iLpqeApFCifp0u5stpIcUwz5yKp5DUW1gcWQZ18d4RSfAvqqV3
	mhhUmz+s5pJrN0OLNqGe1hF9qcMlb2paS96jOvHCeO+t9dr97Jil6yvWB5Z8bJPnJmwT3Cy5dMz
	8R4FwjxrORqltJmdXKL+ZuNBMVshM1bXN1Fo8YQQlk9vMFs5R2q7Iv3AXSGoJo3HvYdxNlhD2ea
	93Gg/pa8hafMcqqDPvWG7pM3To=
X-Google-Smtp-Source: AGHT+IEIzs7n1nl91TIN023GUF0KUu3vYki89SdmZKUjsJa36BUfXx8eHWGEvtkrF3jtxJ7k3zA0vEDE+kHUSzoN6S4=
X-Received: by 2002:a05:6870:6591:b0:2d6:245:a9b3 with SMTP id
 586e51a60fabf-34c7b236bfemr746748fac.6.1758607934210; Mon, 22 Sep 2025
 23:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com> <20250327-counter_delegation-v5-12-1ee538468d1b@rivosinc.com>
In-Reply-To: <20250327-counter_delegation-v5-12-1ee538468d1b@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 23 Sep 2025 14:12:03 +0800
X-Gm-Features: AS18NWCpz0zRDa7TiIE6jd6ds8giKZBrxub6MRRgBhuLhQx-LIu9q4wyCfRpBus
Message-ID: <CAEEQ3wm-TGcRFjmb7cw5K-M13CicwgJSLZrgY1KMZA5SgUjziw@mail.gmail.com>
Subject: Re: [External] [PATCH v5 12/21] RISC-V: perf: Modify the counter
 discovery mechanism
To: Atish Patra <atishp@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Atish,

On Fri, Mar 28, 2025 at 3:42=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> If both counter delegation and SBI PMU is present, the counter
> delegation will be used for hardware pmu counters while the SBI PMU
> will be used for firmware counters. Thus, the driver has to probe
> the counters info via SBI PMU to distinguish the firmware counters.
>
> The hybrid scheme also requires improvements of the informational
> logging messages to indicate the user about underlying interface
> used for each use case.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_dev.c | 130 ++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 96 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
> index 6cebbc16bfe4..c0397bd68b91 100644
> --- a/drivers/perf/riscv_pmu_dev.c
> +++ b/drivers/perf/riscv_pmu_dev.c
> @@ -66,6 +66,20 @@ static bool sbi_v2_available;
>  static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
>  #define sbi_pmu_snapshot_available() \
>         static_branch_unlikely(&sbi_pmu_snapshot_available)
> +static DEFINE_STATIC_KEY_FALSE(riscv_pmu_sbi_available);
> +static DEFINE_STATIC_KEY_FALSE(riscv_pmu_cdeleg_available);
> +
> +/* Avoid unnecessary code patching in the one time booting path*/
> +#define riscv_pmu_cdeleg_available_boot() \
> +       static_key_enabled(&riscv_pmu_cdeleg_available)
> +#define riscv_pmu_sbi_available_boot() \
> +       static_key_enabled(&riscv_pmu_sbi_available)
> +
> +/* Perform a runtime code patching with static key */
> +#define riscv_pmu_cdeleg_available() \
> +       static_branch_unlikely(&riscv_pmu_cdeleg_available)
> +#define riscv_pmu_sbi_available() \
> +               static_branch_likely(&riscv_pmu_sbi_available)
>
>  static struct attribute *riscv_arch_formats_attr[] =3D {
>         &format_attr_event.attr,
> @@ -88,7 +102,8 @@ static int sysctl_perf_user_access __read_mostly =3D S=
YSCTL_USER_ACCESS;
>
>  /*
>   * This structure is SBI specific but counter delegation also require co=
unter
> - * width, csr mapping. Reuse it for now.
> + * width, csr mapping. Reuse it for now we can have firmware counters fo=
r
> + * platfroms with counter delegation support.
>   * RISC-V doesn't have heterogeneous harts yet. This need to be part of
>   * per_cpu in case of harts with different pmu counters
>   */
> @@ -100,6 +115,8 @@ static unsigned int riscv_pmu_irq;
>
>  /* Cache the available counters in a bitmask */
>  static unsigned long cmask;
> +/* Cache the available firmware counters in another bitmask */
> +static unsigned long firmware_cmask;
>
>  struct sbi_pmu_event_data {
>         union {
> @@ -780,34 +797,38 @@ static int rvpmu_sbi_find_num_ctrs(void)
>                 return sbi_err_map_linux_errno(ret.error);
>  }
>
> -static int rvpmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
> +static u32 rvpmu_deleg_find_ctrs(void)
> +{
> +       /* TODO */
> +       return 0;
> +}
> +
> +static int rvpmu_sbi_get_ctrinfo(u32 nsbi_ctr, u32 *num_fw_ctr, u32 *num=
_hw_ctr)
>  {
>         struct sbiret ret;
> -       int i, num_hw_ctr =3D 0, num_fw_ctr =3D 0;
> +       int i;
>         union sbi_pmu_ctr_info cinfo;
>
> -       pmu_ctr_list =3D kcalloc(nctr, sizeof(*pmu_ctr_list), GFP_KERNEL)=
;
> -       if (!pmu_ctr_list)
> -               return -ENOMEM;
> -
> -       for (i =3D 0; i < nctr; i++) {
> +       for (i =3D 0; i < nsbi_ctr; i++) {
>                 ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_IN=
FO, i, 0, 0, 0, 0, 0);
>                 if (ret.error)
>                         /* The logical counter ids are not expected to be=
 contiguous */
>                         continue;
>
> -               *mask |=3D BIT(i);
> -
>                 cinfo.value =3D ret.value;
> -               if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW)
> -                       num_fw_ctr++;
> -               else
> -                       num_hw_ctr++;
> -               pmu_ctr_list[i].value =3D cinfo.value;
> +               if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW) {
> +                       /* Track firmware counters in a different mask */
> +                       firmware_cmask |=3D BIT(i);
> +                       pmu_ctr_list[i].value =3D cinfo.value;
> +                       *num_fw_ctr =3D *num_fw_ctr + 1;
> +               } else if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_HW &&
> +                          !riscv_pmu_cdeleg_available_boot()) {
> +                       *num_hw_ctr =3D *num_hw_ctr + 1;
> +                       cmask |=3D BIT(i);
> +                       pmu_ctr_list[i].value =3D cinfo.value;
> +               }
>         }
>
> -       pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num=
_hw_ctr);
> -
>         return 0;
>  }
>
> @@ -1069,16 +1090,41 @@ static void rvpmu_ctr_stop(struct perf_event *eve=
nt, unsigned long flag)
>         /* TODO: Counter delegation implementation */
>  }
>
> -static int rvpmu_find_num_ctrs(void)
> +static int rvpmu_find_ctrs(void)
>  {
> -       return rvpmu_sbi_find_num_ctrs();
> -       /* TODO: Counter delegation implementation */
> -}
> +       u32 num_sbi_counters =3D 0, num_deleg_counters =3D 0;
> +       u32 num_hw_ctr =3D 0, num_fw_ctr =3D 0, num_ctr =3D 0;
> +       /*
> +        * We don't know how many firmware counters are available. Just a=
llocate
> +        * for maximum counters the driver can support. The default is 64=
 anyways.
> +        */
> +       pmu_ctr_list =3D kcalloc(RISCV_MAX_COUNTERS, sizeof(*pmu_ctr_list=
),
> +                              GFP_KERNEL);
> +       if (!pmu_ctr_list)
> +               return -ENOMEM;
>
> -static int rvpmu_get_ctrinfo(int nctr, unsigned long *mask)
> -{
> -       return rvpmu_sbi_get_ctrinfo(nctr, mask);
> -       /* TODO: Counter delegation implementation */
> +       if (riscv_pmu_cdeleg_available_boot())
> +               num_deleg_counters =3D rvpmu_deleg_find_ctrs();
> +
> +       /* This is required for firmware counters even if the above is tr=
ue */
> +       if (riscv_pmu_sbi_available_boot()) {
> +               num_sbi_counters =3D rvpmu_sbi_find_num_ctrs();
> +               /* cache all the information about counters now */
> +               rvpmu_sbi_get_ctrinfo(num_sbi_counters, &num_hw_ctr, &num=
_fw_ctr);
> +       }
> +
> +       if (num_sbi_counters > RISCV_MAX_COUNTERS || num_deleg_counters >=
 RISCV_MAX_COUNTERS)
> +               return -ENOSPC;
> +
> +       if (riscv_pmu_cdeleg_available_boot()) {
> +               pr_info("%u firmware and %u hardware counters\n", num_fw_=
ctr, num_deleg_counters);
> +               num_ctr =3D num_fw_ctr + num_deleg_counters;
> +       } else {
> +               pr_info("%u firmware and %u hardware counters\n", num_fw_=
ctr, num_hw_ctr);
> +               num_ctr =3D num_sbi_counters;
> +       }
> +
> +       return num_ctr;
>  }
>
>  static int rvpmu_event_map(struct perf_event *event, u64 *econfig)
> @@ -1379,12 +1425,21 @@ static int rvpmu_device_probe(struct platform_dev=
ice *pdev)
>         int ret =3D -ENODEV;
>         int num_counters;
>
> -       pr_info("SBI PMU extension is available\n");
> +       if (riscv_pmu_cdeleg_available_boot()) {
> +               pr_info("hpmcounters will use the counter delegation ISA =
extension\n");
> +               if (riscv_pmu_sbi_available_boot())
> +                       pr_info("Firmware counters will use SBI PMU exten=
sion\n");
> +               else
> +                       pr_info("Firmware counters will not be available =
as SBI PMU extension is not present\n");
> +       } else if (riscv_pmu_sbi_available_boot()) {
> +               pr_info("Both hpmcounters and firmware counters will use =
SBI PMU extension\n");
> +       }
> +
>         pmu =3D riscv_pmu_alloc();
>         if (!pmu)
>                 return -ENOMEM;
>
> -       num_counters =3D rvpmu_find_num_ctrs();
> +       num_counters =3D rvpmu_find_ctrs();
>         if (num_counters < 0) {
>                 pr_err("SBI PMU extension doesn't provide any counters\n"=
);
>                 goto out_free;
> @@ -1396,9 +1451,6 @@ static int rvpmu_device_probe(struct platform_devic=
e *pdev)
>                 pr_info("SBI returned more than maximum number of counter=
s. Limiting the number of counters to %d\n", num_counters);
>         }
>
> -       /* cache all the information about counters now */
> -       if (rvpmu_get_ctrinfo(num_counters, &cmask))
> -               goto out_free;
>
>         ret =3D rvpmu_setup_irqs(pmu, pdev);
>         if (ret < 0) {
> @@ -1488,13 +1540,23 @@ static int __init rvpmu_devinit(void)
>         int ret;
>         struct platform_device *pdev;
>
> -       if (sbi_spec_version < sbi_mk_version(0, 3) ||
> -           !sbi_probe_extension(SBI_EXT_PMU)) {
> -               return 0;
> -       }
> +       if (sbi_spec_version >=3D sbi_mk_version(0, 3) &&
> +           sbi_probe_extension(SBI_EXT_PMU))
> +               static_branch_enable(&riscv_pmu_sbi_available);
>
>         if (sbi_spec_version >=3D sbi_mk_version(2, 0))
>                 sbi_v2_available =3D true;
> +       /*
> +        * We need all three extensions to be present to access the count=
ers
> +        * in S-mode via Supervisor Counter delegation.
> +        */
> +       if (riscv_isa_extension_available(NULL, SSCCFG) &&
> +           riscv_isa_extension_available(NULL, SMCDELEG) &&

Is there no need to check SMCDELEG (Machine-level) in the kernel, and
can it be done directly via SSCCFG or sbi_probe_extension?
The #define RISCV_ISA_EXT_SMCDELEG 98 also doesn't need to be defined
in the kernel.

> +           riscv_isa_extension_available(NULL, SSCSRIND))
> +               static_branch_enable(&riscv_pmu_cdeleg_available);
> +
> +       if (!(riscv_pmu_sbi_available_boot() || riscv_pmu_cdeleg_availabl=
e_boot()))
> +               return 0;
>
>         ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
>                                       "perf/riscv/pmu:starting",
>
> --
> 2.43.0
>
>

Thanks,
Yunhui
