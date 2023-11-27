Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56E36AEB
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+a5RdsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E386C433C7;
	Mon, 27 Nov 2023 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701122616;
	bh=sgOJ6U7HZ+AC7XaG2fCShwuNmSNdLJ8YQTkNUpN7nZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+a5RdsPeiaQ54NWiK+EKzu7bs8ByxbFAfEqornh3xkrEW1HwUB5TmXEccV/B9y0j
	 uRzqKrEVkO3tif+P3BGK5r6o9Shp1bznyFfc5mzQQOO7oPLwfee7XzW8kqTlUDtMKk
	 opeVtzHxo0dP0WHtPgXd84285qsrKKtdyy5dDdgTajhgduZUbiYgRzGCB///T/zVY0
	 RMa0JupNUOs30FbsdfQd2fmVkcCj3vQTsJJZ5/OPG4HIca9ZvgGxOfKZhpIt75O+pR
	 h3ur5N9/n0Kc4x1J8ySnaBcxEzYm4DavvWmssohucTyp/YxNZmPKjvSimtF3eYOiad
	 jdIVXf5ciUY/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id AB4FA40094; Mon, 27 Nov 2023 19:03:32 -0300 (-03)
Date: Mon, 27 Nov 2023 19:03:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v4 10/53] perf record: Be lazier in allocating lost
 samples buffer
Message-ID: <ZWUSNLmApMByu94B@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102175735.2272696-11-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 02, 2023 at 10:56:52AM -0700, Ian Rogers escreveu:
> Wait until a lost sample occurs to allocate the lost samples buffer,
> often the buffer isn't necessary. This saves a 64kb allocation and
> 5.3kb of peak memory consumption.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 9b4f3805ca92..b6c8c1371b39 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
>  static void record__read_lost_samples(struct record *rec)
>  {
>  	struct perf_session *session = rec->session;
> -	struct perf_record_lost_samples *lost;
> +	struct perf_record_lost_samples *lost = NULL;
>  	struct evsel *evsel;
>  
>  	/* there was an error during record__open */
>  	if (session->evlist == NULL)
>  		return;
>  
> -	lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> -	if (lost == NULL) {
> -		pr_debug("Memory allocation failed\n");
> -		return;
> -	}

Shouldn't we take the time here and instead improve this error message
and then propagate the error?

For instance, we may want to still get some perf.data file without these
records but inform the user at this point how many records were lost
(count.lost)?

- Arnaldo

> -
> -	lost->header.type = PERF_RECORD_LOST_SAMPLES;
> -
>  	evlist__for_each_entry(session->evlist, evsel) {
>  		struct xyarray *xy = evsel->core.sample_id;
>  		u64 lost_count;
> @@ -1961,6 +1953,14 @@ static void record__read_lost_samples(struct record *rec)
>  				}
>  
>  				if (count.lost) {
> +					if (!lost) {
> +						lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> +						if (!lost) {
> +							pr_debug("Memory allocation failed\n");
> +							return;
> +						}
> +						lost->header.type = PERF_RECORD_LOST_SAMPLES;
> +					}
>  					__record__save_lost_samples(rec, evsel, lost,
>  								    x, y, count.lost, 0);
>  				}
> @@ -1968,9 +1968,18 @@ static void record__read_lost_samples(struct record *rec)
>  		}
>  
>  		lost_count = perf_bpf_filter__lost_count(evsel);
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
>  			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
>  						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
> +		}
>  	}
>  out:
>  	free(lost);
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

-- 

- Arnaldo
