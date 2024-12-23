Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5BE1B4144
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Dec 2024 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734985576; cv=none; b=SDrDc/kedhOsiC8xGeFAjSso9v1FAG7tAUYQPN1PUiktGo5f/Mw6lJqmvhp5zXmK/Ibb2RKQam/D4oMkftLGuhg/2GmzJi2q5H1acx8M4lq4fGkYQyxPpQhOeA9jAQqbKlYfTJbKq40uITlE1mrPIcQZDxSaCX80VsmqdRBnprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734985576; c=relaxed/simple;
	bh=x3/N64MxpcRQFSU2o9ngqSZwz4vbqNRBLkM1w34epQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=og3ERfupnNwJcINRuAAM/rT0/vUgfBZ/dvllav/tAyABqxxvua8qmB6ojsVKaX4oVstBcAlVKtKDGb6GBcNWRLGjgmKaaJkTKIkXy59otk6vDSMFtWUF9vkj+ujgimHw8H24KZQWdKzf/dxzhHxu0LqxeRNqAvLUPgW19md1j5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BL5R/IGb; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BL5R/IGb"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so574805ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Dec 2024 12:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734985574; x=1735590374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILdk1XYX6u56rFptJ+Y4LqgKKhCG5GAp2Sd3/Fh9KN8=;
        b=BL5R/IGbtD0k3iqAjCffKoNUNuDwa03iQZoZkQ68fcs+zTfEFaqySzhGHtxQiIvBkl
         oLz0iho+YqPnmSJyHR1wWELAObQPgXKIS67FZbREOi9tXGk2z2ist5G3ySnLs+fxIkdn
         Jf8WJlP+nT5c6gvGRexSWfJDF6s4Uo1SMuDy4dIRsZGnrsFvoLhbGQ4KD4JpIgnFExoM
         Yw6+ZeWmfLWts/omyMy8Su/9CjjjY+JeOrCQ3F7OXvuWIcb5eJ02AyNUBgUngbVoIc22
         a2QA6Y3LtEIYbCcn2pwG6Jll6mElKqdAOtLsAZoQFlksCijVfIE3ntN55PsXgHWexI54
         ZcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734985574; x=1735590374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILdk1XYX6u56rFptJ+Y4LqgKKhCG5GAp2Sd3/Fh9KN8=;
        b=bUNW1fXc0NJ0zEBZZ1uV4j7Tdmf9vCnX6RR5lAqAjY/Sx68CzhT6i74/SLoY2QugxJ
         taMQaMwUQbNZmaM3388diUZC9DkjDge9Ee2TTrTO0RPIYiBExRqF+TPauuJ4c4z3Ez95
         oskKquyEKD7/Ha5DTS/KrptY++l0ZcAEKyNwjmZkKU/+QjEfYGHGKH5HsD29dzawsyPE
         lAsIjmKfQrUW8QdumCt6rtEPZTu+f2UEBP3rLpUmW6gqp/uIYmzmB5+TaCFD1tJdV9c4
         TYjWqZiKgtgXF6ZR8+Rf7xliqPksHZp0T/z1lRKgKUCdhp2c3xLMlp6aEqRKl/J++x+b
         Ix/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbMYEcp1c9eQxpGpnLtay0XDmidVs2V8HMFhSOKRtvyIOSgvqnTYnx3wif9XUNMudrKkS9/sTo5bIHZq0PQBWV@vger.kernel.org
X-Gm-Message-State: AOJu0YzsWVBqSrkvgUNTsyO4qUtCpxe6TC3y+RnyHxslwLoiR/II6tnH
	Kc5CINSplQrdhsG3TQDw/Sj1T2oVGeLpfjXrzIrkU17jf9G6UyHtZ83NnOmMZB6SvdGwkb/d+on
	1GhfN5hrlsQdL7KYEH7lrsBZYJ1bSj1ElL4Cf
X-Gm-Gg: ASbGncuaggJUDMa183qCicfYxFYQrc6/SJvbSUWeuhSj98JGUNso4caeUN+PnJi6GoL
	fjHRRarjm8Ve6cibj3UzI67+iLiDlBSUdKEGUAhc=
X-Google-Smtp-Source: AGHT+IF1KdMwvxlsIFl3RZPFZMoeP9UsFLGJhYlHMrPcHiNtVBWvmE53FVpXRstDAT8ortANAQBBthCL9njDU0TPQLs=
X-Received: by 2002:a92:c0cf:0:b0:3a7:e616:8d21 with SMTP id
 e9e14a558f8ab-3c33139baa9mr7607825ab.9.1734985573897; Mon, 23 Dec 2024
 12:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216070244.14450-1-adrian.hunter@intel.com>
 <20241216070244.14450-8-adrian.hunter@intel.com> <CAP-5=fUwjYH8uvmsgSN=1exN1FEEBEPQHFYwgq4cJEeOApFNQg@mail.gmail.com>
 <7e438859-26c3-4ad6-850b-21b9ab6078c3@intel.com> <CAP-5=fX8hWF-PaAE2VKHW3fk1W19xd0hyBVsP3653J9xw-U7VQ@mail.gmail.com>
 <68747890-ae9f-476a-97a9-f3cf3424e379@intel.com>
In-Reply-To: <68747890-ae9f-476a-97a9-f3cf3424e379@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Dec 2024 12:26:01 -0800
Message-ID: <CAP-5=fW+0YhM5EG7j3RGawp56u14JN3kXqLLPk-g5Fh8UPB=5Q@mail.gmail.com>
Subject: Re: [PATCH V16 7/7] perf intel-pt: Add a test for pause / resume
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 11:17=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 22/12/24 18:54, Ian Rogers wrote:
> > On Sat, Dec 21, 2024 at 11:30=E2=80=AFAM Adrian Hunter <adrian.hunter@i=
ntel.com> wrote:
> >>
> >> On 21/12/24 19:10, Ian Rogers wrote:
> >>> On Sun, Dec 15, 2024 at 11:03=E2=80=AFPM Adrian Hunter <adrian.hunter=
@intel.com> wrote:
> >>>>
> >>>> Add a simple sub-test to the "Miscellaneous Intel PT testing" test t=
o
> >>>> check pause / resume.
> >>>>
> >>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>> Acked-by: Ian Rogers <irogers@google.com>
> >>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> >>>> ---
> >>>>  tools/perf/tests/shell/test_intel_pt.sh | 28 ++++++++++++++++++++++=
+++
> >>>>  1 file changed, 28 insertions(+)
> >>>>
> >>>> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/te=
sts/shell/test_intel_pt.sh
> >>>> index e6f0070975f6..f3a9a040bacc 100755
> >>>> --- a/tools/perf/tests/shell/test_intel_pt.sh
> >>>> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> >>>> @@ -644,6 +644,33 @@ test_pipe()
> >>>>         return 0
> >>>>  }
> >>>>
> >>>> +test_pause_resume()
> >>>> +{
> >>>> +       echo "--- Test with pause / resume ---"
> >>>> +       if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt/=
aux-action=3Dstart-paused/u uname ; then
> >>>> +               echo "SKIP: pause / resume is not supported"
> >>>> +               return 2
> >>>> +       fi
> >>>> +       if ! perf_record_no_bpf -o "${perfdatafile}" \
> >>>> +                       -e intel_pt/aux-action=3Dstart-paused/u \
> >>>> +                       -e instructions/period=3D50000,aux-action=3D=
resume,name=3DResume/u \
> >>>> +                       -e instructions/period=3D100000,aux-action=
=3Dpause,name=3DPause/u uname  ; then
> >>>> +               echo "perf record with pause / resume failed"
> >>>> +               return 1
> >>>> +       fi
> >>>> +       if ! perf script -i "${perfdatafile}" --itrace=3Db -Fperiod,=
event | \
> >>>> +                       awk 'BEGIN {paused=3D1;branches=3D0}
> >>>> +                            /Resume/ {paused=3D0}
> >>>> +                            /branches/ {if (paused) exit 1;branches=
=3D1}
> >>>> +                            /Pause/ {paused=3D1}
> >>>> +                            END {if (!branches) exit 1}' ; then
> >>>> +               echo "perf record with pause / resume failed"
> >>>> +               return 1
> >>>> +       fi
> >>>> +       echo OK
> >>>
> >>> Hi,
> >>>
> >>> this new test is now constantly making "Miscellaneous Intel PT testin=
g" fail:
> >>>
> >>> ```
> >>> ...
> >>> --- Test with pause / resume ---
> >>> Error:
> >>> Failure to open event 'intel_pt/aux-action=3Dstart-paused/u' on PMU
> >>> 'intel_pt' which will be removed.
> >>> The 'aux_action' feature is not supported, update the kernel.
> >>> Linux
> >>> [ perf record: Woken up 1 times to write data ]
> >>> [ perf record: Captured and wrote 0.003 MB
> >>> /tmp/perf-test-intel-pt-sh.Hs8jcq0ADc/test-perf.data ]
> >>> Error:
> >>> Failure to open event 'intel_pt/aux-action=3Dstart-paused/u' on PMU
> >>> 'intel_pt' which will be removed.
> >>> The 'aux_action' feature is not supported, update the kernel.
> >>> Error:
> >>> Failure to open event 'Resume' on PMU 'cpu' which will be removed.
> >>> The 'aux_action' feature is not supported, update the kernel.
> >>> Error:
> >>> Failure to open event 'Pause' on PMU 'cpu' which will be removed.
> >>> The 'aux_action' feature is not supported, update the kernel.
> >>> Linux
> >>> [ perf record: Woken up 1 times to write data ]
> >>> [ perf record: Captured and wrote 0.005 MB
> >>> /tmp/perf-test-intel-pt-sh.Hs8jcq0ADc/test-perf.data ]
> >>> perf record with pause / resume failed
> >>> --- Cleaning up ---
> >>> ...
> >>> ```
> >>>
> >>> Should the fail be turned into a skip for missing kernel support?
> >>
> >> Seems to skip for me with perf-tools-next:
> >>
> >> --- Test with pause / resume ---
> >> Error:
> >> The 'aux_action' feature is not supported, update the kernel.
> >> SKIP: pause / resume is not supported
> >>
> >> perf version 6.13.rc2.g39c2547579aa
> >
> > My mistake, I thought I tested a clean client but I was testing with:
> > https://lore.kernel.org/lkml/20241221192654.94344-1-irogers@google.com/
> > The issue there is that intel-pt is opening multiple dummy events in th=
is test:
>
> >
> > That is a dummy event is added in 2 places:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/x86/util/intel-pt.c?h=3Dperf-tools-next#n800
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/x86/util/intel-pt.c?h=3Dperf-tools-next#n865
> >
> > I'll need to update my patch set for things outside of record adding
> > dummy events, but I'm curious if the intel-pt code could share a
> > single dummy evsel?
>
> I doubt it.  There are cases where capturing auxiliary events
> like text_poke or context_switch want to be system-wide while
> the workload task events (comm, task, mmap2) are not.

Thanks, I'll rework the dummy event detection because of this. I'm a
little concerned about APIs like `evlist__findnew_tracking_event`, nit
that we're inconsistent on naming (dummy vs tracking vs sideband),
perhaps we need an enum to capture the different
dummy/tracking/sideband event kinds for APIs like this, given the
expectation that there can be >1. Something I hope to do for uncore
evsels is to move the multiple PMUs into the evsel itself. My hope is
that will help with `perf stat` aggregation logic and the like, as
well as simplifying event sorting. Perhaps the evsel for a
dummy/tracking/sideband event can cover >1 use-case to reduce the
evlist's evsels.

Thanks,
Ian
