Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B071C0015E
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 16:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjG1QB0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 12:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjG1QBZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 12:01:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3898B3C31
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 09:01:24 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40550136e54so352651cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690560083; x=1691164883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZH6nQn01C8Sr35XvItongnJrzthU2bVlvOmhLP0Vz4=;
        b=efVlqDVSjL6hA7pH00Obl7K/hepyTwEAmwJ9S77NzwRdLZhvsACfpPSV/UEEDWueDO
         WqpN1pZSCukYdKhuENE81FkCJ41Or7iSNohh3brPPiPR/EJcdFWXy3CxD1/Ezu2LfaMJ
         dDIqc7PSfthEwCbT4aH/hWJxzMmziJXj074F6WkoQ0jMqgjGNCTFB8lMxYCoB6mxTa6v
         TFXANH5T2OzmoPWaxtENtjUldT8CS6rV6cyAGsqj4i7z0uhCJVJK++r+84cErubxBpJS
         THtb+DI/cGVHK6IKxTtJHZVYVM+A/wShTe8cBebMKoPDyvb8rij1DmDWRBAMYmW4tR3S
         hVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690560083; x=1691164883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZH6nQn01C8Sr35XvItongnJrzthU2bVlvOmhLP0Vz4=;
        b=Yzy5JobODonnNG9fO6Xm8lb3dWZgpa92IX9HMAW2vpIDBjXUo0hinVOTwGO+dbcJGc
         mc5vPvxdLN8gi6B0dwJEY6VbsttFYOd7v4o7ZBDymqrikY1N5bMEFTufdHw4/ymFkL9D
         v1/MAtBugB3KrilW0OBRmsA7Sl6Rp98KVqj+tJ/86GPJe77M8Vj7jg242mBS08QnPYzS
         KYVq5jDPsi/NQwVKU24eE0B+oO4xshvK44NtjHqcUteWN4W5Tp1Ij/m/pH6MwYAenn5r
         hDyRnfrMAQVLjkr7KyrYK2Er6a+zylg2sqGRWWfOOonxyjvPxZ2MBgWFUs6qraBK33y5
         rJPQ==
X-Gm-Message-State: ABy/qLaYGA54dYeL3Ic7B9ufkdpY6waJYz+ARDWqAA+4xg7pgJ/Kty4r
        e0gAWS/hdfrW+4wXAwKBGZ/2wOx8+6F/5XCk8B8HeA==
X-Google-Smtp-Source: APBJJlGz8xBM5B0JACXOlDeDiPzvNUvs8ZfSUITEkeaXWUnL/b+pJDlsmnUkdUfhBNfddso1uEi2UhmOVMqQozMD6zs=
X-Received: by 2002:a05:622a:15d2:b0:3f5:2006:50f1 with SMTP id
 d18-20020a05622a15d200b003f5200650f1mr318937qty.12.1690560083088; Fri, 28 Jul
 2023 09:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230725061649.34937-1-adityag@linux.ibm.com> <ZMPWk5K63tadmDlU@kernel.org>
In-Reply-To: <ZMPWk5K63tadmDlU@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Jul 2023 09:01:11 -0700
Message-ID: <CAP-5=fW1zkpJ4zr4ngz=6bZQuE6hOHo4AtXwUsVJK9oiDSc_mg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests task_analyzer: Check perf build options
 for libtraceevent support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Aditya Gupta <adityag@linux.ibm.com>, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 28, 2023 at 7:54=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jul 25, 2023 at 11:46:49AM +0530, Aditya Gupta escreveu:
> > Currently we depend on output of 'perf record -e "sched:sched_switch"',=
 to
> > check whether perf was built with libtraceevent support.
> >
> > Instead, a more straightforward approach can be to check the build opti=
ons,
> > using 'perf version --build-options', to check for libtraceevent suppor=
t.
> >
> > When perf is compiled WITHOUT libtraceevent ('make NO_LIBTRACEEVENT=3D1=
'),
> > 'perf version --build-options' outputs (output trimmed):
> >
> >        ...
> >          libtraceevent: [ OFF ]  # HAVE_LIBTRACEEVENT
> >        ...
> >
> > While, when perf is compiled WITH libtraceevent,
> >
> > 'perf version --build-options' outputs:
> >
> > ...
> >          libtraceevent: [ on ]  # HAVE_LIBTRACEEVENT
> >        ...
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >
> >  tools/perf/tests/shell/test_task_analyzer.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/=
tests/shell/test_task_analyzer.sh
> > index 0095abbe20ca..a28d784987b4 100755
> > --- a/tools/perf/tests/shell/test_task_analyzer.sh
> > +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> > @@ -52,7 +52,7 @@ find_str_or_fail() {
> >
> >  # check if perf is compiled with libtraceevent support
> >  skip_no_probe_record_support() {
> > -     perf record -e "sched:sched_switch" -a -- sleep 1 2>&1 | grep "li=
btraceevent is necessary for tracepoint support" && return 2
> > +     perf version --build-options | grep HAVE_LIBTRACEEVENT | grep -q =
OFF && return 2
> >       return 0
>
> I'll apply this, but please consider adding a:
>
>         perf build --has libtraceevent

That's a nice idea. You mean add a script like perf-archive.sh?
Perhaps this flag should be supported by perf version instead.

Thanks,
Ian

> subcommand to have that query made more compact and to avoid the two
> extra grep.
>
> BTW, I'll change that to:
>
> [acme@quaco perf-tools-next]$ perf version --build-options | grep " on .*=
 HAVE_LIBTRACEEVENT"
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> [acme@quaco perf-tools-next]$
>
> replacing "on" with OFF, so that we have just one grep.
>
> Thanks,
>
> - Arnaldo
>
> >  }
> >
> > --
> > 2.41.0
> >
>
> --
>
> - Arnaldo
