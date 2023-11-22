Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qFCeU5nw"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6126119B2
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 07:33:48 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50aba9b8955so3603e87.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 07:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700667226; x=1701272026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWid6eIzgQXVTn+FJFm1OcXKu1j1/Z6O6m4d0ApRahA=;
        b=qFCeU5nwFcR4EBIItSurssC3nOEwt1RYF+JBTG9GRobpZt9/bvlDh2VtW8kirTMqKL
         q/bWsA3XN6rlPIha/DKMOO85oA2kvitv/5HAl+06twctGfNkUQilDSXMNVxgfvsgan80
         MkPNCSTy6w2d1KPB3tJi5J6nSeQM8gfwoVi1PNB/F2ZsUYAcpopdM2pYG6voOc0Jp38x
         UmM56efiRDW/SU257O9vLe6rIz8MJP11/0gtqMU3icW/RtioT3kYc50mcncAdugQ9X/t
         OGHohFMNEqb/ZB4AnyAu4QkzeftJ7i+92fUe/60k2mrIepJnlUynWC6Y2EJIvhQoYQnH
         oSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667226; x=1701272026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWid6eIzgQXVTn+FJFm1OcXKu1j1/Z6O6m4d0ApRahA=;
        b=fdIyEESpGoIPHqUiPQ7enYTb2r/OSAcovM3FSlifd1CcovyBAsPh+lf+g/pSjFvFNw
         0O17qDxBPd9NhgwWW0e7bEcOmqVgvs9ROl+hWA6e4qiuL157DW4zs9SyOxfkt7c8P0Eo
         RjZNxxpetPmpdMxTWY1rcLkmdWDAwpJLtbICppijENVNV+JPKbRqjXJwn3ZIv9b9F6VY
         tNb2gZ53szBsBtzZk2EEGKM5EoYTNPKr9dy7nT/+CoeJag6wvuULolj5AcJq4KIKkNUk
         BAqgThcnYmHKdCYMUDykzS6uKZQ87YMefGdrWu8PbDuwtKY1JK4IeVMpLpruiHy/Q/ak
         nr+A==
X-Gm-Message-State: AOJu0Ywr1h05XrwaRksF/OzAgmao+U9kLTGh5ouZQeTC/mfBdvHp9AW9
	YaLmHGp1CM7CiJNyWwVwD9JbmVRvFEuSaqh8Ky1ddw==
X-Google-Smtp-Source: AGHT+IEqRlZl1vl3IXc4KJ5dpcRfB73lyXQ/rpLqQDx+63npnZw58JIljRndHuL0aOmb+1b2atr9K7Xjp5kGX/UOmdY=
X-Received: by 2002:a05:6512:4002:b0:509:4ac3:12c with SMTP id
 br2-20020a056512400200b005094ac3012cmr94633lfb.7.1700667226281; Wed, 22 Nov
 2023 07:33:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org> <86o7fnyvrq.wl-maz@kernel.org>
 <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
 <930bfb9a-dcbe-4385-9ae3-26e2aa14c50e@marcan.st> <ZV38z3+p2S2ETtzG@kernel.org>
In-Reply-To: <ZV38z3+p2S2ETtzG@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 Nov 2023 07:33:34 -0800
Message-ID: <CAP-5=fWr17kGwo-xrggM5u4Ydjb=_LeyTPXOP1-i6Fsvq=2xxw@mail.gmail.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 5:06=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 22, 2023 at 12:23:27PM +0900, Hector Martin escreveu:
> > On 2023/11/22 1:38, Ian Rogers wrote:
> > > On Tue, Nov 21, 2023 at 8:15=E2=80=AFAM Mark Rutland <mark.rutland@ar=
m.com> wrote:
> > >> On Tue, Nov 21, 2023 at 08:09:37AM -0800, Ian Rogers wrote:
> > >>> On Tue, Nov 21, 2023 at 8:03=E2=80=AFAM Mark Rutland <mark.rutland@=
arm.com> wrote:
> > >>>> On Tue, Nov 21, 2023 at 07:46:57AM -0800, Ian Rogers wrote:
> > >>>>> On Tue, Nov 21, 2023 at 7:40=E2=80=AFAM Mark Rutland <mark.rutlan=
d@arm.com> wrote:
> > >>>>>> On Tue, Nov 21, 2023 at 03:24:25PM +0000, Marc Zyngier wrote:
> > >>>>>>> On Tue, 21 Nov 2023 13:40:31 +0000,
> > >>>>>>> Marc Zyngier <maz@kernel.org> wrote:
> > >>>>>>>>
> > >>>>>>>> [Adding key people on Cc]
> > >>>>>>>>
> > >>>>>>>> On Tue, 21 Nov 2023 12:08:48 +0000,
> > >>>>>>>> Hector Martin <marcan@marcan.st> wrote:
> > >>>>>>>>>
> > >>>>>>>>> Perf broke on all Apple ARM64 systems (tested almost everythi=
ng), and
> > >>>>>>>>> according to maz also on Juno (so, probably all big.LITTLE) s=
ince v6.5.
> > >>>>>>>>
> > >>>>>>>> I can confirm that at least on 6.7-rc2, perf is pretty busted =
on any
> > >>>>>>>> asymmetric ARM platform. It isn't clear what criteria is used =
to pick
> > >>>>>>>> the PMU, but nothing works anymore.
> > >>>>>>>>
> > >>>>>>>> The saving grace in my case is that Debian still ships a 6.1 p=
erftool
> > >>>>>>>> package, but that's obviously not going to last.
> > >>>>>>>>
> > >>>>>>>> I'm happy to test potential fixes.
> > >>>>>>>
> > >>>>>>> At Mark's request, I've dumped a couple of perf (as of -rc2) ru=
ns with
> > >>>>>>> -vvv.  And it is quite entertaining (this is taskset to an 'ice=
storm'
> > >>>>>>> CPU):
> > >>>>>>
> > >>>>>> IIUC the tool is doing the wrong thing here and overriding expli=
cit
> > >>>>>> ${pmu}/${event}/ events with PERF_TYPE_HARDWARE events rather th=
an events using
> > >>>>>> that ${pmu}'s type and event namespace.
> > >>>>>>
> > >>>>>> Regardless of the *new* ABI that allows PERF_TYPE_HARDWARE event=
s to be
> > >>>>>> targetted to a specific PMU, it's semantically wrong to rewrite =
events like
> > >>>>>> this since ${pmu}/${event}/ is not necessarily equivalent to a s=
imilarly-named
> > >>>>>> PERF_COUNT_HW_${EVENT}.
> > >>>>>
> > >>>>> If you name a PMU and an event then the event should only be open=
ed on
> > >>>>> that PMU, 100% agree. There's a bunch of output, but when the leg=
acy
> > >>>>> cycles event is opened it appears to be because it was explicitly
> > >>>>> requested.
> > >>>>
> > >>>> I think you've missed that the named PMU events are being erreousl=
y transformed
> > >>>> into PERF_TYPE_HARDWARE events. Look at the -vvv output, e.g.
> > >>>>
> > >>>>   Opening: apple_firestorm_pmu/cycles/
> > >>>>   ------------------------------------------------------------
> > >>>>   perf_event_attr:
> > >>>>     type                             0 (PERF_TYPE_HARDWARE)
> > >>>>     size                             136
> > >>>>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > >>>>     sample_type                      IDENTIFIER
> > >>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME=
_RUNNING
> > >>>>     disabled                         1
> > >>>>     inherit                          1
> > >>>>     enable_on_exec                   1
> > >>>>     exclude_guest                    1
> > >>>>   ------------------------------------------------------------
> > >>>>   sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8=
 =3D 4
> > >>>>
> > >>>> ... which should not be PERF_TYPE_HARDWARE && PERF_COUNT_HW_CPU_CY=
CLES.
> > >>>>
> > >>>> Marc said that he bisected the issue down to commit:
> > >>>>
> > >>>>   5ea8f2ccffb23983 ("perf parse-events: Support hardware events as=
 terms")
> > >>>>
> > >>>> ... so it looks like something is going wrong when the events are =
being parsed,
> > >>>> e.g. losing the HW PMU information?
> > >>>
> > >>> Ok, I think I'm getting confused by other things. This looks like t=
he issue.
> > >>>
> > >>> I think it may be working as intended, but not how you intended :-)=
 If
> > >>> a core PMU is listed and then a legacy event, the legacy event shou=
ld
>
> The point is that "cycles" when prefixed with "pmu/" shouldn't be
> considered "cycles" as HW/0, in that setting it is "cycles" for that
> PMU. (but we only have "cpu_cycles" for at least the a53 and a72 PMUs I
> have access in a Libre Computer rockchip 3399-pc hybrid board, if we use
> it, then we get what we want/had before, see below):
>
> And there is an attempt at using the specified PMU, see the first
> perf_event_open:
>
> root@roc-rk3399-pc:~# strace -e perf_event_open perf stat -vv -e cycles,a=
rmv8_cortex_a53/cycles/,armv8_cortex_a72/cycles/ echo
> Using CPUID 0x00000000410fd082
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   config                           0x700000000
>   disabled                         1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8perf_event_open=
({type=3DPERF_TYPE_HARDWARE, size=3D0 /* PERF_ATTR_SIZE_??? */, config=3D0x=
7<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=3D0, sample_type=3D0, read_fo=
rmat=3D0, disabled=3D1, precise_ip=3D0 /* arbitrary skid */, ...}, 0, -1, -=
1, PERF_FLAG_FD_CLOEXEC) =3D -1 ENOENT (No such file or directory)
>
> //// HERE: it tries config=3D0x7<<32|PERF_COUNT_HW_CPU_CYCLES taking into
> //account the PMU number 0x7
>
> root@roc-rk3399-pc:~# cat /sys/devices/armv8_cortex_a53/type
> 7
> root@roc-rk3399-pc:~#
>
> But then we don't have "cycles" in that PMU:
>
> root@roc-rk3399-pc:~# ls -la /sys/devices/armv8_cortex_a53/events/cycles
> ls: cannot access '/sys/devices/armv8_cortex_a53/events/cycles': No such =
file or directory
> root@roc-rk3399-pc:~#
>
> Maybe:
>
> root@roc-rk3399-pc:~# taskset -c 5,6 perf stat -v -e armv8_cortex_a53/cpu=
_cycles/,armv8_cortex_a72/cpu_cycles/ echo
> Using CPUID 0x00000000410fd034
> Control descriptor is not initialized
>
> armv8_cortex_a53/cpu_cycles/: 0 2079000 0
> armv8_cortex_a72/cpu_cycles/: 2488961 2079000 2079000
>
>  Performance counter stats for 'echo':
>
>      <not counted>      armv8_cortex_a53/cpu_cycles/                     =
                       (0.00%)
>            2488961      armv8_cortex_a72/cpu_cycles/
>
>        0.003449266 seconds time elapsed
>
>        0.003502000 seconds user
>        0.000000000 seconds sys
>
>
> root@roc-rk3399-pc:~# taskset -c 0,1,2,3,4 perf stat -v -e armv8_cortex_a=
53/cpu_cycles/,armv8_cortex_a72/cpu_cycles/ echo
> Using CPUID 0x00000000410fd034
> Control descriptor is not initialized
>
> armv8_cortex_a53/cpu_cycles/: 2986601 6999416 6999416
> armv8_cortex_a72/cpu_cycles/: 0 6999416 0
>
>  Performance counter stats for 'echo':
>
>            2986601      armv8_cortex_a53/cpu_cycles/
>      <not counted>      armv8_cortex_a72/cpu_cycles/                     =
                       (0.00%)
>
>        0.011434508 seconds time elapsed
>
>        0.003911000 seconds user
>        0.007454000 seconds sys
>
>
> root@roc-rk3399-pc:~#
>
> root@roc-rk3399-pc:~# cat /sys/devices/armv8_cortex_a53/events/cpu_cycles
> event=3D0x0011
> root@roc-rk3399-pc:~# cat /sys/devices/armv8_cortex_a72/events/cpu_cycles
> event=3D0x0011
> root@roc-rk3399-pc:~#
>
> And the syscalls seem sane:
>
> root@roc-rk3399-pc:~# strace -e perf_event_open taskset -c 0,1,2,3,4 perf=
 stat -v -e armv8_cortex_a53/cpu_cycles/,armv8_cortex_a72/cpu_cycles/ echo
> Using CPUID 0x00000000410fd034
> Control descriptor is not initialized
> perf_event_open({type=3D0x7 /* PERF_TYPE_??? */, size=3D0x88 /* PERF_ATTR=
_SIZE_??? */, config=3D0x11, sample_period=3D0, sample_type=3DPERF_SAMPLE_I=
DENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_T=
IME_RUNNING, disabled=3D1, inherit=3D1, enable_on_exec=3D1, precise_ip=3D0 =
/* arbitrary skid */, exclude_guest=3D1, ...}, 14573, -1, -1, PERF_FLAG_FD_=
CLOEXEC) =3D 3
> perf_event_open({type=3D0x8 /* PERF_TYPE_??? */, size=3D0x88 /* PERF_ATTR=
_SIZE_??? */, config=3D0x11, sample_period=3D0, sample_type=3DPERF_SAMPLE_I=
DENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_T=
IME_RUNNING, disabled=3D1, inherit=3D1, enable_on_exec=3D1, precise_ip=3D0 =
/* arbitrary skid */, exclude_guest=3D1, ...}, 14573, -1, -1, PERF_FLAG_FD_=
CLOEXEC) =3D 4
>
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D14573, si=
_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
> armv8_cortex_a53/cpu_cycles/: 3227098 4480875 4480875
> armv8_cortex_a72/cpu_cycles/: 0 4480875 0
>
>  Performance counter stats for 'echo':
>
>            3227098      armv8_cortex_a53/cpu_cycles/
>      <not counted>      armv8_cortex_a72/cpu_cycles/                     =
                       (0.00%)
>
>        0.008381759 seconds time elapsed
>
>        0.004064000 seconds user
>        0.004121000 seconds sys
>
>
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DSI_USER, si_pid=3D14572, si_ui=
d=3D0} ---
> +++ exited with 0 +++
> root@roc-rk3399-pc:~#
>
> As:
>
> root@roc-rk3399-pc:~# cat /sys/devices/armv8_cortex_a53/type
> 7
> root@roc-rk3399-pc:~# cat /sys/devices/armv8_cortex_a72/type
> 8
> root@roc-rk3399-pc:~#
>
> See the type=3D0x7 and type=3D0x8.
>
> So what we need here seems to be to translate the generic term "cycles"
> to "cpu_cycles" when a PMU is explicitely passed in the event name and
> it doesn't have "cycles" and then just retry.

The PMU driver does the legacy to raw encoding translation, this is an
assumption the tool has of core PMUs. You can see ARM's PMU driver
doing the mapping here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/perf/arm_pmuv3.c#n40

Thanks,
Ian


> - Arnaldo
