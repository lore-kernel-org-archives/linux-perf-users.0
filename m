Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66FAC04AA9
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Sep 2023 16:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbjITQCn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Sep 2023 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjITQCm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Sep 2023 12:02:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3855DDC
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 09:02:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41761e9181eso392831cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695225755; x=1695830555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hKvz7XvoFisXebVKsC7UUKF/hpZhzRWhPwp6F41w0w=;
        b=i9hONhm7zfnHV/aTzhGs4cQSXGMT2yUc7CjaGBaa6WKeeCP05+3V7isaAv6aJYaEkM
         YcArR8d8c3S26ZrCOgaN69Dv2lLdu+CfT5iqHbDrPhQBZZm9kB5McPVKGhwpjwRLIYmq
         tdc+0waZ7rUMVZg4xlQo2UDYKGeAmpJOQHHsW7+C8hOiEGwQ5BGwFMNEliprJzJn1Y0G
         LhJKf+yjNicp2acodGhD6Ks/C20jtrqSS7htOeQNtRJplpXMhl1ePqw+SywVDXuQFIfw
         /pnWsEVOBtF2UmKRKkoiqhQclzB1VQIs8B/1RUR8oexIp9XQJdEne1m1dq0PI4U8T1Gh
         VQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225755; x=1695830555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hKvz7XvoFisXebVKsC7UUKF/hpZhzRWhPwp6F41w0w=;
        b=WVYzqcvtxVH9vpb2iBy7+Id1pVi2Ww9x8A7AczgmDOux2EophyXRtsuorjhdpftMMy
         5dGkPmnziVexF8sE5XwOIG/ffarN81s3Ag2c3YpsiZcqSNk3ns1bw3Zz/JYPLKdAHsko
         jdWTsfbDYWyVirnPGpPMGvDRk38PKREZH97aIZV80B17Sf6nIU9BlyM96vU7sfdI5oSW
         wBRkovQMB3ge3+VkGl/oVKMjZlZxdqgXWTwGDEfhYbnHJ8y6fg2qNn/+SMMhmI/4TodI
         JOtiYUx19dDj2qq3zvx3gG8Av7pK9zSL5mN9nTXirTaInC8MKlHKORlGupjQ+ytgLls6
         63SQ==
X-Gm-Message-State: AOJu0Yw2nZ1n764X+j0Y9RZazBTbFbAD2sfg/NUsyj8bwUeHs3bCxQ5c
        M24w19gwUDoL9cTboTPjpvHAZmsHJpt2zaJLboFExw==
X-Google-Smtp-Source: AGHT+IEeygjqdTL+fm/PeEDoTS9pTf2SbY8SX+R5KBsEK7F7uoR1L27ypheY/jIq1T1yQsVEmEKNyXVQ5afJuA/vQ1E=
X-Received: by 2002:a05:622a:4e:b0:410:9d31:68cd with SMTP id
 y14-20020a05622a004e00b004109d3168cdmr226058qtw.27.1695225755151; Wed, 20 Sep
 2023 09:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230920122349.418673-1-wyes.karny@amd.com>
In-Reply-To: <20230920122349.418673-1-wyes.karny@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Sep 2023 09:02:23 -0700
Message-ID: <CAP-5=fUe-972h3+Cwegb6u8ZOxo2k_jHQ3i5gNPoUq_TR_AWDQ@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Fix perf stat output with correct scale and unit
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ravi.bangoria@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 20, 2023 at 5:24=E2=80=AFAM Wyes Karny <wyes.karny@amd.com> wro=
te:
>
> The perf_pmu__parse_* functions for the sysfs files of pmu event=E2=80=99=
s
> scale, unit, per-pkg and snapshot were updated in commit 7b723dbb96e8
> ("perf pmu: Be lazy about loading event info files from sysfs").
> However, the paths for these sysfs files were incorrect. This resulted
> in perf stat reporting values with wrong scaling and missing units. This
> is fixed by correcting the paths for these sysfs files.
>
> Before this fix:
>
>  $sudo perf stat -e power/energy-pkg/ -- sleep 2
>
>  Performance counter stats for 'system wide':
>
>    351,217,188,864      power/energy-pkg/
>
>           2.004127961 seconds time elapsed
>
> After this fix:
>
>  $sudo perf stat -e power/energy-pkg/ -- sleep 2
>
>  Performance counter stats for 'system wide':
>
>              80.58 Joules power/energy-pkg/
>
>              2.004009749 seconds time elapsed
>
> Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info files fr=
om sysfs")
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/pmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 0d81c059c91c..93feee29d054 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -295,7 +295,7 @@ static int perf_pmu__parse_scale(struct perf_pmu *pmu=
, struct perf_pmu_alias *al
>         len =3D perf_pmu__event_source_devices_scnprintf(path, sizeof(pat=
h));
>         if (!len)
>                 return 0;
> -       scnprintf(path + len, sizeof(path) - len, "%s/%s.scale", pmu->nam=
e, alias->name);
> +       scnprintf(path + len, sizeof(path) - len, "%s/events/%s.scale", p=
mu->name, alias->name);
>
>         fd =3D open(path, O_RDONLY);
>         if (fd =3D=3D -1)
> @@ -330,7 +330,7 @@ static int perf_pmu__parse_unit(struct perf_pmu *pmu,=
 struct perf_pmu_alias *ali
>         len =3D perf_pmu__event_source_devices_scnprintf(path, sizeof(pat=
h));
>         if (!len)
>                 return 0;
> -       scnprintf(path + len, sizeof(path) - len, "%s/%s.unit", pmu->name=
, alias->name);
> +       scnprintf(path + len, sizeof(path) - len, "%s/events/%s.unit", pm=
u->name, alias->name);
>
>         fd =3D open(path, O_RDONLY);
>         if (fd =3D=3D -1)
> @@ -364,7 +364,7 @@ perf_pmu__parse_per_pkg(struct perf_pmu *pmu, struct =
perf_pmu_alias *alias)
>         len =3D perf_pmu__event_source_devices_scnprintf(path, sizeof(pat=
h));
>         if (!len)
>                 return 0;
> -       scnprintf(path + len, sizeof(path) - len, "%s/%s.per-pkg", pmu->n=
ame, alias->name);
> +       scnprintf(path + len, sizeof(path) - len, "%s/events/%s.per-pkg",=
 pmu->name, alias->name);
>
>         fd =3D open(path, O_RDONLY);
>         if (fd =3D=3D -1)
> @@ -385,7 +385,7 @@ static int perf_pmu__parse_snapshot(struct perf_pmu *=
pmu, struct perf_pmu_alias
>         len =3D perf_pmu__event_source_devices_scnprintf(path, sizeof(pat=
h));
>         if (!len)
>                 return 0;
> -       scnprintf(path + len, sizeof(path) - len, "%s/%s.snapshot", pmu->=
name, alias->name);
> +       scnprintf(path + len, sizeof(path) - len, "%s/events/%s.snapshot"=
, pmu->name, alias->name);
>
>         fd =3D open(path, O_RDONLY);
>         if (fd =3D=3D -1)
> --
> 2.34.1
>
