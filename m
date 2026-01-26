Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1DE344DB7
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445859; cv=pass; b=uu5wV5pCLzkPmMy9RSUtlO20e3z4stVptE0jxds/ii9P9is4qgfz8ePh4yhivJi3oATTbNLR3z3FrD0YS1ONlfgNSpFJGtgU2eW1YOEs6rRGTc8V3zbsWTggCpxJBCnpdz39FZnLl8z0U5v3SmoUdbmU4IaQdZboGjfGD5f2wk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445859; c=relaxed/simple;
	bh=ijBB1BRvhhOEdEQDllwKzoQbnf42S4Wm/dbRHau5Dpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMDfugmoi+GKcbnTjI/MjUaGC8Nd9unT5ISoKME+nRTpn2lZxPcXo64n8nPTke8BSpD+9mIwBscrqkSGgKPh9g7VNG3BtxbjyO6/rYg+nPIUhoww1ukZeCwQg/aR0WS8Js3uO9LufzK3akeWI+IEREjFovY6mXMf63DX14y9F44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etwylixs; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etwylixs"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d06cfa93so151095ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 08:44:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769445855; cv=none;
        d=google.com; s=arc-20240605;
        b=RkfEd1YcrSt4M9hFyOAhfAS97pYItEpnV00cyonzVKnGl1ZXDFF6q5yKfdY7BPn9AV
         rTbqP4z7IkB9EAQ7xhxGWgJZpdCqg2Y8r7LAXinp8368J0g2kmS9jOwWpC8T/cjDREpt
         O9J0jly8RFp+7vhOIsDD68UaS2QVCnCe8Xrlinmk+qieiawvAqO2M9FJPdV5dcxK3NrX
         4Vh2z/h+CfznSPjipB/7rLheVLf4Q8Imd8IEaLrMmu8CjiVvq5xrneZ1R2krSVfYGkXg
         +RX0C5qqRZpYLbKl9FBMAZUFFYGEihBsETt5J1IZj8HSVNU/nOVY2eaUItskzGqtAeGs
         kISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGAy20/G0aLhcGacwfot8jtNaLKVL17HJucsdvURcXU=;
        fh=RzWYv11tz4ht14ZA0tgUseHW33MHFPhnjlb9VHb5ia8=;
        b=Oimop3BNLxJMsTk19tqbjCV9XKyfdTGZM14EaDZ4gbnuniYcPInLm8zwHPQu2BuqZO
         /IqMWbaxCLGPAnKhmrKiR2sHOHAoRmsDMsR/SHPNQ69aNSDNu1yZp/PuKcLD6NgORuO5
         zw7xQbMu6EpkYK4a3SMEeSfzWXuHoLHoGuhPAVX1sAhmWbPHPIgJEyjED7zh+43GUDTx
         Uf2j0r6jptWhalCMz7rFoX+ayiHFWU2xFXQSHPWWqM8Q6GlXpUSgWvuKsuJZO5dAC81i
         kRutzvzm1UoN2FM/rddZykKMQULbPTVPaxeaNFCraZpoLcpj///SChiL6NXfSwuvZZz2
         hVwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769445855; x=1770050655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGAy20/G0aLhcGacwfot8jtNaLKVL17HJucsdvURcXU=;
        b=etwylixsQjIH33t8vpV2sUnU56OtVypUsd0eFu1GvX4YhOilUJ3KbBjl6k7J8bVyYX
         oZ3qcurbhFLY/J1+74Jyr4CAgFNd6mttQA9YoYEnw6myR57c/yE2ANDfBlNYNPydzLkN
         v/E9qMzh9HDpdoboTd7QDL5D5Mz2rXXcFXvVA11wujGZrwEljZIuB1q3ZLtHOkwWO96p
         wH/PEQ2EXbwwVfY5MC0ZMCXFvyhDmo7F28FdQQVes71XUnUx5dqCVy59Is9jVXAWO7xp
         2MhYmSgyQJ6s3NmnrL5pTkEpA51dZJP7orr/lFOx4md1odp8EWoqunuX6OA5Mon8lfIy
         L/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769445855; x=1770050655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGAy20/G0aLhcGacwfot8jtNaLKVL17HJucsdvURcXU=;
        b=UgP+h31ZWN65kG8zMtuj6PbjvE6AwV94Spt8SLQ/CQATHYF4uVjdp3DqgRZLofPkC0
         dSfp4BU9vuz89+VHw0GCEP3Hgz4XNnqBndImTJHOs3AVpgldvwielVG7Q65djognqwNj
         6Bv4cUPnrH6nlWT5yaScGrBB03Ys2vBQ0GaqnBmAJ20BY1WHOK+q0bOnb9yPk5vbAzak
         tOxOp6cWRynlw21PTs8Ky9m2rx42OEdbiL778s7ObyKHlR+/RFLxGbMrhPTOxZrbltvI
         /evgh4KCak+HvsQWf1XNyN2pigQZ/PDpQ/3lK9a5GdwyA06/kJaThc9XiXtk+vN2OVGH
         Bneg==
X-Forwarded-Encrypted: i=1; AJvYcCXI29ws/7tRhby/wC8k9ObePSlNTl7FNZiAycRKcQLmDtM5CTNO9Aa1aJeZpoCpra5PiaSwWT+sa7u4SVH5vfVm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy51FhKEjZgyDCBFrODMSSZY+lZYgb4iUewlRGSd18hV/gN1Wy2
	TGIk9chrPDhEN2Rb0Ban/RoqbpcFdwLY58CZJsmTyHJRR5KFgajy+EJABQOcFHiRAgJ5tqlz0+h
	K/5NlZroJmAVxQpIiq7Pu2VuOZGme8KKzuMZlPEyY
X-Gm-Gg: AZuq6aLBTFHd0HEXpj8prMFcXI9Pt2J9toL6LuhxoBgeqhzNyxYx40m7xR0HH2Yx0Ql
	zTFe5g6lVChoOt5o5et9IXP1/x/X8s6JQmUBpcpZXxJgPDEmUUfZv9DtIiOyVrl47x1t5CtrmCb
	/oPsaWx4D1Ec7PwkYwNk09mU75g/FoRBvgSF3OO4XKeliRAoLub2sSCCMbs3wRTM1TA2G6+FqPS
	jckeXkU7HO/l1FPRkE27OF3t51B+Oiu7UNRKHf74Dd++iy5b42pXfHnHiEdAXJXiIszHt0uNN7l
	XqQ+DMplhBT8sS5xEm5buel4Umro4SEjUXTD
X-Received: by 2002:a17:903:384d:b0:2a7:6c4e:5924 with SMTP id
 d9443c01a7336-2a844e5b2d4mr2521265ad.12.1769445854175; Mon, 26 Jan 2026
 08:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126123514.3238425-1-wangyushan12@huawei.com> <20260126123514.3238425-6-wangyushan12@huawei.com>
In-Reply-To: <20260126123514.3238425-6-wangyushan12@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Jan 2026 08:44:01 -0800
X-Gm-Features: AZwV_QjpSdff-setUw1tB91cPILzxIvHf82sL-c45HvujlcAZIHtKG667DnWY6U
Message-ID: <CAP-5=fXJSPbZkSvcLMEM7rdaGqYJGzrh+8qmZodrWy=ZGVRp_Q@mail.gmail.com>
Subject: Re: [RFT PATCH 5/7] perf-iostat: Support wilder wildcard-match for pmus
To: Yushan Wang <wangyushan12@huawei.com>
Cc: mike.leach@linaro.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, peterz@infradead.org, 
	john.g.garry@oracle.com, Jonathan.Cameron@huawei.com, shiju.jose@huawei.com, 
	will@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, 
	liuyonglong@huawei.com, prime.zeng@hisilicon.com, fanghao11@huawei.com, 
	wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 4:35=E2=80=AFAM Yushan Wang <wangyushan12@huawei.co=
m> wrote:
>
> Current wildcard matching of pmu names only support the form of
> "<pmu_name>%d", which may not be sufficient for pmus with other forms of
> name (e.g. HiSilicon PCIe PMU has the name of "hisi_pcie%d_pmu%d").
>
> To address that, change the wildcard matching function into a callback,
> and add a new version of wildcard-matching function using the callback
> to support more flexible pmu names.

There's some discussion around PMU name matching here (and the replies):
https://lore.kernel.org/lkml/20251231224233.113839-12-zide.chen@intel.com/
that I think is relevant.

> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
> ---
>  tools/perf/util/pmus.c | 12 +++++++++---
>  tools/perf/util/pmus.h |  3 +++
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 98be2eb8f1f0..35184d477d07 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -402,7 +402,8 @@ struct perf_pmu *perf_pmus__scan_for_event(struct per=
f_pmu *pmu, const char *eve
>         return NULL;
>  }
>
> -struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu,=
 const char *wildcard)
> +struct perf_pmu *perf_pmus__scan_matching(struct perf_pmu *pmu, const ch=
ar *wildcard,
> +                                         perf_pmus_match_t match)
>  {
>         bool use_core_pmus =3D !pmu || pmu->is_core;
>
> @@ -436,19 +437,24 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(=
struct perf_pmu *pmu, const c
>         }
>         if (use_core_pmus) {
>                 list_for_each_entry_continue(pmu, &core_pmus, list) {
> -                       if (perf_pmu__wildcard_match(pmu, wildcard))
> +                       if (match(pmu, wildcard))
>                                 return pmu;
>                 }
>                 pmu =3D NULL;
>                 pmu =3D list_prepare_entry(pmu, &other_pmus, list);
>         }
>         list_for_each_entry_continue(pmu, &other_pmus, list) {
> -               if (perf_pmu__wildcard_match(pmu, wildcard))
> +               if (match(pmu, wildcard))
>                         return pmu;
>         }
>         return NULL;
>  }
>
> +struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu,=
 const char *wildcard)
> +{
> +       return perf_pmus__scan_matching(pmu, wildcard, perf_pmu__wildcard=
_match);
> +}
> +
>  static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu =
*pmu)
>  {
>         bool use_core_pmus =3D !pmu || pmu->is_core;
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 7cb36863711a..9308afb5a7b8 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -9,6 +9,8 @@ struct perf_event_attr;
>  struct perf_pmu;
>  struct print_callbacks;
>
> +typedef _Bool (*perf_pmus_match_t)(const struct perf_pmu *, const char *=
);

nit: can we use stdbool.h and make this return a bool?
nit: in general Linux style is to avoid typedefs:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#typedefs

Thanks,
Ian

> +
>  size_t pmu_name_len_no_suffix(const char *str);
>  /* Exposed for testing only. */
>  int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
> @@ -22,6 +24,7 @@ struct perf_pmu *perf_pmus__find_by_attr(const struct p=
erf_event_attr *attr);
>  struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
>  struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
>  struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const c=
har *event);
> +struct perf_pmu *perf_pmus__scan_matching(struct perf_pmu *pmu, const ch=
ar *wildcard, perf_pmus_match_t match);
>  struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu,=
 const char *wildcard);
>
>  const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
> --
> 2.33.0
>
