Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E972608;
	Wed, 23 Jul 2025 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297067; cv=none; b=hoCPzV2V+Eg6lEhkDwh0UcWSuwqijZCOg1JbrYLEQH7zO/trfREhHdJQl8TiacZhLmE35qAv4IoFwG811PUGJw8q0k5RrwEzEa5aodvTeBjv/CqQNpJg06RvxirYwO39l2bomNelixvB3NHa+D9Bmtj0De/CujHZAZanbkRSQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297067; c=relaxed/simple;
	bh=j8XKfedFYcUm22+b5RV+OnieIZHRwYbb5ZLgayTvYNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Piq5mCxRO8kjv5EJav6VJUBP/2xh7EUd5v7R3b1ORxwcK4m5RGgtIJU7NuRzZivHTrLtxGiA1WMC/0O15vmDkgRPL9S4BcRsjbnuU7I96GJLeej5wpr29ysitsRsD/M10/zljgyystNUxkoS0Ql/MyzmMTxxNGNYmvRc1le3wZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpLZ/w0T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpLZ/w0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788C2C4CEE7;
	Wed, 23 Jul 2025 18:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753297067;
	bh=j8XKfedFYcUm22+b5RV+OnieIZHRwYbb5ZLgayTvYNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpLZ/w0Tu9BpExuMQzpEErvVFe2PyvoB+u3oEBldPdPLsc/DT01VbLwdDzt9Uc56r
	 mAGE4zizF2YFIcMyVHfP+qDoP2kQUlMY1xBkMUEWsxUu/x1t2FEmSk6SCD00+oAb1R
	 apNfRHBINyvd05YYUiTA8Rmi9bg5Lp+F3zfNXRRN0dvaE+9/V7ipEgfTxIOhqWn1aD
	 gDsdPfw7vuCJFbATR8i5OfS7s+n5VDrYoD9bWcB+9YzVfcniAzqrbJtViaM8VOzZqS
	 LeaHndO9admHKgiTqyXBZKUErA64FhpNQYzwswvnAzObOtme6qznUFtoExX++oxhcl
	 VXKHAyyMJh7Vw==
Date: Wed, 23 Jul 2025 15:57:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 05/16] perf tp_pmu: Add event APIs
Message-ID: <aIEwqAGFvAuUtiah@x1>
References: <20250714164405.111477-1-irogers@google.com>
 <20250714164405.111477-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714164405.111477-6-irogers@google.com>

On Mon, Jul 14, 2025 at 09:43:53AM -0700, Ian Rogers wrote:
> Add event APIs for the tracepoint PMU allowing things like perf list
> to function using it. For perf list add the tracepoint format in the
> long description (shown with -v).
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c    |   7 +++
>  tools/perf/util/tp_pmu.c | 114 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/tp_pmu.h |   7 +++
>  3 files changed, 128 insertions(+)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index b09b2ea2407a..dc05233e8232 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -24,6 +24,7 @@
>  #include "hwmon_pmu.h"
>  #include "pmus.h"
>  #include "tool_pmu.h"
> +#include "tp_pmu.h"
>  #include <util/pmu-bison.h>
>  #include <util/pmu-flex.h>
>  #include "parse-events.h"
> @@ -1983,6 +1984,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
>  		return false;
>  	if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
>  		return false;
> +	if (perf_pmu__is_tracepoint(pmu))
> +		return tp_pmu__have_event(pmu, name);
>  	if (perf_pmu__is_hwmon(pmu))
>  		return hwmon_pmu__have_event(pmu, name);
>  	if (perf_pmu__is_drm(pmu))
> @@ -1998,6 +2001,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>  {
>  	size_t nr;
>  
> +	if (perf_pmu__is_tracepoint(pmu))
> +		return tp_pmu__num_events(pmu);
>  	if (perf_pmu__is_hwmon(pmu))
>  		return hwmon_pmu__num_events(pmu);
>  	if (perf_pmu__is_drm(pmu))
> @@ -2068,6 +2073,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  	struct hashmap_entry *entry;
>  	size_t bkt;
>  
> +	if (perf_pmu__is_tracepoint(pmu))
> +		return tp_pmu__for_each_event(pmu, state, cb);
>  	if (perf_pmu__is_hwmon(pmu))
>  		return hwmon_pmu__for_each_event(pmu, state, cb);
>  	if (perf_pmu__is_drm(pmu))
> diff --git a/tools/perf/util/tp_pmu.c b/tools/perf/util/tp_pmu.c
> index fd83164f8763..9d68a1da17f6 100644
> --- a/tools/perf/util/tp_pmu.c
> +++ b/tools/perf/util/tp_pmu.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  #include "tp_pmu.h"
> +#include "pmus.h"
>  #include <api/fs/fs.h>
>  #include <api/fs/tracing_path.h>
>  #include <api/io_dir.h>
> @@ -93,3 +94,116 @@ int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb)
>  	close(events_dir.dirfd);
>  	return ret;
>  }
> +
> +bool perf_pmu__is_tracepoint(const struct perf_pmu *pmu)
> +{
> +	return pmu->type == PERF_TYPE_TRACEPOINT;
> +}
> +
> +struct for_each_event_args {
> +	void *state;
> +	pmu_event_callback cb;
> +	const struct perf_pmu *pmu;
> +};
> +
> +static int for_each_event_cb(void *state, const char *sys_name, const char *evt_name)
> +{
> +	struct for_each_event_args *args = state;
> +	char name[2 * FILENAME_MAX + 2];
> +	/* 16 possible hex digits and 22 other characters and \0. */
> +	char encoding[16 + 22];
> +	char *format = NULL;
> +	size_t format_size;
> +	struct pmu_event_info info = {
> +		.pmu = args->pmu,
> +		.pmu_name = args->pmu->name,
> +		.event_type_desc = "Tracepoint event",
> +	};
> +	char *tp_dir = get_events_file(sys_name);
> +	char path[PATH_MAX];
> +	int id, err;
> +
> +	if (!tp_dir)
> +		return -1;
> +
> +	scnprintf(path, sizeof(path), "%s/%s/id", tp_dir, evt_name);
> +	err = filename__read_int(path, &id);
> +	if (err == 0) {
> +		snprintf(encoding, sizeof(encoding), "tracepoint/config=0x%x/", id);
> +		info.encoding_desc = encoding;
> +	}
> +
> +	scnprintf(path, sizeof(path), "%s/%s/format", tp_dir, evt_name);
> +	put_events_file(tp_dir);
> +	err = filename__read_str(path, &format, &format_size);
> +	if (err == 0) {
> +		info.long_desc = format;
> +		for (size_t i = 0 ; i < format_size; i++) {
> +			/* Swap tabs to spaces due to some rendering issues. */
> +			if (format[i] == '\t')
> +				format[i] = ' ';
> +		}
> +	}
> +	snprintf(name, sizeof(name), "%s:%s", sys_name, evt_name);
> +	info.name = name;
> +	err = args->cb(args->state, &info);
> +	free(format);
> +	return err;
> +}
> +
> +static int for_each_event_sys_cb(void *state, const char *sys_name)
> +{
> +	return tp_pmu__for_each_tp_event(sys_name, state, for_each_event_cb);
> +}
> +
> +int tp_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
> +{
> +	struct for_each_event_args args = {
> +		.state = state,
> +		.cb = cb,
> +		.pmu = pmu,
> +	};
> +
> +	return tp_pmu__for_each_tp_sys(&args, for_each_event_sys_cb);
> +}
> +
> +static int num_events_cb(void *state, const char *sys_name __maybe_unused,
> +			 const char *evt_name __maybe_unused)
> +{
> +	size_t *count = state;
> +
> +	(*count)++;
> +	return 0;
> +}
> +
> +static int num_events_sys_cb(void *state, const char *sys_name)
> +{
> +	return tp_pmu__for_each_tp_event(sys_name, state, num_events_cb);
> +}
> +
> +size_t tp_pmu__num_events(struct perf_pmu *pmu __maybe_unused)
> +{
> +	size_t count = 0;
> +
> +	tp_pmu__for_each_tp_sys(&count, num_events_sys_cb);
> +	return count;
> +}
> +
> +bool tp_pmu__have_event(struct perf_pmu *pmu __maybe_unused, const char *name)
> +{
> +	char *dup_name, *colon;
> +	int id;
> +
> +	if (strchr(name, ':') == NULL)
> +		return false;

Nit:

	colon = strchr(name, ':');
	if (colon == NULL)
		return false;

> +
> +	dup_name = strdup(name);
> +	if (!dup_name)
> +		return false;
> +
> +	colon = strchr(dup_name, ':');

	colon = dup_name + (colon - name);

> +	*colon = '\0';
> +	id = tp_pmu__id(dup_name, colon + 1);
> +	free(dup_name);
> +	return id >= 0;
> +}
> diff --git a/tools/perf/util/tp_pmu.h b/tools/perf/util/tp_pmu.h
> index 49537303bd73..30456bd6943d 100644
> --- a/tools/perf/util/tp_pmu.h
> +++ b/tools/perf/util/tp_pmu.h
> @@ -2,6 +2,8 @@
>  #ifndef __TP_PMU_H
>  #define __TP_PMU_H
>  
> +#include "pmu.h"
> +
>  typedef int (*tp_sys_callback)(void *state, const char *sys_name);
>  typedef int (*tp_event_callback)(void *state, const char *sys_name, const char *evt_name);
>  
> @@ -9,4 +11,9 @@ int tp_pmu__id(const char *sys, const char *name);
>  int tp_pmu__for_each_tp_event(const char *sys, void *state, tp_event_callback cb);
>  int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb);
>  
> +bool perf_pmu__is_tracepoint(const struct perf_pmu *pmu);
> +int tp_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
> +size_t tp_pmu__num_events(struct perf_pmu *pmu);
> +bool tp_pmu__have_event(struct perf_pmu *pmu, const char *name);
> +
>  #endif /* __TP_PMU_H */
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
