Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F429219F3;
	Tue, 10 Sep 2024 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944424; cv=none; b=AMq1p83fMbNwQka23NGoRGcOWOgXNYojU0M2eXhKJZHDcrGRWIJLRWewRPLlAvQaEUf+byZT+ZX+9YQCuVE9HwzGMs4r2Ihe1fGeWg7Nye35TVIxwkwxsf7nUYqKeY0ZaytdYod57/TP2BOXDnN5m8H5TmWGO1lcGsHyKm1g9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944424; c=relaxed/simple;
	bh=HBKiSMIWRdorqFF6k44fvtV22mxFyyVsRfOnW+ecS8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eu5DAYfCn6Sx8BLyMiPPJ+dod77Y5GbvFBjgVKvJ24DEDs26Vyr4Qy42B4XW++cYc84WszP6yx7P5egeHT2ldAMjJ96pRHo/xeIgHvB6Qv7gdumXNlaNrFIfK+Uk4GBUSjQrAZntwbKsotTAEl3AXuTv5lGjT6/VYPR2MsjJDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JruRvj3R; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JruRvj3R"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1cf1a4865aso4805215276.2;
        Mon, 09 Sep 2024 22:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725944422; x=1726549222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cL0xS0wayOjEvkyYZECg4JW1vW4xZXRD7am42+ruQcs=;
        b=JruRvj3RupTDFsSAz6Mleyt8LDv744du2Y6bbVxI4/h6P+AjqcYC/TYejSS14VROoZ
         kHFhP/mJ/xnjvvNniA4xDSPJxUTKTJAHSVUBiRT7/NQXuSgCVSopOu6sqlmFt/GVPqx6
         yu6NW3ojpki9gORjz+Xu7xI5qxJo8kdq1A44PLwgK9A2yEo3yLxyVQ8L50SPF31Jq1GR
         +U2ruUut6bhdTHyr+PEU6YUvp3JkZZDmNigEvnKfEyDFI5OMQcG89M17joUghLu5K+OZ
         +QyGWYrOghDPWJ1XBcgbxkWWa0/YqF7ZzUoD0Gl/DPkbKlUqq/nXxiPT/SNWzw67N+NG
         qjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725944422; x=1726549222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cL0xS0wayOjEvkyYZECg4JW1vW4xZXRD7am42+ruQcs=;
        b=IKeCMqEMOPnwePaodJcknQEiZRFMfdWkExTA4lCycfUzsvliXswiztMUD17+O1qwd5
         i54YS+MMIc6zdV4KmIFJsPAI74/t3WwAULvz5TOQQ5N9gQq9wlpZ/sK/vxbmgUE1ZsFp
         jDOKQbuztPZEv8l8UjlT/ps5sxifKr1o5snLgiZAOIXqJRA1taiE2f19AMyg2VJOZ5TK
         OCr+h1jS2aCoTNDGxLN+7fVIdwfqG7fP3Ph3LpEYK/l8uPrZq9Rawhjt9uXweNmf5gO5
         j8DAu1sy4NX+byRYTXRS2KqADVQgZqT/dHh7lGvq9mLVPk/eyJ6rrFLyKGyY1iWgd1+V
         ga8A==
X-Forwarded-Encrypted: i=1; AJvYcCVFlAPhzN2R0bEPqgZzP9UejhcwxELExftd9OzlEw3XS7Ed6aCOQ5mu6GPDbkAjtHxhnmunXowNFkAofGRVN/vxSw==@vger.kernel.org, AJvYcCWY7gttbETlcWlyWdXkCXH0BYPMOlsiQ5SZLEUwX3lvfV8GabunKZ8uKd6wHfJVdcoZQcujlffZSGk4/LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuVmOnhdXIGeHI8y/7mMrdYxJ//dMLYBP/b+/gVqOmF1vkjCZ
	KI3pjQxFM6gfjPGH0xvnnVtUeLY/7JKJCum26nHmfyrw5YCQijn7U7Z/E6u+ImDu6KPBkKh6R7w
	KkznDWOlHiii1IAMb2nmHSQFUcrY=
X-Google-Smtp-Source: AGHT+IHaQEliCCpTQV+8HCcyD5VltnYLEkhDUKF3RHye8KXcT4VdpwB6RCMNMFTSlKYrBJrptYGHgHyrX7PfdQq7wgo=
X-Received: by 2002:a25:2614:0:b0:e1d:42ca:f1e with SMTP id
 3f1490d57ef6-e1d42ca0fa9mr10806489276.15.1725944420568; Mon, 09 Sep 2024
 22:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824163322.60796-1-howardchu95@gmail.com> <20240824163322.60796-9-howardchu95@gmail.com>
 <Zt9yiQq-n-W6I274@x1>
In-Reply-To: <Zt9yiQq-n-W6I274@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 9 Sep 2024 22:00:10 -0700
Message-ID: <CAH0uvog6oeXxN3uaaCxLQ00otqhGA-RK0wRcwG4pdBtq9KdBhg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] perf trace: Add general tests for augmented syscalls
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 9, 2024 at 3:11=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Sun, Aug 25, 2024 at 12:33:22AM +0800, Howard Chu wrote:
> > In this test, augmentation for:
> >
> > * string
> > * buffer
> > * struct
> >
> > Is tested.
>
> Please install ShellCheck to test it:
>
>   GEN     perf-archive
>   GEN     perf-iostat
>   TEST    /tmp/build/perf-tools-next/tests/shell/trace_btf_general.sh.she=
llcheck_log
>   CC      /tmp/build/perf-tools-next/util/header.o
>
> In tests/shell/trace_btf_general.sh line 50:
>         echo "Unexpected signal in ${FUNCNAME[1]}"
>                                    ^------------^ SC3028 (warning): In PO=
SIX sh, FUNCNAME is undefined.
>                                    ^------------^ SC3054 (warning): In PO=
SIX sh, array references are undefined.

Sorry my bad, will fix it.

Thanks,
Howard
>
> For more information:
>   https://www.shellcheck.net/wiki/SC3028 -- In POSIX sh, FUNCNAME is unde=
fined.
>   https://www.shellcheck.net/wiki/SC3054 -- In POSIX sh, array references=
 are...
> make[4]: *** [tests/Build:91: /tmp/build/perf-tools-next/tests/shell/trac=
e_btf_general.sh.shellcheck_log] Error 1
> make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:1=
58: tests] Error 2
> make[2]: *** [Makefile.perf:777: /tmp/build/perf-tools-next/perf-test-in.=
o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   LD      /tmp/build/perf-tools-next/util/perf-util-in.o
>   LD      /tmp/build/perf-tools-next/perf-util-in.o
> make[1]: *** [Makefile.perf:292: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> > Please use this command:
> >
> > perf test "perf trace general tests"
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Suggested-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/trace_btf_general.sh | 67 +++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
> >
> > diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/t=
ests/shell/trace_btf_general.sh
> > new file mode 100755
> > index 000000000000..0b4ea8462390
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/trace_btf_general.sh
> > @@ -0,0 +1,67 @@
> > +#!/bin/sh
> > +# perf trace general tests
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +err=3D0
> > +set -e
> > +
> > +. "$(dirname $0)"/lib/probe.sh
> > +skip_if_no_perf_trace || exit 2
> > +
> > +file1=3D$(mktemp /tmp/file1_XXXXX)
> > +file2=3D$(echo $file1 | sed 's/file1/file2/g')
> > +
> > +buffer=3D"this is a buffer for testing"
> > +
> > +trap cleanup EXIT TERM INT HUP
> > +
> > +trace_test_string() {
> > +  echo "Testing perf trace's string augmentation"
> > +  if ! perf trace -e renameat* --max-events=3D1 -- mv ${file1} ${file2=
} 2>&1 | grep -q -E "renameat[2]*.*oldname: \"${file1}\".*newname: \"${file=
2}\".*"
> > +  then
> > +    echo "String augmentation test failed"
> > +    err=3D1
> > +  fi
> > +}
> > +
> > +trace_test_buffer() {
> > +  echo "Testing perf trace's buffer augmentation"
> > +  if ! perf trace -e write --max-events=3D1 -- echo "${buffer}" 2>&1 |=
 grep -q -E ".*write.*buf: ${buffer}.*"
> > +  then
> > +    echo "Buffer augmentation test failed"
> > +    err=3D1
> > +  fi
> > +}
> > +
> > +trace_test_struct_btf() {
> > +  echo "Testing perf trace's struct augmentation"
> > +  if ! perf trace -e clock_nanosleep --force-btf --max-events=3D1 -- s=
leep 1 2>&1 | grep -q -E ".*clock_nanosleep\(rqtp: \{1,\}, rmtp: \{1,\}\).*=
 =3D 0"
> > +  then
> > +    echo "BTF struct augmentation test failed"
> > +    err=3D1
> > +  fi
> > +}
> > +
> > +cleanup() {
> > +     rm -rf ${file1} ${file2}
> > +}
> > +
> > +trap_cleanup() {
> > +     echo "Unexpected signal in ${FUNCNAME[1]}"
> > +     cleanup
> > +     exit 1
> > +}
> > +
> > +trace_test_string
> > +
> > +if [ $err =3D 0 ]; then
> > +  trace_test_buffer
> > +fi
> > +
> > +if [ $err =3D 0 ]; then
> > +  trace_test_struct_btf
> > +fi
> > +
> > +cleanup
> > +
> > +exit $err
> > --
> > 2.45.2
