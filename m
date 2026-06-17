Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745425C80E;
	Wed, 17 Jun 2026 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714175; cv=none; b=DCe1iYG2x9l1Ksdte5HCtp8na8ji/sjhull2acILfLI39pkUvOy5ijkBvpG25TNhgSolChQq+PBaCGcllLqY/DWqPBOq/hwCaJIFW671rWI8kiaar7OrYmG8X6pZxQ2xuyIM1Fb/RttUYqfZj6lvTZQ3Vb3fkRs+S0s6ycYGO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714175; c=relaxed/simple;
	bh=xbLRRL2K4v97ic0CcW1ES7aykW8oSsL8P7jP9mPrg0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNG++WtZR50SjMrwZgs7o3lXMqKGRpOMUJYAhsq7RKA+fEw8mRFFwsz2lpJPtmCUkH7fBWVNcmc3jnPFIl9y+URhnFEt7jhcKKQQNQm+z2yKxOK8n5xNNFBD6kwg4WGGj0eTIfI7gR9uR6Rw2UsAgD9NNCJtuPpqhrfJ6tGXNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD+m7O+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD+m7O+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55F41F000E9;
	Wed, 17 Jun 2026 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781714172;
	bh=2QQlDWV6mbNjLVMhUAuDKm4aZrJTpf6CYkxKGnYpNyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TD+m7O+I+Z4lV0HfgFO5E+31N4J2XEUFcg3eNmZQ3pen/SJTxlylrM5vlgngHzzjn
	 8KbJJyjHm0xeF3aGLK+rQfuLmRD6LJfYRIs2aZ7TNU5kng3T5X53vCRyrLJi+Nyc2k
	 bsyyodDP5atxbQMhRFmAb3EIcIVbw+XSyJuVkaWICYcCMODUEAYf9eg68yg1grLnJh
	 C6OddYcMAz0BdwnU4oo5/lj9x2BDoS1aXEzUxGjN4SAu18In2GqigMcGYke79FJjc/
	 q8v+O2P6hZ3fslu3twz/uPMWKP0RgcqLV5SAbxD3zqrUkVNZZtAr76omqP40qzT0KH
	 AlL7yYxjD3nog==
Date: Wed, 17 Jun 2026 13:36:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com,
	alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, leo.yan@linux.dev,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v21 03/21] perf evsel/evlist: Avoid unnecessary #includes
Message-ID: <ajLM-d58lwP7C1Iu@x1>
References: <20260615223011.3873955-1-irogers@google.com>
 <20260616011543.4037138-1-irogers@google.com>
 <20260616011543.4037138-4-irogers@google.com>
 <ajLGZBOPNraF3Fj3@x1>
 <CAP-5=fWPgRn-Oa=9h367xbciDFeWBPkWfSji3qydwQ1nf08gaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWPgRn-Oa=9h367xbciDFeWBPkWfSji3qydwQ1nf08gaw@mail.gmail.com>

On Wed, Jun 17, 2026 at 09:23:52AM -0700, Ian Rogers wrote:
> On Wed, Jun 17, 2026 at 9:08 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Jun 15, 2026 at 06:15:25PM -0700, Ian Rogers wrote:
> > > Use forward declarations and remove unnecessary #includes in
> > > evsel.h. Sort the forward declarations in evsel.h and evlist.h. Move
> > > some PMU code into evsel.c.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > ⬢ [acme@toolbx perf-tools-next2]$ git log --oneline -5
> > ce69f4f6d7467ef4 (HEAD) perf evsel/evlist: Avoid unnecessary #includes
> > 23dce143f5ed0557 perf python: Add missed explicit dependencies
> > ca74d08280ad690f perf util: Sort includes and add missed explicit dependencies
> > 776bd9ac834556ab (x1/perf-tools-next, perf-tools-next.korg/tmp.perf-tools-next, perf-tools-next.korg/perf-tools-next, origin/perf-tools-next) perf bpf: Fix up build failure due to change of btf_vlen() return type
> > 522ae978ac720a91 (origin/perf/hardening-9) perf dso: Set standard errno on decompression failure
> > ⬢ [acme@toolbx perf-tools-next2]$
> >
> >   LD      /tmp/build/perf-tools-next2/util/scripting-engines/perf-util-in.o
> > make[3]: *** [/home/acme/git/perf-tools-next2/tools/build/Makefile.build:158: util] Error 2
> > make[2]: *** [Makefile.perf:573: /tmp/build/perf-tools-next2/perf-util-in.o] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> >   LD      /tmp/build/perf-tools-next2/tests/perf-test-in.o
> >   LD      /tmp/build/perf-tools-next2/perf-test-in.o
> >   LD      /tmp/build/perf-tools-next2/perf-in.o
> > make[1]: *** [Makefile.perf:288: sub-make] Error 2
> > make: *** [Makefile:122: install-bin] Error 2
> > make: Leaving directory '/home/acme/git/perf-tools-next2/tools/perf'
> > ⬢ [acme@toolbx perf-tools-next2]$
> >
> > I added this to fix the build:
> >
> > ⬢ [acme@toolbx perf-tools-next2]$ git diff
> > diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> > index 6a7542e7db827d1b..027695d967798487 100644
> > --- a/tools/perf/util/aslr.c
> > +++ b/tools/perf/util/aslr.c
> > @@ -13,6 +13,7 @@
> >  #include "session.h"
> >  #include "data.h"
> >  #include "dso.h"
> > +#include "pmu.h"
> >  #include "pmus.h"
> >
> >  #include <internal/lib.h>  /* page_size */
> > ⬢ [acme@toolbx perf-tools-next2]$
> >
> > Applied the series, now testing.
> 
> Thanks, I'd found the same aslr issue but was testing with fixing the
> wider issues you raised. Presumably the aslr code was depending on the
> the #include via evsel.h and so cleaning those up broke the build as
> the aslr code needed a fix.
> 
> Thanks for testing, I can rebase my fixes on top of the v21 changes
> assuming testing goes ok.

Since 7.1 was already released I'm inclined to push what I have, your
v21 series + this simple fix, so that it can sit in linux-next for a few
days and you would send fixes on top of it, ok?

I'm basically stopping merging patch series and switching to processing
just fixes so that I can send the PR to Linus by the end of this week.

I'll push what I have to tmp.perf-tools-next now.

- Arnaldo
