Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFE26E71E;
	Wed, 20 Aug 2025 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726186; cv=none; b=sHz7MBsb0YGToEB1Y8cRL0iJqrJz/QT9mu8kHXCMDzIATFjt08QLvSYfPe+7WSBPkigf9us6tS/pSasktMPJ/vbOd8avduUzeJfDZK7UrAEcWoN9z7rqM7OgyaYF0FQu/xErQLaFjvCLcz7Aq9xfRMK9KNqp63Qth8lgPfUfSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726186; c=relaxed/simple;
	bh=ZNePc8eljeuN/nBlkY4V9QDMgjhk362J4O0djUdMN0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akpja+vnRHqJgqknK9XZzzSuNuc1tFE5kCXCCD1tXOmM0SFBXK5DpDU2kNyhB66AZ//mb2LQfpJkeJCb19qTDePUufH68+INy+VgTIYpzPvb1st4aZqAv/EgDSdE1NAPKlheNJ7pbDVd8Dz7agQV5l0yhb8xviljayLScPrtB7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx9xmdPe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx9xmdPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFE4C4CEE7;
	Wed, 20 Aug 2025 21:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755726186;
	bh=ZNePc8eljeuN/nBlkY4V9QDMgjhk362J4O0djUdMN0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lx9xmdPeMphB1F81iMcigRYuGSXhpVRa7iz6L+89aNhMaLs/DE7XMOPdKfeB88Uog
	 mEbPo58CjbbiHmAYDnQ0ytgB6561NiUYWQowjTJhzyV7JDGBQSnofJk01WlBPNyXS+
	 6+YVc0VPRudIeyHntX/fplI34JGmb3OywfjHQ0Owj5fXXFaGOy1HDd5rZcM/I76P/2
	 ut3v3HAQPp+M9gvaMc8Yy7sBrDIPxjHa3nba+VjZzGaRoPl+WxEGj0dXQIgw+RJgp0
	 S+zwe/i92JWyzFNvNrKdBoMqLmj9C06fQWSyCwp/vLoptnQsktyxnXTtDgx8rSzLRL
	 yL5NIa92iDt6w==
Date: Wed, 20 Aug 2025 18:43:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET v5 00/12] perf annotate: Support --code-with-type on
 TUI
Message-ID: <aKZBZ2I04-p_Yl_m@x1>
References: <20250816031635.25318-1-namhyung@kernel.org>
 <aKZA5bE1ibDMJpuw@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKZA5bE1ibDMJpuw@x1>

On Wed, Aug 20, 2025 at 06:40:53PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 15, 2025 at 08:16:23PM -0700, Namhyung Kim wrote:
> > 
> > Hello,
> > 
> > The --code-with-type option is to show normal annotate output with type
> > information.  It was supported only on --stdio, but this change adds it
> > to TUI as well.
> > 
> > Arnaldo, please tell me if you still don't like the
> > __hist_entry__tui_annotate() but I don't have a better idea for now.
> 
> Not a problem, I tested everything, all seems to work as advertised.
> 
> The minor suggestions I made I can do while merging, if you don't mind
> and agree with them.

I mean the scope of a variable, a missing line before an if line, not
the other more involved one as the alignment of the type comments, etc.
:-)

- Arnaldo
 
> Please let me know.
> 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> - Arnaldo
>  
> > v5 changes)
> >  * use a copy of hist entry for perf top  (Ian)
> >  * split disasm_line__write() change  (Ian)
> >  * constify annotation_write_ops parameter  (Ian)
> >  * update printed length calculation  (Ian)
> >  * remove annotation_print_data.start
> >  * add a hashmap to skip duplicate processing
> > 
> > v4 changes)
> >  * add dso__debuginfo() helper  (Ian)
> > 
> > v3 changes)
> >  * hide stack operation and stack canary by default
> > 
> > v2 changes)
> >  * use 'T' key to toggle data type display  (Arnaldo)
> >  * display '[Type]' in the title line when it's enabled  (Arnaldo)
> >  * show warning when debug info is not available  (Arnaldo)
> >  * fix a typo  (Arnaldo)
> > 
> > Actually the command line option sets the default behavior and users can
> > change it by pressing 'T' key in the TUI annotate browser.
> > 
> > The code is also available at 'perf/annotate-code-type-tui-v5' branch at
> > https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> > Namhyung Kim (12):
> >   perf annotate: Rename to __hist_entry__tui_annotate()
> >   perf annotate: Remove annotation_print_data.start
> >   perf annotate: Remove __annotation_line__write()
> >   perf annotate: Pass annotation_print_data to annotation_line__write()
> >   perf annotate: Simplify width calculation in annotation_line__write()
> >   perf annotate: Return printed number from disasm_line__write()
> >   perf annotate: Add --code-with-type support for TUI
> >   perf annotate: Add 'T' hot key to toggle data type display
> >   perf annotate: Show warning when debuginfo is not available
> >   perf annotate: Hide data-type for stack operation and canary
> >   perf annotate: Add dso__debuginfo() helper
> >   perf annotate: Use a hashmap to save type data
> > 
> >  tools/perf/Documentation/perf-annotate.txt |   1 -
> >  tools/perf/builtin-annotate.c              |   5 -
> >  tools/perf/ui/browsers/annotate.c          | 117 ++++++++++++--
> >  tools/perf/ui/browsers/hists.c             |   2 +-
> >  tools/perf/util/annotate.c                 | 178 +++++++++++++++------
> >  tools/perf/util/annotate.h                 |  29 ++--
> >  tools/perf/util/dso.h                      |  21 +++
> >  tools/perf/util/hist.h                     |  12 +-
> >  8 files changed, 273 insertions(+), 92 deletions(-)
> > 
> > -- 
> > 2.50.1
