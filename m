Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ABD13A244
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Nov 2025 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249609; cv=none; b=uzQtFPYnZmq7FIv8xAiWdJKjLy6QQt/wDTn3HiPNk8hCbaPY5zxrbqrMi8I9OoClEKz7XftoIvF32kX3GL1sGHD4rDChmflTGXqFZl+T8r2avIg6cVewV2IsKZ8D8dHStaYYhvF7Ck505RWl3rIYzE5ID5JwhKvQUnev8PjCKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249609; c=relaxed/simple;
	bh=/CqEb+GCJRanoxokJ/OVBwDbu6fx5Qgrti/cxjbToOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLzkcEiHVFKwj+A2QHGW4pMyBVUxPJyYhgOVwLHtjlyx3ZjTc+t9Cw/N0dU4M1Y3MBKsrqG1TF1INisA+qXcrSCrMc6K2XsrieLVXFYYxUakY6oXu9+wuccotbWoWETA5gZIOo3Zr/volfNskYFQqL/R9RQ6k/jcl35T7r7lTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EwlJaKdz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwlJaKdz"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2980343d9d1so151335ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Nov 2025 05:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764249606; x=1764854406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExJ9D7+UKmPuR11rnt9gTKR6bzSMewWtAWZaxaX6g00=;
        b=EwlJaKdzvNrIqHpP8Yv6Vi313P2INJBCCdY1YSI3k6WndWvwOrZBErOoC42dKSsn8I
         tTwPRhmYs11i9FC1bMkYsDmyFMAbQVihPcaZmC24oPxKnJnz2CQqpRl+Qvz+2mwqS2Lg
         EcXHeRkCbSafZl8Tc/6pstWNR3tRkrZEYuIaGBZ0TJNgMZn42ediCstXAuksMnhcBclD
         SjmhPfQa6jAFrzBDSAFoJK2kiPbxQFw56dloids9/IfSGZeTmq6Hv1HA0ozIXgrV2ftA
         H93/r+VM7u1eGlSD11I9s6aEEJ1JxXRsKt71XpjzCeSvuQgrAAD5I7ZgQXa3rstm2l+d
         f3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764249606; x=1764854406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ExJ9D7+UKmPuR11rnt9gTKR6bzSMewWtAWZaxaX6g00=;
        b=g99bcGUa15GkLJn01iOy5hiPLcGBVaW3Zwpp/xAP85bI0hwAmhA+1Ez2v6bJgIij8m
         T5ttDsxvr4LvnYtOETWOm0XRMVyBBOfz38X4EgZcpl8k1G4hVoZeK3hcahlyFnXR2NTc
         fqdqUR28GABLd6EYs8j0UpX4BGo4fyOa8gQUuvlEZKKsb/HcOCHB//Al5PYNAxbKhJtU
         UFdNZ0h3AiTcic27aUvPkdvCf1HmoakqJOQgvD2/i2rBBJXh95I6O1RdBtWlmh1Tx4aP
         7XX9DE6VKcVNGCYntx6FNYty+fzfTrWGNknXEwP/EEhaskRkNdFP22+16paIr/iA7XM0
         F8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXlecSIKO/7hiO+J/79JJOGkIoq87kdul6NW6bBA8zDE9iasCTBTFIrhnKmW0dhl2M/+D/CKlgodnBVGGZQETcx@vger.kernel.org
X-Gm-Message-State: AOJu0YxCixOilS317AbqCQP1U2/4ey42oW6JzE8XGT16U28DGro5PGtl
	iMlp0Y6nHy+HZwH9R5Rcbv2kn5zRsMQg3rv7ND55C8tkGS6hyn8aRpL/FCkc//gqZcjMOyVCPqo
	1GOWZyR206Wqz1Al5alQjRHFDsZf/c3qYUkWcGXlT
X-Gm-Gg: ASbGncvv4AxYTPgw24lj0r38Vcp8MgV+E29jQGqOFoewwfkaSvMfIckonDMGbx4F9v0
	pTDJcOnFWGRCwkVIWEGT1TX3a2sshh50+ktrDLDG0IVUQJsFUkMsgQ962UDe9d7TiBP1zut6GJC
	dkqN85mEtVtmcjlVjbSP1tC8q9iLOJRiYQKGxRQ1pQZ1CmDbVAn7r+BOzNvhorhPvj6AlS2dzfb
	pjnReKI9bwk03Q098Yxi0EYVtp3O2Dms2YTAGrwDhumADLSDtX2tcOZvjRb4G72eukSD/q9
X-Google-Smtp-Source: AGHT+IHh59NCNPv3Yr9NmHC6bd/e6K3haKYc7p64LvMRsE2bwAsA/eAj8zzRT/7MacNUPhLLtJr7pdGsJrwOhyfDSeU=
X-Received: by 2002:a17:903:41c5:b0:292:b6a0:80df with SMTP id
 d9443c01a7336-29bc92920bamr2283255ad.10.1764249606055; Thu, 27 Nov 2025
 05:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122093934.94971-1-irogers@google.com> <aSdGq2K6TRMyG009@google.com>
 <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com> <f85dacc5-5d81-4ee7-acf3-8aa053c42dab@linaro.org>
In-Reply-To: <f85dacc5-5d81-4ee7-acf3-8aa053c42dab@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Nov 2025 05:19:53 -0800
X-Gm-Features: AWmQ_bkqStlw2x9a51sf5WBJmvEPkxlEIn_y4-yy4qnNnARVAlD0Mbhy8bC9uwE
Message-ID: <CAP-5=fW01urmSotcEHauc3xVUPqDRhkBttCvpa=6FuJyRaxiEw@mail.gmail.com>
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

On Thu, Nov 27, 2025 at 4:16=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 27/11/2025 11:43 am, Ian Rogers wrote:
> > On Wed, Nov 26, 2025 at 10:27=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> >>
> >> On Sat, Nov 22, 2025 at 01:39:34AM -0800, Ian Rogers wrote:
> >>> Add an implementation of addr2line that uses libdw. Other addr2line
> >>> implementations or, in the case of forking addr2line, slow. Add an
> >>> implementation that caches the libdw information in the dso and uses
> >>> it to find the file and line number information.
> >
> > Thanks James and Namhyung for the reviews! I agree with James' comment
> > about a typo in the commit message.
> >
> >> My concern is the limit in the open file descriptors in case the data
> >> touched a lot of different libraries.  The DSO code has some logic to
> >> deal with it but I'm not sure if we can share that since libdw seems t=
o
> >> want to own the FD.
> >
> > The code opens the FD:
> >
> > +               fd =3D open(dso_name, O_RDONLY);
> > +               if (fd < 0)
> > +                       return 0;
> > +
> > +               dwfl =3D dwfl_begin(&offline_callbacks);
> > +               if (!dwfl) {
> > +                       close(fd);
> > +                       return 0;
> > +               }
> >
> > It then uses the FD and closes it (the close is hidden in libdw itself)=
:
> >
> > +               /*
> > +                * If the report is successful, the file descriptor fd
> > is consumed
> > +                * and closed by the Dwfl. If not, it is not closed.
> > +                */
> > +               mod =3D dwfl_report_offline(dwfl, dso_name, dso_name, f=
d);
> >
> > So it is possible we exhaust all the file descriptors if there are
> > multiple concurrent calls to libdw__addr2line and every dso has
> > missing libdw dwfl data... but because the open/close are close
> > together and that 1 FD is say small to the FDs needed for the
> > cmd__addr2line, I don't think it is a problem we need to specifically
> > handle. Were the FD kept open until the dso was deleted, I'd agree
> > with you.
> >
> >> Also, have you checked if this generates the exactly same output with
> >> other implementations?
> >
> > So the code passes `perf test` and I was checking functionality with
> > perf annotate, top, etc. What I saw looked good, but it may not have
> > been exhaustive. I didn't specifically create a test that compares the
> > output of the different addr2line implementations. Such a test would
> > be possible, it's not something we've done elsewhere.
> >
> > Thanks,
> > Ian
> >
>
> I manually looked at a couple of line numbers and they looked
> reasonable. I think an automated test that compared dwarf decoders would
> be a bit of a nightmare because I'm sure there would always be subtle
> differences.
>
> Doing a manual side by side comparison of libdw__addr2line() and
> llvm__addr2line(), they seem to be quite different:
>
>    $ perf record -- perf test -w leafloop
>    $ perf script -F ip,srcline > libdw_addr2line.txt
>    # Comment out libdw_addr2line() and rebuild
>    $ perf script -F ip,srcline > llvm_addr2line.txt
>    $ diff libdw_addr2line.txt llvm_addr2line.txt
>
> It gets all of the simple leafloop workload lines the same, but lots of
> the libc stuff is different.
>
> For example libdw gives cpu-features.c:350 where llvm gives strcmp.S. At
> least that one looks like inlining so llvm might be "better", but where
> it gives dl-cache.c:490 isntead of llvm's mmap64.c:47, it's hard to see
> how that can be inlining if they're in different compilation units.
>
> If the llvm addr2line implementation is also supposed to be slow, it
> just means we're trading speed with accuracy with this change. Hard to
> say what the default should be in that case.

Agreed. We could do some kind of option scheme like with the disassemblers:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/disasm.c?h=3Dperf-tools-next#n1715

I'm not sure there are currently any distributions using the LLVM
options, this in part motivates:
https://lore.kernel.org/lkml/20251007163835.3152881-1-irogers@google.com/
but the addr2line APIs are a pain there - see the extra generated .so.
Because of that it could be reasonable to delete the LLVM addr2line
code and just focus on libdw. I kind of wish we could also delete the
precarious command forking versions too. And libbfd... Perhaps with
this code, those advocating libbfd have a fast enough alternative
without bringing in large dependencies like libLLVM.

Thanks,
Ian

> >> Thanks,
> >> Namhyung
> >>
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>   tools/perf/util/Build     |   1 +
> >>>   tools/perf/util/dso.c     |   2 +
> >>>   tools/perf/util/dso.h     |  11 +++
> >>>   tools/perf/util/libdw.c   | 136 +++++++++++++++++++++++++++++++++++=
+++
> >>>   tools/perf/util/libdw.h   |  60 +++++++++++++++++
> >>>   tools/perf/util/srcline.c |   5 ++
> >>>   6 files changed, 215 insertions(+)
> >>>   create mode 100644 tools/perf/util/libdw.c
> >>>   create mode 100644 tools/perf/util/libdw.h
> >>>
> >>> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> >>> index 1c2a43e1dc68..2bed6274e248 100644
> >>> --- a/tools/perf/util/Build
> >>> +++ b/tools/perf/util/Build
> >>> @@ -224,6 +224,7 @@ perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-powerpc=
.o
> >>>   perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-x86.o
> >>>   perf-util-$(CONFIG_LIBDW) +=3D debuginfo.o
> >>>   perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
> >>> +perf-util-$(CONFIG_LIBDW) +=3D libdw.o
> >>>
> >>>   perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >>>   perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind-local.=
o
> >>> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> >>> index 344e689567ee..06980844c014 100644
> >>> --- a/tools/perf/util/dso.c
> >>> +++ b/tools/perf/util/dso.c
> >>> @@ -32,6 +32,7 @@
> >>>   #include "string2.h"
> >>>   #include "vdso.h"
> >>>   #include "annotate-data.h"
> >>> +#include "libdw.h"
> >>>
> >>>   static const char * const debuglink_paths[] =3D {
> >>>        "%.0s%s",
> >>> @@ -1605,6 +1606,7 @@ void dso__delete(struct dso *dso)
> >>>        auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
> >>>        dso_cache__free(dso);
> >>>        dso__free_a2l(dso);
> >>> +     dso__free_a2l_libdw(dso);
> >>>        dso__free_symsrc_filename(dso);
> >>>        nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
> >>>        mutex_destroy(dso__lock(dso));
> >>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> >>> index f8ccb9816b89..4aee23775054 100644
> >>> --- a/tools/perf/util/dso.h
> >>> +++ b/tools/perf/util/dso.h
> >>> @@ -268,6 +268,7 @@ DECLARE_RC_STRUCT(dso) {
> >>>        const char       *short_name;
> >>>        const char       *long_name;
> >>>        void             *a2l;
> >>> +     void             *a2l_libdw;
> >>>        char             *symsrc_filename;
> >>>   #if defined(__powerpc__)
> >>>        void            *dwfl;                  /* DWARF debug info */
> >>> @@ -334,6 +335,16 @@ static inline void dso__set_a2l(struct dso *dso,=
 void *val)
> >>>        RC_CHK_ACCESS(dso)->a2l =3D val;
> >>>   }
> >>>
> >>> +static inline void *dso__a2l_libdw(const struct dso *dso)
> >>> +{
> >>> +     return RC_CHK_ACCESS(dso)->a2l_libdw;
> >>> +}
> >>> +
> >>> +static inline void dso__set_a2l_libdw(struct dso *dso, void *val)
> >>> +{
> >>> +     RC_CHK_ACCESS(dso)->a2l_libdw =3D val;
> >>> +}
> >>> +
> >>>   static inline unsigned int dso__a2l_fails(const struct dso *dso)
> >>>   {
> >>>        return RC_CHK_ACCESS(dso)->a2l_fails;
> >>> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> >>> new file mode 100644
> >>> index 000000000000..c4331fa8e1a3
> >>> --- /dev/null
> >>> +++ b/tools/perf/util/libdw.c
> >>> @@ -0,0 +1,136 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +#include "dso.h"
> >>> +#include "libdw.h"
> >>> +#include "srcline.h"
> >>> +#include "symbol.h"
> >>> +#include "dwarf-aux.h"
> >>> +#include <fcntl.h>
> >>> +#include <unistd.h>
> >>> +#include <elfutils/libdwfl.h>
> >>> +
> >>> +void dso__free_a2l_libdw(struct dso *dso)
> >>> +{
> >>> +     Dwfl *dwfl =3D dso__a2l_libdw(dso);
> >>> +
> >>> +     if (dwfl) {
> >>> +             dwfl_end(dwfl);
> >>> +             dso__set_a2l_libdw(dso, NULL);
> >>> +     }
> >>> +}
> >>> +
> >>> +int libdw__addr2line(const char *dso_name, u64 addr,
> >>> +                  char **file, unsigned int *line_nr,
> >>> +                  struct dso *dso, bool unwind_inlines,
> >>> +                  struct inline_node *node, struct symbol *sym)
> >>> +{
> >>> +     static const Dwfl_Callbacks offline_callbacks =3D {
> >>> +             .find_debuginfo =3D dwfl_standard_find_debuginfo,
> >>> +             .section_address =3D dwfl_offline_section_address,
> >>> +             .find_elf =3D dwfl_build_id_find_elf,
> >>> +     };
> >>> +     Dwfl *dwfl =3D dso__a2l_libdw(dso);
> >>> +     Dwfl_Module *mod;
> >>> +     Dwfl_Line *dwline;
> >>> +     Dwarf_Addr bias;
> >>> +     const char *src;
> >>> +     int lineno;
> >>> +
> >>> +     if (!dwfl) {
> >>> +             /*
> >>> +              * Initialize Dwfl session.
> >>> +              * We need to open the DSO file to report it to libdw.
> >>> +              */
> >>> +             int fd;
> >>> +
> >>> +             fd =3D open(dso_name, O_RDONLY);
> >>> +             if (fd < 0)
> >>> +                     return 0;
> >>> +
> >>> +             dwfl =3D dwfl_begin(&offline_callbacks);
> >>> +             if (!dwfl) {
> >>> +                     close(fd);
> >>> +                     return 0;
> >>> +             }
> >>> +
> >>> +             /*
> >>> +              * If the report is successful, the file descriptor fd =
is consumed
> >>> +              * and closed by the Dwfl. If not, it is not closed.
> >>> +              */
> >>> +             mod =3D dwfl_report_offline(dwfl, dso_name, dso_name, f=
d);
> >>> +             if (!mod) {
> >>> +                     dwfl_end(dwfl);
> >>> +                     close(fd);
> >>> +                     return 0;
> >>> +             }
> >>> +
> >>> +             dwfl_report_end(dwfl, /*removed=3D*/NULL, /*arg=3D*/NUL=
L);
> >>> +             dso__set_a2l_libdw(dso, dwfl);
> >>> +     } else {
> >>> +             /* Dwfl session already initialized, get module for add=
ress. */
> >>> +             mod =3D dwfl_addrmodule(dwfl, addr);
> >>> +     }
> >>> +
> >>> +     if (!mod)
> >>> +             return 0;
> >>> +
> >>> +     /* Find source line information for the address. */
> >>> +     dwline =3D dwfl_module_getsrc(mod, addr);
> >>> +     if (!dwline)
> >>> +             return 0;
> >>> +
> >>> +     /* Get line information. */
> >>> +     src =3D dwfl_lineinfo(dwline, &addr, &lineno, /*col=3D*/NULL, /=
*mtime=3D*/NULL, /*length=3D*/NULL);
> >>> +
> >>> +     if (file)
> >>> +             *file =3D src ? strdup(src) : NULL;
> >>> +     if (line_nr)
> >>> +             *line_nr =3D lineno;
> >>> +
> >>> +     /* Optionally unwind inline function call chain. */
> >>> +     if (unwind_inlines && node && src) {
> >>> +             Dwarf_Die *cudie =3D dwfl_module_addrdie(mod, addr, &bi=
as);
> >>> +             Dwarf_Die *scopes =3D NULL;
> >>> +             int nscopes;
> >>> +
> >>> +             if (!cudie)
> >>> +                     return 1;
> >>> +
> >>> +             nscopes =3D die_get_scopes(cudie, addr, &scopes);
> >>> +             if (nscopes > 0) {
> >>> +                     int i;
> >>> +                     const char *call_file =3D src;
> >>> +                     unsigned int call_line =3D lineno;
> >>> +
> >>> +                     for (i =3D 0; i < nscopes; i++) {
> >>> +                             Dwarf_Die *die =3D &scopes[i];
> >>> +                             struct symbol *inline_sym;
> >>> +                             char *srcline =3D NULL;
> >>> +                             int tag =3D dwarf_tag(die);
> >>> +
> >>> +                             /* We are interested in inlined subrout=
ines. */
> >>> +                             if (tag !=3D DW_TAG_inlined_subroutine =
&&
> >>> +                                 tag !=3D DW_TAG_subprogram)
> >>> +                                     continue;
> >>> +
> >>> +                             inline_sym =3D new_inline_sym(dso, sym,=
 dwarf_diename(die));
> >>> +
> >>> +                             if (call_file)
> >>> +                                     srcline =3D srcline_from_fileli=
ne(call_file, call_line);
> >>> +
> >>> +                             inline_list__append(inline_sym, srcline=
, node);
> >>> +
> >>> +                             /* Update call site for next level. */
> >>> +                             if (tag =3D=3D DW_TAG_inlined_subroutin=
e) {
> >>> +                                     call_file =3D die_get_call_file=
(die);
> >>> +                                     call_line =3D die_get_call_line=
no(die);
> >>> +                             } else {
> >>> +                                     /* Reached the root subprogram.=
 */
> >>> +                                     break;
> >>> +                             }
> >>> +                     }
> >>> +                     free(scopes);
> >>> +             }
> >>> +     }
> >>> +
> >>> +     return 1;
> >>> +}
> >>> diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
> >>> new file mode 100644
> >>> index 000000000000..0f8d7b4a11a5
> >>> --- /dev/null
> >>> +++ b/tools/perf/util/libdw.h
> >>> @@ -0,0 +1,60 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +#ifndef PERF_LIBDW_H
> >>> +#define PERF_LIBDW_H
> >>> +
> >>> +#include <linux/types.h>
> >>> +
> >>> +struct dso;
> >>> +struct inline_node;
> >>> +struct symbol;
> >>> +
> >>> +#ifdef HAVE_LIBDW_SUPPORT
> >>> +/*
> >>> + * libdw__addr2line - Convert address to source location using libdw
> >>> + * @dso_name: Name of the DSO
> >>> + * @addr: Address to resolve
> >>> + * @file: Pointer to return filename (caller must free)
> >>> + * @line_nr: Pointer to return line number
> >>> + * @dso: The dso struct
> >>> + * @unwind_inlines: Whether to unwind inline function calls
> >>> + * @node: Inline node list to append to
> >>> + * @sym: The symbol associated with the address
> >>> + *
> >>> + * This function initializes a Dwfl context for the DSO if not alrea=
dy present,
> >>> + * finds the source line information for the given address, and opti=
onally
> >>> + * resolves inline function call chains.
> >>> + *
> >>> + * Returns 1 on success (found), 0 on failure (not found).
> >>> + */
> >>> +int libdw__addr2line(const char *dso_name, u64 addr, char **file,
> >>> +                  unsigned int *line_nr, struct dso *dso,
> >>> +                  bool unwind_inlines, struct inline_node *node,
> >>> +                  struct symbol *sym);
> >>> +
> >>> +/*
> >>> + * dso__free_a2l_libdw - Free libdw resources associated with the DS=
O
> >>> + * @dso: The dso to free resources for
> >>> + *
> >>> + * This function cleans up the Dwfl context used for addr2line looku=
ps.
> >>> + */
> >>> +void dso__free_a2l_libdw(struct dso *dso);
> >>> +
> >>> +#else /* HAVE_LIBDW_SUPPORT */
> >>> +
> >>> +static inline int libdw__addr2line(const char *dso_name __maybe_unus=
ed,
> >>> +                                u64 addr __maybe_unused, char **file=
 __maybe_unused,
> >>> +                                unsigned int *line_nr __maybe_unused=
,
> >>> +                                struct dso *dso __maybe_unused,
> >>> +                                bool unwind_inlines __maybe_unused,
> >>> +                                struct inline_node *node __maybe_unu=
sed,
> >>> +                                struct symbol *sym __maybe_unused)
> >>> +{
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static inline void dso__free_a2l_libdw(struct dso *dso __maybe_unuse=
d)
> >>> +{
> >>> +}
> >>> +#endif /* HAVE_LIBDW_SUPPORT */
> >>> +
> >>> +#endif /* PERF_LIBDW_H */
> >>> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> >>> index 27c0966611ab..4b456c4d4138 100644
> >>> --- a/tools/perf/util/srcline.c
> >>> +++ b/tools/perf/util/srcline.c
> >>> @@ -6,6 +6,7 @@
> >>>   #include "libbfd.h"
> >>>   #include "llvm.h"
> >>>   #include "symbol.h"
> >>> +#include "libdw.h"
> >>>
> >>>   #include <inttypes.h>
> >>>   #include <string.h>
> >>> @@ -120,6 +121,10 @@ static int addr2line(const char *dso_name, u64 a=
ddr, char **file, unsigned int *
> >>>   {
> >>>        int ret;
> >>>
> >>> +     ret =3D libdw__addr2line(dso_name, addr, file, line_nr, dso, un=
wind_inlines, node, sym);
> >>> +     if (ret > 0)
> >>> +             return ret;
> >>> +
> >>>        ret =3D llvm__addr2line(dso_name, addr, file, line_nr, dso, un=
wind_inlines, node, sym);
> >>>        if (ret > 0)
> >>>                return ret;
> >>> --
> >>> 2.52.0.rc2.455.g230fcf2819-goog
> >>>
>
