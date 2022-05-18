Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7FAC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 15:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbiERPpj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 11:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbiERPpf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 11:45:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23775119079
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 08:45:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h14so3293481wrc.6
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mankpT0qhfJliBtK0SpBsLvfcP0ytrX/m7evD5LkHn4=;
        b=LSf1hFiKQlapl7Jh4X2H8fYckourCeiLbaZnI0DItQBbl4TJ7HikJHvamSJLbypmOr
         d2R1oxUJWgwpYCftx38GjVO+UElGpji0h1eduMlOV4yTA3OUsPILAUHySCmkvtwQ+TLF
         dv8YnsTEV8ldIcejQyUI4BpaxR0S8G84d38JRSZ2iHyYGIihgpYDUR1Mj88S6Oxq7Qbs
         IvwQZbAArz+R33OSTELYDS2ezQVBD6ZVQxI1DNC+zTIeI9LjaRdX5LhHuw+vFC/2UVCp
         hSfwsgojaZHLKZhaS5+GaQaLqwZesBilPkYYI70VClRlEZ1/g8TTfk1//TMti3SgHozw
         4qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mankpT0qhfJliBtK0SpBsLvfcP0ytrX/m7evD5LkHn4=;
        b=ZnMKTNBBi5R+xr28x1wCAkRL3G3E89wP3yxLNG2UoCx80hW4ct4rH7D2uWQYenPu4e
         oQalWVpVxkxl/3prFhyMNc4iOhpGRwE598CnKt7EZf/alw82AwFkWp04MtaMEn0K6OSF
         ElYhx7Y3hT/5RixyKfWz6Y0tgI2RmLkecL9Wo64Se+77YrJILFyfWYn3PYwjoIfPK+GZ
         TcVP6GyJrUzpcSqXxKkdTyd1AvBPhtfXf0PCp5PwZw857YBI/HkEABTYhTA6namA9J8o
         Cw4/vWzVKXbjfdMS4ftB/4UtPc4DOYvipI4EBGqVoAjDmPeHVkql3TQgU0b5ZMrWErr8
         +BQA==
X-Gm-Message-State: AOAM531ABer/f7DuQcItjoQXMAJ31fC4OKD6vH337PZkXrVuhOTlu8Ag
        X68wIjdkhM0Loq2RmiBRMdGXp7I3FhIJlvQE/ZbWow==
X-Google-Smtp-Source: ABdhPJy6LJ3aYGbc85/ijTBXKgddvabE1RGgigwM/NtZTFnvkfSsKXF1IhRWkhIjIsDceaW32z+8n7xVJJKEWuhKyJ8=
X-Received: by 2002:a5d:448d:0:b0:20d:744:7663 with SMTP id
 j13-20020a5d448d000000b0020d07447663mr276212wrq.654.1652888732345; Wed, 18
 May 2022 08:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.20.2205180047230.29735@Diego> <CAP-5=fU=kydiXW2Q_zc21dywD-wPWtwA8-dvcnu-e0VzOch_Hg@mail.gmail.com>
In-Reply-To: <CAP-5=fU=kydiXW2Q_zc21dywD-wPWtwA8-dvcnu-e0VzOch_Hg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 08:45:20 -0700
Message-ID: <CAP-5=fWQR=sCuiSMktvUtcbOLidEpUJLCybVF6=BRvORcDOq+g@mail.gmail.com>
Subject: Re: perf stat report segfaults
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     Arnaldo de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Resending with corrected linux-perf-users mailing list address.

Thanks,
Ian

On Wed, May 18, 2022 at 8:43 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, May 18, 2022, 12:41 AM Michael Petlan <mpetlan@redhat.com> wrote:
>>
>> Hello Ian.
>>
>> I have been rebasing perf in RHEL to v5.17 and I have hit the following
>> problem:
>>
>> # perf stat record -- ls
>> [...]
>> # perf stat report
>> Segmentation fault (core dumped)
>>
>> Investigation led me to your patch:
>>
>> commit 7ac0089d138f80dcd7ba8ca368a9b2bdfe780b16
>> Author: Ian Rogers <irogers@google.com>
>> Date: Tue Jan 4 22:13:38 2022 -0800
>>
>>   perf evsel: Pass cpu not cpu map index to synthesize
>>
>> This results in that perf_event__synthesize_stat()'s second argument
>> is -1 instead of 0 before.
>>
>> With that, the cpu field is stored as ff ff ff ff, as you can see in the
>> raw report:
>>
>> -1 -1 0x630 [0x30]: PERF_RECORD_STAT
>> ... id 9597, cpu -1, thread 1
>> ... value 3431216, enabled 3431216, running 3431216
>> : unhandled!
>>
>> 0x660 [0x30]: event: 76
>> .
>> . ... raw event: size 48 bytes
>> .  0000:  00 00 00 4c 00 00 00 30 00 00 00 00 00 00 25 7e  ...L...0.....=
.%~
>> .+>0010:  ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 36  .............=
..6
>> .| 0020:  00 00 00 00 01 44 6e 89 00 00 00 00 01 44 6e 89  .....Dn......=
Dn.
>>  |
>>  here
>>
>> This value is later loaded and used as an index to xyarray in libperf, w=
hich
>> causes the segfault.
>
>
> Thanks for reporting this and sorry for the breakage! This kind of proble=
m is something I've been trying  to fix. Basically perf has cpu maps that a=
re sorted arrays of CPU numbers. For a counter that is available on every C=
PU this gets reported as say [0,1,2,3] on a 4 CPU system. Some counters are=
 available on fewer CPUs, for example my 2 socket skylake machine has a mem=
ory controller counter with a cpu map of [0,18]. The indices into the CPU m=
ap are more densely encoded than just using the CPU number, so rather than =
have arrays (for things like file descriptors, saved values, etc.) sized by=
 the number of CPUs they are sized by the CPU map size and indexed using th=
e CPU map index. The problem I've been trying to fix is when the code has i=
nadvertently swapped the two values. This can work if the CPU map has an en=
try for every CPU in the system, but fails for say my Skylake memory contro=
ller.
>
> In your example here the CPU value of -1 is a special "any" CPU marker th=
at is described in the perf_event_open man page. When trying to work out th=
e intent of the code in fixing CPU vs index I'd push the value through the =
API and try to use an intention revealing name, so typically cpu_map_idx. I=
n this case this appears to have been done on the writing side but not on t=
he reading side.
>
>> This is my "hotfix":
>>
>> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>> index 817a2de264b4..b6ca193ff972 100644
>> --- a/tools/perf/util/stat.c
>> +++ b/tools/perf/util/stat.c
>> @@ -472,9 +472,10 @@ int perf_stat_process_counter(struct perf_stat_conf=
ig *config,
>>  int perf_event__process_stat_event(struct perf_session *session,
>>                                    union perf_event *event)
>>  {
>> -       struct perf_counts_values count;
>> +  struct perf_counts_values count, *ptr;
>>         struct perf_record_stat *st =3D &event->stat;
>>         struct evsel *counter;
>> +       int cpu =3D st->cpu;
>>
>>         count.val =3D st->val;
>>         count.ena =3D st->ena;
>> @@ -486,7 +487,9 @@ int perf_event__process_stat_event(struct perf_sessi=
on *session,
>>                 return -EINVAL;
>>         }
>>
>> -       *perf_counts(counter->counts, st->cpu, st->thread) =3D count;
>> +       if (cpu =3D=3D -1) cpu =3D 0;
>> +       ptr =3D perf_counts(counter->counts, cpu, st->thread);
>> +       if (ptr) *ptr =3D count;
>>         counter->supported =3D true;
>>         return 0;
>>  }
>>
>>
>> It needs to be reworked, but checking whether perf_counts() returns
>> not-NULL pointer is necessary anyway.
>>
>> My question here is what the -1 actually means and whether I can simply
>> do "if (cpu =3D=3D -1) cpu =3D 0;", since the data lies on "offset" 0 an=
yway,
>> even when it's recorded by perf with your patch...
>
>
> So I'd rather this wasn't fixed this way. The "cpu" here is really a cpu_=
map_idx, we need to work backward to make sure that is the case. To try to =
make this safer I created a struct perf_cpu to disambiguate indices from CP=
U values. When we load the -1 from the file we need to turn it into an inde=
x using the cpu map. As the array is sorted the index will always be 0, but=
 it would be nicer to use perf_cpu_map__idx [1] to show we're translating f=
rom what to what and how it relates to a particular cpu map.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/t=
ools/lib/perf/include/internal/cpumap.h?h=3Dperf/core#n27
>
>>
>> I think the -1 comes from perf_event_open syscall, where cpu =3D=3D -1 m=
eans
>> all cpus. Am I right?
>
>
> Yep, I'm trying to distinguish "all" from "any". On a 4 CPU system all wo=
uld be [0, 1, 2, 3] while any would be [-1].
>
>>
>> In your opinion, what should be done to fix this problem the best way?
>
>
> Notes above but I'll also try to take a look at this using your very simp=
le reproducer (which should definitely be a test).
>
> Thanks,
> Ian
>
>>
>> Thank you.
>> Michael
