Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0223C2628C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Jun 2025 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973020; cv=none; b=fFeCjK8YIgyvYfkxJjSflws6hkkxy0OrTXGv+gWwiyX5bhTwTzsZptwu7LvbsgiSSF8pRio2DF5DfceBU7oj0dNKYPlyJowNukwqabHZri/QAf8DFXV4d8hDDM1j2TNXvYbR/fEF6CX6Ox4+nePidIFTXNsT+Xc5HCX+AqgXJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973020; c=relaxed/simple;
	bh=J2QPahIuPiJ1fmxBiT8+zyc142Q+es2dGMywjLrLYvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8XAOGteJZdHFnIg/syu9vgUuVpu+HxiXRyRUKOYUV+beeN7NUlHd7JyKpCigioSBZmEaEuHM81891SaLMeDyMv0HHJ7kCWDY6g+xqvvtl4XTHYwWL4vDGVMuL04Eb0ohK2PGSImoGV+f3RUSCDDuYkbsNA6+tU5krYID9TUaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oRkppwFN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRkppwFN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237f18108d2so56775ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jun 2025 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750973017; x=1751577817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjor7lmqlWF20HvW9eupaN+ipbvUAegprpf6x6rXwJc=;
        b=oRkppwFNR6V+rtezh8Dq94p49SKPxX27iiO8nAaI0yZBxnxk7alFy3csTJEYmdtXqS
         uuOVDVsti418LzM3WIixf7xKVLE6g71rc56PKyiE9jvRC2NHlh1CIFuxeAfVOyIXg0Nn
         0xzPZZvkqW9bdkN4TNBBV7kY1TrT4c7lm0neK40MBvAPFiZuC904thryVRpi19fTjsys
         ata1qayzKz7EGANp8bIZ0qoCVvRpwjBzOAqPVCc406wUUYdriM91o+rJg3QEiy8C0sUp
         N9VehcyT0I6vtY1lsOzAZKlTCQsVWekD7PeUuCAemdw+CKAXv7OwcZEjVz/sxot5fojl
         9/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973017; x=1751577817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjor7lmqlWF20HvW9eupaN+ipbvUAegprpf6x6rXwJc=;
        b=dfaltzSOnYN0QTdfN0c4wXd6CUyQL/nUXEMiArf/+kFZNk85/w/QxbGcK8xKnsrA/i
         tl6wj/NQKBE/fZhf44Ep0MAs9Y1VAhEwQU6CuxbmtLS2bNHJy4jsBludnNebzzWmbJMJ
         AsZRg6Xp6mwLkEY2wo7o9IVHV0Y4ReUEVM5g2E6qRlkQue/zh2Jj7T7A0dOzCw1ekM32
         Bxkb1MWoNoVSEyWfhC6eBTRY27+JF6qfqiwfNm7kh9JZHfOyoFxNqrqeAXHX8+N1Twhr
         hZWkxWEQJgYcawjLMFdKuomNYGrVDxLQSJjXzpkZ5mN4R7zlhpz1qrezb/kUFp30+oEH
         ZQQw==
X-Forwarded-Encrypted: i=1; AJvYcCXgxSWcObtKv21U9ZGfw3P6cOb+lliUKi7aA5kHGPtEtrBvOKlWxvKckwwq7nWwNWehFBPOSlxImL171ovHbgK9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5637jJMvjXJ8a0Bj8LI4mV+7Qu0UF2GvtuO427++J6gdA6HEZ
	r/AiVRNv4ITxxSHUna27VXTwK6wEFh0xp0GKfOZ0hfWE8XMo2g0lVYsZofaKwSij3yemPiBNZOx
	gvgsWcv7zSxVhTyPhiBsxpuSmopbtKJCoJLQrGUQ9AVgCh8x5k8Ps0uEl
X-Gm-Gg: ASbGncuyoiYMiyR5hnp+zn0KOAAjdHck42SNmmohz+S8/IFMPKwHrOAFSuOvvWG7vrN
	CFlg/x5mquloJPdmPDONuVSmOKhiAKbcsTBHKx4i5O4yfZwqyHM2DYEpl1S6g0DQhTOQ6J3Dc6i
	iCwz8AXGTomyHblvvb67ysmzFDdSpvopnWeaxuC668PGJUJ62xdHL8diM1tT/77wuSzYPWf9tY
X-Google-Smtp-Source: AGHT+IErFpg6qe7vg1DfOTQm1g3N76FLBBQyW+hspzXsVoVpMLpdCObFFOWjC4q0vAkCsDbE2rboagahOcp4qDdA8bU=
X-Received: by 2002:a17:903:228b:b0:223:2630:6b86 with SMTP id
 d9443c01a7336-23aca807140mr212005ad.7.1750973016981; Thu, 26 Jun 2025
 14:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625230339.702610-1-namhyung@kernel.org> <CAP-5=fUUOT4-1DU=Lx7OTayLssUq_ZT-bdGuqRzj_2jMqBx_FQ@mail.gmail.com>
 <aF2IbcebglJOP1LG@google.com>
In-Reply-To: <aF2IbcebglJOP1LG@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Jun 2025 14:23:24 -0700
X-Gm-Features: Ac12FXziebvYoUFGXZY422Cuv1y1_LTlTEewUFsG6EDrdAza0Z7oWAGq6AUAYf8
Message-ID: <CAP-5=fX6=e2Vd6LUZtu-cvnswjYcsV3Oj59n4mB1jB7RW627qQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf annotate: Fix source code annotate with objdump
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 10:50=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Thu, Jun 26, 2025 at 08:23:30AM -0700, Ian Rogers wrote:
> > On Wed, Jun 25, 2025 at 4:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Recently it uses llvm and capstone to speed up annotation or disassem=
bly
> > > of instructions.  But they don't support source code view yet.  Until=
 it
> > > fixed, we can force to use objdump for source code annotation.
> > >
> > > To prevent performance loss, it's disabled by default and turned it o=
n
> > > when user requests it in TUI by pressing 's' key.
> > >
> > > Link: https://lore.kernel.org/r/20250608004613.238291-1-namhyung@kern=
el.org
> > > Reported-by: Ingo Molnar <mingo@kernel.org>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Can we move this series forward:
> > https://lore.kernel.org/lkml/20250417230740.86048-1-irogers@google.com/
> > There was some build testing by Arnaldo but then things became
> > stalled. I'm guessing I'll need to send a rebase.
>
> I'll take a look.  Is there any thing related to this patchset?
> It'd be nice if we can land this first.

Ok, I'll rebase those changes after this lands.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > > ---
> > > v3)
> > >  * show warning when there's no source code
> > >
> > >  tools/perf/ui/browsers/annotate.c | 86 +++++++++++++++++++++++++++++=
--
> > >  tools/perf/util/annotate.c        |  2 +
> > >  tools/perf/util/annotate.h        |  1 +
> > >  tools/perf/util/disasm.c          |  7 +++
> > >  4 files changed, 93 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browse=
rs/annotate.c
> > > index ab776b1ed2d5b4ba..183902dac042ecb0 100644
> > > --- a/tools/perf/ui/browsers/annotate.c
> > > +++ b/tools/perf/ui/browsers/annotate.c
> > > @@ -345,6 +345,23 @@ static void annotate_browser__calc_percent(struc=
t annotate_browser *browser,
> > >         browser->curr_hot =3D rb_last(&browser->entries);
> > >  }
> > >
> > > +static struct annotation_line *annotate_browser__find_new_asm_line(
> > > +                                       struct annotate_browser *brow=
ser,
> > > +                                       int idx_asm)
> > > +{
> > > +       struct annotation_line *al;
> > > +       struct list_head *head =3D browser->b.entries;
> > > +
> > > +       /* find an annotation line in the new list with the same idx_=
asm */
> > > +       list_for_each_entry(al, head, node) {
> > > +               if (al->idx_asm =3D=3D idx_asm)
> > > +                       return al;
> > > +       }
> > > +
> > > +       /* There are no asm lines */
> > > +       return NULL;
> > > +}
> > > +
> > >  static struct annotation_line *annotate_browser__find_next_asm_line(
> > >                                         struct annotate_browser *brow=
ser,
> > >                                         struct annotation_line *al)
> > > @@ -368,7 +385,31 @@ static struct annotation_line *annotate_browser_=
_find_next_asm_line(
> > >         return NULL;
> > >  }
> > >
> > > -static bool annotate_browser__toggle_source(struct annotate_browser =
*browser)
> > > +static bool annotation__has_source(struct annotation *notes)
> > > +{
> > > +       struct annotation_line *al;
> > > +       bool found_asm =3D false;
> > > +
> > > +       /* Let's skip the first non-asm lines which present regardles=
s of source. */
> > > +       list_for_each_entry(al, &notes->src->source, node) {
> > > +               if (al->offset >=3D 0) {
> > > +                       found_asm =3D true;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       if (found_asm) {
> > > +               /* After assembly lines, any line without offset mean=
s source. */
> > > +               list_for_each_entry_continue(al, &notes->src->source,=
 node) {
> > > +                       if (al->offset =3D=3D -1)
> > > +                               return true;
> > > +               }
> > > +       }
> > > +       return false;
> > > +}
> > > +
> > > +static bool annotate_browser__toggle_source(struct annotate_browser =
*browser,
> > > +                                           struct evsel *evsel)
> > >  {
> > >         struct annotation *notes =3D browser__annotation(&browser->b)=
;
> > >         struct annotation_line *al;
> > > @@ -377,6 +418,39 @@ static bool annotate_browser__toggle_source(stru=
ct annotate_browser *browser)
> > >         browser->b.seek(&browser->b, offset, SEEK_CUR);
> > >         al =3D list_entry(browser->b.top, struct annotation_line, nod=
e);
> > >
> > > +       if (!annotate_opts.annotate_src)
> > > +               annotate_opts.annotate_src =3D true;
> > > +
> > > +       /*
> > > +        * It's about to get source code annotation for the first tim=
e.
> > > +        * Drop the existing annotation_lines and get the new one wit=
h source.
> > > +        * And then move to the original line at the same asm index.
> > > +        */
> > > +       if (annotate_opts.hide_src_code && !notes->src->tried_source)=
 {
> > > +               struct map_symbol *ms =3D browser->b.priv;
> > > +               int orig_idx_asm =3D al->idx_asm;
> > > +
> > > +               /* annotate again with source code info */
> > > +               annotate_opts.hide_src_code =3D false;
> > > +               annotated_source__purge(notes->src);
> > > +               symbol__annotate2(ms, evsel, &browser->arch);
> > > +               annotate_opts.hide_src_code =3D true;
> > > +
> > > +               /* should be after annotated_source__purge() */
> > > +               notes->src->tried_source =3D true;
> > > +
> > > +               if (!annotation__has_source(notes))
> > > +                       ui__warning("Annotation has no source code.")=
;
> > > +
> > > +               browser->b.entries =3D &notes->src->source;
> > > +               al =3D annotate_browser__find_new_asm_line(browser, o=
rig_idx_asm);
> > > +               if (unlikely(al =3D=3D NULL)) {
> > > +                       al =3D list_first_entry(&notes->src->source,
> > > +                                             struct annotation_line,=
 node);
> > > +               }
> > > +               browser->b.seek(&browser->b, al->idx_asm, SEEK_SET);
> > > +       }
> > > +
> > >         if (annotate_opts.hide_src_code) {
> > >                 if (al->idx_asm < offset)
> > >                         offset =3D al->idx;
> > > @@ -833,7 +907,7 @@ static int annotate_browser__run(struct annotate_=
browser *browser,
> > >                         nd =3D browser->curr_hot;
> > >                         break;
> > >                 case 's':
> > > -                       if (annotate_browser__toggle_source(browser))
> > > +                       if (annotate_browser__toggle_source(browser, =
evsel))
> > >                                 ui_helpline__puts(help);
> > >                         annotate__scnprintf_title(hists, title, sizeo=
f(title));
> > >                         annotate_browser__show(&browser->b, title, he=
lp);
> > > @@ -1011,6 +1085,12 @@ int symbol__tui_annotate(struct map_symbol *ms=
, struct evsel *evsel,
> > >                         ui__error("Couldn't annotate %s:\n%s", sym->n=
ame, msg);
> > >                         return -1;
> > >                 }
> > > +
> > > +               if (!annotate_opts.hide_src_code) {
> > > +                       notes->src->tried_source =3D true;
> > > +                       if (!annotation__has_source(notes))
> > > +                               ui__warning("Annotation has no source=
 code.");
> > > +               }
> > >         }
> > >
> > >         ui_helpline__push("Press ESC to exit");
> > > @@ -1025,7 +1105,7 @@ int symbol__tui_annotate(struct map_symbol *ms,=
 struct evsel *evsel,
> > >
> > >         ret =3D annotate_browser__run(&browser, evsel, hbt);
> > >
> > > -       if(not_annotated)
> > > +       if (not_annotated && !notes->src->tried_source)
> > >                 annotated_source__purge(notes->src);
> > >
> > >         return ret;
> > > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > > index 264a212b47df850c..0dd475a744b6dfac 100644
> > > --- a/tools/perf/util/annotate.c
> > > +++ b/tools/perf/util/annotate.c
> > > @@ -1451,6 +1451,7 @@ void annotated_source__purge(struct annotated_s=
ource *as)
> > >                 list_del_init(&al->node);
> > >                 disasm_line__free(disasm_line(al));
> > >         }
> > > +       as->tried_source =3D false;
> > >  }
> > >
> > >  static size_t disasm_line__fprintf(struct disasm_line *dl, FILE *fp)
> > > @@ -2280,6 +2281,7 @@ void annotation_options__init(void)
> > >         opt->annotate_src =3D true;
> > >         opt->offset_level =3D ANNOTATION__OFFSET_JUMP_TARGETS;
> > >         opt->percent_type =3D PERCENT_PERIOD_LOCAL;
> > > +       opt->hide_src_code =3D true;
> > >         opt->hide_src_code_on_title =3D true;
> > >  }
> > >
> > > diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> > > index bbb89b32f398b3c9..8b5131d257b01e3e 100644
> > > --- a/tools/perf/util/annotate.h
> > > +++ b/tools/perf/util/annotate.h
> > > @@ -294,6 +294,7 @@ struct annotated_source {
> > >         int                     nr_entries;
> > >         int                     nr_asm_entries;
> > >         int                     max_jump_sources;
> > > +       bool                    tried_source;
> > >         u64                     start;
> > >         struct {
> > >                 u8              addr;
> > > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > > index 8f0eb56c6fc66a96..ff475a239f4b0db4 100644
> > > --- a/tools/perf/util/disasm.c
> > > +++ b/tools/perf/util/disasm.c
> > > @@ -2284,6 +2284,13 @@ int symbol__disassemble(struct symbol *sym, st=
ruct annotate_args *args)
> > >                 }
> > >         }
> > >
> > > +       /* FIXME: LLVM and CAPSTONE should support source code */
> > > +       if (options->annotate_src && !options->hide_src_code) {
> > > +               err =3D symbol__disassemble_objdump(symfs_filename, s=
ym, args);
> > > +               if (err =3D=3D 0)
> > > +                       goto out_remove_tmp;
> > > +       }
> > > +
> > >         err =3D -1;
> > >         for (u8 i =3D 0; i < ARRAY_SIZE(options->disassemblers) && er=
r !=3D 0; i++) {
> > >                 enum perf_disassembler dis =3D options->disassemblers=
[i];
> > > --
> > > 2.50.0.727.gbf7dc18ff4-goog
> > >
