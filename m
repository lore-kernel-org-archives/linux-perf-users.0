Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C82F531A
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Nov 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320426; cv=none; b=u9DOURH+9hz6RLga4r7rkmmwiIexFANUQfC0H18EHlQft/CwlHsuPRCKovvpuRj385Rn4PYKU1PGfsVumiNOoGJzGhEnsPB2HeXQXzvFLEd6HBuXV9lrCC9xzur1RGFCLFCJwHDEIpcG84AlatMDp3uc29TnIlvm6cDWXFjw+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320426; c=relaxed/simple;
	bh=ff0gOAXqGwtn8lobIYPgcGy2BPPYdRK6ixSfHdpXqPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdqKNslNmMt8CG7ZUmT49jcSrNSKNaM/7EtcIfkhNBa+yqgE+OGVNI9pZmDK9XarUXy8N8d7FXkXxp7+1DOOEM7Bi/XthZ4yOftDQWPsSZ9tgFYZjJ/eAaNro4NvuCGasVho3IJalHy2MPW4phngyLVChAa5TZUgMtS36hfKSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2FmbcM8A; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2FmbcM8A"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29852dafa7dso306325ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Nov 2025 01:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764320423; x=1764925223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsQJf/MywXHKgJmR1kRmp27TSDzlggTLXvKMYxx53G8=;
        b=2FmbcM8Are4dCses4M2u3pY94ys3Vz9+3U7KkjL3nAcKCDCTVAw9bD8JKJIOkXgWQj
         21/4wgOzI0kQSNzNGZ4RukwK3pZOLT7ppF+JO+fJygkyWKvf6RDyqe3fz996A7YVSXJd
         JoTWw29Dv52EVvaNIHNYGakrgEOeasZTlTNjYNKsRdsueZ1tZCreWsrWUaIjO7CJhPeg
         DapIfatUIM+83zfCtvUpEnqELE6uVdbVhPVEwDldkt9AKUd+T0GJheHU7NM6ETjrFNzh
         XekHgxBgNVOgGw+72tw94wj+6zcPB4tTGRsNdC4WUct2AeUwZGsJaIln/0cJGeGgt4Vx
         USHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764320423; x=1764925223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rsQJf/MywXHKgJmR1kRmp27TSDzlggTLXvKMYxx53G8=;
        b=JDo7ZQ7TFhRB8SpF4ma8FdBsUsjHk7lMBkmNYC9b2zdrSjIxCU9PwGe4ZEuWkPNSRn
         NqYpRSYF4o6qfJSywRua+TGkYjCQCJJjfEeVTDchZrOSkcTh1USwOkfoZIqVl8VLH4ni
         tmda15V+we2OQfuzwzd2xcbrbs2a6neK2QhSQuaRwXX7VfCsgZ3zDMWWPiQOFnWphQVF
         TL1zjwFPx7hWKcwMJcCeheb46UMFZZVS5LNDwIilCXn/rndQDVNWIY37U7GUPmBzPiBN
         1zpdQJmXGX0p1v0tzMNkx6J5AAsGuf5Vdp1dw/naSXKwyrWnt3dHbuW8hee52H6+Hkn7
         L17A==
X-Forwarded-Encrypted: i=1; AJvYcCWh1r0C6KZTI9v4ufL2SgE328FStiWmCU0wCipcLy/nVJzMAurGYicEPsOueLvHXCmM2SuHsGB8R5pSz141LMxL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4/0VtaMbuWZbhCLdghHNEah37qmay/PNPie6BjLHXZ32bn7M
	PEyMjFWNjX6WUVuj2q89DUGAYbYFLntqBrMpVe0jHNMt7i3xo0P+S1gNsgUwPF9X+xj1sHQYISz
	aJSafHZD4YU1AORId1GLO+ivrh7qlenx4Z2NTwBE3
X-Gm-Gg: ASbGncu6x/jPeLyr5DzUg4RTXDnBsfQVlPCwAmHmACnQpGcgjzTPFi15jKMnE9XMLmA
	ryh2nvAqWqiDveA8pk0cptBZ2uQbRz8bV18Fsjt5MQ8h1isvHRxM1Cny+M+CSuElOnV9bIBmW7K
	rgPwI8yYucGsG76k09JSaCNJ+Z1FWdVxb02Jmizc+uWI+YmpvjuZjuRZfuh7oidHwpuOYUZVw1O
	infp7izI7WJXKY+RdZjT8dAdGdtSPy8Jo8XFKilEIEWLG7QDqQtITk9K87Mz9Uyr3BtCbfW
X-Google-Smtp-Source: AGHT+IFE/0lasQ+HfhMHJa5wjeANRWkq9KhV29YsTIdiFBQNh3mIuYUWFUZ1lWQIVOyOaZ0gZc1X4xno2IjQMoW+28U=
X-Received: by 2002:a17:902:ce84:b0:294:f745:fe7b with SMTP id
 d9443c01a7336-29bc918b9ebmr4194465ad.6.1764320422669; Fri, 28 Nov 2025
 01:00:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122093934.94971-1-irogers@google.com> <aSdGq2K6TRMyG009@google.com>
 <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com>
 <f85dacc5-5d81-4ee7-acf3-8aa053c42dab@linaro.org> <CAP-5=fW01urmSotcEHauc3xVUPqDRhkBttCvpa=6FuJyRaxiEw@mail.gmail.com>
 <d808f86b-551c-4028-97c0-d468dac71d51@linaro.org>
In-Reply-To: <d808f86b-551c-4028-97c0-d468dac71d51@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Nov 2025 01:00:10 -0800
X-Gm-Features: AWmQ_blJViebD_P61YQf6fJwo_y6cc4AvL2QrvZWtRTcqp5AHjlQAhoiDL07w_Q
Message-ID: <CAP-5=fV7QOe7ThUDCFpqWkqLpuq4j_f1mA=zRE78bmwcyY_nXA@mail.gmail.com>
Subject: Re: [PATCH v1] perf addr2line: Add a libdw implementation
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Tony Jones <tonyj@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 5:48=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 27/11/2025 1:19 pm, Ian Rogers wrote:
> > On Thu, Nov 27, 2025 at 4:16=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >>
> >>
> >> On 27/11/2025 11:43 am, Ian Rogers wrote:
> >>> On Wed, Nov 26, 2025 at 10:27=E2=80=AFAM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> >>>>
> >>>> On Sat, Nov 22, 2025 at 01:39:34AM -0800, Ian Rogers wrote:
> >>>>> Add an implementation of addr2line that uses libdw. Other addr2line
> >>>>> implementations or, in the case of forking addr2line, slow. Add an
> >>>>> implementation that caches the libdw information in the dso and use=
s
> >>>>> it to find the file and line number information.
> >>>
> >>> Thanks James and Namhyung for the reviews! I agree with James' commen=
t
> >>> about a typo in the commit message.
> >>>
> >>>> My concern is the limit in the open file descriptors in case the dat=
a
> >>>> touched a lot of different libraries.  The DSO code has some logic t=
o
> >>>> deal with it but I'm not sure if we can share that since libdw seems=
 to
> >>>> want to own the FD.
> >>>
> >>> The code opens the FD:
> >>>
> >>> +               fd =3D open(dso_name, O_RDONLY);
> >>> +               if (fd < 0)
> >>> +                       return 0;
> >>> +
> >>> +               dwfl =3D dwfl_begin(&offline_callbacks);
> >>> +               if (!dwfl) {
> >>> +                       close(fd);
> >>> +                       return 0;
> >>> +               }
> >>>
> >>> It then uses the FD and closes it (the close is hidden in libdw itsel=
f):
> >>>
> >>> +               /*
> >>> +                * If the report is successful, the file descriptor f=
d
> >>> is consumed
> >>> +                * and closed by the Dwfl. If not, it is not closed.
> >>> +                */
> >>> +               mod =3D dwfl_report_offline(dwfl, dso_name, dso_name,=
 fd);
> >>>
> >>> So it is possible we exhaust all the file descriptors if there are
> >>> multiple concurrent calls to libdw__addr2line and every dso has
> >>> missing libdw dwfl data... but because the open/close are close
> >>> together and that 1 FD is say small to the FDs needed for the
> >>> cmd__addr2line, I don't think it is a problem we need to specifically
> >>> handle. Were the FD kept open until the dso was deleted, I'd agree
> >>> with you.
> >>>
> >>>> Also, have you checked if this generates the exactly same output wit=
h
> >>>> other implementations?
> >>>
> >>> So the code passes `perf test` and I was checking functionality with
> >>> perf annotate, top, etc. What I saw looked good, but it may not have
> >>> been exhaustive. I didn't specifically create a test that compares th=
e
> >>> output of the different addr2line implementations. Such a test would
> >>> be possible, it's not something we've done elsewhere.
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>
> >> I manually looked at a couple of line numbers and they looked
> >> reasonable. I think an automated test that compared dwarf decoders wou=
ld
> >> be a bit of a nightmare because I'm sure there would always be subtle
> >> differences.
> >>
> >> Doing a manual side by side comparison of libdw__addr2line() and
> >> llvm__addr2line(), they seem to be quite different:
> >>
> >>     $ perf record -- perf test -w leafloop
> >>     $ perf script -F ip,srcline > libdw_addr2line.txt
> >>     # Comment out libdw_addr2line() and rebuild
> >>     $ perf script -F ip,srcline > llvm_addr2line.txt
> >>     $ diff libdw_addr2line.txt llvm_addr2line.txt
> >>
> >> It gets all of the simple leafloop workload lines the same, but lots o=
f
> >> the libc stuff is different.
> >>
> >> For example libdw gives cpu-features.c:350 where llvm gives strcmp.S. =
At
> >> least that one looks like inlining so llvm might be "better", but wher=
e
> >> it gives dl-cache.c:490 isntead of llvm's mmap64.c:47, it's hard to se=
e
> >> how that can be inlining if they're in different compilation units.
> >>
> >> If the llvm addr2line implementation is also supposed to be slow, it
> >> just means we're trading speed with accuracy with this change. Hard to
> >> say what the default should be in that case.
> >
> > Agreed. We could do some kind of option scheme like with the disassembl=
ers:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/disasm.c?h=3Dperf-tools-next#n1715
> >
> > I'm not sure there are currently any distributions using the LLVM
> > options, this in part motivates:
> > https://lore.kernel.org/lkml/20251007163835.3152881-1-irogers@google.co=
m/
> > but the addr2line APIs are a pain there - see the extra generated .so.
> > Because of that it could be reasonable to delete the LLVM addr2line
> > code and just focus on libdw. I kind of wish we could also delete the
> > precarious command forking versions too. And libbfd... Perhaps with
> > this code, those advocating libbfd have a fast enough alternative
> > without bringing in large dependencies like libLLVM.
> >
> > Thanks,
> > Ian
> >
>
> Personally for debugging I would want the most accurate and detailed
> information possible and don't care at all about the size of
> dependencies. If Perf is a tool for debugging then surely that should be
> the default? But right now I don't actually know which of the outputs is
> most accurate although I'll assume that the llvm one is.

I know LLVM got dwarf 5 support early. I'm not sure if accurate is the
best word to compare libdw and LLVM as, if libdw supports the format,
discrepancies are bugs in LLVM or libdw, .. Building around LLVM as a
common base sgtm and my main use-case doesn't get impeded by the large
dependency because of the dlopen patches. As libelf/libdw is pretty
much a given for a perf build, as it is required for libbpf, then the
code here can avoid the fork/exec fallback. I can see the sense in
trying with LLVM first and then falling back to libdw.

> Wanting the smallest application possible while trading away detail and
> accuracy seems like an unusual special case that should be opt in. It
> also seems to relate to this old discussion [1], in that if we're going
> to keep the llvm depencency then it doesn't make sense to re-write
> anything in Perf.

So I think PE support in libdw wouldn't be a priority and so LLVM for
the win there. I think distributions have been slow to pick up the
LLVM dependency, I'm not sure what the issue is there. It would be
nice to start removing some of the alternatives the perf build
supports. The libbfd and libunwind code is only built with specific
opt-ins, and I think the fork/exec addr2line is redundant after this
change. For addr2line that'd bring the 2 implementations down to libdw
and LLVM. As the recent libbfd fixes show [1], inadvertently we can
break these largely untested dependencies by exposing latent bugs in
things like improper initialization.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20251112074311.1440101-1-irogers@google.co=
m/

> [1]:
> https://lore.kernel.org/linux-perf-users/549d3812-a606-4981-83f5-0a99b0ff=
9f6a@linaro.org/
>
> >>>> Thanks,
> >>>> Namhyung
> >>>>
> >>>>>
> >>>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>>> ---
> >>>>>    tools/perf/util/Build     |   1 +
> >>>>>    tools/perf/util/dso.c     |   2 +
> >>>>>    tools/perf/util/dso.h     |  11 +++
> >>>>>    tools/perf/util/libdw.c   | 136 ++++++++++++++++++++++++++++++++=
++++++
> >>>>>    tools/perf/util/libdw.h   |  60 +++++++++++++++++
> >>>>>    tools/perf/util/srcline.c |   5 ++
> >>>>>    6 files changed, 215 insertions(+)
> >>>>>    create mode 100644 tools/perf/util/libdw.c
> >>>>>    create mode 100644 tools/perf/util/libdw.h
> >>>>>
> >>>>> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> >>>>> index 1c2a43e1dc68..2bed6274e248 100644
> >>>>> --- a/tools/perf/util/Build
> >>>>> +++ b/tools/perf/util/Build
> >>>>> @@ -224,6 +224,7 @@ perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-power=
pc.o
> >>>>>    perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-x86.o
> >>>>>    perf-util-$(CONFIG_LIBDW) +=3D debuginfo.o
> >>>>>    perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
> >>>>> +perf-util-$(CONFIG_LIBDW) +=3D libdw.o
> >>>>>
> >>>>>    perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >>>>>    perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind-loc=
al.o
> >>>>> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> >>>>> index 344e689567ee..06980844c014 100644
> >>>>> --- a/tools/perf/util/dso.c
> >>>>> +++ b/tools/perf/util/dso.c
> >>>>> @@ -32,6 +32,7 @@
> >>>>>    #include "string2.h"
> >>>>>    #include "vdso.h"
> >>>>>    #include "annotate-data.h"
> >>>>> +#include "libdw.h"
> >>>>>
> >>>>>    static const char * const debuglink_paths[] =3D {
> >>>>>         "%.0s%s",
> >>>>> @@ -1605,6 +1606,7 @@ void dso__delete(struct dso *dso)
> >>>>>         auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
> >>>>>         dso_cache__free(dso);
> >>>>>         dso__free_a2l(dso);
> >>>>> +     dso__free_a2l_libdw(dso);
> >>>>>         dso__free_symsrc_filename(dso);
> >>>>>         nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
> >>>>>         mutex_destroy(dso__lock(dso));
> >>>>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> >>>>> index f8ccb9816b89..4aee23775054 100644
> >>>>> --- a/tools/perf/util/dso.h
> >>>>> +++ b/tools/perf/util/dso.h
> >>>>> @@ -268,6 +268,7 @@ DECLARE_RC_STRUCT(dso) {
> >>>>>         const char       *short_name;
> >>>>>         const char       *long_name;
> >>>>>         void             *a2l;
> >>>>> +     void             *a2l_libdw;
> >>>>>         char             *symsrc_filename;
> >>>>>    #if defined(__powerpc__)
> >>>>>         void            *dwfl;                  /* DWARF debug info=
 */
> >>>>> @@ -334,6 +335,16 @@ static inline void dso__set_a2l(struct dso *ds=
o, void *val)
> >>>>>         RC_CHK_ACCESS(dso)->a2l =3D val;
> >>>>>    }
> >>>>>
> >>>>> +static inline void *dso__a2l_libdw(const struct dso *dso)
> >>>>> +{
> >>>>> +     return RC_CHK_ACCESS(dso)->a2l_libdw;
> >>>>> +}
> >>>>> +
> >>>>> +static inline void dso__set_a2l_libdw(struct dso *dso, void *val)
> >>>>> +{
> >>>>> +     RC_CHK_ACCESS(dso)->a2l_libdw =3D val;
> >>>>> +}
> >>>>> +
> >>>>>    static inline unsigned int dso__a2l_fails(const struct dso *dso)
> >>>>>    {
> >>>>>         return RC_CHK_ACCESS(dso)->a2l_fails;
> >>>>> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> >>>>> new file mode 100644
> >>>>> index 000000000000..c4331fa8e1a3
> >>>>> --- /dev/null
> >>>>> +++ b/tools/perf/util/libdw.c
> >>>>> @@ -0,0 +1,136 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>> +#include "dso.h"
> >>>>> +#include "libdw.h"
> >>>>> +#include "srcline.h"
> >>>>> +#include "symbol.h"
> >>>>> +#include "dwarf-aux.h"
> >>>>> +#include <fcntl.h>
> >>>>> +#include <unistd.h>
> >>>>> +#include <elfutils/libdwfl.h>
> >>>>> +
> >>>>> +void dso__free_a2l_libdw(struct dso *dso)
> >>>>> +{
> >>>>> +     Dwfl *dwfl =3D dso__a2l_libdw(dso);
> >>>>> +
> >>>>> +     if (dwfl) {
> >>>>> +             dwfl_end(dwfl);
> >>>>> +             dso__set_a2l_libdw(dso, NULL);
> >>>>> +     }
> >>>>> +}
> >>>>> +
> >>>>> +int libdw__addr2line(const char *dso_name, u64 addr,
> >>>>> +                  char **file, unsigned int *line_nr,
> >>>>> +                  struct dso *dso, bool unwind_inlines,
> >>>>> +                  struct inline_node *node, struct symbol *sym)
> >>>>> +{
> >>>>> +     static const Dwfl_Callbacks offline_callbacks =3D {
> >>>>> +             .find_debuginfo =3D dwfl_standard_find_debuginfo,
> >>>>> +             .section_address =3D dwfl_offline_section_address,
> >>>>> +             .find_elf =3D dwfl_build_id_find_elf,
> >>>>> +     };
> >>>>> +     Dwfl *dwfl =3D dso__a2l_libdw(dso);
> >>>>> +     Dwfl_Module *mod;
> >>>>> +     Dwfl_Line *dwline;
> >>>>> +     Dwarf_Addr bias;
> >>>>> +     const char *src;
> >>>>> +     int lineno;
> >>>>> +
> >>>>> +     if (!dwfl) {
> >>>>> +             /*
> >>>>> +              * Initialize Dwfl session.
> >>>>> +              * We need to open the DSO file to report it to libdw=
.
> >>>>> +              */
> >>>>> +             int fd;
> >>>>> +
> >>>>> +             fd =3D open(dso_name, O_RDONLY);
> >>>>> +             if (fd < 0)
> >>>>> +                     return 0;
> >>>>> +
> >>>>> +             dwfl =3D dwfl_begin(&offline_callbacks);
> >>>>> +             if (!dwfl) {
> >>>>> +                     close(fd);
> >>>>> +                     return 0;
> >>>>> +             }
> >>>>> +
> >>>>> +             /*
> >>>>> +              * If the report is successful, the file descriptor f=
d is consumed
> >>>>> +              * and closed by the Dwfl. If not, it is not closed.
> >>>>> +              */
> >>>>> +             mod =3D dwfl_report_offline(dwfl, dso_name, dso_name,=
 fd);
> >>>>> +             if (!mod) {
> >>>>> +                     dwfl_end(dwfl);
> >>>>> +                     close(fd);
> >>>>> +                     return 0;
> >>>>> +             }
> >>>>> +
> >>>>> +             dwfl_report_end(dwfl, /*removed=3D*/NULL, /*arg=3D*/N=
ULL);
> >>>>> +             dso__set_a2l_libdw(dso, dwfl);
> >>>>> +     } else {
> >>>>> +             /* Dwfl session already initialized, get module for a=
ddress. */
> >>>>> +             mod =3D dwfl_addrmodule(dwfl, addr);
> >>>>> +     }
> >>>>> +
> >>>>> +     if (!mod)
> >>>>> +             return 0;
> >>>>> +
> >>>>> +     /* Find source line information for the address. */
> >>>>> +     dwline =3D dwfl_module_getsrc(mod, addr);
> >>>>> +     if (!dwline)
> >>>>> +             return 0;
> >>>>> +
> >>>>> +     /* Get line information. */
> >>>>> +     src =3D dwfl_lineinfo(dwline, &addr, &lineno, /*col=3D*/NULL,=
 /*mtime=3D*/NULL, /*length=3D*/NULL);
> >>>>> +
> >>>>> +     if (file)
> >>>>> +             *file =3D src ? strdup(src) : NULL;
> >>>>> +     if (line_nr)
> >>>>> +             *line_nr =3D lineno;
> >>>>> +
> >>>>> +     /* Optionally unwind inline function call chain. */
> >>>>> +     if (unwind_inlines && node && src) {
> >>>>> +             Dwarf_Die *cudie =3D dwfl_module_addrdie(mod, addr, &=
bias);
> >>>>> +             Dwarf_Die *scopes =3D NULL;
> >>>>> +             int nscopes;
> >>>>> +
> >>>>> +             if (!cudie)
> >>>>> +                     return 1;
> >>>>> +
> >>>>> +             nscopes =3D die_get_scopes(cudie, addr, &scopes);
> >>>>> +             if (nscopes > 0) {
> >>>>> +                     int i;
> >>>>> +                     const char *call_file =3D src;
> >>>>> +                     unsigned int call_line =3D lineno;
> >>>>> +
> >>>>> +                     for (i =3D 0; i < nscopes; i++) {
> >>>>> +                             Dwarf_Die *die =3D &scopes[i];
> >>>>> +                             struct symbol *inline_sym;
> >>>>> +                             char *srcline =3D NULL;
> >>>>> +                             int tag =3D dwarf_tag(die);
> >>>>> +
> >>>>> +                             /* We are interested in inlined subro=
utines. */
> >>>>> +                             if (tag !=3D DW_TAG_inlined_subroutin=
e &&
> >>>>> +                                 tag !=3D DW_TAG_subprogram)
> >>>>> +                                     continue;
> >>>>> +
> >>>>> +                             inline_sym =3D new_inline_sym(dso, sy=
m, dwarf_diename(die));
> >>>>> +
> >>>>> +                             if (call_file)
> >>>>> +                                     srcline =3D srcline_from_file=
line(call_file, call_line);
> >>>>> +
> >>>>> +                             inline_list__append(inline_sym, srcli=
ne, node);
> >>>>> +
> >>>>> +                             /* Update call site for next level. *=
/
> >>>>> +                             if (tag =3D=3D DW_TAG_inlined_subrout=
ine) {
> >>>>> +                                     call_file =3D die_get_call_fi=
le(die);
> >>>>> +                                     call_line =3D die_get_call_li=
neno(die);
> >>>>> +                             } else {
> >>>>> +                                     /* Reached the root subprogra=
m. */
> >>>>> +                                     break;
> >>>>> +                             }
> >>>>> +                     }
> >>>>> +                     free(scopes);
> >>>>> +             }
> >>>>> +     }
> >>>>> +
> >>>>> +     return 1;
> >>>>> +}
> >>>>> diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
> >>>>> new file mode 100644
> >>>>> index 000000000000..0f8d7b4a11a5
> >>>>> --- /dev/null
> >>>>> +++ b/tools/perf/util/libdw.h
> >>>>> @@ -0,0 +1,60 @@
> >>>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>>> +#ifndef PERF_LIBDW_H
> >>>>> +#define PERF_LIBDW_H
> >>>>> +
> >>>>> +#include <linux/types.h>
> >>>>> +
> >>>>> +struct dso;
> >>>>> +struct inline_node;
> >>>>> +struct symbol;
> >>>>> +
> >>>>> +#ifdef HAVE_LIBDW_SUPPORT
> >>>>> +/*
> >>>>> + * libdw__addr2line - Convert address to source location using lib=
dw
> >>>>> + * @dso_name: Name of the DSO
> >>>>> + * @addr: Address to resolve
> >>>>> + * @file: Pointer to return filename (caller must free)
> >>>>> + * @line_nr: Pointer to return line number
> >>>>> + * @dso: The dso struct
> >>>>> + * @unwind_inlines: Whether to unwind inline function calls
> >>>>> + * @node: Inline node list to append to
> >>>>> + * @sym: The symbol associated with the address
> >>>>> + *
> >>>>> + * This function initializes a Dwfl context for the DSO if not alr=
eady present,
> >>>>> + * finds the source line information for the given address, and op=
tionally
> >>>>> + * resolves inline function call chains.
> >>>>> + *
> >>>>> + * Returns 1 on success (found), 0 on failure (not found).
> >>>>> + */
> >>>>> +int libdw__addr2line(const char *dso_name, u64 addr, char **file,
> >>>>> +                  unsigned int *line_nr, struct dso *dso,
> >>>>> +                  bool unwind_inlines, struct inline_node *node,
> >>>>> +                  struct symbol *sym);
> >>>>> +
> >>>>> +/*
> >>>>> + * dso__free_a2l_libdw - Free libdw resources associated with the =
DSO
> >>>>> + * @dso: The dso to free resources for
> >>>>> + *
> >>>>> + * This function cleans up the Dwfl context used for addr2line loo=
kups.
> >>>>> + */
> >>>>> +void dso__free_a2l_libdw(struct dso *dso);
> >>>>> +
> >>>>> +#else /* HAVE_LIBDW_SUPPORT */
> >>>>> +
> >>>>> +static inline int libdw__addr2line(const char *dso_name __maybe_un=
used,
> >>>>> +                                u64 addr __maybe_unused, char **fi=
le __maybe_unused,
> >>>>> +                                unsigned int *line_nr __maybe_unus=
ed,
> >>>>> +                                struct dso *dso __maybe_unused,
> >>>>> +                                bool unwind_inlines __maybe_unused=
,
> >>>>> +                                struct inline_node *node __maybe_u=
nused,
> >>>>> +                                struct symbol *sym __maybe_unused)
> >>>>> +{
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static inline void dso__free_a2l_libdw(struct dso *dso __maybe_unu=
sed)
> >>>>> +{
> >>>>> +}
> >>>>> +#endif /* HAVE_LIBDW_SUPPORT */
> >>>>> +
> >>>>> +#endif /* PERF_LIBDW_H */
> >>>>> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> >>>>> index 27c0966611ab..4b456c4d4138 100644
> >>>>> --- a/tools/perf/util/srcline.c
> >>>>> +++ b/tools/perf/util/srcline.c
> >>>>> @@ -6,6 +6,7 @@
> >>>>>    #include "libbfd.h"
> >>>>>    #include "llvm.h"
> >>>>>    #include "symbol.h"
> >>>>> +#include "libdw.h"
> >>>>>
> >>>>>    #include <inttypes.h>
> >>>>>    #include <string.h>
> >>>>> @@ -120,6 +121,10 @@ static int addr2line(const char *dso_name, u64=
 addr, char **file, unsigned int *
> >>>>>    {
> >>>>>         int ret;
> >>>>>
> >>>>> +     ret =3D libdw__addr2line(dso_name, addr, file, line_nr, dso, =
unwind_inlines, node, sym);
> >>>>> +     if (ret > 0)
> >>>>> +             return ret;
> >>>>> +
> >>>>>         ret =3D llvm__addr2line(dso_name, addr, file, line_nr, dso,=
 unwind_inlines, node, sym);
> >>>>>         if (ret > 0)
> >>>>>                 return ret;
> >>>>> --
> >>>>> 2.52.0.rc2.455.g230fcf2819-goog
> >>>>>
> >>
>
