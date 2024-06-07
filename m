Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B992581
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Jun 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717720575; cv=none; b=MRzPCQQn3X/+wIUsgAInIWKxKK2caldpTILM14KL7GJVRfGizV7CsPWjZi9bf29lzOfh+PFpUpze7GKa1c2LQjXw/QQZyZNyufeqOYl6W1zSt7q2VTeNOBsMxD2jD1lBankT/t6603lCryy06yf84ZhFRdR/PQ2MCB9qX9PqgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717720575; c=relaxed/simple;
	bh=5OqyPGAWcLAMGNIfJnhVZDWU5ams7Yoy+WMQhugY7sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoC6QeP2Oiud12xt71YLldf7fA0sZtRgPIqTYurQthcohtzjnSgH8ncQy16C0Hvl2yNxq5sdo/oRd2YqgnXZpAJXPTWreVYnCpGzfzvmgJgBfwT+Vmpwu+WhLK7oeYotGnZwxGDmpx53wSQk/dhyhlpkfIRf4dZIHxp2GRPvFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tnmo3UAq; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnmo3UAq"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3748a9fa84fso51585ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jun 2024 17:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717720573; x=1718325373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdR34JcM3yQUUFZUVMjolu0atN77DJIEKaKiwh3qFBA=;
        b=tnmo3UAqcUAJfhEeP83YqbPmDzI3H/qzVo25rFFv1EISbgutFukWUKAaajXrjwYLKp
         zfAuV/98WQy+QO8J8SWG3/Pfm71UT8fumWEuLystqSFz/IP8SQy+k6b9H5PHp1eXyqPp
         YuNzWDdEPnaXoaQiiQninVEpSrdWBmIDf5eqiUwQMtlceEDa0jkSDx7w5PbmW4zigBPf
         X0urGHDri2uSf/rSHeh8AN2HA+kCCItyyPj2TXfs+ZluHQ3rNdLPy+Y0MqnepDq0WjRy
         pa1QOCIuJ4UIJPvMMdV86sG//BxJaYVs/pt3LsovKnWU4EKUkYwEnSXgsNAxKaS2ie0f
         zD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717720573; x=1718325373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdR34JcM3yQUUFZUVMjolu0atN77DJIEKaKiwh3qFBA=;
        b=lPmFo+U4rrv/i5BYwkhOmvL/4QipRp88oFVhI3RptSLDXhsaRVovfzG2D1DcNJRptT
         NIEt8248DJ/sZTEHEz0h3V7//e4lDW3SkX8+VTLIrVlo9IIazGPGaVXk7Q74a9UX3+5a
         cjCL5oCZiJsNpHceayZ11ntAA0e6qje8+Pdo6sJnntf/x/tteK7wG9fTyslUoMbvT8zd
         Hfn3RB0gJh3hyYsSjxugtr3m5EqkINPoIiJmF+YOlSj0dCxTkjIgEwjNp4GuJv0DzOdJ
         1PCR1fn5j5HSahACbKU3NBbg8C+VuHtR0Lj6J6s/gTnBCzo0iJLfobU1S02dPJ/iXYgm
         fXog==
X-Forwarded-Encrypted: i=1; AJvYcCW02yDFCXqFuzM04RrOR11Er8QF5TNErA+ucoWlyDNGYGlrzoMiRREnKd/Zplms74KtfAvm00dtFadLULMfEEOnZZ5lXIBIiBJtPqtH7Dvn9A==
X-Gm-Message-State: AOJu0YwE8i/S/UiOQgVJP59QHUiAXowyoRGRHvhcGZ26uDmLlJj3VkKq
	4h/4M03al7GTyWXc497tfbfJRSM4tGKr/1BJ0MjYUK0LgHo4GUYToxpgs6dG3YrHi52rRzsL7Ab
	E8dDmfgHc+YU/0c4ZmBb3aN159iP47nX8ppHs
X-Google-Smtp-Source: AGHT+IFFHoTuAXtBwywnffPPgv1AMvfCClApoocsOwgs0CQGxOgfH1I8J5ecYdB7XjRAlRFwgGIub9OJrZ6hbBxSk/g=
X-Received: by 2002:a92:c608:0:b0:374:ade4:cb6c with SMTP id
 e9e14a558f8ab-374ba8b7086mr4510235ab.28.1717720572785; Thu, 06 Jun 2024
 17:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603092812.46616-1-yangyicong@huawei.com> <20240603092812.46616-2-yangyicong@huawei.com>
 <CAP-5=fXNumMLL=_+qXdnQPqgLSwo7Z1BFmPww63NkX5EcDRDsQ@mail.gmail.com> <ZmJPtZvWr3kgx4xF@google.com>
In-Reply-To: <ZmJPtZvWr3kgx4xF@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Jun 2024 17:36:01 -0700
Message-ID: <CAP-5=fUrgdNvwL-ZDMoTdvXEJBJOc_aMtAc66tgQ34Dd5K=4+g@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf pmu: Limit PMU cpumask to online CPUs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Yicong Yang <yangyicong@huawei.com>, will@kernel.org, mark.rutland@arm.com, 
	acme@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, james.clark@arm.com, dongli.zhang@oracle.com, 
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Mon, Jun 03, 2024 at 09:52:15AM -0700, Ian Rogers wrote:
> > On Mon, Jun 3, 2024 at 2:33=E2=80=AFAM Yicong Yang <yangyicong@huawei.c=
om> wrote:
> > >
> > > From: Yicong Yang <yangyicong@hisilicon.com>
> > >
> > > We'll initialize the PMU's cpumask from "cpumask" or "cpus" sysfs
> > > attributes if provided by the driver without checking the CPUs
> > > are online or not. In such case that CPUs provided by the driver
> > > contains the offline CPUs, we'll try to open event on the offline
> > > CPUs and then rejected by the kernel:
> > >
> > > [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
> > > [root@localhost yang]# ./perf_static stat -e armv8_pmuv3_0/cycles/ --=
timeout 100
> > > Error:
> > > The sys_perf_event_open() syscall returned with 19 (No such device) f=
or event (cpu-clock).
> > > /bin/dmesg | grep -i perf may provide additional information.
> > >
> > > So it's better to do a double check in the userspace and only include
> > > the online CPUs from "cpumask" or "cpus" to avoid opening events on
> > > offline CPUs.
> >
> > I see where you are coming from with this but I think it is wrong. The
> > cpus for an uncore PMU are a hint of the CPU to open on rather than
> > the set of valid CPUs. For example:
> > ```
> > $ cat /sys/devices/uncore_imc_free_running_0/cpumask
> > 0
> > $ perf stat -vv -e uncore_imc_free_running_0/data_read/ -C 1 -a sleep 0=
.1
> > Using CPUID GenuineIntel-6-8D-1
> > Attempt to add: uncore_imc_free_running_0/data_read/
> > ..after resolving event: uncore_imc_free_running_0/event=3D0xff,umask=
=3D0x20/
> > Control descriptor is not initialized
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             24 (uncore_imc_free_running_0)
> >   size                             136
> >   config                           0x20ff (data_read)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -22
> > switching off cloexec flag
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             24 (uncore_imc_free_running_0)
> >   size                             136
> >   config                           0x20ff (data_read)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> >   exclude_guest                    1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0
> > sys_perf_event_open failed, error -22
> > switching off exclude_guest, exclude_host
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             24 (uncore_imc_free_running_0)
> >   size                             136
> >   config                           0x20ff (data_read)
> >   sample_type                      IDENTIFIER
> >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNIN=
G
> >   disabled                         1
> >   inherit                          1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0 =3D 3
> > uncore_imc_free_running_0/data_read/: 1: 4005984 102338957 102338957
> > uncore_imc_free_running_0/data_read/: 4005984 102338957 102338957
> >
> >  Performance counter stats for 'system wide':
> >
> >             244.51 MiB  uncore_imc_free_running_0/data_read/
> >
> >        0.102320376 seconds time elapsed
> > ```
> > So the CPU mask of the PMU says to open on CPU 0, but on the command
> > line when I passed "-C 1" it opened it on CPU 1. If the cpumask file
> > contained an offline CPU then this change would make it so the CPU map
> > in the tool were empty, however, a different CPU may be programmable
> > and online.
>
> I think Intel uncore PMU driver ignores the CPU parameter and set it to
> CPU 0 in this case internally.  See uncore_pmu_event_init() at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/x86/events/intel/uncore.c#n761

Hmm.. maybe that's just the option if not set. Wrt hot plugging, on a
2 socket skylake:
```
$ cat /sys/devices/uncore_imc_0/cpumask
0,18
$ echo 0 > /sys/devices/system/cpu/cpu18/online
$ cat /sys/devices/uncore_imc_0/cpumask
0,19
```
So the cpumask should be reflecting the online/offline nature of CPUs.

> >
> > Fwiw, the tool will determine whether the mask is for all valid or a
> > hint by using the notion of a PMU being "core" or not. That notion
> > considers whether the mask was loading from a "cpumask" or "cpus"
> > file:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n810
> >
> > Thanks,
> > Ian
> >
> > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > ---
> > >  tools/perf/util/pmu.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index 888ce9912275..51e8d10ee28b 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -771,8 +771,17 @@ static struct perf_cpu_map *pmu_cpumask(int dirf=
d, const char *name, bool is_cor
> > >                         continue;
> > >                 cpus =3D perf_cpu_map__read(file);
> > >                 fclose(file);
> > > -               if (cpus)
> > > -                       return cpus;
> > > +               if (cpus) {
> > > +                       struct perf_cpu_map *intersect __maybe_unused=
;
> > > +
> > > +                       if (perf_cpu_map__is_subset(cpu_map__online()=
, cpus))
> > > +                               return cpus;
> > > +
> > > +                       intersect =3D perf_cpu_map__intersect(cpus, c=
pu_map__online());
>
> So IIUC this is for core PMUs with "cpus" file, right?  I guess uncore
> drivers already handles "cpumask" properly..

So I think this is an ARM specific bug:

Core PMUs:
x86 uses /sys/devices/cpu, s390 uses cpum_cf, these lack a cpus or
cpumask and so we default to opening events on all online processors.
The fact these are core PMUs is hardcoded in the tool:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n1747
x86 hybrid /sys/devices/cpu_(core|atom)/cpus - the set of CPUs is
updated to reflect online and offline
ARM the /sys/devices/armv8_pmuv3_0 isn't a hardcoded core PMU and so
we expect the cpus to contain online CPUs, but it currently also
erroneously contains offline ones.

Uncore PMUs:
x86 has /sys/devices/<uncore...>/cpumask where the cpumask reflects
online and offline CPUs
ARM has things like the dmc620 PMU, it appears to be missing cpumask
in certain cases leading to the perf tool treating it like the x86
core PMU and opening events for it on every CPU:
```
# ls /sys/devices/arm_dmc620_10008c000/
events  format  perf_event_mux_interval_ms  power  subsystem  type  uevent
```

I think we need a PMU test so that bugs like this can be reported, but
we may also need to add tool workarounds for PMUs that are broken. I
can imagine it will be tricky to test uncore PMUs that default to CPU0
as often we can't offline that.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > > +                       perf_cpu_map__put(cpus);
> > > +                       if (intersect)
> > > +                               return intersect;
> > > +               }
> > >         }
> > >
> > >         /* Nothing found, for core PMUs assume this means all CPUs. *=
/
> > > --
> > > 2.24.0
> > >
