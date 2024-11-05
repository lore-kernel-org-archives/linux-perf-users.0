Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391057DA6F;
	Tue,  5 Nov 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827121; cv=none; b=PwR7l5k+lhyLHwHDbXaeSxq7k/+raCRnwMkxqEadza+SQG1WOZT/iSjcrm518rIfiQj3ekU58yhwkXRc6D7a1ZALOIQpuiauDsNMlITyYae1tkEyxUfpbubY0XSyEJueI+GgIQz4Rmvm+7s31qFYFvBFdSC17AzmGyrY1h5w/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827121; c=relaxed/simple;
	bh=X1tjw+DqzERc1tNyRRoK1laUCQc7IxShhk67AjUwTr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj1RtZnRve6IqG3ympzLWczVkEIldLX6IKBblGM+SNfzevY2WYAoV1nh65920SdccICGRvdzPav4UCTMnCOX9L/a3krTkRUKCnyRnjBCBaU7JVgglrfrv2uSTmICnaZ80K7r8JOz4C4S7wb5M8s4eaO9V4BxtqCqx1sLF3bph44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJUrsHOR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJUrsHOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C219C4CECF;
	Tue,  5 Nov 2024 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730827121;
	bh=X1tjw+DqzERc1tNyRRoK1laUCQc7IxShhk67AjUwTr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJUrsHORW7WQKlPEDJlTEtXJoT7vsT96jOrQMOloEZ22/oKEY6hjG7DxJVFbqIi18
	 VkmKlQPET4LOKT3KDqFi8o4MPpmkbeyyN61nw8w1rqXEYzEwg1JqQf/6sBjXiQLp/E
	 pBLwTqnfAmUCPdw5X15zMt2G2Csx/vIcvKzf19VrWc85YYN0cy6Hy1uH3optXnyc5h
	 7WSE34XmlLYqW9cf5kN4px1bRKIUIBB6yaCKf4xNh9+09z5sRCKespBh3TtT+dGRjg
	 wT3u7Qt6R81BxlBwkh+B9Hp2oiYEkkTiWhPgdfm5rWXRsBHkTQXQ5a0hXz7r4bAOvp
	 PEJjXHBPfpUJA==
Date: Tue, 5 Nov 2024 14:18:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Paran Lee <p4ranlee@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/6] perf trace-event: Constify print arguments
Message-ID: <ZypTbPyzplDg1cf9@x1>
References: <20241102165400.75785-1-irogers@google.com>
 <20241102165400.75785-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102165400.75785-3-irogers@google.com>

On Sat, Nov 02, 2024 at 09:53:56AM -0700, Ian Rogers wrote:
> Capture that these functions don't mutate their input.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/trace-event-parse.c | 4 ++--
>  tools/perf/util/trace-event.h       | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
> index f0332bd3a501..6f11ca5513e3 100644
> --- a/tools/perf/util/trace-event-parse.c
> +++ b/tools/perf/util/trace-event-parse.c
> @@ -99,7 +99,7 @@ unsigned long long read_size(struct tep_event *event, void *ptr, int size)
>  	return tep_read_number(event->tep, ptr, size);
>  }
>  
> -void event_format__fprintf(struct tep_event *event,
> +void event_format__fprintf(const struct tep_event *event,
>  			   int cpu, void *data, int size, FILE *fp)
>  {
>  	struct tep_record record;
> @@ -116,7 +116,7 @@ void event_format__fprintf(struct tep_event *event,
>  	trace_seq_destroy(&s);
>  }
>  
> -void event_format__print(struct tep_event *event,
> +void event_format__print(const struct tep_event *event,
>  			 int cpu, void *data, int size)
>  {
>  	return event_format__fprintf(event, cpu, data, size, stdout);
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index bbf8b26bc8da..084068fb36a1 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -39,10 +39,10 @@ trace_event__tp_format(const char *sys, const char *name);
>  
>  struct tep_event *trace_event__tp_format_id(int id);
>  
> -void event_format__fprintf(struct tep_event *event,
> +void event_format__fprintf(const struct tep_event *event,
>  			   int cpu, void *data, int size, FILE *fp);
>  
> -void event_format__print(struct tep_event *event,
> +void event_format__print(const struct tep_event *event,
>  			 int cpu, void *data, int size);
>  
>  int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size);
> -- 
> 2.47.0.199.ga7371fff76-goog
