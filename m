Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E051EC6FD1F
	for <linux-perf-users@archiver.kernel.org>; Sat, 25 Mar 2023 03:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCYDTI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Mar 2023 23:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYDTH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Mar 2023 23:19:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B604BBDEF
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 20:19:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d14so1578856ion.9
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 20:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679714346; x=1682306346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLEvDX9LEMNNnvoz2PkzPHceAuTxd9uiyhqMMnTdWQc=;
        b=luWEj+NDIEI8q137MKDZm3d8sh2CGvhMRwU9reujcm9gC1kwPjsG2m0acoEJ+OAEuZ
         CEDrVG7gZvEeAqJpmgKLL81xpnkb/a3VxkhSTJNufLnfjKoW07wrvLKHvqHuODXTh0BF
         8THuSAU2gKYq1f8w//UffcHMyxT+dOp7q7ET1wxQR1kLZemLT1b3KT04CRdvnKRN9Z4e
         Qq7zWEUJnWb7QcPG5ivn54R9Gp/vwczJBSfBsxPFMMrUioPesyMts6KjAu3KlU58swYD
         1BTtp1kofGCokyoDJnpRl/HVmwukY9c6EG2q1cPuQy66e+QOjD0HOJUcDZMsuXT2G7C+
         5Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679714346; x=1682306346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLEvDX9LEMNNnvoz2PkzPHceAuTxd9uiyhqMMnTdWQc=;
        b=FK2TmzvC3gX8W4KM6P0oEbh06PEbEiMCzcSfzd4PMR6bZiduYbQLf/fD+l0NCQvk8c
         04nPFq1MWf77SS0SKO2NGcBI1qzvY9mF0LaqFpnPzXIjrUqa4WFQhLURm0s896qaIFq6
         8LEch8HYDIu9IHDDFj13BteG5lVOLwYdR0UyuTAQqyezHHYOa4IUTiaDY6hClSf0vmBF
         eudfexgMFwsqS/GEyeRazFJPGAVvTT1YYrAtbicpLMz1LwJNSmGG5f00oz4TyUo8joZc
         9WlFcpGIlyyBWVn+4KWdAAcPTYY93YRuSiMY6o0uKeKuPDcXZeSPs6uh9KYv9yFiOU4h
         PTyg==
X-Gm-Message-State: AO0yUKUbmXI4XqQApXc00IlrXeQusLHRpRx0gtG6r98RvJyjbhO8iih4
        n6VUN8KRjpOZsaeujuk1k6u85wODUJD5h245WkQjc/0l
X-Google-Smtp-Source: AK7set+ISFAhexxzqrbNwbdkKXXTA8O5/XdN8djgsL75N6dA3YQaqOyTT4jEVMcmJ3xHJ+Tl6uUxiNPSLXL4v7fY4j0=
X-Received: by 2002:a6b:720b:0:b0:74c:bc14:46a1 with SMTP id
 n11-20020a6b720b000000b0074cbc1446a1mr3785795ioc.4.1679714346003; Fri, 24 Mar
 2023 20:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAGKjw9KHDnVgRz5bstJYkq4t0-bT5fvkuQZbEB48d-8jo4Q00g@mail.gmail.com>
 <20230303193058.21274-1-patrice.duroux@gmail.com> <CAP-5=fV5h9AEf3V1taXA++frs=AAPeuPbd=Hb0koVjKfGpQNsw@mail.gmail.com>
 <CAP-5=fUy_mLJ2-z89dc0vro+1aqWFn-CrvqZA1Ji3etPXg+RTg@mail.gmail.com> <ZB4DdJ14nz84CTCl@kernel.org>
In-Reply-To: <ZB4DdJ14nz84CTCl@kernel.org>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 24 Mar 2023 20:18:54 -0700
Message-ID: <CAM9d7chpa1rv1P6=a2ESjKXytD3PnuS-Vcy2OeTWLxc0qNRpug@mail.gmail.com>
Subject: Re: [PATCH 1/2] replace 2&>1 by 2>&1
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Patrice Duroux <patrice.duroux@gmail.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Fri, Mar 24, 2023 at 1:19=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Mar 23, 2023 at 11:03:49AM -0700, Ian Rogers escreveu:
> > On Mon, Mar 6, 2023 at 1:46=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > On Fri, Mar 3, 2023 at 11:31=E2=80=AFAM Patrice Duroux <patrice.durou=
x@gmail.com> wrote:
> > > >
> > > > Signed-off-by: Patrice Duroux <patrice.duroux@gmail.com>
> > >
> > > Fixes: ade1d0307b2f ("perf offcpu: Update offcpu test for child proce=
ss")
> > > Acked-by: Ian Rogers <irogers@google.com>
> > >
> > > Thanks,
> > > Ian
> >
> > Arnaldo, could we pick this up?
>
> Yeah, but next time please write in the subject line that its a patch
> for the perf tools :-)

Oops, it was me who messed this up.. sorry about that.
At least now I know where the file named "1" is created. :)

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> >
> > > > ---
> > > >  tools/perf/tests/shell/record_offcpu.sh | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/t=
ests/shell/record_offcpu.sh
> > > > index e01973d4e0fb..f062ae9a95e1 100755
> > > > --- a/tools/perf/tests/shell/record_offcpu.sh
> > > > +++ b/tools/perf/tests/shell/record_offcpu.sh
> > > > @@ -65,7 +65,7 @@ test_offcpu_child() {
> > > >
> > > >    # perf bench sched messaging creates 400 processes
> > > >    if ! perf record --off-cpu -e dummy -o ${perfdata} -- \
> > > > -    perf bench sched messaging -g 10 > /dev/null 2&>1
> > > > +    perf bench sched messaging -g 10 > /dev/null 2>&1
> > > >    then
> > > >      echo "Child task off-cpu test [Failed record]"
> > > >      err=3D1
> > > > --
> > > > 2.39.2
> > > >
>
> --
>
> - Arnaldo
