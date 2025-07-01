Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766B199385;
	Tue,  1 Jul 2025 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751349944; cv=none; b=HFOOzuZNLdfdZtGURE01gaLs0gORqoVWxZ0YOpbD7LXZveUUH674oxZkPXAvEDireaPA3o2jetMqAHR95ycpoCBmykGNR33t2nqQWneWcUQplOhC55cufabQSXVKCWijpCZmEEqyn1gO6szzV9e0fF6fU6gc/f4jlIsX/V7AqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751349944; c=relaxed/simple;
	bh=5wxaXCZgzcsOdU2YdEfVEPx37l7c81hL3jRM5rarvbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OP2nAKL7WfhT2tULmy0Pw9wfUOqXUiJt/sqmy2uE8jfXKYNByYLP72/iyRVWHSsTOEainMNw2vsl0ZPdGi6jfGByZiIYjWFDynQnNVLDOd9JMgn+d2Whi9FO21JVu4z6sMH2Sdh0Vu+tQU+mpyKx8AdfMGVfyrbCh+UtA3gXQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Icn2+5KX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Icn2+5KX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE12CC4CEEB;
	Tue,  1 Jul 2025 06:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751349943;
	bh=5wxaXCZgzcsOdU2YdEfVEPx37l7c81hL3jRM5rarvbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Icn2+5KX57HRZwT5+1VGTOQCeQNj7UvRQ1GCzOQXSWdK6KsMrm2Fja5AZMUgspLAS
	 JmTY4hIHuEUR+Ay7H39x6XFH1ZxTMKvEkZ3Xb7uB4Cd7xoF96Iy0uizi6ENT6gyQpU
	 IZ8ACk5hRfSAZ2PHpWdm7NUTuz1oND+KF8ZndKkiZhtnTDVsg6DcZKtdpYCJ6+zcyI
	 +hVc1FNKtGtv2gh4eHfU7IHY1CHQJvkEy8OB+KWu5Gr3ZvmqMLcqd/na8D+x9rhORE
	 Q/EHI+Wfz70CGui1wd2uWR5lFuKVFAjBTtU7JqAwukkwxQDhzgc+YiBzIPsxYjYfsJ
	 or68BrKQcPnkA==
Date: Mon, 30 Jun 2025 23:05:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Chun-Tse Shao <ctshao@google.com>, Yujie Liu <yujie.liu@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Matt Fleming <matt@readmodwrite.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Zixian Cai <fzczx123@gmail.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Ben Gainey <ben.gainey@arm.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Martin Liska <martin.liska@hey.com>,
	Martin =?utf-8?B?TGnFoWth?= <m.liska@foxlink.cz>,
	Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 16/23] perf bench synthesize: Avoid use of global
 perf_env
Message-ID: <aGN6tPDP50RrNTnq@google.com>
References: <20250628045017.1361563-1-irogers@google.com>
 <20250628045017.1361563-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250628045017.1361563-17-irogers@google.com>

On Fri, Jun 27, 2025 at 09:50:10PM -0700, Ian Rogers wrote:
> The benchmark doesn't use a data file and so the header perf_env isn't
> used. Stack allocate a host perf_env for use to avoid the use of the
> global perf_env.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/bench/synthesize.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> index 9b333276cbdb..79d99ba50284 100644
> --- a/tools/perf/bench/synthesize.c
> +++ b/tools/perf/bench/synthesize.c
> @@ -114,10 +114,13 @@ static int run_single_threaded(void)
>  		.pid = "self",
>  	};
>  	struct perf_thread_map *threads;
> +	struct perf_env host_env;
>  	int err;
>  
>  	perf_set_singlethreaded();
> -	session = perf_session__new(NULL, NULL);
> +	perf_env__init(&host_env);
> +	session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
> +				      /*trace_event_repipe=*/false, &host_env);
>  	if (IS_ERR(session)) {
>  		pr_err("Session creation failed.\n");
>  		return PTR_ERR(session);

Missing perf_env__exit() ?


> @@ -144,6 +147,7 @@ static int run_single_threaded(void)
>  		perf_thread_map__put(threads);
>  
>  	perf_session__delete(session);
> +	perf_env__exit(&host_env);
>  	return err;
>  }
>  
> @@ -154,17 +158,21 @@ static int do_run_multi_threaded(struct target *target,
>  	u64 runtime_us;
>  	unsigned int i;
>  	double time_average, time_stddev, event_average, event_stddev;
> -	int err;
> +	int err = 0;
>  	struct stats time_stats, event_stats;
>  	struct perf_session *session;
> +	struct perf_env host_env;
>  
> +	perf_env__init(&host_env);
>  	init_stats(&time_stats);
>  	init_stats(&event_stats);
>  	for (i = 0; i < multi_iterations; i++) {
> -		session = perf_session__new(NULL, NULL);
> -		if (IS_ERR(session))
> -			return PTR_ERR(session);
> -
> +		session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
> +					      /*trace_event_repipe=*/false, &host_env);
> +		if (IS_ERR(session)) {
> +			err = PTR_ERR(session);
> +			goto err_out;
> +		}
>  		atomic_set(&event_count, 0);
>  		gettimeofday(&start, NULL);
>  		err = __machine__synthesize_threads(&session->machines.host,
> @@ -173,10 +181,8 @@ static int do_run_multi_threaded(struct target *target,
>  						process_synthesized_event,
>  						true, false,
>  						nr_threads_synthesize);
> -		if (err) {
> -			perf_session__delete(session);
> -			return err;
> -		}
> +		if (err)
> +			goto err_out;

Missing perf_session__delete() ?


>  
>  		gettimeofday(&end, NULL);
>  		timersub(&end, &start, &diff);
> @@ -198,7 +204,9 @@ static int do_run_multi_threaded(struct target *target,
>  
>  	printf("    Average time per event %.3f usec\n",
>  		time_average / event_average);
> -	return 0;
> +err_out:
> +	perf_env__exit(&host_env);
> +	return err;
>  }
>  
>  static int run_multi_threaded(void)
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
