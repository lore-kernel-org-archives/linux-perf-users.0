Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6DE8F6B;
	Wed, 28 May 2025 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464876; cv=none; b=bKot50eFX7MWzXmEov8Zf1PQFo8DyXT7n2o1fn1ToqxqBJcVAW6+ujioHQ18i17TqqFaYvcx8fuPhvtnngDy4PGKj6h4wJI4rX2qM3+5l5DiOQ5yGQocDD8lkmcqnFLa+Vnki574+/4HrtmZyC4wZceSLCGLHHBmfPflHYoE70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464876; c=relaxed/simple;
	bh=LWVMEg3l1GT6SnBAWXO9qNjxVgzPXBCLOsmNOmxY1GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svAg2N1ZJ/+9btiS7gTbl7J6IUKjPbaDIbnH8X37P94zYOIj1TFlvpFoH/AYhvRrfIOIk23MU1jcaOvu1q0K3Scq85wnuCnI2waq4TeSH6V9Pj0nGLxUVt3HiBV+WLuXAu/agHi+P3ZFBnO77DigHzG27y2LCZCbQwfyRd44OlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkpC+F6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkpC+F6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7ACC4CEE3;
	Wed, 28 May 2025 20:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748464875;
	bh=LWVMEg3l1GT6SnBAWXO9qNjxVgzPXBCLOsmNOmxY1GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkpC+F6X2GHJzAvOzo155VRw6v001bz1JwFFqV/j5dSslz9H4XbTQ0VUugtdV06AM
	 U8FnEXl7MgtpD6QMrmOcKB4DJYcBVgY5i2MYf+uMsA2sBoEjQdd5h0gp1P8FzX9irk
	 LWkGoOesNnSHb6lh7MBjOpKKHJ1lnRrhbql7H9NXvKqSlVIV8RBXeEb8t+jrpJS6Ev
	 9Zcm/mZtmVEfNxeyIcjzZpt/hvopX+PbgLsZ0IvuuZzrFoxqKAwX+DIXY3ZYxVaNn8
	 0JQOiKPhpH3Bi2AYBUlc6DRV7tjdYFdmoaCLMUS7YqtCdsB2rnOphm+kfcctLyYswc
	 CmYWKskgLibQg==
Date: Wed, 28 May 2025 13:41:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCH v3 5/9] perf build-id: Mark DSO in sample callchains
Message-ID: <aDd06eK7fKFsFsVS@google.com>
References: <20250428213409.1417584-1-irogers@google.com>
 <20250428213409.1417584-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428213409.1417584-6-irogers@google.com>

On Mon, Apr 28, 2025 at 02:34:04PM -0700, Ian Rogers wrote:
> Previously only the sample IP's map DSO would be marked hit for the
> purposes of populating the build ID cache. Walk the call chain to mark
> all IPs and DSOs.

I think this is correct, but I'm afraid it'd also increase the processing
time.  Do you happen to have any numbers?

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/build-id.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index aa35dceace90..3386fa8e1e7e 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -42,10 +42,20 @@
>  
>  static bool no_buildid_cache;
>  
> +static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data __maybe_unused)
> +{
> +	struct map *map = node->ms.map;
> +
> +	if (map)
> +		dso__set_hit(map__dso(map));
> +
> +	return 0;
> +}
> +
>  int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
>  			   union perf_event *event,
>  			   struct perf_sample *sample,
> -			   struct evsel *evsel __maybe_unused,
> +			   struct evsel *evsel,
>  			   struct machine *machine)
>  {
>  	struct addr_location al;
> @@ -63,6 +73,11 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
>  		dso__set_hit(map__dso(al.map));
>  
>  	addr_location__exit(&al);
> +
> +	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
> +					/*symbols=*/false, mark_dso_hit_callback, /*data=*/NULL);
> +
> +
>  	thread__put(thread);
>  	return 0;
>  }
> -- 
> 2.49.0.901.g37484f566f-goog
> 
