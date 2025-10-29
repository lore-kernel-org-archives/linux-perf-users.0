Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6172EC56D
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755166; cv=none; b=BD5u3580Yk5iGvIHzE9wzZ8qoVC9GbzDyBrTDMV102C/dgAI3wQo+yCR+eNAOlD4O8CYyuSyMxIx3wrSaSrj/zd1/Xi/yOTf55MlGg9eGolwxNZ83qCMslzS0USTphZw1VjUyqw73D2MC8ZzK1L0386RP6dURZce7RUt5yMtA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755166; c=relaxed/simple;
	bh=uS3mSxTQ6C/PIAkVzcpaQUTosNV7h2QI+JFbTaee4hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6+OczkKSuqc5Jgx9xVsPL7Q7AdwAqIHrKH1ca7O9XygAA+0KfNViVqxo0jlaaU/zRg9QHAF/F0sQiKBblWbv6aKDWn51d+gjlNXe0fwM2IjdVsAmJ+u0DycBvMOCnAMAdQQDgUcafBxt+gcmM4G/4i/NBLYxGj/M3BWes2TUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zm1KnPAA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zm1KnPAA"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27eeafd4882so262065ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761755164; x=1762359964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkrDz7763tHjWxGWwBj78bmOlQLD3Xq/Qp4yr3NJWEM=;
        b=zm1KnPAA/FqZeD3KISrzSMzwa9+3vhHCGc5/pl0nSru6VKDnt9+JzxzYEzNY+hil1C
         awt+/wiI/JT2ALmvrIsFPCIABHmHd5xgUO6CQ81Sx6gTSgWxHAa6HfK2CpznzbRE+bea
         8qh/2A2dDlrH9hKh1LdWhmO28CZfFee+HRTAalkWUMDf/5NHx3+8aAbbNF+8FD1uwQp5
         kAdqBitPkoNHJoBEygaDPOG6WlGV0vQzN6FGNxJkywLIamedvw+Kz0wjQ7B0Ilk29K4/
         jKcWiAV5rbev+PYEMOpJBJGr1+Hsm/uz1hBk6B1FoapsnUyzEuQPEbgbRgz9ZLo9W4fz
         hijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755164; x=1762359964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkrDz7763tHjWxGWwBj78bmOlQLD3Xq/Qp4yr3NJWEM=;
        b=wWGVeNEWmScB+W5eLQaq9YACBDsgV1zPwU2smN2Pu6OvIHGpsGxRPTG1DJot6rhfN7
         I91PtgHmD1gZZkm0eXjw8qlqhb9K4SAt4sr0InVpVrvAHi5142wyLQqPQ5jim+9Glvdy
         H0+CUC1CpTigylcn1998OeZ5XdAGbqp95ZHPGtMEG/JU+lW2kK16+aoQmR186I08CYoU
         HEKMtk3uqzrdnI8Ds683Z8TAC/wGIEfz+Ewm7Z6DQFdh8UWyFCVcr3iTWA0YqJ4AzGbY
         9gBufjnJ/Kkw8f6ZlPeL0XpDm3J7HyeiMkQs1iSHmoMqir29Osw5MWuKq+XJWv8jyrpv
         eraQ==
X-Gm-Message-State: AOJu0YwFwYLN6/AUh6e17SiNTUTSG9ZkGgE2JBVGxf0nYDC9F6WeME1L
	BeB3s5+grGmgbegaqOH3JFRLv3NQGhzvQG6Q5Q0vKYeqKRN8uplrSHZ4i/3YWiYLEZZ3S0SLxN6
	FcxaBXAqWliMecyMx1aUW808hvzo5QBEZcaPdFOW1
X-Gm-Gg: ASbGnctGLrQEfzrxRPMroAoxhVe/3lbWa7/WoJddQAOEn6zTd8YXFutI5VqQO4jOyRa
	PJvY/zB5w6y234mvjFf+nDGGbApm2uwl6MXcSe6J1m2qd+OjmSSSlbQ+vRuOJE1oM5ifsPk+Ds8
	bfhQuwo3XajCbUnZWmgdttLCSrASZqkEGyqRew7Et5PU+PoTQM4XfNHlhD0hez6Uhk+fCppP6jZ
	SU9bknhX1kbZRoUDcna33EgPNOgPjMej7iTBmR4R5UkQZgH4SnH4Nx7uTDYkEQsa8sGTJybt4Bx
	wN0etGlfwSDk4Bs=
X-Google-Smtp-Source: AGHT+IFz2HpvjVEub9B+nM/D2UULab8FiNUT7eYNhjZUB5uX7MWMUZkSXvSvi9+IgkHFz1faTgdFEgOPHKHdUcGwZT0=
X-Received: by 2002:a17:903:1107:b0:290:d7fd:6297 with SMTP id
 d9443c01a7336-294de368a80mr5995365ad.2.1761755163312; Wed, 29 Oct 2025
 09:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
 <CAP-5=fU7zGF90yPyPhNUKqZp6zvynjZ_fQd_+x4hB6+KFumrhg@mail.gmail.com> <219af201-12d4-4700-8d84-575969f83f0e@linux.ibm.com>
In-Reply-To: <219af201-12d4-4700-8d84-575969f83f0e@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Oct 2025 09:25:52 -0700
X-Gm-Features: AWmQ_bk7h50diC9F5nRpf5MjjMK2qGZsQXl4pCnluRs2emgcberIHri0isxA4s4
Message-ID: <CAP-5=fWq90oMw6KfTv0zB8Cfr=BcCdO5V5jxRYx25ks-hO7PJw@mail.gmail.com>
Subject: Re: [linux-next] perf report runtime extremely long
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:52=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 10/29/25 16:13, Ian Rogers wrote:
> > On Wed, Oct 29, 2025 at 1:04=E2=80=AFAM Thomas Richter <tmricht@linux.i=
bm.com> wrote:
> >>
> >> Hi all,
> >>
> >> has something changed recently in perf report in linux-next repo?
> >>
> >> I run perf report -i <file> -D | grep something
> >> on s390 with 2 different kernels:
> >>
> >> master 6.18.0rc3:
> >> # uname -a
> >> Linux a35lp67.lnxne.boe 6.18.0-rc3m-perf+ #23 SMP Tue Oct 28 15:53:44 =
CET 2025 s390x GNU/Linux
> >> # ll /tmp/perf2-eSso2q-2
> >> -rw------- 1 root root 8538184 Oct 29 08:44 /tmp/perf2-eSso2q-2
> >> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/=
null
> >>
> >> real    0m22.262s
> >> user    0m22.068s
> >> sys     0m0.200s
> >> #
> >>
> >> This runtime is ok for the perf.data file size.
> >>
> >> linux-next:
> >> # uname -a
> >> Linux s83lp47.lnxne.boe 6.18.0-20251028.rc3.git141.f7d2388eeec2.63.fc4=
2.s390x+next #1 SMP Tue Oct 28 20:06:13 CET 2025 s390x GNU/Linux
> >> #ll /tmp/perf2-eSso2q-2
> >> -rw-------. 1 root root 8538184 Oct 29 08:47 /tmp/perf2-eSso2q-2
> >> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/=
null
> >>
> >> real    2m53.601s
> >> user    2m52.938s
> >> sys     0m0.575s
> >> #
> >>
> >> Same perf.data file and run time increased from 22 seconds to nearly 3=
00 seconds, roughly 14 times longer
> >> for the same input!
> >>
> >> Has anybody similar observations?
> >
> > So there were changes relating to addr2line that could impact this:
> > https://lore.kernel.org/lkml/20251005212212.2892175-1-irogers@google.co=
m/
> >
> > There was also the switch to always using build IDs:
> > https://lore.kernel.org/lkml/20250724163302.596743-1-irogers@google.com=
/
> >
> > Any chance you could do a `perf record`/`perf report` to see where the
> > time is going?
> >
> > Thanks!
> > Ian
>
> Ok here is a first try, can do more tests tomorrow morning.
> The file perf1.data has this size:
>
> root in =F0=9F=8C=90 s83lp47 in ~
> =E2=9D=AF ll perf1.data
> -rw-------. 1 root root 99692290 Oct 29 16:17 perf1.data
>
> root in =F0=9F=8C=90 s83lp47 in ~
> =E2=9D=AF
>
> time perf record -- perf report -i perf1.data -D > /dev/null
> ^C[ perf record: Woken up 6 times to write data ]
> [ perf record: Captured and wrote 2.742 MB perf.data (70481 samples) ]
> Terminated
>
> real    13m9.894s
> user    13m6.583s
> sys     0m2.449s
>
> root in =F0=9F=8C=90 s83lp47 in ~ took 13m9s
> =E2=9D=AF perf report --stdio
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 70K of event 'cpum_cf/cycles/P'
> # Event count (approx.): 88101250000
> #
> # Overhead  Command  Shared Object      Symbol
> # ........  .......  .................  .................................=
.................................................
> #
>     26.67%  perf     libc.so.6          [.] __printf_buffer
>     12.43%  perf     libc.so.6          [.] __GI___strnlen
>     12.30%  perf     libc.so.6          [.] __strstr_vx
>     11.92%  perf     perf               [.] perf_pmu__for_each_event
>      7.46%  perf     libc.so.6          [.] __printf_buffer_write
>      5.48%  perf     libc.so.6          [.] memcpy
>      5.13%  perf     libc.so.6          [.] __GI___strchrnul
>      3.25%  perf     libc.so.6          [.] __vfscanf_internal
>      2.61%  perf     libc.so.6          [.] strchr
>      2.39%  perf     libc.so.6          [.] __vsnprintf_internal
>      2.19%  perf     libc.so.6          [.] __printf_buffer_done
>      2.03%  perf     perf               [.] perf_pmu__is_tool
>      1.14%  perf     libc.so.6          [.] __snprintf_chk@@GLIBC_2.4
>      1.05%  perf     perf               [.] get_counter_name_callback
>      0.73%  perf     libc.so.6          [.] __GI_____strtoull_l_internal
>      0.60%  perf     libc.so.6          [.] memcmp
>      0.28%  perf     libc.so.6          [.] _IO_str_init_static_internal
>      0.19%  perf     libc.so.6          [.] strlen


Looks like the time is in s390-sample-raw.c but I don't see recent
changes there:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/log/tools/perf/util/s390-sample-raw.c?h=3Dperf-tools-next

I wonder for the scanf if the following would help:
```
diff --git a/tools/perf/util/s390-sample-raw.c
b/tools/perf/util/s390-sample-raw.c
index a2d6a1f93cce..21edd359a43a 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -140,8 +140,9 @@ struct get_counter_name_data {
static int get_counter_name_callback(void *vdata, struct pmu_event_info *in=
fo)
{
       struct get_counter_name_data *data =3D vdata;
-       int rc, event_nr;
+       int event_nr;
       const char *event_str;
+       char *end_ptr;

       if (info->str =3D=3D NULL)
               return 0;
@@ -150,8 +151,8 @@ static int get_counter_name_callback(void *vdata,
struct pmu_event_info *info)
       if (!event_str)
               return 0;

-       rc =3D sscanf(event_str, "event=3D%x", &event_nr);
-       if (rc =3D=3D 1 && event_nr =3D=3D data->wanted) {
+       event_nr =3D strtol(event_str + 6, &end_ptr, /*base=3D*/16);
+       if ((end_ptr !=3D event_str + 6) && event_nr =3D=3D data->wanted) {
               data->result =3D strdup(info->name);
               return 1; /* Terminate the search. */
       }
```

ah, new email, let me follow up further there.

> Hope this helps
>
> Kind regards
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
