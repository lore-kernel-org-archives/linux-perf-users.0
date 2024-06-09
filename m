Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C86A3F;
	Sun,  9 Jun 2024 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717900270; cv=none; b=q+ekQiccYD3E8AMfHMiZAL6+5d3FbUiUAzQl90wkLzXV3RmeKifC1T20s+f3rWRVDrghmt7ElVQ78CS0ngdl/23Yw+GnY7oENeO+v3jxs7AFhpE59e72t3693lv3Fwi+SKzJNwkZGrgDP7f3MScivPd6lg2xsH9Shs4f/3zs1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717900270; c=relaxed/simple;
	bh=RimMKfclsGPvJiI/BEOm16GPf0mGYGXXaBBnCfkkSms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCsC+4G+h/X9b5Fop3E3zVnS7qtmNX6UH0vvvLTSborgvulJNGllRLta16BhhaEHJzxabCc94ArSdEUXLIFG9RKPWlsx/SQsJFfp52eccnu0dfxFXzPhvuZj5vobdygtLhhTzEFEvRTVwFIeWUho/T90OvwvQkjH8TVrowfbi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+6B8fRt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+6B8fRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3822EC2BD11;
	Sun,  9 Jun 2024 02:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717900269;
	bh=RimMKfclsGPvJiI/BEOm16GPf0mGYGXXaBBnCfkkSms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+6B8fRtaerzTWUY9neUkoQ0lqwulx/SPHrSo8IO+v9uCRn3U90YhXC9vpjCeD80w
	 TWIlSfy565is4Ehq6RJ4CqXpMcgc1Q4LyL7Hn6nB/avqQ8ab9K4uKbxXm2tc9i9o3V
	 bBIhqm2hpOQQtVvqTUous8MUZLD6WaY3AEKPa0JAl+XaII6cotvGiFUQtQ4VR/skfg
	 vdY+N/lOJyTh+to1Rhn5Oc0IopB+7reEWusPQpo8tA/HVuVMY3pGmQqpGnaqiu6aCe
	 0r1Weg0oHBB3xU0/C3b5MClWNuBZfUdPfiBl4PngCk82guZUMHJpAtBJ+d1GE24aFf
	 zFTdKj5G43ztg==
Date: Sat, 8 Jun 2024 19:31:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v1] perf record: Ensure space for lost samples
Message-ID: <ZmUT6qNB_ghSCibT@google.com>
References: <20240607204727.849174-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607204727.849174-1-irogers@google.com>

On Fri, Jun 07, 2024 at 01:47:27PM -0700, Ian Rogers wrote:
> Previous allocation didn't account for sample ID written after the
> lost samples event. Switch from malloc/free to a stack allocation.
> 
> Reported-by: Milian Wolff <milian.wolff@kdab.com>
> Closes: https://lore.kernel.org/linux-perf-users/23879991.0LEYPuXRzz@milian-workstation/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/include/perf/event.h |  3 +++
>  tools/perf/builtin-record.c         | 37 ++++++++++-------------------
>  2 files changed, 15 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index ae64090184d3..8f3cefef9069 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -77,6 +77,9 @@ struct perf_record_lost_samples {
>  	__u64			 lost;
>  };
>  
> +#define MAX_ID_HDR_ENTRIES  6
> +#define PERF_RECORD_MAX_LOST_SAMPLE_AND_ID_SIZE \
> +	(sizeof(struct perf_record_lost_samples) + MAX_ID_HDR_ENTRIES * sizeof(__u64))
>  /*
>   * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID | PERF_FORMAT_LOST
>   */
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 66a3de8ac661..1615a1723fb9 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1926,7 +1926,10 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
>  static void record__read_lost_samples(struct record *rec)
>  {
>  	struct perf_session *session = rec->session;
> -	struct perf_record_lost_samples *lost = NULL;
> +	union {
> +		struct perf_record_lost_samples lost;
> +		char lost_and_sample_id[PERF_RECORD_MAX_LOST_SAMPLE_AND_ID_SIZE];
> +	} lost;

Can we make it struct and keep the sample_id part only?

Other than that, looks good to me.

Thanks,
Namhyung

>  	struct evsel *evsel;
>  
>  	/* there was an error during record__open */
> @@ -1951,20 +1954,13 @@ static void record__read_lost_samples(struct record *rec)
>  
>  				if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
>  					pr_debug("read LOST count failed\n");
> -					goto out;
> +					return;
>  				}
>  
>  				if (count.lost) {
> -					if (!lost) {
> -						lost = zalloc(sizeof(*lost) +
> -							      session->machines.host.id_hdr_size);
> -						if (!lost) {
> -							pr_debug("Memory allocation failed\n");
> -							return;
> -						}
> -						lost->header.type = PERF_RECORD_LOST_SAMPLES;
> -					}
> -					__record__save_lost_samples(rec, evsel, lost,
> +					memset(&lost, 0, sizeof(lost));
> +					lost.lost.header.type = PERF_RECORD_LOST_SAMPLES;
> +					__record__save_lost_samples(rec, evsel, &lost.lost,
>  								    x, y, count.lost, 0);
>  				}
>  			}
> @@ -1972,21 +1968,12 @@ static void record__read_lost_samples(struct record *rec)
>  
>  		lost_count = perf_bpf_filter__lost_count(evsel);
>  		if (lost_count) {
> -			if (!lost) {
> -				lost = zalloc(sizeof(*lost) +
> -					      session->machines.host.id_hdr_size);
> -				if (!lost) {
> -					pr_debug("Memory allocation failed\n");
> -					return;
> -				}
> -				lost->header.type = PERF_RECORD_LOST_SAMPLES;
> -			}
> -			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
> +			memset(&lost, 0, sizeof(lost));
> +			lost.lost.header.type = PERF_RECORD_LOST_SAMPLES;
> +			__record__save_lost_samples(rec, evsel, &lost.lost, 0, 0, lost_count,
>  						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
>  		}
>  	}
> -out:
> -	free(lost);
>  }
>  
>  static volatile sig_atomic_t workload_exec_errno;
> @@ -3198,7 +3185,7 @@ static int switch_output_setup(struct record *rec)
>  	unsigned long val;
>  
>  	/*
> -	 * If we're using --switch-output-events, then we imply its 
> +	 * If we're using --switch-output-events, then we imply its
>  	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
>  	 *  thread to its parent.
>  	 */
> -- 
> 2.45.2.505.gda0bf45e8d-goog
> 
