Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9033823ED6A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691582; cv=none; b=ktK1ECQrXTsV2ntxqkAx5ejp5UO9sRs1oOgEP8jMNUN4cuceCCfTJrYORrfFfXO6+eTPLOMNq9lfd7H7KoJKaS6JNtRMOGuzxNoIW2DZD3FhSPeDV0Gnpvail/vLUo+0b9A9Qe1Plrhl0YAAkRVYkwSC+EPsBQSU86Ch7XALjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691582; c=relaxed/simple;
	bh=pTTZcRj9DId2ZvPOeWmaUNyph2whs2Bb+Fr/O9WRfwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYBcfXoE9no77E6mu9CJWQxFd7l7AQzAYNIKC0xuJBE0Ji9KaQJBqKGfVbFZgHBh4NfIxtC9osUaw3x4EKxbIOP+Zly/zgFv+N4lKR47rW1sLDhOhlvmBTYmWRM4mKQ8C8mufrBgOSSIxS2sxfl6xLWM1wYx4JAxFGrm3g9Tw5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c98wl3cD; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c98wl3cD"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ddd1a3e659so361195ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750691580; x=1751296380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mnxjz5dmIOfE5ct74X590DWV56+gnOXa9jI3Dx4SADY=;
        b=c98wl3cDiEDeL3WhB1ccK/aRJE+/otiU78yYuaqtfR1ET9c2XqGqGuk2RTac7Ym0DJ
         CC67kV5wwhZQLosI3znUoxeAXkbS3w6DCla/T+eRajTyWTViyCXo81ExzMvluUbZHoLd
         q9cUoXe601vnJF1tPFsR5SPsPUhZu56BluT/CMBykEpZC7hfdcrZMIDtW/3Gn3kettRV
         Ti8wr0KsgrjdSwupGWtM8y3Vg3LpUh1Esug56QrANn1L3LYTXVQ8rcerk39BYYliUD+d
         DW09fhZF/DZ2LqmUbBJLAq+U8l33axVNTs77mNWfZ+CY15d6Q0Jjacelk7pUAJWbzKSh
         0dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691580; x=1751296380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mnxjz5dmIOfE5ct74X590DWV56+gnOXa9jI3Dx4SADY=;
        b=fHmB/op0Vp3NWp09qLfhRz7Jl+V1urEdnrbbnjDdp0/6Ifss7Sz1zukMGqiWrkpA3Z
         S2QF8rnygyLxScV05jM2bU/WcC31pn7/oV5tE/kCFMK253krykpLkyE3zQS1Mc+W5uzQ
         OfDo7EKCTqV9DdABEvIEUlIiagUr0f9jfmOIv4ZUJ/jPW1dpf+1Hl8FhWpELAe3CNUlQ
         AMoIvm3fZC1GPJaQ1zB2THwOlhu8BReQ/eVSnS9uZ44K3+b6lGLgJKhFXXd6JgrULMPw
         lssnlKNzuko7fyZi71KQwPK5SFW++3+prt6SAKCvzIko52FdXEG8ZyUZ9m5//spDQB6v
         oPsA==
X-Forwarded-Encrypted: i=1; AJvYcCVziakfzXHg4jvYG2D1N5wR4EjUfjQoApyNNnFvBSCxCSHg2xSk2GMUqJfi6ioXIgBDTEfnBxVCQksD4mYHSkv+@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEU0rvc+jpYcr3miN6OJu418Xd/ZEhgZ0q2lzZI6/Bmb8PZnN
	cNmXSr+j6V6JHTGQHwpv9qPjwpSQAwRUDQUp8OEig8xxA0JfgXE9JZOw5C09N2KxKTea720X8/k
	jevua+DmFS/uBN/hJR3lkn8EEkceYIgEbev2SHxvS
X-Gm-Gg: ASbGncuyl0YHZickxfE+19cJRc/KEpF3bKKtlHKNUeYawu756B+l0s30r+xJXYa2MbZ
	0RbWITFMeaZLld20Vf4JGOWxWGTAWi8uldOinNholmeE4aVTd5Q1DHaCsUZegLB1pKUMWwInnIb
	jHtavCSClF1uFRZA++IKf/7cNuQyuPz5BSwvxRCWaTFWYMBkeA1AtMagUEWJRxs0qGDzsm5NT9
X-Google-Smtp-Source: AGHT+IE8gIT7WMGF5c34LGPl6UQebM0f8gjV+JTGABGoMmYQ/5qwTt7OO7vZdNuzPwnYzz+ZM+IfaqM7KM/36j/PkHU=
X-Received: by 2002:a05:6e02:184f:b0:3dc:5cb1:8f24 with SMTP id
 e9e14a558f8ab-3df0da148f5mr5687465ab.9.1750691579267; Mon, 23 Jun 2025
 08:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619002034.97007-1-irogers@google.com> <aFW4VJtk96JD865U@google.com>
In-Reply-To: <aFW4VJtk96JD865U@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Jun 2025 08:12:47 -0700
X-Gm-Features: AX0GCFuBMGlka0OTxLTpe-4n1RG-F3_OoLNQ1mo06Bc_W8WiH7hXnMEGIn4fhxc
Message-ID: <CAP-5=fUpnW1DE68pMW0q3vMT+n6d5SeNkwXd45XLaf01-eP47A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf test workload noploop: Name the noploop process
To: Namhyung Kim <namhyung@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 12:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Wed, Jun 18, 2025 at 05:20:33PM -0700, Ian Rogers wrote:
> > Name the noploop process "perf-noploop" so that tests can easily check
> > for its existence.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/workloads/noploop.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/wo=
rkloads/noploop.c
> > index 940ea5910a84..8b954d466083 100644
> > --- a/tools/perf/tests/workloads/noploop.c
> > +++ b/tools/perf/tests/workloads/noploop.c
> > @@ -2,6 +2,8 @@
> >  #include <stdlib.h>
> >  #include <signal.h>
> >  #include <unistd.h>
> > +#include <linux/prctl.h>
> > +#include <sys/prctl.h>
>
> I'm afraid it'd introduce a build failure on musl.  Please see
>
> https://lore.kernel.org/linux-perf-users/20250611092542.F4ooE2FL@linutron=
ix.de/
>
> I think <sys/prctl.h> would be enough.

Hi Namhyung,

we could do that but in the glibc man page it says:
https://man7.org/linux/man-pages/man2/prctl.2.html
```
#include <linux/prctl.h>  /* Definition of PR_* constants */
#include <sys/prctl.h>
```
So wouldn't the PR_SET_NAME definition potentially be missing then? We
could fill in the missing definition with `#ifndef PR_SET_NAME` it
seems sub-optimal - I see this is what was done in the linked to
changes. Perhaps we need something like a tools/perf/util/prctl.h, and
a feature test, then in that we have something like:
```
/* A header file to work around musl libc breakages caused conflicting
definitions in linux/prctl.h . */
#ifndef HAVE_SENSIBLE_PRCTL
#  include <linux/prctl.h>
#  include <sys/prctl.h>
#else // !HAVE_SENSIBLE_PRCTL
#  include <sys/prctl.h>
#  ifndef PR_SET_NAME
#    define PR_SET_NAME 15
#  endif // PR_SET_NAME
#  ifndef PR_FUTEX_HASH
#    define PR_FUTEX_HASH                   78
#    define PR_FUTEX_HASH_SET_SLOTS        1
#    define FH_FLAG_IMMUTABLE              (1ULL << 0)
#    define PR_FUTEX_HASH_GET_SLOTS        2
#    define PR_FUTEX_HASH_GET_IMMUTABLE    3
#  endif // PR_FUTEX_HASH
#endif // HAVE_SENSIBLE_PRCTL
```
The feature test would just be to include the two headers and see if
the build breaks.

It'd be nice to think musl was slowly getting fixed. I notice we're
carrying two comments in the code about working around musl, but I
suspect we do this kind of thing in a lot of places (just knowing the
issues that come up from yourself and Arnaldo when trying to integrate
patches). It'd be nice if perf's code could keep close to what the man
page, or whatever, is saying the standard should be, rather than doing
some kind of adhoc linux/prctl.h rewrite (or if we are doing that,
make the code more explicit that it's what we're doing).

It'd be nice to think that the perf code could be clean wrt analyses
like "include what you use" [1], but strategically removing #includes
to try to work around musl issues seems like the opposite of this.

Thanks,
Ian

[1] https://github.com/include-what-you-use/include-what-you-use

> Thanks,
> Namhyung
>
>
> >  #include <linux/compiler.h>
> >  #include "../tests.h"
> >
> > @@ -16,6 +18,7 @@ static int noploop(int argc, const char **argv)
> >  {
> >       int sec =3D 1;
> >
> > +     prctl(PR_SET_NAME, "perf-noploop");
> >       if (argc > 0)
> >               sec =3D atoi(argv[0]);
> >
> > --
> > 2.50.0.rc2.701.gf1e915cc24-goog
> >
