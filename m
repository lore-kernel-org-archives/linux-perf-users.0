Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUVkg/r/"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4EAB9
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 11:27:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c38e520e2so12095e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 11:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702409226; x=1703014026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpWWa0boH3+/2WIj2IQtKJSjorRZele4YQzAu/aAdHk=;
        b=MUVkg/r/g/XEGrT2LDlpt89VQAB0gdxF3Wgi6cR2QeG5X2iDakpIey8MV9b3cBcngJ
         BEXEeEkGZBovaZwYZ7ZSAwgXLhpH3FvvW9H17bOVjAtzcXJZ4kCp8fyQt5qZ6D+6xH7h
         MH5Z1ou3fVyrhT2Gp9CwTjrxVnWMMNlUQLF6HhUA41gBkKfIcOnDW/oZs+5PUSVyVxXK
         if2+c1dGQJ95gWpFSaXvmGsBoIdcXcUFYyyqg8uNZmtIm/p/QJFFumWZfzT1r7SpRzdl
         ugFwWgugHW2wULCei3I1QZVo6E4C8QAg6oAREaD6b4L6xRpH5tZb6ePhH36uc7erplHR
         s2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409226; x=1703014026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpWWa0boH3+/2WIj2IQtKJSjorRZele4YQzAu/aAdHk=;
        b=E5jUI52xJOKU1ge58qPCssDObZBwLenrXpgRFzIxDgnt2vVp3w9VOOERg63B2ucoFG
         5DxMUxcqQk2eEQXPU47fvVs62Kk/uVqsB0YfLGep1pvCS63vEvKuzRm10ToKohMI0G3z
         EPHR04fVn+FMZhx8T5EOW33RyFoNChVUiJQLVTvkFnzdlWLBqoYEzVeb4kvJyyub93qi
         C0iQR6bDjoXgKsNIDrsFc6o/Eadx8yStfEyCuf9Y0sZqpf9MYHo+KXFKmVRwLrgJzYtH
         Uf6oelfktHqMvi1+kZ8NC5DVA35RLqiAzXVty9NUfw7uZDhdw6zMywlEGhLHEQBgvun+
         TOrg==
X-Gm-Message-State: AOJu0YxYE9LAiDKJUn59xtPUloKcj/LCaMnYXFSDEaky3xN4o1eq7T2T
	qk8SgYgWkSFTw+HioCDu1TEpa1/C2Xfbdyt5hkFytRzWKZSRH7bBRrsvqh1gb0M=
X-Google-Smtp-Source: AGHT+IE05j7AziF9pUtM9j1ETwUNx5mCJwdaeYFqzHeKiZxdn3DWSzLk/BsBBHDWE9EM8HAm2iDHDHQ89Wl/esh7maM=
X-Received: by 2002:a05:600c:3491:b0:40b:33aa:a2b9 with SMTP id
 a17-20020a05600c349100b0040b33aaa2b9mr364639wmq.4.1702409225824; Tue, 12 Dec
 2023 11:27:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org> <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
 <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com> <CAM9d7cgxCg0bgWRUg2rkR1dFfpTEUX6AZdw-Od5yALiL33ymQg@mail.gmail.com>
In-Reply-To: <CAM9d7cgxCg0bgWRUg2rkR1dFfpTEUX6AZdw-Od5yALiL33ymQg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Dec 2023 11:26:54 -0800
Message-ID: <CAP-5=fXzCp9Lctz1vt-asN4s67Cs=mW8m3upjTJCwjoK0CUcvw@mail.gmail.com>
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
To: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, maz@kernel.org, marcan@marcan.st, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:49=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Dec 12, 2023 at 10:31=E2=80=AFAM Mark Rutland <mark.rutland@arm.c=
om> wrote:
> >
> > On Tue, Dec 12, 2023 at 10:00:16AM -0800, Ian Rogers wrote:
> > > On Tue, Dec 12, 2023 at 9:23=E2=80=AFAM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > On Tue, Dec 12, 2023 at 7:56=E2=80=AFAM Liang, Kan <kan.liang@linux=
.intel.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 2023-12-11 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> > > > > > Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel=
.com escreveu:
> > > > > >> From: Kan Liang <kan.liang@linux.intel.com>
> > > > > >>
> > > > > >> perf top errors out on a hybrid machine
> > > > > >>  $perf top
> > > > > >>
> > > > > >>  Error:
> > > > > >>  The cycles:P event is not supported.
> > > > > >>
> > > > > >> The user_requested_cpus may contain CPUs that are invalid for =
a hybrid
> > > > > >> PMU. It causes perf_event_open to fail.
> > > > > >
> > > > > > ?
> > > > > >
> > > > > > All perf top expects is that the "cycles", the most basic one, =
be
> > > > > > collected, on all CPUs in the system.
> > > > > >
> > > > >
> > > > > Yes, but for hybrid there is no single "cycles" event which can c=
over
> > > > > all CPUs.
> > > >
> > > > Does that mean the kernel would reject the legacy "cycles" event
> > > > on hybrid CPUs?
> > >
> > > I believe not. When the extended type isn't set on legacy cycles we
> > > often have the CPU and from that can determine the PMU. The issue is
> > > with the -1 any CPU perf_event_open option. As I was told, the PMU th=
e
> > > event is opened on in this case is the first one registered in the
> > > kernel, on Intel hybrid this could be cpu_core or cpu_atom.. but IIRC
> > > it'll probably be cpu_core. On ARM =C2=AF\_(=E3=83=84)_/=C2=AF.
> >
> > On ARM it'll be essentially the same as on x86: if you open an event wi=
th
> > type=3D=3DPERF_EVENT_TYPE_HARDWARE (without the extended HW type pointi=
ng to a
> > specific PMU), and with cpu=3D=3D-1, it'll go to an arbitrary CPU PMU, =
whichever
> > happens to be found by perf_init_event() when iterating over the 'pmus'=
 list.
> >
> > If you open an event with type=3D=3DPERF_EVENT_TYPE_HARDWARE and cpu!=
=3D-1, the event
> > will opened on the appropriate CPU PMU, by virtue of being rejected by =
others
> > when perf_init_event() iterates over the 'pmus' list.
>
> Ok, that means "cycles" with cpu =3D=3D -1 would not work well.
>
> I'm curious if it's possible to do some basic work at the event_init()
> like to preserve (common) resource and to do some other work at
> sched to config PMU on the current CPU.  So that users can simply
> use "cycles" or "instructions" for their processes.

It should be possible to make things better, especially for standard
events for cycles or instructions, for software that isn't aware of
multiple core PMUs and the extended type field. There are legacy
events like dTLB-speculative-read that may be supported by 1 PMU and
not the other, so what should happen with thread scheduling there?

On RISC-V there was discussion of the legacy to pmu/config mapping
that happens in the driver being something that is handled in the
tool. A lot of the legacy events end up being "<not supported>" which
is a pretty bad user experience, like this on AMD:
```
# perf stat -d -a sleep 1

 Performance counter stats for 'system wide':

        259,256.21 msec cpu-clock                        #  257.445
CPUs utilized
            11,931      context-switches                 #   46.020
/sec
               264      cpu-migrations                   #    1.018
/sec
               419      page-faults                      #    1.616
/sec
     5,892,812,250      cycles                           #    0.023
GHz                         (62.43%)
     1,159,909,806      stalled-cycles-frontend          #   19.68%
frontend cycles idle        (62.48%)
       831,668,644      stalled-cycles-backend           #   14.11%
backend cycles idle         (62.52%)
     2,825,351,898      instructions                     #    0.48
insn per cycle
                                                  #    0.41  stalled
cycles per insn     (62.54%)
       520,403,374      branches                         #    2.007
M/sec                       (62.57%)
        12,050,970      branch-misses                    #    2.32% of
all branches             (62.55%)
     1,117,382,209      L1-dcache-loads                  #    4.310
M/sec                       (62.48%)
        61,060,457      L1-dcache-load-misses            #    5.46% of
all L1-dcache accesses   (62.43%)
   <not supported>      LLC-loads
   <not supported>      LLC-load-misses

       1.007033432 seconds time elapsed
```
So I think the move should be away from legacy events but that doesn't
necessarily mean we can't make them better.

Thanks,
Ian

> Thanks,
> Namhyung
