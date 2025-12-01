Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B033468D;
	Mon,  1 Dec 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608470; cv=none; b=my5yaK+M+SfpRqZdIfaA8zRgbmaYa+f306GhqQlYtN+35IjU+46/v7nBGn6rY3MaEO+sFnLTR+Yd9xGb5lSEWVqFWvBQmwH8cKqy3AvARnxfgYHnAjXBecHmLe7DlFBXO441shdSpPxhFtBxFua/14+/Yuv3YyktxwwTHDB5q7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608470; c=relaxed/simple;
	bh=DEcuSL1n7r/KSBBqiQc7zDnwYd7NPz4TTwyhYHxtJXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNtOKa3gQ8GZbxuANwM1qjkazFmNlPutgDct8YFGLl4AuSZl9mbTt75b54Q3HAZyJJZt5k4+zNZLzo/q2SBMeNnvK6EEOjLWnMuoMSZJQWhrKKv26xSjkyC3eYxKC8L+wqrHsen5Kup7gGrn4bQ8J2QKjvKt7ntAZcG0KR+1C+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikAjl2RK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikAjl2RK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF91C4CEF1;
	Mon,  1 Dec 2025 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764608470;
	bh=DEcuSL1n7r/KSBBqiQc7zDnwYd7NPz4TTwyhYHxtJXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikAjl2RK3v+T6dcpBGtqlBxnMeGeFzb41o7XVm6h9riaxExOPCqRlxod+WXdXuoJq
	 kj2kFbEOZxTq1ySectH9rTSOAlHmpHjSAOct2+5Ew/g+7HuCc9dOkaD/Vo7aMGDsGj
	 QoFAzUD6qnwn4LtcJxPHJaJ2qUQ/iD3CkG0hJH3rxhaU/N40NQ5o0551DnFlMQ2ur2
	 +OQd4b+qwDIk9H+88iPvxYn68i8/82ybP8QDRu333ZwQ2ulV84fytlPt9m/vyjO7x6
	 rI01r5S9D6eTech4Z04u8pCfawjfK5HqRCa8ZPdgqXDb5yA+koRHs/DBqtng6AIcxk
	 jha6Hcj5Adn1g==
Date: Mon, 1 Dec 2025 14:01:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 07/17] perf mem-events: Don't leak online CPU map
Message-ID: <aS3J06ZnbOvDXYfC@x1>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122081929.7588-8-irogers@google.com>

On Sat, Nov 22, 2025 at 12:19:19AM -0800, Ian Rogers wrote:
> Reference count checking found the online CPU map was being gotten but
> not put. Add in the missing put.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/mem-events.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 80b3069427bc..0b49fce251fc 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -303,12 +303,15 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr, char **eve
>  	}
>  
>  	if (cpu_map) {
> -		if (!perf_cpu_map__equal(cpu_map, cpu_map__online())) {
> +		struct perf_cpu_map *online = cpu_map__online();
> +
> +		if (!perf_cpu_map__equal(cpu_map, online)) {
>  			char buf[200];
>  
>  			cpu_map__snprint(cpu_map, buf, sizeof(buf));
>  			pr_warning("Memory events are enabled on a subset of CPUs: %s\n", buf);
>  		}
> +		perf_cpu_map__put(online);
>  		perf_cpu_map__put(cpu_map);
>  	}
>  
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
