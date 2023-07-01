Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E44EB64DC
	for <linux-perf-users@archiver.kernel.org>; Sat,  1 Jul 2023 05:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjGAFZz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 1 Jul 2023 01:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGAFZy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 1 Jul 2023 01:25:54 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9DDE65
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 22:25:52 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c17534f4c63so2613851276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 22:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688189150; x=1690781150;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1IbgPskuZjkHbaetOdWMwLAnH5BVLJDAsDlTvG1aNY=;
        b=TLBTzB4w9M5dZ4szDykw89pQBnCzAiltHR7/yKKZQ5cbteV5jtPrrBdU0R5G9HChKl
         xdILJmcDakKaKSJyzw/G/LXe5HvlRnncFTytw7ZiWHTV/63MgKoInqo1kp+o4Fi5wErl
         UqN6dUwhgXVLbnkuhiSHoKWjgwQ/ryD821quWcn+49E53B5IUh7m8fBQIhQJg/ee7PDb
         f4drmWCxW+yynMRsUMwf6ud6DJWg1C1iFFsKaxduRZcHOcVWSZu3dVgkWPf+RrTWL71a
         hROI/LcnBJaPBBKMVAMh1Vt8evk5E54i0QkhbjlJ1f5hskYHfr2N1+QyDRU3KOYsnYWR
         7euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688189150; x=1690781150;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1IbgPskuZjkHbaetOdWMwLAnH5BVLJDAsDlTvG1aNY=;
        b=EP/ltBln3BSuCK2PRe/yy1RswDFZWC/hWp7puGMFFImIMhNUOlmnsvcXVt6+A3ujzU
         07r9Jf8HUhC5shveQ5NO1FCc2uUz/QjTszMdwmKHifdpaHiNnqQ5uEKKnC+mce0P8DtF
         qDn5sdy/POjmQgScvYKwdkM3GZUF9N4DoBzSf2GXBoqE7FUORL8oZy8b0/Ftt9CkzBij
         6F63wTXZkAkWcawfEGGrpYYvAyk2cPYzOoaid669nsSEuhUfYaknNetL5Xj15oivrqEP
         rkuvLZSwI+93G/pEwDSQTYtqWEva+2ze4U+Tx+QsFDulRk5opvH2jwmPFZ+DKWogFdpf
         TlVw==
X-Gm-Message-State: ABy/qLZPaGHEfg8juCs6Md4uuNHxYH3xN4FQSGaVZg07UEGXyfB8YoBF
        vDF2SfRMtimJzjgmlaEQYA5VXG4mkjhcZZJfXosTarSNgrM=
X-Google-Smtp-Source: APBJJlHir6+4qDZYSLAkAyTG5ZtHyF3IaovP4RJDA+xfO1sL6Z63SpteSw3k64H+dpQwzDLInxmNYvr3+42H2E/6AKs=
X-Received: by 2002:a05:6902:603:b0:ba7:6d35:6b0f with SMTP id
 d3-20020a056902060300b00ba76d356b0fmr4813803ybt.22.1688189150144; Fri, 30 Jun
 2023 22:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
 <874963e2-f97e-b463-1351-b00640b0f67b@arm.com> <CALDTKqg01+xJ2xu218c_QH2PbX9wdhYOiJfDieCXL5PHWV-6FQ@mail.gmail.com>
 <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com> <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
 <20230614012102.GJ217089@leoy-huanghe.lan> <CALDTKqgz6=WFs=bMvnFkKv5kt5OP5wtUqQ2uekVbumCxNqeRXw@mail.gmail.com>
 <CALDTKqiy7h+SiCsUhpgFNzUoYUPdq3e8EpAEbDgcH3ePbGOV3w@mail.gmail.com> <20230618092806.GA245455@leoy-huanghe.lan>
In-Reply-To: <20230618092806.GA245455@leoy-huanghe.lan>
From:   =?UTF-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>
Date:   Sat, 1 Jul 2023 13:25:37 +0800
Message-ID: <CALDTKqivmdU4tFRyc99QUAbGSHG4ttzyuWN7wRRux9KrYdHa0w@mail.gmail.com>
Subject: Re: Some questions about using the perf tool in ARM-SPE
To:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo Yan

On our platform, I cannot enable too many NUMA configurations as it
would lead to build failures.
could this be the reason for c2c failure? If so, I will try to
identify which side is experiencing issues.

This is my platform config status. ccould support c2c?
user_shell:/data/local/tmp # zcat /proc/config.gz | grep NUMA
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
# CONFIG_NUMA is not set
CONFIG_DMA_PERNUMA_CMA=3Dy

> ./perf script --header -I
I think that's a key message.
# =3D=3D=3D=3D=3D=3D
# missing features: TRACING_DATA CPUDESC NUMA_TOPOLOGY BRANCH_STACK
GROUP_DESC STAT MEM_TOPOLOGY CLOCKID DIR_FORMAT (null) (null)
COMPRESSED CPU_PMU_CAPS CLOCK_DATA HYBRID_TOPOLOGY
# =3D=3D=3D=3D=3D=3D=3D=3D
#
Only instruction-based sampling period is currently supported by Arm SPE.

There are also many events related to L1d, TLB, and memory that are
displayed. If you require this information, I can provide it

         perf6.1  4725 [000]   129.779296:          1
                                                   l1d-access:
ffffffe012888f64 [unknown] ([unknown])

Many Thanks
Best Regards
Zack.
Leo Yan <leo.yan@linaro.org> =E6=96=BC 2023=E5=B9=B46=E6=9C=8818=E6=97=A5 =
=E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=885:28=E5=AF=AB=E9=81=93=EF=BC=9A

<http://www.avg.com/email-signature?utm_medium=3Demail&utm_source=3Dlink&ut=
m_campaign=3Dsig-email&utm_content=3Dwebmail>
=E4=B9=BE=E6=B7=A8=E7=84=A1=E7=97=85=E6=AF=92=E3=80=82www.avg.com
<http://www.avg.com/email-signature?utm_medium=3Demail&utm_source=3Dlink&ut=
m_campaign=3Dsig-email&utm_content=3Dwebmail>
<#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2>

>
> On Wed, Jun 14, 2023 at 02:08:36PM +0800, =E8=94=A1=E6=B2=85=E4=BF=A1 wro=
te:
> > "Fix mail to text modeFix mail to text mode"
> >
> > Hi,
> > How do I add NUME nodes (or CPU topology) to the kernel config?
>
> Below configurations are enabled in my testing kernel:
>
> root@leoy-huangpu:/home/leoy# zcat /proc/config.gz | grep NUMA
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
> CONFIG_NUMA_BALANCING=3Dy
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
> CONFIG_NUMA=3Dy
> CONFIG_ACPI_NUMA=3Dy
> CONFIG_NUMA_KEEP_MEMINFO=3Dy
> CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
> CONFIG_GENERIC_ARCH_NUMA=3Dy
> CONFIG_OF_NUMA=3Dy
> CONFIG_DMA_PERNUMA_CMA=3Dy
>
> > After I modified arm-spe.c. Snoop is working but Locked&Blocked&Local
> > INSTR Latency their results are always No&N/A&0
>
> I cannot understand this ... What's you have modified for arm-spe.c?
>
> If you don't share more complete perf log then it would be difficult to
> understand and locate issue.
>
> > I merged 3 Cluter into one and have been able to record the whole syste=
m.
> > user_shell:/sys/bus/event_source/devices/arm_spe_0 # cat cpumask
> > 0-7
>
> This seems to me fine to me.
>
> > On the c2c side:
> > user_shel:/data/local/tmp # ./perf c2c report -vvv
> > coalesce sort   fields: offset,iaddr
> > coalesce resort fields: offset,tot_peer
> > coalesce output fields:
> > cl_num_empty,percent_rmt_peer,percent_lcl_peer,percent_stores_l1hit,per=
cent_stores_l1miss,percent_stores_na,offset,offset_node,dcacheline_count,ia=
ddr,mean_rmt_peer,mean_lcl_peer,mean_load,tot_recs,cpucnt,symbol,dso,cl_src=
line,node
> > Failed setup nodes
>
> Before diving into "perf c2c" tool, please use "perf script" tool to
> decode the perf data file and check if you have captured any SPE trace
> data, and it's good to dump header info.  This would be useful to
> analyze the issie.
>
> $ ./perf script --header -I
>
> > On the other hand, the perf I use is statically compiled with the
> > aarch64 cross-compiler. I can't open all the features
>
> This would be fine.  At my side, I built perf statically on x86_64
> machine with the command:
>
> $ make LDFLAGS=3D-static NO_LIBELF=3D1 NO_JVMTI=3D1  VF=3D1 DEBUG=3D1 NO_=
LIBTRACEEVENT=3D1
>
> And then I copied the perf binary on my Arm64 machine, it works pretty
> well for Arm SPE.
>
> Thanks,
> Leo
