Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4C2139C9
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000848; cv=none; b=JBrHmOWNnU3HcMmYS4xKNz3E9rWu8eSbOxOuMhobQEGfpYHhKwNjKJgw/FjsmPBUCtSskosshSdFSdWwyVaa1TW5rzOnC/8ZApDs+GlamxBtZJNvfLw1Xq+skO/2kLGduqCFDlEGoMESdPpJlpkqQ6zCkiNEggJZlAdrfaqKnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000848; c=relaxed/simple;
	bh=oC8venrC7xC6hT6DJGyg6TMklBOFJtsRu01GJxY2pr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQchYbvCqbzmByluFfSQwqfCw1+AT04g9eOpqcMfwBlAb5Lpel1yCdnjPtfP9x2X/4YdDYm2WmgxcPYx8KaWd0GrXtG0/fV3qDFvRBuHWYXxUr0t3qTH+Ye2rw9l+O1u3pX9AMuX7c6BMWzksDXT4+6L3o9pjW7r2Nlr5wpCOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVbwmJKc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVbwmJKc"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49068493267so34370705e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 13:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780000845; x=1780605645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnzRVf8yaceLHogrALCaxw82HjdwzGDuq9+iL8xiuQM=;
        b=KVbwmJKcQWgEVgeTCKfk828us14hWm8vRD36IjMifrJGK8ooFWWISIhAPwhJqGVqng
         kP4HLSWCaW6d11ff+n9aAVnu1paCCkZUMGoc7lRPrBdNDR42xKWD29IUBHoK1ateC6Cg
         CyTK3vzbqxQyUjcur4xStVxzGkd0wlabZ64PgK1ybKV1KbISa5YHGPIBYE/RyjmAELaN
         OnRdzdp8B9qELIDaM+IBB2QrVopMaQ6iyoq1afCPMLk7MWR7xbPZhtWlEOosz7s8XMAX
         MmLt7oVQpnGrOsDuVhrDAmOEjapFj2lWdWXGR0iqwJrStgEJFZcHU7Dfx4IMDAkhecV7
         fJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000845; x=1780605645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tnzRVf8yaceLHogrALCaxw82HjdwzGDuq9+iL8xiuQM=;
        b=pQXrmmyrn6Sn4xm6ibaEbg9yCXwuObPLgvPrGGa16BP+yDUzxYSwVKBfJKK7FAG+EB
         j4sO7xmKJLpENP3KEl8tCc7q/gmsSMPyOoU3UOyZ1plZaKLdf6tE7B3yEsrpvPiDG40c
         INHyg5YJzaV9JcUOIlApcoC5o/15gtAVXRJxMrQROFo7yHnFfk9GO8QPkxudn1gpr4K3
         MqeXvLNJzwFWNc99il1zguLVNgdtfGD8Q6JoOLdsLiYAT+4QDDPJiD3sMTtL/Qbeos4Y
         kxAFI/QUaRnnW6oMcophw6A3rCW5/FrGtxHf8z7QzEyVnq5HiCw4C0cPMr64P1aDHn04
         GL4g==
X-Forwarded-Encrypted: i=1; AFNElJ/naei44Ihs3WUWAKbrQobtwfJ71H0oduYudef/v84AhTwEheg0uQYFs+sZILsWFUut8h207i1TxaB2HxS4nLba@vger.kernel.org
X-Gm-Message-State: AOJu0YxoYYd0rLzoDlTQVn//NdZiyfcCNMyGpF3jedxkynOTKPVpH0Yh
	3v8/7djNUyrlCMvgicSrIEwrUVerWDy2M4EcyuiWVwdU7oaqIAaFGLSZ
X-Gm-Gg: Acq92OEDbL+QW+ZlzQX5nC13kFCEiJTN4IAMw8Ug/d7Qp08p15p4vsdoSDWrHti4i2V
	t6mWRxHMatZhcLYAwiP4QpkQeHnkv5UtLjS+t7DEhGlAm8UJ+nUW+RbvTnUC1nsf9LzRwz63fYa
	PVyZd6WLsuw4eVW9p+aAhdHEkkKTn8er01teE7LFlJ2Wn402I+2bORM49aM4gCB+yT/+XhjOd4H
	0Ls3E3br+Z8XOiRh+GpC8yrbAJtPb5/fYMx8fvhdNbQF/DlnHvrY+Z56QCv1YRe6ttPj5ygXwtm
	/Fc1Kgdl3JbJ8O4rKUPBpmRWEZtt5w9xVNJcscE77iZ/OfPfvVDXd0QOePRBXZgIUv/KzbvhjvK
	6fP1ca/T1csDwFUiFKCI9OcfegVlCGBUiqGcmQ2AtlEf9B1jE47Y+2MChzGIxTDbj9esxTNlyOr
	OVMQM3i4vOYq5NBoaST1TqN+FzyT+vBAy2tU8dke3Rx1sBC0RI08U7juOjXHsw/HrT0tpfkOg=
X-Received: by 2002:a05:600d:84ca:20b0:48e:8741:fd3d with SMTP id 5b1f17b1804b1-4909c087599mr1155575e9.14.1780000845180;
        Thu, 28 May 2026 13:40:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54959bsm16989692f8f.1.2026.05.28.13.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:40:44 -0700 (PDT)
Date: Thu, 28 May 2026 21:40:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim
 <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf tests hwmon_pmu: Use PRIu64 + (u64) cast for a
 __u64 field to work more widely
Message-ID: <20260528214043.58afaa56@pumpkin>
In-Reply-To: <CAP-5=fUGaDGhvBU6z9hAuqFr5hpO9S-TKcW6bhwvjoA4j+xBRg@mail.gmail.com>
References: <ahidF9--hJ7YXPiO@x1>
	<CAP-5=fUGaDGhvBU6z9hAuqFr5hpO9S-TKcW6bhwvjoA4j+xBRg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 May 2026 12:55:45 -0700
Ian Rogers <irogers@google.com> wrote:

> On Thu, May 28, 2026 at 12:53=E2=80=AFPM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > While testing perf with an updated Debian experimental cross compiler
> > (gcc version 14.2.0 (Debian 14.2.0-13)) this started failing:
> >
> >   In file included from tests/hwmon_pmu.c:12:
> >   tests/hwmon_pmu.c: In function 'do_test':
> >   tests/hwmon_pmu.c:199:34: error: format '%lld' expects argument of ty=
pe 'long long int', but argument 7 has type '__u64' {aka 'long unsigned int=
'} [-Werror=3Dformat=3D]
> >     199 |                         pr_debug("FAILED %s:%d Unexpected con=
fig for '%s', %lld !=3D %ld\n",
> >         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   /git/perf-7.1.0-rc5/tools/perf/util/debug.h:20:21: note: in definitio=
n of macro 'pr_fmt'
> >      20 | #define pr_fmt(fmt) fmt
> >         |                     ^~~
> >   tests/hwmon_pmu.c:199:25: note: in expansion of macro 'pr_debug'
> >     199 |                         pr_debug("FAILED %s:%d Unexpected con=
fig for '%s', %lld !=3D %ld\n",
> >         |                         ^~~~~~~~
> >   tests/hwmon_pmu.c:199:79: note: format string is defined here
> >     199 |                         pr_debug("FAILED %s:%d Unexpected con=
fig for '%s', %lld !=3D %ld\n",
> >         |                                                              =
              ~~~^
> >         |                                                              =
                 |
> >         |                                                              =
                 long long int
> >         |                                                              =
              %ld
> >     LD      /tmp/build/perf/util/intel-pt-decoder/perf-util-in.o
> >
> > The usual make that %lld a PRIu64 (since arg7 is
> > evsel->core.attr.config, which is a __u64) but then on Fedora 44 (gcc
> > version 16.1.1 20260515 (Red Hat 16.1.1-2)) it ends up with:
> >
> >   In file included from tests/hwmon_pmu.c:13:
> >   tests/hwmon_pmu.c: In function =E2=80=98do_test=E2=80=99:
> >   tests/hwmon_pmu.c:200:34: error: format =E2=80=98%lu=E2=80=99 expects=
 argument of type =E2=80=98long unsigned int=E2=80=99, but argument 7 has t=
ype =E2=80=98__u64=E2=80=99 {aka =E2=80=98long long unsigned int=E2=80=99} =
[-Werror=3Dformat=3D]
> >     200 |                         pr_debug("FAILED %s:%d Unexpected con=
fig for '%s', %" PRIu64 " !=3D %ld\n",
> >         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~
> >   /home/acme/git/perf-tools-next2/tools/perf/util/debug.h:20:21: note: =
in definition of macro =E2=80=98pr_fmt=E2=80=99
> >      20 | #define pr_fmt(fmt) fmt
> >         |                     ^~~
> >   tests/hwmon_pmu.c:200:25: note: in expansion of macro =E2=80=98pr_deb=
ug=E2=80=99
> >     200 |                         pr_debug("FAILED %s:%d Unexpected con=
fig for '%s', %" PRIu64 " !=3D %ld\n",
> >         |                         ^~~~~~~~
> >   cc1: all warnings being treated as errors
> >
> > So the way to satisfy both compilers is to also add a (u64) cast to
> > arg7. =20
>=20
> As the inttypes.h definitions match stdint.h would it make more sense
> to use uint64_t for the cast?

Or use (unsigned long long) and "%lld".
Using PRIu64 and a cast is the worst of both worlds.

Where does the definition of __u64 come from?
#define __u64 @@
at the top of a file might give a clue.
I thought it was a Linux kernel type matching u64 - which is always 'unsign=
ed long long'.

-- David

>=20
> Thanks,
> Ian
>=20
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/tests/hwmon_pmu.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
> > index ada6e445c4c41e1b..870d59c0f7cba2e7 100644
> > --- a/tools/perf/tests/hwmon_pmu.c
> > +++ b/tools/perf/tests/hwmon_pmu.c
> > @@ -2,6 +2,7 @@
> >  #include "hwmon_pmu.h"
> >
> >  #include <errno.h>
> > +#include <inttypes.h>
> >
> >  #include <fcntl.h>
> >  #include <linux/compiler.h>
> > @@ -196,9 +197,9 @@ static int do_test(size_t i, bool with_pmu, bool wi=
th_alias)
> >                         continue;
> >
> >                 if (evsel->core.attr.config !=3D (u64)test_events[i].ke=
y.type_and_num) {
> > -                       pr_debug("FAILED %s:%d Unexpected config for '%=
s', %lld !=3D %ld\n",
> > +                       pr_debug("FAILED %s:%d Unexpected config for '%=
s', %" PRIu64 " !=3D %ld\n",
> >                                 __FILE__, __LINE__, str,
> > -                               evsel->core.attr.config,
> > +                               (u64)evsel->core.attr.config,
> >                                 test_events[i].key.type_and_num);
> >                         ret =3D TEST_FAIL;
> >                         goto out;
> > --
> > 2.54.0
> > =20
>=20

