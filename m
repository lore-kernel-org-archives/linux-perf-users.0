Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149C3112C1
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674988; cv=pass; b=CHshrQvpEo+T6AleUm+g7jtrTl2YsyuZiRgAZQw026UNEXRs2EN2BgGH/vWXYsTnbM3gEPraVEv2mA2cSmNUR5g9d4BSz7oT2cDexiYeyIywoczA7tNYSAd4ydJEQv8Me56Opb8N41Ts9qNYTwXTkq7J7MqRkv8ZBzjMZfiu7Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674988; c=relaxed/simple;
	bh=T8Let5DIwXEOR0oBHqvfQTA/DIfXTanwpVIzCPFkgYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPNcmpveK7M5PkL9Vs6PqBmflTPMtsUBN0aOE2aMwrx4+3/bP2hE2vsyEfO51JYGny0WpltodxxvHQHmHDH8WyYT5i7glScihQ//G+RXJCx8zfZn8ZLt5lea7R7aVdCgqRwi5qd32v9wPTANE3Zjsx+pY9E6N5dsygEYXhLWig0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rWRlVjAj; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWRlVjAj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a964077671so10955ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 14:09:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770674986; cv=none;
        d=google.com; s=arc-20240605;
        b=OX6KazfnpV+Z5VIsZGtFPW5foNgP2J6ltKJZEtlt+wOgzff56D92+DnhRN7uW5CNox
         NjoSNyfl7+NorEIMZ98oIkY9eRRX7PAk6/TEp5EhyOx4sYH9qVMzNcBvlzN5hdIxEEY0
         XdKWGQkTfOQNRq5zf6mNdZuvtn7S/lWOVEFzRfyvvmjevBMfCf4cvwb0KSpWcLPeLonj
         O7ftxAj+jf4NLn3KpYRDPKhs3tvRvFDE2di4ZXvabqcu7MlK7Fq1L5atKPotF+sGFsrS
         NujXnelK/ufDbBpdc9nljaclkW039t56drBatfu08IDQdjJ4qJjp3PZIpVapxolnW04V
         4AyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/vsufn9Kehb056elwpv/nurbAveVaZdLPpQA0L+q1+g=;
        fh=M3VAfnJ6b06cRm2yK1pTajyKWh9NNV/oVw5ScJqWhmg=;
        b=EnOFEEYXTMRfm9nu8Xm2fqteDI9eAsRx4YIKnNzfl4ImudnZ3TNadra3M7/orhBiqm
         XQnHxUjrBIg9GCGOREPAl+AdCj1/Kr3JJD6yksf1rvaBQt9ciJlCVPsVLuFRIZvmxQSW
         m5y0ok9zGVuwYVefjtFJfjF68dixZswk3T2Nbhk0iG70mmYntnyeT5e0jOmHD1xJLRv1
         JJbEV/Byhzrv8g010ulqaQbuLSKC1OH/n1qCkL3eYlYmF7yjypnN/+YFYjSu4LyuWH7/
         yPk3xBad/crmJ5th2gQJekrr70R8TnecxiJzPVqMMvrTMwpHAkmIiKO5TM9k40TJ6s9o
         AGRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770674986; x=1771279786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vsufn9Kehb056elwpv/nurbAveVaZdLPpQA0L+q1+g=;
        b=rWRlVjAj2e3ZFLLddlBijKUWThKC3oiR10RqXRzUa6LpYfJaMUo46mwiSKOcZvWDhQ
         igvWaJynailytYzuBjFJk9PoMIAAN9CDhJCK6mwcagzsChC1LTvIwGKViDOVVUD2/2D/
         66V7MeHKJI451TM3xLbL31MefrcNZKIXYayXayaJDUDAWLzQboE0XAd+MSU2qCcf+19E
         3aJqxEruM1du+VB9j2EIoJxDP4AcgFdSwcaFRvkCwfj9N7PMI3l7oML8AzoW/id2gKu2
         XI5A6f58NXoZ5j6PRFpSOg8wHb6is+GmFx/mP2eLY99VtSGoWRehsnaqnPHHQQV5c5qN
         uiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770674986; x=1771279786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vsufn9Kehb056elwpv/nurbAveVaZdLPpQA0L+q1+g=;
        b=GeR5p8fOuneQAxwr3nsWv7oicMTwedhlaxw2HUfylOAc1wUYjkEs0iINf6qzcQlUcA
         U3Ix1BluuW7x2CcCRDbEEMMdRhzG4wt6SOSDUWTuqe+ZynKjrqU2uYraQhLfWQGi8+so
         sLd1RK4xLSRT1wwHoEDHvH8x2YKlkO1GR7U8sPnh3t1ANxHfJSZY5xf4kFpduvm6teX0
         g1CZD/GOv8zThOEfgloqV7h4eAMUZxa7nopss5B2z8eROShXUcRSEiwdsjPW4Y9lrz10
         FR8fQ/STdZQG1sD8n98OUeLA8PTZfJZ5ltUna4yvepNLn/n9QIjIiqgE+3tATQrgbzFq
         yGuA==
X-Forwarded-Encrypted: i=1; AJvYcCW9FzZe73wohHSUl8WReNGodq//gfBvgJUQnG4w0xH13NXIGKH9s1Bbmwos8l2Ko0v+VXL3uSHX28pmNnepyJiG@vger.kernel.org
X-Gm-Message-State: AOJu0YwVafaoRw0P2fZ95XN72LLYlHhaS+VGJAo1/E87CU0akw716TUl
	2cN6/CKNAwkvYKLPqYPHJPbDKGO/nioWoxDPV3EXlpBVp0q7SIjbOQ+KiLKoQ7Zgq6tJKBXG7Yp
	BgoD1SX5owF/ied9/xXI+4Cblim2ktVtDZZMpMVfr
X-Gm-Gg: AZuq6aIRXqzd9R0f0jQE0+mDtjfHzAWTydntZgX/QpSXdSTYpGRK5mGvfO//1nlHTW3
	grjFKj1iQ2+sJQYmXnVAwqm78TAXyWb57jbL9IfQMZwhm6fvEoBrjNeyaXH4yY4+AM8pswyvvMy
	dPAUeIdC/ojMg96yE1koOXfRwzv2mOu1oQTuJ0UmWqxDfcCsqpWpCWGWRu2IsxCczn0nP+Q3dK8
	JL6F6ciEuircOle6TDus/gK6jrN9ifx3NP4ydf9MeNz1FEdz4ppLeRv9Ka97bknZAGO1iw/c/PL
	pyC99g2cpe/8Zd3xId+ChoMC
X-Received: by 2002:a17:902:f64f:b0:2aa:d5fd:5d76 with SMTP id
 d9443c01a7336-2ab1002df0cmr379795ad.1.1770674985997; Mon, 09 Feb 2026
 14:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com> <20260209083514.2225115-2-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260209083514.2225115-2-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Feb 2026 14:09:33 -0800
X-Gm-Features: AZwV_Qgtp3MfdYFpaarG7iI-zGRFuXqnecqWi-OYbC9IiY4okC0msz7SvAbQBik
Message-ID: <CAP-5=fV6WRASqp=HCTF1E64cDJy_mJrESMLYiyydwj0hGoYsDQ@mail.gmail.com>
Subject: Re: [Patch v6 1/4] perf headers: Sync with the kernel headers
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 12:39=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
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
>  tools/arch/x86/include/uapi/asm/perf_regs.h | 49 +++++++++++++++++++++
>  tools/include/uapi/linux/perf_event.h       | 45 +++++++++++++++++--
>  2 files changed, 90 insertions(+), 4 deletions(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86=
/include/uapi/asm/perf_regs.h
> index 7c9d2bb3833b..6da63e1dbb40 100644
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

nit: I think it'd be nice to comment that PERF_REG_X86_SSP and
PERF_REG_X86_XMM0 are both 32, the meaning of the register is
dependent on the PERF_SAMPLE_REGS_ABI_SIMD, 0 meaning XMM0 and 1
meaning SSP (which could be the opposite of what would be expected).

>         /* These are the limits for the GPRs. */
>         PERF_REG_X86_32_MAX =3D PERF_REG_X86_GS + 1,
>         PERF_REG_X86_64_MAX =3D PERF_REG_X86_R15 + 1,
> +       PERF_REG_MISC_MAX =3D PERF_REG_X86_SSP + 1,
>
>         /* These all need two bits set because they are 128bit */
>         PERF_REG_X86_XMM0  =3D 32,
> @@ -54,5 +79,29 @@ enum perf_event_x86_regs {
>  };
>
>  #define PERF_REG_EXTENDED_MASK (~((1ULL << PERF_REG_X86_XMM0) - 1))
> +#define PERF_X86_EGPRS_MASK    GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X8=
6_R16)
> +
> +enum {
> +       PERF_X86_SIMD_XMM_REGS      =3D 16,
> +       PERF_X86_SIMD_YMM_REGS      =3D 16,
> +       PERF_X86_SIMD_ZMM_REGS      =3D 32,
> +       PERF_X86_SIMD_VEC_REGS_MAX  =3D PERF_X86_SIMD_ZMM_REGS,
> +
> +       PERF_X86_SIMD_OPMASK_REGS   =3D 8,
> +       PERF_X86_SIMD_PRED_REGS_MAX =3D PERF_X86_SIMD_OPMASK_REGS,
> +};
> +
> +#define PERF_X86_SIMD_PRED_MASK        GENMASK(PERF_X86_SIMD_PRED_REGS_M=
AX - 1, 0)
> +#define PERF_X86_SIMD_VEC_MASK GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - =
1, 0)
> +
> +#define PERF_X86_H16ZMM_BASE           16
> +
> +enum {
> +       PERF_X86_OPMASK_QWORDS   =3D 1,
> +       PERF_X86_XMM_QWORDS      =3D 2,
> +       PERF_X86_YMM_QWORDS      =3D 4,
> +       PERF_X86_ZMM_QWORDS      =3D 8,
> +       PERF_X86_SIMD_QWORDS_MAX =3D PERF_X86_ZMM_QWORDS,

nit: for a non-x86 audience who may think a word is more than 2 bytes,
I think it would be nice to comment that a QWORD is 8 bytes. I don't
see other mentions of the unit of length in the kernel headers.

> +};
>
>  #endif /* _ASM_X86_PERF_REGS_H */
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/l=
inux/perf_event.h
> index 72f03153dd32..ce3a14d35390 100644
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
> @@ -383,6 +384,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER7                    128     /* Add: sig_data =
*/
>  #define PERF_ATTR_SIZE_VER8                    136     /* Add: config3 *=
/
>  #define PERF_ATTR_SIZE_VER9                    144     /* add: config4 *=
/
> +#define PERF_ATTR_SIZE_VER10                   176     /* Add: sample_si=
md_{pred,vec}_reg_* */
>
>  /*
>   * 'struct perf_event_attr' contains various attributes that define
> @@ -547,6 +549,25 @@ struct perf_event_attr {
>
>         __u64   config3; /* extension of config2 */
>         __u64   config4; /* extension of config3 */
> +
> +       /*
> +        * Defines set of SIMD registers to dump on samples.
> +        * The sample_simd_regs_enabled !=3D0 implies the
> +        * set of SIMD registers is used to config all SIMD registers.
> +        * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
> +        * config some SIMD registers on X86.

nit: I think this comment could be clearer, perhaps:

If sample_simd_regs_enabled is non-zero then the following
sampled_simd values define a set of SIMD registers to dump in all
samples. Each register is defined as a bitmap position in
(pred|vec)_reg_(intr|user) and the width of the register in qwords
(8-bytes) is given in (pred|vec)_reg_qwords. If sample_simd_regs is 0
then the vector registers may be dumped if they are in use. To
determine if all or a subset of the registers are dumped, and the
register width, the sample contains the values nr_vectors,
vector_qwords, nr_pred and pred_qwords.

Note, it is particularly the notion of "config all SIMD registers"
that I'm having a hard time being clear on here.

> +        */
> +       union {
> +               __u16 sample_simd_regs_enabled;

nit: I wonder if "enabled" is the right name here as the value being 0
means the vector register may be dumped. Perhaps
sample_simd_regs_full.

Thanks,
Ian

> +               __u16 sample_simd_pred_reg_qwords;
> +       };
> +       __u16   sample_simd_vec_reg_qwords;
> +       __u32   __reserved_4;
> +
> +       __u32   sample_simd_pred_reg_intr;
> +       __u32   sample_simd_pred_reg_user;
> +       __u64   sample_simd_vec_reg_intr;
> +       __u64   sample_simd_vec_reg_user;
>  };
>
>  /*
> @@ -1020,7 +1041,15 @@ enum perf_event_type {
>          *      } && PERF_SAMPLE_BRANCH_STACK
>          *
>          *      { u64                   abi; # enum perf_sample_regs_abi
> -        *        u64                   regs[weight(mask)]; } && PERF_SAM=
PLE_REGS_USER
> +        *        u64                   regs[weight(mask)];
> +        *        struct {
> +        *              u16 nr_vectors;         # 0 ... weight(sample_sim=
d_vec_reg_user)
> +        *              u16 vector_qwords;      # 0 ... sample_simd_vec_r=
eg_qwords
> +        *              u16 nr_pred;            # 0 ... weight(sample_sim=
d_pred_reg_user)
> +        *              u16 pred_qwords;        # 0 ... sample_simd_pred_=
reg_qwords
> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * p=
red_qwords];
> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +        *      } && PERF_SAMPLE_REGS_USER
>          *
>          *      { u64                   size;
>          *        char                  data[size];
> @@ -1047,7 +1076,15 @@ enum perf_event_type {
>          *      { u64                   data_src; } && PERF_SAMPLE_DATA_S=
RC
>          *      { u64                   transaction; } && PERF_SAMPLE_TRA=
NSACTION
>          *      { u64                   abi; # enum perf_sample_regs_abi
> -        *        u64                   regs[weight(mask)]; } && PERF_SAM=
PLE_REGS_INTR
> +        *        u64                   regs[weight(mask)];
> +        *        struct {
> +        *              u16 nr_vectors;         # 0 ... weight(sample_sim=
d_vec_reg_intr)
> +        *              u16 vector_qwords;      # 0 ... sample_simd_vec_r=
eg_qwords
> +        *              u16 nr_pred;            # 0 ... weight(sample_sim=
d_pred_reg_intr)
> +        *              u16 pred_qwords;        # 0 ... sample_simd_pred_=
reg_qwords
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
