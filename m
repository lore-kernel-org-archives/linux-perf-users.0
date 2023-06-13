Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998EBC7EE29
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 13:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbjFMNXs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 09:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbjFMNXs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 09:23:48 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A851E6
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 06:23:47 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b28fc7a6dcso3851603a34.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686662626; x=1689254626;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR5zmorCkKDaSbvaf9pNI6jJlWzgrKKfPwK8wVfaj5g=;
        b=jKDURkE+bZ7y5cwkBT8w6pzqUNHaV7zZhqw5p5Hxvsb1YavF+N+inNUDwono5XTpqD
         0/O5S8eWFOXMdDGH/fe+a78AyJcBwm1Y8rNZUHSjMlfu015bkNWLR4zNl5uvyjJDzSMf
         Flw3EeT/yg/2kP8FqsEeli8atTK6mYKeynl0l+Zv9oXj+usLicRHUTSkFdXiMZxSACwJ
         Uo4XZOxpEN6rYjkGHDqZvxXZfGEOAvd6ZJqTC4lrJLSWLB39whLzaf9qXY07WotFM5Lx
         jfPxcg/jtKiYGTA1PoANbhne4sNglmrPGvedJtf/dI5JsZJLHny0yePfEFyr7L2Xa2ba
         d7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686662626; x=1689254626;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR5zmorCkKDaSbvaf9pNI6jJlWzgrKKfPwK8wVfaj5g=;
        b=YIk8nIo7TchUMe3vCs3G/Yw7GjXen1jV/CES2eeN/TSg2jIWff1UtBxKmzbcF5zPaG
         vrqYolMt3XEHs3xZv5LPhYnJzk5A0m/i8I65Wn8GSZ72zZ3iHV0BLEhUgGXbD92aMeK+
         a+XkurudXulCdwTlB3ZWbGP5++C1R+Otx1Tm6cus3OpjtLJz9fgd4IlfAEpgwKa9UqmX
         DCoueFlNnxDCwo11csyKfLJPgC6GQ20tKqtOogaztlFxywKbIkbBEwWihWyi9SH4hzy2
         qrr0QyGuCNOLwqPHTLr/sPedMvZt8f1bIsSUq/M3ESSPQXjtdQSRYLZQRuVchEL945mh
         slGw==
X-Gm-Message-State: AC+VfDzFJmUsi/xjA5BIxApoZSWe3SVMYnUhaqdX33wWslE+jibaXQ8i
        QF9tydr+CQsoAfsnoKcPOqyCcVwEOgdrhe/T/I6SVTEWpKM=
X-Google-Smtp-Source: ACHHUZ5DnLDxqypl3fW0UGmXGpeqkkRpmkBxCu5tD3//lebby8WULn/3Y6xKUXmY7oTEBOtrC3MT1AdT05oOsssO1JE=
X-Received: by 2002:a05:6808:204:b0:39c:4779:d92 with SMTP id
 l4-20020a056808020400b0039c47790d92mr7125702oie.51.1686662626173; Tue, 13 Jun
 2023 06:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
 <874963e2-f97e-b463-1351-b00640b0f67b@arm.com> <CALDTKqg01+xJ2xu218c_QH2PbX9wdhYOiJfDieCXL5PHWV-6FQ@mail.gmail.com>
 <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com>
In-Reply-To: <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com>
From:   =?UTF-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>
Date:   Tue, 13 Jun 2023 21:23:33 +0800
Message-ID: <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
Subject: Re: Some questions about using the perf tool in ARM-SPE
To:     James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

OK
I have a new discovery that c2c seems to support only certain Arm
Neoverse (N1/N2/V1) CPUs, I wonder if cortex-X4 could support it?

Using the Arm Statistical Profiling Extension to detect false
cache-line sharing | Blog | Linaro

Thanks
Zack

<http://www.avg.com/email-signature?utm_medium=3Demail&utm_source=3Dlink&ut=
m_campaign=3Dsig-email&utm_content=3Dwebmail>
=E4=B9=BE=E6=B7=A8=E7=84=A1=E7=97=85=E6=AF=92=E3=80=82www.avg.com
<http://www.avg.com/email-signature?utm_medium=3Demail&utm_source=3Dlink&ut=
m_campaign=3Dsig-email&utm_content=3Dwebmail>
<#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2>


James Clark <james.clark@arm.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Zack,
>
> It looks like you replied just to me rather than to the list. Are you
> able to re-send this as a reply-all to the original post so others might
> be able to help as well?
>
> Thanks
> James
>
> On 12/06/2023 06:50, =E8=94=A1=E6=B2=85=E4=BF=A1 wrote:
> > Hi James.
> >
> > After my debug experiment. I found that there are seven CPUs on my plat=
form
> > but I can't get them to work together
> > The first setting is divided into three types of clusters. This part is=
 set
> > to three cluter through DTS
> >
> > user_shell:/sys/bus/event_source/devices # cat arm_spe_0/cpumask
> > arm_spe_1/cpumask arm_spe_2/cpumask
> > 7
> > 4-6
> > 0-3
> >
> > This makes it impossible for me to record the whole system together (cp=
u
> > 0-7). only one cluter can be recorded at the same time  thhe above is -=
v
> > information
> >
> > user_shell:/data/local/tmp # ./perf record -e
> > arm_spe/branch_filter=3D1,load_filter=3D1,store_filter=3D1,ts_enable=3D=
1,pct_enable=3D1,pa_enable=3D1,min_latency=3D10,jitter=3D1/
> > -a  -v  --vmlinux ./vmlinux -o text.data
> >  Warning: option `vmlinux' is being ignored because NO_DWARF=3D1
> > DEBUGINFOD_URLS=3D
> > nr_cblocks: 0
> > affinity: SYS
> > mmap flush: 1
> > comp level: 0
> > maps__set_modules_path_dir: cannot open
> > /lib/modules/6.1.25-android14-5-maybe-dirty-mainline dir
> > Problems setting modules path maps, continuing anyway...
> > mmap size 528384B
> > Control descriptor is not initialized
> > ^C[ perf record: Woken up 51 times to write data ]
> > failed to write feature CPUDESC
> > failed to write feature NUMA_TOPOLOGY
> > failed to write feature MEM_TOPOLOGY
> > failed to write feature CPU_PMU_CAPS
> > failed to write feature HYBRID_TOPOLOGY
> > [ perf record: Captured and wrote 23.952 MB text.data ]
> >
> > Could give me some help can three cluter work together I think perf c2c
> > should also work
> > If I have left out any information you may need, please let me know!
> >
> > Many Thanks
> > Best Regards
> > Zack.
> >
> >
> > James Clark <james.clark@arm.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=889=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:06=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> >>
> >>
> >> On 09/06/2023 08:14, =E8=94=A1=E6=B2=85=E4=BF=A1 wrote:
> >>> hi linux-perf-users
> >>>
> >>> I glad perf tool can support ARM-SPE.
> >>> however, I have encountered some problems in using
> >>> My perf tool version is 6.1. I compiled it to run on an Android syste=
m
> >>> "Here are my questions"
> >>>
> >>> 1.I can't use the perf c2c function to analyze, i'm not sure if it
> >>> only supports certain hardware architectures
> >>>
> >>>>> user_shell:/data/local/tmp # ./perf c2c report
> >>>>> Failed setup nodes
> >>>
> >>> 2.I get more information via the command /.perf report --mem-mode but
> >>> I'm confused about the data
> >>>
> >>> Snoop  Locked  Blocked     Local INSTR Latency
> >>> ......         ..........  .       ..................
> >>> N/A            No          N/A           0
> >>> N/A            No          N/A           0
> >>> N/A            No          N/A           0
> >>> N/A            No          N/A           0
> >>> .               ,                .
> >>> .
> >>> .
> >>> I have observed a lot of data about Snoop&Locked&Blocked&Local INSTR
> >>> Latency and their results are always N/A&No&N/A&0 which makes me feel
> >>> like it is not supported. Please give me some information about it an=
d
> >>> introduction.
> >>>
> >>> Many Thanks
> >>> Best Regards
> >>> Zack.
> >>
> >> Hi Zack,
> >>
> >> I wasn't able to reproduce your issue on Ubuntu, it could be something
> >> to do with Android.
> >>
> >> It looks like the error "Failed setup nodes" comes from the
> >> setup_nodes() function. Can you debug it to see exactly which part of =
it
> >> is failing? I see it's something to do with numa nodes, maybe that
> >> doesn't work on Android or you need to add some numa stuff to the kern=
el
> >> config. Or the function needs to handle missing data differently.
> >>
> >> James
> >>
> >
