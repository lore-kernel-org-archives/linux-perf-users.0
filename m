Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102931F999;
	Mon, 25 May 2026 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779709583; cv=none; b=srCPm+qv6oHdGWai4I9kzuJyRmXsCy9IcYY6GjLOMRWBgTsaHDrkYEsO2kS2mu7jgtyJd7F7aE24UpmMo8QxC3f5pnVCqFSUah6vEOcaPAIVTjn5joHr+ArLReSlKH9SumXfxk+sHuekUhK8Pc2EHFnjApmBK5nWOI8M+zyqp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779709583; c=relaxed/simple;
	bh=KCxFtCOIeO6j/U2jIdYhsf33DsAK8s6KeZQC7GzokQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yp4e3+rlw9GB0noj7rg56d83UmAZh9BmIJvl22liIRMAk1ZypJcCtN5jgRrdsQ52Ovx85ki2+EarblTEcVSO+xslElnvOmfH+cXZs4QuvBRu2FSAwNeF+Ax6hv3tAwKDYkdv84litG1EHW7AOdTuEjm6wYFU4P/ZEa5SMn7NKzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWPDiik6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWPDiik6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C8C1F000E9;
	Mon, 25 May 2026 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779709581;
	bh=mYd4gJtdtUVKRaSvEZKRfv4z5xfoRFCDZrzzDzpR470=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iWPDiik65jZKIp2K8lZY8yBEgzM5fYk2kegCd2PWl7QdFN0q2sfAcGGl8RBhW78yz
	 y4sX/vcuaPys7ze41reqhesh1/03WgOSjI/+dLHCZwMI3KCKpKTrU48vYbTawcrYjK
	 uHpyuoe3q1q2LyAj+keZlSqOFlE+m/BgUahevKLoNvPCnpv1XLfEVuu3N/1QwhoFy3
	 7SeUlKJD7icqqP0kWjS84CS6hFrBWcK4ykoDon0AHUMQWElbFa8gNIX5m6hBZpUz/C
	 RnKb0v+lvKFQbtEF2YR72KthgjPsgixEkELWznftJRVbNnkXWVFajU/vLA09r3RTqH
	 YO6K+EYRlQfDw==
Date: Mon, 25 May 2026 08:46:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf trace: Include copied headers in the beauty
 directory
Message-ID: <ahQ2iko9pk1VDkdx@x1>
References: <20260525011133.179130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525011133.179130-1-namhyung@kernel.org>

On Sun, May 24, 2026 at 06:11:31PM -0700, Namhyung Kim wrote:
> We keep uptodate copied of the kernel headers, let's use it directly and
> don't worry about missing definitions.

Using it directly with the latest header, when reasonable, is indeed
better than having those conditional defines.

Sometimes it is warranted as having the latest headers may involve
dragging many files (header dependencies) into the tools/include/ copy
of kernel headers we try to keep in sync.

> +++ b/tools/perf/trace/beauty/fcntl.c
> @@ -5,25 +5,10 @@
>   *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
>   */

<SNIP>

> -#ifndef F_GET_FILE_RW_HINT
> -#define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
> -#endif
> +#include "trace/beauty/beauty.h"
> +#include "trace/beauty/include/uapi/linux/fcntl.h"

The intention isn't documented anywhere, but files in
trace/beauty/include/uapi were not intended to be used in compiling,
just scraping, i.e. it didn't need to be compileable, no need to have
things it includes in turn nor have defines in Makefiles, it would just
be used by the scripts to extract info from it, info that otherwise
isn't available as enums (which they should, but that is a digression)
or as BTF (which would be even better).

Things for compiling would remain in tools/include/, as other tools may
need them and then the maintainainace of these headers would be shared
to some degree.

Otherwise each and every tools/ living code that needed copies of header
files would end up with its own copy, which seems excessive.

What do you think?

- Arnaldo
  
> -#ifndef F_SET_FILE_RW_HINT
> -#define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
> -#endif
