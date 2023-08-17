Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CE6C41513
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Aug 2023 03:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347850AbjHQDbX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Aug 2023 23:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347854AbjHQDbO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Aug 2023 23:31:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A332684
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Aug 2023 20:31:12 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40c72caec5cso179981cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Aug 2023 20:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692243072; x=1692847872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OZBeaJgZy+JtC76XaUX/QbDCUYKDpGHJgNlTIZgiv0=;
        b=uihlZtlBlwbqRXrGgDB1cx3+tvFPoMptKF8xwFjYExbafSk6aawa6UDjyuuwD1NCMo
         HmgeMUS4wDBpAmFqrT/tgWkUKwKndxmFzpDFO72Kas+XUk3o4IEQRmPYMwAmJYYE9Xsq
         FQBC9dTf66m/hiST75GBrjP2qOP5ZNWatP0sMvW05t3LeGtTA6fnSHCB479i41DZg6sK
         Dm0hxC7EtcRVLxDNpAvoWrIIv389qZiIWn6/GYOP0GA1ONg9UEKyACo+8oKSUttkcz+k
         uzKWUBEkfO7Lg8P0EhcHtF6jpWDwhlkLDtrRoKTxbsq1KYi4uaXqpCdtXtR2zcQfA3Rv
         2YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692243072; x=1692847872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OZBeaJgZy+JtC76XaUX/QbDCUYKDpGHJgNlTIZgiv0=;
        b=UHw6Fq4eELnH9GCTO9fQCf7Fv1gAaR8Bl73cuDm1W52tq9RgI7icJF6MgLt6xZyR/k
         pEHwEp5Av9VyoOVmlHDJ7So8KpYOMjeawzYJIFfaqccKYn4PB8KFlp2U2XM7F0iD19YI
         9jodKDdRfJmXGWo51iXGn/s2JtsSzP5ibMRQ0He6UFoyuTMKFr2EkzAiy/yZAl9p43rr
         TnY/eTTCb9tXkn5OjSR0j4USV2VYBwrE7W9/A3+oflu6fR6WxcfWTU4G8bq/TpKI16XJ
         W22OsbSJUeHE/mXeKfdYPQ9DlZ5So3n0DrgqUreEYHRMECkcZKsQ4zz/gHvT5pMDfwcD
         eMKQ==
X-Gm-Message-State: AOJu0YzWYt3Ufr8c2dSpVK1tEJiPNWkj4GDKfmH8o5emxKJQe3ZS8KIV
        dEnLSckKXKjaOisz+H9AOl0GK6qYGuUS+QYonnmwrg==
X-Google-Smtp-Source: AGHT+IF5LHZK0NKxj/bs+fsND7QceZAiQkVA/xe91rJU9IS7u1PLQAPJLP27KZA6Rrgn2WZrntOL54K3FjA5+B5x12U=
X-Received: by 2002:ac8:5bc9:0:b0:40f:d387:65d0 with SMTP id
 b9-20020ac85bc9000000b0040fd38765d0mr162112qtb.16.1692243071597; Wed, 16 Aug
 2023 20:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230815130722.1223744-1-liwei391@huawei.com>
In-Reply-To: <20230815130722.1223744-1-liwei391@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Aug 2023 20:31:00 -0700
Message-ID: <CAP-5=fX2v=vV8eUX3x2i+vcYQQ=W9_tswh4VXy4nP9R3MPh=2Q@mail.gmail.com>
Subject: Re: [PATCH] perf header: Fix missing PMU caps recording in write_pmu_caps
To:     Wei Li <liwei391@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-perf-users@vger.kernel.org, huawei.libin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 15, 2023 at 6:10=E2=80=AFAM Wei Li <liwei391@huawei.com> wrote:
>
> An error occurred when executing "perf script syscall-counts" on arm64:
>     Press control+C to stop and show the summary
>     0x6a7c [0x14]: failed to process type: 80
>
> After debugging i found that it failed to process HEADER_PMU_CAPS, lookin=
g
> back on write_pmu_caps(), it get all pmus with caps except "cpu" first,
> then handle the hybrid core pmus, and the uncore pmus finally.
>
> But on arm64 platforms, the core pmu is named "armv8_pmuv3" etc, not "cpu=
".
> So it's counted but no caps recorded here, this is broken since commit
> 178ddf3bad98 ("perf header: Avoid hybrid PMU list in write_pmu_caps"),
> as the logic for determining hybrid is changed from name matching to "cor=
e"
> attribute judging.
>
> To fix this, change the logic of recording pmu caps to be consistent with
> the preceding counting, also make the code clear. The compatibility with
> old perf tool is ignored since it has been already broken.
>
> Fixes: 178ddf3bad98 ("perf header: Avoid hybrid PMU list in write_pmu_cap=
s")
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/util/header.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 52fbf526fe74..7d2bd1fb8ef2 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1618,22 +1618,10 @@ static int write_pmu_caps(struct feat_fd *ff,
>         if (!nr_pmu)
>                 return 0;
>
> -       /*
> -        * Write hybrid pmu caps first to maintain compatibility with
> -        * older perf tool.
> -        */
> -       if (perf_pmus__num_core_pmus() > 1) {
> -               pmu =3D NULL;
> -               while ((pmu =3D perf_pmus__scan_core(pmu))) {
> -                       ret =3D __write_pmu_caps(ff, pmu, true);
> -                       if (ret < 0)
> -                               return ret;
> -               }
> -       }
> -
>         pmu =3D NULL;
>         while ((pmu =3D perf_pmus__scan(pmu))) {
> -               if (pmu->is_core || !pmu->nr_caps)
> +               if (!pmu->name || !strcmp(pmu->name, "cpu") ||
> +                   !pmu->nr_caps)
>                         continue;
>
>                 ret =3D __write_pmu_caps(ff, pmu, true);

Sorry for the breakage. I think all of the branches are interfering
here, I think a simpler solution is:

```
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1605,8 +1605,7 @@ static int write_pmu_caps(struct feat_fd *ff,
       int ret;

       while ((pmu =3D perf_pmus__scan(pmu))) {
-               if (!pmu->name || !strcmp(pmu->name, "cpu") ||
-                   perf_pmu__caps_parse(pmu) <=3D 0)
+               if (perf_pmu__caps_parse(pmu) <=3D 0)
                       continue;
               nr_pmu++;
       }
@@ -1619,23 +1618,13 @@ static int write_pmu_caps(struct feat_fd *ff,
               return 0;

       /*
-        * Write hybrid pmu caps first to maintain compatibility with
-        * older perf tool.
+        * Note older perf tools assume core PMUs come first, this is a pro=
perty
+        * of perf_pmus__scan.
        */
-       if (perf_pmus__num_core_pmus() > 1) {
-               pmu =3D NULL;
-               while ((pmu =3D perf_pmus__scan_core(pmu))) {
-                       ret =3D __write_pmu_caps(ff, pmu, true);
-                       if (ret < 0)
-                               return ret;
-               }
-       }
-
       pmu =3D NULL;
       while ((pmu =3D perf_pmus__scan(pmu))) {
-               if (pmu->is_core || !pmu->nr_caps)
+               if (perf_pmu__caps_parse(pmu) <=3D 0)
                       continue;
-
               ret =3D __write_pmu_caps(ff, pmu, true);
               if (ret < 0)
                       return ret;
```

Could you try it out?

Thanks,
Ian

> --
> 2.25.1
>
