Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE03597B;
	Fri,  2 Jan 2026 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767391976; cv=none; b=eqXoqss6P9elRP9I/nF1Rfck+uYTCTYBjZXkRvRiM1rv2kIp2m5R8RtPsuTvtai6kGvortdZnVV58f7MzQiBKisUPKfEoStFhWygkDxheQDRFFLvrE5rRrVheX21zCeLtTFLXdugRdLz0GXmPTS30R24n63gSy5sMHywH9YOuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767391976; c=relaxed/simple;
	bh=t/zS0AUdilEeOtzoweZ9oAdExTOY3LYJutsJmfHnwtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecZ4qhsD3ZtmOgAhjxf9ccsR5OuVMav5Vk2J+d9cVmqI5WxCXmkW59g7qLRwhGTOmGtWdxyzqBdh5aNEQf5vgXoDwaCWLHUPQw6sqKFWzbD4BdbQ+S3gIXS+LzlDXezUBliSBuVAf+yaGGxlWdAfuKEAGtouN3NfbyR8EIWeWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5mTRsMj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5mTRsMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D6DC116B1;
	Fri,  2 Jan 2026 22:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767391976;
	bh=t/zS0AUdilEeOtzoweZ9oAdExTOY3LYJutsJmfHnwtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5mTRsMj/nwDXaA2ZaoIczu9jdOAvKzDgtKFh7fopYU7zZe484QoS1NKnJ+BZDwW8
	 2KSpgiXTcBkZYOqQZnLtoUO0xOVpbUE9Z91kZi8DjMqwaTN5HHfHZv1W2c59vW2dEh
	 Y7Z1vVNw/51u+ThjHMNxu41oM/6ygY7j4aigPdp6FulHMm7KItrWNmbRhTAIgxYnh/
	 4NaGPRU5V4hJ2Q5xKE1o4TtvRraixgQyF74zmX61nan9fWpw6U31g6ZSnxYv823+Gq
	 SKI8Ken7RfxS9Y1wc9FuNpZHncxE/SAkfGHONrz8ckRZZs2872RRZ0ffz9rhtBITBZ
	 k0JZT+e8Z0+Pw==
Date: Fri, 2 Jan 2026 14:12:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com,
	quic_zhonhan@quicinc.com, thomas.falcon@intel.com,
	blakejones@google.com, ashelat@redhat.com, leo.yan@arm.com,
	dvyukov@google.com, ak@linux.intel.com, yujie.liu@intel.com,
	graham.woodward@arm.com, ben.gainey@arm.com, vineethr@linux.ibm.com,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	santosh.shukla@amd.com, sandipan.das@amd.com
Subject: Re: [PATCH RESEND v4 01/11] perf: Add print_separator to util
Message-ID: <aVhC40oJIx1cbfiJ@google.com>
References: <20250909114227.58802-1-swapnil.sapkal@amd.com>
 <20250909114227.58802-2-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909114227.58802-2-swapnil.sapkal@amd.com>

Hello,

Sorry for the delay and happy new year!

On Tue, Sep 09, 2025 at 11:42:17AM +0000, Swapnil Sapkal wrote:
> Add print_separator to util.c and use it wherever necessary.
> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  tools/perf/builtin-kwork.c | 13 ++++---------
>  tools/perf/util/util.c     |  6 ++++++
>  tools/perf/util/util.h     |  2 ++
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index d2e08de5976d..842f59ff85ac 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -1340,11 +1340,6 @@ static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
>  	[KWORK_CLASS_SCHED]     = &kwork_sched,
>  };
>  
> -static void print_separator(int len)
> -{
> -	printf(" %.*s\n", len, graph_dotted_line);
> -}
> -
>  static int report_print_work(struct perf_kwork *kwork, struct kwork_work *work)
>  {
>  	int ret = 0;
> @@ -1458,7 +1453,7 @@ static int report_print_header(struct perf_kwork *kwork)
>  	}
>  
>  	printf("\n");
> -	print_separator(ret);
> +	print_separator(ret, "", 0);
>  	return ret;
>  }
>  
> @@ -1633,7 +1628,7 @@ static void top_print_header(struct perf_kwork *kwork __maybe_unused)
>  		     PRINT_RUNTIME_HEADER_WIDTH + RPINT_DECIMAL_WIDTH, "RUNTIME",
>  		     PRINT_TASK_NAME_WIDTH, "COMMAND");
>  	printf("\n ");
> -	print_separator(ret);
> +	print_separator(ret, "", 0);
>  }
>  
>  static int top_print_work(struct perf_kwork *kwork __maybe_unused, struct kwork_work *work)
> @@ -1933,11 +1928,11 @@ static int perf_kwork__report(struct perf_kwork *kwork)
>  		}
>  		next = rb_next(next);
>  	}
> -	print_separator(ret);
> +	print_separator(ret, "", 0);
>  
>  	if (kwork->summary) {
>  		print_summary(kwork);
> -		print_separator(ret);
> +		print_separator(ret, "", 0);
>  	}
>  
>  	print_bad_events(kwork);
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 0f031eb80b4c..1b91834e11de 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -257,6 +257,12 @@ static int rm_rf_kcore_dir(const char *path)
>  	return 0;
>  }
>  
> +void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt)
> +{
> +	printf("%.*s%s%.*s\n", pre_dash_cnt, graph_dotted_line, s, post_dash_cnt,
> +	       graph_dotted_line);
> +}

I think it's better to keep the existing interface and add a new one
like print_separator2() for your case.  The old one can be implemented
on top of the new API.

Thanks,
Namhyung

> +
>  int rm_rf_perf_data(const char *path)
>  {
>  	const char *pat[] = {
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 3423778e39a5..de69384380c2 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -48,6 +48,8 @@ bool sysctl__nmi_watchdog_enabled(void);
>  
>  int perf_tip(char **strp, const char *dirpath);
>  
> +void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt);
> +
>  #ifndef HAVE_SCHED_GETCPU_SUPPORT
>  int sched_getcpu(void);
>  #endif
> -- 
> 2.43.0
> 
