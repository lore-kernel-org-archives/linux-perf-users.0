Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E1A42049;
	Wed, 16 Jul 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686825; cv=none; b=QGeFxDr5vswocoIsnwb4eW3yJO0zCLG2PF7X7nyZ1EQnWnZV+NX04iXb0+z17HBtX5QX+YdGbga/j1n+t1RM+mxBJVqSQaNzE82nUFVsLN8+Kmnq089NHQjlDOfiTB9IV7Jt7BJw54Y8cnrwGnJBCYK8K3oj9mUtJmpGm8z5SyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686825; c=relaxed/simple;
	bh=ung1/c+VoT7uBwomOYs85t+QB/IG/Pxjtt1tBmMikUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i62G6EbY7Aci6Ce4stDtLjDFHP8AbXDmS82UJYLf8E48zlU9x+nLQciHbtWpZ3bqSM6myI1FHucXDTo61ampfe9WbkRJTn7Va1+tDzFiXMuHo6OKsP+/CKjxCnsY9uiBFbWWha1gGPJT1hV/J0vqrf1WOQvJEHALKYOrbd/aT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llxwcRsL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llxwcRsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED23EC4CEF9;
	Wed, 16 Jul 2025 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752686824;
	bh=ung1/c+VoT7uBwomOYs85t+QB/IG/Pxjtt1tBmMikUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=llxwcRsLciriimjC/YDWuGTfT8JGzVDHw//ZpNeeI++d+FazffRQNFomFtQGbZ0n5
	 ljN7tbZ1ocxp3bE5CvDKsyqwmLi8zrkQjgA+4ED8dONLxYI/zj3cQSeGmOLNw7euX8
	 DTFCzMULhVPHSYh5PO1+VdxPh8ChxsUHOg04QSE0V04NFSiLEE8cztZAesNEiK2199
	 FbcXfOe/waKaWGwn0B4pBVCLOkihwPPyTQp3oN70bcG4s0clLVzN/s+juMjE81ZcuW
	 5dIIbKp9JcnrCvLaX2VaJi13sdThtiCP5ip5Le55oltIF8AveEwTCT2XsxlAPXcviJ
	 x46vrJIkLm46A==
Date: Wed, 16 Jul 2025 10:27:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 5/8] perf annotate: Add --code-with-type support for
 TUI
Message-ID: <aHfg5YPlVD_6iMg6@google.com>
References: <20250716050054.14130-1-namhyung@kernel.org>
 <20250716050054.14130-6-namhyung@kernel.org>
 <CAP-5=fVAYNy9pk9zyQRySrJ-1j12dC9ogiW94133Li_WQHd6RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVAYNy9pk9zyQRySrJ-1j12dC9ogiW94133Li_WQHd6RA@mail.gmail.com>

On Wed, Jul 16, 2025 at 08:00:37AM -0700, Ian Rogers wrote:
> On Tue, Jul 15, 2025 at 10:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Until now, the --code-with-type option is available only on stdio.
> > But it was an artifical limitation because of an implemention issue.
> >
> > Implement the same logic in annotation_line__write() for stdio2/TUI.
> > Make disasm_line__write() return the number of printed characters so
> > that it can skip unnecessary operations when the screen is full.
> >
> > Remove the limitation and update the man page.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-annotate.txt |  1 -
> >  tools/perf/builtin-annotate.c              |  5 --
> >  tools/perf/ui/browsers/annotate.c          |  6 +++
> >  tools/perf/util/annotate.c                 | 61 +++++++++++++++++++---
> >  4 files changed, 61 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
> > index 46090c5b42b4762f..547f1a2680185e3c 100644
> > --- a/tools/perf/Documentation/perf-annotate.txt
> > +++ b/tools/perf/Documentation/perf-annotate.txt
> > @@ -170,7 +170,6 @@ include::itrace.txt[]
> >
> >  --code-with-type::
> >         Show data type info in code annotation (for memory instructions only).
> > -       Currently it only works with --stdio option.
> >
> >
> >  SEE ALSO
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index 9833c2c82a2fee46..6debd725392db4a4 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -917,11 +917,6 @@ int cmd_annotate(int argc, const char **argv)
> >                 symbol_conf.annotate_data_sample = true;
> >         } else if (annotate_opts.code_with_type) {
> >                 symbol_conf.annotate_data_member = true;
> > -
> > -               if (!annotate.use_stdio) {
> > -                       pr_err("--code-with-type only works with --stdio.\n");
> > -                       goto out_delete;
> > -               }
> >         }
> >
> >         setup_browser(true);
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index 23bea5b165774ae7..cdee1969f3131a7c 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -4,6 +4,7 @@
> >  #include "../ui.h"
> >  #include "../../util/annotate.h"
> >  #include "../../util/debug.h"
> > +#include "../../util/debuginfo.h"
> >  #include "../../util/dso.h"
> >  #include "../../util/hist.h"
> >  #include "../../util/sort.h"
> > @@ -1101,6 +1102,9 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> >
> >         ui_helpline__push("Press ESC to exit");
> >
> > +       if (annotate_opts.code_with_type)
> > +               browser.dbg = debuginfo__new(dso__long_name(dso));
> > +
> >         browser.b.width = notes->src->widths.max_line_len;
> >         browser.b.nr_entries = notes->src->nr_entries;
> >         browser.b.entries = &notes->src->source;
> > @@ -1111,6 +1115,8 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> >
> >         ret = annotate_browser__run(&browser, evsel, hbt);
> >
> > +       if (annotate_opts.code_with_type)
> > +               debuginfo__delete(browser.dbg);
> >         if (not_annotated && !notes->src->tried_source)
> >                 annotated_source__purge(notes->src);
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index d69e406c1bc289cd..06ddc7a9f58722a4 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1362,6 +1362,11 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
> >         };
> >         struct annotation_line *al;
> >
> > +       if (annotate_opts.code_with_type) {
> > +               evsel__get_arch(apd->evsel, &apd->arch);
> > +               apd->dbg = debuginfo__new(dso__long_name(map__dso(apd->he->ms.map)));
> 
> This API looks unfortunate. A dso may have a long name (it'd be easier
> to understand if this were called path rather than long name) or a
> build ID. The API isn't the fault of this change, but I thought I'd
> mention as we move toward greater use of build IDs.

Are you talking about build-id in MMAP2?  I think it's build-id vs. (dev
major/minor + inode) and the long name should be available always.

Thanks,
Namhyung

