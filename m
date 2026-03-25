Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28426351C29
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774477639; cv=pass; b=eenlyCIAGOJvGNkpn9fxgBuXRinqxyJpBsuXOvVFAQGwgjF1NiVTCODEwVn/gLNRkAd8yPNwQxgOOjIV5/gQqhL4MwQm4cPph+Q6wRxvEZf/NN3ltCR/DVSVDt8OWzFY9fxgDKyT+47MiiPPd69U0fwmy22Q4HBatnxJE0FQ0fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774477639; c=relaxed/simple;
	bh=HYB4bnwVzonzBECd4nX+KH7nX0UiDGcn4H16hv4XA4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6Q375rTK/Hbog5PP/6tQTuTunHtyfcPSc65igxMUCzulYWw079MVfNbITyrwhH2U/uDfQxGD8eBpYROOj+tKIn+fsocvmEK5cc9ds7b6fK3RN980UqMWNp+2AXEZfH3Tr77Ut7xnOfC5vu+KToZPi+yrSpHSmV7NMeNN/RUohY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BmiRiFNa; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BmiRiFNa"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aeab6ff148so17685ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 15:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774477637; cv=none;
        d=google.com; s=arc-20240605;
        b=Z/Gax+avbiacJf+edgUn3gHmYaj84tPHrMxgU1cgSKV033j72FblXYxJZcz6Jglkpz
         0Eazsi3oVNlHa+j5zPUsS714W162IAtc8ZdoHHCrm1caUaEezVuAdIeCwSoe/wHWCqW8
         +15rN2vC/y45fKgz3cSk+TqtEf6gjssVPHyL66Aq+XAuACUgtkRxNAcFmhSnp4qeomEh
         nANO/RIDf3Xl++TPGWaCtM+PqTx+2ddMTHqNXpdSOk2F22TrUAZT31x+vw0QdLx3+bp8
         z031Xxp4we3+i0sI2LHMAOVRuscm0e+FN/36vSMPAaLXK1vHXacyUMEKmV+/4yJpOELT
         SCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d2pv3vdtFK8ecxqfvOFGpTxlpmLoK7AAjbFbeT7IQVs=;
        fh=sZGQBgk7wBGqvnysh2Wf0joYszvz0Xw85RR+vQYhL38=;
        b=EX3JShUYREUiJ5Nj8sg2Simmiwb1jzxSAnaPv+/bFR874hawFouIpN9w1kudt7bhtK
         u3BSL1SA62hFgFaemGYFmuswTcyzmcSqAVMztnLLcH0ST6Gczk0oHEwpgGIb9OdrRLQc
         DQPtNvSxfsEIhYtPGC+lyaN8JYRc4FBb//T+ZxkKIiSCPfYCbMHy2f1Vrkqi4HMjaINi
         WsuxwlPohMwJGvogD7B4G45BJnWgxMv0WyhYsS2vzX7ON9nVm9+qDlfwc3jV1zM56wN8
         j5sE11ZC2BXFWCovFqWe0Ot5+xxD2ZTqW6N4RS9S30fWSgzmOtjZ5jI6vm9Y45k40Dkp
         ku/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774477637; x=1775082437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2pv3vdtFK8ecxqfvOFGpTxlpmLoK7AAjbFbeT7IQVs=;
        b=BmiRiFNajy4ive/SsZttsbjwfghOTKtsWEn6Azf75B7oeH/JTCoF4nUyTQfwz4km9S
         svtfcFWU4W2GVeakZbFvJdcfATI4hXy1bgpgy6SKxgfmYjLIAUEMyOy0PSvBNm7o37YG
         oalk5THBUgN+FlHPPmStgmKDRqHRpmMZ7ZbPmFWRCRZsTkAN/wSeyzj+gG66yaJFryLF
         SjVXJV2UXIFy/yBR5exBcsLJWClLjq06JP1Jv6Vzk4QxIkY+8Tnuo4bHgiRMdiGSi/2K
         Z6WacZ7tr3T3V7B+bofjNmBxY5jTiz1+nYbbvSN3V32RxWHmpM2wrg42ZszpCBi8cde6
         xGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774477637; x=1775082437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2pv3vdtFK8ecxqfvOFGpTxlpmLoK7AAjbFbeT7IQVs=;
        b=sHlbnV3m9274Nj/8wMPmSlZZ6UL78vtzBoq2RrYRL58oc/iJDI/pjyhyFdF2acZoQ7
         /QWNUif6gjbM6bBnMrMfDRmEmuXOpDNoUwefCaaAVMJQ6Iu8BNNJ1UMPyUYN5MMWgeGw
         Ng28IP64fi6U2pO7ZlAobH/kxOKFmU57MlTRVIIM7/tf7Uca7O1Z5XBPBmBY/6wX5aBu
         9y7NR99u8+VgxCA1/VUEC8K0u5UVJPL9mYXmGpYRNhcOxV6MxUpyC2V5cFhl6n2trxTq
         CZ+tJ4nBRAClUHW8nz8tirKudc6/jGrbZYPysmBLhnShoqfPtBPhtfhJ1ICLPi5Ak2TT
         i7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUkELPMZ4x/jQ7AQyMQVTo+PYdMxEb9AMCflT0wGJlntDOKwO3uVpmpF+diIgfGs+yL1QEGFXu4RWU8pPekeAaa@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWUnkRHHaa2veYTPHUKBHig4C2whcR1VWGLkfj2WQ3P5wPiDh
	IRaWA5t84l+IH2ClJx8r3H015cre48Al+ohn9DDfBKEuBHoK5tqRrZBPj5gXdAwFfle5aiodcF9
	D7cQa/QJkIAxyoMoFPe0g+EJs5AXxpqqaWKUBDteB
X-Gm-Gg: ATEYQzxsxrrIOBqR41uQcIfRKgn2jzzU13oJrAoOdqxUo/zNfLpblL012hlfmdhswgn
	1PxYPCPKyTMzDFs3aP8CgaT2LXRXyeqU6Bpik09Poc0MZHKjKJgIRwsCbLc50oskD7DQ+z0kMae
	fbUAMxUbySDy4/XzskDPYJH7c7mkblntrI1D+4qiBo3OvZ8oJNtvELd9cka5Oqeo8Ppmvt+X0kE
	IPImR3foJzaraW+b0pcKHbKYMkJeQC6mf9/9hUP5ux02AQmvk+1VjyP/Av12mnNm6hIaUXNWCUA
	WSv6uhsYUbujjmagbl8UzvQ8XAVFIOJweQjDIQ==
X-Received: by 2002:a17:903:3804:b0:2b0:5e19:1862 with SMTP id
 d9443c01a7336-2b0c12141d0mr320815ad.5.1774477636840; Wed, 25 Mar 2026
 15:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org> <20260325205914.GA356832@e132581.arm.com>
In-Reply-To: <20260325205914.GA356832@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Mar 2026 15:27:05 -0700
X-Gm-Features: AaiRm53YyVvgNaCxy-pC5wU700TqqW6bvGSkFbF9suByHf7327E8gR8buE76dR4
Message-ID: <CAP-5=fWkbhffgL6BJjpiwRV6rD3yd=KkOz7-ODH2FnORBf70bQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Fix crash on arm64
To: Leo Yan <leo.yan@arm.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>, Dmitry Ilvokhin <d@ilvokhin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 1:59=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> On Wed, Mar 25, 2026 at 03:24:30AM -0700, Breno Leitao wrote:
> > Perf stat is crashing on arm64 hosts with the following issue:
> >
> >       # make -C tools/perf DEBUG=3D1
> >       # perf stat sleep 1
> >       perf: util/evsel.c:2034: get_group_fd: Assertion `!(!leader->core=
.fd)' failed.
> >       [1]    1220794 IOT instruction (core dumped)  ./perf stat
> >
> > The sorting function introduced by commit a745c0831c15c ("perf stat:
> > Sort default events/metrics") compares events based on their individual
> > properties. This can cause events from different groups to be
> > interleaved, resulting in group members appearing before their leaders
> > in the sorted evlist.
> >
> > When the iterator opens events in list order, a group member may be
> > processed before its leader has been opened.
> >
> > For example, CPU_CYCLES (idx=3D32) with leader STALL_SLOT_BACKEND (idx=
=3D37)
> > could be sorted before its leader, causing the crash when CPU_CYCLES
> > tries to get its group fd from the not-yet-opened leader.
> >
> > Fix this by comparing events based on their leader's attributes instead
> > of their own attributes when the events are in different groups. This
> > ensures all members of a group share the same sort key as their leader,
> > keeping groups together and guaranteeing leaders are opened before thei=
r
> > members.
> >
> > Reported-by: Denis Yaroshevskiy <dyaroshev@meta.com>
> > Fixes: a745c0831c15c ("perf stat: Sort default events/metrics")
> > Tested-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
>
> As Arnaldo mentioned in v1, I also found Segmentation fault when
> testing this patch:
>
>  Program received signal SIGSEGV, Segmentation fault.
>  metricgroup__copy_metric_events (evlist=3D0xaaaaab037750, cgrp=3D0x0, ne=
w_metric_events=3D0xaaaaab038210, old_metric_events=3D0xaaaaab038d20) at ut=
il/metricgroup.c:1662
>  1662                    evsel =3D evlist__find_evsel(evlist, old_me->evs=
el->core.idx);
>  (gdb) bt
>  #0  metricgroup__copy_metric_events (evlist=3D0xaaaaab037750, cgrp=3D0x0=
, new_metric_events=3D0xaaaaab038210, old_metric_events=3D0xaaaaab038d20) a=
t util/metricgroup.c:1662
>  #1  0x0000aaaaaab05870 in add_default_events () at builtin-stat.c:2110
>  #2  0x0000aaaaaab08300 in cmd_stat (argc=3D0, argv=3D0xfffffffffaa0) at =
builtin-stat.c:2838
>  #3  0x0000aaaaaab40998 in run_builtin (p=3D0xaaaaaaf9d428 <commands+360>=
, argc=3D4, argv=3D0xfffffffffaa0) at perf.c:348
>  #4  0x0000aaaaaab40c14 in handle_internal_command (argc=3D4, argv=3D0xff=
fffffffaa0) at perf.c:398
>  #5  0x0000aaaaaab40ddc in run_argv (argcp=3D0xfffffffff8bc, argv=3D0xfff=
ffffff8b0) at perf.c:442
>  #6  0x0000aaaaaab41110 in main (argc=3D4, argv=3D0xfffffffffaa0) at perf=
.c:549
>
> Last week I tested v1 and confirmed the issue was gone with the change,
> I will dig a bit in tomorrow and share back if any finding.
>
> Apologies for my lazy, as I should double check once Arnaldo
> pointed out in v1.


From the stack trace I don't see anything that should allow this.
Either the list of metrics is broken, or the struct metric_event's
evsel is NULL. But that should never happen as we wouldn't have a
metric at that point. The sorting shouldn't affect that. If you can
reproduce the issue, verbose logs may help.

Thanks,
Ian

> Thanks,
> Leo
