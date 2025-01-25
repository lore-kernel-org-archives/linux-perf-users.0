Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F38821
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jan 2025 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737766776; cv=none; b=a1V7znfe9hkU1gFiKtYxu9Hkt53EOCWuvL35vmwyWXLSZcQp+PLZL5zKYLUyWwlXuXLTilih881j1bgEqQumlAyFK0wNe23XqFHhWHoYovKMdjbPF3PCOPceJREVOPMM2vIM9pOwEhfJ9zTmqZ6iCnBwMk0jT6GjB4d1jgIvnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737766776; c=relaxed/simple;
	bh=Ilq9sG8JKYA4H+fvAVGKWLkyxIF6IHweN1JBP/ZoAJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLCXPIUDk4SqAB6vzbu8vqAXlqK+6JkYK/twlpgLnN/jCgba+sBe5+2bDO7lk0PFUU4qSyhbn4PPgIeVJNIANUUTjU1iGJrCSDjxVycnYsN/oGzTQWEjxtfF/Y8aiP74yRDIxfjUV7s0cDlZlEwFgd+cwdbITNFxWIi48FllhME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5aPdWIo; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5aPdWIo"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so41835ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 16:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737766774; x=1738371574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvwNFInayukMcJtdYJm+4EZPaQ/jTSatsUUoZ8KS1Fk=;
        b=d5aPdWIo+FWVWPD1GJ2CuemrcBO0P/M30tCNAQV+9p6D2ShyZ9xqsDDi5oOkFSZJaB
         6I0gE4+Hr96Du19RcCu6R8jC2bSi3Yx5clRjL8+JA35AeNcpVAJEThrisMyAa6vTp2tu
         ObDhMLlMJf4YlcN6xO0L3zMZ0boNorAoY7EWg2JJ2PSPhVqvKokn0Y1kme6cOJ/aiBHW
         qI6UTIz4wb4sakcLOxN6Hk4A8V8B0w2RiuVsorLnx6P55il3nSe030veGzq8xIq/rIgi
         QiXBssy4xRyQe3IURq7Q4lMzQhKqAN/xDyaSNDd8ZFymZD3Lc9ir0rfybPitbQhcMt7a
         NwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737766774; x=1738371574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvwNFInayukMcJtdYJm+4EZPaQ/jTSatsUUoZ8KS1Fk=;
        b=tFNEmEihEZQUVweBeqnzySBXNG29R6iF0NYqGg90P5tLjfQaLsfxG1pkhv/W9aeOw4
         xsQvxmHte7A4lviFyhV9DutCWJbOH0D3PoFfmBS0jsm1t/yl47FH983dMjpaCj0zZZXB
         nnIjpSsoe9+/J4wqpatvDEAcFD3SWebzzxvMwvugzWcTEuXeD0lbQInTBfNPrkIFEY29
         5ZQshIhMjT70IQIgX7jkulHedZOe7HyOC+53+HAxWVHBhZPnFvbcOri2sB+JdEWIV5jd
         YWONryeEcLEOcoqpRcGX+PnYkN6XqLFnOk4xi8/lcSvWrqCUr9hmnRYGSmi1LKQNKs0y
         d4KA==
X-Forwarded-Encrypted: i=1; AJvYcCWmg6w8uPy1pCPycQw/o+TH5eiR2uKu68Byqw17N3+WmJIOCd/tSEDOw+efwyBRYmCpOkqRZJz42M59oGDnpm3+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwej0+ZNJRHoYDwcq66bUpyyw32qvoSjSwEfUN/MCHBexyrojT
	+Iy7PSYe27OD14MuqKEuZ6ouSwR1YAu02NYnEST/6DjqdfCrJaGI66BPfSkkL/xEjSA7uRDmVLz
	J/O/7WGeZZDvKqlwFDLK/EqNoEoh6BlDxFMSo
X-Gm-Gg: ASbGnctOxtQto0hmXUm5PO9Xff/rrZtIHZtRDu9ropymVePKh8zeWURTpsOXljX7swl
	bq7ngM0pB2r666oYWtu4Oi8gbR+qa+yY2PxulneWRUAK883fR4e0a2JoGh0cZR3I=
X-Google-Smtp-Source: AGHT+IGh6ivw0qBP88gyiao18KHDgot1XcauQGKSYwcM9daOgt1ih9JPzBPb/ZTgOfAUg0HkcgcVg7rmGc4ArDfHqMU=
X-Received: by 2002:a05:6e02:1a4c:b0:3cf:cb47:9963 with SMTP id
 e9e14a558f8ab-3cfd20f3b7amr730665ab.25.1737766773969; Fri, 24 Jan 2025
 16:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com> <20250122174308.350350-4-irogers@google.com>
 <Z5QM8nHzwuQYczyQ@google.com>
In-Reply-To: <Z5QM8nHzwuQYczyQ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 Jan 2025 16:59:21 -0800
X-Gm-Features: AWEUYZmjvpS3jmWoPhF4fcTYu0oQT1XVXYfxlbBmbmP1TgNbAdiddMkuBPFhAFw
Message-ID: <CAP-5=fV0w9tLFr7xYHFUH=UUq+tr+o5EYUik0d74rMWa9=Qi+A@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] perf capstone: Move capstone functionality into
 its own file
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 1:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jan 22, 2025 at 09:42:53AM -0800, Ian Rogers wrote:
> > Capstone disassembly support was split between disasm.c and
> > print_insn.c. Move support out of these files into capstone.[ch] and
> > remove include capstone/capstone.h from those files. As disassembly
> > routines can fail, make failure the only option without
> > HAVE_LIBCAPSTONE_SUPPORT. For simplicity's sake, duplicate the
> > read_symbol utility function.
> >
> > The intent with moving capstone support into a single file is that
> > dynamic support, using dlopen for libcapstone, can be added in later
> > patches. This can potentially always succeed or fail, so relying on
> > ifdefs isn't sufficient. Using dlopen is a useful option to minimize
> > the perf tools dependencies and potentially size.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-script.c  |   2 -
> >  tools/perf/util/Build        |   1 +
> >  tools/perf/util/capstone.c   | 536 +++++++++++++++++++++++++++++++++++
> >  tools/perf/util/capstone.h   |  24 ++
> >  tools/perf/util/disasm.c     | 358 +----------------------
> >  tools/perf/util/print_insn.c | 117 +-------
> >  6 files changed, 569 insertions(+), 469 deletions(-)
> >  create mode 100644 tools/perf/util/capstone.c
> >  create mode 100644 tools/perf/util/capstone.h
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 33667b534634..f05b2b70d5a7 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -1200,7 +1200,6 @@ static int any_dump_insn(struct evsel *evsel __ma=
ybe_unused,
> >                        u8 *inbuf, int inlen, int *lenp,
> >                        FILE *fp)
> >  {
> > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> >       if (PRINT_FIELD(BRSTACKDISASM)) {
> >               int printed =3D fprintf_insn_asm(x->machine, x->thread, x=
->cpumode, x->is64bit,
> >                                              (uint8_t *)inbuf, inlen, i=
p, lenp,
> > @@ -1209,7 +1208,6 @@ static int any_dump_insn(struct evsel *evsel __ma=
ybe_unused,
> >               if (printed > 0)
> >                       return printed;
> >       }
> > -#endif
> >       return fprintf(fp, "%s", dump_insn(x, ip, inbuf, inlen, lenp));
> >  }
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 5ec97e8d6b6d..9542decf9625 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -8,6 +8,7 @@ perf-util-y +=3D block-info.o
> >  perf-util-y +=3D block-range.o
> >  perf-util-y +=3D build-id.o
> >  perf-util-y +=3D cacheline.o
> > +perf-util-y +=3D capstone.o
> >  perf-util-y +=3D config.o
> >  perf-util-y +=3D copyfile.o
> >  perf-util-y +=3D ctype.o
> > diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> > new file mode 100644
> > index 000000000000..c0a6d94ebc18
> > --- /dev/null
> > +++ b/tools/perf/util/capstone.c
> > @@ -0,0 +1,536 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "capstone.h"
> > +#include "annotate.h"
> > +#include "addr_location.h"
> > +#include "debug.h"
> > +#include "disasm.h"
> > +#include "dso.h"
> > +#include "machine.h"
> > +#include "map.h"
> > +#include "namespaces.h"
> > +#include "print_insn.h"
> > +#include "symbol.h"
> > +#include "thread.h"
> > +#include <fcntl.h>
> > +#include <string.h>
> > +
> > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > +#include <capstone/capstone.h>
> > +#endif
>
> I think you can use a big #ifdef throughout the file to minimize the
> #ifdef dances.  Usually it goes to the header to provide dummy static
> inlines and make the .c file depends on config.  But I know you will
> add dlopen code for the #else case later.

So I think big ifdefs like:

#if HAVE_xyz
// 100s of lines
#else
// 100s of lines
#endif

are best avoided. It is also the point of the shim-ing that we do

... perf_foobar(...)
{
#if NO_SHIM
  ... foobar(...);
#else
  //dlsym code
#endif
}

Having the shimming and not shimming as two separate functions buried
in a 100 #ifdef loses that the code is common except for the shimming.

For example, in the current code we have find_file_offset:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/disasm.c?h=3Dperf-tools-next&id=3D91b7747dc70d64b5ec56ff=
e493310f207e7ffc99#n1371

It is only possible to understand the use of this seemingly common
code by trying to interpret what's going on with the #ifdefs.

I think it stylistically it is okay to have multiple stubbed out
functions inside a #if or #else, such as:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/include/linux/perf_event.h?h=3Dperf-tools-next&id=3D91b7747dc70d64b5ec56=
ffe493310f207e7ffc99#n1797

But when the logic is shared and all in one file it becomes next to
impossible to determine what's in use and what's not. Other than by
tweaking things and trying to get build errors.

So for the shims I've placed the #if inside the function to make it
clear the function is a shim. For the other functions that are over
100s of lines, for clarity the individual functions have #if
HAVE_LIBLLVM_SUPPORT around them to make it clear that the function
only has a meaning in that context - ie the source code doesn't make
you go on a #ifdef finding expedition to try to understand when the
code is in use.

Thanks,
Ian
