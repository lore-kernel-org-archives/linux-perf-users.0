Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73373548E5
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Feb 2024 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631085; cv=none; b=fmFJvFykWCAvJY4IORif531WTMvAFoczF3hIKWQdpNcwlvqhifwFIeGG48z4qMEsH5MvegPu/MegKfKqpqrav4s/VSJwCpsQU8VJf5iisVHQ/kzJFEIVg4AnNOPYjnb+9qKQh8nJArg2ihAINRWNUphnGiIWS9vPAEq2iBZH40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631085; c=relaxed/simple;
	bh=tgWG/Godrei85+X/RdUMDJtVegkqZmu5Afi5kVXwTJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hB+gDjOQX8wEEj1bhsnOywSv1IB/AcPYl7qF1R8a2knh6SsaKnWFzzZUS75ntPkbabMlKfvJ7y0Kvl/1AnoQl3qzHTRqI0ppCqWIEUwhaqBNE/es0IQFmJIx3pMS3W8Qvm6yFDT7wfCWAK9J8gIMVzcKjcvxzmFYVp65tIxa70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsu78cFn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsu78cFn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dbcf58b05cso22265ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Feb 2024 11:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708631083; x=1709235883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6OcETDiZuUNE51mFmBIi+Ji9vV910q3idLCCfNTBw0=;
        b=vsu78cFnGbB7U6cp6otil1RiBwyD0widjeu6RxCtt1od9vHXdITa7IyuoN7hCK63Q1
         HEyvU9z+pnQLsyQJC9MtN8SKx5eFP7YHxORpx/ZR+tKIGX4kzAg+0YFt6IGXTivHPmHC
         05E8T5sjhjPWAZH0mOLLv+I1zfl+VI87dwSiymnh3Ls2sMvFBteAbflvM5qwCqAfdGmZ
         C6SHGzUkDlORCWYCbXX8K6XR6h7eQWvjB7Jleum+738YD2JYOEJrAOu3jrMx06bOlXDP
         RIBdO5p/jCtSRye3X2wqr/cl3TLHbS6CarreuytTY6y6bQ7RLaVi/2u8/7xMEk0BGq21
         pkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708631083; x=1709235883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6OcETDiZuUNE51mFmBIi+Ji9vV910q3idLCCfNTBw0=;
        b=usLtZ60rPvlAzvfO47PPzHXdRl6oTcvJCkO7o5Zu6dyB9SmVofZAnRccgfknUM2Z05
         GV//jYgYl1Zob5hVBH86uHvIAgmUK5ZYV7Y1Aq6PA/rxe7WMA5K3EPNu0Xn+qoGNEZeU
         YACdSB0yGrsu7/p8TJKX7Cpjsdj2GzD/bo8wEcSAZNcUWqSgucW6HCVlbh2/KMoSKAAe
         p9D63JKjO/sQN7jFRMIS4UezfOiDKp4exkfCpRIXYZ9fXC8zvrUiu+PUfdsqAV0+v2/k
         yEM7KOQpHuPQO69L4hpzBnLbe8QXEyYLzs2YVsVvv8POY8Vm9vWtsycy52uQo6hOC27L
         W8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXByRCAYA6YtIPzELZZK7dVo/gBZZYjZTQ4C2bsH/nshuu0AzvlBVeNcXixXns7zeedQTxdEQcd8irENLWPKt1y1AZ8L1/coBKrE7+iobwC6g==
X-Gm-Message-State: AOJu0YwbvgHkcCbtzUcl21bT+cXnRNd0K5FO/4j8x5sROP5ZfmIx/hMQ
	BMpXf+UdqHeiZB2LncWm5tdUIvWGW8jvlBQZKTZBIE2w9CXDbcS7t+w+/Dycbwr1DXPLNUwnOl1
	R2A12oNeDNlVyxYlOSDg2QrHZ1yWZhiOiN2Zv
X-Google-Smtp-Source: AGHT+IF1ooeawE2vMbZjpLm2Ef3AVCRRzjYlPHKaZvx8SmduQN4iR7iUcbz6RiWqnOpXyKd387FJreCALy56syI2ux8=
X-Received: by 2002:a17:902:ce91:b0:1db:a6be:ddc6 with SMTP id
 f17-20020a170902ce9100b001dba6beddc6mr544314plg.27.1708631082359; Thu, 22 Feb
 2024 11:44:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221175210.19936-1-khuey@kylehuey.com> <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
 <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>
 <CAP-5=fVWUAWa4vZ7_Zb_3DjaMiTGT6grfFO2j_kOFbuZemJZTA@mail.gmail.com> <CAP045Arp+1j_W_iiHWwOGRCvvXCg3pC=gH5WMho-RpQXi4H1xg@mail.gmail.com>
In-Reply-To: <CAP045Arp+1j_W_iiHWwOGRCvvXCg3pC=gH5WMho-RpQXi4H1xg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Feb 2024 11:44:29 -0800
Message-ID: <CAP-5=fXh0OunzyZdky9BCqA1QfsqwPifCbbFRpsB5QY+5DP6+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, "Robert O'Callahan" <robert@ocallahan.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 10:41=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> On Thu, Feb 22, 2024 at 10:33=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Thu, Feb 22, 2024 at 9:55=E2=80=AFAM Kyle Huey <me@kylehuey.com> wro=
te:
> > >
> > > On Wed, Feb 21, 2024 at 10:36=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > On Wed, Feb 21, 2024 at 9:52=E2=80=AFAM Kyle Huey <me@kylehuey.com>=
 wrote:
> > > > >
> > > > > The test uses PERF_RECORD_SWITCH records to fill the ring buffer =
and
> > > > > trigger the watermark wakeup, which in turn should trigger an IO
> > > > > signal.
> > > > >
> > > > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > > > > ---
> > > > >  tools/perf/tests/Build              |   1 +
> > > > >  tools/perf/tests/builtin-test.c     |   1 +
> > > > >  tools/perf/tests/tests.h            |   1 +
> > > > >  tools/perf/tests/watermark_signal.c | 123 ++++++++++++++++++++++=
++++++
> > > > >  4 files changed, 126 insertions(+)
> > > > >  create mode 100644 tools/perf/tests/watermark_signal.c
> > > > >
> > > > > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > > > > index 53ba9c3e20e0..de43eb60b280 100644
> > > > > --- a/tools/perf/tests/Build
> > > > > +++ b/tools/perf/tests/Build
> > > > > @@ -67,6 +67,7 @@ perf-y +=3D sigtrap.o
> > > > >  perf-y +=3D event_groups.o
> > > > >  perf-y +=3D symbols.o
> > > > >  perf-y +=3D util.o
> > > > > +perf-y +=3D watermark_signal.o
> > > > >
> > > > >  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
> > > > >  perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> > > > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/b=
uiltin-test.c
> > > > > index 4a5973f9bb9b..715c01a2172a 100644
> > > > > --- a/tools/perf/tests/builtin-test.c
> > > > > +++ b/tools/perf/tests/builtin-test.c
> > > > > @@ -124,6 +124,7 @@ static struct test_suite *generic_tests[] =3D=
 {
> > > > >         &suite__event_groups,
> > > > >         &suite__symbols,
> > > > >         &suite__util,
> > > > > +       &suite__watermark_signal,
> > > > >         NULL,
> > > > >  };
> > > > >
> > > > > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > > > > index dad3d7414142..7ef4e0d0a77b 100644
> > > > > --- a/tools/perf/tests/tests.h
> > > > > +++ b/tools/perf/tests/tests.h
> > > > > @@ -146,6 +146,7 @@ DECLARE_SUITE(sigtrap);
> > > > >  DECLARE_SUITE(event_groups);
> > > > >  DECLARE_SUITE(symbols);
> > > > >  DECLARE_SUITE(util);
> > > > > +DECLARE_SUITE(watermark_signal);
> > > > >
> > > > >  /*
> > > > >   * PowerPC and S390 do not support creation of instruction break=
points using the
> > > > > diff --git a/tools/perf/tests/watermark_signal.c b/tools/perf/tes=
ts/watermark_signal.c
> > > > > new file mode 100644
> > > > > index 000000000000..ae4abedc4b7c
> > > > > --- /dev/null
> > > > > +++ b/tools/perf/tests/watermark_signal.c
> > > > > @@ -0,0 +1,123 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +#include <stddef.h>
> > > > > +#include <signal.h>
> > > > > +#include <stdlib.h>
> > > > > +#include <string.h>
> > > > > +#include <sys/ioctl.h>
> > > > > +#include <sys/mman.h>
> > > > > +#include <sys/wait.h>
> > > > > +#include <unistd.h>
> > > > > +#include <errno.h>
> > > > > +#include <fcntl.h>
> > > > > +
> > > > > +#include "tests.h"
> > > > > +#include "debug.h"
> > > > > +#include "event.h"
> > > > > +#include "../perf-sys.h"
> > > > > +#include "cloexec.h"
> > > > > +#include <internal/lib.h> // page_size
> > > > > +
> > > > > +static int sigio_count;
> > > > > +
> > > > > +static void handle_sigio(int sig __always_unused)
> > > > > +{
> > > > > +       ++sigio_count;
> > > > > +}
> > > > > +
> > > > > +static void do_child(void)
> > > > > +{
> > > > > +       for (int i =3D 0; i < 20; ++i)
> > > > > +               sleep(1);
> > > > > +
> > > > > +       exit(0);
> > > > > +}
> > > > > +
> > > > > +static int test__watermark_signal(struct test_suite *test __mayb=
e_unused, int subtest __maybe_unused)
> > > > > +{
> > > > > +       struct perf_event_attr attr;
> > > > > +       struct perf_event_mmap_page *p =3D NULL;
> > > > > +       sighandler_t previous_sigio =3D SIG_ERR;
> > > > > +       pid_t child =3D -1;
> > > > > +       int fd =3D -1;
> > > > > +       int ret =3D TEST_FAIL;
> > > > > +
> > > > > +       previous_sigio =3D signal(SIGIO, handle_sigio);
> > > > > +       if (previous_sigio =3D=3D SIG_ERR) {
> > > > > +               pr_debug("failed setting SIGIO handler\n");
> > > > > +               goto cleanup;
> > > > > +       }
> > > > > +
> > > > > +       memset(&attr, 0, sizeof(attr));
> > > > > +       attr.size =3D sizeof(attr);
> > > > > +       attr.type =3D PERF_TYPE_SOFTWARE;
> > > > > +       attr.config =3D PERF_COUNT_SW_DUMMY;
> > > > > +       attr.sample_period =3D 1;
> > > > > +       attr.disabled =3D 1;
> > > > > +       attr.watermark =3D 1;
> > > > > +       attr.context_switch =3D 1;
> > > > > +       attr.wakeup_watermark =3D 1;
> > > > > +
> > > > > +       child =3D fork();
> > > > > +       if (child =3D=3D 0)
> > > > > +               do_child();
> > > > > +       else if (child < 0) {
> > > > > +               pr_debug("failed fork() %d\n", errno);
> > > > > +               goto cleanup;
> > > > > +       }
> > > > > +
> > > > > +       fd =3D sys_perf_event_open(&attr, child, -1, -1,
> > > > > +                                perf_event_open_cloexec_flag());
> > > > > +       if (fd < 0) {
> > > > > +               pr_debug("failed opening event %llx\n", attr.conf=
ig);
> > > > > +               goto cleanup;
> > > > > +       }
> > > > > +
> > > > > +       if (fcntl(fd, F_SETFL, FASYNC)) {
> > > > > +               pr_debug("failed F_SETFL FASYNC %d\n", errno);
> > > > > +               goto cleanup;
> > > > > +       }
> > > >
> > > > Thanks for the work! The perf tool and perf test should run on olde=
r
> > > > kernels ideally without failure. I'm assuming this would fail on an
> > > > older kernel. Could we make the return value skip in that case?
> > >
> > > Ah, hmm, I wasn't aware of that. This would fail on an older kernel,
> > > yes. It's not possible to distinguish between an older kernel and a
> > > kernel where this fix broke (at least not without hardcoding in an
> > > expected good kernel version, which seems undesirable), so that would
> > > mean the test would always return ok or skip, not ok or fail. Is that
> > > ok?
> >
> > Not great :-) Is there any hint from the errno? I was hoping for
> > EOPNOTSUPP but I'm guessing it will be EINVAL, in which case probably
> > something like:
> > /* Older kernels lack support. */
> > ret =3D (errno =3D=3D EINVAL) ? TEST_SKIP : TEST_FAIL;
>
> Ah, I see. The issue I am trying to fix is not that setting FASYNC is
> rejected with an error code, it's that it doesn't actually send the IO
> signal when the watermark is reached.

That's unfortunate. Perhaps similar to errno you could use uname,
return skip for failures on older kernels and fail on newer kernels.

Thanks,
Ian

> - Kyle
>
> > > > > +
> > > > > +       if (fcntl(fd, F_SETOWN, getpid())) {
> > > > > +               pr_debug("failed F_SETOWN getpid() %d\n", errno);
> > > > > +               goto cleanup;
> > > > > +       }
> > > > > +
> > > > > +       if (fcntl(fd, F_SETSIG, SIGIO)) {
> > > > > +               pr_debug("failed F_SETSIG SIGIO %d\n", errno);
> > > > > +               goto cleanup;
> > > > > +       }
> > > > > +
> > > > > +       p =3D mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, M=
AP_SHARED, fd, 0);
> > > > > +       if (p =3D=3D NULL) {
> > > > > +               pr_debug("failed to mmap\n");
> > > > > +               goto cleanup;
> > > > > +       }
> > > > > +
> > > > > +       if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0)) {
> > > > > +               pr_debug("failed PERF_EVENT_IOC_ENABLE %d\n", err=
no);
> > > > > +               goto cleanup;
> > > > > +       }
> > > > > +
> > > > > +       sleep(30);
> > > >
> > > > This is kind of a painful wait, could it be less? No sleeps would b=
e best :-)
> > >
> > > We could synchronize with the child using SIGSTOP instead of sleeping
> > > here. Not sure about getting rid of the tiny sleeps in the child. I
> > > have observed that sched_yield() doesn't reliably trigger context
> > > switches (which isn't surprising). I'll experiment with blocking on a
> > > pipe or something.
> >
> > Great, thanks!
> > Ian
> >
> > > - Kyle
> > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > +
> > > > > +       ret =3D (sigio_count =3D=3D 1) ? TEST_OK : TEST_FAIL;
> > > > > +
> > > > > +cleanup:
> > > > > +       if (p !=3D NULL)
> > > > > +               munmap(p, 2 * page_size);
> > > > > +
> > > > > +       if (fd >=3D 0)
> > > > > +               close(fd);
> > > > > +
> > > > > +       if (child > 0) {
> > > > > +               kill(child, SIGTERM);
> > > > > +               waitpid(child, NULL, 0);
> > > > > +       }
> > > > > +
> > > > > +       if (previous_sigio !=3D SIG_ERR)
> > > > > +               signal(SIGIO, previous_sigio);
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +DEFINE_SUITE("Watermark signal handler", watermark_signal);
> > > > > --
> > > > > 2.34.1
> > > > >
