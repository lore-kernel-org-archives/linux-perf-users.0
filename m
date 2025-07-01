Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C8B23B60B;
	Tue,  1 Jul 2025 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351236; cv=none; b=tuEIt+xLM7UMvKRoJfyaDQJ82mkvlDxvDOoO4NUqjnbWo3Nt/RKRIn/Am0qAqvwXoqfR8vOvx2yAJV/pIZye+sQDj1Hq36H6LZqlrUbFJGyYIG/wLTkEnf1MHrWDbtYqajC2D0Q37wgfcLGC0XzWXvhL2f4VSyqy4B/vKjfxoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351236; c=relaxed/simple;
	bh=EVqZ5AXgN+Lqg5d4ako7k4AxyCn3s4HtFBq5nXm8ww4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHYRbPDn2Ab/CgdmcdxIEh7hBt/zbXk1NuSWdIs8YfIx9gj4Wdct9JkOlBDAXhulMjtZYsTAhsKDzbaWKaaz8xnh8WqySSqTbN/Gwg9Hv8ZkeN6drKDNQbNV0NFqfaSN1YnTWLKWwHXoMQtAdnbCs6tUHWATliAQpmeSLZ/tsjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2MTiFaf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2MTiFaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23714C4CEEB;
	Tue,  1 Jul 2025 06:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751351235;
	bh=EVqZ5AXgN+Lqg5d4ako7k4AxyCn3s4HtFBq5nXm8ww4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m2MTiFafr+Bb7phzcdlc8BYCSyf2gRzghdPPMWyhLwl5KMpPhehDIwesSV+U402vW
	 M1peJ9nnjknmCW/NF+SaoPDC+hEL6e1FEeodSiuTudcI/GptQdfQK/4T8IhiWyy4dW
	 GVpVdPtQj9FewVwR+MwqWtKALjd4PSNmxxZgQDw7x4ppCTdXoEYLAHLME+eW/s7vXd
	 jE9yHrH9Lkr/G+gu/CTSCQRpkIft1sOAMMOWIJCyLNpKWEPqquO47G6WX6U8cad29Y
	 uEgL2MrINmz48RtA/sj1che6hUUa+Dl8pLhRSEllKKTwvJRRWaYoT6DitmvdeVJigO
	 nWJn8OT293EcA==
Date: Mon, 30 Jun 2025 23:27:12 -0700
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
Subject: Re: [PATCH v5 10/23] perf session: Add an env pointer for the
 current perf_env
Message-ID: <aGN_wBXVt6YN4Itb@google.com>
References: <20250628045017.1361563-1-irogers@google.com>
 <20250628045017.1361563-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250628045017.1361563-11-irogers@google.com>

On Fri, Jun 27, 2025 at 09:50:04PM -0700, Ian Rogers wrote:
> Initialize to `&header.env`. This will later allow the env value to be
> changed.

I'm curious when it is changed.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/session.c | 3 ++-
>  tools/perf/util/session.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index b09d157f7d04..e39a1df7c044 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -156,6 +156,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
>  			     ordered_events__deliver_event, NULL);
>  
>  	perf_env__init(&session->header.env);
> +	session->env = &session->header.env;
>  	if (data) {
>  		ret = perf_data__open(data);
>  		if (ret < 0)
> @@ -2750,5 +2751,5 @@ int perf_session__dsos_hit_all(struct perf_session *session)
>  
>  struct perf_env *perf_session__env(struct perf_session *session)
>  {
> -	return &session->header.env;
> +	return session->env;
>  }
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index e7f7464b838f..088868f1004a 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -45,6 +45,8 @@ struct perf_session {
>  	struct perf_header	header;
>  	/** @machines: Machines within the session a host and 0 or more guests. */
>  	struct machines		machines;
> +	/** @env: The perf_env being worked with, either from a data file or the host's. */
> +	struct perf_env		*env;
>  	/** @evlist: List of evsels/events of the session. */
>  	struct evlist	*evlist;
>  	/** @auxtrace: callbacks to allow AUX area data decoding. */
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
