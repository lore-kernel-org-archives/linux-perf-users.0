Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272E1EA8D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912543; cv=none; b=uelbOQ9eUVeMPit1R5N0ktUoRpTlxVkX56aBaL3oQn53xaPHfsdY1INRwdQbiP59Rji6Rv4lQWlRqsnH/SYaWkXSwyYCbCgR3ql/RCQMGsEe7ixax2vpjEn2vEy2MKSpUYreklZs/JUU7MRM98PHKIL7hjOGTUnSUzS3rpKWyKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912543; c=relaxed/simple;
	bh=q3rJ1K4a1vL1Qu/phBQBW+iD659Ved+2DL9VEOCZbrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RCPbhwxiBlJxfZhgjfUlBnbNtz1dRzm+wMagNlq22fIx11/PBz0PLHZICOK8kqzdkpPmTdAJZgMS7lSmG7uX+3hAVeMSiJeKRcHGTjFyxfX3Ib5K5CD3iMNz809pIsPpyR39I+ZkTDv/v2gmq7yUANZXgI3h/VDxVx/BPTkCzh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yblf64iG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yblf64iG"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-439b1c72676so92911cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713912540; x=1714517340; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFuf1odJW6gw+5rRIRioMk6XvuTZgOYXmnq0hWj8KOU=;
        b=yblf64iG+UrxnHtnrhcTrPAsnOVOantu7dypRxh6pglAeZW3gG5xullReF8pGz/ecR
         /qquIHeOKFYM55pG9S3QSMN6858No5SQRSedkJJWMj/RRuD5In15mY6tEPa+kDtQusZw
         mGIpxgtNc4y8xXeDjnip7t+WdrmsvXZtlMV4U4IMKVtXhAOAUejQPy72lDXSq6Hv096H
         Vh047LqV/f1JH3ytzJXbgTSQPIqmF7jx01QbGFaqVUfeT0naqeiQUTpvX9CXVv1VH4RR
         RUiIV1p184t758QPBLKCCugeMlrVEmMgZX16xHZUlXYP9qcoul+L/Csb0Zkdlww2+YS8
         wlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713912540; x=1714517340;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFuf1odJW6gw+5rRIRioMk6XvuTZgOYXmnq0hWj8KOU=;
        b=UwMiO6nAKGvQfIvZUrJ7lKIe9IelfFhEG5QENCxBmSs6PSoHPthpxoaL7k65APHrKu
         lBpYET2Nuo8Rm/8cufojSRMG47L5AelLcCq4AiWx+rRquvpN7p6D2OXEBdl9TIzxshrL
         +SKE91NRhfEF+cBtdf2jsgY5KElEyImnXNAofYv2wr0ZsD3nesWnM8K18eYWBfA6sVpE
         BGWvIiz5xel2jfiY0BbtSJGfj7Ni0d8lmUyRJBimRiXcSzAe2X5RTbxurytcrTex/QZ0
         W1KSSW3OvGtNYqbeFPUp44zotZpgMJ+aabefcI99E4gLSWsZzQ1xNSWf1RoEVKR/ELQt
         jsgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjOFUQ1/mOnA0HOIOB03CB9mO8VuLWAlQER3oM49oM3klobQtM94LG6EBT+0pB9hualhreK8gi4LABQ79JcYZlwExq0W8lGJGEAlE5S0CaDg==
X-Gm-Message-State: AOJu0YwHlCaxB7Zl6Su3wWLl6zxrIMMF+M94EiH/HFDtv3KJWGM5Re+Q
	P8gOEtVpZzzqrFCre24jhSY4Yx9y3hFirvS2BIqOmeKSSQlrECZe3xXkN8N9/mpfJT1DtOKyXc/
	2K7BvpAWq7Qkbv/nujPGQuWztUB3p23L6Zsqr
X-Google-Smtp-Source: AGHT+IFgrJmuqO3aOW7/tZCx+QVARQ7MwfvlmzhtXJrUMzw/zLxt5jU9cu2ClNCgb0H7upSfSPusLpDOjuysnwsbDmc=
X-Received: by 2002:ac8:6e81:0:b0:437:c89e:245b with SMTP id
 c1-20020ac86e81000000b00437c89e245bmr43930qtv.15.1713912539931; Tue, 23 Apr
 2024 15:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410011313.2556848-1-irogers@google.com>
In-Reply-To: <20240410011313.2556848-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Apr 2024 15:48:48 -0700
Message-ID: <CAP-5=fU7gO2VOEc6MCaPGnsznVPUmGcS6zm=b0xtWp+qxoSibw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Bharat Bhushan <bbhushan2@marvell.com>, 
	Bhaskara Budiredla <bbudiredla@marvell.com>, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>, Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:13=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> The mrvl_ddr_pmu is uncore and has a hexadecimal address suffix while
> the previous PMU sorting/merging code assumes uncore PMU names start
> with uncore_ and have a decimal suffix. Because of the previous
> assumption it isn't possible to wildcard the mrvl_ddr_pmu.
>
> Modify pmu_name_len_no_suffix but also remove the suffix number out
> argument, this is because we don't know if a suffix number of say 10
> is in hexadecimal or decimal. As the only use of the suffix number is
> in comparisons, it is safe there to compare the values as hexadecimal.

+Thomas Richter

Thomas could you help validate that this doesn't cause issues on s390
with the cpum_cf PMU (note how cf potentially looks like a hex
suffix).

Thanks,
Ian

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c  |  2 +-
>  tools/perf/util/pmus.c | 51 ++++++++++++++++++++++--------------------
>  tools/perf/util/pmus.h |  7 +++++-
>  3 files changed, 34 insertions(+), 26 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index f39cbbc1a7ec..b0cca5841f90 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1657,7 +1657,7 @@ static char *format_alias(char *buf, int len, const=
 struct perf_pmu *pmu,
>  {
>         struct parse_events_term *term;
>         int pmu_name_len =3D skip_duplicate_pmus
> -               ? pmu_name_len_no_suffix(pmu->name, /*num=3D*/NULL)
> +               ? pmu_name_len_no_suffix(pmu->name)
>                 : (int)strlen(pmu->name);
>         int used =3D snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->nam=
e, alias->name);
>
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 16505071d362..b4ddcd0ade26 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -39,31 +39,44 @@ static bool read_sysfs_all_pmus;
>
>  static void pmu_read_sysfs(bool core_only);
>
> -int pmu_name_len_no_suffix(const char *str, unsigned long *num)
> +int pmu_name_len_no_suffix(const char *str)
>  {
>         int orig_len, len;
>
>         orig_len =3D len =3D strlen(str);
>
> -       /* Non-uncore PMUs have their full length, for example, i915. */
> -       if (!strstarts(str, "uncore_"))
> -               return len;
> -
>         /*
>          * Count trailing digits and '_', if '_{num}' suffix isn't presen=
t use
>          * the full length.
>          */
> -       while (len > 0 && isdigit(str[len - 1]))
> +       while (len > 0 && isxdigit(str[len - 1]))
>                 len--;
>
> -       if (len > 0 && len !=3D orig_len && str[len - 1] =3D=3D '_') {
> -               if (num)
> -                       *num =3D strtoul(&str[len], NULL, 10);
> +       if (len > 0 && len !=3D orig_len && str[len - 1] =3D=3D '_')
>                 return len - 1;
> -       }
> +
>         return orig_len;
>  }
>
> +int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
> +{
> +       unsigned long lhs_num =3D 0, rhs_num =3D 0;
> +       int lhs_pmu_name_len =3D pmu_name_len_no_suffix(lhs_pmu_name);
> +       int rhs_pmu_name_len =3D pmu_name_len_no_suffix(rhs_pmu_name);
> +       int ret =3D strncmp(lhs_pmu_name, rhs_pmu_name,
> +                       lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_nam=
e_len : rhs_pmu_name_len);
> +
> +       if (lhs_pmu_name_len !=3D rhs_pmu_name_len || ret !=3D 0 || lhs_p=
mu_name_len =3D=3D 0)
> +               return ret;
> +
> +       if (lhs_pmu_name_len + 1 < (int)strlen(lhs_pmu_name))
> +               lhs_num =3D strtoul(&lhs_pmu_name[lhs_pmu_name_len + 1], =
NULL, 16);
> +       if (rhs_pmu_name_len + 1 < (int)strlen(rhs_pmu_name))
> +               rhs_num =3D strtoul(&rhs_pmu_name[rhs_pmu_name_len + 1], =
NULL, 16);
> +
> +       return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> +}
> +
>  void perf_pmus__destroy(void)
>  {
>         struct perf_pmu *pmu, *tmp;
> @@ -164,20 +177,10 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, =
const char *name)
>  static int pmus_cmp(void *priv __maybe_unused,
>                     const struct list_head *lhs, const struct list_head *=
rhs)
>  {
> -       unsigned long lhs_num =3D 0, rhs_num =3D 0;
>         struct perf_pmu *lhs_pmu =3D container_of(lhs, struct perf_pmu, l=
ist);
>         struct perf_pmu *rhs_pmu =3D container_of(rhs, struct perf_pmu, l=
ist);
> -       const char *lhs_pmu_name =3D lhs_pmu->name ?: "";
> -       const char *rhs_pmu_name =3D rhs_pmu->name ?: "";
> -       int lhs_pmu_name_len =3D pmu_name_len_no_suffix(lhs_pmu_name, &lh=
s_num);
> -       int rhs_pmu_name_len =3D pmu_name_len_no_suffix(rhs_pmu_name, &rh=
s_num);
> -       int ret =3D strncmp(lhs_pmu_name, rhs_pmu_name,
> -                       lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_nam=
e_len : rhs_pmu_name_len);
>
> -       if (lhs_pmu_name_len !=3D rhs_pmu_name_len || ret !=3D 0 || lhs_p=
mu_name_len =3D=3D 0)
> -               return ret;
> -
> -       return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> +       return pmu_name_cmp(lhs_pmu->name ?: "", rhs_pmu->name ?: "");
>  }
>
>  /* Add all pmus in sysfs to pmu list: */
> @@ -297,11 +300,11 @@ static struct perf_pmu *perf_pmus__scan_skip_duplic=
ates(struct perf_pmu *pmu)
>                 pmu_read_sysfs(/*core_only=3D*/false);
>                 pmu =3D list_prepare_entry(pmu, &core_pmus, list);
>         } else
> -               last_pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?:=
 "", NULL);
> +               last_pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?:=
 "");
>
>         if (use_core_pmus) {
>                 list_for_each_entry_continue(pmu, &core_pmus, list) {
> -                       int pmu_name_len =3D pmu_name_len_no_suffix(pmu->=
name ?: "", /*num=3D*/NULL);
> +                       int pmu_name_len =3D pmu_name_len_no_suffix(pmu->=
name ?: "");
>
>                         if (last_pmu_name_len =3D=3D pmu_name_len &&
>                             !strncmp(last_pmu_name, pmu->name ?: "", pmu_=
name_len))
> @@ -313,7 +316,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicat=
es(struct perf_pmu *pmu)
>                 pmu =3D list_prepare_entry(pmu, &other_pmus, list);
>         }
>         list_for_each_entry_continue(pmu, &other_pmus, list) {
> -               int pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?: =
"", /*num=3D*/NULL);
> +               int pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?: =
"");
>
>                 if (last_pmu_name_len =3D=3D pmu_name_len &&
>                     !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len=
))
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 94d2a08d894b..624c2d53fc30 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -2,10 +2,15 @@
>  #ifndef __PMUS_H
>  #define __PMUS_H
>
> +#include <stdbool.h>
> +#include <linux/list.h>
> +
>  struct perf_pmu;
>  struct print_callbacks;
>
> -int pmu_name_len_no_suffix(const char *str, unsigned long *num);
> +int pmu_name_len_no_suffix(const char *str);
> +/* Exposed for testing only. */
> +int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
>
>  void perf_pmus__destroy(void);
>
> --
> 2.44.0.478.gd926399ef9-goog
>
