Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BFD13665A;
	Fri,  5 Jul 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170867; cv=none; b=mmDVCVqRGV3GeC+MhiOhsRwaJsRJ0xLNhlWRLVnLOe0i6pSsAjnxiQippHwKdKdqecHUU703mRGUmefT/orO5xkU+D4mhMAphy3yYQnWhgBDdHEHZ/hyvbKL5HkXHv8NHy4c+/dnAPuOGea5n6j2qeBMB8L9IkhaS6V42XHD8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170867; c=relaxed/simple;
	bh=+OjcpRvrN+YfhX2ItVTPvnBtOuFXamMtkawFuKe62/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnmNRwrcZG+ZTpla2CGe/XZyE1pCkN6auurkutq4SaZsmB71oArQ/VoQCOA5FCxXkTt11dMJ/CG34M+T9TqYhhDiq5/+h6knCvzl5ef9jTcPbIOWu3RECGtYATuGfhir4g+WUHhP6SBWZt3ohN82cEIAHeXAd9s7b9PmPF72bN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4Jkjb6f; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4Jkjb6f"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e03a0faee1eso1371610276.1;
        Fri, 05 Jul 2024 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720170865; x=1720775665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbZmJfe1zwNHMC/mgsKLuXgDrTYF/7R6c919IQGDPlI=;
        b=T4Jkjb6fC6VXXHs6qG3RRm/uuuyYQkRn60pJZU+Xtnv72ZTtOtKtVMA8SKWf+DjM3E
         Oq0+RFaPF5Ow2kQdRKvQjrmVQ46PnTn+ioHc+JcJj7zYLrklhr43gOCyspVMyOiQaS4X
         4xACZ/wGcQsUqX3UrSz/beFcQjufB7Spwiz12+C2FDjA3K21cEMTVZtgGnva8vdEwyy6
         jZJMmzKFmu9y5k6jP4iBRv1YHWAFwS2gevfjd9SFBDZlNPmOwUI73qt8w5NI5gV4Gq4B
         jg77kVaODxd67/ETpk2wp2W4fGFuC7lhxoIWtJShc29fmvhQMUFtpIxwpvSOmgJhJ8Wy
         gtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720170865; x=1720775665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbZmJfe1zwNHMC/mgsKLuXgDrTYF/7R6c919IQGDPlI=;
        b=mNuCBzEYd5neulJIEDER0gmaAmr6lUf2mXgiPXOEBCGfEMXyAH70plm2SgA8AhxghS
         EihJPr0uIpNVGkX/fV4v6LnAbY+5HYdS1AEb/igaZGGlGLGywla0oTegYSQO4MqytjJz
         MF99A8quZmLopfHT45CHqQt5iFJTVB9qthDbo5b3zNiYtum63zN7p8reWSujnebvdjwe
         +ZDOkVoEyNLmE3sXqFLy/ENEhocQpwXYNBQCT9cDTvaLs4GfDHnMvsDzHYTMVAQZMuHC
         9Er4xB1mLApBJ1fvS76+hauQZB7bsAvRn8x0enlIHyKFMZ2QhBwkT9khrihN7juOqDNs
         aCIw==
X-Forwarded-Encrypted: i=1; AJvYcCXQVHIwBlXyS2b5ZU2Q0CHMw974KZWxmriIMcxxiD1X6BdZsLk+v/nYtZid3B2sUH3FsR7Rq352HtDAl8mhZp9ogcc0XV9xXf3ax2CdkQ2LiQcAYmt45PJeb8z6TD00Oq4JJG6xg4rtcdnzoVkjwg==
X-Gm-Message-State: AOJu0YzpnRFW6pDLpk+wLUGnmRQlQqGLzC2kjuAKRjGsqLft9ZQ+8uvS
	R4J0bJdgvSPe66ZATSYeTNX73fxHA3UL/xCbIkaHo1Ymf7rq1b+3hhMg7JaQCtA9ARigg/6lgoV
	jtfr4Ye9O/Fa8A/EoO9xKpWbapMg=
X-Google-Smtp-Source: AGHT+IHbqwfOEO8j+reeD3pqfqwQ9T1hKCDrmjE5LWsuV3/mYcNZ7uD8AVK6pVCRHJLKOAxm+3eJg17quGr4CW3mJOA=
X-Received: by 2002:a05:690c:45c5:b0:615:10f8:124a with SMTP id
 00721157ae682-652d7b5e4famr53537347b3.29.1720170864301; Fri, 05 Jul 2024
 02:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704124354.904540-1-howardchu95@gmail.com>
 <20240704124354.904540-6-howardchu95@gmail.com> <Zob4sO8-D-hepgD2@x1>
In-Reply-To: <Zob4sO8-D-hepgD2@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 5 Jul 2024 17:14:14 +0800
Message-ID: <CAH0uvohn0gMih+HOBLgfvttUfBJC=GfKJhtv7g0vfkPBOn4kCA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] perf test: Add landlock workload
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 5, 2024 at 3:32=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Thu, Jul 04, 2024 at 08:43:51PM +0800, Howard Chu wrote:
> > We'll use it to add a regression test for the BTF augmentation of enum
> > arguments for tracepoints in 'perf trace':
> >
> >   root@x1:~# perf trace -e landlock_add_rule perf test -w landlock
> >        0.000 ( 0.009 ms): perf/747160 landlock_add_rule(ruleset_fd: 11,=
 rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffd8e258594, flags: 4=
5) =3D -1 EINVAL (Invalid argument)
> >        0.011 ( 0.002 ms): perf/747160 landlock_add_rule(ruleset_fd: 11,=
 rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffd8e2585a0, flags: 45) =
=3D -1 EINVAL (Invalid argument)
> >   root@x1:~#
> >
> > Committer notes:
> >
> > It was agreed on the discussion (see Link1 below) to shorten then name =
of
> > the workload from 'landlock_add_rule' to 'landlock', and I moved it to =
a
> > separate patch.
> >
> > Howard fixed the build error found by Namhyung (see Link2 below),
> > changing the landlock.h header to the one in source tree, and including
> > syscall.h for the '__NR_landlock_add_rule' syscall number.
> >
> > However, there is another problem. Because of this line in Makefile.con=
fig:
> > INC_FLAGS +=3D -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi ,
> > we'll include 'tools/arch/x86/include/uapi/asm/unistd_64.h' in the sour=
ce
> > tree. But what we want is '/usr/include/asm/unistd_64.h'.
> > This hardcoded unistd_64.h in the source tree is not cool for the landl=
ock
> > workload because it is a simplified list of syscall numbers for particu=
lar
> > use cases, we need to discard this search path if we want the
> > __NR_landlock_add_rule macro. To solve this problem, Howard added a
> > CFLAGS_REMOVE_landlock.o to remove the flag of
> > -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi.
> >
> > The problem above will not occur in some arch, say arm64
> > and riscv because they include asm-generic/unistd.h instead. The arch
> > that it really affects is the ones that include asm/unistd_32.h and
> > asm/unistd_64.h.
> >
> > linux $ find . -regex './arch/.*/include/uapi/asm/unistd.h' | xargs gre=
p -H --color=3Dauto 'include <asm'
> > ./arch/x86/include/uapi/asm/unistd.h:#  include <asm/unistd_32.h>
> > ./arch/x86/include/uapi/asm/unistd.h:#  include <asm/unistd_x32.h>
> > ./arch/x86/include/uapi/asm/unistd.h:#  include <asm/unistd_64.h>
> > ./arch/parisc/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
> > ./arch/parisc/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> > ./arch/nios2/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> > ./arch/mips/include/uapi/asm/unistd.h:#include <asm/sgidefs.h>
> > ./arch/mips/include/uapi/asm/unistd.h:#include <asm/unistd_o32.h>
> > ./arch/mips/include/uapi/asm/unistd.h:#include <asm/unistd_n64.h>
> > ./arch/mips/include/uapi/asm/unistd.h:#include <asm/unistd_n32.h>
> > ./arch/s390/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
> > ./arch/s390/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> > ./arch/arm64/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> > ./arch/riscv/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> > ./arch/sparc/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
> > ./arch/sparc/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> > ./arch/xtensa/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> > ./arch/hexagon/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h=
>
> > ./arch/openrisc/include/uapi/asm/unistd.h:#include <asm-generic/unistd.=
h>
> > ./arch/arm/include/uapi/asm/unistd.h:#include <asm/unistd-eabi.h>
> > ./arch/arm/include/uapi/asm/unistd.h:#include <asm/unistd-oabi.h>
> > ./arch/alpha/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> > ./arch/sh/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> > ./arch/m68k/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> > ./arch/microblaze/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> > ./arch/arc/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> > ./arch/powerpc/include/uapi/asm/unistd.h:#include <asm/unistd_32.h>
> > ./arch/powerpc/include/uapi/asm/unistd.h:#include <asm/unistd_64.h>
> > ./arch/csky/include/uapi/asm/unistd.h:#include <asm-generic/unistd.h>
> > ./arch/loongarch/include/uapi/asm/unistd.h:#include <asm-generic/unistd=
.h>
> >
> > Reported-by: Namhyung Kim <namhyung@kernel.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202406250302.E4WaX9Ud-lkp@intel.com/
> > Closes: https://lore.kernel.org/linux-perf-users/Zn8TfuQi0iq7bMVD@googl=
e.com/
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link1: https://lore.kernel.org/lkml/CAH0uvohaypdTV6Z7O5QSK+va_qnhZ6BP6o=
SJ89s1c1E0CjgxDA@mail.gmail.com
> > Link2: https://lore.kernel.org/linux-perf-users/Zn8TfuQi0iq7bMVD@google=
.com/
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/tests/builtin-test.c       |  1 +
> >  tools/perf/tests/tests.h              |  1 +
> >  tools/perf/tests/workloads/Build      |  2 ++
> >  tools/perf/tests/workloads/landlock.c | 38 +++++++++++++++++++++++++++
> >  4 files changed, 42 insertions(+)
> >  create mode 100644 tools/perf/tests/workloads/landlock.c
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index c3d84b67ca8e..470a9709427d 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -152,6 +152,7 @@ static struct test_workload *workloads[] =3D {
> >       &workload__sqrtloop,
> >       &workload__brstack,
> >       &workload__datasym,
> > +     &workload__landlock,
> >  };
> >
> >  static int num_subtests(const struct test_suite *t)
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index 3aa7701ee0e9..6ea2be86b7bf 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -205,6 +205,7 @@ DECLARE_WORKLOAD(leafloop);
> >  DECLARE_WORKLOAD(sqrtloop);
> >  DECLARE_WORKLOAD(brstack);
> >  DECLARE_WORKLOAD(datasym);
> > +DECLARE_WORKLOAD(landlock);
> >
> >  extern const char *dso_to_test;
> >  extern const char *test_objdump_path;
> > diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/worklo=
ads/Build
> > index 48bf0d3b0f3d..e132d5d95983 100644
> > --- a/tools/perf/tests/workloads/Build
> > +++ b/tools/perf/tests/workloads/Build
> > @@ -6,8 +6,10 @@ perf-test-y +=3D leafloop.o
> >  perf-test-y +=3D sqrtloop.o
> >  perf-test-y +=3D brstack.o
> >  perf-test-y +=3D datasym.o
> > +perf-test-y +=3D landlock.o
> >
> >  CFLAGS_sqrtloop.o         =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> >  CFLAGS_leafloop.o         =3D -g -O0 -fno-inline -fno-omit-frame-point=
er -U_FORTIFY_SOURCE
> >  CFLAGS_brstack.o          =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> >  CFLAGS_datasym.o          =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> > +CFLAGS_REMOVE_landlock.o  =3D -I$(srctree)/tools/arch/$(SRCARCH)/inclu=
de/uapi
> > diff --git a/tools/perf/tests/workloads/landlock.c b/tools/perf/tests/w=
orkloads/landlock.c
> > new file mode 100644
> > index 000000000000..c4f29b17f2a7
> > --- /dev/null
> > +++ b/tools/perf/tests/workloads/landlock.c
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <sys/syscall.h> // for __NR_landlock_add_rule
> > +#include <linux/compiler.h>
> > +#include <unistd.h>
> > +#include "../tests.h"
> > +#ifdef __NR_landlock_add_rule
> > +#include "../../../../include/uapi/linux/landlock.h"
>
> We can't access files outside tools/

Oops, sorry, didn't know that.

>
> =E2=AC=A2[acme@toolbox linux]$ cd tools/perf/tests/workloads
> =E2=AC=A2[acme@toolbox workloads]$ ls -la ../../../../include/uapi/linux/=
landlock.h
> -rw-r--r--. 1 acme acme 9309 Dec  8  2023 ../../../../include/uapi/linux/=
landlock.h
> =E2=AC=A2[acme@toolbox workloads]$ realpath ../../../../include/uapi/linu=
x/landlock.h
> /home/acme/git/linux/include/uapi/linux/landlock.h
> =E2=AC=A2[acme@toolbox workloads]$
>
> Take a look at the alternative patch I just sent, this was a real "mid
> air collision" :-)
>

Yeah, I think a hardcoded structs and macros are fine, at the end of
the day, it's just a pointer and a hexadecimal number in perf trace.

Thanks,
Howard

> - Arnaldo
