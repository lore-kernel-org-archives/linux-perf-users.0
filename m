Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBC34403A
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677816; cv=pass; b=C9GesZDE7n3XNEB4JbD+QMoZPx4+iMqk1V4yrrdml4JZAPzTp+RErU/svAwc/ExKBPyd6noacSXRgptzvRhv9vC7k0HhgSYHEtim4U8ave7T4ZWmFgODzzPfYXw+V1UilcQ1alHrFi5ymzZqTrQ7TSxed02GaLfMUEnvWjDtS0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677816; c=relaxed/simple;
	bh=OuZZiM53IUKgqwFvt6C5F+e5recuXWoWiFeQf2kwbE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqszA3tr/6DhWzY26AYUyT+Rqj/joUoFCO8MsHdcwvpXkw8NJ6cwCZROSDQGEY9rBOOfR27nx/B1GGlqQ0vfzI3LUUgFlI1TiLiFy0gYAGv1Dme61SIV0tzLSANkthZOBE8S8+33fnwoLpp4HivyWJhGmp5l+f5NPf0hhTBBLe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Necmj0Ph; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Necmj0Ph"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1455ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 06:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778677813; cv=none;
        d=google.com; s=arc-20240605;
        b=AGvIprn3wWlirpAvoUbkvBJtclG/cQZ6yarZuVo9G+saifoKI/kk6hPuzs1o7pZni/
         6EOZMoAvOLlwXWMjbLJsZMBTqVM1Xwwl2MAf8Qf8VBsxmTDgSl65zNT77KC2bnEatysk
         jn0hBaaNqPXeZWhOg+jGBTU3l0mYxjviXMBHQgUN7Ho+z/u2hZb4mr6JkR/RTOr2hu2W
         emx+rVwZoNaHjDnBQiaCf6E2IPackB0aJVpHlA7ooMKUzN4K20blqhLHefj/k/FNfOP4
         QyQzBmmV6ZIUBr9molIRHguM+96kNenxQn27+75TfP9ceTfaSY8ABNuttZ/7sihDZyQE
         dGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J80v47MFIUMplK/XrYKZ6oTEGbHAb+Wain7vFd3f27w=;
        fh=GA3gVbT3cHdOuNblbL41UGVaCQ1K6QLXymCQXh8xnk8=;
        b=G52g0fGA5Xw4IR6R8cX4RfgwRHuULmzNiNlWlKcNS2C1pjMrb6CT8mj6ZflVpnEG5C
         v1wiaQZjM/0tlqOKgKNh5D135K1CpP1l35+uAhSLrAdtqviRpnVfaCSDyLLG2a8lyao0
         ++p243xPs2j9qXHihT6Ikwgxomardv5mVm09dP4eXG4rqaZGxktk/h8Swqi0T0pVbGRA
         aw16q/X4km/Lr+0mPPijgXZSO3XwPIqa23XlyHJwgl638xI37r5UnjP9lo7igl2c1Kzx
         t3vo8TOi6HqMvS80eq3PXI+lOYr30Vp6QgaaObQYR04yPFmOFTtCHke1wq7U1rWFz5B8
         EqAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778677813; x=1779282613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J80v47MFIUMplK/XrYKZ6oTEGbHAb+Wain7vFd3f27w=;
        b=Necmj0PhcNXK/Igmudv2/+FE8JmfgPVHOUlE4eVdTwpAYuXMIIoQzmwyXklEi4b2E/
         G0BIQrBcxvVmofx6e11sIMfsv5ApnjooVBvvHbDImqFXy0YnJBLGuzpBbKhQysthV2ut
         yIPkOuoo5sBIcSxksnly4BMe8IyzdPmSE4u2QbKorBL8o1hbL45s7vyvmkBWCvgCrcIU
         TlQZyyCXSXdYN8+A/OUSMs8vq9agk88LdwCOXSOkHqib14x4XUSwFcWGPQinNLyFXLHs
         QAHWb6OaEjzr0t2ZeTgLKYRdQB4vP1yyw8dJuraWU4Rj18lEMBQW970Ttxkvu96rFk/Z
         0dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677813; x=1779282613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J80v47MFIUMplK/XrYKZ6oTEGbHAb+Wain7vFd3f27w=;
        b=HTBZ8iNdsB+BnsITpqR0vcnIAKAsR75NgPbn5Z49CJb1dSoIicrimuMHHG7mK/G8Mp
         eF1HsB5LH2G00VKAqfia6BwjAZ9yQK8HLiOVZfKjuOuziXrDU2y9GueAnqVKALhE7pkQ
         2JYLM0/Q5EQ/w+M8kzpOpo6jFtX3XLhmFojMIxKcqi0hWJlmZfD06KdP+8T0jhLDaRkX
         miw3Jhec4KJNl2t+geF9RdIqEaFKobOki6Kv20koPxZpHYpZV4VFmzmX7SP9TkF59eWI
         ExwkG8gzKaBB7PWC4OWr+Y8Nk5rW5i725LU7eUb4mhMd7o9cB1UC2SYLyZm/NEpOqnwy
         OKPw==
X-Forwarded-Encrypted: i=1; AFNElJ/BP6CQ7DbnxgQUyvjNmH3xACFdqng3V27alZUwfBtGHyW6uyoQr2B7iiE5Ca/rQQeO8DUUqnHDRUPHu++eacrb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5160bPhi8O+jIBrSxEaxTYvMRzonLudngcKOFxqHr3W7ukOr
	ph/Hz93+21G0QX6DOXIuROoSGOtWpCPOgFLkA3t11swjDeUvshwGxOwm1+SCDDeHcyt7bpbL+0u
	j13ANGzn6JQt1ahYt0PG3OzDW+53b4tmp8QsiLkds
X-Gm-Gg: Acq92OGv7gRPucksWX6qHBrsisJzIl3p/DZJnx2Ux+eOUJ58Zv+uj4d1VJ1PaP6kK+6
	Mvddvq6IdLKjE0Cl0QvxkYf26L7IbM2Q8bMkxX4yn/Ee0gHBsD9wuT41maaO67ACGnbMTvI0EJQ
	WnxRM1rsQlYrFWSUpOzrnMc36CxXkGIOFpGrkACJBpAsU/qovYZc4u2d1fO8IsRQbUc6OnuDIuH
	U5ng3ajr9xj+7fRXmIG3CIHtP4eldPf0RGohgZ3Q58fHkF6j95BAZQfi//t/EXsnm5B0RFy+Xuh
	Tp/7VVsZfL2V2n2IEIc=
X-Received: by 2002:a17:903:2154:b0:2b8:e82d:ff7c with SMTP id
 d9443c01a7336-2bd2c0f12bemr1575125ad.9.1778677812356; Wed, 13 May 2026
 06:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b@arm.com>
In-Reply-To: <20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 May 2026 06:10:00 -0700
X-Gm-Features: AVHnY4IbIvN-HTv2dz5KRRE_1vRGBFzhoaoEPIQvKP1iD8T9FqlysrUiSwFy1wo
Message-ID: <CAP-5=fWEU5qqTHjisUyDJMQQB5yFibyogMwAerTs5VUF0OSPHA@mail.gmail.com>
Subject: Re: [PATCH v2] perf pmu: Skip test on Arm64 when #slots is zero
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 4:13=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Some Arm64 PMUs expose 'caps/slots' as 0 when the slot count is not
> implemented, tool_pmu__read_event() currently returns false for this,
> so metrics that reference #slots are reported as syntax error.
>
> Since the commit 3a61fd866ef9 ("perf expr: Return -EINVAL for syntax
> error in expr__find_ids()"), these syntax errors are populated as
> failures and make the PMU metric test fail:
>
>     9.3: Parsing of PMU event table metrics:
>     --- start ---
>     ...
>
>     Found metric 'backend_bound'
>     metric expr 100 * (stall_slot_backend / (#slots * cpu_cycles)) for ba=
ckend_bound
>     parsing metric: 100 * (stall_slot_backend / (#slots * cpu_cycles))
>     Failure to read '#slots'
>     literal: #slots =3D nan
>     syntax error
>     Fail to parse metric or group `backend_bound'
>
>     ...
>     ---- end(-1) ----
>     9.3: Parsing of PMU event table metrics    : FAILED!
>
> This commit introduces a new function is_expected_broken_metric() to
> identify broken metrics, and treats metrics containing "#slots" as
> expected broken when #slots =3D=3D 0 on Arm64 platforms.
>
> Fixes: 3a61fd866ef9 ("perf expr: Return -EINVAL for syntax error in expr_=
_find_ids()")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

We get this failure for these metrics on x86 when building perf with
JEVENTS_ARCH=3Dall. Rather than expecting the parse failure perhaps we
should just always return true in tool_pmu__read_event:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/tool_pmu.c#n421
I guess the problem there is that when these metrics are broken (no
slots value) you can't distinguish this case from other valid cases.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changes in v2:
> - Checked pm->metric_expr instead of pm->metric_name and removed the
>   negation before strstr() suggested by sashiko.
> - Link to v1: https://lore.kernel.org/r/20260410-perf_fix_pmu_metrics_tes=
t-v1-1-18a5d80f71b6@arm.com
> ---
>  tools/perf/tests/pmu-events.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.=
c
> index a997168621688007c85495e2d9f6f459c2471516..b1609a7e1d8c9427e6bf95003=
80e8aac6167c7fa 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -15,6 +15,7 @@
>  #include "util/expr.h"
>  #include "util/hashmap.h"
>  #include "util/parse-events.h"
> +#include "util/tool_pmu.h"
>  #include "metricgroup.h"
>  #include "stat.h"
>
> @@ -817,6 +818,26 @@ struct metric {
>         struct metric_ref metric_ref;
>  };
>
> +static bool is_expected_broken_metric(const struct pmu_metric *pm)
> +{
> +       if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_name, "M=
2") ||
> +           !strcmp(pm->metric_name, "M3"))
> +               return true;
> +
> +#if defined(__aarch64__)
> +       /*
> +        * Arm64 platforms may return "#slots =3D=3D 0", which is treated=
 as a
> +        * syntax error by the parser. Don't test these metrics when runn=
ing
> +        * on such platforms.
> +        */
> +       if (strstr(pm->metric_expr, "#slots") &&
> +           !tool_pmu__cpu_slots_per_cycle())
> +               return true;
> +#endif
> +
> +       return false;
> +}
> +
>  static int test__parsing_callback(const struct pmu_metric *pm,
>                                   const struct pmu_metrics_table *table,
>                                   void *data)
> @@ -852,8 +873,7 @@ static int test__parsing_callback(const struct pmu_me=
tric *pm,
>
>         err =3D metricgroup__parse_groups_test(evlist, table, pm->metric_=
name);
>         if (err) {
> -               if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_=
name, "M2") ||
> -                   !strcmp(pm->metric_name, "M3")) {
> +               if (is_expected_broken_metric(pm)) {
>                         (*failures)--;
>                         pr_debug("Expected broken metric %s skipping\n", =
pm->metric_name);
>                         err =3D 0;
>
> ---
> base-commit: 4cf1f549bbcdfea9c20df52994bb342677472dcd
> change-id: 20260408-perf_fix_pmu_metrics_test-73c4dedc8585
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>
