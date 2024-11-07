Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3019B5B1
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731021493; cv=none; b=JQrgSWbC/s4bqCg5Vflux/pjWQTIK4YvUiu8I+heHpDfJLmR7hCn1rmmUhCHHKnKnT5U8AKSm4G57dGMi+UlxtPM9eiWlv1/sPvKGpd8o4O/lds7eGsAegS8Q+/4cOoVHAwxnweySY/DZb6KGdAxonf7MbufhLuWyXyEqFPP93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731021493; c=relaxed/simple;
	bh=UsCYobydzKsg8aLIC1XwhAcdJoxlWDz42bNImpN16BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyDZBCeSpVpu2PMW6+SozW3dZDuoScDDc8KytrEH2jLL/4+ZZl9KsT1y6te5NEgoRmCJXchGZAkKJzFVE7XHZOOsgpu7JA8yp3teSfO2LuUshSvYVdZ3wQcPL8cXdsJVhQ4zI9InXp32pfmf5+IRGMQirVGajvAhoP62lvDgsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=DlJeBQce; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="DlJeBQce"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ed7d8c86cso264862866b.2
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 15:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1731021489; x=1731626289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuPuhI4YOphQos4FAxS9zY7xpHdfbrfyr5AbTQ8jrQ4=;
        b=DlJeBQceBC+23LXEKWMeXlKnXaepBAoZaULgSdNwZ4KOX0RQZbeQqgYNMribR5cDWX
         0g0mLl52FU+wiR8sYXKpJZzOF7UeERgb3vOEAKERs1lyuPZ+TWEPiMqJdQM84ZdRmtLY
         R3a2sf7Q6D35Gv5i9JQ2YlLg7nNOjEuw8Ue/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731021489; x=1731626289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuPuhI4YOphQos4FAxS9zY7xpHdfbrfyr5AbTQ8jrQ4=;
        b=P8mp8JcwykWvK95jIO7dHcNF4lAVVYZ/BffkpqxrHxpRzzpJN8M6H6EH61NfrC63+L
         yejgmskoffv0UzSd6mUklfqeUEEtr7wXleQiooERknxmtyZZ2Zfw2daa+N1RAKvImSgo
         CxjjLbD2IWa6zPqM9VyDPH/CSmKlfakR9UsSERYwinfpdrzhYBuT2l9wH85Ny+wVisNW
         WErsWatC+NCNZlJW45pb+A9f2/ZoweIMcao4GYh0LAE9HoqGTd33pNG2jkvQMaotCYAY
         pdbAIWb+dzhx6P8E1+bE76TNhhJNJ/JfBDcGeiDJEbuDsueNWW6UZPlBK66W9yS6zz4Z
         7BQA==
X-Forwarded-Encrypted: i=1; AJvYcCWVK1n+0A5+U/OJXxtrYsxf3YirqDREMB6zrAkVu+cMjxIQECyUV/jm0X6jJPpqyH6VbPi2HhOpt6a/TBsuY98j@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuqLHPZ+A5Pnn/lX61yIU/GZ5McM/OM62MN4vbN9mUdpL3nR9
	AU/jBiS6KCHPWXnozV9FN5J6osqwbIuzrwh4z2HcuWMoF7CKPq6CPjYlVhRsZpfjJrO4Afb6SMj
	IU4PuLZtPL8mMQ7zBpVHJFS/vHJQQhJVKavTTFA==
X-Google-Smtp-Source: AGHT+IFD5XwI3/WZ+1nbUNXOoh2R40lEtfpSHeXEVrCkmgzQY62ot03zLjITgu7X7vxOvc2WCY7puV21cR2YmlWEmjA=
X-Received: by 2002:a17:907:7dab:b0:a9a:3cf:cdb8 with SMTP id
 a640c23a62f3a-a9eeff3adaamr49171966b.36.1731021489093; Thu, 07 Nov 2024
 15:18:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106234518.115234-1-benjamin@engflow.com> <20241106234518.115234-2-benjamin@engflow.com>
 <CAH0uvohtu_XQochZ_nguXN4e65C_m88Chip1mm84uDRLBXagzA@mail.gmail.com>
In-Reply-To: <CAH0uvohtu_XQochZ_nguXN4e65C_m88Chip1mm84uDRLBXagzA@mail.gmail.com>
From: Benjamin Peterson <benjamin@engflow.com>
Date: Thu, 7 Nov 2024 15:17:58 -0800
Message-ID: <CAEmfU+ud__oG3NyQsVri1xztU-JhqA=WE-y=1STxqibejnuLYA@mail.gmail.com>
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

On Thu, Nov 7, 2024 at 2:07=E2=80=AFPM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Hello,
>
> On Wed, Nov 6, 2024 at 3:46=E2=80=AFPM Benjamin Peterson <benjamin@engflo=
w.com> wrote:
> >
> > Add a test that checks that trace output is not lost to races. This is
> > accomplished by tracing the exit_group syscall of "true" multiple times=
 and
> > checking for correct output.
> >
> > Conveniently, this test also serves as a regression test for 5fb8e56542=
a3 ("perf
> > trace: avoid garbage when not printing a trace event's arguments") beca=
use
> > exit_group triggers the previously buggy printing behavior.
> >
> > Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> > ---
> >  tools/perf/tests/shell/trace_exit_race.sh | 31 +++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/trace_exit_race.sh
> >
> > diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tes=
ts/shell/trace_exit_race.sh
> > new file mode 100755
> > index 000000000000..8b70324bc5b4
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/trace_exit_race.sh
> > @@ -0,0 +1,31 @@
> > +#!/bin/sh
> > +# perf trace exit race
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# Check that the last events of a perf trace'd subprocess are not
> > +# lost. Specifically, trace the exiting syscall of "true" 100 times an=
d ensure
> > +# the output contains 100 correct lines.
> > +
> > +# shellcheck source=3Dlib/probe.sh
> > +. "$(dirname $0)"/lib/probe.sh
> > +
> > +skip_if_no_perf_trace || exit 2
> > +
> > +trace_shutdown_race() {
> > +       for i in $(seq 100); do
> > +               perf trace -e syscalls:sys_enter_exit_group true 2>>$fi=
le
> > +       done
> > +       [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_ente=
r_exit_group\(\)$" $file) =3D "100" ]
>
> The test failed due to regex mismatched, I think because of this:
>
>      0.000 true/1526046 syscalls:sys_enter_exit_group( )
>      0.000 true/1526212 syscalls:sys_enter_exit_group( )
>      0.000 true/1526383 syscalls:sys_enter_exit_group(SSSSSSSSSSSSSSSS)
>
> Ironically the junk buffer problem you fixed last time, thanks for
> finding another printing problem in perf trace :), I'll figure out the
> cause of this.

Thanks, the problem is a parallel issue with trace__fprintf_sys_enter.
I will include a patch for the problem in my spin of this series.

>
> Another thing is this test takes a long time to finish
>
> perf $ time ./perf test 109
> 109: perf trace exit race                                            : FA=
ILED!
>
> real    0m38.762s
> user    0m15.090s
> sys     0m21.794s
>
> Is it really necessary to run it 100 times? To me it seems to be just
> a wrong handling logic of draining samples, will there be coincidence?

Yes, it's racy. In my testing, sometimes the correct output would
appear. However, I will reduce the number of iterations to 10.
