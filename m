Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACFA29CB49;
	Wed, 16 Jul 2025 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696574; cv=none; b=EBwfDzKKdzCCmEOxC6L5IdiJ5tHk+6BviN5EBJPaUzRQPGSjKVqzBV8RZiWdchDXlvHT/5nK10gqLORG9zzBf9tbRhQgvAOyVNS7BpDeCn+Dh/Y2Up5xByzseyy5c9oORg5sgtqflFe5pZfY5y8aF3Z5mh0zTa5OzWLSUYvsb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696574; c=relaxed/simple;
	bh=NclOaaf4/iWs/+cgbq979FL7Scz/PAQBDhPtjL7H6oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuNgNVKWZbf0I0Q34NliSLazWvN2WfxSVG9pQ1ORwdoJlYDsYTmGszDZab08EtPLMTwSyfbqbwva5MYX1hNt+4uhzKvGv7WXYtF+7I/mHVwGcoCz9MSQuq+fNhbUf1h8siwMZHJfnRPczoUkeoFr7NgU7NHBPW8O0kvbtdptvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8pOqSl0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8pOqSl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC1FC4CEE7;
	Wed, 16 Jul 2025 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752696573;
	bh=NclOaaf4/iWs/+cgbq979FL7Scz/PAQBDhPtjL7H6oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8pOqSl0pqi4bHIS2y/KArgSbLVPz7wzCnStK0wZUt8kLwDtMSjcua7ahNrkCgosX
	 TPptxR/sVDx05G0UMFQomREEZAmmGKfGuPzJF3JkqSYmy9RBeby814SfJj7V6cBlg1
	 /n0UCKLjI2WKFRQpYF5K719JW1Su4/pZz9aVwOOry9knAGkyi8jpx8RLZCNdEqgjFL
	 coURusJHgA4ZgBHfNu9Cruge4SZrdW2KYuPxQsrVAv/d+l9/m3Kj5VpnWQnQ/3Uylk
	 Ptq48rLLcyRPLWeNnOnGaxzilI+xQ1ZMu4+ERLkaGtPIQ4iK3EB3ylm69VRAY/wuMb
	 mqPVoFLYrwZvw==
Date: Wed, 16 Jul 2025 13:09:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Blake Jones <blakejones@google.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/12] perf parse-events: Allow the cpu term to be a
 PMU
Message-ID: <aHgG-9iuoj4B72SU@google.com>
References: <20250627192417.1157736-1-irogers@google.com>
 <20250627192417.1157736-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627192417.1157736-5-irogers@google.com>

On Fri, Jun 27, 2025 at 12:24:09PM -0700, Ian Rogers wrote:
> On hybrid systems, events like msr/tsc/ will aggregate counts across
> all CPUs. Often metrics only want a value like msr/tsc/ for the cores
> on which the metric is being computed. Listing each CPU with terms
> cpu=0,cpu=1.. is laborious and would need to be encoded for all
> variations of a CPU model.
> 
> Allow the cpumask from a PMU to be an argument to the cpu term. For
> example in the following the cpumask of the cstate_pkg PMU selects the
> CPUs to count msr/tsc/ counter upon:
> ```
> $ cat /sys/bus/event_source/devices/cstate_pkg/cpumask
> 0
> $ perf stat -A -e 'msr/tsc,cpu=cstate_pkg/' -a sleep 0.1

It can be confusing if 'cpu' takes a number or a PMU name.  What about
adding a new term (maybe 'cpu_from') to handle this case?

Also please update the documentation.

Thanks,
Namhyung

> 
>  Performance counter stats for 'system wide':
> 
> CPU0          252,621,253      msr/tsc,cpu=cstate_pkg/
> 
>        0.101184092 seconds time elapsed
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 37 +++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 7a32d5234a64..ef38eb082342 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -192,10 +192,20 @@ static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms *head
>  
>  	list_for_each_entry(term, &head_terms->terms, list) {
>  		if (term->type_term == PARSE_EVENTS__TERM_TYPE_CPU) {
> -			struct perf_cpu_map *cpu = perf_cpu_map__new_int(term->val.num);
> +			struct perf_cpu_map *term_cpus;
>  
> -			perf_cpu_map__merge(&cpus, cpu);
> -			perf_cpu_map__put(cpu);
> +			if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
> +				term_cpus = perf_cpu_map__new_int(term->val.num);
> +			} else {
> +				struct perf_pmu *pmu = perf_pmus__find(term->val.str);
> +
> +				if (perf_cpu_map__is_empty(pmu->cpus))
> +					term_cpus = pmu->is_core ? cpu_map__online() : NULL;
> +				else
> +					term_cpus = perf_cpu_map__get(pmu->cpus);
> +			}
> +			perf_cpu_map__merge(&cpus, term_cpus);
> +			perf_cpu_map__put(term_cpus);
>  		}
>  	}
>  
> @@ -1054,12 +1064,21 @@ do {									   \
>  		}
>  		break;
>  	case PARSE_EVENTS__TERM_TYPE_CPU:
> -		CHECK_TYPE_VAL(NUM);
> -		if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
> -			parse_events_error__handle(err, term->err_val,
> -						strdup("too big"),
> -						NULL);
> -			return -EINVAL;
> +		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
> +			if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
> +				parse_events_error__handle(err, term->err_val,
> +							strdup("too big"),
> +							/*help=*/NULL);
> +				return -EINVAL;
> +			}
> +		} else {
> +			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_STR);
> +			if (perf_pmus__find(term->val.str) == NULL) {
> +				parse_events_error__handle(err, term->err_val,
> +							strdup("not a valid PMU"),
> +							/*help=*/NULL);
> +				return -EINVAL;
> +			}
>  		}
>  		break;
>  	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
