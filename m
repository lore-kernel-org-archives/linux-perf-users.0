Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA3E5253
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0E90;
	Tue, 24 Oct 2023 20:44:24 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SFZV10fbkzrSB5;
	Wed, 25 Oct 2023 11:41:29 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 25 Oct 2023 11:44:20 +0800
Subject: Re: [PATCH v3 20/50] perf record: Be lazier in allocating lost
 samples buffer
To: Ian Rogers <irogers@google.com>
References: <20231024222353.3024098-1-irogers@google.com>
 <20231024222353.3024098-21-irogers@google.com>
From: Yang Jihong <yangjihong1@huawei.com>
CC: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
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
Message-ID: <7516348d-fe6d-9768-049e-328cfcda89ee@huawei.com>
Date: Wed, 25 Oct 2023 11:44:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231024222353.3024098-21-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected

Hello,

On 2023/10/25 6:23, Ian Rogers wrote:
> Wait until a lost sample occurs to allocate the lost samples buffer,
> often the buffer isn't necessary. This saves a 64kb allocation and
> 5.3kb of peak memory consumption.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
>   1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 9b4f3805ca92..b6c8c1371b39 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
>   static void record__read_lost_samples(struct record *rec)
>   {
>   	struct perf_session *session = rec->session;
> -	struct perf_record_lost_samples *lost;
> +	struct perf_record_lost_samples *lost = NULL;
>   	struct evsel *evsel;
>   
>   	/* there was an error during record__open */
>   	if (session->evlist == NULL)
>   		return;
>   
> -	lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> -	if (lost == NULL) {
> -		pr_debug("Memory allocation failed\n");
> -		return;
> -	}
> -
> -	lost->header.type = PERF_RECORD_LOST_SAMPLES;
> -
>   	evlist__for_each_entry(session->evlist, evsel) {
>   		struct xyarray *xy = evsel->core.sample_id;
>   		u64 lost_count;
> @@ -1961,6 +1953,14 @@ static void record__read_lost_samples(struct record *rec)
>   				}
>   
>   				if (count.lost) {
> +					if (!lost) {
> +						lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> +						if (!lost) {
> +							pr_debug("Memory allocation failed\n");
> +							return;
> +						}
> +						lost->header.type = PERF_RECORD_LOST_SAMPLES;
> +					}
>   					__record__save_lost_samples(rec, evsel, lost,
>   								    x, y, count.lost, 0);
>   				}
> @@ -1968,9 +1968,18 @@ static void record__read_lost_samples(struct record *rec)
>   		}
>   
>   		lost_count = perf_bpf_filter__lost_count(evsel);
> -		if (lost_count)
> +		if (lost_count) {
> +			if (!lost) {
> +				lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> +				if (!lost) {
> +					pr_debug("Memory allocation failed\n");
> +					return;
> +				}
> +				lost->header.type = PERF_RECORD_LOST_SAMPLES;
> +			}
>   			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
>   						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
> +		}
>   	}

Can zalloc for `lost` be moved to __record__save_lost_samples?
This simplifies the code.


diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index dcf288a4fb9a..8d2eb746031a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1888,14 +1888,25 @@ record__switch_output(struct record *rec, bool 
at_exit)
  }

  static void __record__save_lost_samples(struct record *rec, struct 
evsel *evsel,
-                                       struct perf_record_lost_samples 
*lost,
+                                       struct perf_record_lost_samples 
**plost,
                                         int cpu_idx, int thread_idx, 
u64 lost_count,
                                         u16 misc_flag)
  {
         struct perf_sample_id *sid;
         struct perf_sample sample = {};
+       struct perf_record_lost_samples *lost = *plost;
         int id_hdr_size;

+       if (!lost) {
+               lost = zalloc(PERF_SAMPLE_MAX_SIZE);
+               if (!lost) {
+                       pr_debug("Memory allocation failed\n");
+                       return;
+               }
+               lost->header.type = PERF_RECORD_LOST_SAMPLES;
+               *plost = lost;
+       }
+
         lost->lost = lost_count;
         if (evsel->core.ids) {
                 sid = xyarray__entry(evsel->core.sample_id, cpu_idx, 
thread_idx);
@@ -1912,21 +1923,13 @@ static void __record__save_lost_samples(struct 
record *rec, struct evsel *evsel,
  static void record__read_lost_samples(struct record *rec)
  {
         struct perf_session *session = rec->session;
-       struct perf_record_lost_samples *lost;
+       struct perf_record_lost_samples *lost = NULL;
         struct evsel *evsel;

         /* there was an error during record__open */
         if (session->evlist == NULL)
                 return;

-       lost = zalloc(PERF_SAMPLE_MAX_SIZE);
-       if (lost == NULL) {
-               pr_debug("Memory allocation failed\n");
-               return;
-       }
-
-       lost->header.type = PERF_RECORD_LOST_SAMPLES;
-
         evlist__for_each_entry(session->evlist, evsel) {
                 struct xyarray *xy = evsel->core.sample_id;
                 u64 lost_count;
@@ -1949,7 +1952,7 @@ static void record__read_lost_samples(struct 
record *rec)
                                 }

                                 if (count.lost) {
-                                       __record__save_lost_samples(rec, 
evsel, lost,
+                                       __record__save_lost_samples(rec, 
evsel, &lost,
                                                                     x, 
y, count.lost, 0);
                                 }
                         }
@@ -1957,11 +1960,12 @@ static void record__read_lost_samples(struct 
record *rec)

                 lost_count = perf_bpf_filter__lost_count(evsel);
                 if (lost_count)
-                       __record__save_lost_samples(rec, evsel, lost, 0, 
0, lost_count,
+                       __record__save_lost_samples(rec, evsel, &lost, 
0, 0, lost_count,
 
PERF_RECORD_MISC_LOST_SAMPLES_BPF);
         }
  out:
-       free(lost);
+       if (lost)
+               free(lost);
  }

  static volatile sig_atomic_t workload_exec_errno;


Thanks,
Yang
