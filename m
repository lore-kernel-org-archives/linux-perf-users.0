Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EDD13AD03;
	Thu, 31 Oct 2024 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402422; cv=none; b=djjLY28aJXRvy8X/8N8kHtTUS5pqkoEAjWBzKM5t983ZPdEpaXyK/bZoyE2KHwzhuL3fonrCD29dMDKcurLXHs0x7A/tCEmHbsD8QKOzvKTEoKawjJ6mjUOOTUsi0XXBPsry8D+XmBJPgliXJmggB1lmniLBbeSiEuF6H4jv3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402422; c=relaxed/simple;
	bh=F5qUSVL7eKLwVT+0y5zs3mUKvspZfS9rfjmVIge0frw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htr3DUWGcmQg7dnDKOm6A1uSEoRNeFmCNnTA1JKJ94BD6Q3MSh8FR7nim66/mJ+h5bQ5D3q/T0y2zL9gxuKQkYZWVr5uO+rPrrIq2CSSUf9iqUxZpavBjcG42F92hh/gx3IcM926h/tOj38LeXsyiEb1EIMd/KWDiTNw1bEFxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX7P8Ml6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX7P8Ml6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B8AC4CEC3;
	Thu, 31 Oct 2024 19:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402422;
	bh=F5qUSVL7eKLwVT+0y5zs3mUKvspZfS9rfjmVIge0frw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oX7P8Ml6LK46LV4YRG78WB+d6TaPK9vuxpI7T9U2+Csc5i5M5Hh+LoS1LvQ0MthWH
	 2+/nZzaYHyR28DWyRGmmrzRcrvBW45RH2W63wHIcxFhZfAIObV0VYhMJsm5RxJZxHK
	 kwe/Vz5vWk4QbqtHuFb0WAinxMiXvsBTWW7sEl3HMwbv55MbiQAeDsfTHCxLj6brsE
	 DlJvONl1i99R+684B/58CpSH3HxSXbPa6KdNKPhW6IDvI7xPvRtST+wblQeHPTvi1U
	 9ydwawV4mja/5jefBiX2/LdFNTtiB30aJ6TtC3mROsTP+Q469lRtxoV08FTqQ2enDe
	 kdt56Dddri4gw==
Date: Thu, 31 Oct 2024 16:20:18 -0300
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
Subject: Re: [PATCH v5 04/21] perf script: Move scripting_max_stack out of
 builtin
Message-ID: <ZyPYck6mr17jS4uV@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-5-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:35PM -0700, Ian Rogers wrote:
> scripting_max_stack is used in util code which is linked into the
> python module. Move the variable declaration to
> util/trace-event-scripting.c to avoid conditional compilation.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-script.c             | 2 --
>  tools/perf/util/python.c                | 2 --
>  tools/perf/util/trace-event-scripting.c | 3 +++
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 6b6d4472db6e..5d5a1a06d8c6 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -92,8 +92,6 @@ static struct dlfilter		*dlfilter;
>  static int			dlargc;
>  static char			**dlargv;
>  
> -unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
> -
>  enum perf_output_field {
>  	PERF_OUTPUT_COMM            = 1ULL << 0,
>  	PERF_OUTPUT_TID             = 1ULL << 1,
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 974578a04099..298f43981fc5 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1306,8 +1306,6 @@ PyMODINIT_FUNC PyInit_perf(void)
>  /* The following are stubs to avoid dragging in builtin-* objects. */
>  /* TODO: move the code out of the builtin-* file into util. */
>  
> -unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
> -
>  bool kvm_entry_event(struct evsel *evsel __maybe_unused)
>  {
>  	return false;
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> index bd0000300c77..8abb7a7b6888 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -16,9 +16,12 @@
>  #include "debug.h"
>  #include "trace-event.h"
>  #include "evsel.h"
> +#include <linux/perf_event.h>
>  #include <linux/zalloc.h>
>  #include "util/sample.h"
>  
> +unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
> +
>  struct scripting_context *scripting_context;
>  
>  void scripting_context__update(struct scripting_context *c,
> -- 
> 2.47.0.163.g1226f6d8fa-goog
