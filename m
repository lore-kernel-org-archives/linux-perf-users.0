Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8E25DB1A
	for <linux-perf-users@vger.kernel.org>; Tue,  5 May 2026 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016265; cv=pass; b=VSzkNs3dOVwH+p8YL6rKgyFIvImp+PdIVVgFTv5HVqJJqxJR2AGQHrn6Tsg8WPVJ7Se3aEr6sik3Shh+w6Byf/9O4Rb+kBkloPfS2abBeHk6grKg5O9Jl8C8HOFekfJXdUwVVc+b5MhxzT44LdBebu4dgBzdSDCV8UKake4KjUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016265; c=relaxed/simple;
	bh=qwrevQuKW7SU82cOtABfTLrl2B9eclHLAka9VuSvJ1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loBWVZjs0BqhTb/yoBKVTmwSax0DVMyLMUE7RjnL5Zwtq3v9GoV6/3QDptMmwGr60ARVgOB6ztMpBjy0KcWvcbNTJ0pJM+Ku6LN00CQLtvJsxKD3U821jHn92n1OVmq2fUuPckZgg9zCq7uXy7thXg5jZ8adNVbKTHt6sWa2IWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+16yXQa; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+16yXQa"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so13355ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 14:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778016264; cv=none;
        d=google.com; s=arc-20240605;
        b=ch1VUG/3+ZeS11VPWl6J1rkRKlAoYh8peokIgNvg5MBHvZP1K52WbD4FtsLPL5/Dsz
         EDWPY1V5srHPrsFL1EzJOO5+2wKopcz4wmUHp1m0ibRK4eNhN79AS1KKL2PQkhzCHN/d
         NWRKX3mexD3dT90ETAXsyx2giS9h9pbV/jlZBSSUYBFECEmaWM0TNASSiyClQL2RL7X2
         ljVCaMbmpTwvdC6mvFv1bW4XjS38pMOGoD3YMWraSmPhdYhSbuNSL9J8xqlVVWPTzxvT
         ELjkqQZ8IGoyvL3F5CIJjgN3C2B80pjN3+Lq7IVit5sW9cUU+igsilrJF8jr/zv7JM1J
         6yZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LX5hmYdSGq+Tl89zMS1RsgzIQfBbZy0yGuyvPD6gODU=;
        fh=WFkPsRDpuMZHyURrhwDBmEpbvhUrMXDUBI0QfMqAfv0=;
        b=Z6U3ZTBsyN1VUwgXRx7HZQCvJmP+KqvLunedVfNKRl28O7oo+TQeycuiWuDbHKHOpG
         gcF5O4ZK6QOcnY751n1ZWyZ1xvAnPp0iBEvhR4WH0E4QYN3jos1K4gWB2QbbLB2mPrN7
         QlgtR+tpFQKeA11LMi455CJNRH8J5HBG6IuG0VJR6b3kkXyWRJVzGMuwEUN6nb7567Zi
         XgdnyKE1ufTJuLFnZz6Fpst7uWi4HRMzbGsZeT5zeyvTvBxxcW2V+diXLFQCyvj0bL4x
         J0M7OUx+PYKi2rX8AKFSoQWOKFVZPtnXkJEFCaE5e44Ah+rFBFTORk6MdCtREmHRqQdL
         nPnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016264; x=1778621064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX5hmYdSGq+Tl89zMS1RsgzIQfBbZy0yGuyvPD6gODU=;
        b=S+16yXQagvGzex40EZnSYzll3XtKPoNcioRMF8IveStVylcLQvcJjqGD7exE2N4oXT
         CndI4luYyQtaDPlI3eP1DLuAJkLqE17XKfMl7nsRDujDkaIvr7hNbeqLCEXEct/zR8NF
         c0CoZO9A8eb9tMay2p5XEIogOGsdIx3yObKst8boFUmvS94xejTD+DDnTj4mjPmPETk8
         nljLOAzWbwPzdvzgpJC6wLkl/34X5FLpIO6MBxJjEvHHWPYVXS8eS+8SggWiQJvScgrX
         QL8gqnw1nVE3Whfj9/hQJmAZ8D/6XgUDu8OHta8/MkhVaEf/dcCs+mXMvjbxjR8MwQN3
         Lluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016264; x=1778621064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LX5hmYdSGq+Tl89zMS1RsgzIQfBbZy0yGuyvPD6gODU=;
        b=U7LL5mNm2tqFCTjuEWwTJXz+eKaXFBfPfjHYsnBgTNsKBMWVgoHbnTV3Wv3Kb6J5hi
         plf0uExli2chq8jK/+9w+aLS2zKa1MVrTLegEQXq2d1UJeDzdHSE/H/wW4WQ2JoupQkW
         Wl15bQcGAPZkmelegaeZ3TqgspzW+X1q/U4tg3HhAKhIjjDitZjbU8zqTtXKuIuyq+tC
         OFn6J+w0nL5C7BqYdVKP/ck1yvYOddIxegjyxn4Ft8atPTPnMQG0k1kzb1n8h0srGFBt
         b4cHxRpi9yrA2E7Ku5uFuinEqmvSrXUGA88sJbVodsvwu5qegV3RkyDJSsWqUj//kOz+
         JQbg==
X-Forwarded-Encrypted: i=1; AFNElJ+e+WzvRj5zKIU4hOlJmWpeV1sqremHHD7QSkug7LZ2PRBas/6ds2ip0YXtcIZaLEGmsm7xB7zOWbhzvIrE5dx3@vger.kernel.org
X-Gm-Message-State: AOJu0YxOo5mWbvRkAAwkxkW8uUZbqZMXYViUBaomnrT2f6HxZvtSpFsv
	k/PSaGHCjfBeXc7HiBR67mpfaelInn0o3BXSV0t+zin1yI7xf8v3C9nji9RXOXCj4j225KtZFj5
	SC5B+1oOfCp5eu1skAvoiFaol1l9o1F/+y/PVGDte
X-Gm-Gg: AeBDies1EMA6ELRNHVUxU/62WX4mp/VVpY1t29cBgtHc3EBHKJOyz/zCp/BrMnooUGY
	wVeB/kLYbSXu12kE772P0L8T8hgMW2hDDj31UBkJGF3Oln6COYZBtnZCikR0IZrt4TWmaBAHy54
	TQOY+XiFC8/o2m3VvKcN8ro928p+8N4mb3+6LOicaZqtoHXqsut6/snzPbZv/7ON/q/Jdr+EExc
	sYttWt4nHzLtDNfnkhJNmrn058wRs8kdiXloN5ohE2lMqmqnvdHF2IfpksYIxsj24Xa0UP903+E
	oO+AILJ6QTterb/JCeY+fnU8hU2UKw==
X-Received: by 2002:a17:903:1b48:b0:2b4:641a:6b7c with SMTP id
 d9443c01a7336-2ba7cef9053mr368105ad.13.1778016263248; Tue, 05 May 2026
 14:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acyWR2GAWIY7TKyD@google.com> <20260430161725.3131665-1-irogers@google.com>
In-Reply-To: <20260430161725.3131665-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 May 2026 14:24:11 -0700
X-Gm-Features: AVHnY4KT74T-6jD_3Vt4mmwC7DOrPEUJ8X1JHf5fGBNz3Y8EJ0nJcXa98IisLQM
Message-ID: <CAP-5=fU8H=aApHk8vS-scEKXR9t=oSiJ19UiiOr_M27MtCyv1w@mail.gmail.com>
Subject: Re: [PATCH v2] perf metricgroup: Avoid scanning unnecessary PMUs for
 identifier match
To: namhyung@kernel.org, acme@kernel.org, james.clark@linaro.org
Cc: adrian.hunter@intel.com, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:17=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Only uncore PMUs can have an identifier, so add an optimized
> perf_pmus__scan routine for that case to avoid all PMU types being
> created.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

This passes Sashiko review (green). I didn't copy James Clark's
reviewed-by tag given the metricgroup code rewrite to avoid the loop,
but I think this is ready to land.

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 11 +++--------
>  tools/perf/util/pmus.c        | 18 +++++++++++++++++-
>  tools/perf/util/pmus.h        |  1 +
>  3 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 4db9578efd81..5a489e97c413 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -415,14 +415,9 @@ static int metricgroup__sys_event_iter(const struct =
pmu_metric *pm,
>         if (!pm->metric_expr || !pm->compat)
>                 return 0;
>
> -       while ((pmu =3D perf_pmus__scan(pmu))) {
> -
> -               if (!pmu->id || !pmu_uncore_identifier_match(pm->compat, =
pmu->id))
> -                       continue;
> -
> -               return d->fn(pm, table, d->data);
> -       }
> -       return 0;
> +       /* Only process with the iterator if there is a a PMU that matche=
s the ID. */
> +       pmu =3D perf_pmus__scan_for_uncore_id(pmu, pm->compat);
> +       return pmu ? d->fn(pm, table, d->data) : 0;
>  }
>
>  int metricgroup__for_each_metric(const struct pmu_metrics_table *table, =
pmu_metric_iter_fn fn,
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 9a2023ceeefd..5e3f571450fe 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -409,7 +409,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(st=
ruct perf_pmu *pmu, const c
>         if (!pmu) {
>                 /*
>                  * Core PMUs, other sysfs PMUs and tool PMU can have any =
name or
> -                * aren't wother optimizing for.
> +                * aren't worth optimizing for.
>                  */
>                 unsigned int to_read_pmus =3D  PERF_TOOL_PMU_TYPE_PE_CORE=
_MASK |
>                         PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
> @@ -486,6 +486,22 @@ static struct perf_pmu *perf_pmus__scan_skip_duplica=
tes(struct perf_pmu *pmu)
>         return NULL;
>  }
>
> +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, con=
st char *compat)
> +{
> +       if (!pmu) {
> +               /* Only uncore PMUs can have identifiers. */
> +               unsigned int to_read_pmus =3D PERF_TOOL_PMU_TYPE_PE_OTHER=
_MASK;
> +
> +               pmu_read_sysfs(to_read_pmus);
> +               pmu =3D list_prepare_entry(pmu, &other_pmus, list);
> +       }
> +       list_for_each_entry_continue(pmu, &other_pmus, list) {
> +               if (pmu->id && pmu_uncore_identifier_match(compat, pmu->i=
d))
> +                       return pmu;
> +       }
> +       return NULL;
> +}
> +
>  const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
>  {
>         struct perf_pmu *pmu =3D NULL;
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 7cb36863711a..0d55edb3f2fc 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -23,6 +23,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
>  struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
>  struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const c=
har *event);
>  struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu,=
 const char *wildcard);
> +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, con=
st char *compat);
>
>  const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
>
> --
> 2.54.0.545.g6539524ca2-goog
>
