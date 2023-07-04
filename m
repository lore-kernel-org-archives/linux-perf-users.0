Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08240EB64D9
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Jul 2023 17:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjGDRKQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Jul 2023 13:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjGDRKP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Jul 2023 13:10:15 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B24F3
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jul 2023 10:10:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40371070eb7so187351cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jul 2023 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688490613; x=1691082613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZZgqpZksNE4Bs7ESika3g3oCcyL0AnOsQIxWBGrP+0=;
        b=zQ/68cLNfPdOGpe9SfTvHbkdFrMSA22+m5WYbQSD4UJ396k8NtDDr3p7dkm5OaBMbf
         vc4kMghM/N5SlP7sO4z4zF7EDp9o+xCZJoMuUeCaXMCz8iASw+gtB6v/9R8a+tg0VDJe
         nFRkzbUjJtxHv3kfROEpDETG7FclmO0h9XoaAKEX3+kyW2GCuRhwFS+tEiGChU0MYeCW
         av8boMsnCIgsl8kTsBkn2k30TmNNUX687sp0XMAyrrFJb+QsLGoegNP9vjxYg+BnPqq/
         6o5j+ZxWwd3PlnSTmqBc7svsM1D3w6QRHmCqljSHW6bB2FSr+6CiBZRSOqbDMv5BBTa2
         hB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688490613; x=1691082613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZZgqpZksNE4Bs7ESika3g3oCcyL0AnOsQIxWBGrP+0=;
        b=hmvqmd5g9CKxTLnUANTjwoAZKumZpTr04qQKWhJGANF0hjcko8/SHUwi5g6B7rA3CK
         UqWpemikvzQe/p0SRlM9W0k2EG6AVdizE7eKp1YXomENifgmEGxViDJuFj3Rl9YY5tNR
         LoyDlpUGdpZMc1uavgtRB9UQ/1kkT5DkzcDgg2F1JyS02HSQWbVenHJglRZg8YAKaVhF
         jDB2a6Hdxs+WuLKEvAwIKJK12HIx6lq1d9Ol0fqhSeFTv8yGw4oJDDIzZFHnXEztpUTk
         MLHeGjdU7lXDaoQ4HNhtEeC0j7Bnnhl1z/eBZvC5U+TCouyI5DIDxHycgDD7VNxkgjUf
         09RA==
X-Gm-Message-State: ABy/qLabcBTnOzqcMpd6VyPO3+vKqXzq6CyO0TvEspNVpDYVdWLmpCYp
        efHQ9igRKpmi/tSsXg8IzsxMlyIBHNyPu3k1AYQupQ==
X-Google-Smtp-Source: APBJJlHJA+4pTMG1uz+RTYxp+HZbAYvFg0JaBtspOYxwocYh1zKXNaeOd2PnhLiIBAFvvMDERZWZCt7kveNONa4s+x8=
X-Received: by 2002:ac8:5908:0:b0:3f8:3065:7fc5 with SMTP id
 8-20020ac85908000000b003f830657fc5mr126181qty.1.1688490612831; Tue, 04 Jul
 2023 10:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230704143628.1177124-1-james.clark@arm.com>
In-Reply-To: <20230704143628.1177124-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 Jul 2023 10:10:00 -0700
Message-ID: <CAP-5=fVzFsgh6PC2EPJi8XpwTpdoSqqNnLgM-AYeHLzCWiQwZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf test: Fix event parsing test on Arm
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 4, 2023 at 7:38=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> The test looks for a PMU from sysfs with type =3D PERF_TYPE_RAW when
> opening a raw event. Arm doesn't have a real raw PMU, only core PMUs
> with unique types other than raw.
>
> Instead of looking for a matching PMU, just test that the event type
> was parsed as raw and skip the PMU search on Arm. The raw event type
> test should also apply to all platforms so add it outside of the ifdef.
>
> Fixes: aefde50a446b ("perf test: Fix parse-events tests for >1 core PMU")
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/parse-events.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index 133218e51ab4..21f79aa31233 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -108,10 +108,21 @@ static int test__checkevent_raw(struct evlist *evli=
st)
>         TEST_ASSERT_VAL("wrong number of entries", 0 !=3D evlist->core.nr=
_entries);
>
>         perf_evlist__for_each_evsel(&evlist->core, evsel) {
> -               struct perf_pmu *pmu =3D NULL;
> +               struct perf_pmu *pmu __maybe_unused =3D NULL;
>                 bool type_matched =3D false;
>
>                 TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0=
x1a));
> +               TEST_ASSERT_VAL("event not parsed as raw type",
> +                               evsel->attr.type =3D=3D PERF_TYPE_RAW);
> +#if defined(__aarch64__)
> +               /*
> +                * Arm doesn't have a real raw type PMU in sysfs, so raw =
events
> +                * would never match any PMU. However, RAW events on Arm =
will
> +                * always successfully open on the first available core P=
MU
> +                * so no need to test for a matching type here.
> +                */
> +               type_matched =3D raw_type_match =3D true;
> +#else
>                 while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
>                         if (pmu->type =3D=3D evsel->attr.type) {
>                                 TEST_ASSERT_VAL("PMU type expected once",=
 !type_matched);
> @@ -120,6 +131,7 @@ static int test__checkevent_raw(struct evlist *evlist=
)
>                                         raw_type_match =3D true;
>                         }
>                 }
> +#endif
>                 TEST_ASSERT_VAL("No PMU found for type", type_matched);
>         }
>         TEST_ASSERT_VAL("Raw PMU not matched", raw_type_match);
> --
> 2.34.1
>
