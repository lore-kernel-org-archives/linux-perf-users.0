Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C37223708
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268605; cv=none; b=U7LHy4dL9LK0n0QabtzB6qlza6v71wK8k2g1s8rX9mbIBkC/DIDmtM8LfjiZE4BCezPz4qHB/W8h9lPqyrEl0xAOjmIq1qJtcrRH1NmVPi7DkebMTFDZ4tgpcFfVYrTC12hs6wYbZmuS8FjRF7WilhBsSVUXkfSskChkqtjsj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268605; c=relaxed/simple;
	bh=obypYOrhKWdkyuMYPEbMk0GcWvupxXNCqCmfQ4rsGRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEmZyrp25n20LJM/orbsIDDhyl7t9FTugzgAH+mNHfKYwGxb3C6HYvOaP+3nRXrlnG99E67qlRk5CsHnF4KOFMPxOfO278ik2ThLa1uSl+wGQke0yAqgOXujTrh0Ae5+DBrBzqsNYv6NE+BKPq89188QLTjOI7DmyDMkmIrm7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNIymlgd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNIymlgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2A2C19425;
	Mon, 27 Apr 2026 05:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777268605;
	bh=obypYOrhKWdkyuMYPEbMk0GcWvupxXNCqCmfQ4rsGRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNIymlgdo0oTA3eNJtxUlaMLmLsWJ5k2PxW1BocXrWDQU/fGnZwd7XyiKIKDHP6/S
	 3W+LkC0Wm7Yf2bOM6g45mUO/k0bxqheNDEw12cW0uEAFV6mRjVTSKvhSuI+3tFPfWh
	 z77yIlKB8CcG1ClkoZPQBWKPi/qKNPnMJrU4XeGOzYJi7a/eXI1lB8z+yKLDO3FZsI
	 jYO6HwLV4I1W7sP8sRkkmtBmEDH1att1jnS7nm3XgTVS+llnClS8tnMbjc6Elq73ah
	 2y5bonhep+xtECwts7P7cZJa/DKCBZy88riEG1lV1xwRSr5l7i1DEQIF4TIW6XzkXe
	 MwW+WQGwc+owQ==
Date: Sun, 26 Apr 2026 22:43:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] powerpc tools perf: Initialize error code in
 auxtrace_record_init function
Message-ID: <ae73ebdFs8hN98u9@google.com>
References: <20260426064301.90614-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260426064301.90614-1-atrajeev@linux.ibm.com>

Hello,

On Sun, Apr 26, 2026 at 12:13:01PM +0530, Athira Rajeev wrote:
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
> With the fix,
> 
>  # ./perf trace record sleep 1
>  [ perf record: Woken up 2 times to write data ]
>  [ perf record: Captured and wrote 0.033 MB perf.data (228 samples) ]

Sounds like you need a Fixes tag.

Thanks,
Namhyung

> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/auxtrace.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
> index e39deff6c857..fe1ea4e222f3 100644
> --- a/tools/perf/arch/powerpc/util/auxtrace.c
> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
> @@ -71,6 +71,19 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>  	struct evsel *pos;
>  	int found = 0;
>  
> +	/*
> +	 * Assign err value to zero here. Any fail later
> +	 * will set appropriate return code to err.
> +	 * Even if we haven't found any event for auxtrace, perf
> +	 * record should continue for other events. NULL return
> +	 * will indicate that there is no auxtrace record initialized.
> +	 *
> +	 * Not having "err" set here will affect monitoring
> +	 * of other events also because perf record will fail seeing
> +	 * random value in err.
> +	 */
> +	*err = 0;
> +
>  	evlist__for_each_entry(evlist, pos) {
>  		if (strstarts(pos->name, "vpa_dtl")) {
>  			found = 1;
> -- 
> 2.47.3
> 
