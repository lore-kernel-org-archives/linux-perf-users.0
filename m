Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1D2E0B5C
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805430; cv=none; b=Vvs6PJPKy0RIjMpVVr3NLuLP4Scm5keVkZqleJg/P8MRFOUVMrtvtQDIVlzsfiQsR8B0K78oAHPTAZemamvQPsNfWZZxC6CqWcKOkr7Q+Kans3k0LEMP2gjiq061/mtL6/3hKzX4KRxeM09R5jKXT7FceLaX75BkDVu6kB3/nOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805430; c=relaxed/simple;
	bh=u4NP7hflKKgav1/eEea14ibTkCw26qNedWtl/SE+I/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXLY92wEjUo3jEfCfdwlHv8h3FYq7Ockl9k2kywVWCffqUznFwOPlIGTQU0KVS9AqaiV7PY5IuvigA7XrnciVoFU8fOPpGvYM0BVvg8U4+PYPncqXm5PicPqQ271qMQSdPwztlWZimy687sHxiyOtEfi4KlVEAIR5TpKm+W1hKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0LDdhydm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0LDdhydm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295c64cb951so77455ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764805428; x=1765410228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syn4qtsN1VA3TIkNHjNmAM/IP0GcOQPRBKIWK7aD9Ig=;
        b=0LDdhydmzdkZ0pI6H9gjiUSXw3RYFP/OqGqqelmHQKCdg0M1+D7jJ6DNIgbLOCI5Ds
         nlGpl1eJULvtiilPM2QZwG6OZWfm+kLFXxLEEWeB7SNX28sxoz8XSUUyEWvCdLcRvR7N
         QothLl3rJd4e+aEaeFG/NiaehXVG7uQC/zZ3Kf5Feaam2kGwqJ8IU5K7mWybhFITCfe2
         0DSSJ7zymNwEF//lRRK1qpiV/XZ3Wb53j4L8Qs8IFTx7TaFtQ0SiONppTbG31W8c5JWY
         FpfSyV5bHb6V0gXjSSadpHGCuQFTDqS+OkUGE/vCG5MHUZziK5UdP6Di26H7m6s8jgG8
         pwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805428; x=1765410228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=syn4qtsN1VA3TIkNHjNmAM/IP0GcOQPRBKIWK7aD9Ig=;
        b=C85LQBhirEJdWYzgxtLSQu6JAnbbUvbwxPNmb0DBdV0mVG0mwCq7/3DnSldDFjJ79v
         ArIzujJEay9EY2FWZE7q6J349YDVtqw/UOo2txeovF+rYnHl7qCvL1LzU8hHFt0Aooc6
         jmGjuNXmuSnuRcqy3hy/oOu3EtZvTL7bt9GFK2P2obrwA4JgngLjhH8rJFcWkt84m9L0
         hbMebUIfuCQYM64H10dahzj+JlX6RmqEFLUfkjUQl1kVNyKtWr/Kwf6gvSZJh5w+ty6K
         WdXlredv5R999XHBWgqM4UBJZRLpOFvGHg8ao50v0hZPoA8DxmO26wAAglpnfi0RcZgm
         2vzw==
X-Forwarded-Encrypted: i=1; AJvYcCVk39Ns+4OuWfjeUW1pBaZpcVAhQHfUAOIr3IAHWjP425To979kKHBpjiQ3PwouA1DVrDMEoIR/4JOHQdC0R87g@vger.kernel.org
X-Gm-Message-State: AOJu0YwWy5ZlU6bRtg7RMAT8w1NGz5eFFkSv6TxqYC56X6i9Ur6BbM1I
	TxiEhQcqxuBm94sMOU4hcsKSTPmaCiOpkD14S5uFiFa3YnbishxA0ESy6ltLCjfMSq+VynVy0gU
	tQeCPk2lw8jfUxBXSl2qCyGlyhqRYVWIYgZriMMld
X-Gm-Gg: ASbGncvQCeTm1Vf39uhr5qbRIpqdsnbLKDBIG6zg+FEewSz7bw3ckpwkcF2MECRTsEd
	XfuYN1cq6WWBtY0cTknI7n14pEO7ZPtmaFqVsSN2iEmlHJaxywgeqhwz0tZmqdJjGowbZx7objQ
	i+HG9nr0DjKQwZy+VXvWNez3NbEQrZpaIQV/618UljjUMhgS+/J7yRpGulnlEYQM7p+QARH5p7p
	43G8E99Wu0a1Drk6osu4iXEAeQ3wPWW1njdBQPmFdj5bWKAVjm8R2sY5aPTJ2Jz7rV25nr/
X-Google-Smtp-Source: AGHT+IGdxHu/nX4fNN4q/2iyXVQqq8p3/Tsjr+aIPQlt+6YlyC2x0QT6mWThzkLa1cH4umqdAD3BX7zhXVZaguZ38ms=
X-Received: by 2002:a17:902:e752:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-29da40139efmr1280885ad.6.1764805427582; Wed, 03 Dec 2025
 15:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com> <20251203065500.2597594-18-dapeng1.mi@linux.intel.com>
In-Reply-To: <20251203065500.2597594-18-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Dec 2025 15:43:36 -0800
X-Gm-Features: AWmQ_bkbXryATAsJTWS2H-oA6lMG5qmrk0RjoQ71jzzQZMmc6HTLGVV-NQmiUXU
Message-ID: <CAP-5=fU+eoG5sXwL_ZHYup2RbZpZvYY7OaMjWQVRhO2ATq9BoQ@mail.gmail.com>
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

I wonder MISC isn't the most intention revealing name. What happens if
things are extended again? Would APX be a better alternative, so
PERF_REG_APX_MAX ?

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

ARM have added a config4 in:
https://lore.kernel.org/lkml/20251111-james-perf-feat_spe_eft-v10-1-1e1b5bf=
2cd05@linaro.org/
so this will need to be VER10.

Thanks,
Ian

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
> +       __u32 sample_simd_pred_reg_intr;
> +       __u32 sample_simd_pred_reg_user;
> +       __u16 sample_simd_vec_reg_qwords;
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
