Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA981C6FA99
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Mar 2023 17:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCFRgD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjCFRf7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Mar 2023 12:35:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B356A077
        for <linux-perf-users@vger.kernel.org>; Mon,  6 Mar 2023 09:35:18 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f11so9654289wrv.8
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Mar 2023 09:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678124051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l7f78f50NdGk2m7EfpInLJBNokopZ4/VqtELYi8kgQ=;
        b=PWK1KLD3NXA+Op3+NIpmd2+ES0GK5882iKRuKm06Xob4kTx0mxva4glDZeDYxv0ewj
         K1/E0IoVwep0z5lU6BNA0GTH9GHF/TsiGR3wETvRdOCF/8sOa1urnEtZ1YBKbRrU99rQ
         yDx33n1IB+JKXctnqqIuJ5tGyqcivUcvvcvqqTJ04G+zC+Rloj7T582ouDU8r606k3xu
         9tUJBoMPs/GwkLRysEPceCcCW5uhSsLYdWI4I5Vg8jUFEW7GXvcDRWqEuDLKDyoKDLLL
         81lzQmZO+Z90Kj//1ir2BBCA+1nxR+827iJnGuEt/7fVMbKYZHhFzERIzuogsH9eQzxg
         w4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678124051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+l7f78f50NdGk2m7EfpInLJBNokopZ4/VqtELYi8kgQ=;
        b=fzNT4CKofT/1hIYx1yEO3dIQE6Ts/U9RMX3GS1foKmezLkkVLFVygYM36NO4k872PP
         iLoSpWyVzC+kTOEQNC9sfhpuCGdehqiSFc6ugQsGeirW7u/+h+6yy4T9WXQBWOdT3GeJ
         oT8B5IWwxfk51wNF8TxMuMUU24rqf8Bl/91jafK7dhe3995QE/rCWnLN7bX0+fy67bNJ
         6AQvJCY3kC2hVaPtyzc+hN+Cxb4dox2myQorqhfmx17lS6m40126Hmx2dWoLWEEeon64
         5/VI09edepygK/bMQfgUaAI+WIuOYVZbWTAqbb97r5sl0sVi3Ns0c7xUWn4pjXZSbybj
         TQqw==
X-Gm-Message-State: AO0yUKVYwBPq5LnpjPvV9C2l0Rvc+vKBUhUrI+5+PR6LOKHmi2+AIB1y
        4073Q3Q3IYK1ue46QKuquf2u1IliNljLArCS0Mk21Gv1N8dF2Xc9xyc=
X-Google-Smtp-Source: AK7set/fB5PG1cyHdI+mAM94YVOfINZk1M3vtDgSx7dRCrvh/TRpiaR8/yz3a4RyqH08F+h3/4j707c45pl6kaJKh4c=
X-Received: by 2002:adf:fd0b:0:b0:2c9:f41d:6200 with SMTP id
 e11-20020adffd0b000000b002c9f41d6200mr2123761wrr.4.1678124050922; Mon, 06 Mar
 2023 09:34:10 -0800 (PST)
MIME-Version: 1.0
References: <CAPXMrf9hCmTKjUJJ_cymxqw696FdDvgV0xuDjwGeQTkoDpi=KQ@mail.gmail.com>
 <CAP-5=fWzTyz5hZqPSrtMyxZ3biu+ywtzMJk-A2jituE20EGGNA@mail.gmail.com> <CAPXMrf8KBWJ=+H6xTHM2kB0-PWE1euvKBc+NXPuf08s_jxVACg@mail.gmail.com>
In-Reply-To: <CAPXMrf8KBWJ=+H6xTHM2kB0-PWE1euvKBc+NXPuf08s_jxVACg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 6 Mar 2023 09:33:58 -0800
Message-ID: <CAP-5=fVU7RtHhKgyVHep4Z_AiVbS1dbYJVP9uBFGzn+_Wo=M9g@mail.gmail.com>
Subject: Re: perf record is crashing on system with bpf progs are running
To:     RAJESH DASARI <raajeshdasari@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 6, 2023 at 7:26=E2=80=AFAM RAJESH DASARI <raajeshdasari@gmail.c=
om> wrote:
>
> Hi ,
>
> I tried with perf build with Linux 6.2
> I get the below warning , now the crash is not seen but i see the
> Couldn't synthesize bpf events message on the output, I guess crash is
> avoided by this commit
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/t=
ools/perf/util/bpf-event.c?h=3Dv6.2.2&id=3D1a096ae46e21b73f83a581e617f76326=
c1de592d
>
> perf record
> Couldn't synthesize bpf events.
>
> perf record --no-bpf-event
> Couldn't synthesize bpf events.
>
> But when I pass --no-bpf-events option also I see this  Couldn't
> synthesize bpf events message , I feel the warning message is
> misleading as i am explicitly specifying no-bpf-event option , Please
> provide your inputs.

It sounds like kernel issues. You can add the -v verbose flag to see
what's happening but there is insufficient detail here to say what's
happening.

Thanks,
Ian

> Thanks,
> Rajesh Dasari.
>
> On Fri, Feb 24, 2023 at 5:45=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Feb 23, 2023 at 12:02=E2=80=AFAM RAJESH DASARI <raajeshdasari@g=
mail.com> wrote:
> > >
> > > Hi ,
> > >
> > > perf record is crashing on systems with bpf programs are running.
> > >
> > > We are running on the 4.18 host kernel and we launch a container ,
> > > inside the container we run perf record command, (bpf program is
> > > running). Perf is built on top of the 5.4.228 kernel.
> >
> > You mean you are running perf built from Linux 5.4? Could you try
> > something more recent like Linux 6.2?
> >
> > Thanks,
> > Ian
> >
> > > (gdb) bt
> > > #0  0x000000000055becf in perf_event__synthesize_one_bpf_prog
> > > (opts=3D0x94def8 <record+280>, event=3D0xabd910, fd=3D132, machine=3D=
0xaf6208,
> > > process=3D0x421260 <process_synthesized_event>,
> > >     session=3D0xaf6090) at util/bpf-event.c:242
> > > #1  perf_event__synthesize_bpf_events (session=3Dsession@entry=3D0xaf=
6090,
> > > process=3Dprocess@entry=3D0x421260 <process_synthesized_event>,
> > > machine=3Dmachine@entry=3D0xaf6208,
> > >     opts=3Dopts@entry=3D0x94def8 <record+280>) at util/bpf-event.c:33=
3
> > > #2  0x000000000041ff5c in record__synthesize (tail=3Dtail@entry=3Dfal=
se,
> > > rec=3D0x94dde0 <record>) at builtin-record.c:1323
> > > #3  0x0000000000422bc4 in __cmd_record (rec=3D0x94dde0 <record>,
> > > argv=3D<optimized out>, argc=3D<optimized out>) at builtin-record.c:1=
465
> > > #4  cmd_record (argc=3D<optimized out>, argv=3D<optimized out>) at
> > > builtin-record.c:2474
> > > #5  0x0000000000490769 in run_builtin (p=3Dp@entry=3D0x9574b8
> > > <commands+216>, argc=3Dargc@entry=3D1, argv=3Dargv@entry=3D0x7fffffff=
c120) at
> > > perf.c:312
> > > #6  0x000000000040c05a in handle_internal_command
> > > (argv=3D0x7fffffffc120, argc=3D1) at perf.c:364
> > > #7  run_argv (argv=3D<synthetic pointer>, argcp=3D<synthetic pointer>=
) at perf.c:408
> > > #8  main (argc=3D1, argv=3D0x7fffffffc120) at perf.c:538
> > >
> > > We tried running perf record --no-bpf-event but crash is still seen s=
o
> > > we added the below patch to skip processing bpf events when
> > > no-bpf-event options is provided , but not sure if this is the actual
> > > solution, please provide your inputs.
> > >
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.=
c
> > > index 454e275..78e96ad 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -1320,11 +1320,12 @@ static int record__synthesize(struct record
> > > *rec, bool tail)
> > >                 return err;
> > >         }
> > >
> > > -       err =3D perf_event__synthesize_bpf_events(session,
> > > process_synthesized_event,
> > > -                                               machine, opts);
> > > -       if (err < 0)
> > > -               pr_warning("Couldn't synthesize bpf events.\n");
> > > -
> > > +        if (!opts->no_bpf_event) {
> > > +                err =3D perf_event__synthesize_bpf_events(session,
> > > process_synthesized_event,
> > > +                                                       machine, opts=
);
> > > +               if (err < 0)
> > > +                       pr_warning("Couldn't synthesize bpf events.\n=
");
> > > +        }
> > >
> > >
> > > Thanks,
> > > Rajesh Dasari.
