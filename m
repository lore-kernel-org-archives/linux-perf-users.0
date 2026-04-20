Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FA76FC5
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644068; cv=none; b=PP8c0LGgZzqaA5WQmxZRmVsKXVhIQvUj/ybts/YyIKJ6P0M3f+aKMRChXblUOv0AMyEl/ocUg5hMF6YbTN5DHJhomoWF8ihORXSmoz4zyXDEEKbfsBnf8EPU5SxbLvmlrzLck1tNFrKscKH+pkcjMdQhjvXT5de1dJZuU0RdCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644068; c=relaxed/simple;
	bh=JIAeJOHO0R9iz2gQgZyktMWe4rnyQpbWffON7H6mt5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzt7SQBZx97nthIQ//2jWccGbGbsiA4hAfnhvZG82M0WV6BPk37pdRwMm7n59vUhGk9kiMkNQkzhTbSGfXqlw9VcjLxV4RAMPy83WRU6eNpo8Cn4H3d79khb6N3IEit0tj2jkKEQJjR0ryK/Ww2YPt0hhh6SmhdcafpkgcCGLEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obBy16yl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obBy16yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DD8C2BCAF;
	Mon, 20 Apr 2026 00:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776644068;
	bh=JIAeJOHO0R9iz2gQgZyktMWe4rnyQpbWffON7H6mt5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=obBy16yluZBs3wEGw+05AtT0cX54iV9swB7Bp9oGX90l+cb2LA/wuKk/E+DRKe6yc
	 2m+I/vS0u+5tbKpnTiRsE6VE3vhfObTNu+yB+YSL0TvPKMk+O6pNsny2oQAN80NoFF
	 t0rS4WYa9KQNd0hdA6ngCJffNL6gDVrWJpc/cByfE0MOu08cMm8RG4CIApcbhY6hHD
	 XbuACBJICiPTf64zYq+TqH1kWJkcEofUk92LtjXVw5T6DN7VRLup0eYpW+SKJJ41/M
	 uIsySosQufShJ/wkEfkXh0DjuAD2yH3t6pQTE0lwPEgGZemWWnZqLcqpEtcVFo2exh
	 7Y2ohGp1ObLDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/58] perf evsel/evlist: Avoid unnecessary #includes
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-9-irogers@google.com>
References: <20260419235911.2186050-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:14:27 +0000
Message-Id: <20260420001428.26DD8C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Redundant forward declaration and commit message inaccuracies.
--

commit c0d219d10c45c703a1eae6877283598fe6fc4805
Author: Ian Rogers <irogers@google.com>

perf evsel/evlist: Avoid unnecessary #includes

This commit attempts to reduce header dependencies by using forward
declarations and removing unnecessary includes in evsel.h and evlist.h,
while also sorting the forward declarations.

> Use forward declarations and remove unnecessary #includes in evsel.h
> and evlist.h. Sort the forward declaration.s

This isn't a bug, but there is a typo (declaration.s) at the end of the
commit message.

Also, looking at the diff for evlist.h, it appears the includes were merely
reordered rather than removed. Is the commit message accurate regarding
removing unnecessary includes in evlist.h?

> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index e507f5f20ef61..69784787da486 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h

[ ... ]

>  #include <api/fd/array.h>
>  #include <internal/evlist.h>
>  #include <internal/evsel.h>
>  #include <perf/evlist.h>
> +
>  #include "affinity.h"
>  #include "events_stats.h"
>  #include "evsel.h"
>  #include "rblist.h"
> -#include <pthread.h>
> -#include <signal.h>
> -#include <unistd.h>
> =20
> -struct pollfd;
> -struct thread_map;
> +struct evsel;

Is this forward declaration for struct evsel needed? Since evsel.h is still
included a few lines above, the forward declaration appears to be redundant.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D8
