Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EB819FA86;
	Thu, 12 Sep 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168737; cv=none; b=GvtJkqdtkHx5DNY9uFSQMzmgjiswsIlMhdsoSq6P7SDMWzlWKQRkn3e7T3xR6hJDHuuSCQPt5ZFfRN/hxXUzmu0l/70KNo1mcOKgvx2C+rD9gR/jKAmfyCfSjoBve1VHlHFAvXp5Y+DLbG9hB12U1U+GQyfmcL/vSiwRQzqbh64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168737; c=relaxed/simple;
	bh=6VvmHk310H2pDM3uIfZd+otM8qPMdy6gwUmX7kT0Hkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT8DGSnZL7ovIVVmNGkX5XBiOYlAY7mQ2RKoqDcJTgIpi/XP7d9UQqB6qen99mFThiGCXWtodSbaiMTh3zrlwN8pib8dNhg0LYgj11k/TIHl50NSV6LiTFZqt8U+fJ6rrgOFTM8MUSIyRVVaq9ngXLqcOHaTpH43gRwszZsmiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/IKxY21; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/IKxY21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E942C4CEC6;
	Thu, 12 Sep 2024 19:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726168736;
	bh=6VvmHk310H2pDM3uIfZd+otM8qPMdy6gwUmX7kT0Hkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/IKxY217iyVi5tdaS/n1i197pc4ox5J9FYqB89rtglw/I/3ZjIsOnus1+ZOBTCMe
	 vSc8ggTPT182Ve84h63EHiXBpe+hOo8+3WYDAZzBW/9cK4V7nJRTPyixKy4Qf9SmHh
	 SvodvKpsptYD4FquxQdas4SWsNn2wyywR9tvPQ6fJ/yuRFBI9BXZfAbwhy0UObOcxD
	 iG1ca7KSk4CNdJDI4vqultZtZj2qFFghzSsFw2ltwERpbyVeiCcwaRsheGWz7lLJ5b
	 xss6qSU/JXLiElPSrNGPfyH7afI9MTIECj2CsbUm95EARuMzdU/wH8eiqE/GMEZy7L
	 YtmFiHfkftGpQ==
Date: Thu, 12 Sep 2024 16:18:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Junhao He <hejunhao3@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/13] perf pmu: Simplify an asprintf error message
Message-ID: <ZuM-natFYgtS5wwL@x1>
References: <20240912190341.919229-1-irogers@google.com>
 <20240912190341.919229-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912190341.919229-2-irogers@google.com>

On Thu, Sep 12, 2024 at 12:03:28PM -0700, Ian Rogers wrote:
> Use ifs rather than ?: to avoid a large compound statement.

Cherry picked this one.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 61bdda01a05a..779db2ac06f0 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1466,13 +1466,12 @@ static int pmu_config_term(const struct perf_pmu *pmu,
>  		if (err) {
>  			char *err_str;
>  
> -			parse_events_error__handle(err, term->err_val,
> -				asprintf(&err_str,
> -				    "value too big for format (%s), maximum is %llu",
> -				    format->name, (unsigned long long)max_val) < 0
> -				    ? strdup("value too big for format")
> -				    : err_str,
> -				    NULL);
> +			if (asprintf(&err_str,
> +				     "value too big for format (%s), maximum is %llu",
> +				     format->name, (unsigned long long)max_val) < 0) {
> +				err_str = strdup("value too big for format");
> +			}
> +			parse_events_error__handle(err, term->err_val, err_str, /*help=*/NULL);
>  			return -EINVAL;
>  		}
>  		/*
> -- 
> 2.46.0.662.g92d0881bb0-goog
> 
