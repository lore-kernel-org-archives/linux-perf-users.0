Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD377E2
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203C010E;
	Tue, 24 Oct 2023 19:38:56 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SFY2S5kzWzrTcT;
	Wed, 25 Oct 2023 10:36:00 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 25 Oct 2023 10:38:52 +0800
Subject: Re: [PATCH v3 13/50] libperf: Lazily allocate mmap event copy
To: Ian Rogers <irogers@google.com>
References: <20231024222353.3024098-1-irogers@google.com>
 <20231024222353.3024098-14-irogers@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Nick
 Terrell <terrelln@fb.com>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen
	<ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, Song Liu
	<song@kernel.org>, Sandipan Das <sandipan.das@amd.com>, James Clark
	<james.clark@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Miguel
 Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, Athira
 Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson
	<seanjc@google.com>, Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria
	<ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, Changbin Du
	<changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, liuwenyu <liuwenyu7@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <4d275fcd-a102-662f-d9f7-3acd3586acf2@huawei.com>
Date: Wed, 25 Oct 2023 10:38:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231024222353.3024098-14-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected

Hello,

On 2023/10/25 6:23, Ian Rogers wrote:
> The event copy in the mmap is used to have storage to a read
> event. Not all users of mmaps read the events, such as perf record, so
> switch the allocation to being on first read rather than being
> embedded within the perf_mmap.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/lib/perf/include/internal/mmap.h | 2 +-
>   tools/lib/perf/mmap.c                  | 9 +++++++++
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
> index 5a062af8e9d8..b11aaf5ed645 100644
> --- a/tools/lib/perf/include/internal/mmap.h
> +++ b/tools/lib/perf/include/internal/mmap.h
> @@ -33,7 +33,7 @@ struct perf_mmap {
>   	bool			 overwrite;
>   	u64			 flush;
>   	libperf_unmap_cb_t	 unmap_cb;
> -	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
> +	void			*event_copy;
>   	struct perf_mmap	*next;
>   };
>   
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 2184814b37dd..91ae46aac378 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
>   
>   void perf_mmap__munmap(struct perf_mmap *map)
>   {
> +	free(map->event_copy);
> +	map->event_copy = NULL;
>   	if (map && map->base != NULL) {
>   		munmap(map->base, perf_mmap__mmap_len(map));
>   		map->base = NULL;
> @@ -226,6 +228,13 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
>   			unsigned int len = min(sizeof(*event), size), cpy;
>   			void *dst = map->event_copy;
>   
> +			if (!dst) {
> +				dst = malloc(PERF_SAMPLE_MAX_SIZE);
`event` is used as the return parameter of libperf API 
perf_mmap__read_event().
Is `zalloc` better to avoid dirty data?

Thanks,
Yang
