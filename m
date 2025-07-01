Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ED9450F2;
	Tue,  1 Jul 2025 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351035; cv=none; b=dDY8KavyFND35DJhvfS1NjXzyB8swfmiB1uuvlnGpNuU1iNlaqY6RJ2Rzm914pczLVT7YXT8omU3lv+I729mDVCmuTcAivkHOQLg/9GigEFVy6eOf95Hh6A1tYwzcCxcwgxPuJqtv6pOWko9NTOxRnbYdCi8TTV/0nqBkrdNrHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351035; c=relaxed/simple;
	bh=4i2k8Kls+ue/tzY9XkDvo0G/r5OHrsZEyH8rZH7yUXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVvLqR8WQRZu5n62qqarWgMwV6qQxW7vp+jwtTEuwpNXFjZ2A0dlJuniIIyX9iHAJIgzMJA29UVFd3FudvnpsKL4JKs9SoeGQlNLugHanQmU/pku2rRK0+sTNX4SuuMKCnDhTHT9jT9t4Tk7XSimA2MPkF+UC7Mq/Uqp/ofahzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5LfUCQY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5LfUCQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093AAC4CEEB;
	Tue,  1 Jul 2025 06:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751351034;
	bh=4i2k8Kls+ue/tzY9XkDvo0G/r5OHrsZEyH8rZH7yUXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5LfUCQYiCuKVcCGZL1M/sTm07QuKc8OJiWsKbAl7EE8dK6e7X0ErlNehuLyPbspK
	 Bbh8tnUD/9x2eQa/9080LpvNadxyHOt/zRwWNd5kMzjGQBNzGjCkQMzgV7CSNaQdoy
	 MEr7Q076FsjpmKODf9sNK22vOvqTE/MQv3y9+A0NQgwyOmTJgJZojRuCjZPxdJ3+y6
	 83q93N9ZbaDmU+fjgxZUkPQUbOcYT1wwW8074i4bKN3KPI7xFWIzPXmqpMp9he3KyQ
	 Q5jcjbb6V/UflGQyoy0RepiiEBxUBgZXFmhOkXijBYzdZyT15s7dg+HH9YGiyQNbsI
	 S8tqO/fnDHwsA==
Date: Mon, 30 Jun 2025 23:23:51 -0700
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
Subject: Re: [PATCH v5 23/23] perf sort: Use perf_env to set arch sort keys
 and header
Message-ID: <aGN-9079q9sQaW8s@google.com>
References: <20250628045017.1361563-1-irogers@google.com>
 <20250628045017.1361563-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250628045017.1361563-24-irogers@google.com>

On Fri, Jun 27, 2025 at 09:50:17PM -0700, Ian Rogers wrote:
> Previously arch_support_sort_key and arch_perf_header_entry used a
> weak symbol to compile as appropriate for x86 and powerpc. A
> limitation to this is that the handling of a data file could vary in
> cross-platform development. Change to using the perf_env of the
> current session to determine the architecture kind and set the sort
> key and header entries as appropriate.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index ada8e0166c78..6f24540bdee9 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1790,7 +1790,7 @@ int cmd_report(int argc, const char **argv)
>  	}
>  
>  	if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
> -	    (setup_sorting(session->evlist) < 0)) {
> +	    (setup_sorting(session->evlist, &session->header.env) < 0)) {

					    perf_session__env(session) ?

Thanks,
Namhyung


>  		if (sort_order)
>  			parse_options_usage(report_usage, options, "s", 1);
>  		if (field_order)
