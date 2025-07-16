Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F62BE03B
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698547; cv=none; b=No82uH3B5sxzCbl1iaj96+lFa9L5b+fJQXySYhvxfclFVk0jf5KYM7eEm128yEnM63MPfl8wii6VWhxuvNqz2iuoPQbo9mWYsaRb8bcKtq1r4n8fOZMjMalAI2o4RmdPPhjllRYtUrQJRnwYULzs1a/pOP7ekG6Y67kWsGVvzLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698547; c=relaxed/simple;
	bh=untgnyDWEArh1UoVstqivWFtfJ7NZfaSTAzmxoDN32w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGiVZP8VnceNJl1byfZ+8JLbc53+Oq4NxmHgfyid5qmIi8mb++EGO3WaAKeC5PTt18IBpvEC1P7zE8wK5ha+zxpr67i6mI/KebTSWNt0/81Yl6Wkvua++2leExoWOS64LxmKOzMsdGeGUSPzGchWgIkeuep8UTNXFICBfV2ZaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q74slgOD; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q74slgOD"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e283b2d065so11745ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 13:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752698544; x=1753303344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlQP6cWB5c6EOc1XK+3iu3r9ZzZfzPwNGPOPdZh2/9g=;
        b=q74slgOD7p4vcw8ePeAw4S8/9rvQBx4qEjpGZk3jIWRA0UYYiMqp+E9vSST2b83dxb
         QA1H9AnbZYe/8pI7/pHtYlIQOeu8Jfa2nyAewaW50nWm7fgCjzDDDPUsP7KOth6xe0cG
         ndXJHUVWeMPRXZX96ZlFIKDqKfEjdRfG0XYIwXACbGcvhG7+cLXpDLfc1rHdMS/pgz6g
         mbxHncNjyT7IXY4SkA9D0zNXY114V43YBHHdHHvmfnzjKMhPWuHCkwXVkQQG6yrBOPpF
         qAfuMbj+UK6qUu28cK5yRoC+B2YKhmeW72bQgn5J83HPUcU7ZxP0fLpJ3auBGoeWbz4x
         ap3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752698544; x=1753303344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlQP6cWB5c6EOc1XK+3iu3r9ZzZfzPwNGPOPdZh2/9g=;
        b=h7qSmW+18HeDm9X0hMQHSi9p85v8/RVwRwN+iYP4c1ufEqEXZ+S99iSz6pc14pB6bY
         ZCNlj0AjhAGlDFc0JZ6pZK3DqT+9bdaZ1xv3JIt0hzRgrLC6Z6DQQ1vfUejN0r1tnpyQ
         HH8UEp4b+gtkY5MDst0KlByHd5PREFbFSlFqG4daKUqAEDgaoQLCC02dqargugCueQZl
         toKzmUhz49bq5Qv8TugcTP2HWIo2/elN3ywTod/GRCYhdbEYEC5jMYKfsPxW4Ui2ZdrM
         vFttjrCOTleTNw3OP3iJGXN40+zZWuIfuUVlyiD1dPuZUis8Uk2kV5tukx1gFWYbPhDU
         CbKA==
X-Forwarded-Encrypted: i=1; AJvYcCWNLtn7vg4DLSyFq5MHbEbeWniXaAY+eZTh3pNkwhrQ813z/rpHYmHSc+B3MdEWRxLPQpWeOBpexWaIn456u0nC@vger.kernel.org
X-Gm-Message-State: AOJu0YxEeJB4Oc5/ztsZlpseSZ50KxAfWpGtNt9B6bBcnRcFe3Ryp/I8
	9HN/SDwDQVI1rd13UdGheUiueWnSs/z5A1W84hMLImFdgR81KnjSfxoRP/s3hvurR+If5CyTvL8
	/w7Ff6ioZe3UbGoln/LDmjJpNeetk7t3t4n4OinAz
X-Gm-Gg: ASbGnctK/GD7ZbVf39PYKNSdNizgAeKguNyNKp9bZfg9GccgNj1Uxi6VrsN/HV8K7sE
	eLJCZXV+DKZoY24O1wouqohtzVoIeyfowLgIqY8+9dg2y/+YfBtkqadvp8oa8u7/+y0Q3oBVLvK
	YLrRtJlwPsgLO0OgFCDzqg3rpH0ngJGniEe+idb1qNW2D2gFudYiSAH/RHTR25IL8N2yYDNQ0sA
	NZ3GOVLghW2c/2pXY5Qesive453APQunw==
X-Google-Smtp-Source: AGHT+IEHRs8DyBpwx31BC4At3emdTm2IEDp0Bj1peZov4YekTcB0/n7pRdCy5Ga1IIYvu5jwdDe21uPeu+W8euKtE5o=
X-Received: by 2002:a05:6e02:2185:b0:3dc:7e19:fcc4 with SMTP id
 e9e14a558f8ab-3e28c9d6b5bmr1158075ab.8.1752698544209; Wed, 16 Jul 2025
 13:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716050054.14130-1-namhyung@kernel.org> <20250716050054.14130-6-namhyung@kernel.org>
 <CAP-5=fVAYNy9pk9zyQRySrJ-1j12dC9ogiW94133Li_WQHd6RA@mail.gmail.com> <aHfg5YPlVD_6iMg6@google.com>
In-Reply-To: <aHfg5YPlVD_6iMg6@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Jul 2025 13:42:13 -0700
X-Gm-Features: Ac12FXxkrnUg-BTp1aAqZYDN1yF2G4GBlam11bOWOTNTxDVzgvehODrb9gA8fV4
Message-ID: <CAP-5=fV=E4_9RVvf1CW0GM0VY+ubr8sOvnXc+xhGW66PhMFCnA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] perf annotate: Add --code-with-type support for TUI
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 10:27=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Jul 16, 2025 at 08:00:37AM -0700, Ian Rogers wrote:
> > On Tue, Jul 15, 2025 at 10:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > Until now, the --code-with-type option is available only on stdio.
> > > But it was an artifical limitation because of an implemention issue.
> > >
> > > Implement the same logic in annotation_line__write() for stdio2/TUI.
> > > Make disasm_line__write() return the number of printed characters so
> > > that it can skip unnecessary operations when the screen is full.
> > >
> > > Remove the limitation and update the man page.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/Documentation/perf-annotate.txt |  1 -
> > >  tools/perf/builtin-annotate.c              |  5 --
> > >  tools/perf/ui/browsers/annotate.c          |  6 +++
> > >  tools/perf/util/annotate.c                 | 61 +++++++++++++++++++-=
--
> > >  4 files changed, 61 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/=
Documentation/perf-annotate.txt
> > > index 46090c5b42b4762f..547f1a2680185e3c 100644
> > > --- a/tools/perf/Documentation/perf-annotate.txt
> > > +++ b/tools/perf/Documentation/perf-annotate.txt
> > > @@ -170,7 +170,6 @@ include::itrace.txt[]
> > >
> > >  --code-with-type::
> > >         Show data type info in code annotation (for memory instructio=
ns only).
> > > -       Currently it only works with --stdio option.
> > >
> > >
> > >  SEE ALSO
> > > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annot=
ate.c
> > > index 9833c2c82a2fee46..6debd725392db4a4 100644
> > > --- a/tools/perf/builtin-annotate.c
> > > +++ b/tools/perf/builtin-annotate.c
> > > @@ -917,11 +917,6 @@ int cmd_annotate(int argc, const char **argv)
> > >                 symbol_conf.annotate_data_sample =3D true;
> > >         } else if (annotate_opts.code_with_type) {
> > >                 symbol_conf.annotate_data_member =3D true;
> > > -
> > > -               if (!annotate.use_stdio) {
> > > -                       pr_err("--code-with-type only works with --st=
dio.\n");
> > > -                       goto out_delete;
> > > -               }
> > >         }
> > >
> > >         setup_browser(true);
> > > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browse=
rs/annotate.c
> > > index 23bea5b165774ae7..cdee1969f3131a7c 100644
> > > --- a/tools/perf/ui/browsers/annotate.c
> > > +++ b/tools/perf/ui/browsers/annotate.c
> > > @@ -4,6 +4,7 @@
> > >  #include "../ui.h"
> > >  #include "../../util/annotate.h"
> > >  #include "../../util/debug.h"
> > > +#include "../../util/debuginfo.h"
> > >  #include "../../util/dso.h"
> > >  #include "../../util/hist.h"
> > >  #include "../../util/sort.h"
> > > @@ -1101,6 +1102,9 @@ int __hist_entry__tui_annotate(struct hist_entr=
y *he, struct map_symbol *ms,
> > >
> > >         ui_helpline__push("Press ESC to exit");
> > >
> > > +       if (annotate_opts.code_with_type)
> > > +               browser.dbg =3D debuginfo__new(dso__long_name(dso));
> > > +
> > >         browser.b.width =3D notes->src->widths.max_line_len;
> > >         browser.b.nr_entries =3D notes->src->nr_entries;
> > >         browser.b.entries =3D &notes->src->source;
> > > @@ -1111,6 +1115,8 @@ int __hist_entry__tui_annotate(struct hist_entr=
y *he, struct map_symbol *ms,
> > >
> > >         ret =3D annotate_browser__run(&browser, evsel, hbt);
> > >
> > > +       if (annotate_opts.code_with_type)
> > > +               debuginfo__delete(browser.dbg);
> > >         if (not_annotated && !notes->src->tried_source)
> > >                 annotated_source__purge(notes->src);
> > >
> > > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > > index d69e406c1bc289cd..06ddc7a9f58722a4 100644
> > > --- a/tools/perf/util/annotate.c
> > > +++ b/tools/perf/util/annotate.c
> > > @@ -1362,6 +1362,11 @@ static int symbol__annotate_fprintf2(struct sy=
mbol *sym, FILE *fp,
> > >         };
> > >         struct annotation_line *al;
> > >
> > > +       if (annotate_opts.code_with_type) {
> > > +               evsel__get_arch(apd->evsel, &apd->arch);
> > > +               apd->dbg =3D debuginfo__new(dso__long_name(map__dso(a=
pd->he->ms.map)));
> >
> > This API looks unfortunate. A dso may have a long name (it'd be easier
> > to understand if this were called path rather than long name) or a
> > build ID. The API isn't the fault of this change, but I thought I'd
> > mention as we move toward greater use of build IDs.
>
> Are you talking about build-id in MMAP2?  I think it's build-id vs. (dev
> major/minor + inode) and the long name should be available always.

I'm thinking of work I'm doing with build IDs like (unmerged):
https://lore.kernel.org/lkml/20250628045017.1361563-1-irogers@google.com/
Even with mmap2 events the filename shouldn't be necessary as the
build ID should be preferred - if you profile remotely there may be a
file name/path collision on a local machine, but it should be unlikely
for a build ID collision. In those patches the dso_id is changed to
instead of considering inode numbers using build IDs when possible. It
was already the case that the name of a dso could be changed, which
affects sorting. In general I think we should move away from file
paths, inodes and the like as the build IDs will avoid races, work
across systems, etc. I think in this case we could add:
```
apd->dbg =3D dso__debuginfo(map__dso(apd->he->ms.map))))
```
or possibly just change `apd->dbg` to be the dso and grab the
debuginfo from the dso when needed. For now the dso__debuginfo would
be something like:
```
struct debuginfo *dso__debuginfo(struct dso *dso)
{
     debuginfo__delete(dso->debuginfo);
     dso->debuginfo =3D debuginfo__new(dso__long_name(dso));
     return dso->debuginfo;
}
```
but in the future we can find the debuginfo off of the build ID and paths, =
etc.

Thanks,
Ian
> Thanks,
> Namhyung
>
