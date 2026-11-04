Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793831486;
	b=JzHC2TNTFBqL0Y7dfNhJYONNJTTWC2hN4JUocmII8SfZFMt3Z8KLwim1Z+kIxqAkz1za
	 /VLLhs8zZAW75NLp5NU5GBA9NYu504gzgmOQZPmdNz4nMNhyOiWr/f1cEia+ngw+FXXAE
	 iu+LNQfA0FP5/+yQcp37llDBvPrmcfgbQJjDcGgUSF/v9k5TGFRsFCGZspfVTbihrBzE8
	 rBhOLu6kJzVgW4DgzeH7AGapKZeRfnDLJ5GTzQl8ADWW9Fvj9HCZpr97UXeYs4rjlWXw8
	 zu5SRRr7nOTNC/gjftglPrNJNJRO6lJsHK6Btp4Gcr4qxJpvhgSHKftGS5cpNhBrYBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9ElVEracKYqU2HPS7pij1Ejie+xyil1NNct20nME2rU=;
	b=mX3Bx7jhgMJcN1m16JlMyXsmT4826ZhOAlV0pdYAEXrIBUuldHKG+g46GYw8ZCmLuz+r
	 wXD3JqOGA4p0RVuu23Wc92BbysR1wSTUQTdPKRQ32KxxT5r4L/ZhfYSBlaVtwhF8tNSIB
	 ZRt5D6CVdjHLiCLjTIEGYCrZU4VdsMDXhET6eqiW33ntuLuNqPRBvLONFhoNzcas34MFz
	 aZ/B42tOMBdcYPg1LiCMbe7H3ioVzIsKIrZXWk9QJvW3kWsxXK/YumCXdNKq03/vX5IXf
	 TX37LLzI5hEm9dE7aXtkKV4vXTRULuWiyWwtLBhXPv/XUPDQIAsMS07vu7RH//dOaag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yvKTEN8B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE075606B2E4
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 22:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE075606B2E4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yvKTEN8B
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b566cf56c1so971095a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 14:31:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793831484; cv=none;
        d=google.com; s=arc-20260327;
        b=kyc/Y1HCVKWAJyNYVXSQO8VAXqFgSCBppoC5OESyUe29Ct5L6QgWGJBsvZ/SLmj1t8
         XI79tqytkD/1eyHJ1VI+FpnIx8eyD/hC32XqXeEPNPVJF5oBVGMSD909nUGJ55z5MZVx
         /Sge1owfkUNXKyrSOAhFUXWrgyArWsTr2TNTCK3PUlL+BAckBZWa/CBAu+1L8O9BGkEZ
         Q5AYrgGK4Zuu47Egj0tbwcAkNBr4i8YidSByr0HHQ/Br8oC+tN10Wnf9ae/2UO3req3c
         nO25frboksXY2h8u67nLDxgZUp2XkPdLPYyNXpio6P/5Xr1xJCnaG8gvfVvmdUjJIbKf
         6dQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ElVEracKYqU2HPS7pij1Ejie+xyil1NNct20nME2rU=;
        fh=9tz6WaYrwzBXpdMS4drJOyT0WiPNfYaB5pPimT98nDc=;
        b=DU12j0ppyOFv4uL7FgN088x3SnP2T8kn2Qdnj1vQjRVtKISqqDq0D+VmOCRYFm6dRo
         ikzYm7JoT2rvwGTRJKodnzFVM8hxaYd2F1ZijwPILO9qfvkB0+3B/jyjRklCeWrc0BPi
         S9LNdb1fPYF/i0NPZCL+csN/EGlnvUl6XD9bK6/0qu3QYidcQvYmtqXhVhYYrD/wMbs/
         Y5D8EwebCuKmP7ZbgIWvOYta7YAcAm6iabb7B2vPc/td4db+J9p9OSpvRDanWWrw/9Lg
         R+7AzQbpp9W1Kx0mNRGdxCrcO1K+BXDN7cNXYhYxnIuGcQoukVsLB0j7KpLRds7AJM5B
         mNzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793831484; x=1794436284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ElVEracKYqU2HPS7pij1Ejie+xyil1NNct20nME2rU=;
        b=yvKTEN8BO7H7/D5zBeHdDcwqdSxjk3mykZyNtP1VoCsE7rk3hjiqmRW6NKgrRSK4v3
         ey3Un7v+fOM0Jy6V/e/j8/soOTulVrQKy0mjxiMojmIhtqBEPgo5EPUkKNkyCH+GyryP
         d9b5zrUX3apuYVEKPTZOPd0D1etIsRz0Cf1ggf6kj1GFug26qAwX8nAZnW8q9UXRqvRz
         5vIYcVjMxmqBu+oKWVq9yeJz+g2wqbBsbWOcNskUPkPUgpNkMxVOxJcFPrLTuu4WXwal
         nTPo4j5LtX2nDMipiegNtwnkogd263vVFN+5SyA99NkKIJUM9993X9dNxmEyZySOvb35
         OmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831484; x=1794436284;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ElVEracKYqU2HPS7pij1Ejie+xyil1NNct20nME2rU=;
        b=ETTUiftVjElJDQbSULqjiihmOZ/SuUUItytRYLdrR3r2sHXAdnD4kQSmS49lwHroCO
         M2jEY1RhWhmYd5ydE4jBV3lFYsZAHXPOY7oc5HGRheezjRVAJcC/ESbudllP3e2yKS4P
         QUiPwLjBCd4ulfNkVM7OMxSIde8fY36ubuTFCVWiRtRZ1BtQnebNd5jt05o5XYg0Yv7u
         U0NHD1aw12Fh5kQHtq0Cb4WZj6OMcJaHNNrdpWT7aRue/Rq6dUBRYEpi7kBgEWompsNc
         X/kAl7daDqJtz/bGloS2oFI+V1NgmZHWskmXUUQibXElUkZ+tWfGEIgWWYcCf2MSR2+b
         zDUA==
X-Forwarded-Encrypted: i=1; AKwUvBx9dOJA2i/ROaQ/8TGVkfWD8WSA9M1V2oblaoIp019PjhT1VLsBdvBnB/nsHJw4UCjtyict3Dq71JvVrgsmhzE9@vger.kernel.org
X-Gm-Message-State: APuU4Z9n/5wtzhIo51lQpNqA5rY7x95IM9i4VJY/IzFVzY91Lsw13Jbv
	yu0eBg7VowFDxcqY2yxi4h9Lb0GQ5tCArawJyZb3HR0TqHwOlV4b+liJVqb9xNgxQeePo4PCVtn
	yU5GGtyVLzYQmTbk5gNqMbkXuV+e+0V4=
X-Gm-Gg: AYBFou3G9TKhwW9alcVfsjxTA7RClfwUu2ho8ZIu5W7QLHmdF4rWcQwC0G+IKgjkftt
	M790hz1Ecbd4ANU66C/wZkSZLWS6dCTPjdVjTjB8cQWDpE7LnnJ/3bF7PsPl4tfQlCZQUgBYZEA
	g73uws8LKJ3g4lWSGCR5fWQzSG6v71elYVsaVnJfyiW0l/dhJKeTA/VLVG5Ne/TP/vOY9nkUMu0
	4i/wIGlhx2b2Yh8AjaummHp+py7zSL+dzEH41QLBFmVuCcEDUQfY1aAu5MnbvizPULlenwluEDo
	QeA6WOfM5KIPPMNV6ssTju37cZBi1szsxU528iST96LQVuYI1LjbkzoTWCJwgvKd4RWruznMttw
	3e6v2Z+tGzO890B2baegCdO9cVJGZVPMQvbu1IVdFylwg9riZuSG6JqcRBvLd7FEZTTfrNoOewR
	0iKKwwVYn00YZfMMyGknsj5BU=
X-Received: by 2002:a05:6402:3812:b0:6b4:bf13:b4a3 with SMTP id
 4fb4d7f45d1cf-6b54cd6c670mr4543415a12.43.1793831483988; Wed, 04 Nov 2026
 14:31:23 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com> <20261104-alpha-profileme-v6-10-63362e9290a3@gmail.com>
In-Reply-To: <20261104-alpha-profileme-v6-10-63362e9290a3@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 4 Nov 2026 23:31:11 +0100
X-Gm-Features: AclHuK_FQC2kU8FbgVaSurfMsLUUgjteliOMC1CNRp4DejscmYttK5_od5jdt6g
Message-ID: <CA+=Fv5Q1rPBSyqRqzQES3E8Recy9itKzWTNBSxaDZ+QpbLxmbQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/13] alpha/perf: report the data source of ProfileMe
 memory accesses
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Wed, Nov 4, 2026 at 7:49=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> Whether a ProfileMe sample's memory access missed the DTB is only in the
> PERF_SAMPLE_RAW data, as a DTB miss trap.
>
> Set PERF_SAMPLE_DATA_SRC for the samples of memory instructions, so that
> the memory sort keys see them. One that trapped on a DTB miss gets an L1
> miss in mem_dtlb. PALcode fills the DTB, so one that retired without
> that trap hit it, and gets an L1 hit. mem_op comes from the opcode, as
> I_STAT does not say whether the access was a load or a store. A load
> into $31 or $f31 is a prefetch, except for ldq_u, a UNOP that is left
> out. Samples that fall back to the interrupted PC get none.
>
> On an EV7, a loop that loads one word from each page of 64 MB in random
> order had as many DTB hit samples on the load as misses: the miss trap
> aborts the load, and its refetch hits. A prefetch into $31 takes the
> same trap, and its samples are reported as PFETCH misses and hits.
>
> I_STAT[TRP] is ignored for an instruction killed before it was mapped. On
> an EV7, TRP and MIS were seen set for killed instructions that are not
> even branches.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/wrperfmon.h | 12 ++++++
>  arch/alpha/kernel/perf_event.c     | 86 ++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 98 insertions(+)
>
> diff --git a/arch/alpha/include/asm/wrperfmon.h b/arch/alpha/include/asm/=
wrperfmon.h
> index 7fbbfd74926a..dc24c7cb45db 100644
> --- a/arch/alpha/include/asm/wrperfmon.h
> +++ b/arch/alpha/include/asm/wrperfmon.h
> @@ -100,6 +100,18 @@
>  /* ProfileMe status, from the EV67/EV68 Hardware Reference Manuals. */
>  #define EV67_I_STAT_OVR_SHIFT 30
>  #define EV67_I_STAT_OVR_MASK 0x7UL
> +#define EV67_I_STAT_TRAP_TYPE_SHIFT 34
> +#define EV67_I_STAT_TRAP_TYPE_MASK 0xfUL
> +#define EV67_I_STAT_TRP (1UL<<39)
> +#define EV67_I_STAT_MIS (1UL<<40)
> +
> +/* I_STAT[TRAP_TYPE] values */
> +#define EV67_TRAP_DTB_DOUBLE_3 2
> +#define EV67_TRAP_DTB_DOUBLE_4 3
> +#define EV67_TRAP_DTB_SINGLE 6
> +
> +#define EV67_PCTR_VAL (1UL<<1)
> +#define EV67_PCTR_PM_KILLED_BM (1UL<<26)
>
>  /* PMPC bits 63:2 hold the profiled PC. Bit 0 set means a PALmode addres=
s. */
>  #define EV67_PMPC_PAL (1UL<<0)
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index c9ab40ff76ad..0723e1042145 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -20,6 +20,7 @@
>  #include <linux/overflow.h>
>  #include <linux/prandom.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/uaccess.h>
>
>  #include <asm/hwrpb.h>
>  #include <linux/atomic.h>
> @@ -1053,6 +1054,88 @@ static void alpha_profileme_set_regs_user(struct p=
erf_event *event,
>                                   sizeof(u64);
>  }
>
> +/* TRP, and MIS with it, are stale for an insn killed before it was mapp=
ed. */
> +static bool alpha_profileme_trp(unsigned long i_stat, unsigned long pctr=
_ctl)
> +{
> +       return !(pctr_ctl & EV67_PCTR_PM_KILLED_BM) && (i_stat & EV67_I_S=
TAT_TRP);
> +}
> +
> +/* What the memory instruction at pc does, or PERF_MEM_OP_NA. */
> +static u64 alpha_profileme_mem_op(unsigned long pc)
> +{
> +       u32 insn;
> +       bool r31;
> +
> +       if (pc < TASK_SIZE) {
> +               if (copy_from_user_nofault(&insn, (const void __user *)pc=
,
> +                                          sizeof(insn)))
> +                       return PERF_MEM_OP_NA;
> +       } else if (copy_from_kernel_nofault(&insn, (const void *)pc,
> +                                           sizeof(insn))) {
> +               return PERF_MEM_OP_NA;
> +       }
> +
> +       /* A load into $31 or $f31 is a prefetch, except for ldq_u: a UNO=
P. */
> +       r31 =3D ((insn >> 21) & 0x1f) =3D=3D 31;
> +
> +       switch (insn >> 26) {
> +       case 0x0b:                                      /* ldq_u */
> +               return r31 ? PERF_MEM_OP_NA : PERF_MEM_OP_LOAD;
> +       case 0x0a: case 0x0c:                           /* ldbu, ldwu */
> +       case 0x20: case 0x21: case 0x22: case 0x23:     /* ldf, ldg, lds,=
 ldt */
> +       case 0x28: case 0x29:                           /* ldl, ldq */
> +               return r31 ? PERF_MEM_OP_PFETCH : PERF_MEM_OP_LOAD;
> +       case 0x2a: case 0x2b:                           /* ldl_l, ldq_l *=
/
> +               return PERF_MEM_OP_LOAD;
> +       case 0x0d: case 0x0e: case 0x0f:                /* stw, stb, stq_=
u */
> +       case 0x24: case 0x25: case 0x26: case 0x27:     /* stf, stg, sts,=
 stt */
> +       case 0x2c: case 0x2d: case 0x2e: case 0x2f:     /* stl, stq, stl_=
c, stq_c */
> +               return PERF_MEM_OP_STORE;
> +       default:
> +               return PERF_MEM_OP_NA;
> +       }
> +}
> +
> +/*
> + * Report the DTB access of a memory instruction. PALcode fills the DTB,=
 so
> + * one that retired without a DTB miss trap hit it.
> + */
> +static void alpha_profileme_data_src(struct perf_sample_data *data,
> +                                    unsigned long pc, unsigned long i_st=
at,
> +                                    unsigned long pctr_ctl)
> +{
> +       u64 op, dtlb;
> +
> +       if (alpha_profileme_trp(i_stat, pctr_ctl)) {
> +               if (i_stat & EV67_I_STAT_MIS)
> +                       return;
> +               switch ((i_stat >> EV67_I_STAT_TRAP_TYPE_SHIFT) &
> +                       EV67_I_STAT_TRAP_TYPE_MASK) {
> +               case EV67_TRAP_DTB_SINGLE:
> +               case EV67_TRAP_DTB_DOUBLE_3:
> +               case EV67_TRAP_DTB_DOUBLE_4:
> +                       dtlb =3D PERF_MEM_TLB_L1 | PERF_MEM_TLB_MISS;
> +                       break;
> +               default:
> +                       return;
> +               }
> +               op =3D alpha_profileme_mem_op(pc);
> +       } else if (!(pctr_ctl & EV67_PCTR_PM_KILLED_BM) &&
> +                  (pctr_ctl & EV67_PCTR_VAL)) {
> +               dtlb =3D PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT;
> +               op =3D alpha_profileme_mem_op(pc);
> +               if (op =3D=3D PERF_MEM_OP_NA)
> +                       return;
> +       } else {
> +               return;
> +       }
> +
> +       data->data_src.val =3D PERF_MEM_NA;
> +       data->data_src.mem_op =3D op;
> +       data->data_src.mem_dtlb =3D dtlb;
> +       data->sample_flags |=3D PERF_SAMPLE_DATA_SRC;
> +}
> +
>  /*
>   * Handle the close of a ProfileMe window on PCTR0.
>   *
> @@ -1168,6 +1251,9 @@ static void alpha_perf_event_profileme(struct perf_=
event *event,
>                 data.sample_flags |=3D PERF_SAMPLE_WEIGHT_TYPE;
>         }
>
> +       if (exact && (event->attr.sample_type & PERF_SAMPLE_DATA_SRC))
> +               alpha_profileme_data_src(&data, pc, i_stat, pctr_ctl);
> +
>         if (!alpha_perf_event_set_period(event, hwc, 0))
>                 return;
>
>
> --
> 2.55.0
>

I tested this on my EV67 ES40 with a page-stride workload. At the
ldq into $31 I saw 89 PFETCH hits and 87 PFETCH misses. The load
and store sites also showed both DTB hits and misses. All 215 samples
at the ldq_u UNOP had no memory data source.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
