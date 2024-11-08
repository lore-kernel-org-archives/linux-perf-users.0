Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C41991BD
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085168; cv=none; b=l6HsQC9sqaQGju6vjYMdTIrR7G7C04lPT9hcc0K0QzNQcHE2lzn1spD/qEGqg/0d6I8NjI2um5EudwV1FsQJ8dLptA+yDbuhq322LAUUif+iv3RwHHlBpphEHJK4gG8bahpuxdTQ4hGGui/G09c/UfZRcVfX9TzXVd52wH3iGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085168; c=relaxed/simple;
	bh=FxOwEU7IugwTghyB5emCVNuAEHOm3lbOrlBOS5dvYys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pi3Lu6P06JOLCsWZNJr44CKM3YeE9Upe6V4dz9mYYkpVQcBorsS49XT2pJuTUz8ET7327H2OiTgzPiB3zNx1ieWAoPzqEQjyfAsRvR3UL73n0jyBYltSXDkZRmJh6WGTUM9y0V5MGoq+WhxdeVboHJJYBUTIi+HDU4YYa6mlTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=eIhBgKF8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="eIhBgKF8"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed7d8c86cso418348866b.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 08:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1731085163; x=1731689963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgetP3QbjEJJR1PWLs7vPWsjlPdnJzS53NVUV8Nth3g=;
        b=eIhBgKF8XCS/HR9YuKOb5LQbugUTAAybSlayyGXVqamITOjVd+UpM4NfnUfxviq84F
         0/yysm61YOFqKgv7O6o5FRBEZ6WCmPbBRCiD8BvNhiX2sd2hZip7Sz1bVC+WCfbmf0x8
         RddXfPMssrcVs18jX04Q6VI/OWN3HAjJaJWnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731085163; x=1731689963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgetP3QbjEJJR1PWLs7vPWsjlPdnJzS53NVUV8Nth3g=;
        b=OaZ2xC6cewysoqKGFSUkvfi6QgDnSkC5zTiRoOP+T0h4JGvtfI9RHN7uvuqvxTN5YV
         CleNOkbc/Q7dBE8SpyYJpQ9naSoQHN3o1m+H+xI6Oqi0pUWCgobV2vCNYSkdu9shluqz
         +uJiDXg4MxFhj5TEaAIImpNxodBtUIazFa0dxFMniMJi4ZAbWKqdsfWyYD2eZFiAODI+
         KNaeckeUSKNSeiB/Js1k8o7tCqtwujyMdpL8Z3wByPfLYYb0osdCbFuleTYyf6ihFvsP
         FrKy3vP0HN+/YXzZh/Lc5u6GlPXqMQqc+jBw4M4VNAoAFwJtqawLVd0CV5ZvjzwudwaT
         h0zg==
X-Forwarded-Encrypted: i=1; AJvYcCXdmGm4DaknRbn4bnoEIpCX7jKtQqHv9dOWvAffJilyZcLg7QNWZqeGnwXhBCbcSCfHRZl5s6WlyEeFxEJV5Rbp@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6IibPi/NG4K2epdmsmKjUIoV+RiRojB83r2droi6z7/dguOX
	tQmWFks/eqj58ohHh0Z4zUMK94MCYbmEp9W7uBLymD02cWlMCBxo7WQxx8lWsg5KBoNNikgE9ta
	b9xyqfoLxwxjeyhSrNMjAEK/1mdfmI+7KMzBPZcDQBEZJbST+JnjgTQ==
X-Google-Smtp-Source: AGHT+IFuqAeVM5yCf/A+bKTr2dEaXy0Y7y4jGGnzz6A7XL5usbkAt6whB8phaWDQTTN4T1mN8kkHJZVJG1d7rPmZbx4=
X-Received: by 2002:a17:907:6d07:b0:a99:caf5:c897 with SMTP id
 a640c23a62f3a-a9eefeecb18mr312195366b.20.1731085163199; Fri, 08 Nov 2024
 08:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106234518.115234-1-benjamin@engflow.com> <20241106234518.115234-2-benjamin@engflow.com>
 <CAH0uvohtu_XQochZ_nguXN4e65C_m88Chip1mm84uDRLBXagzA@mail.gmail.com>
 <CAEmfU+ud__oG3NyQsVri1xztU-JhqA=WE-y=1STxqibejnuLYA@mail.gmail.com> <CAH0uvojrdxWSEd5r9J_8b39VV6qCTM3j0t1ZAsq8p596LTunqw@mail.gmail.com>
In-Reply-To: <CAH0uvojrdxWSEd5r9J_8b39VV6qCTM3j0t1ZAsq8p596LTunqw@mail.gmail.com>
From: Benjamin Peterson <benjamin@engflow.com>
Date: Fri, 8 Nov 2024 08:59:11 -0800
Message-ID: <CAEmfU+vfYY8jVD-mLuRBVrk9M8OFCNiptXQjL1Rf+S5XtjiDVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tests: add test for trace output loss
To: Howard Chu <howardchu95@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 8:20=E2=80=AFAM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Hello Benjamin,
>
> On Thu, Nov 7, 2024 at 3:18=E2=80=AFPM Benjamin Peterson <benjamin@engflo=
w.com> wrote:
> >
> > On Thu, Nov 7, 2024 at 2:07=E2=80=AFPM Howard Chu <howardchu95@gmail.co=
m> wrote:
> > >
> > > Hello,
> > >
> > > On Wed, Nov 6, 2024 at 3:46=E2=80=AFPM Benjamin Peterson <benjamin@en=
gflow.com> wrote:
> > > >
> > > > Add a test that checks that trace output is not lost to races. This=
 is
> > > > accomplished by tracing the exit_group syscall of "true" multiple t=
imes and
> > > > checking for correct output.
> > > >
> > > > Conveniently, this test also serves as a regression test for 5fb8e5=
6542a3 ("perf
> > > > trace: avoid garbage when not printing a trace event's arguments") =
because
> > > > exit_group triggers the previously buggy printing behavior.
> > > >
> > > > Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> > > > ---
> > > >  tools/perf/tests/shell/trace_exit_race.sh | 31 +++++++++++++++++++=
++++
> > > >  1 file changed, 31 insertions(+)
> > > >  create mode 100755 tools/perf/tests/shell/trace_exit_race.sh
> > > >
> > > > diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf=
/tests/shell/trace_exit_race.sh
> > > > new file mode 100755
> > > > index 000000000000..8b70324bc5b4
> > > > --- /dev/null
> > > > +++ b/tools/perf/tests/shell/trace_exit_race.sh
> > > > @@ -0,0 +1,31 @@
> > > > +#!/bin/sh
> > > > +# perf trace exit race
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +# Check that the last events of a perf trace'd subprocess are not
> > > > +# lost. Specifically, trace the exiting syscall of "true" 100 time=
s and ensure
> > > > +# the output contains 100 correct lines.
> > > > +
> > > > +# shellcheck source=3Dlib/probe.sh
> > > > +. "$(dirname $0)"/lib/probe.sh
> > > > +
> > > > +skip_if_no_perf_trace || exit 2
> > > > +
> > > > +trace_shutdown_race() {
> > > > +       for i in $(seq 100); do
> > > > +               perf trace -e syscalls:sys_enter_exit_group true 2>=
>$file
> > > > +       done
> > > > +       [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_=
enter_exit_group\(\)$" $file) =3D "100" ]
> > >
> > > The test failed due to regex mismatched, I think because of this:
> > >
> > >      0.000 true/1526046 syscalls:sys_enter_exit_group( )
> > >      0.000 true/1526212 syscalls:sys_enter_exit_group( )
> > >      0.000 true/1526383 syscalls:sys_enter_exit_group(SSSSSSSSSSSSSSS=
S)
> > >
> > > Ironically the junk buffer problem you fixed last time, thanks for
> > > finding another printing problem in perf trace :), I'll figure out th=
e
> > > cause of this.
> >
> > Thanks, the problem is a parallel issue with trace__fprintf_sys_enter.
> > I will include a patch for the problem in my spin of this series.
> >
> > >
> > > Another thing is this test takes a long time to finish
> > >
> > > perf $ time ./perf test 109
> > > 109: perf trace exit race                                            =
: FAILED!
> > >
> > > real    0m38.762s
> > > user    0m15.090s
> > > sys     0m21.794s
> > >
> > > Is it really necessary to run it 100 times? To me it seems to be just
> > > a wrong handling logic of draining samples, will there be coincidence=
?
> >
> > Yes, it's racy. In my testing, sometimes the correct output would
> > appear. However, I will reduce the number of iterations to 10.
>
> Could you be a bit more specific about this race condition issue?

From the code, it's apparent that if the SIGCHLD from the traced
process is seen before the exit_group trace event, output will be
lost. If the signal is received after the trace event, the trace event
will be correctly printed.

> Could you please tell us how one might emulate and test the scenario
> you mentioned? I ran the command 1,000 times before and after applying
> the patch, and each time I got the expected output. Could you please
> provide more information about your use cases?

I can see it simply by running the unpatched perf few times in the
terminal, but it might be helpful for reproduction to create some
scheduling contention with stress.
