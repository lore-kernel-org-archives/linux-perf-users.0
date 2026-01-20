Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C72387564
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892539; cv=pass; b=BPJS4aqEWh1LN8vvGYFHuA8LUX3sniDc4F1DsY4434d1GA22x0c44b6Cv3Tj0bH3/KqQirQjGEAHyRbcvci9YOY0KEM+bQ4hGJtBUePkcHxe5R1DyFvnX3ONVbp3gYy1inQ+XPDCEP/MmpIQ1RiBv6K0sMEs5jvzcDwCqKTlCRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892539; c=relaxed/simple;
	bh=7CiU3xAcGmF0aGJSs6foaU4S5JpGb+sF6YMWhZkMbeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkLkIddwsmMDDCUIRgbEUS36oJVo6rd6Lr16nuyBim0Q+IkANU8aGnz3XRrdt/MLPGPBIutc1u7D3sngmtxClfPePc6hOdmL373u9xVTtWh2vDxEeW3VjFqaRvdCdeFwUFxtEtGvc87oSOb0IcGPEXKnZ+SSRxv4wEfxfiGzYeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzWXToMr; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzWXToMr"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11a247de834so17335c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 23:02:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768892528; cv=none;
        d=google.com; s=arc-20240605;
        b=c9IS2mWtlIlvV5q5Ggng75MhfEUCKnf+3AB5Y2Awd0ZpeIQxXU/jBD5ogdVI+Wni23
         QUD/lwA11jjlrl6OZ6GMQ1ZjIQF0B50a9LMkjWCysPpwDvwH0R2Ptj3J/uMCGvsDbXdl
         HqdU1NZocW6sRFIczjtQkLdLPq5nHPFxrKhhA4MOvikHYSRey/8aWPCIEekAOASZOuWr
         DDdZOEHf95vqgSZyurvpkJ51sWzedWcKBY4hT5QQ8LPGGYvFwRehVfBFdVvraX0NnPUP
         0wyK3dA9YSqNCSkTfZJM/ymxFePTrikzQEvsMOD9UzJu11SBfEhR1Wc5k0DlRiBZvpyK
         2tCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fGkZO0eAaLHjDvSQ8Jz+T4HimifGdYEoV7H1TT6lRf4=;
        fh=LJ43zqZJuxnU82MUerIC3+bRTHYSS/BMeU2gN3xyAvs=;
        b=QpEKlNy5KDcA0DtFQu0YOxmeBWGNAsiWIU6zvZtZBLiOafvlAC+9jgsvf3H7tZzd0o
         NvfBxwNYBeyj2b+/7dNr/jd4iSgV3Dfh94rPxn+LQ+6NOCwEtFdwxHTCCvU+HHZia9Rc
         +T2Hfr+QbvxnU+f8UuqVTtA4rgUp9Ma6Ak/RH+32fNUNgVGbv+2CLEtCMPx/HqwaNMl2
         Gi6f6DQf9V6kbHSz7MS2O0Of7bs8+alYyAqyhc5JRwFifNLW52NpHVsi3zbQiG0VFtS1
         L0ha5/G7blwL3l9pCbUHywtGtLwsPJ8FJUjUWKfJTlZRPOlO9SvHKd1TmkxeRgCNT4Uf
         HFwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768892528; x=1769497328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGkZO0eAaLHjDvSQ8Jz+T4HimifGdYEoV7H1TT6lRf4=;
        b=vzWXToMrSyp8uVzNtGnZACQTu3oiTFB0knkjnp3nnwhz0g5dRPqZCNMGWBHyep3Tou
         GqL6r1hhFUc01wR0jCKR/5YUeJydwlD0ZhQvKuY07/f7jFkaGpc2PYo0xShypAb9U4Qq
         mzJFjrdn8z2AHa4D1kkbMZMeku1CpDKfOb43Ox1Bpu3XdSexs0xUKbGTDR6An9X17bZC
         PYV90VYbLGoEMBuAD63yw15ygdRVmIeg+Wgfs79pxX++MEF/v1lcRHJlXeX7M+vYUfun
         iwGo62POGeov2MQBHZ7S4tlB+xL1eRszf6V0U8XUlt0T2sUh9q35JnZpcW269A+yR3Lk
         nLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768892528; x=1769497328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fGkZO0eAaLHjDvSQ8Jz+T4HimifGdYEoV7H1TT6lRf4=;
        b=An+qOyrRa16k/VwaCwrRAnl9hMIAkV0E2v6yYMsITGqZ6wDR3hMg04tTwm3QDeyKxh
         BwIRrJzMe2PHPW9cWz60uFOGWFfQEJBJAi4GZdBadHRJuV59V3+INEdnmTAEb8JP6/G+
         G/xQrl31AWUVvTwYA8ww4MOsZyCXhh3YOkByCLcO46bOGYMgzQqFFw/ItRsv9fN3ugnh
         HfQD/w6jLOyqMrOJoiZNAWirx/tzoirSH5/F8Ds6ECrWrTohpdtuKK1RmH8N1bAC8e31
         GLL8NnwZHv/sQKfVF65dl3Uet9/4PZ4+dBHYlHGmCzgea4u1xSSaDjdpev/ur4sSxoqK
         2wRA==
X-Forwarded-Encrypted: i=1; AJvYcCWGXfqxHwy1lFBc9oJCmmEPC15TS2Hs+JF0Ue+KX9eYiFWxUkUEBc8behSA8N4PXsfTdjSPSGk9D0LbaxeBKhzL@vger.kernel.org
X-Gm-Message-State: AOJu0YyCzGjaS7f8NET+PJQ7jwZQHD9SGJiSOmhqBMiln0+3Z+ybzibO
	LMT9Q+MWXCHCtUhIhBpnyKVAjP5Sbo3vH+dBWQKP6SXe8t2HO0kToiz7l1gB8bA13m9g9movf7B
	K0118kyTTt4tPxtGpiVzcyCFHt9fF8OQJlwOVBhE0
X-Gm-Gg: AY/fxX41KBPF35qdTwsps9IzLX5d51Cce7O1/W17Hk3D/qeaLhZWSTpxM/iTof+lHoS
	qj3WS95vYZy95Lqq3DDIzkPhNMpqKR3nl7TvpH8Ra6CB/9xOvVu8QPxZn6OXuvqmT9qQ3PVSZeY
	dNqHg4yZKO8xUoQIKb/fHB1E3WudvG3FuVnyKZdX/5J8IkBHp3j8UkRa2At8PIO88lXtzGnh3tN
	d+PjirswgllBLRxpfgNMfdSbXxX4Zxh6UJLjJBDHulTpPxxqyiaEpraOKPXf8rJ09VKN0Q272+x
	xkKXpeI=
X-Received: by 2002:a05:7022:3a08:b0:122:8d:3538 with SMTP id
 a92af1059eb24-12453d1b7afmr341750c88.2.1768892527682; Mon, 19 Jan 2026
 23:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com> <20251203065500.2597594-18-dapeng1.mi@linux.intel.com>
In-Reply-To: <20251203065500.2597594-18-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Jan 2026 23:01:56 -0800
X-Gm-Features: AZwV_Qh-r7UhxcY3tSCqqxMH7P1Mw0xupkyDp24GKStVEhfzo4po3isb5a7jBXw
Message-ID: <CAP-5=fUAOErzzU=tPk0adQkqqwnc7BU0FxNgKrXwWQUN=Qjoug@mail.gmail.com>
Subject: Re: [Patch v5 17/19] perf headers: Sync with the kernel headers
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 10:59=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Update include/uapi/linux/perf_event.h and
> arch/x86/include/uapi/asm/perf_regs.h to support extended regs.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/arch/x86/include/uapi/asm/perf_regs.h | 62 +++++++++++++++++++++
>  tools/include/uapi/linux/perf_event.h       | 45 +++++++++++++--
>  2 files changed, 103 insertions(+), 4 deletions(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86=
/include/uapi/asm/perf_regs.h
> index 7c9d2bb3833b..f3561ed10041 100644
> --- a/tools/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
> @@ -27,9 +27,34 @@ enum perf_event_x86_regs {
>         PERF_REG_X86_R13,
>         PERF_REG_X86_R14,
>         PERF_REG_X86_R15,
> +       /*
> +        * The EGPRs/SSP and XMM have overlaps. Only one can be used
> +        * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
> +        * utilize EGPRs/SSP. For the other ABI type, XMM is used.
> +        *
> +        * Extended GPRs (EGPRs)
> +        */
> +       PERF_REG_X86_R16,
> +       PERF_REG_X86_R17,
> +       PERF_REG_X86_R18,
> +       PERF_REG_X86_R19,
> +       PERF_REG_X86_R20,
> +       PERF_REG_X86_R21,
> +       PERF_REG_X86_R22,
> +       PERF_REG_X86_R23,
> +       PERF_REG_X86_R24,
> +       PERF_REG_X86_R25,
> +       PERF_REG_X86_R26,
> +       PERF_REG_X86_R27,
> +       PERF_REG_X86_R28,
> +       PERF_REG_X86_R29,
> +       PERF_REG_X86_R30,
> +       PERF_REG_X86_R31,
> +       PERF_REG_X86_SSP,
>         /* These are the limits for the GPRs. */
>         PERF_REG_X86_32_MAX =3D PERF_REG_X86_GS + 1,
>         PERF_REG_X86_64_MAX =3D PERF_REG_X86_R15 + 1,
> +       PERF_REG_MISC_MAX =3D PERF_REG_X86_SSP + 1,
>
>         /* These all need two bits set because they are 128bit */
>         PERF_REG_X86_XMM0  =3D 32,
> @@ -54,5 +79,42 @@ enum perf_event_x86_regs {
>  };
>
>  #define PERF_REG_EXTENDED_MASK (~((1ULL << PERF_REG_X86_XMM0) - 1))
> +#define PERF_X86_EGPRS_MASK    GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X8=
6_R16)
> +
> +enum {
> +       PERF_REG_X86_XMM,
> +       PERF_REG_X86_YMM,
> +       PERF_REG_X86_ZMM,
> +       PERF_REG_X86_MAX_SIMD_REGS,
> +
> +       PERF_REG_X86_OPMASK =3D 0,
> +       PERF_REG_X86_MAX_PRED_REGS =3D 1,
> +};
> +
> +enum {
> +       PERF_X86_SIMD_XMM_REGS      =3D 16,
> +       PERF_X86_SIMD_YMM_REGS      =3D 16,
> +       PERF_X86_SIMD_ZMMH_REGS     =3D 16,
> +       PERF_X86_SIMD_ZMM_REGS      =3D 32,
> +       PERF_X86_SIMD_VEC_REGS_MAX  =3D PERF_X86_SIMD_ZMM_REGS,
> +
> +       PERF_X86_SIMD_OPMASK_REGS   =3D 8,
> +       PERF_X86_SIMD_PRED_REGS_MAX =3D PERF_X86_SIMD_OPMASK_REGS,
> +};
> +
> +#define PERF_X86_SIMD_PRED_MASK                GENMASK(PERF_X86_SIMD_PRE=
D_REGS_MAX - 1, 0)
> +#define PERF_X86_SIMD_VEC_MASK         GENMASK_ULL(PERF_X86_SIMD_VEC_REG=
S_MAX - 1, 0)
> +
> +#define PERF_X86_H16ZMM_BASE           PERF_X86_SIMD_ZMMH_REGS
> +
> +enum {
> +       PERF_X86_OPMASK_QWORDS   =3D 1,
> +       PERF_X86_XMM_QWORDS      =3D 2,
> +       PERF_X86_YMMH_QWORDS     =3D 2,
> +       PERF_X86_YMM_QWORDS      =3D 4,
> +       PERF_X86_ZMMH_QWORDS     =3D 4,
> +       PERF_X86_ZMM_QWORDS      =3D 8,
> +       PERF_X86_SIMD_QWORDS_MAX =3D PERF_X86_ZMM_QWORDS,
> +};
>
>  #endif /* _ASM_X86_PERF_REGS_H */
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/l=
inux/perf_event.h
> index d292f96bc06f..f1474da32622 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -314,8 +314,9 @@ enum {
>   */
>  enum perf_sample_regs_abi {
>         PERF_SAMPLE_REGS_ABI_NONE               =3D 0,
> -       PERF_SAMPLE_REGS_ABI_32                 =3D 1,
> -       PERF_SAMPLE_REGS_ABI_64                 =3D 2,
> +       PERF_SAMPLE_REGS_ABI_32                 =3D (1 << 0),
> +       PERF_SAMPLE_REGS_ABI_64                 =3D (1 << 1),
> +       PERF_SAMPLE_REGS_ABI_SIMD               =3D (1 << 2),
>  };
>
>  /*
> @@ -382,6 +383,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER6                    120     /* Add: aux_sampl=
e_size */
>  #define PERF_ATTR_SIZE_VER7                    128     /* Add: sig_data =
*/
>  #define PERF_ATTR_SIZE_VER8                    136     /* Add: config3 *=
/
> +#define PERF_ATTR_SIZE_VER9                    168     /* Add: sample_si=
md_{pred,vec}_reg_* */
>
>  /*
>   * 'struct perf_event_attr' contains various attributes that define
> @@ -545,6 +547,25 @@ struct perf_event_attr {
>         __u64   sig_data;
>
>         __u64   config3; /* extension of config2 */
> +
> +
> +       /*
> +        * Defines set of SIMD registers to dump on samples.
> +        * The sample_simd_regs_enabled !=3D0 implies the
> +        * set of SIMD registers is used to config all SIMD registers.
> +        * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
> +        * config some SIMD registers on X86.
> +        */
> +       union {
> +               __u16 sample_simd_regs_enabled;
> +               __u16 sample_simd_pred_reg_qwords;
> +       };

Shouldn't there be 16-bits of reserved data here as the next __u32
will require it for alignment?

> +       __u32 sample_simd_pred_reg_intr;
> +       __u32 sample_simd_pred_reg_user;
> +       __u16 sample_simd_vec_reg_qwords;

Shouldn't there be 48-bits of reserved data here as the next __u64
will require it for alignment?

I wonder the order should be:
```
union {
__u16 sample_simd_regs_enabled;
__u16 sample_simd_pred_reg_qwords;
};
__u16 sample_simd_vec_reg_qwords;
__u32 sample_simd_pred_reg_intr;
__u32 sample_simd_pred_reg_user;
__u32 __reserved_4;
__u64 sample_simd_vec_reg_intr;
__u64 sample_simd_vec_reg_user;
```

Thanks,
Ian

> +       __u64 sample_simd_vec_reg_intr;
> +       __u64 sample_simd_vec_reg_user;
> +       __u32 __reserved_4;
>  };
>
>  /*
> @@ -1018,7 +1039,15 @@ enum perf_event_type {
>          *      } && PERF_SAMPLE_BRANCH_STACK
>          *
>          *      { u64                   abi; # enum perf_sample_regs_abi
> -        *        u64                   regs[weight(mask)]; } && PERF_SAM=
PLE_REGS_USER
> +        *        u64                   regs[weight(mask)];
> +        *        struct {
> +        *              u16 nr_vectors;
> +        *              u16 vector_qwords;
> +        *              u16 nr_pred;
> +        *              u16 pred_qwords;
> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * p=
red_qwords];
> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +        *      } && PERF_SAMPLE_REGS_USER
>          *
>          *      { u64                   size;
>          *        char                  data[size];
> @@ -1045,7 +1074,15 @@ enum perf_event_type {
>          *      { u64                   data_src; } && PERF_SAMPLE_DATA_S=
RC
>          *      { u64                   transaction; } && PERF_SAMPLE_TRA=
NSACTION
>          *      { u64                   abi; # enum perf_sample_regs_abi
> -        *        u64                   regs[weight(mask)]; } && PERF_SAM=
PLE_REGS_INTR
> +        *        u64                   regs[weight(mask)];
> +        *        struct {
> +        *              u16 nr_vectors;
> +        *              u16 vector_qwords;
> +        *              u16 nr_pred;
> +        *              u16 pred_qwords;
> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * p=
red_qwords];
> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +        *      } && PERF_SAMPLE_REGS_INTR
>          *      { u64                   phys_addr;} && PERF_SAMPLE_PHYS_A=
DDR
>          *      { u64                   cgroup;} && PERF_SAMPLE_CGROUP
>          *      { u64                   data_page_size;} && PERF_SAMPLE_D=
ATA_PAGE_SIZE
> --
> 2.34.1
>
