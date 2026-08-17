Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7CD3EEAE1;
	Mon, 17 Aug 2026 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006939; cv=none; b=K1w+zoLjA4FaoUbbaOVbwT1VXHToKbm9+7jucSRcsuqiS9m/O5rVKe5idAYkPiqpyxjA5CbCBfNhvMRP5b6vebd8Lb0jv20HApgOke1CmBljBrEFe0RMIfBeJ1eyjd5QPzsZqf5oz+HwaL3S/tsfdSIl7aEmpFc3PPTBaiwGHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006939; c=relaxed/simple;
	bh=Rm4h31BhS4s/CgvjaHyh+NGPJSF9YIq3VEGkFWfTq+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5cyqhXm8egJIE24x/n612hDJXJQS2az5FcdKPPVwFh1W7fHjOInh9kG70MBk+Qz+0PRPrbJhFSHx8X2AEgsitGO+NF1WeG4LvL3FUYnTDHcFm8HWKiA3hQHoCnqZ0QfkLQTvKGcW4phcBj5HB8idFc2nn2A5LkNFFcrO7P/eZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klQgqIFv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klQgqIFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8B41F000E9;
	Mon, 17 Aug 2026 22:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787006937;
	bh=RL807sVq3qR0rwCmLP3Mn8ZxHCBaHor53/d0KP2jXHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=klQgqIFvHNgyrYOJhctb1V55Bued0tF4ub25KZDeSV9U0eUIl8s593sTlq0glDlgw
	 5qT4gdOVHs1eKIyFSe2Klu0GIZrNm0Rej0AhBjgVeTyorzFsvICKzo8w+DXGC02NfG
	 lu+MyXuDWY4tlgrFUkyWsTMuqhqZtWwXCt+GN2pwZ6+gFvDpKw7jXzplXlDbw+ArT9
	 NjammwQd3cNvcqxm2mj9koBlj3/FYol7oH0ylC66LlYTgbOybtyXRLBaGS4NRjym45
	 ZJ+GoL0enyYDa9439De899Aiw7QAFj8TQ9IdhtTzMwIqnS6CRzBAyqInjco17wddWo
	 bV8WDcaYaYJCQ==
Date: Tue, 18 Aug 2026 07:48:56 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiebin Sun <jiebin.sun@intel.com>, acme@kernel.org, mingo@redhat.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/9] perf c2c: add function view model skeleton
Message-ID: <aoOP2P8EWYPzLy1V@google.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
 <20260817094623.3288456-3-jiebin.sun@intel.com>
 <CAP-5=fXbrgF1+bhYLxvr+JPQhs_9YrMkSjOx6QrncPj0CKABXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXbrgF1+bhYLxvr+JPQhs_9YrMkSjOx6QrncPj0CKABXA@mail.gmail.com>

Hello,

On Mon, Aug 17, 2026 at 01:53:46PM -0700, Ian Rogers wrote:
> On Mon, Aug 17, 2026 at 2:40 AM Jiebin Sun <jiebin.sun@intel.com> wrote:
> >
> > Add the initial common model for the c2c function view: model state and
> > small helpers shared by the hierarchy construction and formatting added
> > in later patches.
> >
> > Build the model from util/ so it remains independent of the TUI and
> > command-private symbols.
> >
> > Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Falcon <thomas.falcon@intel.com>
> > Reviewed-by: Tianyou Li <tianyou.li@intel.com>
> > Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> > ---
> >  tools/perf/util/Build          |  1 +
> >  tools/perf/util/c2c-function.c | 66 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 67 insertions(+)
> >  create mode 100644 tools/perf/util/c2c-function.c
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 1dfd92cbe3b7..b26a0b1ddfa3 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -12,6 +12,7 @@ perf-util-y += block-info.o
> >  perf-util-y += block-range.o
> >  perf-util-y += build-id.o
> >  perf-util-y += c2c.o
> > +perf-util-y += c2c-function.o
> >  perf-util-y += cacheline.o
> >  perf-util-$(CONFIG_LIBCAPSTONE) += capstone.o
> >  perf-util-y += config.o
> > diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-function.c
> > new file mode 100644
> > index 000000000000..ca82425a28dc
> > --- /dev/null
> > +++ b/tools/perf/util/c2c-function.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * C2C function model - function-level cacheline sharing analysis
> > + *
> > + * Displays a 3-level hierarchy showing which functions share cachelines:
> > + *   Level 1: Read-side functions sorted by Cycles % (estimated load cycles)
> > + *   Level 2: Functions sampled writing the shared lines read by level 1
> > + *   Level 3: The specific cachelines where the two functions contend
> > + *
> > + * Builds the hierarchy from the existing cacheline histograms
> > + * (c2c_hist_entry->hists), reusing the shared c2c data structures.
> > + */
> > +
> > +#include <errno.h>
> > +#include <inttypes.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <tools/libc_compat.h> /* reallocarray */
> > +#include <linux/list.h>
> > +#include <linux/rbtree.h>
> > +#include <linux/zalloc.h>
> > +
> > +#include "addr_location.h"
> > +#include "c2c.h"
> > +#include "cacheline.h"
> > +#include "hist.h"
> > +#include "map.h"
> > +#include "mem-events.h"
> > +#include "mem-info.h"
> > +#include "sort.h"
> > +#include "symbol.h"
> > +#include "thread.h"
> 
> nit: the number of #includes is somewhat generous here. I presume
> later patches will require these includes. To avoid everything
> depending on everything else it would be nice to use forward
> declarations when possible. For example, if the only reason for
> including the header file was to use a struct's name where it is
> passed as a pointer in a function declaration, ie in header files
> prefer:
> 
>   struct map;
>   int foo(struct map *m);
> 
> over
> 
>   #include "map.h"
>   int foo(struct map *m);

I think they are actually used in the later patches in this series.

> 
> > +
> > +struct c2c_function_model {
> > +       struct c2c_hists        function_hists;
> > +       /* Total estimated cycles across all level-1 entries. */
> > +       u64                     total_cycles;
> > +       /* Source cacheline histograms; not owned here. */
> > +       struct c2c_hists        *cl_hists;
> > +       /* --coalesce field list, used to require iaddr. */
> > +       const char              *cl_sort;
> > +       /* Do not cap long symbol names. */
> > +       bool                     symbol_full;
> > +};
> > +
> > +static struct c2c_function_model c2c_ext __maybe_unused;
> > +
> > +static inline __maybe_unused u64 c2c_hitm_count(const struct c2c_stats *stats)
> > +{
> > +       return stats->tot_hitm;
> > +}
> > +
> > +static inline __maybe_unused bool symbol_name_equal(struct symbol *a, struct symbol *b)
> > +{
> > +       /* Two unknown symbols compare equal, matching cmp_null() in util/sort.c. */
> > +       if (!a || !b)
> > +               return a == b;
> > +       return arch__compare_symbol_names(a->name, b->name) == 0;
> 
> Sashiko rightly flagged this as not being cross-platform compatible,
> but this is a pre-existing issue that looks relatively easy to clean
> up but only really impacts PowerPC and so is hard for me to test. I'll
> try to do it anyway.

Thanks for your review.  Yep, I think it can be handled separately.

Namhyung

> 
> > +}
> > +
> > +static inline __maybe_unused u64 hist_entry__iaddr(struct hist_entry *he)
> > +{
> > +       if (he->mem_info)
> > +               return mem_info__iaddr(he->mem_info)->addr;
> > +       return he->ip;
> > +}
> > --
> > 2.52.0
> >
