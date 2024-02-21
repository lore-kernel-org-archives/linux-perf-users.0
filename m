Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93BF8563B
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540563; cv=none; b=cZFC89UjUTbzSpEB7HhztTkEh3tSHBVcpf91CZkjpCaBgvi7IqX6eBCzf+GMmFHKbJSHV8wqO78HG5UeCPJ7aLFJIC97H9JTTNNu5lVnPucVfTLYP0JjBH67vBVTXZp2qORNvbkcbMJ98NNNA2d+VDozfYeZ7bEVtEyY5Oha+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540563; c=relaxed/simple;
	bh=JzXkEkAkZFt6tQSDJ0a/WDHwD2LKtf6I1CtX9A8t9gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmqT3xJlMwUQVZZP1bQAhUz4EAg3qdiO1LVpbZZ7UitEBqsKxvvH444oR31FLbDwS1Ym9hwWmsE20mSNn9VsNaxMczqnhMRVjN0333oj3uvXBW+WQHSuTpC+ox2xMZKwxp77Vm5oyFaGlIxa6ZqxabHOIp9B1tDN8wSvcCO0lp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rg2q7U8n; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rg2q7U8n"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dbe7e51f91so12315ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708540560; x=1709145360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN/hJ0GELYNvoKL9mhGdK5MwPicVkqUQ3Gg9Bl/EC/o=;
        b=rg2q7U8n2QcCuCKA3ohp5fiHOOM/3mNv8tJg7SrEKFeWdDZy8+q57o5xqy4A/oTrFZ
         BmEEoAxLrpbZ07GWXY7HA/p9ICz4ypOrE+wNGFsZDzYiCyjhgkg8X7MJUwANB8A+M5Ey
         Fy1Lx4eKEyZdLXSrMERX3beE2J4xRkjk8cJ0bV1BnQ7XvDyXZi/4322e9cRCt8FpRtgP
         VLxXEVcKhJQDoKCMI5LX/A7DADqa00kA7ExARoaxIeZcN5cKF7o5zu7xLIBG7bn5ETQ7
         GvVN3gNLRuyO1Z17KyaNv3lw/WaE7CG6auxmk4CaplX30JOVW0kfvQ0Ls7wTeORskfaf
         bSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708540560; x=1709145360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN/hJ0GELYNvoKL9mhGdK5MwPicVkqUQ3Gg9Bl/EC/o=;
        b=kpY8HH/b7+FmaZ+7lkXpWrTpWgHDL693OL7gAjngOEXuCDP9NHtiucV4L6Bi9M4r+q
         Sceu/XLajlK5RHbwQcTknigDJqRM37oj++V6Zui3czKzronQqSMqxlxgF46aMJm3EpCg
         BC8hQ6UBJnUV8DwjFZEgd2+MK4IMeO9XF58Y+MLQPY0ZgJ8khVttJtUu4irhAEQ6jiBA
         FDjgVtDlBR4RY9wyugoPv57+vi69giF//BLiGYW4PNcjCzAzAU/ZVz5wmmqqy6K5+H4w
         nY42NwNO0PNGQlJOAxvlAnCqrGv3nwuDZeWwothfld98G6MAcod/JIDEYWiNeorpnFoK
         IK1w==
X-Forwarded-Encrypted: i=1; AJvYcCXKkVeN3bC5WuMQcvHZkKRJ7lBgkESHmuf9VPM7vdYGwuc9+VuhbSq7Vi5WP7oOx5DJtN/CggrDeXZWdyZqE1wUGSsg1nl2DiZ6YaIn3ORYeQ==
X-Gm-Message-State: AOJu0YwzRIUHU0HGRbc6maCZEDc2wflT69CaMn9Jj7qXTdorzYJqPKx5
	pZskZui0FNSYtqg+zpaBsGMsV68M7jkc2YYKBwN2nKVOTYBTCFxPuH72IqIaVltFsXMxt7Wci0A
	oCBlQvqNflzd15a6zicy9Vbd8cZP5nQ+GAmg4Xz/JgipcpFTj4MDI
X-Google-Smtp-Source: AGHT+IHeZE8/mcjExoQZJoCHRSaPbX90Sxfl4B3Ofs6EyvbBVns2+y/ssJTLEwWNVbm41tka1GX9UJpkI4TwCReypAw=
X-Received: by 2002:a17:902:e9d5:b0:1dc:f0e:51 with SMTP id
 21-20020a170902e9d500b001dc0f0e0051mr243176plk.17.1708540559906; Wed, 21 Feb
 2024 10:35:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221175210.19936-1-khuey@kylehuey.com> <20240221175210.19936-2-khuey@kylehuey.com>
In-Reply-To: <20240221175210.19936-2-khuey@kylehuey.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Feb 2024 10:35:45 -0800
Message-ID: <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
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

On Wed, Feb 21, 2024 at 9:52=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> The test uses PERF_RECORD_SWITCH records to fill the ring buffer and
> trigger the watermark wakeup, which in turn should trigger an IO
> signal.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  tools/perf/tests/Build              |   1 +
>  tools/perf/tests/builtin-test.c     |   1 +
>  tools/perf/tests/tests.h            |   1 +
>  tools/perf/tests/watermark_signal.c | 123 ++++++++++++++++++++++++++++
>  4 files changed, 126 insertions(+)
>  create mode 100644 tools/perf/tests/watermark_signal.c
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 53ba9c3e20e0..de43eb60b280 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -67,6 +67,7 @@ perf-y +=3D sigtrap.o
>  perf-y +=3D event_groups.o
>  perf-y +=3D symbols.o
>  perf-y +=3D util.o
> +perf-y +=3D watermark_signal.o
>
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
>  perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 4a5973f9bb9b..715c01a2172a 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -124,6 +124,7 @@ static struct test_suite *generic_tests[] =3D {
>         &suite__event_groups,
>         &suite__symbols,
>         &suite__util,
> +       &suite__watermark_signal,
>         NULL,
>  };
>
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index dad3d7414142..7ef4e0d0a77b 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -146,6 +146,7 @@ DECLARE_SUITE(sigtrap);
>  DECLARE_SUITE(event_groups);
>  DECLARE_SUITE(symbols);
>  DECLARE_SUITE(util);
> +DECLARE_SUITE(watermark_signal);
>
>  /*
>   * PowerPC and S390 do not support creation of instruction breakpoints u=
sing the
> diff --git a/tools/perf/tests/watermark_signal.c b/tools/perf/tests/water=
mark_signal.c
> new file mode 100644
> index 000000000000..ae4abedc4b7c
> --- /dev/null
> +++ b/tools/perf/tests/watermark_signal.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stddef.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +
> +#include "tests.h"
> +#include "debug.h"
> +#include "event.h"
> +#include "../perf-sys.h"
> +#include "cloexec.h"
> +#include <internal/lib.h> // page_size
> +
> +static int sigio_count;
> +
> +static void handle_sigio(int sig __always_unused)
> +{
> +       ++sigio_count;
> +}
> +
> +static void do_child(void)
> +{
> +       for (int i =3D 0; i < 20; ++i)
> +               sleep(1);
> +
> +       exit(0);
> +}
> +
> +static int test__watermark_signal(struct test_suite *test __maybe_unused=
, int subtest __maybe_unused)
> +{
> +       struct perf_event_attr attr;
> +       struct perf_event_mmap_page *p =3D NULL;
> +       sighandler_t previous_sigio =3D SIG_ERR;
> +       pid_t child =3D -1;
> +       int fd =3D -1;
> +       int ret =3D TEST_FAIL;
> +
> +       previous_sigio =3D signal(SIGIO, handle_sigio);
> +       if (previous_sigio =3D=3D SIG_ERR) {
> +               pr_debug("failed setting SIGIO handler\n");
> +               goto cleanup;
> +       }
> +
> +       memset(&attr, 0, sizeof(attr));
> +       attr.size =3D sizeof(attr);
> +       attr.type =3D PERF_TYPE_SOFTWARE;
> +       attr.config =3D PERF_COUNT_SW_DUMMY;
> +       attr.sample_period =3D 1;
> +       attr.disabled =3D 1;
> +       attr.watermark =3D 1;
> +       attr.context_switch =3D 1;
> +       attr.wakeup_watermark =3D 1;
> +
> +       child =3D fork();
> +       if (child =3D=3D 0)
> +               do_child();
> +       else if (child < 0) {
> +               pr_debug("failed fork() %d\n", errno);
> +               goto cleanup;
> +       }
> +
> +       fd =3D sys_perf_event_open(&attr, child, -1, -1,
> +                                perf_event_open_cloexec_flag());
> +       if (fd < 0) {
> +               pr_debug("failed opening event %llx\n", attr.config);
> +               goto cleanup;
> +       }
> +
> +       if (fcntl(fd, F_SETFL, FASYNC)) {
> +               pr_debug("failed F_SETFL FASYNC %d\n", errno);
> +               goto cleanup;
> +       }

Thanks for the work! The perf tool and perf test should run on older
kernels ideally without failure. I'm assuming this would fail on an
older kernel. Could we make the return value skip in that case?

> +
> +       if (fcntl(fd, F_SETOWN, getpid())) {
> +               pr_debug("failed F_SETOWN getpid() %d\n", errno);
> +               goto cleanup;
> +       }
> +
> +       if (fcntl(fd, F_SETSIG, SIGIO)) {
> +               pr_debug("failed F_SETSIG SIGIO %d\n", errno);
> +               goto cleanup;
> +       }
> +
> +       p =3D mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, MAP_SHARE=
D, fd, 0);
> +       if (p =3D=3D NULL) {
> +               pr_debug("failed to mmap\n");
> +               goto cleanup;
> +       }
> +
> +       if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0)) {
> +               pr_debug("failed PERF_EVENT_IOC_ENABLE %d\n", errno);
> +               goto cleanup;
> +       }
> +
> +       sleep(30);

This is kind of a painful wait, could it be less? No sleeps would be best :=
-)

Thanks,
Ian

> +
> +       ret =3D (sigio_count =3D=3D 1) ? TEST_OK : TEST_FAIL;
> +
> +cleanup:
> +       if (p !=3D NULL)
> +               munmap(p, 2 * page_size);
> +
> +       if (fd >=3D 0)
> +               close(fd);
> +
> +       if (child > 0) {
> +               kill(child, SIGTERM);
> +               waitpid(child, NULL, 0);
> +       }
> +
> +       if (previous_sigio !=3D SIG_ERR)
> +               signal(SIGIO, previous_sigio);
> +
> +       return ret;
> +}
> +
> +DEFINE_SUITE("Watermark signal handler", watermark_signal);
> --
> 2.34.1
>
