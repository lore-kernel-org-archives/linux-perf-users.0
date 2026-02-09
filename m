Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43E163
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676770; cv=pass; b=tepgsLb8yPIr5bPKoXq3jeHz0ymT3Ir6Fj2yg7UCECb+prI0Et5zBWC2mtLAeZ5ehHuk8vq+jGlpy/KBfi+Pvm4gB+h9jnAAUYOfo4pTESw+jhQq5Sc1/MyfcU/5iafMAfh+7QHxRyA5mp837GpQtE9o4o6bXAjhDovTYqydz1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676770; c=relaxed/simple;
	bh=YYMbQBtEJ7RQ5j5CiY5BYV+Pwb+tDlpH3DOVH4+fUTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtdygvqH4kfr8KKZvKCsXEKJaBuUUspmlYGdljfo7cPWgLV8PPgjDwj8fPHzwL/SmhBwmXZSXUznu1t2upotOKal6zSsn8o+Rz56JVwEgXgMTXJTesiSvWIQsBxYoI+B6INjsabxEkJZIhXLFgf7CRrVF05Pchtm56wvHw9JtM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ERJHoRPT; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ERJHoRPT"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a964077671so13545ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 14:39:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770676768; cv=none;
        d=google.com; s=arc-20240605;
        b=KyBKScjgPxpEG2DeSmeayd5DiVmVqUV5OHozELAI2WDRA5YEekAf9w+ibXobFobUWu
         ifaYTb1K3vYhu7nlDRy0MOzZKSsfrPHJITaTdqwMvTRFcoSaciWf2ZqL2x1jvE+soK3z
         5MKxpOXy1xoxL3xil2QGAkB9kwDtf1PcTPwSPlp3lhsBP+qqQIK7DaueQYzuue5T6cuo
         NstgkkKfd0BGmcHnGguzje6YLDevvsjqL8ePRQtttBb/bpMPi9hLuZ3iNzb45ttWxFxY
         ZIve+ca1+pX/C/WbXddkjGmRZGkdPjnYi3757x3G+RmLKQz81jALmAS7JFM8/ycbL0cp
         b3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/3e4RNZAYGPWd+prnXxgPaU32+gThRGmuLyzNbyPWGw=;
        fh=/AW/lSK5aTIDPzEq0X+7XbgQ67+3aojjUQpI2KMv1nA=;
        b=ENM1zuWVkTbpxdLQE+pZ6J2BYQjBEb/uujjItPjSX93Ea9UOT3tmy5AQY3KWHCH5KL
         VK1Qy77IYAjy/0h1CF//AZ/WpZ+siIvVObLqw3g4jRhEDwSpwzvmj79jA8zFf66EpKq/
         71CS1mlpiq7haPsUZn97xpDHKpbsNNh8Pi0JYdes1N0WFpHAI3CQ02qxM0F3rCVh9U3h
         qCg+WTnOXA1SNW4lV+/+k2si4B3KBHZqWyoQ3BLFbg6ieRBtmuFPOlHFSq3slelE6hEJ
         r85zDvaT1mt27iuP4Kjr5HH6+wo03TL9ZP+0oaiZ1HzrNubnshvcywTQKu3ZU1e+KZMC
         AQ7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770676768; x=1771281568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3e4RNZAYGPWd+prnXxgPaU32+gThRGmuLyzNbyPWGw=;
        b=ERJHoRPTO/uxUlhjw09Hx+tw4h/pbpeAt1B+jlq06/d8mBwb33nNWjK41IhrggbeQn
         AX6Y8X+fC2TVenKTY0/nRVEUPwIWllBjEkR8Lcw3ntMPVVA1FV22DZAaWEDJjKeqMYK/
         RWrhkurP50z7kdSBcdlSiU6WmN9+O7m4+Pp1n3PZSdvWp+EBSKIl8iBzHcMzxBgOxPBn
         yxgszRPWhmuSXhTjpuxkOVfyD9m1KjS4T6DMStvRlWrWBrLiCHxug4FZAecYWUQmvH2Z
         Tl1q46sUhBU5kJqyK2sScfTxXOhwH5dz0Oy7j8x5Oi3uKvfAnSqYImNtv+MsgdP0CXeW
         1wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770676768; x=1771281568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/3e4RNZAYGPWd+prnXxgPaU32+gThRGmuLyzNbyPWGw=;
        b=em3/77+Ybp72rEYyvpgaEqwRywlqBSaRV5H+eN9I8rwI0eASECgW5Z9C40XGqi5i6A
         pNvq6uYtLepe3q2071iM5H3gp+VFnEvgMyRrGQ1wQ0O5FW1yzvYpEeN6KTm+XiioEalK
         MGMqRQ5X9iqRawhwVaWkYYfoM+eAo7expiyuG2cby9NqbFFWIF2/NkZt5I8S5fqxlBa8
         byi1L5HMJEOBWWI8neIeEeW5kt/F/aftLE6tjBH/+sU4sx+YvR79nS+FRVR/ODZ8Q4D3
         rf3lTZxL5HSYDtjHQ9w8uGsO0Mj1grDlc2f+4aTWghl+6W9yu3WkDD2Z+KgSjX3SHDZq
         seyw==
X-Forwarded-Encrypted: i=1; AJvYcCXOk/0V2fSNIY1Isi4rVox8QlCyi4ID3NyvhrqIzK3MSRcA14cXCbBSTk13675TlpGry1R0d4salV6UEJj399Gt@vger.kernel.org
X-Gm-Message-State: AOJu0YzCx0ZpZuHn5S25vhXCjnC5mRh0CHX07IHkeSL+MDzg6NKs89W2
	b3a7pGdZZ77wQjStF8GODtF79KpIesUwJTOhrSYmNA0H3F7EtWcsBHxJ/jaE29no54hegnHhrFC
	qAERt16ez9BCAg6S2dLjVcRdzES1aiqfdzWn3opTM
X-Gm-Gg: AZuq6aICbL9EmJp7QN9Ng37ejCWcfm49KtKRwfh8lGqG5WujtPWIzwhjZX/tqq+gCJU
	CJvfopsXcM80rrqjXU205uQ+dY+8xw2MuxukZPCjmZ4mwCHS0C0qhl1pYOsVNr5tGNI3QKgpXol
	TvCEIn+iFKPsZmOYtgaZoHf6wX8imcn+PwHAfhZ06Lt5GdIIKowlKrNOxdn02Diqq0NnDWVunl/
	/UMzEWRvrlNbO1SzVce5zI3/Lq72G9RUSiaTLt0GcRt3Z7VF7vt/qtO9SFoG2lWsmt5gRIEROcA
	1yCqpLSaRCZ+CoFX7TYf1rMX
X-Received: by 2002:a17:902:e74c:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-2ab0e56d319mr1514895ad.6.1770676767213; Mon, 09 Feb 2026
 14:39:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com> <20260209083514.2225115-4-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260209083514.2225115-4-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Feb 2026 14:39:16 -0800
X-Gm-Features: AZwV_QgKOA5huFC5d8vQzWtyCgVPSN9MD4mL7ySuoe-2XZZWAcxQeaM31A8O_sY
Message-ID: <CAP-5=fWjBZFsFqQX_wCLweNGv_NdHwp=zV6G7BRTVdBiwRmRkQ@mail.gmail.com>
Subject: Re: [Patch v6 3/4] perf regs: Support x86 SIMD registers sampling
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 12:39=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> This patch adds support for the newly introduced SIMD register sampling
> format by adding the following 5 functions:
>
> uint64_t perf_intr_simd_reg_class_mask(uint16_t e_machine, bool pred);
> uint64_t perf_user_simd_reg_class_mask(uint16_t e_machine, bool pred);
> uint64_t perf_intr_simd_reg_class_bitmap_qwords(uint16_t e_machine, int r=
eg_c,
>                                                 uint16_t *qwords, bool pr=
ed);
> uint64_t perf_user_simd_reg_class_bitmap_qwords(uint16_t e_machine, int r=
eg_c,
>                                                 uint16_t *qwords, bool pr=
ed);
> const char *perf_simd_reg_class_name(uint16_t e_machine, int id, bool pre=
d);
>
> The perf_{intr|user}_simd_reg_class_mask() functions retrieve the bitmap
> of kernel supported SIMD/PRED register classes on current platform for
> intr-regs and user-regs sampling, such as OPMASK/XMM/YMM/ZMM on
> x86 platforms.
>
> The perf_{intr|user}_simd_reg_class_bitmap_qwords() functions retrieve
> the bitmap and qwords length of a certain class of SIMD/PRED register
> on current platform for intr-regs and user-regs sampling. For example,
> for the XMM registers on x86 platforms, the returned bitmap is 0xffff
> (XMM0 ~ XMM15) and the qwords length is 2 (128 bits for each XMM
> register).
>
> The perf_simd_reg_class_name() function gets the register class name for
> a certain register class index.
>
> Additionally, the function __parse_regs() is enhanced to support parsing
> these newly introduced SIMD/PRED registers. Currently, each class of
> register can only be sampled collectively; sampling a specific SIMD
> register is not supported. For example, all XMM registers are sampled
> together rather than sampling only XMM0.
>
> When multiple overlapping register types, such as XMM and YMM, are
> sampled simultaneously, only the superset (YMM registers) is sampled.
>
> With this patch, all supported sampling registers on x86 platforms are
> displayed as follows.
>
>  $perf record --intr-regs=3D?
>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28
>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
>
>  $perf record --user-regs=3D?
>  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
>  R11 R12 R13 R14 R15 R16 R17 R18 R19 R20 R21 R22 R23 R24 R25 R26 R27 R28
>  R29 R30 R31 SSP XMM0-15 YMM0-15 ZMM0-31 OPMASK0-7
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evsel.c                       |  27 ++
>  tools/perf/util/parse-regs-options.c          | 161 +++++++++-
>  .../perf/util/perf-regs-arch/perf_regs_x86.c  | 292 ++++++++++++++++++
>  tools/perf/util/perf_event_attr_fprintf.c     |   6 +
>  tools/perf/util/perf_regs.c                   |  72 +++++
>  tools/perf/util/perf_regs.h                   |  11 +
>  tools/perf/util/record.h                      |   6 +
>  7 files changed, 565 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index b7fb3f936ae3..a86d2434a4ad 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1583,12 +1583,39 @@ void evsel__config(struct evsel *evsel, struct re=
cord_opts *opts,
>         if (opts->sample_intr_regs && !evsel->no_aux_samples &&
>             !evsel__is_dummy_event(evsel)) {
>                 attr->sample_regs_intr =3D opts->sample_intr_regs;
> +               attr->sample_simd_regs_enabled =3D !!opts->sample_pred_re=
g_qwords;
> +               evsel__set_sample_bit(evsel, REGS_INTR);
> +       }
> +
> +       if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs) &=
&
> +           !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
> +               /* The pred qwords is to implies the set of SIMD register=
s is used */
> +               if (opts->sample_pred_reg_qwords)
> +                       attr->sample_simd_pred_reg_qwords =3D opts->sampl=
e_pred_reg_qwords;
> +               else
> +                       attr->sample_simd_pred_reg_qwords =3D 1;
> +               attr->sample_simd_vec_reg_intr =3D opts->sample_intr_vec_=
regs;
> +               attr->sample_simd_vec_reg_qwords =3D opts->sample_vec_reg=
_qwords;
> +               attr->sample_simd_pred_reg_intr =3D opts->sample_intr_pre=
d_regs;
>                 evsel__set_sample_bit(evsel, REGS_INTR);
>         }
>
>         if (opts->sample_user_regs && !evsel->no_aux_samples &&
>             !evsel__is_dummy_event(evsel)) {
>                 attr->sample_regs_user |=3D opts->sample_user_regs;
> +               attr->sample_simd_regs_enabled =3D !!opts->sample_pred_re=
g_qwords;
> +               evsel__set_sample_bit(evsel, REGS_USER);
> +       }
> +
> +       if ((opts->sample_user_vec_regs || opts->sample_user_pred_regs) &=
&
> +           !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
> +               if (opts->sample_pred_reg_qwords)
> +                       attr->sample_simd_pred_reg_qwords =3D opts->sampl=
e_pred_reg_qwords;
> +               else
> +                       attr->sample_simd_pred_reg_qwords =3D 1;
> +               attr->sample_simd_vec_reg_user =3D opts->sample_user_vec_=
regs;
> +               attr->sample_simd_vec_reg_qwords =3D opts->sample_vec_reg=
_qwords;
> +               attr->sample_simd_pred_reg_user =3D opts->sample_user_pre=
d_regs;
>                 evsel__set_sample_bit(evsel, REGS_USER);
>         }
>
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse=
-regs-options.c
> index 518327883b18..f27960846edc 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -9,13 +9,13 @@
>  #include <subcmd/parse-options.h>
>  #include "util/perf_regs.h"
>  #include "util/parse-regs-options.h"
> +#include "record.h"
>
>  static void
> -list_perf_regs(FILE *fp, uint64_t mask, int abi)
> +__list_gp_regs(FILE *fp, uint64_t mask, int abi)
>  {
>         const char *last_name =3D NULL;
>
> -       fprintf(fp, "available registers: ");
>         for (int reg =3D 0; reg < 64; reg++) {
>                 const char *name;
>
> @@ -27,14 +27,68 @@ list_perf_regs(FILE *fp, uint64_t mask, int abi)
>                         fprintf(fp, "%s%s", reg > 0 ? " " : "", name);
>                 last_name =3D name;
>         }
> +}
> +
> +static void
> +__list_simd_regs(FILE *fp, uint64_t mask, bool intr, bool pred)
> +{
> +       uint64_t bitmap =3D 0;
> +       uint16_t qwords =3D 0;
> +       const char *name;
> +       int i =3D 0;
> +
> +       for (int reg_c =3D 0; reg_c < 64; reg_c++) {
> +               if (((1ULL << reg_c) & mask) =3D=3D 0)
> +                       continue;
> +
> +               name =3D perf_simd_reg_class_name(EM_HOST, reg_c, pred);
> +               bitmap =3D intr ?
> +                        perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, =
reg_c, &qwords, pred) :
> +                        perf_user_simd_reg_class_bitmap_qwords(EM_HOST, =
reg_c, &qwords, pred);
> +               if (name && bitmap)
> +                       fprintf(fp, "%s%s0-%d", i++ > 0 ? " " : "",
> +                               name, fls64(bitmap) - 1);
> +       }
> +}
> +
> +static void
> +list_perf_regs(FILE *fp, uint64_t mask, uint64_t simd_mask,
> +              uint64_t pred_mask, int abi, bool intr)
> +{
> +       bool printed =3D false;
> +
> +       fprintf(fp, "available registers: ");
> +
> +       if (mask) {
> +               __list_gp_regs(fp, mask, abi);
> +               printed =3D true;
> +       }
> +
> +       if (simd_mask) {
> +               if (printed)
> +                       fprintf(fp, " ");
> +               __list_simd_regs(fp, simd_mask, intr, /*pred=3D*/false);
> +               printed =3D true;
> +       }
> +
> +       if (pred_mask) {
> +               if (printed)
> +                       fprintf(fp, " ");
> +               __list_simd_regs(fp, pred_mask, intr, /*pred=3D*/true);
> +               printed =3D true;
> +       }
> +
>         fputc('\n', fp);
>  }
>
>  static uint64_t
> -name_to_perf_reg_mask(const char *to_match, uint64_t mask, int abi)
> +name_to_gp_reg_mask(const char *to_match, uint64_t mask, int abi)
>  {
>         uint64_t reg_mask =3D 0;
>
> +       if (!mask)
> +               return reg_mask;
> +
>         for (int reg =3D 0; reg < 64; reg++) {
>                 const char *name;
>
> @@ -51,13 +105,78 @@ name_to_perf_reg_mask(const char *to_match, uint64_t=
 mask, int abi)
>         return reg_mask;
>  }
>
> +static bool
> +name_to_simd_reg_mask(struct record_opts *opts, const char *to_match,
> +                     uint64_t mask, bool intr, bool pred)
> +{
> +       bool matched =3D false;
> +       uint64_t bitmap;
> +       uint16_t qwords;
> +       int reg_c;
> +
> +       if (!mask)
> +               return false;
> +
> +       for (reg_c =3D 0; reg_c < 64; reg_c++) {
> +               const char *name;
> +
> +               if (((1ULL << reg_c) & mask) =3D=3D 0)
> +                       continue;
> +
> +               name =3D perf_simd_reg_class_name(EM_HOST, reg_c, pred);
> +               if (!name)
> +                       continue;
> +
> +               if (!strcasecmp(to_match, name)) {
> +                       matched =3D true;
> +                       break;
> +               }
> +       }
> +
> +       if (!matched)
> +               return false;
> +
> +       if (intr) {
> +               bitmap =3D perf_intr_simd_reg_class_bitmap_qwords(EM_HOST=
,
> +                                                       reg_c, &qwords, p=
red);
> +       } else {
> +               bitmap =3D perf_user_simd_reg_class_bitmap_qwords(EM_HOST=
,
> +                                                       reg_c, &qwords, p=
red);
> +       }
> +
> +       /* Just need the highest qwords */
> +       if (pred) {
> +               if (qwords >=3D opts->sample_pred_reg_qwords) {
> +                       opts->sample_pred_reg_qwords =3D qwords;
> +                       if (intr)
> +                               opts->sample_intr_pred_regs =3D bitmap;
> +                       else
> +                               opts->sample_user_pred_regs =3D bitmap;
> +               }
> +       } else {
> +               if (qwords >=3D opts->sample_vec_reg_qwords) {
> +                       opts->sample_vec_reg_qwords =3D qwords;
> +                       if (intr)
> +                               opts->sample_intr_vec_regs =3D bitmap;
> +                       else
> +                               opts->sample_user_vec_regs =3D bitmap;
> +               }
> +       }
> +
> +       return true;
> +}
> +
>  static int
>  __parse_regs(const struct option *opt, const char *str, int unset, bool =
intr)
>  {
>         uint64_t *mode =3D (uint64_t *)opt->value;
> +       struct record_opts *opts;
>         char *s, *os =3D NULL, *p;
> -       int ret =3D -1;
> +       uint64_t simd_mask;
> +       uint64_t pred_mask;
>         uint64_t mask;
> +       bool matched;
> +       int ret =3D -1;
>         int abi;
>
>         if (unset)
> @@ -69,11 +188,16 @@ __parse_regs(const struct option *opt, const char *s=
tr, int unset, bool intr)
>         if (*mode)
>                 return -1;
>
> -       mask =3D intr ? perf_intr_reg_mask(EM_HOST, &abi) : perf_user_reg=
_mask(EM_HOST, &abi);
> +       mask =3D intr ? perf_intr_reg_mask(EM_HOST, &abi) :
> +                     perf_user_reg_mask(EM_HOST, &abi);
> +       opts =3D intr ? container_of(opt->value, struct record_opts, samp=
le_intr_regs) :
> +                     container_of(opt->value, struct record_opts, sample=
_user_regs);
>
>         /* str may be NULL in case no arg is passed to -I */
>         if (!str) {
>                 *mode =3D mask;
> +               if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +                       opts->sample_pred_reg_qwords =3D 1;
>                 return 0;
>         }
>
> @@ -82,6 +206,14 @@ __parse_regs(const struct option *opt, const char *st=
r, int unset, bool intr)
>         if (!s)
>                 return -1;
>
> +       if (intr) {
> +               simd_mask =3D perf_intr_simd_reg_class_mask(EM_HOST, /*pr=
ed=3D*/false);
> +               pred_mask =3D perf_intr_simd_reg_class_mask(EM_HOST, /*pr=
ed=3D*/true);
> +       } else {
> +               simd_mask =3D perf_user_simd_reg_class_mask(EM_HOST, /*pr=
ed=3D*/false);
> +               pred_mask =3D perf_user_simd_reg_class_mask(EM_HOST, /*pr=
ed=3D*/true);
> +       }
> +
>         for (;;) {
>                 uint64_t reg_mask;
>
> @@ -90,15 +222,24 @@ __parse_regs(const struct option *opt, const char *s=
tr, int unset, bool intr)
>                         *p =3D '\0';
>
>                 if (!strcmp(s, "?")) {
> -                       list_perf_regs(stderr, mask, abi);
> +                       list_perf_regs(stderr, mask, simd_mask, pred_mask=
, abi, intr);
>                         goto error;
>                 }
>
> -               reg_mask =3D name_to_perf_reg_mask(s, mask, abi);
> -               if (reg_mask =3D=3D 0) {
> -                       ui__warning("Unknown register \"%s\", check man p=
age or run \"perf record %s?\"\n",
> +               reg_mask =3D name_to_gp_reg_mask(s, mask, abi);
> +               if (reg_mask) {
> +                       if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +                               opts->sample_pred_reg_qwords =3D 1;
> +               } else {
> +                       matched =3D name_to_simd_reg_mask(opts, s, simd_m=
ask,
> +                                                       intr, /*pred=3D*/=
false) ||
> +                                 name_to_simd_reg_mask(opts, s, pred_mas=
k,
> +                                                       intr, /*pred=3D*/=
true);
> +                       if (!matched) {
> +                               ui__warning("Unknown register \"%s\", che=
ck man page or run \"perf record %s?\"\n",
>                                 s, intr ? "-I" : "--user-regs=3D");
> -                       goto error;
> +                               goto error;
> +                       }
>                 }
>                 *mode |=3D reg_mask;
>
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/=
util/perf-regs-arch/perf_regs_x86.c
> index 3e9241a11a95..867059fc3cb0 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> @@ -461,3 +461,295 @@ uint64_t __perf_reg_sp_x86(void)
>  {
>         return PERF_REG_X86_SP;
>  }
> +
> +enum {
> +       PERF_REG_CLASS_X86_OPMASK =3D 0,
> +       PERF_REG_CLASS_X86_XMM,
> +       PERF_REG_CLASS_X86_YMM,
> +       PERF_REG_CLASS_X86_ZMM,
> +       PERF_REG_X86_MAX_SIMD_CLASSES,
> +};
> +
> +#define PERF_REG_CLASS_X86_PRED_MASK   (BIT(PERF_REG_CLASS_X86_OPMASK))
> +#define PERF_REG_CLASS_X86_SIMD_MASK   (BIT(PERF_REG_CLASS_X86_XMM) | \
> +                                        BIT(PERF_REG_CLASS_X86_YMM) | \
> +                                        BIT(PERF_REG_CLASS_X86_ZMM))
> +
> +/*
> + * This function is used to determin whether kernel perf subsystem suppo=
rts
> + * which kinds of SIMD registers (OPMASK/XMM/YMM/ZMM) sampling.
> + *
> + * @sample_type: PERF_SAMPLE_REGS_INTR or PERF_SAMPLE_REGS_USER
> + * @qwords: the length of SIMD register, like 1/2/4/8 qwords for
> + *          OPMASK/XMM/YMM/ZMM regisers.
> + * @mask: the bitamsk of SIMD register, like 0xffff for XMM0 ~ XMM15
> + * @pred: whether It's a preceding SIMD register, like OPMASK register.
> + *
> + * Return value: true indicates support, otherwise no support.
> + */
> +static bool
> +__support_simd_reg_class(uint64_t sample_type, uint16_t qwords,
> +                        uint64_t mask, bool pred)
> +{
> +       struct perf_event_attr attr =3D {
> +               .type                           =3D PERF_TYPE_HARDWARE,
> +               .config                         =3D PERF_COUNT_HW_CPU_CYC=
LES,
> +               .sample_type                    =3D sample_type,
> +               .disabled                       =3D 1,
> +               .exclude_kernel                 =3D 1,
> +               .sample_simd_regs_enabled       =3D 1,
> +       };
> +       int fd;
> +
> +       attr.sample_period =3D 1;
> +
> +       if (!pred) {
> +               attr.sample_simd_vec_reg_qwords =3D qwords;
> +               if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> +                       attr.sample_simd_vec_reg_intr =3D mask;
> +               else
> +                       attr.sample_simd_vec_reg_user =3D mask;
> +       } else {
> +               attr.sample_simd_pred_reg_qwords =3D PERF_X86_OPMASK_QWOR=
DS;
> +               if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> +                       attr.sample_simd_pred_reg_intr =3D PERF_X86_SIMD_=
PRED_MASK;
> +               else
> +                       attr.sample_simd_pred_reg_user =3D PERF_X86_SIMD_=
PRED_MASK;
> +       }
> +
> +       if (perf_pmus__num_core_pmus() > 1) {
> +               __u64 type =3D perf_pmus__find_core_pmu()->type;
> +
> +               attr.config |=3D type << PERF_PMU_TYPE_SHIFT;
> +       }
> +
> +       event_attr_init(&attr);
> +
> +       fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
> +       if (fd !=3D -1) {
> +               close(fd);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +#define PERF_X86_SIMD_ZMMH_REGS        (PERF_X86_SIMD_ZMM_REGS / 2)
> +
> +static bool __arch_has_simd_reg_class(uint64_t sample_type, int reg_clas=
s,
> +                                     uint64_t *mask, uint16_t *qwords)
> +{
> +       bool supported =3D false;
> +       uint64_t bits;
> +
> +       *mask =3D 0;
> +       *qwords =3D 0;
> +
> +       switch (reg_class) {
> +       case PERF_REG_CLASS_X86_OPMASK:
> +               bits =3D BIT_ULL(PERF_X86_SIMD_OPMASK_REGS) - 1;
> +               supported =3D __support_simd_reg_class(sample_type,
> +                                                    PERF_X86_OPMASK_QWOR=
DS,
> +                                                    bits, true);
> +               if (supported) {
> +                       *mask =3D bits;
> +                       *qwords =3D PERF_X86_OPMASK_QWORDS;
> +               }
> +               break;
> +       case PERF_REG_CLASS_X86_XMM:
> +               bits =3D BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
> +               supported =3D __support_simd_reg_class(sample_type,
> +                                                    PERF_X86_XMM_QWORDS,
> +                                                    bits, false);
> +               if (supported) {
> +                       *mask =3D bits;
> +                       *qwords =3D PERF_X86_XMM_QWORDS;
> +               }
> +               break;
> +       case PERF_REG_CLASS_X86_YMM:
> +               bits =3D BIT_ULL(PERF_X86_SIMD_YMM_REGS) - 1;
> +               supported =3D __support_simd_reg_class(sample_type,
> +                                                    PERF_X86_YMM_QWORDS,
> +                                                    bits, false);
> +               if (supported) {
> +                       *mask =3D bits;
> +                       *qwords =3D PERF_X86_YMM_QWORDS;
> +               }
> +               break;
> +       case PERF_REG_CLASS_X86_ZMM:
> +               bits =3D BIT_ULL(PERF_X86_SIMD_ZMM_REGS) - 1;
> +               supported =3D __support_simd_reg_class(sample_type,
> +                                                    PERF_X86_ZMM_QWORDS,
> +                                                    bits, false);
> +               if (supported) {
> +                       *mask =3D bits;
> +                       *qwords =3D PERF_X86_ZMM_QWORDS;
> +                       break;
> +               }
> +
> +               bits =3D BIT_ULL(PERF_X86_SIMD_ZMMH_REGS) - 1;
> +               supported =3D __support_simd_reg_class(sample_type,
> +                                                    PERF_X86_ZMM_QWORDS,
> +                                                    bits, false);
> +               if (supported) {
> +                       *mask =3D bits;
> +                       *qwords =3D PERF_X86_ZMM_QWORDS;
> +               }
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return supported;
> +}
> +
> +static bool __support_simd_sampling(void)
> +{
> +       uint64_t mask =3D BIT_ULL(PERF_X86_SIMD_XMM_REGS) - 1;
> +       uint16_t qwords =3D PERF_X86_XMM_QWORDS;
> +       static bool simd_sampling_supported;
> +       static bool cached;
> +
> +       if (cached)
> +               return simd_sampling_supported;
> +
> +       simd_sampling_supported =3D
> +                __arch_has_simd_reg_class(PERF_SAMPLE_REGS_INTR,
> +                                          PERF_REG_CLASS_X86_XMM,
> +                                          &mask, &qwords);
> +       simd_sampling_supported |=3D
> +                __arch_has_simd_reg_class(PERF_SAMPLE_REGS_USER,
> +                                          PERF_REG_CLASS_X86_XMM,
> +                                          &mask, &qwords);
> +       cached =3D true;
> +
> +       return simd_sampling_supported;
> +}
> +
> +/*
> + * @x86_intr_simd_cached: indicates the data of below 3
> + *  x86_intr_simd_* items has been retrieved from kernel and cached.
> + * @x86_intr_simd_reg_class_mask: indicates which kinds of PRED/SIMD
> + *  registers are supported for intr-regs option. Assume kernel perf
> + *  subsystem supports XMM/YMM sampling, then the mask is
> + *  PERF_REG_CLASS_X86_XMM|PERF_REG_CLASS_X86_YMM.
> + * @x86_intr_simd_mask: indicates register bitmask for each kind of
> + *  supported PRED/SIMD register, like
> + *  x86_intr_simd_mask[PERF_REG_CLASS_X86_XMM] =3D 0xffff.
> + * @x86_intr_simd_mask: indicates the register length (qwords uinit)
> + *  for each kind of supported PRED/SIMD register, like
> + *  x86_intr_simd_qwords[PERF_REG_CLASS_X86_XMM] =3D 2.
> + */
> +static bool x86_intr_simd_cached;
> +static uint64_t x86_intr_simd_reg_class_mask;
> +static uint64_t x86_intr_simd_mask[PERF_REG_X86_MAX_SIMD_CLASSES];
> +static uint16_t x86_intr_simd_qwords[PERF_REG_X86_MAX_SIMD_CLASSES];
> +
> +/*
> + * Similar with above x86_intr_simd_* items, the difference is these
> + * items are used for user-regs option.
> + */
> +static bool x86_user_simd_cached;
> +static uint64_t x86_user_simd_reg_class_mask;
> +static uint64_t x86_user_simd_mask[PERF_REG_X86_MAX_SIMD_CLASSES];
> +static uint16_t x86_user_simd_qwords[PERF_REG_X86_MAX_SIMD_CLASSES];
> +
> +static uint64_t __arch__simd_reg_class_mask(bool intr)
> +{
> +       uint64_t mask =3D 0;
> +       bool supported;
> +       int reg_c;
> +
> +       if (!__support_simd_sampling())
> +               return 0;
> +
> +       if (intr && x86_intr_simd_cached)
> +               return x86_intr_simd_reg_class_mask;
> +
> +       if (!intr && x86_user_simd_cached)
> +               return x86_user_simd_reg_class_mask;
> +
> +       for (reg_c =3D 0; reg_c < PERF_REG_X86_MAX_SIMD_CLASSES; reg_c++)=
 {
> +               supported =3D false;
> +
> +               if (intr) {
> +                       supported =3D __arch_has_simd_reg_class(
> +                                               PERF_SAMPLE_REGS_INTR,
> +                                               reg_c,
> +                                               &x86_intr_simd_mask[reg_c=
],
> +                                               &x86_intr_simd_qwords[reg=
_c]);
> +               } else {
> +                       supported =3D __arch_has_simd_reg_class(
> +                                               PERF_SAMPLE_REGS_USER,
> +                                               reg_c,
> +                                               &x86_user_simd_mask[reg_c=
],
> +                                               &x86_user_simd_qwords[reg=
_c]);
> +               }
> +               if (supported)
> +                       mask |=3D BIT_ULL(reg_c);
> +       }
> +
> +       if (intr) {
> +               x86_intr_simd_reg_class_mask =3D mask;
> +               x86_intr_simd_cached =3D true;
> +       } else {
> +               x86_user_simd_reg_class_mask =3D mask;
> +               x86_user_simd_cached =3D true;
> +       }
> +
> +       return mask;
> +}
> +
> +static uint64_t
> +__arch__simd_reg_class_bitmap_qwords(bool intr, int reg_c, uint16_t *qwo=
rds)
> +{
> +       uint64_t mask =3D 0;
> +
> +       *qwords =3D 0;
> +       if (reg_c >=3D PERF_REG_X86_MAX_SIMD_CLASSES)
> +               return mask;
> +
> +       if (intr) {
> +               mask =3D x86_intr_simd_mask[reg_c];
> +               *qwords =3D x86_intr_simd_qwords[reg_c];
> +       } else {
> +               mask =3D x86_user_simd_mask[reg_c];
> +               *qwords =3D x86_user_simd_qwords[reg_c];
> +       }
> +
> +       return mask;
> +}
> +
> +uint64_t __perf_simd_reg_class_mask_x86(bool intr, bool pred)
> +{
> +       uint64_t mask =3D __arch__simd_reg_class_mask(intr);
> +
> +       return pred ? mask & PERF_REG_CLASS_X86_PRED_MASK :
> +                     mask & PERF_REG_CLASS_X86_SIMD_MASK;
> +}
> +
> +uint64_t __perf_simd_reg_class_bitmap_qwords_x86(int reg_c, uint16_t *qw=
ords,
> +                                                bool intr, bool pred)
> +{
> +       if (!x86_intr_simd_cached)
> +               __perf_simd_reg_class_mask_x86(intr, pred);
> +       return __arch__simd_reg_class_bitmap_qwords(intr, reg_c, qwords);
> +}
> +
> +const char *__perf_simd_reg_class_name_x86(int id, bool pred __maybe_unu=
sed)
> +{
> +       switch (id) {
> +       case PERF_REG_CLASS_X86_OPMASK:
> +               return "OPMASK";
> +       case PERF_REG_CLASS_X86_XMM:
> +               return "XMM";
> +       case PERF_REG_CLASS_X86_YMM:
> +               return "YMM";
> +       case PERF_REG_CLASS_X86_ZMM:
> +               return "ZMM";
> +       default:
> +               return NULL;
> +       }
> +
> +       return NULL;
> +}
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/=
perf_event_attr_fprintf.c
> index 741c3d657a8b..c6b8e53e06fd 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -362,6 +362,12 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_e=
vent_attr *attr,
>         PRINT_ATTRf(aux_start_paused, p_unsigned);
>         PRINT_ATTRf(aux_pause, p_unsigned);
>         PRINT_ATTRf(aux_resume, p_unsigned);
> +       PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
> +       PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
> +       PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
> +       PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
> +       PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
> +       PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
>
>         return ret;
>  }
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index bdd2eef13bc3..0ad40421f34e 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -248,3 +248,75 @@ uint64_t perf_arch_reg_sp(uint16_t e_machine)
>                 return 0;
>         }
>  }
> +
> +uint64_t perf_intr_simd_reg_class_mask(uint16_t e_machine, bool pred)
> +{
> +       switch (e_machine) {
> +       case EM_386:
> +       case EM_X86_64:
> +               return __perf_simd_reg_class_mask_x86(/*intr=3D*/true, pr=
ed);
> +       default:
> +               return 0;
> +       }
> +}
> +
> +uint64_t perf_user_simd_reg_class_mask(uint16_t e_machine, bool pred)
> +{
> +       switch (e_machine) {
> +       case EM_386:
> +       case EM_X86_64:
> +               return __perf_simd_reg_class_mask_x86(/*intr=3D*/false, p=
red);
> +       default:
> +               return 0;
> +       }
> +}
> +
> +uint64_t perf_intr_simd_reg_class_bitmap_qwords(uint16_t e_machine, int =
reg_c,
> +                                               uint16_t *qwords, bool pr=
ed)
> +{
> +       switch (e_machine) {
> +       case EM_386:
> +       case EM_X86_64:
> +               return __perf_simd_reg_class_bitmap_qwords_x86(reg_c, qwo=
rds,
> +                                                              /*intr=3D*=
/true,
> +                                                              pred);
> +       default:
> +               *qwords =3D 0;
> +               return 0;
> +       }
> +}
> +
> +uint64_t perf_user_simd_reg_class_bitmap_qwords(uint16_t e_machine, int =
reg_c,
> +                                               uint16_t *qwords, bool pr=
ed)
> +{
> +       switch (e_machine) {
> +       case EM_386:
> +       case EM_X86_64:
> +               return __perf_simd_reg_class_bitmap_qwords_x86(reg_c, qwo=
rds,
> +                                                              /*intr=3D*=
/false,
> +                                                              pred);
> +       default:
> +               *qwords =3D 0;
> +               return 0;
> +       }
> +}
> +
> +const char *perf_simd_reg_class_name(uint16_t e_machine, int id, bool pr=
ed)
> +{
> +       const char *name =3D NULL;
> +
> +       switch (e_machine) {
> +       case EM_386:
> +       case EM_X86_64:
> +               name =3D __perf_simd_reg_class_name_x86(id, pred);
> +               break;
> +       default:
> +               break;
> +       }
> +       if (name)
> +               return name;
> +
> +       pr_debug("Failed to find %s register %d for ELF machine type %u\n=
",
> +                pred ? "PRED" : "SIMD", id, e_machine);
> +       return "unknown";
> +}
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index c9501ca8045d..80d1d7316188 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -20,6 +20,13 @@ const char *perf_reg_name(int id, uint16_t e_machine, =
uint32_t e_flags, int abi)
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
>  uint64_t perf_arch_reg_ip(uint16_t e_machine);
>  uint64_t perf_arch_reg_sp(uint16_t e_machine);
> +uint64_t perf_intr_simd_reg_class_mask(uint16_t e_machine, bool pred);
> +uint64_t perf_user_simd_reg_class_mask(uint16_t e_machine, bool pred);
> +uint64_t perf_intr_simd_reg_class_bitmap_qwords(uint16_t e_machine, int =
reg_c,
> +                                               uint16_t *qwords, bool pr=
ed);
> +uint64_t perf_user_simd_reg_class_bitmap_qwords(uint16_t e_machine, int =
reg_c,
> +                                               uint16_t *qwords, bool pr=
ed);
> +const char *perf_simd_reg_class_name(uint16_t e_machine, int id, bool pr=
ed);
>
>  int __perf_sdt_arg_parse_op_arm64(char *old_op, char **new_op);
>  uint64_t __perf_reg_mask_arm64(bool intr);
> @@ -68,6 +75,10 @@ uint64_t __perf_reg_mask_x86(bool intr, int *abi);
>  const char *__perf_reg_name_x86(int id, int abi);
>  uint64_t __perf_reg_ip_x86(void);
>  uint64_t __perf_reg_sp_x86(void);
> +uint64_t __perf_simd_reg_class_mask_x86(bool intr, bool pred);
> +uint64_t __perf_simd_reg_class_bitmap_qwords_x86(int reg_c, uint16_t *qw=
ords,
> +                                                bool intr, bool pred);
> +const char *__perf_simd_reg_class_name_x86(int id, bool pred);
>
>  static inline uint64_t DWARF_MINIMAL_REGS(uint16_t e_machine)
>  {
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 93627c9a7338..37ed44b5f15b 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -62,6 +62,12 @@ struct record_opts {
>         u64           branch_stack;
>         u64           sample_intr_regs;
>         u64           sample_user_regs;
> +       u64           sample_intr_vec_regs;
> +       u64           sample_user_vec_regs;
> +       u32           sample_intr_pred_regs;
> +       u32           sample_user_pred_regs;
> +       u16           sample_vec_reg_qwords;
> +       u16           sample_pred_reg_qwords;
>         u64           default_interval;
>         u64           user_interval;
>         size_t        auxtrace_snapshot_size;
> --
> 2.34.1
>
