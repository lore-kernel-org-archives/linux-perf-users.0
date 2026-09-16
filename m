Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56DE483BDD
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593785; cv=pass; b=SPK7dQVuJDvU6onWQxDPnJy3rDVKYHeMT4Cq/3EbBZ5jsRKp5juvAVecRiuRObbiN9X3hDphAaQVOIdpWGuD19DxMCLeGcUduugi6vGL5OeZzyAS2bnuAWRV2LbVq7yZzq1Lzb6Cm7qggs9MyJmrQ6Hys03Zz/ClyR2yyLQnmZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593785; c=relaxed/simple;
	bh=kJ3qjQeUA1hzBGsnetqxEJPJWR0Sb6vtf5Fuv2RNDYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoJ+wUfAkh0//Tm3YGtpaBOcEfV1LgX/Ln+kp/hUMgeYFFAoBIgBu1BDLd7f8Jtc2+GdzCeSf9ZwzK3Hiahfr53Cn19KUDuCYvlaFEPFa/ZeDHQMvg2NzMaBM09vUY8p6ICyMXifamkctlNGabaRZLcy6nfWsZtx2xzN3HdnCts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=orX4AZsA; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orX4AZsA"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso56181cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 14:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789593778; cv=none;
        d=google.com; s=arc-20260327;
        b=HcuF6iHv5iQa1FQUt4zeUq1vN0H4S90Ru8zrxUwSqjFcn2EunxNHQGpVc/VIznihyO
         jO7jjzDC0kzJPFguE4xVlWbWc8ce3/EavP2wEHqL2GmhCTKLrov+MtJIzqV9zzJEfL3x
         l0asyjbkTQvVG+vnHDedry646OHICYDlwifVqWGhIJlg0ixPW3v2TqYEzB0BI8Ln0SvJ
         /HZyex5QW3rxUrjfHqAaTjQTaNf4BHJiPQAzJBlPfiC3kxRfCo2qNdZtYYc4TL3gorQJ
         +lD/AwyBBjdh+O4afbiORuxr8Q6usoMbQ7zil+iKMQSxl8+CKjQCfbszDcva07YOUfKS
         KCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t+L4ATsOS/ltxA59iLXaFMH5JEUnlPoBgt9xqDRiJME=;
        fh=9XGb/FPLjfDpVyDPzBcxdWJBVzAcAnyYnCeEAAwOlGU=;
        b=jKXEkrP2MYIK5RyIupD0NemxboVluMSFRzdAxGmous4Ul3rhfnaJWcZBwrgMa5B1qT
         OYZg/TeQsjmlo3GbXxENCtL7fQnA6ChvkBfhQoa2Y6FS+/RxOqnfFXVHujim7rIbyoVY
         JaQUxhmIeS6ZlhPbdtewfPS8VA2LYgnl5S6csACNv15fkDyCPlDjkgqGs7/damGjHkU6
         V0OjZ4sAdoMXIq3NVO4esgCfp2brpNblTkqvRfYEPvOEM4+HTHDabExXoCfqKchSEec9
         RkanQfIyRe3ZAKy6IE1BaAxPNlwI2cf8L7pWuuBUSwTgxFARfxHWOyc70XULrmNgUVD5
         iFnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789593778; x=1790198578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t+L4ATsOS/ltxA59iLXaFMH5JEUnlPoBgt9xqDRiJME=;
        b=orX4AZsA+hBSN+ha2I0EXUhy11+LHD5FX06w8p5czBp2wx/sFUiAQu/0WOP7JWEmWb
         9nmtIjDZWA8GdwFmoeN8rZGl3AtD4n34MqEgmATKafNMaaMX1/IhZGQmdODJn1QPy3Ua
         +KWLUxDAWcwkKFrreiPBhfYbO6MGZoh1+zCpOQXSsDxxLZbZgDjlYFrv8omFVYR13IMD
         o+L6e/HA0nXm86TgkCMyAcMZBhZnxpZuJxkEEHZZ00GD+EooU1f6XM3vc1uphxeWaiVS
         m+vLnS4+DwoCtg1Ne+lVQJedMih8YZCHGRwd4OOb4yPX8vOcWClpy2yojsSs3judEl+K
         gopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593778; x=1790198578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t+L4ATsOS/ltxA59iLXaFMH5JEUnlPoBgt9xqDRiJME=;
        b=nNAECKmsYUTHACkVZFsTY03gNpN2s186k9WH6ds9agTBCkkjMlnCfVoM6oTgUfFyk5
         eC4myGnBo1F6tttvQM8IPhZ2a/KFq49JpRquONzVufBNNkpptYuNjJ8Snf+cROCIWr1t
         4pw1Wt+srC89ZFt2Or6Sy7YyF3vxXCSPwc45S3EFCvRytniAoWK5+Tb7HtTBQJ+WzxZj
         sKDDN1iP/TM17P+dRXktUzeUberNAyAIf1SbNohPrKC+zZC9vAIr5TTpy1uE2exYT6NQ
         qRVKf86eUEc0no+eM7pF1AcC38Cr2Rczri5jI9TZv4cXBvSLAtTj+4/0AFBJON9esc76
         DI5Q==
X-Forwarded-Encrypted: i=1; AKwUvBx90fFu8/SaL2F41HeXQUE8q4EQTlrhdyXXKyTH27yu2xRynQsGRbNp26JfQFklBp9vHHn5ocodJtpKOLxaDa8L@vger.kernel.org
X-Gm-Message-State: AFuF++nwK5AGKz2uRv2JqnV5zJOA2J9OZiWb4hwD6rtvy6Yzg7My0YlN
	+uCHDEW3MClcF/i+fozJKE+vIrq+7hvMvzbw0C0oGaAr/BWem+lsT/s30+mGAd8dYYZitmann0i
	Z6bfSJk3xVbISa9YwizJHLafmsrZMhTteOaLEcfUK0cQKTr/VRkQKMhqJPBE=
X-Gm-Gg: AYBFou3vbdy7FYygwZgpKZvupXj6OmnihsMpkcsK19b+bjBNFsWZiXXG+JWtGfgzizO
	iHUkiCZJt9nlXsbAiSgTXK13vHn0CJYA+9/aBQ5FbUoX8PrHzQkz0IVuUUrACcQQ0iR9Hl6wRU6
	CRrDaMbhuabNIFcNTr1kXzpkSmLdLKBbRHmvj5PAMFhq3iDiMKjrAcxvf65P6kGIZAiX2Ybe6Mh
	UMFGw9uB/+0iiyFeXQmm2EWwaxaW2q8fd89ZAkEAUYxTBC7C1ali6TkvKxWqfCAspDo5DJcfxRL
	2Ya8veGVXksw8hYvGTwK2bJZNxJ5nm6bHw2IXPokIPXcY+PZyyxGZMkyh0BKkj2DPjJ4nvZI5Gd
	pQgymkX8d3A==
X-Received: by 2002:ac8:7d41:0:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-5328f62cff6mr1774981cf.11.1789593777405; Wed, 16 Sep 2026
 14:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916202740.257376-1-zide.chen@intel.com>
In-Reply-To: <20260916202740.257376-1-zide.chen@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Sep 2026 14:22:45 -0700
X-Gm-Features: AcwNN1UpwmHpsRhkk0-wlxxNxRvn3k6gVDt4JwxuU3lXl21UiCshidAQlI2GmXo
Message-ID: <CAP-5=fV7mJEx27OQra2yaTegwRdzFUYohivFHFBvwD0cdb3=SQ@mail.gmail.com>
Subject: Re: [PATCH] perf topdown: Don't require config1==0 for a slots event
To: Zide Chen <zide.chen@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, thomas.falcon@intel.com, 
	dapeng1.mi@linux.intel.com, xudong.hao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 1:37=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> arch_is_topdown_slots() requires config1 =3D=3D 0, so it misidentified
> "cpu/slots,metrics_clear=3D1/" as not being the slots event, and an
> additional slots event gets inserted, which fails event scheduling
> since the group now needs two fixed counter 3.
>
>   $ perf stat -e "{cpu/slots,metrics_clear=3D1/,cpu/topdown-retiring/}" -=
- sleep 1
>   WARNING: events were regrouped to match PMUs
>        <not counted>      slots
>      <not supported>      cpu/slots,metrics_clear=3D1/
>        <not counted>      cpu/topdown-retiring/
>
> Drop the config1 =3D=3D 0 check from arch_is_topdown_slots(). This is
> safe: config1 has no bearing on the event's identifying config value
> (TOPDOWN_SLOTS, 0x0400).
>
> The attr.type =3D=3D PERF_TYPE_RAW check is what actually matters: only t=
he
> core PMU is registered with PERF_TYPE_RAW, and on x86, 0x400 is
> guaranteed to be slots event on core CPU.
>
> arch_is_topdown_metrics() keeps its own config1 =3D=3D 0 check, since
> genuine metrics events have no "metrics_clear" and config1 remains 0.
>
> Add a test verifying that an explicit "slots,metrics_clear=3D1" event in
> a group does not trigger an extra slots event injection.
>
> Fixes: 5b546de9cc17 ("perf topdown: Use attribute to see an event is a to=
pdown metic or slots")
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Note, there's a Sashiko warning about a potentially missing #include
for musl compatibility that maybe you or Arnaldo could address.

Thanks,
Ian

> ---
>  tools/perf/arch/x86/tests/topdown.c | 28 ++++++++++++++++++++++++++++
>  tools/perf/arch/x86/util/topdown.c  |  3 +--
>  2 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/te=
sts/topdown.c
> index 2b6f47ce4932..b1ce9f83db00 100644
> --- a/tools/perf/arch/x86/tests/topdown.c
> +++ b/tools/perf/arch/x86/tests/topdown.c
> @@ -229,10 +229,38 @@ static int test__x86_topdown_slots_injection(struct=
 test_suite *test __maybe_unu
>         return TEST_OK;
>  }
>
> +/*
> + * An explicit "slots,metrics_clear=3D1" event is still the slots event =
and
> + * must not cause an extra slots event to be injected into the group.
> + */
> +static int test__x86_topdown_metrics_clear(struct test_suite *test __may=
be_unused,
> +                                          int subtest __maybe_unused)
> +{
> +       struct perf_pmu *pmu;
> +       char event_str[128];
> +       int ret;
> +
> +       if (!topdown_sys_has_perf_metrics())
> +               return TEST_OK;
> +
> +       pmu =3D perf_pmus__find_by_type(PERF_TYPE_RAW);
> +       if (!pmu || !perf_pmu__has_format(pmu, "metrics_clear"))
> +               return TEST_OK;
> +
> +       snprintf(event_str, sizeof(event_str),
> +                "{%s/slots,metrics_clear=3D1/,%s/topdown-retiring/}",
> +                pmu->name, pmu->name);
> +       ret =3D test_sort(event_str, 2, 1);
> +       TEST_ASSERT_EQUAL("explicit metrics_clear slots event isn't dupli=
cated", ret, TEST_OK);
> +
> +       return TEST_OK;
> +}
> +
>  static struct test_case x86_topdown_tests[] =3D {
>         TEST_CASE("topdown events", x86_topdown),
>         TEST_CASE("topdown sorting", x86_topdown_sorting),
>         TEST_CASE("topdown slots injection", x86_topdown_slots_injection)=
,
> +       TEST_CASE("topdown metrics_clear no extra slots", x86_topdown_met=
rics_clear),
>         { .name =3D NULL, }
>  };
>
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/uti=
l/topdown.c
> index bafd285119d7..64bc64e335a2 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -37,8 +37,7 @@ bool topdown_sys_has_perf_metrics(void)
>  bool arch_is_topdown_slots(const struct evsel *evsel)
>  {
>         return evsel->core.attr.type =3D=3D PERF_TYPE_RAW &&
> -              evsel->core.attr.config =3D=3D TOPDOWN_SLOTS &&
> -              evsel->core.attr.config1 =3D=3D 0;
> +              evsel->core.attr.config =3D=3D TOPDOWN_SLOTS;
>  }
>
>  bool arch_is_topdown_metrics(const struct evsel *evsel)
> --
> 2.55.0
>
