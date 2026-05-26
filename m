Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BBB48CFC;
	Tue, 26 May 2026 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779754487; cv=none; b=hS3iUpXH9zLPe7iWXNoGFwNpxbIwnySWUr8bwmqJ8OayuxKzARkEOQ4/NM1jEHk6lkASuvDIaw+AkshSw301m6DdaR0HyXyWOXkmkS55fRIC0BBEXzC/vRsCUqfHobdMyuzDfHntxBX+okFHPdzjBH1zlc04v4QHbs6Un+UIHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779754487; c=relaxed/simple;
	bh=e2IvYpQdP8NEDr96lSatZTaUKj5e/qN2hO5HNVXVmJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5ZGTGk8MlhPAFjV4qglgms5VZhf9shtyCRPYpdIoijHszao+7lLw8hqFG6i37QUq48Ra6j7YxvK0LEyCZOihZKu2SzyCKeyZ/P74wA8+nTkFK+GK/nzNYgNK3KwrTYvKWhzIpCyfYdQ9nXqyrgfVWbJHhn4HkOz2iORsSH0Doc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUpEcjsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUpEcjsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6881F00A3A;
	Tue, 26 May 2026 00:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779754486;
	bh=bx8X5dzuoL+Aic7Dx8uX2SxZJf4uB+s2hvhH3ODUm5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mUpEcjsyojkXG2Z4WfE7AY5Irq0fkyqgg/JXwwmjNewA9HzDFTGBo1IjSOl6rehg7
	 VOfUp09VCqwO2jyqum3EA6G1p1L1K1bxA0Anc/EVbGLzAmDMZhH2kCi4NFW6jG8/Ny
	 EZM/nltjoD3+U5m8+uXQIMLqzlylOlAGrtUrvlgUYJ9qeUC64Lx/X2vw6V1V4KqVAK
	 6LhLZJVzywbXpLAFzk8ZGjKnnwOMTfcSah5Xuf8RwRup4XVEIg6R2L3QZkJ3eCrdVB
	 f9AjqZs7luaWsRt7SmpeHVzEoICt+r6iju9P2aGA7D32es+JmrSmOVAjyFI8ep9Rz4
	 nMPhFQ+emC09A==
Date: Mon, 25 May 2026 19:14:42 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf trace: Include copied headers in the beauty
 directory
Message-ID: <ahTl8o0B3eLZpZu6@google.com>
References: <20260525011133.179130-1-namhyung@kernel.org>
 <ahQ2iko9pk1VDkdx@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ahQ2iko9pk1VDkdx@x1>

On Mon, May 25, 2026 at 08:46:18AM -0300, Arnaldo Carvalho de Melo wrote:
> On Sun, May 24, 2026 at 06:11:31PM -0700, Namhyung Kim wrote:
> > We keep uptodate copied of the kernel headers, let's use it directly and
> > don't worry about missing definitions.
> 
> Using it directly with the latest header, when reasonable, is indeed
> better than having those conditional defines.
> 
> Sometimes it is warranted as having the latest headers may involve
> dragging many files (header dependencies) into the tools/include/ copy
> of kernel headers we try to keep in sync.
> 
> > +++ b/tools/perf/trace/beauty/fcntl.c
> > @@ -5,25 +5,10 @@
> >   *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
> >   */
> 
> <SNIP>
> 
> > -#ifndef F_GET_FILE_RW_HINT
> > -#define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
> > -#endif
> > +#include "trace/beauty/beauty.h"
> > +#include "trace/beauty/include/uapi/linux/fcntl.h"
> 
> The intention isn't documented anywhere, but files in
> trace/beauty/include/uapi were not intended to be used in compiling,
> just scraping, i.e. it didn't need to be compileable, no need to have
> things it includes in turn nor have defines in Makefiles, it would just
> be used by the scripts to extract info from it, info that otherwise
> isn't available as enums (which they should, but that is a digression)
> or as BTF (which would be even better).
> 
> Things for compiling would remain in tools/include/, as other tools may
> need them and then the maintainainace of these headers would be shared
> to some degree.
> 
> Otherwise each and every tools/ living code that needed copies of header
> files would end up with its own copy, which seems excessive.
> 
> What do you think?

Yep, makes sense.  I'll try to find a way to use them without including.

Thanks,
Namhyung

