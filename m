Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98130C433E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 01:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E62964E2E
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 01:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhBRBWx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Feb 2021 20:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhBRBWw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Feb 2021 20:22:52 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6184CC061574
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Feb 2021 17:22:37 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id b16so394304lji.13
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Feb 2021 17:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ES4dbYRX09Q2opUge7V3g9wUmR2OFYOCxA+Yv0qlEdg=;
        b=TRbRLSCLk2ZBB4qsbVdN9yvmBNe0SAODq+KJTwX1xt1k4GURMtfKFxeOZvDBOXTGf1
         5NOmdTu3TSQwn7FXQO7Fk764eCJXRPGRZy1W9TgI0lr3ycOPt3XJN2axqs9VZ84L61zg
         hyIVdrXrnGSgQA+gNQSnyyK8SUfyKDGSUnRuDNBTlyEnNR1Pp2asQb+PO2T2KaPGQe77
         eK1bD1EKJWN29OGkklBi57z7+h/n5/ad8ZLBdwMd7Ky0x7NaS4McvdZXyrWabP2ojRTh
         HCEbmIpPeFHzuvGg61UvQKj+4Zky000/deJxcgkex5iz5veEPTA4PSt8xqV+PW1vbVpf
         w0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ES4dbYRX09Q2opUge7V3g9wUmR2OFYOCxA+Yv0qlEdg=;
        b=T0Kyh4gbiVRegYg83RZmVqzNt6U2qgfyJBcLac5qUK03Lni74AgPCvqGVbU5LI/fzz
         9GSEeYC8Oz6aIhKTI+AzPflExGvpZgaLEftpyv0CWpdafaUHtrNy5VEg++QrIPRiBVZG
         SJbXVyfAyqqU80Y/xp4bZClWkmkENzygQNc5bA4+K14NTkKJ1u/jIn0iTereGN9gNa7j
         oLRl8SmHfv1f4HJBhZ5/3jL6bxWsIXyPpyrdIaD/QV/O6lH0UOwny5T5hzGVD6LgRvUw
         pDwyBDO5Ae3T3J9MAJcS8nJ0vFrruLv2kqfR5s259oPmByYNlK5icHJk1Kjp1L6Hz28v
         v2Qw==
X-Gm-Message-State: AOAM530XRgPI6ZKCxdilPDG1IULk1Tf5+VaEr5cwJY2DtH7yV7axOiSO
        wh0Qh3yQpLhUCZvLwGXc9uc5StaEw9q3fXBrjYoYoBxU4bcNPOvG
X-Google-Smtp-Source: ABdhPJz5ZD86aQR4oKaYPTtiO7ZLUVnvEwt4rgU5OqQKfbBDPrpGpwOJEy6Wz2qpOivb0wpZRk6cReDkaUDrWvO1q1w=
X-Received: by 2002:a2e:b048:: with SMTP id d8mr1119114ljl.386.1613611355880;
 Wed, 17 Feb 2021 17:22:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHb-xavRszhCbGcs0DgrdoJCHmOznHC4UzhLXxtXz=gXXk+wMQ@mail.gmail.com>
 <CAM9d7cg2qfQcNkH__XL8HUPSfsFqSwnYUXWCJZQLr06dip9RCw@mail.gmail.com>
In-Reply-To: <CAM9d7cg2qfQcNkH__XL8HUPSfsFqSwnYUXWCJZQLr06dip9RCw@mail.gmail.com>
From:   rainkin <rainkin1993@gmail.com>
Date:   Thu, 18 Feb 2021 09:22:00 +0800
Message-ID: <CAHb-xattigptjcmZCXu81vJ-Z05=L+mGJJ=AgFset0w0g=aEcw@mail.gmail.com>
Subject: Re: [Question] How to sample PERF_TYPE_HARDWARE
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,
Thanks for your reply.
Let me make my goal more clear:
record the number of occurring branches instructions
(PERF_COUNT_HW_BRANCH_INSTRUCTIONS) every N cycles
(PERF_COUNT_HW_CPU_CYCLES).

>   perf record -e branches -c N
I use strace to capture the syscall invoked by the above command:

perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_VER6,
config=3DPERF_COUNT_HW_BRANCH_INSTRUCTIONS, sample_period=3D100000,
sample_type=3DPERF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_TIME|PERF_SAMPLE_I=
D|PERF_SAMPLE_CPU,
read_format=3DPERF_FORMAT_ID, disabled=3D1, inherit=3D1, pinned=3D0,
exclusive=3D0, exclusive_user=3D0, exclude_kernel=3D0, exclude_hv=3D0,
exclude_idle=3D0, mmap=3D0, comm=3D0, freq=3D0, inherit_stat=3D0,
enable_on_exec=3D0, task=3D0, watermark=3D0, precise_ip=3D0 /* arbitrary sk=
id
*/, mmap_data=3D0, sample_id_all=3D1, exclude_host=3D0, exclude_guest=3D1,
exclude_callchain_kernel=3D0, exclude_callchain_user=3D0, mmap2=3D0,
comm_exec=3D0, use_clockid=3D0, context_switch=3D0, write_backward=3D0,
namespaces=3D0, wakeup_events=3D0, config1=3D0, config2=3D0,
sample_regs_user=3D0, sample_regs_intr=3D0, aux_watermark=3D0,
sample_max_stack=3D0, aux_sample_size=3D0}, -1, 10, -1,
PERF_FLAG_FD_CLOEXEC) =3D 15

In my understanding ,WHAT this command actually does is recording
IP,TID, and so on
(sample_type=3DPERF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_TIME|PERF_SAMPLE_=
ID|PERF_SAMPLE_CPU)
every N (here N =3D 100000) branches
(config=3DPERF_COUNT_HW_BRANCH_INSTRUCTIONS). Thus this cannot meet my
goal.

Thanks,
Rainkin


Namhyung Kim <namhyung@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Mon, Feb 8, 2021 at 12:50 PM rainkin <rainkin1993@gmail.com> wrote:
> >
> > Hello~
> >
> > My goal is to record the number of occurring PERF_TYPE_HARDWARE events
> > (e.g., branches) every N events.
> >
> > In my understanding, the "perf stat -e branches -I N " command is not
> > sampling, it is actually count model which records branches every N
> > millisecond. Thus perf stat does not meet my goal.
> >
> > For the "perf record -e cycles -b" command, it does sampling, which
> > records a LBR sample every N cycles events. However, it seems that
> > "perf record" does not support sampling PERF_TYPE_HARDWARE.
>
> The 'cycles' is a PERF_TYPE_HARDWARE event.
>
> >
> > I also look at the syscall perf_event_open, but still cannot find any
> > documentation about how to sample PERF_TYPE_HARDWARE.
> >
> > Does anyone know how to do that=EF=BC=9FAny suggestions is helpful for =
me :)
>
>   perf record -e branches -c N
>
> ?
>
> Thanks,
> Namhyung
