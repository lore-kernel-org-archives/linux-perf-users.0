Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD412264C8
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Oct 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759526963; cv=none; b=lD5qsrUUU/BxfObU4Rtz3zWUkuWoJHq5NXK763cmjPOHr1JMZlwDOK/FNHd9z7vqiqYaBf17eheM+SZOL69YMrGRn5jpR09cfGzOE3cJce4BTzCsA3v2uCUJTLGZbyMCH9pG4+fFABcqXQi0Chjd7s7YREICSTUnLb5TanJGzGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759526963; c=relaxed/simple;
	bh=sgCLR2ngapQNLouWMOBzkBY/LCsMsAk0k5g8Ou9XOII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXOhGueGNFw282gWJ8h1MdKsd+UML18d0h2yrvlrOTXTJUC83PjWqftboSpYk2Sw3rpo49s7XRSpVN9/iV1Cm2DMFx4NZvRoHqolwajFF7I1cFcUvnwtEjx8ygOdphmc+gnzvSXL/NVIqgAWD2kl7OoDWINvOAbB22Bdc0lvCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2aorZwbA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2aorZwbA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27eeafd4882so64345ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Oct 2025 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759526961; x=1760131761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9VRi3EH24xBcxIT9mshnPJiIjgju22iBD0ykQ5/sxM=;
        b=2aorZwbAXX68+MXVgPmvCfhv4jEkNdI8P2SEUuAFRkKtw32p+yGosSsrAXRrQUk4XP
         jQxW2slUmMzmOAxwFTUou5iqmN/moFDfe0DhB5vHkbUZc7HZxI4OdVsfrzR4VF2dQrn/
         em1xYW6dMWvZfpzGhXnTaL2o5NI1lGTGFd3zHechaiDYiMNsUmP21oAVqBUpfcR0/6Zo
         0yyJ4u8+XwrkROX9C7gvje+LVKe5NrmOboM8ftRBA/EG2y7212bJx/lEOp8vHb18hMTb
         JZjAFn28RwzbxMpNOAQ4ibXAL99MXKuv2nMc1gtmBiUVxhRuyhgh8s/2UOblddLLLmsj
         tQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759526961; x=1760131761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9VRi3EH24xBcxIT9mshnPJiIjgju22iBD0ykQ5/sxM=;
        b=eeQd3qiCzOvV4c7DxWnBfR4Q9Lxjq90NGcq2/bcD8pCa82mZhfJpQ+DdCr5vu68i3J
         pqGcfk6PkVFQAK4oDRo4e2eC+TTZr9+2kE5ch1c6Lp/bsI+QAd+uWgrtwkHo9pELq3FZ
         zmNRtsIqZPIcIDyfYFFHKL1It4uQx0alGx4GBqy2Xsc80NL3QISf2DuVKoBaoSOtRPyY
         5mff5/K39h6e+FU5SPY8GY6WMQcttq4QMwnqKFbvcHC5HqEKOoPgx7VymVzSLpdtdvIi
         Sy8ExOVPpIU4mQ3oAm9pAcnsNlE0KVtHDypmEF0+O4qZ46pzDpryTQVfYwCPpaO5xEdy
         EQOg==
X-Forwarded-Encrypted: i=1; AJvYcCUeCgn1ViORCxhEwbMcpfvFWQpGefXhVt6TTtORU/K399CRnpV01frddzD9gueHk5XbdRkoSAyQ8RWqg+otwIR9@vger.kernel.org
X-Gm-Message-State: AOJu0YwAShn/oBsbSoTDsK5ZFhO46GrR6hRPs3ozu98xAYPuRQlMIwWS
	vHSMt5gS8/Ijv09f4mjqBpH52lDu4E2WSoTYRlePMcZDHG/KU1buTNPr+bU8BPvH8yHdkaFECzi
	78ILnILnHykBvN13gGmOojayKZdmXyYdyyRRHXeUd
X-Gm-Gg: ASbGnctCWLguNNQiqlDk/JMTXv1j54FQuU8/9p2oXxP/oy3FEpB8kQkUU3uJAHeNXeb
	E2j1WqsAn8uHQTR1RXBeM7G8+iX37Ikwiuz9miGIL6Q0nNdMBv9PXUR0zaUc3ZVq+83NIIIyLB5
	vu+g0rCuOk5rt+Y0VjG4z9hzNLiiNqDtfFOA5G2r7mAQdVgALc+t1wD56Kih4UZouqmBeDgPC+2
	/e8HnEiiOT8rp42ChUdemTKAaNvQ7G04djXfdY=
X-Google-Smtp-Source: AGHT+IHUleMTSV8OFBZDxUEi0C1/AcmU8XAZJZPNf2qZ0+XgxlY77yPW07NAORzho2z6VXpzlcFrk1fhQ/DDZCDalIA=
X-Received: by 2002:a17:903:3c70:b0:268:cc5:5e3c with SMTP id
 d9443c01a7336-28ea7f48339mr1229385ad.10.1759526960554; Fri, 03 Oct 2025
 14:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003175613.2512296-1-irogers@google.com> <20251003175613.2512296-2-irogers@google.com>
 <aOAoc0-Oy99l3iQG@x1>
In-Reply-To: <aOAoc0-Oy99l3iQG@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Oct 2025 14:29:09 -0700
X-Gm-Features: AS18NWCd15Gjm1sQjDY-vazJTUi06ucepjQjCnk20HrbpaC4TLu776xKUu3Fsmw
Message-ID: <CAP-5=fXVVg5BC-q85i4s8Phdp86UYEKTaKHcb75W76LdSa+_7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tools build: Remove get_current_dir_name
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 12:48=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Oct 03, 2025 at 10:56:13AM -0700, Ian Rogers wrote:
> > As perf no longer tests for this feature, and it was the only user,
> > remove the feature test.
>
> You forgot to remove this:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git diff
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-al=
l.c
> index 71ba7001dc25c6bb..8a354b81417c6fcc 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -151,7 +151,6 @@ int main(int argc, char *argv[])
>         main_test_libpython();
>         main_test_hello();
>         main_test_libelf();
> -       main_test_get_current_dir_name();
>         main_test_gettid();
>         main_test_glibc();
>         main_test_libdw();
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> That results, when building with this alias:
>
> alias m=3D'rm -rf ~/libexec/perf-core/ ; make CORESIGHT=3D1 -k O=3D/tmp/b=
uild/$(basename $PWD)/ -C tools/perf install-bin && perf test python && cat=
 /tmp/build/$(basename $PWD)/feature/test-all.make.output'
>
> that needs to be on the makefiles somewhere, shows that test-all.bin is
> failing to build:
>
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
>  88: 'import perf' in python                                         : FA=
ILED!
> test-all.c: In function =E2=80=98main=E2=80=99:
> test-all.c:154:9: error: implicit declaration of function =E2=80=98main_t=
est_get_current_dir_name=E2=80=99; did you mean =E2=80=98get_current_dir_na=
me=E2=80=99? [-Wimplicit-function-declaration]
>   154 |         main_test_get_current_dir_name();
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |         get_current_dir_name
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> I fixed this up already,

Sorry for that. Thanks for fixing it up!
Ian

> Thanks,
>
> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/build/Makefile.feature                    |  1 -
> >  tools/build/feature/Makefile                    |  4 ----
> >  tools/build/feature/test-all.c                  |  4 ----
> >  tools/build/feature/test-get_current_dir_name.c | 11 -----------
> >  4 files changed, 20 deletions(-)
> >  delete mode 100644 tools/build/feature/test-get_current_dir_name.c
> >
> > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.featur=
e
> > index 9c1a69d26f51..9399f591bd69 100644
> > --- a/tools/build/Makefile.feature
> > +++ b/tools/build/Makefile.feature
> > @@ -68,7 +68,6 @@ FEATURE_TESTS_BASIC :=3D                  \
> >          libdw                           \
> >          eventfd                         \
> >          fortify-source                  \
> > -        get_current_dir_name            \
> >          gettid                               \
> >          glibc                           \
> >          libbfd                          \
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index b41a42818d8a..d13d2a1f44fe 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -8,7 +8,6 @@ FILES=3D                                          \
> >           test-libdw.bin                         \
> >           test-eventfd.bin                       \
> >           test-fortify-source.bin                \
> > -         test-get_current_dir_name.bin          \
> >           test-glibc.bin                         \
> >           test-gtk2.bin                          \
> >           test-gtk2-infobar.bin                  \
> > @@ -147,9 +146,6 @@ $(OUTPUT)test-libelf.bin:
> >  $(OUTPUT)test-eventfd.bin:
> >       $(BUILD)
> >
> > -$(OUTPUT)test-get_current_dir_name.bin:
> > -     $(BUILD)
> > -
> >  $(OUTPUT)test-glibc.bin:
> >       $(BUILD)
> >
> > diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-=
all.c
> > index e1847db6f8e6..778883a32afb 100644
> > --- a/tools/build/feature/test-all.c
> > +++ b/tools/build/feature/test-all.c
> > @@ -22,10 +22,6 @@
> >  # include "test-libelf.c"
> >  #undef main
> >
> > -#define main main_test_get_current_dir_name
> > -# include "test-get_current_dir_name.c"
> > -#undef main
> > -
> >  #define main main_test_gettid
> >  # include "test-gettid.c"
> >  #undef main
> > diff --git a/tools/build/feature/test-get_current_dir_name.c b/tools/bu=
ild/feature/test-get_current_dir_name.c
> > deleted file mode 100644
> > index c3c201691b4f..000000000000
> > --- a/tools/build/feature/test-get_current_dir_name.c
> > +++ /dev/null
> > @@ -1,11 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#define _GNU_SOURCE
> > -#include <unistd.h>
> > -#include <stdlib.h>
> > -
> > -int main(void)
> > -{
> > -     free(get_current_dir_name());
> > -     return 0;
> > -}
> > -#undef _GNU_SOURCE
> > --
> > 2.51.0.618.g983fd99d29-goog
