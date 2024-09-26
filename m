Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440EC14BFBF
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364284; cv=none; b=URLMNATITMU9iAFNd2fDUf4UsssXtXuQzW/d4URRusUWpGGzSlj7S9API1I6mpcJALdr/tJx6Q8xmKWRZqHRt786UOk1PBkoeEcSxBm1mtgNjewSkwwpE+oRPs7BPC+ulXvmqr108iMNtJ8uWtrMw+HVsicJZpyjWagcjAtLwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364284; c=relaxed/simple;
	bh=tWOE5PVxgweBsGOCcwxlLqKgtdcWyCzelH3BfOBeCWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EG462SXdlcprQs+EdztDYM39YThNcosCPnQT9UbCESCLKS8meS0AcC27gsYZSa9bSpuakIcI1XEBh2tcYT4zUJjJgkdQOh1A0K26KWgA334EqT5eh3B6AMl6ZmYOdVylUaQ7+fCaztuhVGfLhCX9nl7pwtxrkWcmPZTXAFULVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4tAJN9B; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4tAJN9B"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a1a662a633so297255ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727364282; x=1727969082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cuozky+jSgphlfbjVUk1IVqqC1GBqHG5gttlN+XqLXo=;
        b=R4tAJN9BMAIeHIEOwbmJtGyD4d+3Ds7r+l8AiT1Fmn70/GjHAsqJ6511vH7l35jo9/
         QM2hV7IHtfFFf6HJM6h817nEResWqVL7ujRBqpyY6pknxqldvZqUtY5wtA7UBLPkzj1s
         FIPnBP0xVcQSsrvwpEoVbr4CZMI9kUT6LM4Lrp8gjAwWiKabjYHHuecs4iC/wvi03CDb
         X6ZprcuNlzhg0CVQg+SVZIYu5JVXEsTR+dtzbVC9G62HQI6A+bzV/L2TOgjYm+szVgbB
         GXz4Y73ZVmdFuMGTuzRNvwQ4AKo44G0yIr6K5vE8PQYjyIVfCtVYNargRU4pRYihBlMK
         a5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364282; x=1727969082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cuozky+jSgphlfbjVUk1IVqqC1GBqHG5gttlN+XqLXo=;
        b=QqSTd1BPPxNfS/xNhMCdTiwEUDrSWZSRj/i9v8MLwQB6yD7WaH/5uA5YrSItjwDTzM
         jPAn2V/PJa9II/cccB5L+YF9WQMjmo11LNOL8nETNPApD0GBEafB/PyOd6q0YkW13TtU
         WAKBjhXkUDY49iXsMaZNUig0hGbhYeIHj4yEpsLa7VKDDu1vekpDNmaiphL9d8BZMKrE
         ztS3KzY9vxix3NLweYQAoWPRmpT/THr3N3XH1Tt2Of9xxS7qFIYE68e2q+wkUIGC8rix
         cw5oKs8nfQKiwB+QhAcgQ1RKWOgkHlpwtUum5A0oHyMO4ftV7K3nMaVbr+QXGgjVMFe8
         eXXg==
X-Forwarded-Encrypted: i=1; AJvYcCUCjIeqj2JrutJ+QDhCxM4T7Em5ckNOTwtE8QtW4QDp44e4hs+36+v5jmAk+d0Ltzt1gplWBvexUa8Go98zwuwJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUxFZqzGA9SCpCS7HiSE7zXTKDAoqElbmQ/d9fWy64HUKTXW6
	JqrMKKGQpQC1A/g9Cyr6OvpjmAVJo7QegxdkhwiER++nkYcdcb0/vsl/0H8MU5jNlbIFi12xg4E
	T1PHB3qjnPJTG0DnWAvCWWIkuXJffGgfLGKff
X-Google-Smtp-Source: AGHT+IF+pkiQR5ZICxIzgaVR1r/qBi/cTigcDOdzamXJJzmngzf3LDyfiHsC0+kY+zgGFhP9nOwK2tLWIVBxqCTefIA=
X-Received: by 2002:a05:6e02:b28:b0:3a0:926a:8d35 with SMTP id
 e9e14a558f8ab-3a31b665b0amr3984075ab.17.1727364282140; Thu, 26 Sep 2024
 08:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925173013.12789-1-irogers@google.com> <ZvTojjciV9pFbGJi@google.com>
In-Reply-To: <ZvTojjciV9pFbGJi@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 08:24:30 -0700
Message-ID: <CAP-5=fXJ-Nd-8EUPD+JXy=chZX_7nFYMxRR5L_ovn83+Tt1f_g@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Ignore security failures in all PMU test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 9:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Sep 25, 2024 at 10:30:13AM -0700, Ian Rogers wrote:
> > Refactor code to have some more error diagnosis on traps, etc. and to
> > do less work on each line. Add an ignore situation for security failure=
s.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/stat_all_pmu.sh | 52 ++++++++++++++++++++------
> >  1 file changed, 40 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/=
shell/stat_all_pmu.sh
> > index d2a3506e0d19..42456d89c5da 100755
> > --- a/tools/perf/tests/shell/stat_all_pmu.sh
> > +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> > @@ -1,23 +1,51 @@
> > -#!/bin/sh
> > +#!/bin/bash
> >  # perf all PMU test
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  set -e
> > +err=3D0
> > +result=3D""
> > +
> > +trap_cleanup() {
> > +  echo "Unexpected signal in ${FUNCNAME[1]}"
> > +  echo "$result"
> > +  exit 1
> > +}
> > +trap trap_cleanup EXIT TERM INT
> >
> >  # Test all PMU events; however exclude parameterized ones (name contai=
ns '?')
> > -for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]=
\+[[:space:]]//g'); do
> > +for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]=
\+[[:space:]]//g')
> > +do
> >    echo "Testing $p"
> >    result=3D$(perf stat -e "$p" true 2>&1)
> > -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<n=
ot supported>" ; then
> > -    # We failed to see the event and it is supported. Possibly the wor=
kload was
> > -    # too small so retry with something longer.
> > -    result=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> > -    if ! echo "$result" | grep -q "$p" ; then
> > -      echo "Event '$p' not printed in:"
> > -      echo "$result"
> > -      exit 1
> > -    fi
> > +  if echo "$result" | grep -q "$p"
> > +  then
> > +    # Event seen in output.
> > +    continue
> > +  fi
> > +  if echo "$result" | grep -q "<not supported>"
> > +  then
> > +    # Event not supported, so ignore.
> > +    continue
>
> I'm curious about this case.  It'll show up even if it's not supported
> right?  Then the first condition would match and it doesn't reach here.
>
>   $ perf stat -e LLC-loads true
>
>    Performance counter stats for 'true':
>
>      <not supported>      LLC-loads
>
>          0.001213558 seconds time elapsed
>
>          0.001373000 seconds user
>          0.000000000 seconds sys

We carry this change at Google for an issue on older series kernels. I
was resending the patch as a courtesy in the migration of development
work to:
https://github.com/googleprodkernel/linux-perf
I'm okay with this being a Google only change.

Thanks,
Ian

> > +  fi
> > +  if echo "$result" | grep -q "Access to performance monitoring and ob=
servability operations is limited."
> > +  then
> > +    # Access is limited, so ignore.
> > +    continue
> > +  fi
> > +
> > +  # We failed to see the event and it is supported. Possibly the workl=
oad was
> > +  # too small so retry with something longer.
>
> Ok, maybe we want to check "<not counted>" events specifically.
>
> Thanks,
> Namhyung
>
>
> > +  result=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> > +  if echo "$result" | grep -q "$p"
> > +  then
> > +    # Event seen in output.
> > +    continue
> >    fi
> > +  echo "Error: event '$p' not printed in:"
> > +  echo "$result"
> > +  err=3D1
> >  done
> >
> > -exit 0
> > +trap - EXIT TERM INT
> > +exit $err
> > --
> > 2.46.0.792.g87dc391469-goog
> >
