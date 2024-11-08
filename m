Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89034176ADE;
	Fri,  8 Nov 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082842; cv=none; b=t4Xu7y/P3FODY+AH7Tl6s0EDGVdZ+NHYfkLzRRt5fnVpChhgzc/MVQUnywpYRaSMEOaTbU3/hwe3xkdxLC8V9cdden5v6qyygYUnbFAvWKODLq6npyrxX7fUhdg4lTJTGN+QVWDJToKB1mGFI+O0i3zccuwnI4E4XlYUCRI14OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082842; c=relaxed/simple;
	bh=a6fIUuK4YS+dt5RSiKYC2s2rmN/h5Fnu1S45NhoPLG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdzQuUqMrvtonIZu5Dh+15opBKmEWyVcP8vQMatdim51BdnuRyty0CIOcuThQFoI1YyeMe4OUX3N4fV6qX3PKJP+wzMxgf49HsXFg/3DpJIjzfOEoQ9JUzI0rAiWl8bT6YCwA0V/1PVrGIvKMpxybaHdY7e47S579dzq6ySSUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQf1uGHm; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQf1uGHm"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea15a72087so19336457b3.1;
        Fri, 08 Nov 2024 08:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731082839; x=1731687639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RecYzKiXphg0WpiL7Y/QP/0aGLiBYuk2qpr+7styx70=;
        b=HQf1uGHmXKXgaA93HF05oayzRwrVRev8ywiDxuNTpAg6Q7usK2rT3KTDGJNsPZUqGC
         EfC68yQo/sOWodOrhiACcFGAqhgATdDO7Fmb+KlXtifA4nX759rQ0OftZUsWbjbMuxqd
         3QQrrQTtvPGUBfPlS8qGewKN35poRnAPmYrXwfPDKraoj7OKB0pykGJZElPL6vNbx29g
         c/GgtEL/oIU+Wdpkt2kpnzvuPJi/0/qMFWRvaKlNkCzA4/hM+V+3t4WgfHJHfkPCY0sh
         7xGDKeWxtt6gGkW9fcrdfNgJe5jxtPZPLYltiD5YzrRNDU+PzLD2q1wwu9BYYoO0JrjC
         onjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731082839; x=1731687639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RecYzKiXphg0WpiL7Y/QP/0aGLiBYuk2qpr+7styx70=;
        b=FLMp6DNC+qg6fdJdc3LiGHawWmwG+sLBpPLeYDaNha5+WBDazZ3NG2T38Pd7SmX6kE
         GhorvBcpWag6dw7khmbZV1lPoEmIkRvr+J77czaxTJD+J311bsykn+slsw6V3+Q+y2Rn
         R1QnF8cSPF06MW1lXfOcD7vqe94QHpzV1/7kXWXDt9sCIm4nlsoI/W9+M0hVD+sJDFMo
         rz5biotKQiYMYNz3fOjeHruzTX4loiP6Nuqarhonlk3KO5gcMyo9yTX7CHx6cXjM8Tg+
         AV1vwA6iUmt8PjdNeM/F8fX/DLftkY4amuZTLi4mIbN6MlG4eWvvQ+uE1zQ9DuERxeDj
         wEXg==
X-Forwarded-Encrypted: i=1; AJvYcCVwEMjGFAI4lze1eCZCWdHIvpFoTlzDidFePwUO6OLFCkhNE2tYAMEflDi+JHXJOJjAWKjPIwbtCcMtkJk=@vger.kernel.org, AJvYcCW2s38TrQTrYR9l6c/Y1Zcr3iA7EA7J/3fY+8y23qk7lrhv7wKKFGEVCluhZMWXtMqnx5I9yvMx/8hIvUGSZzma7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWlIUOPTw+vMbhfoAhqjOOK2sYuYylMe4JQrMGw5jtN4B4xnbw
	ddQGjc32LT8yFJqw+tibvr5aWmUAyyITXEnj0h7LAxG31P0GIdx4xwAivi72GX2M6dBwzceEOo8
	y3b0L2GkBKDaT/GuVJPyjRWINuew=
X-Google-Smtp-Source: AGHT+IFopCInIlYwjWwvOp1AcsrIxLJKHonmG3c7SF1xIZ7wqhXHqWyHN1z30Fd1wyPYKeo2Bnhk39d1bBPHlwVV814=
X-Received: by 2002:a05:690c:7448:b0:6dd:e837:3596 with SMTP id
 00721157ae682-6eaddd9703amr40052697b3.14.1731082839276; Fri, 08 Nov 2024
 08:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106234518.115234-1-benjamin@engflow.com> <20241106234518.115234-2-benjamin@engflow.com>
 <CAH0uvohtu_XQochZ_nguXN4e65C_m88Chip1mm84uDRLBXagzA@mail.gmail.com> <CAEmfU+ud__oG3NyQsVri1xztU-JhqA=WE-y=1STxqibejnuLYA@mail.gmail.com>
In-Reply-To: <CAEmfU+ud__oG3NyQsVri1xztU-JhqA=WE-y=1STxqibejnuLYA@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 8 Nov 2024 08:20:28 -0800
Message-ID: <CAH0uvojrdxWSEd5r9J_8b39VV6qCTM3j0t1ZAsq8p596LTunqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tests: add test for trace output loss
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Benjamin,

On Thu, Nov 7, 2024 at 3:18=E2=80=AFPM Benjamin Peterson <benjamin@engflow.=
com> wrote:
>
> On Thu, Nov 7, 2024 at 2:07=E2=80=AFPM Howard Chu <howardchu95@gmail.com>=
 wrote:
> >
> > Hello,
> >
> > On Wed, Nov 6, 2024 at 3:46=E2=80=AFPM Benjamin Peterson <benjamin@engf=
low.com> wrote:
> > >
> > > Add a test that checks that trace output is not lost to races. This i=
s
> > > accomplished by tracing the exit_group syscall of "true" multiple tim=
es and
> > > checking for correct output.
> > >
> > > Conveniently, this test also serves as a regression test for 5fb8e565=
42a3 ("perf
> > > trace: avoid garbage when not printing a trace event's arguments") be=
cause
> > > exit_group triggers the previously buggy printing behavior.
> > >
> > > Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> > > ---
> > >  tools/perf/tests/shell/trace_exit_race.sh | 31 +++++++++++++++++++++=
++
> > >  1 file changed, 31 insertions(+)
> > >  create mode 100755 tools/perf/tests/shell/trace_exit_race.sh
> > >
> > > diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/t=
ests/shell/trace_exit_race.sh
> > > new file mode 100755
> > > index 000000000000..8b70324bc5b4
> > > --- /dev/null
> > > +++ b/tools/perf/tests/shell/trace_exit_race.sh
> > > @@ -0,0 +1,31 @@
> > > +#!/bin/sh
> > > +# perf trace exit race
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +# Check that the last events of a perf trace'd subprocess are not
> > > +# lost. Specifically, trace the exiting syscall of "true" 100 times =
and ensure
> > > +# the output contains 100 correct lines.
> > > +
> > > +# shellcheck source=3Dlib/probe.sh
> > > +. "$(dirname $0)"/lib/probe.sh
> > > +
> > > +skip_if_no_perf_trace || exit 2
> > > +
> > > +trace_shutdown_race() {
> > > +       for i in $(seq 100); do
> > > +               perf trace -e syscalls:sys_enter_exit_group true 2>>$=
file
> > > +       done
> > > +       [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_en=
ter_exit_group\(\)$" $file) =3D "100" ]
> >
> > The test failed due to regex mismatched, I think because of this:
> >
> >      0.000 true/1526046 syscalls:sys_enter_exit_group( )
> >      0.000 true/1526212 syscalls:sys_enter_exit_group( )
> >      0.000 true/1526383 syscalls:sys_enter_exit_group(SSSSSSSSSSSSSSSS)
> >
> > Ironically the junk buffer problem you fixed last time, thanks for
> > finding another printing problem in perf trace :), I'll figure out the
> > cause of this.
>
> Thanks, the problem is a parallel issue with trace__fprintf_sys_enter.
> I will include a patch for the problem in my spin of this series.
>
> >
> > Another thing is this test takes a long time to finish
> >
> > perf $ time ./perf test 109
> > 109: perf trace exit race                                            : =
FAILED!
> >
> > real    0m38.762s
> > user    0m15.090s
> > sys     0m21.794s
> >
> > Is it really necessary to run it 100 times? To me it seems to be just
> > a wrong handling logic of draining samples, will there be coincidence?
>
> Yes, it's racy. In my testing, sometimes the correct output would
> appear. However, I will reduce the number of iterations to 10.

Could you be a bit more specific about this race condition issue?
Could you please tell us how one might emulate and test the scenario
you mentioned? I ran the command 1,000 times before and after applying
the patch, and each time I got the expected output. Could you please
provide more information about your use cases?

Thanks,
Howard
