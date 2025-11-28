Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B22D2EB868
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Nov 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319351; cv=none; b=scUXGF5St8yTRmUUzZ3SycN+z4+DORsYfZYQgIbWUSFCspbUV4PdfPEr23WP21Ltn59dkc74ngpYvorDeD2dkihQzF36mcyW8uR21Y01DEw9MYK8c/vLDVULyxbHw555gr8xnmPX6mj+Qqcn4Boue//A7JstVg4tAmo6pWTUAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319351; c=relaxed/simple;
	bh=i6Ap3KxyQE4KYK+el90G3XIJ2xbIwJPbWlbejbQf4S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGsxVNNoSuPcArFyZgMwjVlbKe8DRzeRAGdxb7ZbHdF4g0tvyU/xyoMVxyU6LYDG/YgaG198BYxHW2RrPOd7KKI1ris8mvmNaZRJST6ppKrf8FJZZAQsGhFvwulK00STC41MPUhOjucDXHE30eSJlBM6522ERB4k4poLgdZPppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2aqBM5GP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2aqBM5GP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297e13bf404so308835ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Nov 2025 00:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764319348; x=1764924148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvtjON200uqsSKc4pOJoWwvVag89AFopn1e89zA/nHE=;
        b=2aqBM5GPRzdB73/SJrhEB4NDUTghMUeNtqMjoMIs7O8mMdmNSoiZk+dPaKEEUAjYRV
         jBXdYBCp6Xbbfh5mP4qtZqFNef5+HqSY4sbA9H+7PJ5Db2YLOTccMjBBeKX9lwUrXrbf
         D3/13tKde70qj60VKd8yOVGvH5fYHvXhjrg7UU9IZP5dsk/2usCObgBO1lqXJeJ0S8Mt
         PufHEc9/OZhskogQgn3QYy8iIfHlnxi7eJG07FBHOVbNYkbjl6Iis5G7b1bBdMuOEtxj
         fMlqRYCN7meJPrgYpD1qdCsb3lJoPZfoxrZ0wvNu5Z4/QT4x/FvLRk7naP5YcAk5+lyd
         5qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764319348; x=1764924148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hvtjON200uqsSKc4pOJoWwvVag89AFopn1e89zA/nHE=;
        b=R9GOW8Rj6U1YGPHvuLwGS3MQbZKxxsvF1C6mBSduWrcSX8UXf5q4xYNKZ4er/9gW6m
         CHbg6cHRVco5blml/yklkMw6GATIrL9y6JrYRZLE4TlEtS70ze8LlTLNpdmnvH9ALu0V
         +FUogUojrp3bBUlOFD2MC3epHdnQUQQOdClcrwdaGx8oGsJqnGCquM/RRk9hHkEN1x95
         Df9Tl4tbPmS7dQZ5r8d62wVBUyETU2GVtM27QKWIL/UpRJ348lD6I0l3eRVmnXFCgZ1+
         +MGPTf9Kq7EVIT3DstEohatNxtIxuNarMh6PHqJrQFVN1kIAJG7SRgXNjHkFXesYC7TX
         JstA==
X-Forwarded-Encrypted: i=1; AJvYcCVoWSxv7TBGhG1XJxpfj7h8jILNhwoaWS0HqwALM599d7o2SitTFV+gcuNpREdd1DEkuupwCNwZ/CTX/uAlkiwg@vger.kernel.org
X-Gm-Message-State: AOJu0YzOyOcIsJ+4lcisecc+GyBgWx+4FjBOlZE2JbTQX0qC7xATnWPr
	bKBFElzTYlOnh+jKoZ7rXqoGfau5qN26lfXNkRLiZmo4LTwmdVPwZVxqYKf8oCLaH14zXyD5ufH
	RTrVKqJgNEM4rtsBlxTf4MimI1X1OWqma7kxK9YAt
X-Gm-Gg: ASbGncuIjriZSl8pjJtm7bXjjgJeui19ZY5t/h8Ffb3f3jZSAqKD3cAdIB/a2BkkLij
	C5OQRRZghSNGD7efr5NDSjkDdQlb7ij53RQBYRjunJeW2w2w28JWufcLvX5TyhH48ZLqXbD8+Rv
	QGiJo/2LkSI632fjZOqXv7pQkQnp5fNghYT/X5zP/33agXAsC6+IdJ9EOqkIk7YvaVUwV0k3S8V
	8y3RyJnRD9sZScis5J0UH8/VzYWLPu0a5fEycsLNzPYLIcEFaermUDQlwx8a8Uc5ClkJErz
X-Google-Smtp-Source: AGHT+IG2vDdt5L4C2UunyxnO87152DuVwFl/WKY1mev6WiEErJs4KhojakhmXpJe1LWuHl+gb70NH+xsU3J3POEb88c=
X-Received: by 2002:a17:902:f14b:b0:299:c367:9e03 with SMTP id
 d9443c01a7336-29bc92e759amr1608515ad.18.1764319348123; Fri, 28 Nov 2025
 00:42:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122093934.94971-1-irogers@google.com> <aSdGq2K6TRMyG009@google.com>
 <CAP-5=fULHMCw=b0PuN07r=aAjoamb+MNSNrHM3nyHPYM2DGkow@mail.gmail.com> <aSi6Wjm2tkuNQEXD@google.com>
In-Reply-To: <aSi6Wjm2tkuNQEXD@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Nov 2025 00:42:15 -0800
X-Gm-Features: AWmQ_bmvPIiBfUX_lzyGKu1dMl6bJ3A91NB4RQoYCk5R0H2XCJ5G5hr9lr6mFts
Message-ID: <CAP-5=fXp4nbnMdgbXogxzQaeo3G-vVWbiTRcFi3PO+vLsB67JA@mail.gmail.com>
Subject: Re: [PATCH v1] perf addr2line: Add a libdw implementation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 12:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Nov 27, 2025 at 03:43:34AM -0800, Ian Rogers wrote:
> > On Wed, Nov 26, 2025 at 10:27=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Sat, Nov 22, 2025 at 01:39:34AM -0800, Ian Rogers wrote:
> > > > Add an implementation of addr2line that uses libdw. Other addr2line
> > > > implementations or, in the case of forking addr2line, slow. Add an
> > > > implementation that caches the libdw information in the dso and use=
s
> > > > it to find the file and line number information.
> >
> > Thanks James and Namhyung for the reviews! I agree with James' comment
> > about a typo in the commit message.
> >
> > > My concern is the limit in the open file descriptors in case the data
> > > touched a lot of different libraries.  The DSO code has some logic to
> > > deal with it but I'm not sure if we can share that since libdw seems =
to
> > > want to own the FD.
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
>
> Oh, I thought libdwfl keeps the FD open until you call dwfl_end().
> Are you sure the dwfl function would close the FD?  I've quickly checked
> the code, but it doesn't seem to close if you pass an FD manually.

So in the documentation there is:
https://sourceware.org/git/?p=3Delfutils.git;a=3Dblob;f=3Dlibdwfl/libdwfl.h=
;h=3D90523283c9359b09a16709a8422917a44257932f;hb=3DHEAD#l155
```
/* ...On success, FD is consumed by the
   library, ... */
extern Dwfl_Module *dwfl_report_elf (Dwfl *dwfl, const char *name,
     const char *file_name, int fd,
     GElf_Addr base, bool add_p_vaddr);

/* Similar, but report the module for offline use. ...  */
extern Dwfl_Module *dwfl_report_offline (Dwfl *dwfl, const char *name,
const char *file_name, int fd);
```

Running with gdb I see:
```
$ perf record perf test -w noploop
Lowering default frequency rate from 4000 to 2500.
Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.611 MB perf.data (2534 samples) ]
$ gdb --args perf --no-pager annotate -l --stdio
...
Reading symbols from /tmp/perf/perf...
(gdb) b libdw__addr2line
Breakpoint 1 at 0x392b98: file util/libdw.c, line 25.
(gdb) r
Starting program: /tmp/perf/perf --no-pager annotate -l --stdio
...
Breakpoint 1, libdw__addr2line (dso_name=3D0x555557b41270
"/root/.debug/.build-id/4c/72a04e484e8636631219f4454cc64a674a5f57/elf",
addr=3D1903613,
    file=3D0x7fffffffa830, line_nr=3D0x7fffffffa82c, dso=3D0x5555569eba20,
unwind_inlines=3Dfalse, node=3D0x0, sym=3D0x0) at util/libdw.c:25
25      {
(gdb) n
31              Dwfl *dwfl =3D dso__a2l_libdw(dso);
(gdb)
38              if (!dwfl) {
(gdb)
45                      fd =3D open(dso_name, O_RDONLY);
(gdb)
46                      if (fd < 0)
(gdb) p fd
$1 =3D 5
(gdb) n
49                      dwfl =3D dwfl_begin(&offline_callbacks);
(gdb) b close
Breakpoint 2 at 0x7fffedf09760: close. (15 locations)
(gdb) c
Continuing.

Breakpoint 2.1, __GI___close (fd=3D5) at ../sysdeps/unix/sysv/linux/close.c=
:27
warning: 27     ../sysdeps/unix/sysv/linux/close.c: No such file or directo=
ry
(gdb) bt
#0  __GI___close (fd=3D5) at ../sysdeps/unix/sysv/linux/close.c:27
#1  0x00007ffff7e0e122 in ?? () from /lib/x86_64-linux-gnu/libdw.so.1
#2  0x00007ffff7e0e6f7 in ?? () from /lib/x86_64-linux-gnu/libdw.so.1
#3  0x00005555558e6c3c in libdw__addr2line (dso_name=3D0x555557b41270
"/root/.debug/.build-id/4c/72a04e484e8636631219f4454cc64a674a5f57/elf",
    addr=3D1903613, file=3D0x7fffffffa830, line_nr=3D0x7fffffffa82c,
dso=3D0x5555569eba20, unwind_inlines=3Dfalse, node=3D0x0, sym=3D0x0) at
util/libdw.c:59
#4  0x000055555584c861 in addr2line (dso_name=3D0x555557b41270
"/root/.debug/.build-id/4c/72a04e484e8636631219f4454cc64a674a5f57/elf",
    addr=3D1903613, file=3D0x7fffffffa830, line_nr=3D0x7fffffffa82c,
dso=3D0x5555569eba20, unwind_inlines=3Dfalse, node=3D0x0, sym=3D0x0)
    at util/srcline.c:124
#5  0x000055555584ca9c in __get_srcline (dso=3D0x5555569eba20,
addr=3D1903613, sym=3D0x0, show_sym=3Dfalse, show_addr=3Dtrue,
unwind_inlines=3Dfalse,
    ip=3D1903613) at util/srcline.c:181
#6  0x000055555584ce21 in get_srcline (dso=3D0x5555569eba20,
addr=3D1903613, sym=3D0x0, show_sym=3Dfalse, show_addr=3Dtrue, ip=3D1903613=
)
    at util/srcline.c:259
#7  0x0000555555754a63 in annotation__calc_lines
(notes=3D0x5555586d02d0, ms=3D0x555558665600, root=3D0x7fffffffa9a0) at
util/annotate.c:1651
#8  0x0000555555754b20 in symbol__calc_lines (ms=3D0x555558665600,
root=3D0x7fffffffa9a0) at util/annotate.c:1663
#9  0x0000555555754f22 in hist_entry__tty_annotate (he=3D0x555558665560,
evsel=3D0x5555561dc6e0) at util/annotate.c:1728
#10 0x00005555555a829a in hist_entry__stdio_annotate
(he=3D0x555558665560, evsel=3D0x5555561dc6e0, ann=3D0x7fffffffcc90) at
builtin-annotate.c:332
#11 0x00005555555a8ed4 in hists__find_annotations
(hists=3D0x5555561dc998, evsel=3D0x5555561dc6e0, ann=3D0x7fffffffcc90) at
builtin-annotate.c:545
#12 0x00005555555a9404 in __cmd_annotate (ann=3D0x7fffffffcc90) at
builtin-annotate.c:655
#13 0x00005555555aa5c6 in cmd_annotate (argc=3D0, argv=3D0x7fffffffe318)
at builtin-annotate.c:949
#14 0x0000555555655e11 in run_builtin (p=3D0x555556128650
<commands+432>, argc=3D3, argv=3D0x7fffffffe318) at perf.c:349
#15 0x00005555556560a9 in handle_internal_command (argc=3D3,
argv=3D0x7fffffffe318) at perf.c:401
#16 0x0000555555656202 in run_argv (argcp=3D0x7fffffffe10c,
argv=3D0x7fffffffe100) at perf.c:445
#17 0x000055555565654b in main (argc=3D3, argv=3D0x7fffffffe318) at perf.c:=
553
(gdb) frame 3
#3  0x00005555558e6c3c in libdw__addr2line (dso_name=3D0x555557b41270
"/root/.debug/.build-id/4c/72a04e484e8636631219f4454cc64a674a5f57/elf",
   addr=3D1903613, file=3D0x7fffffffa830, line_nr=3D0x7fffffffa82c,
dso=3D0x5555569eba20, unwind_inlines=3Dfalse, node=3D0x0, sym=3D0x0) at
util/libdw.c:59
59                      mod =3D dwfl_report_offline(dwfl, dso_name, dso_nam=
e, fd);
```

So I think everything is working as explained. The open happens
returning fd 5, dwfl_report_offline is called and on success it closes
fd 5. Were the dwfl_report_offline to fail then the error path in
libdw__addr2line closes fd.

Looking at older versions of the code (10 years old) the header file
documentation is the same, so I'm not sure why you are seeing a
different behavior.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > > Also, have you checked if this generates the exactly same output with
> > > other implementations?
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
> > > Thanks,
> > > Namhyung
> > >
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/Build     |   1 +
> > > >  tools/perf/util/dso.c     |   2 +
> > > >  tools/perf/util/dso.h     |  11 +++
> > > >  tools/perf/util/libdw.c   | 136 ++++++++++++++++++++++++++++++++++=
++++
> > > >  tools/perf/util/libdw.h   |  60 +++++++++++++++++
> > > >  tools/perf/util/srcline.c |   5 ++
> > > >  6 files changed, 215 insertions(+)
> > > >  create mode 100644 tools/perf/util/libdw.c
> > > >  create mode 100644 tools/perf/util/libdw.h
> > > >
> > > > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > > > index 1c2a43e1dc68..2bed6274e248 100644
> > > > --- a/tools/perf/util/Build
> > > > +++ b/tools/perf/util/Build
> > > > @@ -224,6 +224,7 @@ perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-power=
pc.o
> > > >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-x86.o
> > > >  perf-util-$(CONFIG_LIBDW) +=3D debuginfo.o
> > > >  perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
> > > > +perf-util-$(CONFIG_LIBDW) +=3D libdw.o
> > > >
> > > >  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > > >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind-local=
.o
> > > > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > > > index 344e689567ee..06980844c014 100644
> > > > --- a/tools/perf/util/dso.c
> > > > +++ b/tools/perf/util/dso.c
> > > > @@ -32,6 +32,7 @@
> > > >  #include "string2.h"
> > > >  #include "vdso.h"
> > > >  #include "annotate-data.h"
> > > > +#include "libdw.h"
> > > >
> > > >  static const char * const debuglink_paths[] =3D {
> > > >       "%.0s%s",
> > > > @@ -1605,6 +1606,7 @@ void dso__delete(struct dso *dso)
> > > >       auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
> > > >       dso_cache__free(dso);
> > > >       dso__free_a2l(dso);
> > > > +     dso__free_a2l_libdw(dso);
> > > >       dso__free_symsrc_filename(dso);
> > > >       nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
> > > >       mutex_destroy(dso__lock(dso));
> > > > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > > > index f8ccb9816b89..4aee23775054 100644
> > > > --- a/tools/perf/util/dso.h
> > > > +++ b/tools/perf/util/dso.h
> > > > @@ -268,6 +268,7 @@ DECLARE_RC_STRUCT(dso) {
> > > >       const char       *short_name;
> > > >       const char       *long_name;
> > > >       void             *a2l;
> > > > +     void             *a2l_libdw;
> > > >       char             *symsrc_filename;
> > > >  #if defined(__powerpc__)
> > > >       void            *dwfl;                  /* DWARF debug info *=
/
> > > > @@ -334,6 +335,16 @@ static inline void dso__set_a2l(struct dso *ds=
o, void *val)
> > > >       RC_CHK_ACCESS(dso)->a2l =3D val;
> > > >  }
> > > >
> > > > +static inline void *dso__a2l_libdw(const struct dso *dso)
> > > > +{
> > > > +     return RC_CHK_ACCESS(dso)->a2l_libdw;
> > > > +}
> > > > +
> > > > +static inline void dso__set_a2l_libdw(struct dso *dso, void *val)
> > > > +{
> > > > +     RC_CHK_ACCESS(dso)->a2l_libdw =3D val;
> > > > +}
> > > > +
> > > >  static inline unsigned int dso__a2l_fails(const struct dso *dso)
> > > >  {
> > > >       return RC_CHK_ACCESS(dso)->a2l_fails;
> > > > diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> > > > new file mode 100644
> > > > index 000000000000..c4331fa8e1a3
> > > > --- /dev/null
> > > > +++ b/tools/perf/util/libdw.c
> > > > @@ -0,0 +1,136 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +#include "dso.h"
> > > > +#include "libdw.h"
> > > > +#include "srcline.h"
> > > > +#include "symbol.h"
> > > > +#include "dwarf-aux.h"
> > > > +#include <fcntl.h>
> > > > +#include <unistd.h>
> > > > +#include <elfutils/libdwfl.h>
> > > > +
> > > > +void dso__free_a2l_libdw(struct dso *dso)
> > > > +{
> > > > +     Dwfl *dwfl =3D dso__a2l_libdw(dso);
> > > > +
> > > > +     if (dwfl) {
> > > > +             dwfl_end(dwfl);
> > > > +             dso__set_a2l_libdw(dso, NULL);
> > > > +     }
> > > > +}
> > > > +
> > > > +int libdw__addr2line(const char *dso_name, u64 addr,
> > > > +                  char **file, unsigned int *line_nr,
> > > > +                  struct dso *dso, bool unwind_inlines,
> > > > +                  struct inline_node *node, struct symbol *sym)
> > > > +{
> > > > +     static const Dwfl_Callbacks offline_callbacks =3D {
> > > > +             .find_debuginfo =3D dwfl_standard_find_debuginfo,
> > > > +             .section_address =3D dwfl_offline_section_address,
> > > > +             .find_elf =3D dwfl_build_id_find_elf,
> > > > +     };
> > > > +     Dwfl *dwfl =3D dso__a2l_libdw(dso);
> > > > +     Dwfl_Module *mod;
> > > > +     Dwfl_Line *dwline;
> > > > +     Dwarf_Addr bias;
> > > > +     const char *src;
> > > > +     int lineno;
> > > > +
> > > > +     if (!dwfl) {
> > > > +             /*
> > > > +              * Initialize Dwfl session.
> > > > +              * We need to open the DSO file to report it to libdw=
.
> > > > +              */
> > > > +             int fd;
> > > > +
> > > > +             fd =3D open(dso_name, O_RDONLY);
> > > > +             if (fd < 0)
> > > > +                     return 0;
> > > > +
> > > > +             dwfl =3D dwfl_begin(&offline_callbacks);
> > > > +             if (!dwfl) {
> > > > +                     close(fd);
> > > > +                     return 0;
> > > > +             }
> > > > +
> > > > +             /*
> > > > +              * If the report is successful, the file descriptor f=
d is consumed
> > > > +              * and closed by the Dwfl. If not, it is not closed.
> > > > +              */
> > > > +             mod =3D dwfl_report_offline(dwfl, dso_name, dso_name,=
 fd);
> > > > +             if (!mod) {
> > > > +                     dwfl_end(dwfl);
> > > > +                     close(fd);
> > > > +                     return 0;
> > > > +             }
> > > > +
> > > > +             dwfl_report_end(dwfl, /*removed=3D*/NULL, /*arg=3D*/N=
ULL);
> > > > +             dso__set_a2l_libdw(dso, dwfl);
> > > > +     } else {
> > > > +             /* Dwfl session already initialized, get module for a=
ddress. */
> > > > +             mod =3D dwfl_addrmodule(dwfl, addr);
> > > > +     }
> > > > +
> > > > +     if (!mod)
> > > > +             return 0;
> > > > +
> > > > +     /* Find source line information for the address. */
> > > > +     dwline =3D dwfl_module_getsrc(mod, addr);
> > > > +     if (!dwline)
> > > > +             return 0;
> > > > +
> > > > +     /* Get line information. */
> > > > +     src =3D dwfl_lineinfo(dwline, &addr, &lineno, /*col=3D*/NULL,=
 /*mtime=3D*/NULL, /*length=3D*/NULL);
> > > > +
> > > > +     if (file)
> > > > +             *file =3D src ? strdup(src) : NULL;
> > > > +     if (line_nr)
> > > > +             *line_nr =3D lineno;
> > > > +
> > > > +     /* Optionally unwind inline function call chain. */
> > > > +     if (unwind_inlines && node && src) {
> > > > +             Dwarf_Die *cudie =3D dwfl_module_addrdie(mod, addr, &=
bias);
> > > > +             Dwarf_Die *scopes =3D NULL;
> > > > +             int nscopes;
> > > > +
> > > > +             if (!cudie)
> > > > +                     return 1;
> > > > +
> > > > +             nscopes =3D die_get_scopes(cudie, addr, &scopes);
> > > > +             if (nscopes > 0) {
> > > > +                     int i;
> > > > +                     const char *call_file =3D src;
> > > > +                     unsigned int call_line =3D lineno;
> > > > +
> > > > +                     for (i =3D 0; i < nscopes; i++) {
> > > > +                             Dwarf_Die *die =3D &scopes[i];
> > > > +                             struct symbol *inline_sym;
> > > > +                             char *srcline =3D NULL;
> > > > +                             int tag =3D dwarf_tag(die);
> > > > +
> > > > +                             /* We are interested in inlined subro=
utines. */
> > > > +                             if (tag !=3D DW_TAG_inlined_subroutin=
e &&
> > > > +                                 tag !=3D DW_TAG_subprogram)
> > > > +                                     continue;
> > > > +
> > > > +                             inline_sym =3D new_inline_sym(dso, sy=
m, dwarf_diename(die));
> > > > +
> > > > +                             if (call_file)
> > > > +                                     srcline =3D srcline_from_file=
line(call_file, call_line);
> > > > +
> > > > +                             inline_list__append(inline_sym, srcli=
ne, node);
> > > > +
> > > > +                             /* Update call site for next level. *=
/
> > > > +                             if (tag =3D=3D DW_TAG_inlined_subrout=
ine) {
> > > > +                                     call_file =3D die_get_call_fi=
le(die);
> > > > +                                     call_line =3D die_get_call_li=
neno(die);
> > > > +                             } else {
> > > > +                                     /* Reached the root subprogra=
m. */
> > > > +                                     break;
> > > > +                             }
> > > > +                     }
> > > > +                     free(scopes);
> > > > +             }
> > > > +     }
> > > > +
> > > > +     return 1;
> > > > +}
> > > > diff --git a/tools/perf/util/libdw.h b/tools/perf/util/libdw.h
> > > > new file mode 100644
> > > > index 000000000000..0f8d7b4a11a5
> > > > --- /dev/null
> > > > +++ b/tools/perf/util/libdw.h
> > > > @@ -0,0 +1,60 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef PERF_LIBDW_H
> > > > +#define PERF_LIBDW_H
> > > > +
> > > > +#include <linux/types.h>
> > > > +
> > > > +struct dso;
> > > > +struct inline_node;
> > > > +struct symbol;
> > > > +
> > > > +#ifdef HAVE_LIBDW_SUPPORT
> > > > +/*
> > > > + * libdw__addr2line - Convert address to source location using lib=
dw
> > > > + * @dso_name: Name of the DSO
> > > > + * @addr: Address to resolve
> > > > + * @file: Pointer to return filename (caller must free)
> > > > + * @line_nr: Pointer to return line number
> > > > + * @dso: The dso struct
> > > > + * @unwind_inlines: Whether to unwind inline function calls
> > > > + * @node: Inline node list to append to
> > > > + * @sym: The symbol associated with the address
> > > > + *
> > > > + * This function initializes a Dwfl context for the DSO if not alr=
eady present,
> > > > + * finds the source line information for the given address, and op=
tionally
> > > > + * resolves inline function call chains.
> > > > + *
> > > > + * Returns 1 on success (found), 0 on failure (not found).
> > > > + */
> > > > +int libdw__addr2line(const char *dso_name, u64 addr, char **file,
> > > > +                  unsigned int *line_nr, struct dso *dso,
> > > > +                  bool unwind_inlines, struct inline_node *node,
> > > > +                  struct symbol *sym);
> > > > +
> > > > +/*
> > > > + * dso__free_a2l_libdw - Free libdw resources associated with the =
DSO
> > > > + * @dso: The dso to free resources for
> > > > + *
> > > > + * This function cleans up the Dwfl context used for addr2line loo=
kups.
> > > > + */
> > > > +void dso__free_a2l_libdw(struct dso *dso);
> > > > +
> > > > +#else /* HAVE_LIBDW_SUPPORT */
> > > > +
> > > > +static inline int libdw__addr2line(const char *dso_name __maybe_un=
used,
> > > > +                                u64 addr __maybe_unused, char **fi=
le __maybe_unused,
> > > > +                                unsigned int *line_nr __maybe_unus=
ed,
> > > > +                                struct dso *dso __maybe_unused,
> > > > +                                bool unwind_inlines __maybe_unused=
,
> > > > +                                struct inline_node *node __maybe_u=
nused,
> > > > +                                struct symbol *sym __maybe_unused)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static inline void dso__free_a2l_libdw(struct dso *dso __maybe_unu=
sed)
> > > > +{
> > > > +}
> > > > +#endif /* HAVE_LIBDW_SUPPORT */
> > > > +
> > > > +#endif /* PERF_LIBDW_H */
> > > > diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> > > > index 27c0966611ab..4b456c4d4138 100644
> > > > --- a/tools/perf/util/srcline.c
> > > > +++ b/tools/perf/util/srcline.c
> > > > @@ -6,6 +6,7 @@
> > > >  #include "libbfd.h"
> > > >  #include "llvm.h"
> > > >  #include "symbol.h"
> > > > +#include "libdw.h"
> > > >
> > > >  #include <inttypes.h>
> > > >  #include <string.h>
> > > > @@ -120,6 +121,10 @@ static int addr2line(const char *dso_name, u64=
 addr, char **file, unsigned int *
> > > >  {
> > > >       int ret;
> > > >
> > > > +     ret =3D libdw__addr2line(dso_name, addr, file, line_nr, dso, =
unwind_inlines, node, sym);
> > > > +     if (ret > 0)
> > > > +             return ret;
> > > > +
> > > >       ret =3D llvm__addr2line(dso_name, addr, file, line_nr, dso, u=
nwind_inlines, node, sym);
> > > >       if (ret > 0)
> > > >               return ret;
> > > > --
> > > > 2.52.0.rc2.455.g230fcf2819-goog
> > > >
