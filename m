Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E341FBE9C;
	Thu, 13 Mar 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850947; cv=none; b=FFZsBYiUN297hh410+D2Q3ODlLlbQS45rBd6pwaTt9dBm42YfOKcOxk3QOGJLr+81INlrUTDALfS8xfEtNeQGa49TgxLGnNeMFEN2e8sS/tdz4wAhotg1mvVcuVgpZQeij3Z7kSuLogg7bn7X/bcBhsHm+qWkkt3NekD/JgFfjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850947; c=relaxed/simple;
	bh=bXd5Zvd7dZCJ4R1puUhsaSnoSdsh9qOuJCYZlCWoGgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jti9vEUTJoKX7SJty8uZoxC3N+F/1MwYrVlTDDwTpa4vR7pU/L6y+LjzlQDSdCoMMv53OAOWb4TD/rIa8IaOjSJoo/qIF2smC73BXWWduTm1bpRt27DAwMsvmjdciKPLz/TfxD80d+WbBJZlztqY1r2riwnor/BDoL/MSo3LwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw6NfMQk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw6NfMQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDF2C4CEDD;
	Thu, 13 Mar 2025 07:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741850947;
	bh=bXd5Zvd7dZCJ4R1puUhsaSnoSdsh9qOuJCYZlCWoGgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dw6NfMQko4STR5OR0+dkKeiLiHPVnPVIwaPlVHIXrgH/3QvFEp4FDClO9lW3KPBbo
	 XNYNgGRRu9VX2X/iw47GZ+v8N3O0jMdxo4Egj88CjCFiLkhgBaE4EeXfm0Xt8JaT3N
	 B4dw0g90oNdwfWgHb+tD4O7PrCxnUNEyk+Xcajep5EfUMRDuyG6HPS2IC3hGmLrVAf
	 97+oYBs2OwbmBJU2X5xDFvUD8nqdJtSG7n3BuMf1ZPcUmSpVBNAcaJ8zz4p/gHjTia
	 r+WZOwBAP/kdqFX1NnIFeH8q0CS6q4EkhEMD8sxpk09tAdacrLzMj0QempPAvCP+7o
	 sK0rCcYjRT1Tg==
Date: Thu, 13 Mar 2025 00:29:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 3/3] perf hist stdio: Do bounds check when printing
 callchains to avoid UB with new gcc versions
Message-ID: <Z9KJQdUkEel3OP1X@google.com>
References: <20250310194534.265487-1-acme@kernel.org>
 <20250310194534.265487-4-acme@kernel.org>
 <Z89f6JbpZUQoi2hR@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z89f6JbpZUQoi2hR@google.com>

On Mon, Mar 10, 2025 at 02:55:52PM -0700, Namhyung Kim wrote:
> On Mon, Mar 10, 2025 at 04:45:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Do a simple bounds check to avoid this on new gcc versions:
> > 
> >   31    15.81 fedora:rawhide                : FAIL gcc version 15.0.1 20250225 (Red Hat 15.0.1-0) (GCC)
> >     In function 'callchain__fprintf_left_margin',
> >         inlined from 'callchain__fprintf_graph.constprop' at ui/stdio/hist.c:246:12:
> >     ui/stdio/hist.c:27:39: error: iteration 2147483647 invokes undefined behavior [-Werror=aggressive-loop-optimizations]
> 
> Hmm.. does it warn about a signed integer overflow?
> 
> 2147483647 is 0x7fffffff in hex and it should be INT_MAX.
> I'm not sure what is the problem.

Maybe the aggressive loop optimization can unroll the loop more than the
INT_MAX...?  Anyway the fix is simple and makes sense.

> 
> 
> >        27 |         for (i = 0; i < left_margin; i++)
> >           |                                      ~^~
> >     ui/stdio/hist.c:27:23: note: within this loop
> >        27 |         for (i = 0; i < left_margin; i++)
> >           |                     ~~^~~~~~~~~~~~~
> >     cc1: all warnings being treated as errors
> >     --
> >     util/units.c: In function 'unit_number__scnprintf':
> >     util/units.c:67:24: error: initializer-string for array of 'char' is too long [-Werror=unterminated-string-initialization]
> >        67 |         char unit[4] = "BKMG";
> >           |                        ^~~~~~
> >     cc1: all warnings being treated as errors
> 
> This part belongs to the previous commit. :)

I'll drop this part.

Thanks,
Namhyung

> 
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/ui/stdio/hist.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
> > index 74b2c619c56c8ba3..7ac4b98e28bca82e 100644
> > --- a/tools/perf/ui/stdio/hist.c
> > +++ b/tools/perf/ui/stdio/hist.c
> > @@ -1,4 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#include <limits.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <linux/string.h>
> > @@ -24,6 +25,9 @@ static size_t callchain__fprintf_left_margin(FILE *fp, int left_margin)
> >  	int i;
> >  	int ret = fprintf(fp, "            ");
> >  
> > +	if (left_margin > USHRT_MAX)
> > +		left_margin = USHRT_MAX;
> > +
> >  	for (i = 0; i < left_margin; i++)
> >  		ret += fprintf(fp, " ");
> >  
> > -- 
> > 2.48.1
> > 
