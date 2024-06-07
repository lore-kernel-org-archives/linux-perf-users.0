Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C315443A
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Jun 2024 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743899; cv=none; b=SKRmKTwn3YP0xdWkSSNq0ExuoybbOqSAvz8AKnEW6vxFyswN0qsGoC+Kwd3EPPWzTLnWeD3biqICoL+FvdlPYCjgwgZohJ+NpV7EjGnnYQDCYGYcKX3g1q+iHIVAqtygY9CLDktAAyVYGjL66AvV5VQRzBgzKD01qiol03r2cjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743899; c=relaxed/simple;
	bh=ExmAffy92q5lCCHYU0DLDrpNvN/NVU0TVxBDQKH6ckc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jodlCUeRneZuRJIxcp2633LwthkYXMvcXCNWa5YfskRFHRWxTqibzKkb4oOVQGMRMnuk5QQY21wulWWCkZggFQvrhvWrOBvcETNE065EJAxXdNJj9mmYEjo8BE4g2xT+J3Czm3qxE9A+Dat6vnaEhAokPo06HTdsesKovn18etE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XeeHNDyO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XeeHNDyO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee5f3123d8so80565ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Jun 2024 00:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717743897; x=1718348697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2U6k0mvjnJXDsBrJv6XiaCwi3+ss8Cn/7fpH/m1zTA=;
        b=XeeHNDyO5w0lfCsOopbVifYt/BPiGjOjTI629uD5OIqxaLqidu30DJar0J0IA7zWMD
         CkJ23cAVyy5uq3dsF2htA4Pkq+SaK9JmJ50SK+91n9d6lc0z2rc6nx+fs4eaTXC/Yzvx
         +3DyeNY33ETOfEc9JDDmu9+wPWWp0r53UAEN99mnYFktCZXaxZCZRPh41pDF282SHAn1
         lV4jvgvHQHNFX28txwN4CHW/+6/Cl7JJsqMJxxYXvgMZwYqiusUyWodvcX0JSlIvjzee
         uHtR0aHIBEHE0IQl1IXUiQadb4zVX4Lx36bDKpFyyHmj2kPvFVI3eS+9QwUFvqwUFKzR
         peew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717743897; x=1718348697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2U6k0mvjnJXDsBrJv6XiaCwi3+ss8Cn/7fpH/m1zTA=;
        b=tMyREjxn68kOyy+Dvu3jDN8oL90wgaljSDzwjgSyN6Mb7GVlZMdBV4zxeeHkKwQfcP
         mz7KPTG0GHCdwwOlnPrV5TTPQr4xqxLqbpdP8aVysTryqdvmVe+rVDenfVhk58jgNUcU
         0nY8r6RUiqF7rU6uC9lhJInuzNEYz6tTWdndfMLZI/uD2JtpOut2fP2W5thp3imb2IL5
         pXG9gEF8VhupJOSqFFRgEzt6PxpS0sfNZLixNCWz6YD7hS12Y2R32LiegW9MKTLtvfWz
         j3jGbpdiPZdWohuLsMRqb1YXLPwUC/au2TjBdxEtVpeBgTROp/V+9u30dsLvQCaww5rx
         +3eA==
X-Forwarded-Encrypted: i=1; AJvYcCVbPJxvjZVK+Syon4jg4PxJuvD9jxyTSnr+EZ7HTkezFfFjKPH3WNxRDLKKF9ruYlUMfxhgZ75uBspJcYj9/5QFFMMBo3Uw7Uq/6Mb/O2hQaw==
X-Gm-Message-State: AOJu0Yy2AQkaxWBtds6M3dGOH9oYym2jZ+7X5F2bp+LaTpMXnv1nLxGR
	cgzi+Z4+LCIRMAQjHjXnKQIFcmwWj3JYIxCAkR51r54Z+mYilZwE/wbBRS6JT+ZmAxZCpnWvI59
	CcrnOwRuBTwRRw5VhpS0a66oefXzOntLDYu+S
X-Google-Smtp-Source: AGHT+IHwFRbTGvbN02EoS5YOHkz3ztWTsKXuk9ylfWPnj0rt4QdZrX2TvD0Xw/jkYCsfd2sez4sm4N+OUrFQt6nQ1VU=
X-Received: by 2002:a17:902:778f:b0:1f2:fcc3:59a with SMTP id
 d9443c01a7336-1f6bd3c65f8mr5793335ad.19.1717743896666; Fri, 07 Jun 2024
 00:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603092812.46616-1-yangyicong@huawei.com> <20240603092812.46616-2-yangyicong@huawei.com>
 <CAP-5=fXNumMLL=_+qXdnQPqgLSwo7Z1BFmPww63NkX5EcDRDsQ@mail.gmail.com>
 <ZmJPtZvWr3kgx4xF@google.com> <CAP-5=fUrgdNvwL-ZDMoTdvXEJBJOc_aMtAc66tgQ34Dd5K=4+g@mail.gmail.com>
In-Reply-To: <CAP-5=fUrgdNvwL-ZDMoTdvXEJBJOc_aMtAc66tgQ34Dd5K=4+g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Jun 2024 00:04:44 -0700
Message-ID: <CAP-5=fW=7dKExCfs0h=2xUPskbmOpv6v1AUngW7vWibHbS97dg@mail.gmail.com>
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

On Thu, Jun 6, 2024 at 5:36=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Thu, Jun 6, 2024 at 5:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > Hello,
> >
> > On Mon, Jun 03, 2024 at 09:52:15AM -0700, Ian Rogers wrote:
> > > On Mon, Jun 3, 2024 at 2:33=E2=80=AFAM Yicong Yang <yangyicong@huawei=
.com> wrote:
> > > >
> > > > From: Yicong Yang <yangyicong@hisilicon.com>
> > > >
> > > > We'll initialize the PMU's cpumask from "cpumask" or "cpus" sysfs
> > > > attributes if provided by the driver without checking the CPUs
> > > > are online or not. In such case that CPUs provided by the driver
> > > > contains the offline CPUs, we'll try to open event on the offline
> > > > CPUs and then rejected by the kernel:
> > > >
> > > > [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
> > > > [root@localhost yang]# ./perf_static stat -e armv8_pmuv3_0/cycles/ =
--timeout 100
> > > > Error:
> > > > The sys_perf_event_open() syscall returned with 19 (No such device)=
 for event (cpu-clock).
> > > > /bin/dmesg | grep -i perf may provide additional information.
> > > >
> > > > So it's better to do a double check in the userspace and only inclu=
de
> > > > the online CPUs from "cpumask" or "cpus" to avoid opening events on
> > > > offline CPUs.
> > >
> > > I see where you are coming from with this but I think it is wrong. Th=
e
> > > cpus for an uncore PMU are a hint of the CPU to open on rather than
> > > the set of valid CPUs. For example:
> > > ```
> > > $ cat /sys/devices/uncore_imc_free_running_0/cpumask
> > > 0
> > > $ perf stat -vv -e uncore_imc_free_running_0/data_read/ -C 1 -a sleep=
 0.1
> > > Using CPUID GenuineIntel-6-8D-1
> > > Attempt to add: uncore_imc_free_running_0/data_read/
> > > ..after resolving event: uncore_imc_free_running_0/event=3D0xff,umask=
=3D0x20/
> > > Control descriptor is not initialized
> > > ------------------------------------------------------------
> > > perf_event_attr:
> > >   type                             24 (uncore_imc_free_running_0)
> > >   size                             136
> > >   config                           0x20ff (data_read)
> > >   sample_type                      IDENTIFIER
> > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNN=
ING
> > >   disabled                         1
> > >   inherit                          1
> > >   exclude_guest                    1
> > > ------------------------------------------------------------
> > > sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8
> > > sys_perf_event_open failed, error -22
> > > switching off cloexec flag
> > > ------------------------------------------------------------
> > > perf_event_attr:
> > >   type                             24 (uncore_imc_free_running_0)
> > >   size                             136
> > >   config                           0x20ff (data_read)
> > >   sample_type                      IDENTIFIER
> > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNN=
ING
> > >   disabled                         1
> > >   inherit                          1
> > >   exclude_guest                    1
> > > ------------------------------------------------------------
> > > sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0
> > > sys_perf_event_open failed, error -22
> > > switching off exclude_guest, exclude_host
> > > ------------------------------------------------------------
> > > perf_event_attr:
> > >   type                             24 (uncore_imc_free_running_0)
> > >   size                             136
> > >   config                           0x20ff (data_read)
> > >   sample_type                      IDENTIFIER
> > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNN=
ING
> > >   disabled                         1
> > >   inherit                          1
> > > ------------------------------------------------------------
> > > sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0 =3D 3
> > > uncore_imc_free_running_0/data_read/: 1: 4005984 102338957 102338957
> > > uncore_imc_free_running_0/data_read/: 4005984 102338957 102338957
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >             244.51 MiB  uncore_imc_free_running_0/data_read/
> > >
> > >        0.102320376 seconds time elapsed
> > > ```
> > > So the CPU mask of the PMU says to open on CPU 0, but on the command
> > > line when I passed "-C 1" it opened it on CPU 1. If the cpumask file
> > > contained an offline CPU then this change would make it so the CPU ma=
p
> > > in the tool were empty, however, a different CPU may be programmable
> > > and online.
> >
> > I think Intel uncore PMU driver ignores the CPU parameter and set it to
> > CPU 0 in this case internally.  See uncore_pmu_event_init() at
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/x86/events/intel/uncore.c#n761
>
> Hmm.. maybe that's just the option if not set. Wrt hot plugging, on a
> 2 socket skylake:
> ```
> $ cat /sys/devices/uncore_imc_0/cpumask
> 0,18
> $ echo 0 > /sys/devices/system/cpu/cpu18/online
> $ cat /sys/devices/uncore_imc_0/cpumask
> 0,19
> ```
> So the cpumask should be reflecting the online/offline nature of CPUs.
>
> > >
> > > Fwiw, the tool will determine whether the mask is for all valid or a
> > > hint by using the notion of a PMU being "core" or not. That notion
> > > considers whether the mask was loading from a "cpumask" or "cpus"
> > > file:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n810
> > >
> > > Thanks,
> > > Ian
> > >
> > > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > > ---
> > > >  tools/perf/util/pmu.c | 13 +++++++++++--
> > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > > index 888ce9912275..51e8d10ee28b 100644
> > > > --- a/tools/perf/util/pmu.c
> > > > +++ b/tools/perf/util/pmu.c
> > > > @@ -771,8 +771,17 @@ static struct perf_cpu_map *pmu_cpumask(int di=
rfd, const char *name, bool is_cor
> > > >                         continue;
> > > >                 cpus =3D perf_cpu_map__read(file);
> > > >                 fclose(file);
> > > > -               if (cpus)
> > > > -                       return cpus;
> > > > +               if (cpus) {
> > > > +                       struct perf_cpu_map *intersect __maybe_unus=
ed;
> > > > +
> > > > +                       if (perf_cpu_map__is_subset(cpu_map__online=
(), cpus))
> > > > +                               return cpus;
> > > > +
> > > > +                       intersect =3D perf_cpu_map__intersect(cpus,=
 cpu_map__online());
> >
> > So IIUC this is for core PMUs with "cpus" file, right?  I guess uncore
> > drivers already handles "cpumask" properly..
>
> So I think this is an ARM specific bug:
>
> Core PMUs:
> x86 uses /sys/devices/cpu, s390 uses cpum_cf, these lack a cpus or
> cpumask and so we default to opening events on all online processors.
> The fact these are core PMUs is hardcoded in the tool:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n1747
> x86 hybrid /sys/devices/cpu_(core|atom)/cpus - the set of CPUs is
> updated to reflect online and offline
> ARM the /sys/devices/armv8_pmuv3_0 isn't a hardcoded core PMU and so
> we expect the cpus to contain online CPUs, but it currently also
> erroneously contains offline ones.
>
> Uncore PMUs:
> x86 has /sys/devices/<uncore...>/cpumask where the cpumask reflects
> online and offline CPUs
> ARM has things like the dmc620 PMU, it appears to be missing cpumask
> in certain cases leading to the perf tool treating it like the x86
> core PMU and opening events for it on every CPU:
> ```
> # ls /sys/devices/arm_dmc620_10008c000/
> events  format  perf_event_mux_interval_ms  power  subsystem  type  ueven=
t
> ```
>
> I think we need a PMU test so that bugs like this can be reported, but
> we may also need to add tool workarounds for PMUs that are broken. I
> can imagine it will be tricky to test uncore PMUs that default to CPU0
> as often we can't offline that.

I think we should make this an ARM specific fix up like:
https://lore.kernel.org/lkml/20240607065343.695369-1-irogers@google.com/
The PMU needs fixing up like in the rest of the change, but as perf
can be run on older kernels I think this workaround will remain
necessary. The arm_cmn PMU appears to handle CPU hot plugging, the
arm_dmc620 lacks a cpumask altogether on the test machine I can
access. I suspect we may want a better uncore fix as we may change a
CPU map of 1 CPU into an empty CPU map, for example, if the cpumask is
"0" and CPU0 is offline, then "1" would be a better alternative than
the empty CPU map. I couldn't find a PMU to test this with.

Thanks,
Ian

> Thanks,
> Ian
>
> > Thanks,
> > Namhyung
> >
> >
> > > > +                       perf_cpu_map__put(cpus);
> > > > +                       if (intersect)
> > > > +                               return intersect;
> > > > +               }
> > > >         }
> > > >
> > > >         /* Nothing found, for core PMUs assume this means all CPUs.=
 */
> > > > --
> > > > 2.24.0
> > > >
