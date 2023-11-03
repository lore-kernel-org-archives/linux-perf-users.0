Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB91549B
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F45F182;
	Fri,  3 Nov 2023 01:33:09 -0700 (PDT)
Date: Fri, 3 Nov 2023 09:32:58 +0100
From: Guilherme Amadio <amadio@gentoo.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ming Wang <wangming01@loongson.cn>,
	James Clark <james.clark@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Leo Yan <leo.yan@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	German Gomez <german.gomez@arm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
	Sandipan Das <sandipan.das@amd.com>,
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 03/53] libperf: Lazily allocate mmap event copy
Message-ID: <ZUSwOlsOyJdDT1ls@gentoo.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102175735.2272696-4-irogers@google.com>

Hi, 

On Thu, Nov 02, 2023 at 10:56:45AM -0700, Ian Rogers wrote:
> The event copy in the mmap is used to have storage to a read
> event. Not all users of mmaps read the events, such as perf record, so
> switch the allocation to being on first read rather than being
> embedded within the perf_mmap.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/include/internal/mmap.h | 2 +-
>  tools/lib/perf/mmap.c                  | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
> index 5a062af8e9d8..b11aaf5ed645 100644
> --- a/tools/lib/perf/include/internal/mmap.h
> +++ b/tools/lib/perf/include/internal/mmap.h
> @@ -33,7 +33,7 @@ struct perf_mmap {
>  	bool			 overwrite;
>  	u64			 flush;
>  	libperf_unmap_cb_t	 unmap_cb;
> -	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
> +	void			*event_copy;
>  	struct perf_mmap	*next;
>  };
>  
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 2184814b37dd..91ae46aac378 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
>  
>  void perf_mmap__munmap(struct perf_mmap *map)
>  {
> +	free(map->event_copy);
> +	map->event_copy = NULL;
>  	if (map && map->base != NULL) {

If map can be NULL as the if statement above suggests, then there is a
potential a null pointer dereference bug here. Suggestion:

    if (!map)
        return;

    free(map->event_copy);
    map->event_copy = NULL;
    if (map->base != NULL) {

    ...

Cheers,
-Guilherme

>  		munmap(map->base, perf_mmap__mmap_len(map));
>  		map->base = NULL;
> @@ -226,6 +228,13 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
>  			unsigned int len = min(sizeof(*event), size), cpy;
>  			void *dst = map->event_copy;
>  
> +			if (!dst) {
> +				dst = malloc(PERF_SAMPLE_MAX_SIZE);
> +				if (!dst)
> +					return NULL;
> +				map->event_copy = dst;
> +			}
> +
>  			do {
>  				cpy = min(map->mask + 1 - (offset & map->mask), len);
>  				memcpy(dst, &data[offset & map->mask], cpy);
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
> 
