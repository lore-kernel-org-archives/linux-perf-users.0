Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBF1C61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Mar 2023 15:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCFP0F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Mar 2023 10:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCFP0E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Mar 2023 10:26:04 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E24740CB
        for <linux-perf-users@vger.kernel.org>; Mon,  6 Mar 2023 07:26:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so13567449pjh.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Mar 2023 07:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678116363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dJisTcWtTAHOK1HVT6hPcwzw6Hfx27Poxp09pHkeuA=;
        b=EOGVnrw1Ridf7OvFAURa4YIpPF/m5weuui4TL0vfn2eNUlUEXcxwruEZprmaa571tx
         uiyaH6nNNfB1vqmQBfERGj/Hpc0K955zDGYFVkSoaNOiRjEdc8B6xk6mVJ0fvn9uuIPM
         WFheycoC6M+jisYZV7oEgfCxOHL+kni95XNuXON2Fxng8VEF9U5PbDnpCO9drDJIciU9
         uuiioplbgEPqOFUIYUzG0ofdA5yEB0N0cqIP5qqOREbETZLrqcfd/HiWIoiDIWDyxOVR
         IA2xp5i92mrfoRVDLLfx8wPDxGGidPV+TpmdKlZcnvOKgV8aPXBbjwrB3qz77AQZZn8Z
         53Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dJisTcWtTAHOK1HVT6hPcwzw6Hfx27Poxp09pHkeuA=;
        b=Qkur7ZRQ9WWtVaBV33Szq3VCkSkGTsZUW1czKrufrESWU8fAW2z4Zi1+JYwEgp5T2+
         5HE3im1CZ3Q1knjdcs9CEeAyB0+Zvw0ykdfz0H0120w/eUYNfLgqUsVSWHnQoWOrPr9M
         4xo+QvSxnxrTx19v1Xy5d8cBVXMrdpfnJOj+hA8o74mTrz+IbDmLbDSWUzIAKETgtPj+
         JSWs4OIG4yQZp/OmxYr2MG7NvpOD/mY4c80Rnli99m0QMDNjCIPEqh7xOiScVkPm9+Jo
         YzYnuKffS34BSdkxLLNgyFTacc03tkbd66CudRBlZa+XOnkXm2S505vHJkqRtvcv8TRi
         xiLg==
X-Gm-Message-State: AO0yUKXL4D+4+wKiFLzShKEeDbW1A8UYD9A6l+QGg005lX5FvArDfg7L
        87owJmcX72orBS+OWAvJyr2ChwmKkwEl50tbBsE=
X-Google-Smtp-Source: AK7set8htLJIgdNbT7TGHrvuC71LSjPZA1ZGBGh5fZ0uMo/UKvcRIvvpMGIdDtaQIDFp2YpuQExtJEcUArZnTu1HYEM=
X-Received: by 2002:a17:903:4282:b0:19a:ac0b:9d93 with SMTP id
 ju2-20020a170903428200b0019aac0b9d93mr4595499plb.0.1678116362995; Mon, 06 Mar
 2023 07:26:02 -0800 (PST)
MIME-Version: 1.0
References: <CAPXMrf9hCmTKjUJJ_cymxqw696FdDvgV0xuDjwGeQTkoDpi=KQ@mail.gmail.com>
 <CAP-5=fWzTyz5hZqPSrtMyxZ3biu+ywtzMJk-A2jituE20EGGNA@mail.gmail.com>
In-Reply-To: <CAP-5=fWzTyz5hZqPSrtMyxZ3biu+ywtzMJk-A2jituE20EGGNA@mail.gmail.com>
From:   RAJESH DASARI <raajeshdasari@gmail.com>
Date:   Mon, 6 Mar 2023 17:25:52 +0200
Message-ID: <CAPXMrf8KBWJ=+H6xTHM2kB0-PWE1euvKBc+NXPuf08s_jxVACg@mail.gmail.com>
Subject: Re: perf record is crashing on system with bpf progs are running
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi ,

I tried with perf build with Linux 6.2
I get the below warning , now the crash is not seen but i see the
Couldn't synthesize bpf events message on the output, I guess crash is
avoided by this commit
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/too=
ls/perf/util/bpf-event.c?h=3Dv6.2.2&id=3D1a096ae46e21b73f83a581e617f76326c1=
de592d

perf record
Couldn't synthesize bpf events.

perf record --no-bpf-event
Couldn't synthesize bpf events.

But when I pass --no-bpf-events option also I see this  Couldn't
synthesize bpf events message , I feel the warning message is
misleading as i am explicitly specifying no-bpf-event option , Please
provide your inputs.

Thanks,
Rajesh Dasari.

On Fri, Feb 24, 2023 at 5:45=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Feb 23, 2023 at 12:02=E2=80=AFAM RAJESH DASARI <raajeshdasari@gma=
il.com> wrote:
> >
> > Hi ,
> >
> > perf record is crashing on systems with bpf programs are running.
> >
> > We are running on the 4.18 host kernel and we launch a container ,
> > inside the container we run perf record command, (bpf program is
> > running). Perf is built on top of the 5.4.228 kernel.
>
> You mean you are running perf built from Linux 5.4? Could you try
> something more recent like Linux 6.2?
>
> Thanks,
> Ian
>
> > (gdb) bt
> > #0  0x000000000055becf in perf_event__synthesize_one_bpf_prog
> > (opts=3D0x94def8 <record+280>, event=3D0xabd910, fd=3D132, machine=3D0x=
af6208,
> > process=3D0x421260 <process_synthesized_event>,
> >     session=3D0xaf6090) at util/bpf-event.c:242
> > #1  perf_event__synthesize_bpf_events (session=3Dsession@entry=3D0xaf60=
90,
> > process=3Dprocess@entry=3D0x421260 <process_synthesized_event>,
> > machine=3Dmachine@entry=3D0xaf6208,
> >     opts=3Dopts@entry=3D0x94def8 <record+280>) at util/bpf-event.c:333
> > #2  0x000000000041ff5c in record__synthesize (tail=3Dtail@entry=3Dfalse=
,
> > rec=3D0x94dde0 <record>) at builtin-record.c:1323
> > #3  0x0000000000422bc4 in __cmd_record (rec=3D0x94dde0 <record>,
> > argv=3D<optimized out>, argc=3D<optimized out>) at builtin-record.c:146=
5
> > #4  cmd_record (argc=3D<optimized out>, argv=3D<optimized out>) at
> > builtin-record.c:2474
> > #5  0x0000000000490769 in run_builtin (p=3Dp@entry=3D0x9574b8
> > <commands+216>, argc=3Dargc@entry=3D1, argv=3Dargv@entry=3D0x7fffffffc1=
20) at
> > perf.c:312
> > #6  0x000000000040c05a in handle_internal_command
> > (argv=3D0x7fffffffc120, argc=3D1) at perf.c:364
> > #7  run_argv (argv=3D<synthetic pointer>, argcp=3D<synthetic pointer>) =
at perf.c:408
> > #8  main (argc=3D1, argv=3D0x7fffffffc120) at perf.c:538
> >
> > We tried running perf record --no-bpf-event but crash is still seen so
> > we added the below patch to skip processing bpf events when
> > no-bpf-event options is provided , but not sure if this is the actual
> > solution, please provide your inputs.
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 454e275..78e96ad 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1320,11 +1320,12 @@ static int record__synthesize(struct record
> > *rec, bool tail)
> >                 return err;
> >         }
> >
> > -       err =3D perf_event__synthesize_bpf_events(session,
> > process_synthesized_event,
> > -                                               machine, opts);
> > -       if (err < 0)
> > -               pr_warning("Couldn't synthesize bpf events.\n");
> > -
> > +        if (!opts->no_bpf_event) {
> > +                err =3D perf_event__synthesize_bpf_events(session,
> > process_synthesized_event,
> > +                                                       machine, opts);
> > +               if (err < 0)
> > +                       pr_warning("Couldn't synthesize bpf events.\n")=
;
> > +        }
> >
> >
> > Thanks,
> > Rajesh Dasari.
