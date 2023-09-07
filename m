Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2AFEC8759
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Sep 2023 22:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjIGWjc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIGWjc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Sep 2023 18:39:32 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848ED1BC8
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 15:39:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-414ba610766so134531cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Sep 2023 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694126367; x=1694731167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dtv9dzYwGEPUB4ovcR5uml8jqsakIWZEfBU7crt0IY4=;
        b=Z1EHCtOyVbV/zm0nVFqjDrvTeX55SPfB3LC3qnCA7Zd3JEIiJ0dJ+tswVzQ0DNRIfK
         7tSLXTnxEgy1sQ57XEVzQYxpWIuZzi3eBVYmbh0Y28E0ZEfepnlz0/bKdqzkyAI5J/hj
         1bog0v5jgLQs0FXWl6MkC3jjUkbOSGAFklCYh/ISRBMA16Dw8UPDj8RCULhaOEyK1OEg
         r8RvcW163vTec2AJ884/S/U8zSiWGuTYCV4g63d2cKAEZhKzM6/7GLZ5Be6v/KYcqPWW
         XR2NryuNOt0Wh9bldZu7jo53gdw6J5agknlKt6mPMLhuRCngVzYxMw90x/Bc/ulbH/AE
         9LpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694126367; x=1694731167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dtv9dzYwGEPUB4ovcR5uml8jqsakIWZEfBU7crt0IY4=;
        b=s9S2CwdT1N9pSjB5Z61a5J/TTLbZ9Y2KsHWiFcFSF/W4MDejSITIu6ChMG25HO2vqa
         /ZhWdQXNQfFfMKkRmjPHCeAW/1p2wqYeWQOTN8sMPj+IHtysTjboOGdJ1K+g6R/mxy0e
         x9Gj6+UkFIZ9dXWEDIkNg/Z0a3695gN/6N9gXWwWLWr0QDEYAr/NNR1STPE+AZwHlWS1
         Q1mSjPwnhcwuNJT4GQoCp/2PGwOkK4SSIWrgcDOaFBfX2re3Gn7dR8Zwb+QzMJaRRs4K
         jCpfk3waLYOVe9Sb39saz25vvgx7oxwbnP5gA6YWQ5S12Ov0oZUn60pM1WyiX2f1VXbA
         0oyw==
X-Gm-Message-State: AOJu0Yy43EOk5qcTkHPiWeupLb6mFC1tEGmEjAeM8cmBccJIYbG0R4te
        viANQISCccxR2fjcfrLB4O0uKYi73UN1FMwOmltgo4/hp07dysbGuNc=
X-Google-Smtp-Source: AGHT+IGQCD1giz7x0vXxyulVzIfgMyyDNVYuSRfcPv4V5rsD/6b5z1c5uLMx47n6lrTIWQv08u8mDgMuYMUI5XEJWp8=
X-Received: by 2002:ac8:5793:0:b0:410:9d31:68cd with SMTP id
 v19-20020ac85793000000b004109d3168cdmr39978qta.27.1694126367519; Thu, 07 Sep
 2023 15:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230907165933.36442-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230907165933.36442-1-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 Sep 2023 15:39:15 -0700
Message-ID: <CAP-5=fWTSSH2vgxK7LM23mK-PbsOoZc+ZNq_8dL1X=dYMKemfA@mail.gmail.com>
Subject: Re: [PATCH V2] perf test: Fix parse-events tests to skip parametrized events
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 7, 2023 at 9:59=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Testcase "Parsing of all PMU events from sysfs" parse events for
> all PMUs, and not just cpu. In case of powerpc, the PowerVM
> environment supports events from hv_24x7 and hv_gpci PMU which
> is of example format like below:
>
> - hv_24x7/CPM_ADJUNCT_INST,domain=3D?,core=3D?/
> - hv_gpci/event,partition_id=3D?/
>
> The value for "?" needs to be filled in depending on system
> configuration. It is better to skip these parametrized events
> in this test as it is done in:
> 'commit b50d691e50e6 ("perf test: Fix "all PMU test" to skip
> parametrized events")' which handled a simialr instance with
> "all PMU test".
>
> Fix parse-events test to skip parametrized events since
> it needs proper setup of the parameters.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changelog:
> v1 -> v2:
>  Addressed review comments from Ian. Updated size of
>  pmu event name variable and changed bool name which is
>  used to skip the test.
>
>  tools/perf/tests/parse-events.c | 38 +++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index 658fb9599d95..1ecaeceb69f8 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2514,9 +2514,14 @@ static int test__pmu_events(struct test_suite *tes=
t __maybe_unused, int subtest
>         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
>                 struct stat st;
>                 char path[PATH_MAX];
> +               char pmu_event[PATH_MAX];
> +               char *buf =3D NULL;
> +               FILE *file;
>                 struct dirent *ent;
> +               size_t len =3D 0;
>                 DIR *dir;
>                 int err;
> +               int n;
>
>                 snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/=
events/",
>                         sysfs__mountpoint(), pmu->name);
> @@ -2538,11 +2543,44 @@ static int test__pmu_events(struct test_suite *te=
st __maybe_unused, int subtest
>                         struct evlist_test e =3D { .name =3D NULL, };
>                         char name[2 * NAME_MAX + 1 + 12 + 3];
>                         int test_ret;
> +                       bool is_event_parameterized =3D 0;
>
>                         /* Names containing . are special and cannot be u=
sed directly */
>                         if (strchr(ent->d_name, '.'))
>                                 continue;
>
> +                       /* exclude parametrized ones (name contains '?') =
*/
> +                       n =3D snprintf(pmu_event, sizeof(pmu_event), "%s%=
s", path, ent->d_name);
> +                       if (n >=3D PATH_MAX) {
> +                               pr_err("pmu event name crossed PATH_MAX(%=
d) size\n", PATH_MAX);
> +                               continue;
> +                       }
> +
> +                       file =3D fopen(pmu_event, "r");
> +                       if (!file) {
> +                               pr_debug("can't open pmu event file for '=
%s'\n", ent->d_name);
> +                               ret =3D combine_test_results(ret, TEST_FA=
IL);
> +                               continue;
> +                       }
> +
> +                       if (getline(&buf, &len, file) < 0) {
> +                               pr_debug(" pmu event: %s is a null event\=
n", ent->d_name);
> +                               ret =3D combine_test_results(ret, TEST_FA=
IL);
> +                               continue;
> +                       }
> +
> +                       if (strchr(buf, '?'))
> +                               is_event_parameterized =3D 1;
> +
> +                       free(buf);
> +                       buf =3D NULL;
> +                       fclose(file);
> +
> +                       if (is_event_parameterized =3D=3D 1) {
> +                               pr_debug("skipping parametrized PMU event=
: %s which contains ?\n", pmu_event);
> +                               continue;
> +                       }
> +
>                         snprintf(name, sizeof(name), "%s/event=3D%s/u", p=
mu->name, ent->d_name);
>
>                         e.name  =3D name;
> --
> 2.31.1
>
