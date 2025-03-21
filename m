Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C0222582
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581933; cv=none; b=jUy1kS0bFKAjPWhUuv+PxvCYHiphaocaN8Hsq19uxqo2YQ1AaaGKZzTOClnQb+ipNs8Opbh7JUqjUDIaGBOiF3nT9V7/k7+UBUWkAvFoco/IFYY9YGOHRp+4a4LR8Pj1ypBRoTpQ/26/km2vdPYmYwMHSBeC7Ouq47ziyxwQ+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581933; c=relaxed/simple;
	bh=5BFBcmGbfOEPP9F8rrJwsf0bfXIeuSf2oUK5QlB1XYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLdSGb7e7F2MjTM49hzrw8pvjwYvcY/1jzMrY+BQRiWes9kzLdRVmJ2j9Hbv5RPkrwhL0S6sege+E7TnVuHHM502gquY5indZKpZvRZmgCiaw/nnaKb9Mkqsng1ea4OxHUl4nFoLFh4Qirp/yozak+CK00d2RMVbtLMB4+PHyP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=nf45l7MM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="nf45l7MM"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549967c72bcso2731212e87.3
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1742581929; x=1743186729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZk4MLwYE/VQt4fqcjAW6b/FrOtkSOdml4Fv3RNcxZo=;
        b=nf45l7MMDzw72mxrjaFpkAGnvWVtPbrkoO6Csky2LdK6m11xeRWD5Hm8kjCn/VK4SC
         5XdLSyyctxDR71ClLYyzM/qrq2wMoIr6arlSJSSXzC/aMC1RBDIr1EgSFD2QHSWJvlAs
         foSNl0aJKZSJ5u++sdT/t8ZFAeGEwdyXnSO6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581929; x=1743186729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZk4MLwYE/VQt4fqcjAW6b/FrOtkSOdml4Fv3RNcxZo=;
        b=ZwdF4EaYiyDpHtdZNb1FB+yBPe+lMYFsBM79cZezj3riS7YseexbThwMJWTPDzFT8X
         7kAH6Qc83EJajsrKkZNbN62bXvh3t4w6uWEYrOg66/CejU2398rjc9s5cWMxI5YuWpL5
         jm2eCPaodUIpjod1XPNqybDvVOnd4E2iYhDBYGivLLHjm+8lVqM9ckNZFF1W0z1N0tyu
         2QWqmxI0INDlFQ/CQ/8aJa8ynORdgZ3pFxHG6dY8bl1d7LIhZ1TV9geu6U8zgX+rNlvT
         LCi2GDzOXX/MLjkQhFUQ6jd5iQClGxsBi7weY42bvOC+Oo+2rU1MM3R8orPIpVgHqDCV
         2uXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlVn6zgH2Y1S+/h/8iJsU+adaQdEPQ7yKh6aaWiSqaZ67lvZPasgMDVK/jyHiNDu9AnwTDPy46nKkS8c6C5Djk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lPhhh9fxjcoprLdmDKoQI+ct6JzNPYS7wRAxcf2sH1Gr3UfN
	yB3MDYxOE4A/x6Bv3CaAjayzxa2MADlkUiwk5+sJBqmgjbfvbnwR/L/OotmQu6dfsOdNpM0+G9f
	qmWqUsDIQkGePyQHEAFdw9pbRDXgS8pXSo9PN
X-Gm-Gg: ASbGncu/W8HMPi6jfywVr8OMFiJOAMMlONtmKj+RG3nJRRTfgAoPUrbn3PfkPh0qyhh
	li3gGH0i1c7Hvnjh5mpJCa8ZjjwOpTeXJR846JQGevm/VwO69BkYgi/+GpN/T1rcHnETocikaB6
	AMVQuj7byITO1qH77rrc9usiE=
X-Google-Smtp-Source: AGHT+IFydwhpwDyAxK+PqqqMwQZkO6KmypA7vFIQbQ4IfQs3Lq4ahQKxHvUyO78bWaiTqz47WsfETos8btTHEykUkik=
X-Received: by 2002:a05:6512:b03:b0:548:de7f:b3be with SMTP id
 2adb3069b0e04-54ad648083dmr1567517e87.21.1742581928562; Fri, 21 Mar 2025
 11:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213220341.3215660-1-samuel.holland@sifive.com>
 <Z7ZLB-wZY9wTZSBZ@google.com> <CAOnJCUJYKkGXOJiLTnPOgPSnEiCeXFaoGQRiT5Au+rbvP1unZQ@mail.gmail.com>
 <1198d3ac-d715-4f82-853e-bf9d0ad9dde7@sifive.com>
In-Reply-To: <1198d3ac-d715-4f82-853e-bf9d0ad9dde7@sifive.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Fri, 21 Mar 2025 11:31:57 -0700
X-Gm-Features: AQ5f1JpAvioRH5pIJkZpbP8QU5kqeF9REnt49n819vwaL6pEMkQ5gEPq1IyxaSg
Message-ID: <CAOnJCUKUY8YQ0UtLa39EkGEjckiOqdnuqEsf2ak4Dcp779iY+Q@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/7] perf vendor events riscv: Update SiFive CPU
 PMU events
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Ian Rogers <irogers@google.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-perf-users@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 1:19=E2=80=AFAM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> Hi Atish,
>
> On 2025-03-01 3:21 AM, Atish Patra wrote:
> > On Wed, Feb 19, 2025 at 1:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> >>
> >> Hello,
> >>
> >> On Wed, Feb 12, 2025 at 05:21:33PM -0800, Samuel Holland wrote:
> >>> This series updates the PMU event JSON files to add support for newer
> >>> SiFive CPUs, including those used in the HiFive Premier P550 board.
> >>> Since most changes are incremental, symbolic links are used when a se=
t
> >>> of events is unchanged from the previous CPU series.
> >>>
> >>> I originally sent this series about a year ago[1], but received no
> >>> feedback. The P550 board is now available (and I have tested this ser=
ies
> >>> on it), so it would be good to get perf support for it upstream.
> >>>
> >>> [1]: https://lore.kernel.org/linux-perf-users/20240509021531.680920-1=
-samuel.holland@sifive.com/
> >>>
> >
> > Tested the patches that are part of sifive's release tree for p550.
> > Both perf stat/record seems to work fine
> > for a bunch of events.
> >
> > Based on that
> > Tested-by: Atish Patra <atishp@rivosinc.com>
>
> Thanks for testing!
>
> > @Samuel Holland : perf report that the following two events are not
> > supported on the p550 board.
> >
> > cycle and instruction count:
> >   core_clock_cycles
> >        [Counts core clock cycles]
> >   instructions_retired
> >        [Counts instructions retired]
> >
> > I assumed that these are raw events cycle/instruction retired events
> > that can support
> > perf sampling as well. Maybe I am missing something ? DT binding ?
>
> perf is correct. Those two events are not supported on P550, only by the =
newer
> cores (bulled-0d and p650). Yes, those are aliases of cycles and instruct=
ions
> that were added to support sampling.
>

Thanks for the confirmation. Are there other events that can be used to sam=
ple
instruction count on P550 ? I did not find anything in the perf list
or the json file.
I am not sure if I missed something.

> Regards,
> Samuel
>
> >>>
> >>> Eric Lin (5):
> >>>   perf vendor events riscv: Update SiFive Bullet events
> >>>   perf vendor events riscv: Add SiFive Bullet version 0x07 events
> >>>   perf vendor events riscv: Add SiFive Bullet version 0x0d events
> >>>   perf vendor events riscv: Add SiFive P550 events
> >>>   perf vendor events riscv: Add SiFive P650 events
> >>>
> >>> Samuel Holland (2):
> >>>   perf vendor events riscv: Rename U74 to Bullet
> >>>   perf vendor events riscv: Remove leading zeroes
> >>
> >> It'd be nice if anyone in the RISC-V community can review this.
> >>
> >> Thanks,
> >> Namhyung
> >>
> >>>
> >>>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  6 +-
> >>>  .../cycle-and-instruction-count.json          | 12 +++
> >>>  .../arch/riscv/sifive/bullet-07/firmware.json |  1 +
> >>>  .../riscv/sifive/bullet-07/instruction.json   |  1 +
> >>>  .../arch/riscv/sifive/bullet-07/memory.json   |  1 +
> >>>  .../riscv/sifive/bullet-07/microarch.json     | 62 +++++++++++++
> >>>  .../riscv/sifive/bullet-07/watchpoint.json    | 42 +++++++++
> >>>  .../cycle-and-instruction-count.json          |  1 +
> >>>  .../arch/riscv/sifive/bullet-0d/firmware.json |  1 +
> >>>  .../riscv/sifive/bullet-0d/instruction.json   |  1 +
> >>>  .../arch/riscv/sifive/bullet-0d/memory.json   |  1 +
> >>>  .../riscv/sifive/bullet-0d/microarch.json     | 72 +++++++++++++++
> >>>  .../riscv/sifive/bullet-0d/watchpoint.json    |  1 +
> >>>  .../sifive/{u74 =3D> bullet}/firmware.json      |  0
> >>>  .../arch/riscv/sifive/bullet/instruction.json | 92 +++++++++++++++++=
++
> >>>  .../arch/riscv/sifive/bullet/memory.json      | 32 +++++++
> >>>  .../arch/riscv/sifive/bullet/microarch.json   | 57 ++++++++++++
> >>>  .../arch/riscv/sifive/p550/firmware.json      |  1 +
> >>>  .../arch/riscv/sifive/p550/instruction.json   |  1 +
> >>>  .../arch/riscv/sifive/p550/memory.json        | 47 ++++++++++
> >>>  .../arch/riscv/sifive/p550/microarch.json     |  1 +
> >>>  .../p650/cycle-and-instruction-count.json     |  1 +
> >>>  .../arch/riscv/sifive/p650/firmware.json      |  1 +
> >>>  .../arch/riscv/sifive/p650/instruction.json   |  1 +
> >>>  .../arch/riscv/sifive/p650/memory.json        | 57 ++++++++++++
> >>>  .../arch/riscv/sifive/p650/microarch.json     | 62 +++++++++++++
> >>>  .../arch/riscv/sifive/p650/watchpoint.json    |  1 +
> >>>  .../arch/riscv/sifive/u74/instructions.json   | 92 -----------------=
--
> >>>  .../arch/riscv/sifive/u74/memory.json         | 32 -------
> >>>  .../arch/riscv/sifive/u74/microarch.json      | 57 ------------
> >>>  30 files changed, 555 insertions(+), 182 deletions(-)
> >>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07=
/cycle-and-instruction-count.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07=
/firmware.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07=
/instruction.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07=
/memory.json
> >>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07=
/microarch.json
> >>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07=
/watchpoint.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d=
/cycle-and-instruction-count.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d=
/firmware.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d=
/instruction.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d=
/memory.json
> >>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d=
/microarch.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d=
/watchpoint.json
> >>>  rename tools/perf/pmu-events/arch/riscv/sifive/{u74 =3D> bullet}/fir=
mware.json (100%)
> >>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/in=
struction.json
> >>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/me=
mory.json
> >>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/mi=
croarch.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/firm=
ware.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/inst=
ruction.json
> >>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p550/memo=
ry.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/micr=
oarch.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/cycl=
e-and-instruction-count.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/firm=
ware.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/inst=
ruction.json
> >>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/memo=
ry.json
> >>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/micr=
oarch.json
> >>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/watc=
hpoint.json
> >>>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instr=
uctions.json
> >>>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memor=
y.json
> >>>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/micro=
arch.json
> >>>
> >>> --
> >>> 2.47.0
> >>>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish
>


--=20
Regards,
Atish
