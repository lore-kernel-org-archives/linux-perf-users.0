Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D819E315760
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676585; cv=pass; b=fQW9PAfXz9i9rYX9D0AtP6JmmluaGluBW8IiRbhQYxNuwqVS053lFOQKlkV143egGE7OIwNUIvMgX2FUrI5rmvjP2vysBgU49JO1f2StwyIZL5aUHmOVJylvy8wrj1om2wA2ClhQQxvlZjEjx5e+5W5DZHgT/1HKqpeLcpNT1CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676585; c=relaxed/simple;
	bh=ics2LW4q+7seRGDQ9i/Nw7dittfyNbdvUyTVHFMThNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXV+q/lMdgUvLhIIN/8Pd2X24ZXS4HH1xgXbCoCdvjmE723TpV8rGgWiyzGWjc0a1wX+wyfUTMgAYmhiav8CnoPRoiNrOzAR7iexAO8VCcHOF3hjo170GKGNI5jK0iXfTsDQWtQTL8RkxsTmk9Ak8AymXStYGFWDvNYjVBNnfks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/qN18tM; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/qN18tM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aad8123335so11695ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 14:36:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770676582; cv=none;
        d=google.com; s=arc-20240605;
        b=SMlCrwz7jyQnWSF+Vz4yAQR0QSmLPKNZlxc1rkLFjx7x/RhGzZ7qG+R6wojJGHUHe+
         t/gvLfaX3ZajCMyTZh24exy5SHpakOlXhy8zgXDqBuGVqb8+M6vsN1mcvzs4jMIDXdxa
         8vLgFFr/FPqMNvzskpg4ln9JWvNS1xVCo+4MR5hq0WFLOYSTLUr6B7qoyKtqWcM46UbL
         4Nvm9gT5bL0eM4+W1uKvyLpBoozeDtkb8dGe0JHYnd0oug6KgVF85EgzvPo8OciKeMn9
         zNLvf9eP6SxkmyBaw6aCnN6rK6gRnNHjiSANV8ySXPRuOcWkSO5Oj9OVtrKwAIySZ2wC
         LQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PX3xfVgNazPgDZfs1iuAb+vyfXGWSoxE+eisXVv946c=;
        fh=GCMj7qjoBQTGyLVO6yfNORNpVvJFOzP60g9ZQUMTsDo=;
        b=H5mXoxv1ZSrsn+iFkKDq2dMVDysY2a1waDtigN/s/Spi0cX2+ymaYI8Fy6HV47Pu+3
         vWNpkTn8ogvToE9ltnakvatPxeOBOZAX9gr5yQJxBs1kZi84B7/dTN1s6zE+wNISWKau
         WGJTm2gBW80HUpEVNjxPYTNSokegN2UlDEV1G9Ea+rY8hNMwu7KOmMHz6Suy+yxxiGCJ
         2Z5C2HGZYfiHjG3Cipc3W1h8nEYmMg7Pm5cbIns4cwgK3dGOtOg0WbXvA6JOicV1U3W5
         SLywsFn7/pKyGlL/8RLEH085NOWGVuJRtX7/ArRSrzupX+WNDu35pEuDIkdT14/jssdK
         YKDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770676582; x=1771281382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX3xfVgNazPgDZfs1iuAb+vyfXGWSoxE+eisXVv946c=;
        b=H/qN18tMal/yAX7fHasYpBbveOK9sb50a+/nmMUBbdUIiEkxHslUHQyea/d+tmQ9jN
         u0DybnZt7ye3Tq2Tos7pG9MyJVTBLjd/nxo1xzNkmnmTwKyEdyEio2YqAMfXxrSRM/29
         BqTOKKj77Mh3fi7iDFb9DAOU4MT7i7NYugD5YjgA/Fr7Xl2SE2Nbeq/Hvl+fxLq9T+ga
         kVZIfHSmfo3CDJUj7+lqPuQngfEiRZF9CWmmm30qeaBWQLwIcZ7JsIFFaG81iRqj6+1/
         vkrIQHetqVupIBs43z/FJPxhGzxzE/XvthfpKPad+ZtOFM5VY5o/sHkzHfI0oz7J0N1j
         iiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770676582; x=1771281382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PX3xfVgNazPgDZfs1iuAb+vyfXGWSoxE+eisXVv946c=;
        b=uIyJGBnRryspo+DzckdduLUI9CLwwZPIzL9TQUc4iieijgNJTCgZcGACQYgtJZJ0Bt
         lFjdaRVmd9fQzu84KQGO+96Z33IBPjvnyWfVW6JTGaCrJtdgi2PSMrIOHM0alk4b37vh
         SlLpjaqJSPA1emBOrlP0RqjoRfekuFD9HIYHZA5pJkV/4RRMbpUHcPEGMCKl7s5UiBrR
         homlBm45nE+/5S4SvwnOxcdokigTrgAB7/MpABfNNNSfQJASNAep2cdcP4oAwUN3HqFL
         0I+2YERV0T9OM4ae3z1HlRqzGiOnCeAdAFy9xA9YOUW38RwwZL+UFgqQZ19TPSC4xICF
         1mvA==
X-Forwarded-Encrypted: i=1; AJvYcCWS1vHuY9416i5naGH3Cdwl6akx5O1hFQ+a5GiY+PxngbsBZ9sW3okbCWj65Q9VYP8P3jP0+GbU3uFWulXsh14Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBw1EFPhJkb/zxlw1fZZewtWlKX1/2xqFJMkgm7x/U2Btpzsb
	hKQhrd1GdK/aO3DSNnZm+KSbZjPxpFM8gNyQlJYnEVD1WOTvilvKfkWQo14RZgoQ1qpXuQJqxhj
	GBJ5srCOqZeHo3vnGBoyQymlwaSDra3N78/HlmfAa
X-Gm-Gg: AZuq6aLTgib3MTDM7Gp5svawCz4rX4PKmvnGxCrx1PuZyo07z/74YsDkKvR48M65lHK
	dB2AlGibhkzDA58QjRDabNp5ZCtzK8XFuEwR/dJtAn1K+k8eUDk+NOMBrR+3ZMeRQtltcR2Gar+
	Cmp5I5iaGO7d/3sb30Ez/Wl/v540SMUizpEa7/iIouN3nTU0CQ3U9QKlx9BKtCKD6odA4dFbnAT
	WcWHMYFl0xucGyRkEFbYR5CugZYH0bEBICCvmklNYbNfX/qcvwRxb8WvG9LMakfI/E69+oyamVQ
	U1UUGJT6qjBMXkcbxhfmBZAYK9YXDnvC+LI=
X-Received: by 2002:a17:902:d2d0:b0:2a7:4151:2c74 with SMTP id
 d9443c01a7336-2ab0e7eace7mr1055975ad.16.1770676581667; Mon, 09 Feb 2026
 14:36:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com> <20260209083514.2225115-3-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260209083514.2225115-3-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Feb 2026 14:36:10 -0800
X-Gm-Features: AZwV_QiJrMLGIA-4LNjqjO-oLmrp-Rx4uRQiGohtqTl-GlZ_pqTDDZp2j8x6U3E
Message-ID: <CAP-5=fV+NzS0-dd3a5aaKWCbPQfu2h0isvCWc_R65QgV=9mKOw@mail.gmail.com>
Subject: Re: [Patch v6 2/4] perf regs: Support x86 eGPRs/SSP sampling
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
> This patch adds support for sampling x86 extended GP registers (R16-R31)
> and the shadow stack pointer (SSP) register.
>
> The original XMM registers space in sample_regs_user/sample_regs_intr is
> reclaimed to represent the eGPRs and SSP when SIMD registers sampling is
> supported with the new SIMD sampling fields in the perf_event_attr
> structure. This necessitates a way to distinguish which register layout
> is used for the sample_regs_user/sample_regs_intr bitmap.
>
> To address this, a new "abi" argument is added to the helpers
> perf_intr_reg_mask(), perf_user_reg_mask(), and perf_reg_name(). When
> "abi & PERF_SAMPLE_REGS_ABI_SIMD" is true, it indicates the eGPRs and SSP
> layout is represented; otherwise, the legacy XMM registers are
> represented.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/builtin-script.c                   |   2 +-
>  tools/perf/util/evsel.c                       |   6 +-
>  tools/perf/util/parse-regs-options.c          |  17 ++-
>  .../perf/util/perf-regs-arch/perf_regs_x86.c  | 120 +++++++++++++++---
>  tools/perf/util/perf_regs.c                   |  14 +-
>  tools/perf/util/perf_regs.h                   |  10 +-
>  .../scripting-engines/trace-event-python.c    |   2 +-
>  tools/perf/util/session.c                     |   9 +-
>  8 files changed, 139 insertions(+), 41 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 14c6f6c3c4f2..ffe51f895666 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -730,7 +730,7 @@ static int perf_sample__fprintf_regs(struct regs_dump=
 *regs, uint64_t mask,
>         for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>                 u64 val =3D regs->regs[i++];
>                 printed +=3D fprintf(fp, "%5s:0x%"PRIx64" ",
> -                                  perf_reg_name(r, e_machine, e_flags),
> +                                  perf_reg_name(r, e_machine, e_flags, r=
egs->abi),

It is tempting for clarity to add the ABI to perf_reg_name as the first pat=
ch.

>                                    val);
>         }
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f59228c1a39e..b7fb3f936ae3 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1049,19 +1049,21 @@ static void __evsel__config_callchain(struct evse=
l *evsel, struct record_opts *o
>         }
>
>         if (param->record_mode =3D=3D CALLCHAIN_DWARF) {
> +               int abi;
> +
>                 if (!function) {
>                         uint16_t e_machine =3D evsel__e_machine(evsel, /*=
e_flags=3D*/NULL);
>
>                         evsel__set_sample_bit(evsel, REGS_USER);
>                         evsel__set_sample_bit(evsel, STACK_USER);
>                         if (opts->sample_user_regs &&
> -                           DWARF_MINIMAL_REGS(e_machine) !=3D perf_user_=
reg_mask(EM_HOST)) {
> +                           DWARF_MINIMAL_REGS(e_machine) !=3D perf_user_=
reg_mask(EM_HOST, &abi)) {
>                                 attr->sample_regs_user |=3D DWARF_MINIMAL=
_REGS(e_machine);
>                                 pr_warning("WARNING: The use of --call-gr=
aph=3Ddwarf may require all the user registers, "
>                                            "specifying a subset with --us=
er-regs may render DWARF unwinding unreliable, "
>                                            "so the minimal registers set =
(IP, SP) is explicitly forced.\n");
>                         } else {
> -                               attr->sample_regs_user |=3D perf_user_reg=
_mask(EM_HOST);
> +                               attr->sample_regs_user |=3D perf_user_reg=
_mask(EM_HOST, &abi);
>                         }
>                         attr->sample_stack_user =3D param->dump_size;
>                         attr->exclude_callchain_user =3D 1;
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse=
-regs-options.c
> index c93c2f0c8105..518327883b18 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -10,7 +10,8 @@
>  #include "util/perf_regs.h"
>  #include "util/parse-regs-options.h"
>
> -static void list_perf_regs(FILE *fp, uint64_t mask)
> +static void
> +list_perf_regs(FILE *fp, uint64_t mask, int abi)
>  {
>         const char *last_name =3D NULL;
>
> @@ -21,7 +22,7 @@ static void list_perf_regs(FILE *fp, uint64_t mask)
>                 if (((1ULL << reg) & mask) =3D=3D 0)
>                         continue;
>
> -               name =3D perf_reg_name(reg, EM_HOST, EF_HOST);
> +               name =3D perf_reg_name(reg, EM_HOST, EF_HOST, abi);
>                 if (name && (!last_name || strcmp(last_name, name)))
>                         fprintf(fp, "%s%s", reg > 0 ? " " : "", name);
>                 last_name =3D name;
> @@ -29,7 +30,8 @@ static void list_perf_regs(FILE *fp, uint64_t mask)
>         fputc('\n', fp);
>  }
>
> -static uint64_t name_to_perf_reg_mask(const char *to_match, uint64_t mas=
k)
> +static uint64_t
> +name_to_perf_reg_mask(const char *to_match, uint64_t mask, int abi)
>  {
>         uint64_t reg_mask =3D 0;
>
> @@ -39,7 +41,7 @@ static uint64_t name_to_perf_reg_mask(const char *to_ma=
tch, uint64_t mask)
>                 if (((1ULL << reg) & mask) =3D=3D 0)
>                         continue;
>
> -               name =3D perf_reg_name(reg, EM_HOST, EF_HOST);
> +               name =3D perf_reg_name(reg, EM_HOST, EF_HOST, abi);
>                 if (!name)
>                         continue;
>
> @@ -56,6 +58,7 @@ __parse_regs(const struct option *opt, const char *str,=
 int unset, bool intr)
>         char *s, *os =3D NULL, *p;
>         int ret =3D -1;
>         uint64_t mask;
> +       int abi;
>
>         if (unset)
>                 return 0;
> @@ -66,7 +69,7 @@ __parse_regs(const struct option *opt, const char *str,=
 int unset, bool intr)
>         if (*mode)
>                 return -1;
>
> -       mask =3D intr ? perf_intr_reg_mask(EM_HOST) : perf_user_reg_mask(=
EM_HOST);
> +       mask =3D intr ? perf_intr_reg_mask(EM_HOST, &abi) : perf_user_reg=
_mask(EM_HOST, &abi);
>
>         /* str may be NULL in case no arg is passed to -I */
>         if (!str) {
> @@ -87,11 +90,11 @@ __parse_regs(const struct option *opt, const char *st=
r, int unset, bool intr)
>                         *p =3D '\0';
>
>                 if (!strcmp(s, "?")) {
> -                       list_perf_regs(stderr, mask);
> +                       list_perf_regs(stderr, mask, abi);
>                         goto error;
>                 }
>
> -               reg_mask =3D name_to_perf_reg_mask(s, mask);
> +               reg_mask =3D name_to_perf_reg_mask(s, mask, abi);
>                 if (reg_mask =3D=3D 0) {
>                         ui__warning("Unknown register \"%s\", check man p=
age or run \"perf record %s?\"\n",
>                                 s, intr ? "-I" : "--user-regs=3D");
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/=
util/perf-regs-arch/perf_regs_x86.c
> index b6d20522b4e8..3e9241a11a95 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> @@ -235,26 +235,26 @@ int __perf_sdt_arg_parse_op_x86(char *old_op, char =
**new_op)
>         return SDT_ARG_VALID;
>  }
>
> -uint64_t __perf_reg_mask_x86(bool intr)
> +static uint64_t __arch__reg_mask(u64 sample_type, u64 mask, bool has_sim=
d_regs)
>  {
>         struct perf_event_attr attr =3D {
> -               .type                   =3D PERF_TYPE_HARDWARE,
> -               .config                 =3D PERF_COUNT_HW_CPU_CYCLES,
> -               .sample_type            =3D PERF_SAMPLE_REGS_INTR,
> -               .sample_regs_intr       =3D PERF_REG_EXTENDED_MASK,
> -               .precise_ip             =3D 1,
> -               .disabled               =3D 1,
> -               .exclude_kernel         =3D 1,
> +               .type                           =3D PERF_TYPE_HARDWARE,
> +               .config                         =3D PERF_COUNT_HW_CPU_CYC=
LES,
> +               .sample_type                    =3D sample_type,
> +               .precise_ip                     =3D 1,
> +               .disabled                       =3D 1,
> +               .exclude_kernel                 =3D 1,
> +               .sample_simd_regs_enabled       =3D has_simd_regs,
>         };
>         int fd;
> -
> -       if (!intr)
> -               return PERF_REGS_MASK;
> -
>         /*
>          * In an unnamed union, init it here to build on older gcc versio=
ns
>          */
>         attr.sample_period =3D 1;
> +       if (sample_type =3D=3D PERF_SAMPLE_REGS_INTR)
> +               attr.sample_regs_intr =3D mask;
> +       else
> +               attr.sample_regs_user =3D mask;
>
>         if (perf_pmus__num_core_pmus() > 1) {
>                 struct perf_pmu *pmu =3D NULL;
> @@ -276,13 +276,34 @@ uint64_t __perf_reg_mask_x86(bool intr)
>                                  /*group_fd=3D*/-1, /*flags=3D*/0);
>         if (fd !=3D -1) {
>                 close(fd);
> -               return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
> +               return mask;
> +       }
> +
> +       return 0;
> +}
> +
> +uint64_t __perf_reg_mask_x86(bool intr, int *abi)
> +{
> +       u64 sample_type =3D intr ? PERF_SAMPLE_REGS_INTR : PERF_SAMPLE_RE=
GS_USER;
> +       uint64_t mask =3D PERF_REGS_MASK;
> +
> +       *abi =3D 0;
> +       mask |=3D __arch__reg_mask(sample_type,
> +                                GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X=
86_R16),
> +                                true);
> +       mask |=3D __arch__reg_mask(sample_type, BIT_ULL(PERF_REG_X86_SSP)=
, true);
> +
> +       if (mask !=3D PERF_REGS_MASK) {
> +               *abi |=3D PERF_SAMPLE_REGS_ABI_SIMD;
> +       } else {
> +               mask |=3D __arch__reg_mask(sample_type, PERF_REG_EXTENDED=
_MASK,
> +                                        false);
>         }
>
> -       return PERF_REGS_MASK;
> +       return mask;
>  }
>
> -const char *__perf_reg_name_x86(int id)
> +static const char *__arch_reg_gpr_name(int id)
>  {
>         switch (id) {
>         case PERF_REG_X86_AX:
> @@ -333,7 +354,60 @@ const char *__perf_reg_name_x86(int id)
>                 return "R14";
>         case PERF_REG_X86_R15:
>                 return "R15";
> +       default:
> +               return NULL;
> +       }
> +
> +       return NULL;
> +}
>
> +static const char *__arch_reg_egpr_name(int id)
> +{
> +       switch (id) {
> +       case PERF_REG_X86_R16:
> +               return "R16";
> +       case PERF_REG_X86_R17:
> +               return "R17";
> +       case PERF_REG_X86_R18:
> +               return "R18";
> +       case PERF_REG_X86_R19:
> +               return "R19";
> +       case PERF_REG_X86_R20:
> +               return "R20";
> +       case PERF_REG_X86_R21:
> +               return "R21";
> +       case PERF_REG_X86_R22:
> +               return "R22";
> +       case PERF_REG_X86_R23:
> +               return "R23";
> +       case PERF_REG_X86_R24:
> +               return "R24";
> +       case PERF_REG_X86_R25:
> +               return "R25";
> +       case PERF_REG_X86_R26:
> +               return "R26";
> +       case PERF_REG_X86_R27:
> +               return "R27";
> +       case PERF_REG_X86_R28:
> +               return "R28";
> +       case PERF_REG_X86_R29:
> +               return "R29";
> +       case PERF_REG_X86_R30:
> +               return "R30";
> +       case PERF_REG_X86_R31:
> +               return "R31";
> +       case PERF_REG_X86_SSP:
> +               return "SSP";
> +       default:
> +               return NULL;
> +       }
> +
> +       return NULL;
> +}
> +
> +static const char *__arch_reg_xmm_name(int id)
> +{
> +       switch (id) {
>  #define XMM(x) \
>         case PERF_REG_X86_XMM ## x:     \
>         case PERF_REG_X86_XMM ## x + 1: \
> @@ -362,6 +436,22 @@ const char *__perf_reg_name_x86(int id)
>         return NULL;
>  }
>
> +const char *__perf_reg_name_x86(int id, int abi)
> +{
> +       const char *name;
> +
> +       name =3D __arch_reg_gpr_name(id);
> +       if (name)
> +               return name;
> +
> +       if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +               name =3D __arch_reg_egpr_name(id);
> +       else
> +               name =3D __arch_reg_xmm_name(id);
> +
> +       return name;
> +}
> +
>  uint64_t __perf_reg_ip_x86(void)
>  {
>         return PERF_REG_X86_IP;
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 5b8f34beb24e..bdd2eef13bc3 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -32,10 +32,11 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *o=
ld_op, char **new_op)
>         return ret;
>  }
>
> -uint64_t perf_intr_reg_mask(uint16_t e_machine)
> +uint64_t perf_intr_reg_mask(uint16_t e_machine, int *abi)

I wonder if abi is the right out argument name here. Before the SIMD
change the ABI meant either 32 or 64-bit. So we could imagine if it
were 32-bit then registers R8 to R15 wouldn't be in the mask for x86.
Perhaps just a "bool *" for sample_simd_regs_enabled.

Everything else looks good. Thanks for the weak function clean up,
this code is much more generic and better than before. I know it
wasn't trivial to do, but I appreciate it!

Thanks,
Ian

>  {
>         uint64_t mask =3D 0;
>
> +       *abi =3D 0;
>         switch (e_machine) {
>         case EM_ARM:
>                 mask =3D __perf_reg_mask_arm(/*intr=3D*/true);
> @@ -64,7 +65,7 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
>                 break;
>         case EM_386:
>         case EM_X86_64:
> -               mask =3D __perf_reg_mask_x86(/*intr=3D*/true);
> +               mask =3D __perf_reg_mask_x86(/*intr=3D*/true, abi);
>                 break;
>         default:
>                 pr_debug("Unknown ELF machine %d, interrupt sampling regi=
ster mask will be empty.\n",
> @@ -75,10 +76,11 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
>         return mask;
>  }
>
> -uint64_t perf_user_reg_mask(uint16_t e_machine)
> +uint64_t perf_user_reg_mask(uint16_t e_machine, int *abi)
>  {
>         uint64_t mask =3D 0;
>
> +       *abi =3D 0;
>         switch (e_machine) {
>         case EM_ARM:
>                 mask =3D __perf_reg_mask_arm(/*intr=3D*/false);
> @@ -107,7 +109,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
>                 break;
>         case EM_386:
>         case EM_X86_64:
> -               mask =3D __perf_reg_mask_x86(/*intr=3D*/false);
> +               mask =3D __perf_reg_mask_x86(/*intr=3D*/false, abi);
>                 break;
>         default:
>                 pr_debug("Unknown ELF machine %d, user sampling register =
mask will be empty.\n",
> @@ -118,7 +120,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
>         return mask;
>  }
>
> -const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
> +const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, =
int abi)
>  {
>         const char *reg_name =3D NULL;
>
> @@ -150,7 +152,7 @@ const char *perf_reg_name(int id, uint16_t e_machine,=
 uint32_t e_flags)
>                 break;
>         case EM_386:
>         case EM_X86_64:
> -               reg_name =3D __perf_reg_name_x86(id);
> +               reg_name =3D __perf_reg_name_x86(id, abi);
>                 break;
>         default:
>                 break;
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 7c04700bf837..c9501ca8045d 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -13,10 +13,10 @@ enum {
>  };
>
>  int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_o=
p);
> -uint64_t perf_intr_reg_mask(uint16_t e_machine);
> -uint64_t perf_user_reg_mask(uint16_t e_machine);
> +uint64_t perf_intr_reg_mask(uint16_t e_machine, int *abi);
> +uint64_t perf_user_reg_mask(uint16_t e_machine, int *abi);
>
> -const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags);
> +const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, =
int abi);
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
>  uint64_t perf_arch_reg_ip(uint16_t e_machine);
>  uint64_t perf_arch_reg_sp(uint16_t e_machine);
> @@ -64,8 +64,8 @@ uint64_t __perf_reg_ip_s390(void);
>  uint64_t __perf_reg_sp_s390(void);
>
>  int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
> -uint64_t __perf_reg_mask_x86(bool intr);
> -const char *__perf_reg_name_x86(int id);
> +uint64_t __perf_reg_mask_x86(bool intr, int *abi);
> +const char *__perf_reg_name_x86(int id, int abi);
>  uint64_t __perf_reg_ip_x86(void);
>  uint64_t __perf_reg_sp_x86(void);
>
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/too=
ls/perf/util/scripting-engines/trace-event-python.c
> index 2b0df7bd9a46..4cc5b96898e6 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -733,7 +733,7 @@ static void regs_map(struct regs_dump *regs, uint64_t=
 mask, uint16_t e_machine,
>
>                 printed +=3D scnprintf(bf + printed, size - printed,
>                                      "%5s:0x%" PRIx64 " ",
> -                                    perf_reg_name(r, e_machine, e_flags)=
, val);
> +                                    perf_reg_name(r, e_machine, e_flags,=
 regs->abi), val);
>         }
>  }
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 4b465abfa36c..7cf7bf86205d 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -959,15 +959,16 @@ static void branch_stack__printf(struct perf_sample=
 *sample,
>         }
>  }
>
> -static void regs_dump__printf(u64 mask, u64 *regs, uint16_t e_machine, u=
int32_t e_flags)
> +static void regs_dump__printf(u64 mask, struct regs_dump *regs,
> +                             uint16_t e_machine, uint32_t e_flags)
>  {
>         unsigned rid, i =3D 0;
>
>         for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) =
{
> -               u64 val =3D regs[i++];
> +               u64 val =3D regs->regs[i++];
>
>                 printf(".... %-5s 0x%016" PRIx64 "\n",
> -                      perf_reg_name(rid, e_machine, e_flags), val);
> +                      perf_reg_name(rid, e_machine, e_flags, regs->abi),=
 val);
>         }
>  }
>
> @@ -995,7 +996,7 @@ static void regs__printf(const char *type, struct reg=
s_dump *regs,
>                mask,
>                regs_dump_abi(regs));
>
> -       regs_dump__printf(mask, regs->regs, e_machine, e_flags);
> +       regs_dump__printf(mask, regs, e_machine, e_flags);
>  }
>
>  static void regs_user__printf(struct perf_sample *sample, uint16_t e_mac=
hine, uint32_t e_flags)
> --
> 2.34.1
>
