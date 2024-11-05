Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960831E0DBF;
	Tue,  5 Nov 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827373; cv=none; b=TrhtSK5vzm5bQWdqghOlPZl7XnDzY9bXtORx2fmDkfoVpo1tmUrx2otWg5N0/Me+9TcIFXVJ9cyF+q7U08qBC2ijdQb9HzT64WckYtsOjFQY2tRLXkj1SGknrkNO4Hv04//63FYZiMvpPJRyBdGL4x1DbKqL/IhnNnPVNo2czbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827373; c=relaxed/simple;
	bh=gJNs3OM487k44bvDEB1mLU1Fr4d9X2WvQIpWvqnIn14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDHw8AhmuUUMT7TA/G6SKtxgiefwhAdbFsrN5Vrk0bjQ1qWdsVYgi9FLfd19VHCb41EF0OIir/CeSd34HMd42EzMxNl7HTBDmpA57AOKSgsdD2N9rWgM4TePmHTQ8g8HPVRxDsegoHsLEfBskgrcFa8DquvgeqQOZcTHn3oIVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw1Zevgn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw1Zevgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F564C4CED1;
	Tue,  5 Nov 2024 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730827373;
	bh=gJNs3OM487k44bvDEB1mLU1Fr4d9X2WvQIpWvqnIn14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yw1ZevgnlthmNypJ151xMZ73CctukCmhQGDwzSg45EfajXiN99Tb7g+0ADMeGbOhV
	 cHoFpawWnofn9qgrYeyKAVSYnoFlHidbas9wLeg5WOq2diBuVl9WtYuM1L9tmEqSRG
	 ncui3Hy6CmhLw8x6rwcB0kvv8od6IbAq1gJlO+PTOoxiWAUvl2GpXc4X8uffjF8qjg
	 +SCwF529c2MftSUGTRibWly7KM5DzEgoD5EmGrm5uMaCM6ge6LqzTiG8XeJpwrXqjk
	 yno60wFAQ+D9rmamyNF+dzRjM3SpNzWt3nZtIFkzQY3VnSuykZw7sA0SG31H1Fjtne
	 ZR2gC01novQiA==
Date: Tue, 5 Nov 2024 14:22:48 -0300
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
Subject: Re: [PATCH v2 3/6] perf trace-event: Always build trace-event-info.c
Message-ID: <ZypUaPH9UjXQyXYz@x1>
References: <20241102165400.75785-1-irogers@google.com>
 <20241102165400.75785-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102165400.75785-4-irogers@google.com>

On Sat, Nov 02, 2024 at 09:53:57AM -0700, Ian Rogers wrote:
> trace-event-info.c has no libtraceevent depdendencies, always build it
> and use it in builtin-record and perf_event_attr printing.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c               | 2 --
>  tools/perf/util/Build                     | 2 +-
>  tools/perf/util/perf_event_attr_fprintf.c | 4 ----
>  3 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f83252472921..0b637cea4850 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1748,10 +1748,8 @@ static void record__init_features(struct record *rec)
>  	if (rec->no_buildid)
>  		perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
>  
> -#ifdef HAVE_LIBTRACEEVENT
>  	if (!have_tracepoints(&rec->evlist->core.entries))
>  		perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
> -#endif
>  
>  	if (!rec->opts.branch_stack)
>  		perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 1eedead5f2f2..609c69995c51 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -85,7 +85,7 @@ perf-util-y += pmu-flex.o
>  perf-util-y += pmu-bison.o
>  perf-util-y += tool_pmu.o
>  perf-util-y += svghelper.o
> -perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
> +perf-util-y += trace-event-info.o
>  perf-util-y += trace-event-scripting.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-parse.o
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index 59fbbba79697..a73c74b99a3b 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -212,7 +212,6 @@ static void __p_config_hw_cache_id(char *buf, size_t size, u64 value)
>  	}
>  }
>  
> -#ifdef HAVE_LIBTRACEEVENT
>  static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
>  {
>  	char *str = tracepoint_id_to_name(value);
> @@ -220,7 +219,6 @@ static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
>  	print_id_hex(str);
>  	free(str);
>  }
> -#endif
>  
>  static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 value)
>  {
> @@ -238,9 +236,7 @@ static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type
>  	case PERF_TYPE_HW_CACHE:
>  		return __p_config_hw_cache_id(buf, size, value);
>  	case PERF_TYPE_TRACEPOINT:
> -#ifdef HAVE_LIBTRACEEVENT
>  		return __p_config_tracepoint_id(buf, size, value);
> -#endif
>  	case PERF_TYPE_RAW:
>  	case PERF_TYPE_BREAKPOINT:
>  	default:
> -- 
> 2.47.0.199.ga7371fff76-goog
