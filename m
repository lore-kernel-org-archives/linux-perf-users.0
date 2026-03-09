Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C93E7149
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070123; cv=pass; b=grslsKMNgvmH1537w086rlitB/5IrPD6kpqjm6p5c8BK/A/87mrkQ0hqthjfl2ejq3d3nS2yrLQut7cDlfDjiG+Avt+kD5cVRBvAtFBzfV3TfwVymP94rykLMhxiWvftenw10rHBksGo+pjp52KMWoZVPwM4gcdMlYIyvibh51U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070123; c=relaxed/simple;
	bh=o2QI0Yj6+CKf8lfIsCBQgUkg19hGsh6BGYR2rkbZggY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlAA+nG2iVntWvuA0FSf0F0bo42otKodeeGKy4PgW9ifNiLf9oM8d8ThUUg0AAFfdKZZ2HQlpeHv4PhyGf50PFVZvkIGfAbwZBph2/1NVImW1DIpQR83xEOjFKjgyCiVj4X6LBKX59qKmeEEmZb8K41mTsRFs9nT1S4eOicaiL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZwfwrOWU; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZwfwrOWU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae4b40999bso159685ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 08:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773070121; cv=none;
        d=google.com; s=arc-20240605;
        b=L70xtwJjGQxaLxB2IgLXBsF7rxTPsus2XDNgEBqM4SH3GlcTvtp6cNUkSfYxHrCcoH
         KPUL6tk6SF1wlgvVsQM9XqoGq092gmYg2P+sy1dwmSq0aJ2HCYGHFOKQ/1TJ9w8bxPCn
         8V0FKpnMwQEK+UHfmwDZMq8kuSUityMGAgBNfk+i2NoxZl+5yPWJ0Q6XSB0dP2zt+o80
         k9nlF2prL15+8z4/QZP0RpukWXfsOzbVmPMa7CaXIkzUjHFc8s1+UagD0lxeJFEkPuM7
         cPltKknoyzYCyLciWvpyRacejYCzbD3zP/LltwIbF8fYsFM1A9mWZFtoaPVEN2HAjjjv
         cdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o+PCCyBjUmuep/B1rPUgGTwDvCOXRAKjhfR9xiWluww=;
        fh=7pwKRJFIWR/oAsDmZ/w8qD6FfXzLgYwq09eyzn+qSn0=;
        b=K60Ud5wFUBu8XFDEpEfMocLh3x/TQyEycwAmjqmREUPFF1XwV0MYvzum7JxdwnAjE4
         WgDuPkc5z7E1NwblAjZErEKU3YcIeO5834lvyJS/69jFci8vptjoeTVbGHthBrrAgOkC
         3MzEzB+SknD3+f70N7GrMcvdGs5L8KOB9IJAo6RkuB6CcnIseqFQgbDm0aCmIRl+hMpb
         HrBGrZVVhMxeyy4zaRb+BqWM6yrBam9PXV9REbxKjjiang1ZtJJzCv77RavheRzE46d8
         1wf22sPfyv8W2bVqvTpwJe4R4vAvG5DKUG9j44Qs/Re2OyQaVj4efuNiQS+PFKWBjkZ3
         rY3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773070121; x=1773674921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+PCCyBjUmuep/B1rPUgGTwDvCOXRAKjhfR9xiWluww=;
        b=ZwfwrOWUIIjnSVPsJAzlO2tZDea2cjiRWYnBq2/k0HLkB6EyATNQ2Ynh3MEqZ6CLal
         3dOZHoyAte/wJhyRHJWMGrSoqR9/CPBBSnkUDL7O21VeKuEzmvAYDgFqhRbuBemnajgS
         7u4iGaGbUZOEz6rMC2OL3rDJpvHy2+/DXgHLOQkza9Z2qCUKBcofPqPD2+0aROFtQJfK
         qI2lSotPzIW1M0OsbDOmaMh1X71+YSoCpooB6DfxQgL4Ls0KVHSOEJruIrgrp9tAGLDf
         AVmt8X+FLymREXsfECJQjVB64549ZE0rNWvF9yX6Z+V1COgl3qR9AfdL7GOjVZOPGHAf
         5nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070121; x=1773674921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+PCCyBjUmuep/B1rPUgGTwDvCOXRAKjhfR9xiWluww=;
        b=igrLTy5uKaUK4OnJ94JRSfH4leaVuDOM/vmH3Mef6pg6dHNHrRPKRhCxGtnPLJNeNW
         u2/nn5lVicX2WIVslnzFoyr9IxiTrAG2VPZD7wwpgt/OWcsDMstU5rhnYrgcO2dzUXfJ
         amdNiqPPGiTFyHSAsJcyqY/PnTgQ4BVv2h2G06Cn4+SvQI/aj4n2v+HlhLNn9SA/vFre
         M8bQB6lBXxT7CoR6BAZL01/bJrmu32HbNzRYpAtvyJn6guvhe6XUypSbo+QfA6Nhaasb
         Bs9cDjxKNVdLAlT8wiCoiJRh0CD1vDXR3n5SGf+0ofa5j2+x7Jbm0TxXygM97al3uv/m
         7rUg==
X-Forwarded-Encrypted: i=1; AJvYcCX33lxkl5lyBpev94l5qWJKygdaSElalbqI9GttcDnjEO8fv0PJmMDFAlnJ7SCpiRCEIWL7CBC4GjUtjRY4hUeT@vger.kernel.org
X-Gm-Message-State: AOJu0YyjibejbZOkN+R6U49SH9zfhx+rvsqGop1LUQbxPTk+x3+AL2Fz
	qbNqla4/+lpJ25oFrm88fD6bnlqa0rkE6oeMeUbxSAOz8mlDIQ3JP4JI3b/i+4m6w64ZKaNmYG2
	7MilNjfglKawpRQ4qxTTDM89cRPYyGsbI8CeaK+td
X-Gm-Gg: ATEYQzzAOLH6G1bFFmUg/WkmWac5NIMRxF/sbzoM8+USRoGi4TboxuPjv7ypQHmD6cu
	67tebhhDVvueTZVW+1hTRTf0eyISrYkJmECCakNLfAGOqp8hp539VGB6Nn8I9e1YyNFD/ISKb1c
	i6JGQlSNOhPsQ7qyo6n65MfQvEBi7Ynn+DSOLMtUCCTQ/aFoslikWfuO85Am4SpFCvwrgiaieiP
	jepz1Pw2418SIAQQ/GRSXRRf1gFKf6qChrNIzuxAbPVX9QmfkpQV+cxMkVcxiIoeaXqABLityqy
	8USivYDc0zv/t995A28xw8bmu35GMd4bhkobnw==
X-Received: by 2002:a17:902:f543:b0:2ae:4572:50e8 with SMTP id
 d9443c01a7336-2ae8ad1cfb3mr3696755ad.8.1773070120934; Mon, 09 Mar 2026
 08:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214040659.168769-2-ricky.ringler@proton.me>
 <aaeKBOolC3AyHAFa@google.com> <20260305235655.40779-1-ricky.ringler@proton.me>
 <THyJLu3kRy_7q7V6-XpKu2hIZsSzkadNwnZ6YIOUSSTS2if2u3OWv6ROm_MtvBWVQVOJ03FVWw0POxzhU0LpeSBhoKSxTwKVV-JhZFJNCvg=@proton.me>
 <20260308172037.123654-1-ricky.ringler@proton.me>
In-Reply-To: <20260308172037.123654-1-ricky.ringler@proton.me>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 08:28:29 -0700
X-Gm-Features: AaiRm51cSHWWv6rAzhyD5ZxyRod7wzVerWuvw2mSBd20O47ntnGUu4V0zvkr15M
Message-ID: <CAP-5=fVk22oOxLSN-2_MioJ3RKUpQwD2TWK9sA=WcegUc_dj1w@mail.gmail.com>
Subject: Re: [PATCH v3] perf utilities: cln_size header
To: Ricky Ringler <ricky.ringler@proton.me>
Cc: namhyung@kernel.org, mingo@redhat.com, acme@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 10:21=E2=80=AFAM Ricky Ringler <ricky.ringler@proton=
.me> wrote:
>
> Store cacheline size during perf record in header, so
> that cacheline size can be used for other features, like
> sort.
>
> Follow-up patch from message ID "aYZiQk6Uftzlb_JV@x1"
>
> Testing:
> - Built perf
> - Ran record + report with feat enabled
> - Ran record + report with feat disabled
>
> Tested-by: Ricky Ringler <ricky.ringler@proton.me>
> Signed-off-by: Ricky Ringler <ricky.ringler@proton.me>
> ---
>  tools/perf/builtin-inject.c |  1 +
>  tools/perf/util/env.h       |  1 +
>  tools/perf/util/header.c    | 29 +++++++++++++++++++++++++++++
>  tools/perf/util/header.h    |  1 +
>  tools/perf/util/sort.c      | 37 ++++++++++++++++++++++++++-----------
>  5 files changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5b29f4296861..2675d32f88cf 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2134,6 +2134,7 @@ static bool keep_feat(struct perf_inject *inject, i=
nt feat)
>         case HEADER_HYBRID_TOPOLOGY:
>         case HEADER_PMU_CAPS:
>         case HEADER_CPU_DOMAIN_INFO:
> +       case HEADER_CLNq_SIZE:

Looks like a typo, s/HEADER_CLNq_SIZE/HEADER_CLN_SIZE/

>                 return true;
>         /* Information that can be updated */
>         case HEADER_BUILD_ID:
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index a4501cbca375..c7052ac1f856 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -112,6 +112,7 @@ struct perf_env {
>         struct cpu_cache_level  *caches;
>         struct cpu_domain_map   **cpu_domain;
>         int                      caches_cnt;
> +       unsigned int            cln_size;
>         u32                     comp_ratio;
>         u32                     comp_ver;
>         u32                     comp_type;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9142a8ba4019..4f65faafe75d 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -54,6 +54,7 @@
>  #include "bpf-event.h"
>  #include "bpf-utils.h"
>  #include "clockid.h"
> +#include "cacheline.h"
>
>  #include <linux/ctype.h>
>  #include <internal/lib.h>
> @@ -1304,6 +1305,18 @@ static int write_cache(struct feat_fd *ff,
>         return ret;
>  }
>
> +static int write_cln_size(struct feat_fd *ff,
> +                      struct evlist *evlist __maybe_unused)
> +{
> +       int cln_size =3D cacheline_size();
> +
> +       if (!cln_size)
> +               cln_size =3D 0;

Did you mean to assign "cln_size =3D DEFAULT_CACHELINE_SIZE" here? It
seems strange to something with value 0 the value 0.

> +       ff->ph->env.cln_size =3D cln_size;
> +
> +       return do_write(ff, &cln_size, sizeof(cln_size));
> +}
> +
>  static int write_stat(struct feat_fd *ff __maybe_unused,
>                       struct evlist *evlist __maybe_unused)
>  {
> @@ -2261,6 +2274,11 @@ static void print_cache(struct feat_fd *ff, FILE *=
fp __maybe_unused)
>         }
>  }
>
> +static void print_cln_size(struct feat_fd *ff, FILE *fp __maybe_unused)

No need for the __maybe_unused on fp here.

> +{
> +       fprintf(fp, "# cacheline size: %u\n", ff->ph->env.cln_size);
> +}
> +
>  static void print_compressed(struct feat_fd *ff, FILE *fp)
>  {
>         fprintf(fp, "# compressed : %s, level =3D %d, ratio =3D %d\n",
> @@ -3154,6 +3172,16 @@ static int process_cache(struct feat_fd *ff, void =
*data __maybe_unused)
>         return -1;
>  }
>
> +static int process_cln_size(struct feat_fd *ff, void *data __maybe_unuse=
d)
> +{
> +       struct perf_env *env =3D &ff->ph->env;
> +
> +       if (do_read_u32(ff, &env->cln_size))
> +               return -1;
> +
> +       return 0;
> +}
> +
>  static int process_sample_time(struct feat_fd *ff, void *data __maybe_un=
used)
>  {
>         struct perf_session *session;
> @@ -3763,6 +3791,7 @@ const struct perf_header_feature_ops feat_ops[HEADE=
R_LAST_FEATURE] =3D {
>         FEAT_OPR(PMU_CAPS,      pmu_caps,       false),
>         FEAT_OPR(CPU_DOMAIN_INFO,       cpu_domain_info,        true),
>         FEAT_OPR(E_MACHINE,     e_machine,      false),
> +       FEAT_OPR(CLN_SIZE,      cln_size,       false),
>  };
>
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index cc40ac796f52..be315040727f 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -55,6 +55,7 @@ enum {
>         HEADER_PMU_CAPS,
>         HEADER_CPU_DOMAIN_INFO,
>         HEADER_E_MACHINE,
> +       HEADER_CLN_SIZE,
>         HEADER_LAST_FEATURE,
>         HEADER_FEAT_BITS        =3D 256,
>  };
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 42d5cd7ef4e2..13287ade784e 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -30,6 +30,7 @@
>  #include "time-utils.h"
>  #include "cgroup.h"
>  #include "machine.h"
> +#include "session.h"
>  #include "trace-event.h"
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> @@ -2474,7 +2475,26 @@ struct sort_entry sort_type_offset =3D {
>
>  /* --sort typecln */
>
> -#define DEFAULT_CACHELINE_SIZE 64
> +static int
> +hist_entry__cln_size(struct hist_entry *he)
> +{
> +       int ret =3D 0;
> +
> +       if (he && he->hists) {
> +               struct evsel *evsel =3D hists_to_evsel(he->hists);
> +
> +               if (evsel && evsel->evlist->session && evsel->evlist->ses=
sion)
> +                       ret =3D evsel->evlist->session->header.env.cln_si=
ze;

I think on these 2 lines, prefer evsel__session(evsel) rather than the
direct access.

Thanks,
Ian

> +       }
> +
> +       if (!ret || ret < 1) {
> +               int default_cacheline_size =3D 64; // avoid div/0 later
> +
> +               ret =3D default_cacheline_size;
> +       }
> +
> +       return ret;
> +}
>
>  static int64_t
>  sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
> @@ -2482,11 +2502,9 @@ sort__typecln_sort(struct hist_entry *left, struct=
 hist_entry *right)
>         struct annotated_data_type *left_type =3D left->mem_type;
>         struct annotated_data_type *right_type =3D right->mem_type;
>         int64_t left_cln, right_cln;
> +       int64_t cln_size_left =3D hist_entry__cln_size(left);
> +       int64_t cln_size_right =3D hist_entry__cln_size(right);
>         int64_t ret;
> -       int cln_size =3D cacheline_size();
> -
> -       if (cln_size =3D=3D 0)
> -               cln_size =3D DEFAULT_CACHELINE_SIZE;
>
>         if (!left_type) {
>                 sort__type_init(left);
> @@ -2502,8 +2520,8 @@ sort__typecln_sort(struct hist_entry *left, struct =
hist_entry *right)
>         if (ret)
>                 return ret;
>
> -       left_cln =3D left->mem_type_off / cln_size;
> -       right_cln =3D right->mem_type_off / cln_size;
> +       left_cln =3D left->mem_type_off / cln_size_left;
> +       right_cln =3D right->mem_type_off / cln_size_right;
>         return left_cln - right_cln;
>  }
>
> @@ -2511,10 +2529,7 @@ static int hist_entry__typecln_snprintf(struct his=
t_entry *he, char *bf,
>                                      size_t size, unsigned int width __ma=
ybe_unused)
>  {
>         struct annotated_data_type *he_type =3D he->mem_type;
> -       int cln_size =3D cacheline_size();
> -
> -       if (cln_size =3D=3D 0)
> -               cln_size =3D DEFAULT_CACHELINE_SIZE;
> +       int cln_size =3D hist_entry__cln_size(he);
>
>         return repsep_snprintf(bf, size, "%s: cache-line %d", he_type->se=
lf.type_name,
>                                he->mem_type_off / cln_size);
> --
> 2.53.0
>
>
>
