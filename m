Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E73D4119
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896022; cv=pass; b=qpWOxNPB+bKWgrSIcMNxNdDzw5bJmHp+HtSLn6Da2k2cNSi1ARFAAQAB5kZamVr0S4DpwVuEn9mxvcv19Rkr1n2FTPwktj5fYDsuV338Ysi2L3rYXVegp9IcVE98+AP3huJbQfLQSH5OyXgmPoovjMdZIB6oob370ncsATeFTrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896022; c=relaxed/simple;
	bh=mAbJlSolxXaLJCEmQOzNGJGd0EobwOwR4qocvBMzgM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEnbyE3s2U7rfHeOdtYDeuQUU8CYufbka/dIvGpWclfl/bZl9fji07sYTAiaoVdW2g+YSSo9+PjUpGnDh6RQLZEDm/0XKJ3O7TNeClHU4xuRPMTgP4sUbj2SBM3LINtHPGMvyZ6sQOpmRswgVAoWCvTKgavgWcgBvJ9Xwrcj9SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjnfKIPJ; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjnfKIPJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a76b39587aso22155ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 00:00:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768896020; cv=none;
        d=google.com; s=arc-20240605;
        b=fAgYX82AGqdIE6uuDAjjb7bUvgP+oq9E6rn+K7tAm31bpGC39nmonLyNmyENsop5zi
         UBr49ga+qgdemlPYMWQwq5QG2lv6tJIj7o4U0bxBhv/+/fmIGQDH8+aVgRglWYecR+G/
         iTq9sy2V1XWFflduSH3jHHrygUkHbGhN+y1gfaUqlnXwEQvyaLJprksl9WOfIcMHkeaL
         xHFv4Zrm+khAOYcDG6pfpzTuIfxFGCstEYLXfkXGRF8L3IctpYuxNKKPtM1+uH4z1wuF
         T1H4tja5z0X1XRntWHoXHOD/fYmevS/S4NqlcS6PL6dAUQtdypioPbFlMxs5SekL3UZl
         aasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mUR2IDzu+Di2Dhy5NVzCIBGJ4m1kwxYZKFkp+NkaL+w=;
        fh=tqMPPE4xq02mjOCG+ZY2eO9xfSxzM+S8SSx/5tt4u3c=;
        b=Po3jVJsDXXH18oN3uAol/+EhqspepGweCGOySv6vK8sE959fRSCKgvE2zMxOEr7sr/
         8qcxmDdODcRldvdoAHXH4jHRoAY0/cekBS6wICDDsANA/fI2kAN5ovEmdMfkguD2NYeN
         fWk3kHRVE0drfNcdTjfJzj/ZJd2oZGGafOg44GQvKrA5rq8c6wIDaXwSyO/qwIjDgGLR
         pFhKF7DmJOcHZ3pLnFUH2nCNXsb9KIjwd8QKxKBmwufjTUo/R4RVAaMQqDbUAi68VHP+
         K6Q6sANQ/6kS04mhgnFC5QvgAKapz1sU7+z2IDcS+HxTOlKpb6l3/R5HvQJMuHSXcRi6
         m14A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768896020; x=1769500820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUR2IDzu+Di2Dhy5NVzCIBGJ4m1kwxYZKFkp+NkaL+w=;
        b=RjnfKIPJp3WmCfpjuSUxo2w+5G2ByA0SmVGl97jBVbI31MZbOaLSXJswZD8RvXfvBW
         YRL4tpnUMzEhhFO8zTcnm4vZ7t98FHcI9K7sVp8CIP+rTE41b+2dEL0ALQjGLY50rc9C
         BdD35+56hjvqD1vKxDjqvnm7gAtjBDtRWf0AKkCepYNOVXypvPDIfT4OFasXEmLwlIVG
         0llBgW1CM5BR7QRsY7/icRLKJ3bk5su88uFSKS94C/DONJdfHRps5gpklVHbYGh+40ii
         ceVNhewMX4yYeLkOArA3Cv9JRDhMRjZbpJqJRG+v9W+8x1ZFFu6Nolq+KAt//Wzqit2W
         KlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768896020; x=1769500820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mUR2IDzu+Di2Dhy5NVzCIBGJ4m1kwxYZKFkp+NkaL+w=;
        b=vIXDxtYWBqorRa4Scu8wlTTN3Pf00ZJc975oTXLb0Um0EhhCBso1jRXDDbjhymw+GD
         VGwLpeHYQnVIwRcV4YUp74Bhqp4BILmWw6IO8PrJsW3z9TxjEbzkNeWqe2XurhxJL4hQ
         /WpPsy479C5jY31EXScYFlXWd8lSXnx6H0ZvfpVwuLjDxJOoFJCLusqXRBoAydZlrOcQ
         4OwKtwmowAtEzA50sAdVjv4jnBDeWn3IU2gktd1h96xQDYWUwMHSq5PbEIYOMTY0q9Lb
         SFw4API74zD7GeIk8FKctYnZE+TvmyBdOwCl9w89Nwmy+dbhhp/JG1AX5PinRN1JJD/2
         q7Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUnUuDgaMwqXsB79w3YOdmS6jPks1L8bPbIGCm/q5QewqOTlL/orMoUuQhEqGmMkS6lEl+lcdqKN44mO1Ly61tf@vger.kernel.org
X-Gm-Message-State: AOJu0YwidZXQwjukJKWLK5Q8nnhOPMqPlmeBbgMAUYulmCxVrEnKO3QV
	xy3p0u1R0h8Ztv11iOmfSBLH/hngwS462Y+Dn73KgWaO7YQNLeOma7vyDEmX630xrX1eUt4ZArF
	Lbs4Ifh04DpZvMFuY2+MurzUVsUHrTodZY6waao+u
X-Gm-Gg: AZuq6aJ3Rzf50GaNU7Et1aF2SF1bXZJ+CCt/mPwxlPmFBSyNkQRknWB9HDbzco+daXZ
	TeHInsGBUkgH0fTa0Rk64YSOmhEVpYiqgmqovSn+p9A4mhTjgHG0d2WEpx8Glv+Y2xNpIXHBTmh
	ice58D/Ldfdg1wXLvMUL2yCVG+IG1Gg+87EBAb+HjvW0GJ+HhjSEu64+swGfoDIQpqfgXTn68KL
	mEIOdGoI1AlLU9Q5dnYRvNBTqAfhljURp3M5bl0XZfimxnlJpkhZ2BAan6PsBXjjgIKY5Ut
X-Received: by 2002:a17:902:d4d1:b0:290:8ecf:e9f9 with SMTP id
 d9443c01a7336-2a72a7b8507mr5087835ad.7.1768896019549; Tue, 20 Jan 2026
 00:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-18-dapeng1.mi@linux.intel.com> <CAP-5=fWPgdiRve_xk_t04wr_p1tccRu1eU7C3v+=yvc4OD4PVg@mail.gmail.com>
 <9b429aa8-d269-4af8-9236-350cb9543f2a@linux.intel.com>
In-Reply-To: <9b429aa8-d269-4af8-9236-350cb9543f2a@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Jan 2026 00:00:07 -0800
X-Gm-Features: AZwV_QjQV7HyE6-A8BP0JqKJVtjoAuieGF_DmBBISxV8VPw2tVr_qGTHLJ86KJ8
Message-ID: <CAP-5=fXQOTXhcuUjHSnMDQzi+u+kja2pNJSwziY7WZo7iLpqng@mail.gmail.com>
Subject: Re: [Patch v5 17/19] perf headers: Sync with the kernel headers
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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

On Mon, Jan 19, 2026 at 11:43=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
>
> On 1/20/2026 3:16 PM, Ian Rogers wrote:
> > On Tue, Dec 2, 2025 at 10:59=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Update include/uapi/linux/perf_event.h and
> >> arch/x86/include/uapi/asm/perf_regs.h to support extended regs.
> >>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> ---
> >>  tools/arch/x86/include/uapi/asm/perf_regs.h | 62 ++++++++++++++++++++=
+
> >>  tools/include/uapi/linux/perf_event.h       | 45 +++++++++++++--
> >>  2 files changed, 103 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/=
x86/include/uapi/asm/perf_regs.h
> >> index 7c9d2bb3833b..f3561ed10041 100644
> >> --- a/tools/arch/x86/include/uapi/asm/perf_regs.h
> >> +++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
> >> @@ -27,9 +27,34 @@ enum perf_event_x86_regs {
> >>         PERF_REG_X86_R13,
> >>         PERF_REG_X86_R14,
> >>         PERF_REG_X86_R15,
> >> +       /*
> >> +        * The EGPRs/SSP and XMM have overlaps. Only one can be used
> >> +        * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
> >> +        * utilize EGPRs/SSP. For the other ABI type, XMM is used.
> >> +        *
> >> +        * Extended GPRs (EGPRs)
> >> +        */
> >> +       PERF_REG_X86_R16,
> >> +       PERF_REG_X86_R17,
> >> +       PERF_REG_X86_R18,
> >> +       PERF_REG_X86_R19,
> >> +       PERF_REG_X86_R20,
> >> +       PERF_REG_X86_R21,
> >> +       PERF_REG_X86_R22,
> >> +       PERF_REG_X86_R23,
> >> +       PERF_REG_X86_R24,
> >> +       PERF_REG_X86_R25,
> >> +       PERF_REG_X86_R26,
> >> +       PERF_REG_X86_R27,
> >> +       PERF_REG_X86_R28,
> >> +       PERF_REG_X86_R29,
> >> +       PERF_REG_X86_R30,
> >> +       PERF_REG_X86_R31,
> >> +       PERF_REG_X86_SSP,
> >>         /* These are the limits for the GPRs. */
> >>         PERF_REG_X86_32_MAX =3D PERF_REG_X86_GS + 1,
> >>         PERF_REG_X86_64_MAX =3D PERF_REG_X86_R15 + 1,
> >> +       PERF_REG_MISC_MAX =3D PERF_REG_X86_SSP + 1,
> >>
> >>         /* These all need two bits set because they are 128bit */
> >>         PERF_REG_X86_XMM0  =3D 32,
> >> @@ -54,5 +79,42 @@ enum perf_event_x86_regs {
> >>  };
> >>
> >>  #define PERF_REG_EXTENDED_MASK (~((1ULL << PERF_REG_X86_XMM0) - 1))
> >> +#define PERF_X86_EGPRS_MASK    GENMASK_ULL(PERF_REG_X86_R31, PERF_REG=
_X86_R16)
> >> +
> >> +enum {
> >> +       PERF_REG_X86_XMM,
> >> +       PERF_REG_X86_YMM,
> >> +       PERF_REG_X86_ZMM,
> >> +       PERF_REG_X86_MAX_SIMD_REGS,
> >> +
> >> +       PERF_REG_X86_OPMASK =3D 0,
> >> +       PERF_REG_X86_MAX_PRED_REGS =3D 1,
> >> +};
> >> +
> >> +enum {
> >> +       PERF_X86_SIMD_XMM_REGS      =3D 16,
> >> +       PERF_X86_SIMD_YMM_REGS      =3D 16,
> >> +       PERF_X86_SIMD_ZMMH_REGS     =3D 16,
> >> +       PERF_X86_SIMD_ZMM_REGS      =3D 32,
> >> +       PERF_X86_SIMD_VEC_REGS_MAX  =3D PERF_X86_SIMD_ZMM_REGS,
> >> +
> >> +       PERF_X86_SIMD_OPMASK_REGS   =3D 8,
> >> +       PERF_X86_SIMD_PRED_REGS_MAX =3D PERF_X86_SIMD_OPMASK_REGS,
> >> +};
> >> +
> >> +#define PERF_X86_SIMD_PRED_MASK                GENMASK(PERF_X86_SIMD_=
PRED_REGS_MAX - 1, 0)
> >> +#define PERF_X86_SIMD_VEC_MASK         GENMASK_ULL(PERF_X86_SIMD_VEC_=
REGS_MAX - 1, 0)
> >> +
> >> +#define PERF_X86_H16ZMM_BASE           PERF_X86_SIMD_ZMMH_REGS
> >> +
> >> +enum {
> >> +       PERF_X86_OPMASK_QWORDS   =3D 1,
> >> +       PERF_X86_XMM_QWORDS      =3D 2,
> >> +       PERF_X86_YMMH_QWORDS     =3D 2,
> >> +       PERF_X86_YMM_QWORDS      =3D 4,
> >> +       PERF_X86_ZMMH_QWORDS     =3D 4,
> >> +       PERF_X86_ZMM_QWORDS      =3D 8,
> >> +       PERF_X86_SIMD_QWORDS_MAX =3D PERF_X86_ZMM_QWORDS,
> >> +};
> >>
> >>  #endif /* _ASM_X86_PERF_REGS_H */
> >> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uap=
i/linux/perf_event.h
> >> index d292f96bc06f..f1474da32622 100644
> >> --- a/tools/include/uapi/linux/perf_event.h
> >> +++ b/tools/include/uapi/linux/perf_event.h
> >> @@ -314,8 +314,9 @@ enum {
> >>   */
> >>  enum perf_sample_regs_abi {
> >>         PERF_SAMPLE_REGS_ABI_NONE               =3D 0,
> >> -       PERF_SAMPLE_REGS_ABI_32                 =3D 1,
> >> -       PERF_SAMPLE_REGS_ABI_64                 =3D 2,
> >> +       PERF_SAMPLE_REGS_ABI_32                 =3D (1 << 0),
> >> +       PERF_SAMPLE_REGS_ABI_64                 =3D (1 << 1),
> >> +       PERF_SAMPLE_REGS_ABI_SIMD               =3D (1 << 2),
> >>  };
> >>
> >>  /*
> >> @@ -382,6 +383,7 @@ enum perf_event_read_format {
> >>  #define PERF_ATTR_SIZE_VER6                    120     /* Add: aux_sa=
mple_size */
> >>  #define PERF_ATTR_SIZE_VER7                    128     /* Add: sig_da=
ta */
> >>  #define PERF_ATTR_SIZE_VER8                    136     /* Add: config=
3 */
> >> +#define PERF_ATTR_SIZE_VER9                    168     /* Add: sample=
_simd_{pred,vec}_reg_* */
> >>
> >>  /*
> >>   * 'struct perf_event_attr' contains various attributes that define
> >> @@ -545,6 +547,25 @@ struct perf_event_attr {
> >>         __u64   sig_data;
> >>
> >>         __u64   config3; /* extension of config2 */
> >> +
> >> +
> >> +       /*
> >> +        * Defines set of SIMD registers to dump on samples.
> >> +        * The sample_simd_regs_enabled !=3D0 implies the
> >> +        * set of SIMD registers is used to config all SIMD registers.
> >> +        * If !sample_simd_regs_enabled, sample_regs_XXX may be used t=
o
> >> +        * config some SIMD registers on X86.
> >> +        */
> >> +       union {
> >> +               __u16 sample_simd_regs_enabled;
> >> +               __u16 sample_simd_pred_reg_qwords;
> >> +       };
> >> +       __u32 sample_simd_pred_reg_intr;
> >> +       __u32 sample_simd_pred_reg_user;
> >> +       __u16 sample_simd_vec_reg_qwords;
> >> +       __u64 sample_simd_vec_reg_intr;
> >> +       __u64 sample_simd_vec_reg_user;
> >> +       __u32 __reserved_4;
> >>  };
> >>
> >>  /*
> >> @@ -1018,7 +1039,15 @@ enum perf_event_type {
> >>          *      } && PERF_SAMPLE_BRANCH_STACK
> >>          *
> >>          *      { u64                   abi; # enum perf_sample_regs_a=
bi
> >> -        *        u64                   regs[weight(mask)]; } && PERF_=
SAMPLE_REGS_USER
> >> +        *        u64                   regs[weight(mask)];
> >> +        *        struct {
> >> +        *              u16 nr_vectors;
> >> +        *              u16 vector_qwords;
> >> +        *              u16 nr_pred;
> >> +        *              u16 pred_qwords;
> >> +        *              u64 data[nr_vectors * vector_qwords + nr_pred =
* pred_qwords];
> >> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> > Why can't these values be taken from the perf_event_attr? The abi is
> > needed as there could be both 32-bit and 64-bit samples for the same
> > event - presumably x32 appears as 64-bit. If the ABI has SIMD within
> > it (implied by the "} && (abi & PERF_SAMPLE_REGS_ABI_SIMD)" below)
> > then why can't we just use the perf_event_attr values? For example,
> > data could be "data[weight(sample_simd_vec_reg_user) *
> > sample_simd_vec_reg_qwords + weight(sample_simd_pred_reg_user) *
> > sample_simd_pred_reg_qwords]".
>
> The main reason is that the sampled SIMD regs could only be a subset of t=
he
> requested SIMD regs in perf_event_attr, so we need to show the bitmask an=
d
> qwords length explicitly in the sample record.

But this doesn't happen in any other register sampling, why in this case?

Perhaps add comments along the lines:
u16 nr_vectors;  // weight(sample_simd_vec_reg_user) except when ...

My random guess as to why the value differs from the weight would be
some kind of optimization around register values of 0. And even if the
number of registers is reduced, why is the number of qwords being
altered?

Thanks,
Ian

> >
> >> +        *      } && PERF_SAMPLE_REGS_USER
> >>          *
> >>          *      { u64                   size;
> >>          *        char                  data[size];
> >> @@ -1045,7 +1074,15 @@ enum perf_event_type {
> >>          *      { u64                   data_src; } && PERF_SAMPLE_DAT=
A_SRC
> >>          *      { u64                   transaction; } && PERF_SAMPLE_=
TRANSACTION
> >>          *      { u64                   abi; # enum perf_sample_regs_a=
bi
> >> -        *        u64                   regs[weight(mask)]; } && PERF_=
SAMPLE_REGS_INTR
> >> +        *        u64                   regs[weight(mask)];
> >> +        *        struct {
> >> +        *              u16 nr_vectors;
> >> +        *              u16 vector_qwords;
> >> +        *              u16 nr_pred;
> >> +        *              u16 pred_qwords;
> >> +        *              u64 data[nr_vectors * vector_qwords + nr_pred =
* pred_qwords];
> >> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> > Same comment.
> >
> > Thanks,
> > Ian
> >
> >> +        *      } && PERF_SAMPLE_REGS_INTR
> >>          *      { u64                   phys_addr;} && PERF_SAMPLE_PHY=
S_ADDR
> >>          *      { u64                   cgroup;} && PERF_SAMPLE_CGROUP
> >>          *      { u64                   data_page_size;} && PERF_SAMPL=
E_DATA_PAGE_SIZE
> >> --
> >> 2.34.1
> >>
