Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29B1E52B
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Dec 2023 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vT9KG78U"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4258b6df295so61021cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Dec 2023 12:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702932208; x=1703537008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQbadrs3fzw7j82VkI2k0YgRL7ehExTxs0ThFn3Lgko=;
        b=vT9KG78UXIBVuCHt2PF9WFlO9Npb9thbFrDVJwxguuOvhOSJFvrgJYk2f7tI0l1wIO
         nYsrq65bNx2MAsoyMWOhIEUF2oGWq9Jee2jY6FoUORgQ4F0ZIV4Y1GZjtEqGjW7HyFoH
         rbuLVrnPvttSHJDj60NsLRUP2OCk2267iF7Row9ThWXZ7NH3zO0WhUMwPbSNrCn7q6y4
         HbQRuNbEZzJ44vobY1YG3HZTfJMxHX/V1JoozN339BVmAl+xTK/fuACX39jn71X3S4D+
         2SkCzklvewEjLVbXQua4PuzR8TlSZTArPAkyBXuXhyZXI1qILvJFtWnB8/3myxcAoG9G
         tASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702932208; x=1703537008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQbadrs3fzw7j82VkI2k0YgRL7ehExTxs0ThFn3Lgko=;
        b=Tvc46UlMDz93iUA/RfB8sGPVBsRdvOIf7Ogdu5BGZWrnxko0pbPptO0CoUIkNMCdEU
         8fVpvhj0bzbrdUHPRLB9Sy0mXdhDuxvnjqGL3qw9pmVRoEW1+kc3+iLBc6dnepbBWjGi
         pXcWcXwf7H1ghvAs8P9OY4G+yELGOqnPlQQbc1i3qOBKxWS/DxWiKKj8N2+EB2kw1g4A
         eMHZDMNkT7a9hJ5fujiBSI+m5ltARRtf/tf5EC6GlqS8zJnvVNRPsazoWZVpqYfczh4I
         Ts9VJGlu8KRcuopQypLFLm/ojLHyrGuBH7ZxWvql5pbVtQAmNl1zT/TLfij8/l7Czi61
         wbYw==
X-Gm-Message-State: AOJu0Ywoa7A9+QJ+xDJMCrvMHQIL29bmpGGaKSWeM0LW4Vau1H+nzFO+
	H76l3iqHl59PK79t4ZWO/+wsiqxb7dVkCyEBeoxGVxUaSZhjGIfQ39e3G26JYg==
X-Google-Smtp-Source: AGHT+IH8OGNLJHaR27LvAIMDHYRY6Wg57ug9Yz3HuZ/0f1hZpu8tQ5gVYqa4mqM4vmFoXcDuJnfUkSB21qszOYGHIMU=
X-Received: by 2002:a05:622a:148a:b0:425:9bac:cab0 with SMTP id
 t10-20020a05622a148a00b004259baccab0mr3406qtx.7.1702932207949; Mon, 18 Dec
 2023 12:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702833179.git.sandipan.das@amd.com> <1d9106579c7781746ca39860bda8061c56d6dc48.1702833179.git.sandipan.das@amd.com>
In-Reply-To: <1d9106579c7781746ca39860bda8061c56d6dc48.1702833179.git.sandipan.das@amd.com>
From: Stephane Eranian <eranian@google.com>
Date: Mon, 18 Dec 2023 12:43:13 -0800
Message-ID: <CABPqkBQ0Zn_orR_9FnHA7Y1pNHAzG0E=86MkdMjOtGfKXDp29g@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/x86/amd/lbr: Use freeze based on availability
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de, 
	bp@alien8.de, irogers@google.com, mario.limonciello@amd.com, 
	ravi.bangoria@amd.com, ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 9:26=E2=80=AFAM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> Currently, it is assumed that LBR Freeze is supported on all processors
> which have CPUID leaf 0x80000022[EAX] bit 1 set. This is incorrect as
> the feature availability is additionally dependent on CPUID leaf
> 0x80000022[EAX] bit 2 being set which may not be set for all Zen 4
> processors. Define a new feature bit for LBR and PMC freeze and set the
> freeze enable bit (FLBRI) in DebugCtl (MSR 0x1d9) conditionally.


Is this new feature bit visible to users?
I think it is useful to know whether or not LBR freeze is supported.
Imagine I want to do kernel FDO, then the user-only LBR trick to freeze LBR
does not work and I need actual LBR freeze support.

Thanks.

> It should still be possible to use LBR without freeze for profile-guided
> optimization of user programs by using an user-only branch filter during
> profiling. When the user-only filter is enabled, branches are no longer
> recorded after the transition to CPL 0 upon PMI arrival. When branch
> entries are read in the PMI handler, the branch stack does not change.
>
> E.g.
>
>   $ perf record -j any,u -e ex_ret_brn_tkn ./workload
>
> Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record suppor=
t")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/events/amd/core.c         |  4 ++--
>  arch/x86/events/amd/lbr.c          | 16 ++++++++++------
>  arch/x86/include/asm/cpufeatures.h |  2 +-
>  arch/x86/kernel/cpu/scattered.c    |  1 +
>  4 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 4ee6390b45c9..ffdfaee08b08 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -905,8 +905,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs=
)
>         if (!status)
>                 goto done;
>
> -       /* Read branch records before unfreezing */
> -       if (status & GLOBAL_STATUS_LBRS_FROZEN) {
> +       /* Read branch records */
> +       if (x86_pmu.lbr_nr) {
>                 amd_pmu_lbr_read();
>                 status &=3D ~GLOBAL_STATUS_LBRS_FROZEN;
>         }
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index eb31f850841a..110e34c59643 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -400,10 +400,12 @@ void amd_pmu_lbr_enable_all(void)
>                 wrmsrl(MSR_AMD64_LBR_SELECT, lbr_select);
>         }
>
> -       rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> -       rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> +       if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
> +               rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> +               wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE=
_LBRS_ON_PMI);
> +       }
>
> -       wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON=
_PMI);
> +       rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
>         wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN)=
;
>  }
>
> @@ -416,10 +418,12 @@ void amd_pmu_lbr_disable_all(void)
>                 return;
>
>         rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> -       rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> -
>         wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN=
);
> -       wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_O=
N_PMI);
> +
> +       if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
> +               rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> +               wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZ=
E_LBRS_ON_PMI);
> +       }
>  }
>
>  __init int amd_pmu_lbr_init(void)
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 4af140cf5719..9790e906d5e5 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -97,7 +97,7 @@
>  #define X86_FEATURE_SYSENTER32         ( 3*32+15) /* "" sysenter in IA32=
 userspace */
>  #define X86_FEATURE_REP_GOOD           ( 3*32+16) /* REP microcode works=
 well */
>  #define X86_FEATURE_AMD_LBR_V2         ( 3*32+17) /* AMD Last Branch Rec=
ord Extension Version 2 */
> -/* FREE, was #define X86_FEATURE_LFENCE_RDTSC          ( 3*32+18) "" LFE=
NCE synchronizes RDTSC */
> +#define X86_FEATURE_AMD_LBR_PMC_FREEZE ( 3*32+18) /* "" AMD LBR and PMC =
Freeze */
>  #define X86_FEATURE_ACC_POWER          ( 3*32+19) /* AMD Accumulated Pow=
er Mechanism */
>  #define X86_FEATURE_NOPL               ( 3*32+20) /* The NOPL (0F 1F) in=
structions */
>  #define X86_FEATURE_ALWAYS             ( 3*32+21) /* "" Always-present f=
eature */
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scatte=
red.c
> index 0dad49a09b7a..a515328d9d7d 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {
>         { X86_FEATURE_BMEC,             CPUID_EBX,  3, 0x80000020, 0 },
>         { X86_FEATURE_PERFMON_V2,       CPUID_EAX,  0, 0x80000022, 0 },
>         { X86_FEATURE_AMD_LBR_V2,       CPUID_EAX,  1, 0x80000022, 0 },
> +       { X86_FEATURE_AMD_LBR_PMC_FREEZE,       CPUID_EAX,  2, 0x80000022=
, 0 },
>         { 0, 0, 0, 0, 0 }
>  };
>
> --
> 2.34.1
>
