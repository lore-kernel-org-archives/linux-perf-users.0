Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214E19ADA2
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102590; cv=none; b=ghbXP2b0tBuPCHccJOyEeYr3p75y/2rPr/KDIkmeXowZAFf3RAJl4bm0KZsrDFSL78/KcAnqHdeq1ToVIlzhkM+ALGHxOMFnpUda7AIfGK9g38VO6R/OUm/VM+05T4lVJumCy8NEOQYgEGy4c3RgkcUjzsGojU/vrbQBzNSzM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102590; c=relaxed/simple;
	bh=yFM1drfDCyYii33JCCgfl0iNAkmuf/K9UQeme7D5bH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HD3zxVLMNanIiT0jkFSGG91EXnN0e5PG0yVhYLexde5Q6o5sSiQSJIIvamBjrkHOb1X0nbUpD322xfA92eyq5vOfYsCf1nZDq6jO1q2D4wMIFbKxDx1RbTtugXNUNJxRvT2WwC362fNGvqK3N9xagk18zC5xx9KN4emZ+B4+vwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xB74T11C; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xB74T11C"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so175865ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 14:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738102588; x=1738707388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9thD99sxYOxhZcIVt1CWIvx0RPYfcuFGVdmxBJHmWDw=;
        b=xB74T11CqUviu69aIjaKuWsmMaSnUnNjG8LPaI3oYYFFjojcSikS+MXQV1dBMV2chk
         7bt1ywiprneGEr320UDhn45/6O3Gy6Zv4Sq7GhhVkGwGyuWiwsVwXAHGuI6bCrueSJs4
         kUJQ97QEZaCW5Rlzc9/tDyA6l9t/8th3oKLckxDGkdELeUH23eAm+8FwhG9XSmL6lrAC
         PbzMgivEtPUomdQnRKg1vuf9gziLc3S6Xx1YX+gXhuf6fxkpbOOOtVsDQgTpCS1ywdBd
         oFsjW6KmeXfr+rtuga4Mwx7aUTd5G2k6Wm1/2e0arGIj2pd7ezsBrtlrJNJSP9/6nlpX
         Zywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738102588; x=1738707388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9thD99sxYOxhZcIVt1CWIvx0RPYfcuFGVdmxBJHmWDw=;
        b=NsA23GVSdM8PKMGzNxfLSNeQZT/m/1mtKcDYX16/4QKqu1p/39yxebP+X+/blLtvw2
         yGqDHyqK6ZrkP7NlyvSKRjZE60z5PMkP98p2cvjP/a+sojeaZGCYOMYeMsHscFVBryOe
         tWnJfXaoyDoSTXY7WKmEYWn1HLgeEDKB93A+VDk3FmU8BlfpeGI4twn6WvOdPd0u7CZ6
         hQLX4PoTwgZkFnVk3a4I4WZIoMV49QBoZ07i+FRYVc3a2xxxYe7I8KAnWiwe5/Yw91Tb
         KGnsXnxcgEdIOtFQAwkJ31afdeyI8PE5PSg8ynOlEGJFP1N+XVdt+6+H/6wS7xVftqrI
         P6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXnNozlJrHJU2rvf2D5cOouRFFE8Hvosl8UJlNKuuoWg8S3NOsLjulLeRKJKglaUsrILUNoifClEl+V1rWOt9Tx@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBsJnp6vIJhefIPSZtNH1ChxyLOiZJ/Wrk2kn24gBg6e+y3P8
	HOUDCe/8+G4GlVwYQ+doE2+FGIeHh6qWCJNteONZDJVK9ccHe1yYVlnDUYcA9uC/XvOPs1zIrr0
	s9O++I0Jyya0wseON6h611nB7f5/SWgeXF0qZ
X-Gm-Gg: ASbGncus4uhPbS0EtjQOurS0dHQ6arnxR2PQYUJw2RD06oqSuPQjaZNBD6exdijwxfO
	BMi5HOIeI3Foxb12hrvACda/SIezh+N0OgUMoScyFAqmO6QPepvZzd4135MAxCA+b1GY4jk9Zz3
	XnUzGj4cYZsHOUYBk+TEdnkU8cUaFv9fw34d4=
X-Google-Smtp-Source: AGHT+IGtqIx6PgyLvYpYwW+PR2OriKGx9AdoInnVjbPzjZdYdwtGYpVsyGldmefUzK9d6ImyEATO7nAaU8dl251a9qQ=
X-Received: by 2002:a05:6e02:1aa4:b0:3a7:c962:95d1 with SMTP id
 e9e14a558f8ab-3cfffaa327dmr320135ab.5.1738102587960; Tue, 28 Jan 2025
 14:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com> <20250122174308.350350-4-irogers@google.com>
 <Z5QM8nHzwuQYczyQ@google.com> <CAP-5=fV0w9tLFr7xYHFUH=UUq+tr+o5EYUik0d74rMWa9=Qi+A@mail.gmail.com>
 <Z5lEdtLVHRZwxuY8@google.com>
In-Reply-To: <Z5lEdtLVHRZwxuY8@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Jan 2025 14:16:15 -0800
X-Gm-Features: AWEUYZlB9pwGJzob7bkqmuwI_Kstr1xWBj7EqDzPTNRqrFBjlPerFeGCGcxR96s
Message-ID: <CAP-5=fWabK5a2C5Qyy2GPtmx1uXM2bu+pQO+JKpfZ2VhtLt2zg@mail.gmail.com>
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

On Tue, Jan 28, 2025 at 12:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, Jan 24, 2025 at 04:59:21PM -0800, Ian Rogers wrote:
> > On Fri, Jan 24, 2025 at 1:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, Jan 22, 2025 at 09:42:53AM -0800, Ian Rogers wrote:
> > > > Capstone disassembly support was split between disasm.c and
> > > > print_insn.c. Move support out of these files into capstone.[ch] an=
d
> > > > remove include capstone/capstone.h from those files. As disassembly
> > > > routines can fail, make failure the only option without
> > > > HAVE_LIBCAPSTONE_SUPPORT. For simplicity's sake, duplicate the
> > > > read_symbol utility function.
> > > >
> > > > The intent with moving capstone support into a single file is that
> > > > dynamic support, using dlopen for libcapstone, can be added in late=
r
> > > > patches. This can potentially always succeed or fail, so relying on
> > > > ifdefs isn't sufficient. Using dlopen is a useful option to minimiz=
e
> > > > the perf tools dependencies and potentially size.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/builtin-script.c  |   2 -
> > > >  tools/perf/util/Build        |   1 +
> > > >  tools/perf/util/capstone.c   | 536 +++++++++++++++++++++++++++++++=
++++
> > > >  tools/perf/util/capstone.h   |  24 ++
> > > >  tools/perf/util/disasm.c     | 358 +----------------------
> > > >  tools/perf/util/print_insn.c | 117 +-------
> > > >  6 files changed, 569 insertions(+), 469 deletions(-)
> > > >  create mode 100644 tools/perf/util/capstone.c
> > > >  create mode 100644 tools/perf/util/capstone.h
> > > >
> > > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-scrip=
t.c
> > > > index 33667b534634..f05b2b70d5a7 100644
> > > > --- a/tools/perf/builtin-script.c
> > > > +++ b/tools/perf/builtin-script.c
> > > > @@ -1200,7 +1200,6 @@ static int any_dump_insn(struct evsel *evsel =
__maybe_unused,
> > > >                        u8 *inbuf, int inlen, int *lenp,
> > > >                        FILE *fp)
> > > >  {
> > > > -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > > >       if (PRINT_FIELD(BRSTACKDISASM)) {
> > > >               int printed =3D fprintf_insn_asm(x->machine, x->threa=
d, x->cpumode, x->is64bit,
> > > >                                              (uint8_t *)inbuf, inle=
n, ip, lenp,
> > > > @@ -1209,7 +1208,6 @@ static int any_dump_insn(struct evsel *evsel =
__maybe_unused,
> > > >               if (printed > 0)
> > > >                       return printed;
> > > >       }
> > > > -#endif
> > > >       return fprintf(fp, "%s", dump_insn(x, ip, inbuf, inlen, lenp)=
);
> > > >  }
> > > >
> > > > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > > > index 5ec97e8d6b6d..9542decf9625 100644
> > > > --- a/tools/perf/util/Build
> > > > +++ b/tools/perf/util/Build
> > > > @@ -8,6 +8,7 @@ perf-util-y +=3D block-info.o
> > > >  perf-util-y +=3D block-range.o
> > > >  perf-util-y +=3D build-id.o
> > > >  perf-util-y +=3D cacheline.o
> > > > +perf-util-y +=3D capstone.o
> > > >  perf-util-y +=3D config.o
> > > >  perf-util-y +=3D copyfile.o
> > > >  perf-util-y +=3D ctype.o
> > > > diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.=
c
> > > > new file mode 100644
> > > > index 000000000000..c0a6d94ebc18
> > > > --- /dev/null
> > > > +++ b/tools/perf/util/capstone.c
> > > > @@ -0,0 +1,536 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +#include "capstone.h"
> > > > +#include "annotate.h"
> > > > +#include "addr_location.h"
> > > > +#include "debug.h"
> > > > +#include "disasm.h"
> > > > +#include "dso.h"
> > > > +#include "machine.h"
> > > > +#include "map.h"
> > > > +#include "namespaces.h"
> > > > +#include "print_insn.h"
> > > > +#include "symbol.h"
> > > > +#include "thread.h"
> > > > +#include <fcntl.h>
> > > > +#include <string.h>
> > > > +
> > > > +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> > > > +#include <capstone/capstone.h>
> > > > +#endif
> > >
> > > I think you can use a big #ifdef throughout the file to minimize the
> > > #ifdef dances.  Usually it goes to the header to provide dummy static
> > > inlines and make the .c file depends on config.  But I know you will
> > > add dlopen code for the #else case later.
> >
> > So I think big ifdefs like:
> >
> > #if HAVE_xyz
> > // 100s of lines
> > #else
> > // 100s of lines
> > #endif
> >
> > are best avoided. It is also the point of the shim-ing that we do
> >
> > ... perf_foobar(...)
> > {
> > #if NO_SHIM
> >   ... foobar(...);
> > #else
> >   //dlsym code
> > #endif
> > }
> >
> > Having the shimming and not shimming as two separate functions buried
> > in a 100 #ifdef loses that the code is common except for the shimming.
>
> Right, can we split the common part and move it out of #ifdef?
>
> >
> > For example, in the current code we have find_file_offset:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/disasm.c?h=3Dperf-tools-next&id=3D91b7747dc70d64b5ec=
56ffe493310f207e7ffc99#n1371
> >
> > It is only possible to understand the use of this seemingly common
> > code by trying to interpret what's going on with the #ifdefs.
> >
> > I think it stylistically it is okay to have multiple stubbed out
> > functions inside a #if or #else, such as:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/include/linux/perf_event.h?h=3Dperf-tools-next&id=3D91b7747dc70d64b5=
ec56ffe493310f207e7ffc99#n1797
>
> I think the convention in the kernel community is that it's better to
> remove #ifdef's in .c files and add a dummy functions under !condition
> in .h files.  If that's not possible, I think we should make the code
> less conditional by minimizing the #ifdef's.
>
> >
> > But when the logic is shared and all in one file it becomes next to
> > impossible to determine what's in use and what's not. Other than by
> > tweaking things and trying to get build errors.
> >
> > So for the shims I've placed the #if inside the function to make it
> > clear the function is a shim. For the other functions that are over
> > 100s of lines, for clarity the individual functions have #if
> > HAVE_LIBLLVM_SUPPORT around them to make it clear that the function
> > only has a meaning in that context - ie the source code doesn't make
> > you go on a #ifdef finding expedition to try to understand when the
> > code is in use.
>
> I think the both approaches have their own pros and cons.  Some people
> prefer one and others may have different opinions.  I think the big
> conditional block is better and easy to follow.  Maybe we cannot agree
> on this.  Then I believe it'd be better to follow the convention, no?

You are talking about a different convention. We're not doing
something or having a dummy function, we're having a direct call to
the underlying function or doing a shim through a dlsym. Having those
in 2 separate functions and having the #ifdefs separated from the code
it controls will impact the readability and lose the association I'm
very much after having.

Thanks,
Ian
