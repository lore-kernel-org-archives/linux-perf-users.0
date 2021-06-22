Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AE9C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 18:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8256128C
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 18:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhFVSTw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhFVSTv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 14:19:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4429AC061756
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Jun 2021 11:17:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e22so21194493wrc.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Jun 2021 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUjNFgJbMc3n/4UpR024/4xgXFRMOO3TLXFoCvUi2LM=;
        b=ZCaB6t+mhREkhR2OvNFoApIE1ei48vRy96ybHQvvpa0MUrNGm/D8CtXEAmf2AckYqc
         +8phSg2DOhfIRbX6xyLwluGh2a3zgUgofsBBEpCEXFq71BRAvUNhHnNqz2y2K45pjodr
         vSZiL6w+/RuM2lVCluoiuATe1Evwl+5YPqOSpYAipU+eVTaiZFd11jVOiAarRbPybAKQ
         FOJndxr8aMZYOiCaGRsiSRWSWRQYHHwbPpM3an9YVhxoUtvr9cf9WXbCR6LofyEhQ9qo
         Y7vzKUv20I87Pv5KGp0y9ZO5TEZarChFNwgw9ZrLTo8aA/PEWFFi7qT4zSno74UaNHZR
         G+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUjNFgJbMc3n/4UpR024/4xgXFRMOO3TLXFoCvUi2LM=;
        b=Wz1sDx31InzSGQSPVTYKCBNk0BN6fA0hyRaLQiwqyV6lvLVdYVHuVMHw8+NF9VkMIr
         oyXlsrhlaMCNWzEMtPY0rHzNkV2BwSdwGPliEQkCKMXCt/k6fcG5T03N91BQ6P1wKgUP
         z9M/d4SrwhuHMckAdBLjfO4UdpOSw+efMLjT4lGxCdbY5GqbKMRSlW2eOKPd9yA/tMH0
         M1Z2KiqXbq8DbHAIRO0ha2SIJiAGNbfQiLk3fTGluT1nKZGU3DN2tBvq2rLGKlxlu5zz
         kxizar6yfwB0OGgg2hF/YVcfm40X4WdghwPk/FsL8BfTz3yDxF1BUD7Hffpizh3Y9KzO
         WIvA==
X-Gm-Message-State: AOAM532lN8jVz71GqvVPytyBM8U4a3oCF5KNCsztGyRPI1dyiMMnxa5A
        58HH8ywH1khykUS2MWfL4GyAIWcGDzmeaNxijTwNYw==
X-Google-Smtp-Source: ABdhPJyyD07iHLTvYxa9U4h3OlVZ8XIGjNQEW31my+3kcgwEcINQJUt+bKV/AuDvHglyJgtyk90UVOSS0U0MHI7/gOQ=
X-Received: by 2002:adf:f30d:: with SMTP id i13mr6318395wro.119.1624385853745;
 Tue, 22 Jun 2021 11:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210621215648.2991319-1-irogers@google.com> <YNIhzyKPqfFvvoYs@kernel.org>
 <YNIjtOSoj+aWnQns@kernel.org>
In-Reply-To: <YNIjtOSoj+aWnQns@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 22 Jun 2021 11:17:21 -0700
Message-ID: <CAP-5=fUtE_9=dYaazUJYzDGz2+nGcWjJoCxGb6b5oSbU6Z02AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf test: Pass the verbose option to shell tests
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 22, 2021 at 10:54 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jun 22, 2021 at 02:45:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jun 21, 2021 at 02:56:46PM -0700, Ian Rogers escreveu:
> > > Having a verbose option will allow shell tests to provide extra failure
> > > details when the fail or skip.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/builtin-test.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > > index cbbfe48ab802..e1ed60567b2f 100644
> > > --- a/tools/perf/tests/builtin-test.c
> > > +++ b/tools/perf/tests/builtin-test.c
> > > @@ -577,10 +577,13 @@ struct shell_test {
> > >  static int shell_test__run(struct test *test, int subdir __maybe_unused)
> > >  {
> > >     int err;
> > > -   char script[PATH_MAX];
> > > +   char script[PATH_MAX + 3];
> >
> > This looks strange, i.e. if it is a _path_ _MAX_, why add 3 chars past
> > that max when generating a _path_? I'll drop the above hunk and keep the
> > rest, ok?
>
> Oh well, its not a path after all, its something that is passed to
> system(), the use of PATH_MAX seems arbitrary, so your patch wasn't
> wrong, but since it is arbitrary, I'll keep it at PATH_MAX and reduce
> the patch size 8-)
>
> - Arnaldo

Works for me. Thanks,

Ian

> > >     struct shell_test *st = test->priv;
> > >
> > > -   path__join(script, sizeof(script), st->dir, st->file);
> > > +   path__join(script, sizeof(script) - 3, st->dir, st->file);
> > > +
> > > +   if (verbose)
> > > +           strncat(script, " -v", sizeof(script) - strlen(script) - 1);
> > >
> > >     err = system(script);
> > >     if (!err)
>
> --
>
> - Arnaldo
