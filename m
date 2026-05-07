Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF625A655
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778134425; cv=none; b=RFTD1EWCtx+nBgHG/upjwHyQKP9R1JtPSSAKV/TsexsE1kAV33HHnHqOq5gTG9TR78opCiF2rYsNLQDqexjiQNHcPjwM7YwLVatBOLHk+MAdRjGJcioKoPHXwSJUqFIKkJYFOpnAtPr8rFf9U4M+Y6F//i/kcqJPS2ybM+jCtE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778134425; c=relaxed/simple;
	bh=/fOGlmO82MYiNksLou9+DYkXXjNNOJOZwge6qWlpEOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coh96cQfNzwQKamXbYtIS304z04N024N6ycgf/8QlCyN/1cigsuLyK5fbcoku8FDfSHVupIzbjA19r6vcD4k6Krml1HoME0XdTbHUstxfV1KU9j3BKyRWBZ2/7FdXTV054l4O4b407SYH1Hu1104mPSUGDe3cgptJOMie2+XS1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1SL7zhc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1SL7zhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC05FC2BCB8;
	Thu,  7 May 2026 06:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778134425;
	bh=/fOGlmO82MYiNksLou9+DYkXXjNNOJOZwge6qWlpEOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1SL7zhcohHCqXKMWZaPdXcpgQgH1z7X+h9hV9UYekMxS+z1I7N0h0S6dNL17ETII
	 pU1/MD4NxjxqlqdmtcDQYIWp2Uxj1ppSZpVZzwJIsPEZDVzheL42ggqSC3q/MOg9Fr
	 2t4ghNTIksaiIb1OG4X/x7EzvYDPRZWg2xOl5YfYGdmK8BPbnrcVdcFazrHsLGIExv
	 hZeWhlVnqv87dqwf+ycQ71pa0zI5yaerTfmMoteWPpm+u6z9Nf/XSn0mUC5fKo5hsF
	 9hgbLhVGUspGMJjz4KNalpYCB4+SL7yUGnHYrLwr82EaugvtGv48TGeZ4C9EvB1AJh
	 7BjDjivXaZJbA==
Date: Wed, 6 May 2026 23:13:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	shivani@linux.ibm.com
Subject: Re: [PATCH V5 1/2] powerpc tools perf: Initialize error code in
 auxtrace_record_init function
Message-ID: <afwtl1zodrSUpK7n@z2>
References: <20260504151321.12346-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504151321.12346-1-atrajeev@linux.ibm.com>

On Mon, May 04, 2026 at 08:43:20PM +0530, Athira Rajeev wrote:
> perf trace record fails some cases in powerpc
> 
>  # ./perf test "perf trace record and replay"
>  128: perf trace record and replay                                    : FAILED!
> 
>  # ./perf trace record sleep 1
>  # echo $?
>    32
> 
> This is happening because of non-zero err value from
> auxtrace_record__init() function.
> 
>  static int record__auxtrace_init(struct record *rec)
>  {
>         int err;
> 
>         if ((rec->opts.auxtrace_snapshot_opts || rec->opts.auxtrace_sample_opts)
>             && record__threads_enabled(rec)) {
>                 pr_err("AUX area tracing options are not available in parallel streaming mode.\n");
>                 return -EINVAL;
>         }
> 
>         if (!rec->itr) {
>                 rec->itr = auxtrace_record__init(rec->evlist, &err);
>                 if (err)
>                         return err;
>         }
> 
> Here "int err" is not initialised. The code expects "err" to be set
> from auxtrace_record__init() function.
> 
> Update auxtrace_record__init() in arch/powerpc/util/auxtrace.c to clear
> err value in the beginning.
> 
> - Clear err value in beginning of function. Any fail later will
> set appropriate return code to err.
> - Even if we haven't found any event for auxtrace, perf record
> should continue for other events. NULL return
> will indicate that there is no auxtrace record initialized.
> - Not having "err" set here will affect monitoring of other events
> also because perf record will fail seeing random value in err.
> 
> Set err to -EINVAL before invoking auxtrace_record__init() in
> builtin-record.c
> 
> With the fix,
> 
>  # ./perf trace record sleep 1
>  [ perf record: Woken up 2 times to write data ]
>  [ perf record: Captured and wrote 0.033 MB perf.data (228 samples) ]
> 
> Fixes: 1dbfaf94cf66 ("perf powerpc: Add basic CONFIG_AUXTRACE support for VPA pmu on powerpc")
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

For both patches,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> Changelog:
> v4:
> Added Reviewed-by from Adrian
> 
> v1 -> v2
> Addressed review comment from Adrian:
> - Set err to -EINVAL before invoking auxtrace_record__init() in
>   builtin-record.c
> - Added kernel-doc to auxtrace_record__init() in tools/perf/util/auxtrace.c
> Addressed review comment from Namhyung:
> - Added fixes tag
> 
>  tools/perf/arch/powerpc/util/auxtrace.c | 6 ++++++
>  tools/perf/builtin-record.c             | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
> index e39deff6c857..4600a1661b4f 100644
> --- a/tools/perf/arch/powerpc/util/auxtrace.c
> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
> @@ -71,6 +71,12 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>  	struct evsel *pos;
>  	int found = 0;
>  
> +	/*
> +	 * Set err value to zero here. Any fail later
> +	 * will set appropriate return code to err.
> +	 */
> +	*err = 0;
> +
>  	evlist__for_each_entry(evlist, pos) {
>  		if (strstarts(pos->name, "vpa_dtl")) {
>  			found = 1;
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4a5eba498c02..708825747af5 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -865,6 +865,7 @@ static int record__auxtrace_init(struct record *rec)
>  	}
>  
>  	if (!rec->itr) {
> +		err = -EINVAL;
>  		rec->itr = auxtrace_record__init(rec->evlist, &err);
>  		if (err)
>  			return err;
> -- 
> 2.47.3
> 
