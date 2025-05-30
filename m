Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E776034;
	Fri, 30 May 2025 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625145; cv=none; b=ZxNjUVYsLuf+V3PF1rYiPxm9E4etmXA2Oj++/1KXp4HkgV4mnNjoGdV9eC320akNBRDI8nfjFz76M097pKSxYt5+6mtEHKtMCXzLAodSjvMvC924y8YMoUlUL31CyqP5NHcHck/MXbgRWe0pTj90/f7jg6Z19ybMe235D6AMXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625145; c=relaxed/simple;
	bh=1VPwN74SM0DtGVcv5AdvHJHGq0USSlu7yM1DezsOIVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgpgKzMq001JDeWt4LAcILOgYWa9wXiYdI6k3KUP8cvXbd+L5UXBJkKOi5tNNkL8YtHrnzUrvP+5n8yvdeMT1dqhOXSjmi2NRiT+jZL64iUXSpz6AmK6okgPz++cI8iordwISc1jqjR5mri7pXVjvWMRgMShIhuQGUQAsbp+jUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2hOTorm; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2hOTorm"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e3c6b88dbso17048027b3.0;
        Fri, 30 May 2025 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748625143; x=1749229943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lNSOjAMfFroLOBhwot5JPzKj1zDI43B2TC6d+niusA=;
        b=Y2hOTormSREZG+4tpRkFvh856er0z/zrpWyD6i9EEnVfeEYwy8dEJU5vP7rvhgjHum
         LxHfmXIiaAAHn7hCW1iaBZhBHymJ4gsfLqEMyQFHEyQLMVCGfgNbMXq8MaZk1FIiATqJ
         JHcE13bSGgpYxSvXctzSnfp5M5LBspkLa43jsM/QZXYMLZY9X/FmKZtEh4QNxH+nxUn5
         +OU4iIR9paziR7g0HsEcRPd3dyjMVR3VnKXd8b60kQWbI1gSywchel9RZwE12FSW5oDJ
         OtzTnPxztG6bl8vxsGsa94ZKiRW/3MKGLEAfLi5lC5KoFNTKOkkEhDbeFQANX0Jy3fxM
         uK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748625143; x=1749229943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lNSOjAMfFroLOBhwot5JPzKj1zDI43B2TC6d+niusA=;
        b=WkuZ/VNgm9i6c7BeEXp7AHVEnHM86aWFId1rM4Lkok8aGvWd+tcQSewm+AgvTs228Y
         o6Tcs9QNA5GXaj/mtnStJTaDxc3mccojFYIXAeQuYVz3ZNjn5j20TdvHOgNF1BLW2MNj
         7rSYV2j/lmithzLpBjKt0DXWZWtYi7DGoZWyFe1FH2reXRiGdyTGMnTaYN+qgM4/bqJ+
         NyOyCqfF3J1iesf7FUepDqZbw7ascKLcnOrj6qaMq/kFVFXLREBXDTIBM/4qoSYgWWLi
         jgUapJH7wRid0Lt4KlPE7qSYxhuchgTmW0K8mFo+lD6kAKcEYHaYtygP/wqPhN2+A+BF
         YSEg==
X-Forwarded-Encrypted: i=1; AJvYcCVu0w7YS1CyQ/TbxjruBha1huJ3jJNSFFeh5MycBv+eYBjWd+vG46JF9amli5yFMBETdMlITpH0a8gdpCw=@vger.kernel.org, AJvYcCXOtw7azy5IRl7bRhTcLgFsMIaSQ4lguBafw/ZDXWUHyMKj3Fzf/w96Bu6ZXleBH/gmJuHXPF+N4AM0cJlUEXyXtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUB1tTnhcVNtSBgxMwYxPMS9JYPZFtdB55gTcoEdAsk/qbG6Ym
	TC/ktkvvsyMAzEKHnJvDAT2K2b6G5ETZA2J3hhgtIWyrs2GTAg4YOacFE/7k04KLRgrG9NttLK6
	cMe6z6Z5CgnP7+m2tSqnyjGRD9PBWrE4=
X-Gm-Gg: ASbGncvJfp0lgfQ/WNi2aioDLcsse9OoI1FWwAe0uKF4eyTxtaAIb2Ip1b2pTpP/1e/
	gxBNrFxqNvz7rYcUAKycIgHh0tnRtNjxfX+eH+gWp9HaqOW7dyDIcm6/dYcweB2V4quhqG1yK9D
	0qVB0HEQRfoLSh+QHkud+gecfJttQlBB99gmS/95RYcg==
X-Google-Smtp-Source: AGHT+IFGWIoaeBGQO4MbFA/c0oijOLEFwSPammZOMT+8lREZY9DoJ17ZZKo6F+9pjJMEdrMDj8cpHSlcpXH6XT4Oo1A=
X-Received: by 2002:a05:690c:5c0a:b0:70f:8835:b767 with SMTP id
 00721157ae682-70f97e3221dmr50164927b3.5.1748625142719; Fri, 30 May 2025
 10:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522142551.1062417-1-namhyung@kernel.org> <CAH0uvoiZ2difXdPsjkdLikHTRwYROYUeuCdZ+gQ5uRfQ2rzwGQ@mail.gmail.com>
 <aC9VoTL_Cv4R7J-j@x1> <aC-hHTgArwlF_zu9@x1> <aDDy4FQe7sBwECL8@google.com>
 <CAH0uvog_5MToOmfcsEn3+hypPrftSvtQAe+Axe94TLNwgq4HbA@mail.gmail.com> <aDjHsJqV7L24qjvT@x1>
In-Reply-To: <aDjHsJqV7L24qjvT@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 30 May 2025 10:12:11 -0700
X-Gm-Features: AX0GCFtaB2Jxpo-c6Ap6Ay5XEjdoSur3ZLAvB0OctX21EMAXBJ2N2Kqp0shQsRM
Message-ID: <CAH0uvoga2g88LM7giL+2RqyVreosSRnEoWGtsaaUeS3B8s5TDQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add cgroup summary test case for perf trace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Thu, May 29, 2025 at 1:46=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, May 28, 2025 at 11:59:44PM -0700, Howard Chu wrote:
> > On Fri, May 23, 2025 at 3:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > > On Thu, May 22, 2025 at 07:11:41PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > From 8c868979d886e2e88aa89f4e3d884e1b6450a7b2 Mon Sep 17 00:00:00 2=
001
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > Date: Thu, 22 May 2025 19:01:47 -0300
> > > > Subject: [PATCH 1/1] perf tests trace_summary.sh: Run in exclusive =
mode
>
> > > > And it is being successfull only when running alone, probably becau=
se
> > > > there are some tests that add the vfs_getname probe that gets used =
by
> > > > 'perf trace' and alter how it does syscall arg pathname resolution.
>
> > > > This should be removed or made a fallback to the preferred BPF mode=
 of
> > > > getting syscall parameters, but till then, run this in exclusive mo=
de.
>
> > > > For reference, here are some of the tests that run close to this on=
e:
>
> > > >   127: perf record offcpu profiling tests                          =
    : Ok
> > > >   128: perf all PMU test                                           =
    : Ok
> > > >   129: perf stat --bpf-counters test                               =
    : Ok
> > > >   130: Check Arm CoreSight trace data recording and synthesized sam=
ples: Skip
> > > >   131: Check Arm CoreSight disassembly script completes without err=
ors : Skip
> > > >   132: Check Arm SPE trace data recording and synthesized samples  =
    : Skip
> > > >   133: Test data symbol                                            =
    : Ok
> > > >   134: Miscellaneous Intel PT testing                              =
    : Skip
> > > >   135: test Intel TPEBS counting mode                              =
    : Skip
> > > >   136: perf script task-analyzer tests                             =
    : Ok
> > > >   137: Check open filename arg using perf trace + vfs_getname      =
    : Ok
> > > >   138: perf trace summary                                          =
    : Ok
>
> > > Looks good to me.
>
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> > Nacked (sorry). I think running them tests in parallel is great
> > because it points out a problem that perf trace has. Please check out
> > this approach: https://lore.kernel.org/linux-perf-users/20250529065537.=
529937-1-howardchu95@gmail.com/T/#u
>
> I'm not saying that perf trace shouldn't be used in parallel, but the
> vfs_getname code, IIRC, checks for the existence of that probe to do
> pathname collection (this predates the BPF method by a long time) and
> then counts on it to do.
>
> There are tests that put it in place and then at the end remove it,
> multiple tests.
>
> So there are possible races with that and out of being conservative I
> made it exclusive for the time being.

Thanks for explaining this.

>
> The plan is to remove that vfs_getname code in builtin-trace.c and then
> the tests, as we have the BPF method that is way better and should allow
> for parallel use.

Agreed.

>
> Probably in the meantime it would be better to mark the vfs_getname ones
> as exclusive tho now that I that I wrote the above explanation... :-\
>
> - Arnaldo

:)

Thanks,
Howard
