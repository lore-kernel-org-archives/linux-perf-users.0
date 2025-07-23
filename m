Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548D1F4C87;
	Wed, 23 Jul 2025 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287630; cv=none; b=dJgjs7Oa5V7RmsyLHQlaE5sFaEWRlwpRnLVyKhLgGMnODQPxICAXsnWzV9kU/ik+n19YU8PaOOoyv9pnFUA9zfXxmUZPrgGz1k1UTn/Glhf5wRNVCvEtFb+MFSrJmC0+pTkr9DBB7LCuH+BXF/35YCtT9ZDz5zpzLG5nOS9+xqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287630; c=relaxed/simple;
	bh=oTd0EuHHjKrCdYujk4PLI6jiloB4JBjZE/fMA+OwsFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na8xwYm5Ys4NHE5HeZvOuvWD4iCDzZvuztsPWjco2q9NwqjptUQhnc96dm7cFdvqRNlj3XcGMBojrvTBgPneOCRiNamEXOw3rP92fhfAbd6FLlCHVy/17ymI/AnZw68HItOx5df6dU9mVEiutIAtUNvLSR9/hP8Jqez2EgYE0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7pvM9ES; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7pvM9ES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2972C4CEE7;
	Wed, 23 Jul 2025 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753287630;
	bh=oTd0EuHHjKrCdYujk4PLI6jiloB4JBjZE/fMA+OwsFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7pvM9ESzvMSs9zVUpJhDPeifBPpyJfP3TkTpOXFpj3C33Ytpuc5vnhink62Bw8tj
	 5iIBkHhpBf7P1Z7exfrMVVNTzTYiRca/1IhEz5c7P7k8P4K2NjJg+5SYfPKXXimvRR
	 m4mkFhEpHadU/9cMDthqDNV2k68MPA18pJ1Vm5qhezp0XIl6I96btvCDs4LNj3jGz5
	 9OVyUPM90rRdnT25F1UOw7glP1wLPl3Uf3A+GwbfQi7Wn8oTuQnhciqS14EggvPvPn
	 Ti1m5UuNn7rVty/UiyWY3FKA6RgTXMElFWwvv+tHIezUNd6dK/x7DYlT8TlITI5EIX
	 7rDdoNnrqrwSw==
Date: Wed, 23 Jul 2025 13:20:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 5/8] perf annotate: Add --code-with-type support for
 TUI
Message-ID: <aIELyy7jg5gSlkVT@x1>
References: <20250716050054.14130-1-namhyung@kernel.org>
 <20250716050054.14130-6-namhyung@kernel.org>
 <aIEH99tRH8EoqBA5@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIEH99tRH8EoqBA5@x1>

On Wed, Jul 23, 2025 at 01:04:11PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Jul 15, 2025 at 10:00:51PM -0700, Namhyung Kim wrote:
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
> >  	Show data type info in code annotation (for memory instructions only).
> > -	Currently it only works with --stdio option.
> >  
> >  
> >  SEE ALSO
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index 9833c2c82a2fee46..6debd725392db4a4 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -917,11 +917,6 @@ int cmd_annotate(int argc, const char **argv)
> >  		symbol_conf.annotate_data_sample = true;
> >  	} else if (annotate_opts.code_with_type) {
> >  		symbol_conf.annotate_data_member = true;
> > -
> > -		if (!annotate.use_stdio) {
> > -			pr_err("--code-with-type only works with --stdio.\n");
> > -			goto out_delete;
> > -		}
> >  	}
> >  
> >  	setup_browser(true);
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
> >  	ui_helpline__push("Press ESC to exit");
> >  
> > +	if (annotate_opts.code_with_type)
> > +		browser.dbg = debuginfo__new(dso__long_name(dso));
> 
> Some error checking here to tell the user if debuginfo isn't available
> and hints on how to get it in place?

Ok, you did it  later with:

commit 81d638a1b96ec04d7c41e163b5077419cf85e798 (HEAD)
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Tue Jul 15 22:00:53 2025 -0700

    perf annotate: Show warning when debuginfo is not available
    
    When user requests data-type annotation but no DWARF info is available,
    show a warning message about it.

- Arnaldo
