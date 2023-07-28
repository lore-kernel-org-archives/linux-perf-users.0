Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADB3C0015E
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 17:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjG1R5s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjG1R5q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 13:57:46 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A0D3C2A
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 10:57:39 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-348c7075afcso7055ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690567058; x=1691171858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxwJTgPqKGUqvUto5dRinQkbqBd7YM2MzlMxp9fWT8E=;
        b=hQjJ1RLhJPauIywvr88WuY2ABYjB2prVNewvEwx+Ocd9iSB0qKWcCl2chTkt7owPHk
         NwK1CRy9qGSPfS6cD1UYHjSR8fesIFv9I0Wd8aClgqqxYPlLXoqaYgEV8kVCIp4ecKgy
         cu7SXnAM12xOR3BfkE6HRFPNdQzYfT5Ou6FJ3h8QqbAqcWzGk8SFvuKtMFGQTKyyeBma
         F6RJuEPDUoITfFKh45bWuULRzL0DaBvkA0SpKtIq1WnQkYKvjBelp7tA2+xQxMt53ozp
         GWWmzWCFAOH+p9xcFIeaU6MJ462VS89dfPCEEZlmfMv0glqmjj538X5HW0+YErboLJov
         /R7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567058; x=1691171858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxwJTgPqKGUqvUto5dRinQkbqBd7YM2MzlMxp9fWT8E=;
        b=gxp5MkX05U0G2Zfktyx7vbecaC3r7Hk2mNzPO7VmoiecOuPpzWiNaESQ60PdihRkr5
         ooRGicPZQ5Qspe4A+g/fDuDamY/KDmtNDpFvzLHdbjX1n4rPYCP2qNBAgsPV3Y3x97bW
         XTvo2B5Rynti4oMDBJzqFw75i92A5sD0xtNXfgoAriy6DfNTa2yUwBLyczGcCRFFJZJq
         g6y9Aa6wQkxYcO9XYR+8uQrk+PaB8FnWNWyick32HKS48w6EMV78HgRio0LprEQiErba
         NsMIO3KTRHM6QkRxHwIlk5cFZ97vftOORCq/OhiWbuvJ9CfvR9xJnyCmdTUfBVD4Ehbi
         F/FQ==
X-Gm-Message-State: ABy/qLbiGiTfipsrhF6ro521tYlF3ILCBFb4WtA5hW3dEcv59rtjqVV/
        pF9nf73rl/dx0MK1hplJcuXNfgWtHWrDJSuMJul6BA==
X-Google-Smtp-Source: APBJJlHpbym5NVbH/RcqOhrKSFskHR7tQZfcGUN6Xl3PdQvSaVwD+bRtz/ffQC9VU+PrLaI/scDIoQUVlMUBomjnwB4=
X-Received: by 2002:a05:6e02:1c01:b0:348:f100:a88 with SMTP id
 l1-20020a056e021c0100b00348f1000a88mr13379ilh.23.1690567058236; Fri, 28 Jul
 2023 10:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230718000737.49077-1-ivan@cloudflare.com> <CABWYdi2E1XozvwsZwOA80X-YbqLejj_5sxzNAh7w6R93rD5sCw@mail.gmail.com>
In-Reply-To: <CABWYdi2E1XozvwsZwOA80X-YbqLejj_5sxzNAh7w6R93rD5sCw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Jul 2023 10:57:26 -0700
Message-ID: <CAP-5=fUe5JxXK3gPAGcR279xDVmFarotHvb2Gk19u5SAOboGtg@mail.gmail.com>
Subject: Re: [PATCH] perf script: print cgroup on the same line as comm
To:     Ivan Babrou <ivan@cloudflare.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 28, 2023 at 10:42=E2=80=AFAM Ivan Babrou <ivan@cloudflare.com> =
wrote:
>
> On Mon, Jul 17, 2023 at 5:07=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com>=
 wrote:
> >
> > Commit 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
> > added support for printing cgroup path in perf script output.
> >
> > It was okay if you didn't want any stacks:
> >
> >     $ sudo perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgr=
oup
> >     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.se=
rvice
> >     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.se=
rvice
> >
> > With stacks it gets messier as cgroup is printed after the stack:
> >
> >     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,i=
p,sym
> >     jpegtran:23f4bf 3321915 [013] 404718.587488:
> >                     5c554 compress_output
> >                     570d9 jpeg_finish_compress
> >                     3476e jpegtran_main
> >                     330ee jpegtran::main
> >                     326e2 core::ops::function::FnOnce::call_once (inlin=
ed)
> >                     326e2 std::sys_common::backtrace::__rust_begin_shor=
t_backtrace
> >     /idle.slice/polish.service
> >     jpegtran:23f4bf 3321915 [031] 404718.592073:
> >                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDIN=
G
> >                 55af68e62fff [unknown]
> >     /idle.slice/polish.service
> >
> > Let's instead print cgroup on the same line as comm:
> >
> >     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,i=
p,sym
> >     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.se=
rvice
> >                     5c554 compress_output
> >                     570d9 jpeg_finish_compress
> >                     3476e jpegtran_main
> >                     330ee jpegtran::main
> >                     326e2 core::ops::function::FnOnce::call_once (inlin=
ed)
> >                     326e2 std::sys_common::backtrace::__rust_begin_shor=
t_backtrace
> >
> >     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.se=
rvice
> >                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDIN=
G
> >                 55af68e62fff [unknown]
> >
> > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > Fixes: 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")

This change makes sense to me. Namhyung, wdyt?

Thanks,
Ian


> > ---
> >  tools/perf/builtin-script.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 200b3e7ea8da..517bf25750c8 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -2199,6 +2199,17 @@ static void process_event(struct perf_script *sc=
ript,
> >         if (PRINT_FIELD(RETIRE_LAT))
> >                 fprintf(fp, "%16" PRIu16, sample->retire_lat);
> >
> > +       if (PRINT_FIELD(CGROUP)) {
> > +               const char *cgrp_name;
> > +               struct cgroup *cgrp =3D cgroup__find(machine->env,
> > +                                                  sample->cgroup);
> > +               if (cgrp !=3D NULL)
> > +                       cgrp_name =3D cgrp->name;
> > +               else
> > +                       cgrp_name =3D "unknown";
> > +               fprintf(fp, " %s", cgrp_name);
> > +       }
> > +
> >         if (PRINT_FIELD(IP)) {
> >                 struct callchain_cursor *cursor =3D NULL;
> >
> > @@ -2243,17 +2254,6 @@ static void process_event(struct perf_script *sc=
ript,
> >         if (PRINT_FIELD(CODE_PAGE_SIZE))
> >                 fprintf(fp, " %s", get_page_size_name(sample->code_page=
_size, str));
> >
> > -       if (PRINT_FIELD(CGROUP)) {
> > -               const char *cgrp_name;
> > -               struct cgroup *cgrp =3D cgroup__find(machine->env,
> > -                                                  sample->cgroup);
> > -               if (cgrp !=3D NULL)
> > -                       cgrp_name =3D cgrp->name;
> > -               else
> > -                       cgrp_name =3D "unknown";
> > -               fprintf(fp, " %s", cgrp_name);
> > -       }
> > -
> >         perf_sample__fprintf_ipc(sample, attr, fp);
> >
> >         fprintf(fp, "\n");
> > --
> > 2.41.0
> >
>
> A friendly bump in case this slipped through the cracks.
