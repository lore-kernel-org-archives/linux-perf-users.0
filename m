Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45E15F41E;
	Fri, 21 Jun 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988215; cv=none; b=f+YnkVq1mYs1KI2yM0VVXI8hIWnhbGZXVMYXsWBRS3PXp/iQEjI59XQOqggSnbnyOTzxGA8+rNZXln5LjC8tJshU4ip4fY8rcL64woM/TsstXGHItWgshPWJSFlRaMyuOuMjX9q4bFYxHQ9PsrZkfva2DXmWSGkn1M+qREWw6Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988215; c=relaxed/simple;
	bh=sKwXW1TabD0bJ4Y2jRQ3KymZ0tyaGEMt82vvgXZ9Qb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTDqCjGbTkY8n5wDWJzimchQ8eHy1dqzwIAwxe7iHBEuUTjVg46vwhJ/86wkKQ14IQotA9X+QxSK4Y6VmgRv/IpGgKaA3bQYpBJ3XWQifAyc2Ia/0O5B05MxyPF+HVbpcR4GntmhtEk98tJ0f9fWBbs3YU3gug25RLEI58XwygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI9/on5A; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI9/on5A"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e02c4168e09so2065696276.2;
        Fri, 21 Jun 2024 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718988213; x=1719593013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYhlBIwPc5g8CbEQRnexlhzN/p56ugUpYFTcdezwQPI=;
        b=UI9/on5AUtvyTg5x67wtixaQimVgCQy4AhKK7FchAFLx3eR28v1tHgCf2DSprSaxp+
         Gw7X+Nolw0jLx3ydR+xYHfLZhqov6P7ZUjonRii6gTlzWf7RopQ7plxGgKznjQFqI5S5
         p3oU5/gt4jU44BT3RQhXY2xUh8yLeKJyjZJcL5+cOvVtz4ADNVMqWkHnNL2+jksk3fcC
         WTMuFWtRHjUy/Yo8YiI3m/1NcY7trBCBfIjg1zKhi7i+8qIRcCImgBqzJ4kT5r1LlSdl
         m5HN9h8KU3f+EmKNGcoM/J1+/MIOo8QC/NNaEXqu8gzJvcJL4uydIEjAsV3+ZJd1l/f7
         JInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718988213; x=1719593013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYhlBIwPc5g8CbEQRnexlhzN/p56ugUpYFTcdezwQPI=;
        b=vWYGlF3RlcSOgjDEwBvn5bzDMna+UCIW9PjlNhdxcg1t1D31gKaf42t0O4CyCF4NkE
         UwO4RN04jkAyTMOy/5nU/DiLTm35pIf6R/sMXpbs+ZckWmgfqC7Nxk97fG3MI1FiYrS+
         M+OvVFdjElhiZWg6hJc3Ke/Z0HzJVYjodDHhqXwpebGvVZNWzoZllqjZPmXmCH+t08vJ
         ZVuj58pNw/f+pbvSBaACtU+/yBegVRUx1Ws0wUYzeB5fz8EABuLXZswo0Xb87WY6rSlT
         xpCC4G43N+Za5Saa3gbzSs6fAm+9ERcIVDycoIUynQkLZwA90msZqBppAFUSafwJ5dJu
         6VvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx6E3rplVu2znODb/HFR+DxYFlM6eYTOMa5ESWR/CAU8t5jT6GV/DJulD5XMcbneCuKDlipvYKXXyTK/s1ZNc0Rz4ZuC6+E4uy2CYj/FC1PHhAS25T8evsk9467cWPJStJ2yRahm/GfL0gipa6eg==
X-Gm-Message-State: AOJu0Yytu+VDl+Lhj07ojFgEGoQwWd763rGNpCnfN+A076W3v71R317X
	Le1qQJqisLrcjjl0okS++UtjbZ6ix8DQHDXR07PwVDI3WgfIf2kQ8CiEXr++Btf58wqoTU5B4kP
	eKHwG5qhDgoArFfQPzGk3RL6aWOE=
X-Google-Smtp-Source: AGHT+IGZHgXpdxrVNsoxnYjTxL1F+ym5vOS9yygK9cBVMkQE5DiUZsm2anT5VxdPvk0RtxyOHWCMn8v4q1AcS5r5Fec=
X-Received: by 2002:a25:9c87:0:b0:dfb:1b10:34bd with SMTP id
 3f1490d57ef6-e02be22d495mr8438701276.64.1718988213147; Fri, 21 Jun 2024
 09:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-6-howardchu95@gmail.com> <ZnWlWG0ScTa22s0O@google.com>
In-Reply-To: <ZnWlWG0ScTa22s0O@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sat, 22 Jun 2024 00:43:22 +0800
Message-ID: <CAH0uvohaypdTV6Z7O5QSK+va_qnhZ6BP6oSJ89s1c1E0CjgxDA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] perf trace: Add test for enum augmentation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Sat, Jun 22, 2024 at 12:07=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Howard,
>
> On Wed, Jun 19, 2024 at 04:20:42PM +0800, Howard Chu wrote:
> > Check for vmlinux's existence in sysfs as prerequisite.
> >
> > Add landlock_add_rule.c workload. Trace landlock_add_rule syscall to se=
e
> > if the output is desirable.
>
> Do you expect to add more things to the landlock workload?  I think we
> could simply call it landlock.c and probably do other things according
> to the argument, if needed (e.g. landlock add).

Shortening the name is good, I'll change it, thanks. I think
landlock_add_rule is the only syscall that we need currently, for it
contains the only enum argument of all the syscalls. I'll look into
how we can use these arguments, thank you.

Thanks,
Howard

>
> Thanks,
> Namhyung
>
> >
> > Trace the non-syscall tracepoint 'timer:hrtimer_init' and
> > 'timer:hrtimer_start', see if the 'mode' argument is augmented,
> > the 'mode' enum argument has the prefix of 'HRTIMER_MODE_'
> > in its name.
> >
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/tests/builtin-test.c               |  1 +
> >  tools/perf/tests/shell/trace_btf_enum.sh      | 57 +++++++++++++++++++
> >  tools/perf/tests/tests.h                      |  1 +
> >  tools/perf/tests/workloads/Build              |  1 +
> >  .../perf/tests/workloads/landlock_add_rule.c  | 32 +++++++++++
> >  5 files changed, 92 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
> >  create mode 100644 tools/perf/tests/workloads/landlock_add_rule.c
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index c3d84b67ca8e..e83200415ad1 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -152,6 +152,7 @@ static struct test_workload *workloads[] =3D {
> >       &workload__sqrtloop,
> >       &workload__brstack,
> >       &workload__datasym,
> > +     &workload__landlock_add_rule,
> >  };
> >
> >  static int num_subtests(const struct test_suite *t)
> > diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/test=
s/shell/trace_btf_enum.sh
> > new file mode 100755
> > index 000000000000..4861983553ab
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/trace_btf_enum.sh
> > @@ -0,0 +1,57 @@
> > +#!/bin/sh
> > +# perf trace enum augmentation tests
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +err=3D0
> > +set -e
> > +
> > +syscall=3D"landlock_add_rule"
> > +non_syscall=3D"timer:hrtimer_init,timer:hrtimer_start"
> > +
> > +TESTPROG=3D"perf test -w landlock_add_rule"
> > +
> > +. "$(dirname $0)"/lib/probe.sh
> > +skip_if_no_perf_trace || exit 2
> > +
> > +check_vmlinux() {
> > +  echo "Checking if vmlinux exists"
> > +  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
> > +  then
> > +    echo "trace+enum test [Skipped missing vmlinux BTF support]"
> > +    err=3D2
> > +  fi
> > +}
> > +
> > +trace_landlock() {
> > +  echo "Tracing syscall ${syscall}"
> > +  if perf trace -e $syscall $TESTPROG 2>&1 | \
> > +     grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LAND=
LOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, fla=
gs: 45\) =3D -1.*"
> > +  then
> > +    err=3D0
> > +  else
> > +    err=3D1
> > +  fi
> > +}
> > +
> > +trace_non_syscall() {
> > +  echo "Tracing non-syscall tracepoint ${non-syscall}"
> > +  if perf trace -e $non_syscall --max-events=3D1 2>&1 | \
> > +     grep -q -E '.*timer:hrtimer_.*\(.*mode: HRTIMER_MODE_.*\)$'
> > +  then
> > +    err=3D0
> > +  else
> > +    err=3D1
> > +  fi
> > +}
> > +
> > +check_vmlinux
> > +
> > +if [ $err =3D 0 ]; then
> > +  trace_landlock
> > +fi
> > +
> > +if [ $err =3D 0 ]; then
> > +  trace_non_syscall
> > +fi
> > +
> > +exit $err
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index 3aa7701ee0e9..69126299bb08 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -205,6 +205,7 @@ DECLARE_WORKLOAD(leafloop);
> >  DECLARE_WORKLOAD(sqrtloop);
> >  DECLARE_WORKLOAD(brstack);
> >  DECLARE_WORKLOAD(datasym);
> > +DECLARE_WORKLOAD(landlock_add_rule);
> >
> >  extern const char *dso_to_test;
> >  extern const char *test_objdump_path;
> > diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/worklo=
ads/Build
> > index a1f34d5861e3..5b12b93ecffa 100644
> > --- a/tools/perf/tests/workloads/Build
> > +++ b/tools/perf/tests/workloads/Build
> > @@ -6,6 +6,7 @@ perf-y +=3D leafloop.o
> >  perf-y +=3D sqrtloop.o
> >  perf-y +=3D brstack.o
> >  perf-y +=3D datasym.o
> > +perf-y +=3D landlock_add_rule.o
> >
> >  CFLAGS_sqrtloop.o         =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> >  CFLAGS_leafloop.o         =3D -g -O0 -fno-inline -fno-omit-frame-point=
er -U_FORTIFY_SOURCE
> > diff --git a/tools/perf/tests/workloads/landlock_add_rule.c b/tools/per=
f/tests/workloads/landlock_add_rule.c
> > new file mode 100644
> > index 000000000000..529b5f1ea5a7
> > --- /dev/null
> > +++ b/tools/perf/tests/workloads/landlock_add_rule.c
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <linux/compiler.h>
> > +#include <uapi/asm-generic/unistd.h> // for __NR_landlock_add_rule
> > +#include <unistd.h>
> > +#include <linux/landlock.h>
> > +#include "../tests.h"
> > +
> > +static int landlock_add_rule(int argc __maybe_unused, const char **arg=
v __maybe_unused)
> > +{
> > +     int fd =3D 11;
> > +     int flags =3D 45;
> > +
> > +     struct landlock_path_beneath_attr path_beneath_attr =3D {
> > +         .allowed_access =3D LANDLOCK_ACCESS_FS_READ_FILE,
> > +         .parent_fd =3D 14,
> > +     };
> > +
> > +     struct landlock_net_port_attr net_port_attr =3D {
> > +         .port =3D 19,
> > +         .allowed_access =3D LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > +     };
> > +
> > +     syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_PATH_BENEATH,
> > +             &path_beneath_attr, flags);
> > +
> > +     syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
> > +             &net_port_attr, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_WORKLOAD(landlock_add_rule);
> > --
> > 2.45.2
> >
