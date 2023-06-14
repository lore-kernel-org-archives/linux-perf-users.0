Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C8AEB64D8
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 06:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjFNGIu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 02:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjFNGIu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 02:08:50 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52CBE55
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 23:08:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-543b599054dso3897705a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 23:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686722928; x=1689314928;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW5RSxg1bAZIjXG+IdtBv2yBJUUKZoGRtHpytMyQG8c=;
        b=pk8fudp2QEkbH0KmqLfnYiqyggwEE8MpAuYb+SOIVqWZhWwpfXfo3ddutp7KpTMsv/
         VAFxsMdZaw0y414m1gGkvcha6zwGvrowaO58VnwVEsEvNNxEFQoZmX4FBep8+aqkQ+fW
         AjoazfZmkDmL7cMZxMgGq7b2jJ4HL/oZ4bRpPIdNRUpOL7b2VQE3hI98ExPRIF5T2f3q
         OtX/7XV9FgaUuFOOp0mFQbrz6pGunlWM4KBs93PrKqa73g0rBtoJ2+jcue7+woFZHVUl
         V6eTICBnMzvSkeB64EBaPi7N0P7ctxUAZdF1W0vqg2e7id/ICvHOBErd8Y/5agfKXLb7
         ZSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686722928; x=1689314928;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW5RSxg1bAZIjXG+IdtBv2yBJUUKZoGRtHpytMyQG8c=;
        b=Hl0FWM+E1o8UXvT/IrVOE8LX3HFUijtr3fpSfFzH7suur8pG8cahghlg26UQt70n8Y
         G+EUBucfvPSKgNw7ANdUF85sV6oO6UrbOADkAbxjf1J1NtmYsnzmJNhYPNk0y/stoXcP
         wpfN+b8skHV9fA65+dQ6y47UaKGlzO6zPIDMx2QX/xIgjkuytvlb+5B7xAxZc+tjXaeh
         bbrTTcgGvXlNyd1jrntBfFjzwyyJXYHf8lcz4gGu2XO88eLbXL6cLJybCr6B3VLGvryw
         6gmowpmcIygaC62LQdc77Cp26qRi5/6bZ36UqvPeApkxviAAy2jdHp8sBsCb0/+Z+s3T
         W4cw==
X-Gm-Message-State: AC+VfDxl4CvVg265hz0z8GbpXyirJHnThm2RHgfAzsiLiIk3igvVEfVI
        A+ekTGmE/VA3q2Ah36gkmPFmjZs3BYGtk/Kr7g4=
X-Google-Smtp-Source: ACHHUZ6dAaE1dCXYnH3hocAo+EY5wwsEYZfrC3+/MtnJ30uUUeqkcNASSL1q5Tia2ppHj9PZxFAff0d/NpDt9f/feGY=
X-Received: by 2002:a17:90a:d381:b0:25b:c172:8a85 with SMTP id
 q1-20020a17090ad38100b0025bc1728a85mr834462pju.17.1686722927870; Tue, 13 Jun
 2023 23:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
 <874963e2-f97e-b463-1351-b00640b0f67b@arm.com> <CALDTKqg01+xJ2xu218c_QH2PbX9wdhYOiJfDieCXL5PHWV-6FQ@mail.gmail.com>
 <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com> <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
 <20230614012102.GJ217089@leoy-huanghe.lan> <CALDTKqgz6=WFs=bMvnFkKv5kt5OP5wtUqQ2uekVbumCxNqeRXw@mail.gmail.com>
In-Reply-To: <CALDTKqgz6=WFs=bMvnFkKv5kt5OP5wtUqQ2uekVbumCxNqeRXw@mail.gmail.com>
From:   =?UTF-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>
Date:   Wed, 14 Jun 2023 14:08:36 +0800
Message-ID: <CALDTKqiy7h+SiCsUhpgFNzUoYUPdq3e8EpAEbDgcH3ePbGOV3w@mail.gmail.com>
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

"Fix mail to text modeFix mail to text mode"

Hi,
How do I add NUME nodes (or CPU topology) to the kernel config?
After I modified arm-spe.c. Snoop is working but Locked&Blocked&Local
INSTR Latency their results are always No&N/A&0


I merged 3 Cluter into one and have been able to record the whole system.
user_shell:/sys/bus/event_source/devices/arm_spe_0 # cat cpumask
0-7



On the c2c side:
user_shel:/data/local/tmp # ./perf c2c report -vvv
coalesce sort   fields: offset,iaddr
coalesce resort fields: offset,tot_peer
coalesce output fields:
cl_num_empty,percent_rmt_peer,percent_lcl_peer,percent_stores_l1hit,percent=
_stores_l1miss,percent_stores_na,offset,offset_node,dcacheline_count,iaddr,=
mean_rmt_peer,mean_lcl_peer,mean_load,tot_recs,cpucnt,symbol,dso,cl_srcline=
,node
Failed setup nodes


On the other hand, the perf I use is statically compiled with the
aarch64 cross-compiler. I can't open all the features
Auto-detecting system features:
...                                   dwarf: [ OFF ]
...                      dwarf_getlocations: [ OFF ]
...                                   glibc: [ on  ]
...                                  libbfd: [ OFF ]
...                          libbfd-buildid: [ OFF ]
...                                  libcap: [ OFF ]
...                                  libelf: [ OFF ]
...                                 libnuma: [ OFF ]
...                  numa_num_possible_cpus: [ OFF ]
...                                 libperl: [ OFF ]
...                               libpython: [ OFF ]
...                               libcrypto: [ OFF ]
...                               libunwind: [ OFF ]
...                      libdw-dwarf-unwind: [ OFF ]
...                                    zlib: [ OFF ]
...                                    lzma: [ OFF ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ OFF ]

Does it affect the results?

Many Thanks
Best Regards
Zack.


=E8=94=A1=E6=B2=85=E4=BF=A1 <fissure2010@gmail.com> =E6=96=BC 2023=E5=B9=B4=
6=E6=9C=8814=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:06=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hi,
> How do I add NUME nodes (or CPU topology) to the kernel config?
> After I modified arm-spe.c. Snoop is working but Locked&Blocked&Local INS=
TR Latency their results are always No&N/A&0
>
>
> I merged 3 Cluter into one and have been able to record the whole system.
> user_shell:/sys/bus/event_source/devices/arm_spe_0 # cat cpumask
> 0-7
>
>
>
> On the c2c side:
> user_shel:/data/local/tmp # ./perf c2c report -vvv
> coalesce sort   fields: offset,iaddr
> coalesce resort fields: offset,tot_peer
> coalesce output fields: cl_num_empty,percent_rmt_peer,percent_lcl_peer,pe=
rcent_stores_l1hit,percent_stores_l1miss,percent_stores_na,offset,offset_no=
de,dcacheline_count,iaddr,mean_rmt_peer,mean_lcl_peer,mean_load,tot_recs,cp=
ucnt,symbol,dso,cl_srcline,node
> Failed setup nodes
>
>
> On the other hand, the perf I use is statically compiled with the aarch64=
 cross-compiler. I can't open all the features
> Auto-detecting system features:
> ...                                   dwarf: [ OFF ]
> ...                      dwarf_getlocations: [ OFF ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ OFF ]
> ...                          libbfd-buildid: [ OFF ]
> ...                                  libcap: [ OFF ]
> ...                                  libelf: [ OFF ]
> ...                                 libnuma: [ OFF ]
> ...                  numa_num_possible_cpus: [ OFF ]
> ...                                 libperl: [ OFF ]
> ...                               libpython: [ OFF ]
> ...                               libcrypto: [ OFF ]
> ...                               libunwind: [ OFF ]
> ...                      libdw-dwarf-unwind: [ OFF ]
> ...                                    zlib: [ OFF ]
> ...                                    lzma: [ OFF ]
> ...                               get_cpuid: [ OFF ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ OFF ]
>
> Does it affect the results?
>
> Many Thanks
> Best Regards
> Zack.
>
>
> Leo Yan <leo.yan@linaro.org> =E6=96=BC 2023=E5=B9=B46=E6=9C=8814=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:21=E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> Hi,
>>
>> On Tue, Jun 13, 2023 at 09:23:33PM +0800, =E8=94=A1=E6=B2=85=E4=BF=A1 wr=
ote:
>> > OK
>> > I have a new discovery that c2c seems to support only certain Arm
>> > Neoverse (N1/N2/V1) CPUs, I wonder if cortex-X4 could support it?
>>
>> Based on Cortex-X4 TRM [1], we can see Cortex-X4 has the same SPE data
>> source packet format with Neoverse CPUs.  In theory, we can add
>> Cortex-X4's MIDR into the neoverse_spe[] array in
>> tools/perf/util/arm-spe.c to support Cortex-X4.
>>
>> Linux master branch misses the definition for Cortex-X4's MIDR [2],
>> Mark.R / Suzuki / James, could you confirm if Arm has plan or already
>> has patches for enabling Cortex-X4's MIDR?
>>
>> Come back to your current issue, as James said, seems the issue is
>> related with NUMA (or CPU topology) which is missed in your kernel
>> config, it's very unlikely related with CPU type, even Cortex-X4 is not
>> supported, perf should still work for SPE packets except data source
>> packet.  But your shared log is not related with decoding, anyway, you
>> can try below change to rule out if the issue is related with CPU type:
>>
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index 7b36ba6b4079..3c3a3846f253 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -527,6 +527,7 @@ static u64 arm_spe__synth_data_source(const struct a=
rm_spe_record *record, u64 m
>>         else
>>                 return 0;
>>
>> +       is_neoverse =3D 1;
>>         if (is_neoverse)
>>                 arm_spe__synth_data_source_neoverse(record, &data_src);
>>         else
>>
>>
>> [1] https://developer.arm.com/documentation/102484/0001/Statistical-Prof=
iling-Extension-support/Statistical-Profiling-Extension-data-source-packet
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/arch/arm64/include/asm/cputype.h
>>
>> > Using the Arm Statistical Profiling Extension to detect false
>> > cache-line sharing | Blog | Linaro
>> >
>> > Thanks
>> > Zack
