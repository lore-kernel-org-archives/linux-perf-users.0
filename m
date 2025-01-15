Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD421D90C8
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976046; cv=none; b=noqut2ZTlRhNSYmO8GSYMmXSmLb9UCrSCdPCPofcwPx90zi+Dn3Xz+mw0h2CqfwABrUSga8wK+QDdcsd+Oazww/SNswCVUxlrgsTyAAYnTxraQDxlLHPVQ+auFElZozT1oZLlx1bVpGbpriAGtRydjreE4CWERuAP+F2Ve6MYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976046; c=relaxed/simple;
	bh=RFQGnF82QQKEbPHmfAURW3WE2od1aVQDJNiwGyvFllE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGy1y35fhH/4svb6J4rmdniY/6huDs56yN68xl0kKIw/QIf7aISJxUsAXfLYkd3skmuEIny8+bvLuw+4yCPvx4uThqSn5qxHDzRaScQNgKjlopmlvVbV9NN+8aH4a2FKUKr1fJ3IVyM5Qa5rKQOsKeD3b3YiyTmGyr/gj+vxoWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eTBPd0SZ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eTBPd0SZ"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a814c54742so6985ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736976044; x=1737580844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeZMzdoAZOaC7hUZA2ynOD6FiOeCO3Zdi0LI3tDnsEQ=;
        b=eTBPd0SZBFKe/dxyjXJsrP4KMoUpKvomEuY3XRS1J3qAOnazgdHGM0MYXu722OCHsy
         8QnwGU+UgoWnkKaRgQQubgorvEU2Fn14pj9VqnneG25xSRGNcti437frMSEKAVBAc9sM
         zqCQJjg4DpSERFqr6kViXbqEm8hnGTvw70eWdqNp/I6kwNN3EMzf0qG7VniWv58t+7I8
         V+taB1LcqGlX7SKBLjCJuXdxxE2QYaDZ8rxNM1FJNDGZDKEE91VoQePTB7XOkc338DY6
         iiXT4tFg0NcLYWqUsA3X0ormxkoINHJQwCh/BW2u6TCBhBsdDpyErLLxdkn/GQH3JS0o
         peuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736976044; x=1737580844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeZMzdoAZOaC7hUZA2ynOD6FiOeCO3Zdi0LI3tDnsEQ=;
        b=ZrEpgid2xo2G1sPSs/HfbysKHwZPz7ysJ3sg94t8eks8zlUz1072/gzqT+p4tAUFC9
         C08YI6bo/GgFX3q6Fer+k1RKUaFZj88nLeYSzNojNHCQtVhONy/KRySZ5I7v/PVzdDy9
         BPkqb31a19iNrQ11N7+NCfHgqO5kDHJbPH1hASSyGNLC2Cn/oXJO6jXakKLEDmfGOGwC
         +BOoBTYYXZpkyDy/XTKqDZe9Io1cIDfY+j2Kdh4a8lfJC11lUlFZz88O0/3kOTrKNdoN
         2pp/xaGao5WjE+XBfOtgr05y2LdIae1rROaRp4XJ9STeRb8o5IDByvWk0VucUZzXZa9G
         x9xA==
X-Forwarded-Encrypted: i=1; AJvYcCVpkViAoIZ+dEZEhrdO1Q5kH0JorsSJqeIyyMA9J9Wbv/SFfJi4cG95l9AI9QBNkBGY6cv2kTWZavfVqle4MnN6@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGcNcTAFpIhlgxunlfb5Gu02tuDRnurABDeETLyNoR2Nod+Hz
	4EU3JPIQ5PU8i9HJHLbEAXPCSNmKszeY30WCV8wZ0ifuzYlN/XVGMgiv1WPoDikk8fnnI9Exr+d
	hEed/q9WbDufvkjRYf+73skVI11SVOOiqXYK/
X-Gm-Gg: ASbGnctug8jl7TsW2iqCH0LJwq467CJEUj1oIxUEbtJbk8gKe6mmsxhaI6Zzdix0MH7
	f34SjvUQDC7m426RGAev78shFsqEFpQIQmSJpUnvQkB54wVb/xbUjd6fz8BcTCssF2ee1SQ==
X-Google-Smtp-Source: AGHT+IFdY3EdK0RlcaqR7XkhN3TwPfkXvTLWVLDZLyVErZSKQhkg++eul6BWJ+ye5pTMy/Cw/yGmyMYIs/WijFhs82g=
X-Received: by 2002:a05:6e02:13af:b0:3a7:e616:8d36 with SMTP id
 e9e14a558f8ab-3cee99d21f9mr659135ab.9.1736976043998; Wed, 15 Jan 2025
 13:20:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-5-irogers@google.com>
 <Z4F3qxFaYnMTtPw7@google.com> <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com> <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com> <Z4f3fDXemAMpBNMS@google.com>
In-Reply-To: <Z4f3fDXemAMpBNMS@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Jan 2025 13:20:32 -0800
X-Gm-Features: AbW1kvYyQa9lv756_leTn8rvCmcqj4_u0BB6bMWojLD8QesTDfLByWCEv88e_84
Message-ID: <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 9:59=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> > On Mon, Jan 13, 2025 at 2:51=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > > There was an explicit, and reviewed by Jiri and Arnaldo, intent with
> > > the hybrid work that using a legacy event with a hybrid PMU, even
> > > though the PMU doesn't advertise through json or sysfs the legacy
> > > event, the perf tool supports it.
>
> I thought legacy events on hybrid were converted to PMU events.

No, when BIG.little was created nothing changed in perf events but
when Intel did hybrid they wanted to make the hybrid CPUs (atom and
performance) appear as if they were one type. The PMU event encodings
vary a lot for this on Intel, ARM has standards for the encoding.
Intel extended the legacy format to take a PMU type id:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/include/uapi/linux/perf_event.h?h=3Dperf-tools-next#n41
"EEEEEEEE: PMU type ID"
that is in the top 32-bits of the config.

> > >
> > > Making it so that events without PMUs are only legacy events just
> > > doesn't work. There are far too many existing uses of non-legacy
> > > events without PMU, the metrics contain 100s of examples.
>
> That's unfortunate.  It'd be nice if metrics were written with PMU
> names.

But then we'd end up with things like on Intel:
UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD
becoming:
uncore_cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD/
or just:
cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD/
As a user the first works for me and doesn't have any ambiguity over
PMUs as the event name already encodes the PMU. AMD similarly place
the part of a pipeline into event names. Were we to break everybody by
requiring the PMU we'd also need to explain which PMU to use. Sites
with event lists (like https://perfmon-events.intel.com/) don't
explain the PMU and it'd be messy as on Intel you have a CHA PMU for
server chips but a CBOX on client chips, etc.

> I have a question.  What if an event name in a metric matches to
> multiple unrelated PMUs?

The metric may break or we'd aggregate the unrelated counts together.
Take a metric like IPC as "instructions/cycles", that metric should
work on a hybrid system as they have instructions and cycles. If you
used an event for instructions like inst_retired.any then maybe the
metric will fail on one kind of core that didn't have that event. Now
if we have accelerators advertising instructions and cycles events, we
should be able to compute the metric for the accelerator. What could
happen today is that the accelerator will have a cpumask of a single
CPU, we could aggregate the accelerator counter into the CPU event
with the same CPU as the cpumask, we'd end up with a weird quasi CPU
and accelerator IPC metric for that CPU. What should happen is that we
get an IPC for the accelerator and IPC for each hybrid core
independently, but the way we handle evsels, CPUs, PMUs is not really
set up for that. Hopefully getting a set of PMUs into the evsel will
clear that up. Assuming all of that is cleared up, is it wrong if the
IPC metric is computed for the accelerator if it was originally
written as a CPU metric? Not really. Could there be metrics where that
is the case? Probably, and specifying PMUs in the event names would be
a fix. There have also been proposals that we restrict the PMUs for
certain metrics. As event names are currently so distinct it isn't a
problem we've faced yet and it is not clear it is a problem other than
highlighting tech debt in areas of the tool like aggregation.

> > >
> > > Prior to switching json/sysfs to being the priority when a PMU is
> > > specified, it was the case that all encodings were the same, with or
> > > without a PMU.
> > >
> > > I don't think there is anything natural about assuming things about
> > > event names. Take cycles, cpu-cycles and cpu_cycles:
> > >  - cycles on x86 is only encoded via a legacy event;
> > >  - cpu-cycles on Intel exists as a sysfs event, but cpu-cycles is als=
o
> > > a legacy event name;
> > >  - cpu_cycles exists as a sysfs event on ARM but doesn't have a
> > > corresponding legacy event name.
>
> I think the behavior should be:
>
>   cycles -> PERF_COUNT_HW_CPU_CYCLES
>   cpu-cycles -> PERF_COUNT_HW_CPU_CYCLES
>   cpu_cycles -> no legacy -> sysfs or json
>   cpu/cycles/ -> sysfs or json
>   cpu/cpu-cycles/ -> sysfs or json

So I disagree as if you add a PMU to an event name the encoding
shouldn't change:
1) This historically was perf's behavior.
2) Different event encodings can have different behaviors (broken in
some notable cases).
3) Intuitively what wildcarding does is try to open "*/event/" where *
is every possible PMU name. Having different event encodings is
breaking that intuition it could also break situations where you try
to assert equivalence based on type/config.
4) The legacy encodings were (are?) broken on ARM Apple M? CPUs,
that's why the priority was changed.
5) RISC-V would like the tool tackle the legacy to config mapping
challenge, rather than the PMU driver, given the potential diversity
of hardware implementations.

To this end we hosted RISC-V's perf people at Google and they
expressed that their preference was what this series does, and they
expressed this directly to you.

I don't think there would be an issue in this area if it wasn't for
Neoverse and Linus - that's why the revert happened. This change in
behavior was proposed by Arnaldo:
https://lore.kernel.org/lkml/ZlY0F_lmB37g10OK@x1/
and has tags from Intel, ARM and Rivos (RISC-V). I intend to carry it
in Google's tree.

Thanks,
Ian
