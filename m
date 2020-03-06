From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 06/10] perf report: Add 'cgroup' sort key
Date: Fri, 6 Mar 2020 15:10:11 +0100
Message-ID: <20200306141011.GB290743@krava>
References: <20200224043749.69466-1-namhyung@kernel.org>
 <20200224043749.69466-7-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200224043749.69466-7-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Feb 24, 2020 at 01:37:45PM +0900, Namhyung Kim wrote:

SNIP

> @@ -634,6 +637,39 @@ struct sort_entry sort_cgroup_id = {
>  	.se_width_idx	= HISTC_CGROUP_ID,
>  };
>  
> +/* --sort cgroup */
> +
> +static int64_t
> +sort__cgroup_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return right->cgroup - left->cgroup;
> +}
> +
> +static int hist_entry__cgroup_snprintf(struct hist_entry *he,
> +				       char *bf, size_t size,
> +				       unsigned int width __maybe_unused)
> +{
> +	const char *cgrp_name = "N/A";
> +
> +	if (he->cgroup) {
> +		struct cgroup *cgrp = cgroup__find(he->ms.maps->machine->env,

eveything is connected :)) great that this one works

jirka
