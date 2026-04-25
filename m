Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB4230BEC
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777120403; cv=pass; b=UGAoorYAQmfVvxEE53COjAOl+IoMH6w24FMYji66o5Wlh29CMluX8987bIcENa0HzTvl2/HeWX4PrTGJpPPWM0zxX1ChcKj2sM55rvSryoQ8JNMt8rwfjydM7DoCa8CtiiIeRR8VXgyFjSYk95hdXuODMhqIhK7LD9In3or2MB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777120403; c=relaxed/simple;
	bh=W5dPlWs+XG9nZfy5TnoKIlvfdFg2ADTJ2GTCqdJZktc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4WWwjWx6n4wXavvbtzgM0kG0/94gf0MD+ko28z7fkomHVtHHXNICH6oWEi0Vo/F7IxIPHD1BsoAz3AkC3/LR5YR2BEtpt9JgIbn/YrKHJfuWfXhnHR3lsKdeAIYOO8NjHmbHhQ2hpZngRHzRfAeAe+tHEospzds7Jt/vORVHpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/+Qt03O; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/+Qt03O"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a747448dso64333611cf.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 05:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777120399; cv=none;
        d=google.com; s=arc-20240605;
        b=ddKXv1mVv5S3P+WrwWOYIykEAWaqMGWFyP+4liEGQkYr18l7+JNgVNt5KNUUMjrnCx
         uFXYwhJRcHeaDH8MkZUebNmhs0Iih3nPZ65MaELuswUoDE8/sFMKWlWLPeomSQH0s6U2
         usOYZc2DCC5SisY4GvKwqSLDsF+0CxloIxtKFvcmx6KZNUA1FuhzFslsdpPD68GEQNkY
         73hpjCMFjzZ4egBWPPG0I7FiGh8JDfcvpickJh/HuU9tt4h5W/PDcglJuILG0xMyMsb+
         SKRLxIMcDRq/fx+IgSvAmBvSp9IkX/7NInMvjPw1W8bNmWr54JbQLpH5O3/+ltQm5B62
         XZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ftgocb40oPxcjjaNTJyGl+Q8Zs5puERTVT80QqciM/4=;
        fh=NCrk5MR5CuiPu5NxuDoGzZ+qWyaLcaI9GIfZHIBo6Mg=;
        b=eC/x1WTy3jDmPDNwQ7MInjLLmt1X6LbABE9cOHrvBMG61sZvjiCJZoSkp0j7VizVfl
         10LKZ0f4o75CJLwIzxMIc7/hIV/W/vpVgiThARa69cp7OeZ4Vj3VxbV2+tm/pgr60S9s
         bXQ2uoVRhaVvcxWcBeQKcUuz72yP1+EcDE/Hu34eMnLheKsS9HUYOvkVzAbxS5Zx5N8v
         SjbxmjCxcCXeHbq5bXtQxPnmf7GHmrFbLMgZNrfDQ/7KF2VDNXi2RZSxJZQ0aHVkiIQH
         rOMWLqkJ3ltMV0yMZo8oOv2gstIL8re70iQ2KPfBqvIrSWJG+TMcGDE6rM/VV+Ds3Zeo
         mEig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777120399; x=1777725199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftgocb40oPxcjjaNTJyGl+Q8Zs5puERTVT80QqciM/4=;
        b=l/+Qt03ORbErkIz+n5eRq4xC8M+UwHy0eT4Ni7didUqBzt8xy1y2Rzz2cuTe8kHNb/
         zoSlvMvx/vhEEvFWTBd11aDWVnvHMBbjfn8WDxIJMgY8FNxA23wGbEoQReByElJxtbF1
         WQsnFNAlivjSdrPJ2jG2PDJYXvPpUu/pd0w7gcmFyWCqPE8iWjWCN55AZ7qxmxuZ7I0T
         tawgMGNvHVptDBqTQ298jIte37plt8RGFqnzVuH4RBipY69nM+Wwve7VNmWSCjCRQSyA
         4FWhpC+0dmdC52p2XzNgz/tuhSbCiDC2njcIUeEssatOFoVbR0iv1dvjYst0ydHJM7P+
         kvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777120399; x=1777725199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftgocb40oPxcjjaNTJyGl+Q8Zs5puERTVT80QqciM/4=;
        b=hV6zyZxmmVmWZmhPvBOcvBKFdPdx8JfQ+3tkyBgDG/ZaqGe4h+ac10vKJi5m8kGAFZ
         B62hiQyDhf5Ot8SeOJOEGy4h2hHHOZV+4D/P0JfkCwM9fYlV4diJb1j1yanQj8dyDmaL
         5RL6WNLX3qZw6c+UEQV/Y8xJAlyd0d5k20sjtH2/635FooRxt6b/1+Iz417sS0LaZHJZ
         XkqufrdTIPOWbfVZ6Mey8ZgrcQHsXXxObWFT+kiKleSFdG4lezpkY6GkFcrYoOGi7tOJ
         nrLkaN9q71lFAIUIGEXwfAfgl0VJDTAJ5ks+wdZWyTqaUpsNsBieg1DKYP8rxv9/iABF
         lsmg==
X-Forwarded-Encrypted: i=1; AFNElJ/Z75F73y1b5IBXQ3jBDgJvQHkl6oCWDzawyVcOTthqZIixcNMtJY8ojaR7Hu9EmGcqBA3nnlGkdIUuSsfc+E6t@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ89tjE6GTClX5jytjNzuUnrZO4z5GYbZbWOqotSHELJ/QR9yh
	hHLQiXBLGgF4GWzJtHuX9N/xEL54XGr/1GQNZrSrEno8qS4tIDGFwTNJ2XQSTloJ8BePnc3EULo
	uTrEtb4kOS3rq7yB++WoHq4Kw7r0S+2I=
X-Gm-Gg: AeBDietTEMxVh2UUFdge0n/GgG8X7wSeGzQtvO5H44iaYHxEVUURH3hcLeZax2H8QS1
	k3SbSFl+JqZMGpVLjSUagb4GeGggvdmdCVmHvZyhODs+4Afradlp2NIR+75U2lw3NFA+CcrX9I6
	h7JAC/bpgHA5zDCGU4e7eHB+HwW1pjH4ay4C9q2V3EoED94zFUsfUrv0Tqm+jwmpgWqShMvvJyt
	T2zFgkBkNXfvK1k8Ano7PLiZDf2ReZExdUUQ9bO15a4HGokN4j+QGoRplFGOwdmtPBF4i6Se6DT
	wSKRv8fVgMq9W73C52fgmEkmvavWG6iQxDgIF+EAU65Bdg==
X-Received: by 2002:a05:622a:2513:b0:50e:6183:beea with SMTP id
 d75a77b69052e-50e6183c685mr377965061cf.23.1777120399039; Sat, 25 Apr 2026
 05:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC5umyiikHr4doYKW5Gy4uv6M0_HbBZUSd9kM+L+kCrKYKEuXw@mail.gmail.com>
 <20260424233136.6716-1-sj@kernel.org>
In-Reply-To: <20260424233136.6716-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 25 Apr 2026 21:33:07 +0900
X-Gm-Features: AQROBzDpdq2IBRfcCGSRDznfqt-u3WmGMUNbHZ7CJx35Af7LgQxOJzS7FHuggi8
Message-ID: <CAC5umyjcFm-iw31kgYP0Z61z7N=vMzkZKsvGZpYmNwNw3R_gHw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/4] mm/damon: introduce perf event based access check
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B44=E6=9C=8825=E6=97=A5(=E5=9C=9F) 8:31 SeongJae Park <sj@kernel=
.org>:
>
> On Fri, 24 Apr 2026 12:27:07 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > Hello SeongJae,
> >
> > 2026=E5=B9=B44=E6=9C=8823=E6=97=A5(=E6=9C=A8) 13:34 SeongJae Park <sj@k=
ernel.org>:
> > >
> > > Hello Akinobu,
> > >
> > > On Thu, 23 Apr 2026 09:42:06 +0900 Akinobu Mita <akinobu.mita@gmail.c=
om> wrote:
> > >
> > > > DAMON currently only provides PTE accessed-bit based access check, =
this
> > > > patch series adds a new perf event based access check.
> > > >
> > > > Since perf event-based access checks do not require modifying the P=
TE
> > > > accessed-bit for pages representing each damon region, it reduces t=
he
> > > > overhead of monitoring at a fixed granularity of the page size.
> > >
> > > As I also commented to the previous version, the high level idea make=
s sense to
> > > me.  I think this can be useful.
> > >
> > > Also as I commented to the previous version, I understand the page le=
vel
> > > monitoring overhead reduction is the main purpose of this patch, and =
it makes
> > > sense to me.  Nonetheless, I like this mainly because the perf event =
could
> > > provide more detailed information including from which CPU/thread the=
 access is
> > > made, and whether the access is for read/write, to my understanding. =
 Please
> > > let me know if my understanding is wrong.
> >
> > That's correct.
> > Once the integration into your new monitoring infrastructure is
> > complete, those things will become possible.
>
> Thank you for confirming!
>
> >
> > > >
> > > > Here is a method and its results for comparing access checks using
> > > > existing access bits and new perf events.
> > > [...]
> > > > Using accessed bit, prepare_access_checks takes 7 seconds and
> > > > check_accesses takes 5 seconds.
> > > [...]
> > > > Using perf event, prepare_access_checks takes 0.01 seconds and
> > > > check_accesses takes 2.6 seconds.
> > >
> > > Thank you so much for sharing these great test results with the detai=
led setup
> > > description!
> > >
> > > > ```
> > > > $ sudo $HOME/damo/damo stop
> > > > $ sudo $HOME/damo/damo start --ops vaddr \
> > > >       --perf_event 5000 0 0x4 0x1cd 0x1f 0 \
> > > >       --monitoring_intervals 5s 60s 300s \
> > > >       --monitoring_nr_regions_range 1000000000 1000000000 \
> > > >       --target_pid $(cat /tmp/memcached.pid)
> > > [...]
> > > > Note: damo's --perf_event option
> > > >
> > > > Using these features also requires modifications to damo, but these
> > > > are not included in this patch series and are currently under
> > > > development in the following branch:
> > > >
> > > > * https://github.com/mita/damo/tree/damo-perf-for-v3.2.2
> > >
> > > Thank you for sharing this, too!
> > >
> > > >
> > > > The option newly added to damo for perf event-based access check ha=
s the
> > > > following format:
> > > >
> > > > `--perf_event <sample freq> <sample phys addr> <type> <config> <con=
fig1> <config2>`
> > >
> > > I think we may need to discuss more for final interface.  But I think=
 that
> > > could be done later, after the kerenl ABI is fixed.
> >
> > My current patch introduces a set of kernel ABIs (.../perf_events/<P>/*=
),
> > and if I want to control another field in the perf_event_attr,
> > I would have to add a new ABI. This would be a significant
> > maintenance cost.
> >
> > Instead, I would like to provide a single bin file where the
> > perf_event_attr I want to set is written as binary.
>
> I'd prefer having single file per parameter, as sysfs is designed for.  I=
t
> allows keeping the input format simple and therefore easy to maintain and
> extend.  Of course, we should carefult at adding new parameters, though.

Another idea from Namhyung Kim [1] is to fix the events
specified by the CPU architecture being executed.

Of course, we would want to control a limited number of
parameters, such as sample_freq.

[1] https://lore.kernel.org/damon/aZwLDAxf9eP0lPdD@z2/

> >
> > > >
> > > > - `sample freq`: A higher frequency improves access accuracy, but a=
lso
> > > >   increases overhead.
> > > > - `sample phys addr`: specify 0 for vaddr and 1 for paddr.
> > > > - The remaining type, config, config1, and config2 settings can be =
found
> > > >   as follows:
> > >
> > > The values look bit human-unfriendly.  I wonder if we could use more
> > > human-friendly values, e.g., 'cpu' for type,
> > > 'mem_trans_retired.load_latency_gt_1024' for config, etc.  Not necess=
arily we
> > > need to fix this right now.  Let's keep discussing.
> >
> > I'd like to do it that way. These processes can be handled better
> > from user space than from within the kernel, so I'd like to achieve
> > this from damo with the help of the perf tool and library.
>
> Does existing perf event ABI also take that approach?  If so, I think tha=
t is
> fine.

On Intel CPUs, you can read the mem-loads and/or mem-stores
files as follows to find the value that should be set to
perf_event_attr:

$ cat /sys/bus/event_source/devices/cpu/events/mem-loads
event=3D0xcd,umask=3D0x1,ldlat=3D3

You can find out which bit field of which member of
perf_event_attr should be used to set these values from the
corresponding files in the format directory.

$ cat /sys/bus/event_source/devices/cpu/format/{event,umask,ldlat}
config:0-7
config:8-15
config1:0-15

This conversion from symbolic event name to values that should
be set in perf_event_attr can be done, for example, as shown below,
so I think it should be implemented using perf in some way.

import perf

if __name__ =3D=3D '__main__':
    evlist =3D perf.parse_events("mem-loads")
    for evsel in evlist:
        print(f"{evsel}: type=3D{evsel.type} config=3D{evsel.config}")
