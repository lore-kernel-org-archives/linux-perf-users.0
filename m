Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827B3354AF6
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893416; cv=pass; b=WxB/GpLUrKJtVT27PQ68eJMa+sxnoQHQVnEkmdRHEPIWaSdnuXVmXnWa240aNqk54Dx+VFWSkYg6CAIvZ3tQ792Is+9/OBl0Ch9vjrERxUBDuqzpEEUc7Tt7kCTrPPN5zJfGshMSUfbydJSI6lLXBSFeJxB1lONELththT+DmMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893416; c=relaxed/simple;
	bh=cNjr206LRyO/Iq6hkgZgDfkivsMohHnE1fUJEgHOcyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSRWAXUlybE8DzQvEAHCRDjmdeUAviWMh7/Pw1PDjPK1u0B3UJqubxcKB0amACn+GPmASXTiw8RZNftXIPVa10UtyJbm7R8tp+9cQ52R5nvuJP3UZL4itada/ZCL9lV+mW1zCJux1p7znEekOmJHQ4JVulQJ7KHz+8KA1SJhY64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHVihg2W; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHVihg2W"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-11a247de834so17400c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 23:16:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768893402; cv=none;
        d=google.com; s=arc-20240605;
        b=HjEPJDMdr+fDZ3DMoDqDlIdtkXTxK66Sz+c+th0GzKM5Mx9aBLZ8aFk7E6YojuWJCT
         L3FRIDwBJX8K9UFZkikhHpT72oR3Yk6Q22q6chgzchc+q082HBUfdndnE0q52+6u3qNA
         ux/UNyX6HIY96ZrHOIexM4UGDgfRejoW1CbZUB6OTqHxmfntRhmEuBfrwCw/UKYhyTnh
         37bgXvXvNEHLC7zhoDgasYYUWbB5eXreAF4Iid8MgsTFENTNkorS5L5tnHRZW1iy5xCi
         ItUcXQiiQPblaYyVpIUq5P7pe9QPqHFNd58M0bmdgxIjh7dR8OAMKlD4TNMnSisdWu7o
         /R3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W36M3fvPnoatii7yFm4j8WXZX/v1MfGgkmZ9jmuNoAc=;
        fh=Z+2WbroQsidrguzC8guhlyp8y2ou520JChSIm1JMrCI=;
        b=JzvZNFiU9pzndzopBJ/V8rfCNspmeW41W4yRPN+quzB6uu+ErI8SqDlkUejG6fIDim
         bpPfgJyyTDF/tSkyf+C0R/zL6ZayG6jix71XYlZN0fqrVKcSRqw98frtDgpn+RxPN0Oi
         FcfXD8GLDe4HVRQ08+eByj0XFbXdlDwzSYdEm01xgwEtAMMGOVJHtyeBIoDG1oNEKPEh
         mDCMvu5BLrlLVo1DBtpFUp/3bDqPfkfGholKZvS3FGPEXxwnnbbwtRYdvgcCQLlI6A6Z
         1sR/eVKng87YgaSj5ajq9dXz7qERo7Xxel9TN0Krt88M1pTEIVbpw6ApFnA6nyGhuWwg
         po+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768893402; x=1769498202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W36M3fvPnoatii7yFm4j8WXZX/v1MfGgkmZ9jmuNoAc=;
        b=OHVihg2Wsj0QNJY3SD7A2i2eJLBjqEcJDVy06RIrbASve8GXg6pNFL7t9LWupBG8XF
         ZH6jB6ucQepPQv9L8+oMScrABbLUEk0UcqhU5rNk7oIojV/yB0Qw9f09j6nWN4bKqEqY
         RqTDuQwUwJqTeDCvNbJlnfa9CfU/aUuS3s6BIqIty23A9sOEvwgyQROXmwEqlPi9Pi6K
         EczRdHq4H7ea1mNQnW0ghXhAjgDJb6yKclMq4QVidKKCSlRsTHBNuEucoWK+L5DLWW3p
         mTfTB8c8TL6/SZsFqoGZzDdqQpqCOjNwt83KGDe93+wPzwausdS2j+3bAEk/l6NGFUvh
         DJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768893402; x=1769498202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W36M3fvPnoatii7yFm4j8WXZX/v1MfGgkmZ9jmuNoAc=;
        b=jF8sEWU9mAhpAJSJ0BBzXL9fmjZ5ojfU17mhoXqegpFY2LrDDT13wg901z7SccMPNI
         /H0o5n4q/wpoRwZxFbeOORBUkoMxGhPHBJuOobRe6LLDlYoMsnDDaGN2EEal64ZJBqMN
         aSqYXZaOu24U3uF7ThBsQV0RHyJN7Tk6dxD7eYe1CjqHtqE6rXUegNCplXJQ7vq4oUMI
         1uLKof/PcmxYQZTkYM3fk/OzVzssJ5w+scNdz23iw3o8774QCm540XQoWVyQdG7l1nTD
         lO0+b7aMi7G3AsGWJa2yuo9xTAb9RzDRcwh0Mw/QORA04Hrq+Fp8oHHT22W6uXPiMxYG
         YL4w==
X-Forwarded-Encrypted: i=1; AJvYcCUzD5wHfV05sHHl4OibAG7euZdNAMnROHGP8fGZKh4W1kTK0LaIJq3yPEH/1OT3xmDCXyxySuwoJt5eeul/xv9S@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hJi4ZLwewJ0EvH+SQtBPoXItlV3BniCK9zOuYZKWqh+wUGVp
	Fqt2pgwG6sL+4a8nGwIDGcZpndz6F6d91uSZAlEawwIRg7PZTwMGwBaS7NbYYB0iIdewERAuyrz
	QNOb9ydpcZKxp1/oj+29bx3q/bClcxGz/wG/9tnNQ
X-Gm-Gg: AY/fxX45GKWTtWcU2rKkwnqaIa4q3i6o6+iXymm+5WvAomsmHcNSkkz48y/SX44HewS
	HTI7bE3tTCREiVF8ZHXg5pdTCM7v9Q/3BOXuqBuZouqnwZJmIsfsGIkvuBHTZMUhB0i0pgs1H00
	scdrpq2WSPKDfQ+OLwWE9tDLVPuMYcZnXIrnS7V4UKxtRxDH0Z5SpdDr0wvWEIKx1E3e8QkVSrD
	Lt0Aq5VXd2AY2OnZQcb8gYF6oLODcZAuaERcJnTKot7Uodof7fbhy+axnIcxr74SwE41pOh
X-Received: by 2002:a05:7022:3d03:b0:120:5719:1855 with SMTP id
 a92af1059eb24-124545668bdmr205705c88.19.1768893401085; Mon, 19 Jan 2026
 23:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com> <20251203065500.2597594-18-dapeng1.mi@linux.intel.com>
In-Reply-To: <20251203065500.2597594-18-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Jan 2026 23:16:29 -0800
X-Gm-Features: AZwV_Qiong-LGvcdwhytX70dcgffnT01up0kWkVakHdr8D6CkN4gXdCaEbI8u_c
Message-ID: <CAP-5=fWPgdiRve_xk_t04wr_p1tccRu1eU7C3v+=yvc4OD4PVg@mail.gmail.com>
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

Why can't these values be taken from the perf_event_attr? The abi is
needed as there could be both 32-bit and 64-bit samples for the same
event - presumably x32 appears as 64-bit. If the ABI has SIMD within
it (implied by the "} && (abi & PERF_SAMPLE_REGS_ABI_SIMD)" below)
then why can't we just use the perf_event_attr values? For example,
data could be "data[weight(sample_simd_vec_reg_user) *
sample_simd_vec_reg_qwords + weight(sample_simd_pred_reg_user) *
sample_simd_pred_reg_qwords]".

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

Same comment.

Thanks,
Ian

> +        *      } && PERF_SAMPLE_REGS_INTR
>          *      { u64                   phys_addr;} && PERF_SAMPLE_PHYS_A=
DDR
>          *      { u64                   cgroup;} && PERF_SAMPLE_CGROUP
>          *      { u64                   data_page_size;} && PERF_SAMPLE_D=
ATA_PAGE_SIZE
> --
> 2.34.1
>
