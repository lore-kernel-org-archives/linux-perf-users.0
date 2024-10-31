Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0E1CB32A;
	Thu, 31 Oct 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402401; cv=none; b=bHzFELn/dlw+USI0AR4nY1sY39KoQcTcv/j18CGfB3y5n/IzWDT40Llz6gIfKFM6jFUAiBVU4qObYK0iSwJClBjFDvC8HFB7LapqoFTCD+fBpfCYiHmDNXZSDlD0hbc60UajLxFLT/TM2Jdfu9Hb1iLoolGEYd750Ss1PwGQbq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402401; c=relaxed/simple;
	bh=QFy9O6IaZMSEtd3GTV+0L27WTpq3fi3FtH6zYLLmmzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQkrZu03vL3QQ0xwRLFUnwgJQbAV9czt/y5xPgL1bvJMm18oAt91XPokzfqNXWGWyCzWyAQyLiXT8GiGvrKJUKJkwt+OHsCkbC3BfQ2MHEOWEOz9nj9d4ZbwHiIjZ5ZGFyUQHMS6L+UzuU/PsELm1Ho3LT35TyQAhVKK8iOqJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USC4OVyN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USC4OVyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF223C4CED2;
	Thu, 31 Oct 2024 19:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402400;
	bh=QFy9O6IaZMSEtd3GTV+0L27WTpq3fi3FtH6zYLLmmzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USC4OVyNY7cY6HBpw4dvNWS61VXM7JC5cjRWzEdsWv5He0JeMTBwh9JC5zAHC3VND
	 2dHd2OfLSgtkYjzUya6gNtj+33o3lA2/TGQPwFVdQUK3z5QMJEghVtDuOmz0hAEaLt
	 JQVqCs0C4+A+TZzwr2u3kER41X9wx6Bv2dVPJIuBvKyYbbXuOLYgVvkyouB7HPsFP7
	 lsO9nmNx2DT0QzHye7KNAsomnQzmQ8hzFb77Uvi0ZBXxNkvLVkqf+mieZwavMRv/mW
	 KE4uCYZiU98s4lRNUJgYNj/uNgfRCsbKwswtyxTl+2H4UZeiU4DO+7oeMM3IawQ0qa
	 gNz2b5BZejTqQ==
Date: Thu, 31 Oct 2024 16:19:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 03/21] perf python: Remove unused #include
Message-ID: <ZyPYXK79F5NTslE1@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-4-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:34PM -0700, Ian Rogers wrote:
> Remove unused #include of bpf-filter.h.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 13dad27169a0..974578a04099 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -16,7 +16,6 @@
>  #include "thread_map.h"
>  #include "trace-event.h"
>  #include "mmap.h"
> -#include "util/bpf-filter.h"
>  #include "util/env.h"
>  #include "util/kvm-stat.h"
>  #include "util/kwork.h"
> -- 
> 2.47.0.163.g1226f6d8fa-goog
