Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A561194C95
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774320594; cv=pass; b=a6ZmzSy1SqyuaEdyh2Rp/Z0YP22knzk67r2sImCSakezVD9Dk8nyUuZOJ32oQx0zSSCJHlEkPVQR2F2vNsjKaz7AX7wQeVRXaiI9gRNAsU46QmkRDB3F/hy+U2eRYZHKgs/79bhh10EC5J7iE7W1D5HafyACvDhr+dDY1fQ9Ckw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774320594; c=relaxed/simple;
	bh=XCxKmeA7z39bdLfyUDk/JYMcwbvF/mLsMhvhBaByDD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3geo2lWv6WMlfgIesQf0mqaZGbd7AeSOKF9meP9phGL+TTSvq1mqZZAPEXelr+cTIYlpw3bxGXS9rIbXFayg/X8jg39fd99/2ZtuSf07mYCWtjemWudjZNRKQvzOXyO0agZt0Q2uT9fvUy2aS2BU/C6pwcFgew/RIFJCHxXTC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlt8jhyZ; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlt8jhyZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aeab6ff148so32795ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 19:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774320592; cv=none;
        d=google.com; s=arc-20240605;
        b=SqW8tp1vL3ClWsQ76UB2ZtzZRGeut2I/WATUGnvdyQGZKSml8SAkoS7uKyvm0GyL3c
         tJJbdqYdjV0ES1srOsx/zLSxlmsP10y8V/mT7vQSdslgZEnzf2Yiqw9674fltHJjgEVh
         KesOA+ssskyoDTcM19GdhbzXyhlpvhByHgIyLlVvRd2znrg2Vov91cGorB4Lkmbjh+ss
         S9tCnmqXeRBYf3Pa1tmKMUpU9EcYzbIsZ9zwx9p5sTrynMPFk8a5Qt9EPqYiD92s/03m
         zpWQR4eOklw6UJ/bZ2e0MC4V+GlqHRTaofv0gbtBKoDpSYHlyD83fzikz/yo0h1VaOS+
         M1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9WzOiHyd/1rfqt2olKhv7QAS7SrkH26K6dMYctzfDPY=;
        fh=44MbamAncg1zjHOkhOagvRtO33M2m6hxqZ6OC5Q3N40=;
        b=FuGzd5Hlhdqnnpo0FLZAHah1WBdpaoZO4KN/ndPbbtGIj/VQv340KYbKh6x6ggAt4N
         N5eXUq8NSCjAIv2h7+PpriqvglH6j2RIED96j/I3fxXH2vuUYLR8yXo+W6ITNUY21D0m
         nARB4Lp2+xDlqk4OqZX48eNjkOffFG5TSOgsU27bkxgvpACP5R3DjckR3gvWg1hRPacG
         DGPIQ7Q1QzgZs+TgJG2d6Om9orXlnjEZKqG0lCfHtu8ARbvXIl9reVT03pwP1zCOcZ0m
         7vynGcbqWRwY/Bt35Q+8Pn17HLgIV20cW6sPc5nSemwVolmi3ktSpdAsEMs5/k+dB39T
         XDEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774320592; x=1774925392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WzOiHyd/1rfqt2olKhv7QAS7SrkH26K6dMYctzfDPY=;
        b=jlt8jhyZlpT0VZ2IuGfdiTu4vVTYRJqZ3xE77DXarlzzznIugCQeTTwWkbUg5ERnNq
         gx+iVgF9k2/BnZJRiUw8Pm8rCha97n/vqvYU5E72BeTwvphOHdt4XEXmZesYHWsXRoSB
         uPROpu/NiC8TBT8hg3EBcBYmTaFQ73euM1DJTbWvnn2O623frzxwck4da7Zk7iqPmTUy
         ElRQ4O669TMx7lkcmrFPDu03Uyxad7AJrVlpHuxvx31/kwu6ncf4AyBn63JAyYy9qYII
         7A/xaS7rAkIa7L8kzeFSuE5siVbhcwZl96bFGRM1x9rRbXm1vI5adYeO5w1dn85Jv7lZ
         GeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774320592; x=1774925392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9WzOiHyd/1rfqt2olKhv7QAS7SrkH26K6dMYctzfDPY=;
        b=QbcKsjgvBmYF0PIfRzeVvDMC05qnZpo1qvQEWfIcaLORX8exOwWTBPcwpypsPGbaE/
         MOtlXxjY1SEENzYfSq8cNRvj+BXBGJKHB22DoXHS+71hPwukEITaRr/ohOH+xzAPE4/u
         eAG5YUUgctRZuUBFOZXmDSSpOP6uSVwPZivtkoFCuUB7iqAnvSRrZYPzQPq/NZqnpbv3
         pbQ5JXIWVO64PaTxuT4RvFoy7wR6k1cP36wEVflgJJ8T1r08nAbhPWMWiweOC/yC2ave
         B3yVdkyP4ammofoX0YQvmFR8GEPhKg2vZRgSfJr3ZUQNjtmtAW1vt05WS623rSQR42ie
         7rfw==
X-Forwarded-Encrypted: i=1; AJvYcCW2NKXKIMl8WVLD0mL8dXjNaPczkrLwy1jNRHXD7cYqlAoVsfRi2yS6IIMGUF1tEtaE+81wIaBhTbdp8HfF4tqN@vger.kernel.org
X-Gm-Message-State: AOJu0YwdszAUbKnDIBH2ojiM8cmfoA3UsLFuzPWaAPUmZTiZtCfkVfVw
	/wncVKk9ord5REe979QoAednxM+xFTFcp1J9bDctouavtwE9L/vXV811t9ullhbTPxnkjMPhYjj
	3QNzuuaJGRv6fZ8NntMsFYCWPc0opKUwa2ErP/ilL
X-Gm-Gg: ATEYQzzt6etTRHX8RXu4cG38YFaH6mJW4CoPcF8ClpQEkI2bzkbmUDSk4lqHGEtfhvs
	7HR9ZSqkvyC8QV/GDNTwB5t62yIEeAAL5cLOV34zwlH3IFbuXeAuAyODUoWy5VaIYqSH6i6FmKK
	nLRIZ3OzaBEn7kXuHMX3VcRMSQ5BXTEHEElzCGV8OJMlCU3k6u9I5k2Sir2VEfe/WfAVV0Ssw1t
	H9Q0AgMIJl7uoJ+LME6D3or2UBtvIzVHqqyS1qboXCebrngI0gvorvkcB/SnXF4xhBm+qy7kVi+
	uSk6vhp5
X-Received: by 2002:a17:902:cf04:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2b0a6733b4emr1201335ad.15.1774320591834; Mon, 23 Mar 2026
 19:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324005706.3778057-1-dapeng1.mi@linux.intel.com> <20260324005706.3778057-3-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260324005706.3778057-3-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Mar 2026 19:49:40 -0700
X-Gm-Features: AaiRm53CTzH5KldKgOBMwU1yDm3jlrPNYUw5wdP2HaF-OnQ2nShTJZQf5v0ImsY
Message-ID: <CAP-5=fX65DzJF+rq0T-58hNZsjYovW60PSBWsmF42kMxPhrv4g@mail.gmail.com>
Subject: Re: [Patch v7 2/4] perf regs: Support x86 eGPRs/SSP sampling
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
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 6:01=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.c=
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
>
> V7: Limit dwarf minimal regs to legacy GPRs (excluding APX eGPRs).

So, R16 to R31 won't be set up? This sounds worrying because a
function, like a leaf function, might use these registers as a frame
pointer with -fomit-frame-pointer when the code includes uses
functions like alloca.

So not having vector register support potentially breaks things like
LLVM's spill2reg, which aims to avoid using the stack and prefers
vector registers:
https://discourse.llvm.org/t/rfc-spill2reg-selectively-replace-spills-to-st=
ack-with-spills-to-vector-registers/59630
I think the dwarf minimal registers need extending to cover SIMD
registers, specifically those outside the mask, but this isn't
supported currently. For now, however, it would be useful to at least
warn when we receive a request (via the dwarf information in a binary)
for a register that we're choosing not to include in the sample set,
otherwise they could look like a spurious unwind errors.

>
>  tools/perf/builtin-script.c                   |   2 +-
>  tools/perf/util/evsel.c                       |   7 +-
>  tools/perf/util/parse-regs-options.c          |  17 ++-
>  .../perf/util/perf-regs-arch/perf_regs_x86.c  | 124 +++++++++++++++---
>  tools/perf/util/perf_regs.c                   |  12 +-
>  tools/perf/util/perf_regs.h                   |  10 +-
>  .../scripting-engines/trace-event-python.c    |   2 +-
>  tools/perf/util/session.c                     |   9 +-
>  8 files changed, 142 insertions(+), 41 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b80c406d1fc1..714528732e02 100644
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
>                                    val);
>         }
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5a294595a677..f565ef2eb476 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1054,19 +1054,22 @@ static void __evsel__config_callchain(struct evse=
l *evsel, const struct record_o
>         }
>
>         if (param->record_mode =3D=3D CALLCHAIN_DWARF) {
> +               int abi =3D -1; /* -1 indicates only basic GPRs are neede=
d. */

Should the abi come from checking
evsel->core.attr.sample_simd_regs_enabled and other related values?

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
> +                               abi =3D -1;

This assignment is redundant.

> +                               attr->sample_regs_user |=3D perf_user_reg=
_mask(EM_HOST, &abi);
>                         }
>                         attr->sample_stack_user =3D param->dump_size;
>                         attr->exclude_callchain_user =3D 1;
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse=
-regs-options.c
> index c93c2f0c8105..6cf865bfc2f7 100644
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
> +       int abi =3D 0;

0 here is PERF_SAMPLE_REGS_ABI_NONE, perhaps we can use the perf_env
that has kernel_is_64_bit to set the ABI to at least
PERF_SAMPLE_REGS_ABI_32 or PERF_SAMPLE_REGS_ABI_64. How will the SIMD
registers outside of the register mask be encoded?

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
> index b6d20522b4e8..ae26d991cdc9 100644
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
> @@ -276,13 +276,38 @@ uint64_t __perf_reg_mask_x86(bool intr)
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
> +       /* -1 indicates only basic GPRs are needed. */
> +       if (*abi < 0)
> +               return PERF_REGS_MASK;
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
> @@ -333,7 +358,60 @@ const char *__perf_reg_name_x86(int id)
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
> @@ -362,6 +440,22 @@ const char *__perf_reg_name_x86(int id)
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
> index 5b8f34beb24e..afc567718bee 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -32,7 +32,7 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *old=
_op, char **new_op)
>         return ret;
>  }
>
> -uint64_t perf_intr_reg_mask(uint16_t e_machine)
> +uint64_t perf_intr_reg_mask(uint16_t e_machine, int *abi)
>  {
>         uint64_t mask =3D 0;
>
> @@ -64,7 +64,7 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
>                 break;
>         case EM_386:
>         case EM_X86_64:
> -               mask =3D __perf_reg_mask_x86(/*intr=3D*/true);
> +               mask =3D __perf_reg_mask_x86(/*intr=3D*/true, abi);
>                 break;
>         default:
>                 pr_debug("Unknown ELF machine %d, interrupt sampling regi=
ster mask will be empty.\n",
> @@ -75,7 +75,7 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
>         return mask;
>  }
>
> -uint64_t perf_user_reg_mask(uint16_t e_machine)
> +uint64_t perf_user_reg_mask(uint16_t e_machine, int *abi)
>  {
>         uint64_t mask =3D 0;
>
> @@ -107,7 +107,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
>                 break;
>         case EM_386:
>         case EM_X86_64:
> -               mask =3D __perf_reg_mask_x86(/*intr=3D*/false);
> +               mask =3D __perf_reg_mask_x86(/*intr=3D*/false, abi);
>                 break;
>         default:
>                 pr_debug("Unknown ELF machine %d, user sampling register =
mask will be empty.\n",
> @@ -118,7 +118,7 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
>         return mask;
>  }
>
> -const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
> +const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, =
int abi)
>  {
>         const char *reg_name =3D NULL;
>
> @@ -150,7 +150,7 @@ const char *perf_reg_name(int id, uint16_t e_machine,=
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

Can we add an "/*inout*/" comment for the abi argument?

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

In dwarf_regs.h is also:
int __get_dwarf_regnum_x86_64(const char *name);
This needs extending for r16 to r31, xmm16-xmm31, etc.

__get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum);
I think this needs an ABI argument otherwise, how to differentiate r16
from XMM0?

Thanks,
Ian

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
