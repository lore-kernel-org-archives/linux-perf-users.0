Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C582741C2;
	Fri, 25 Apr 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593948; cv=none; b=PvmaX/xkC7akXJvKYZPZ7VXM+Q5z14dAYE7tNVleNGOba0gzP2B5m3BcGyyuYgISq3ptDOH8CklJ3WRP8+n6pwKSnWkDsjBdcwvuJAQikOvFGmK6T14j5uw4cvpUA7q8lwf43CZ1tcIls3bNcSYAlGxsgqn985eCkoYiAn/3/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593948; c=relaxed/simple;
	bh=k2dlEjW6bN02EsPsXZP+WGuAK1XkqzdWBG/Yeze9+j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajBVi08jST8f9Z3ScJFtGgAj7kW0Raxj8GjUdQkYigYPRISoGm9OB9mLsgwgvToJ1GzXAPK+1u2UxllUGE/+F+JgTVSjOTBvQfMdp86pAspn/MvAYxZFw60O+L4WEN1prlrRkHe28AC0bzcovLlSvTnTGXlcHwXfFeR47u6gdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPu5hOPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPu5hOPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D668AC4CEE8;
	Fri, 25 Apr 2025 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745593948;
	bh=k2dlEjW6bN02EsPsXZP+WGuAK1XkqzdWBG/Yeze9+j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPu5hOPvekUKrQ8NrtZfaTIhpMWEA58RcxLRWr/rEG8Am2Ienbfqm0UECzivtl3M7
	 j9DZu54zUgRiRRcqJdTD39IsJYXFDJskuxktOj3VisE6ykt3bqQ/+LeLr+NDrr6AFD
	 Gus0XSgED4bjV3vYLHtuUDoK7a6qNYmuZHNBd32RGgtzouzZz06f+D/LtVBePdb9WN
	 5VOruMAKK+3OxnSW50ZgIHn9rZfej92CwhivqHeewasZH6CpvL0uU4J6F0qTvYi6S+
	 pNbAIIPnvQT2/6jYL7/kYlbrJTUJbYrznd/sSdFhUPUx9ssnF0J1hUc9zQ9ja4u1HZ
	 Kn+JibzISQe3Q==
Date: Fri, 25 Apr 2025 12:12:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	James Clark <james.clark@linaro.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zixian Cai <fzczx123@gmail.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Martin Liska <martin.liska@hey.com>,
	Martin =?utf-8?B?TGnFoWth?= <m.liska@foxlink.cz>,
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] perf jitdump: Directly mark the jitdump DSO
Message-ID: <aAumWUWXB05qLez6@x1>
References: <20250424195831.1767457-1-irogers@google.com>
 <20250424195831.1767457-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424195831.1767457-3-irogers@google.com>

On Thu, Apr 24, 2025 at 12:58:25PM -0700, Ian Rogers wrote:
> The DSO being generated was being accessed through a thread's maps,
> this is unnecessary as the dso can just be directly found. This avoids
> problems with passing a NULL evsel which may be inspected to determine
> properties of a callchain when using the buildid DSO marking code.

And this patch had to be moved after:

"perf dso: Move build_id to dso_id"

As it uses fields that were introduced there.

Thanks,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/jitdump.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 624964f01b5f..b062b1f234b6 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -14,9 +14,9 @@
>  #include <sys/mman.h>
>  #include <linux/stringify.h>
>  
> -#include "build-id.h"
>  #include "event.h"
>  #include "debug.h"
> +#include "dso.h"
>  #include "evlist.h"
>  #include "namespaces.h"
>  #include "symbol.h"
> @@ -531,9 +531,22 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
>  	/*
>  	 * mark dso as use to generate buildid in the header
>  	 */
> -	if (!ret)
> -		build_id__mark_dso_hit(tool, event, &sample, NULL, jd->machine);
> -
> +	if (!ret) {
> +		struct dso_id dso_id = {
> +			{
> +				.maj = event->mmap2.maj,
> +				.min = event->mmap2.min,
> +				.ino = event->mmap2.ino,
> +				.ino_generation = event->mmap2.ino_generation,
> +			},
> +			.mmap2_valid = true,
> +			.mmap2_ino_generation_valid = true,
> +		};
> +		struct dso *dso = machine__findnew_dso_id(jd->machine, filename, &dso_id);
> +
> +		if (dso)
> +			dso__set_hit(dso);
> +	}
>  out:
>  	perf_sample__exit(&sample);
>  	free(event);
> -- 
> 2.49.0.850.g28803427d3-goog
