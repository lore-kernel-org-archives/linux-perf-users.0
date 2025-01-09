Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9A1FF7DA;
	Thu,  9 Jan 2025 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459963; cv=none; b=b96itsDCEoFZXi44JjC9GVgJXv/PCx3rP/WYo0iLdm3qOtY9C4FU6ocAMuYs0071d14WQtDIDfL3gaUKCUctuIh9Ckf+nTPOvGWSTu8w42Y8IF/G3yiVYcudcRv7lyWj3lVuC+W0DTa0PcBtpKWhrTnj3S5kZAaqSYjDKJZlkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459963; c=relaxed/simple;
	bh=wgnrueW2KTz/YQ+8VSZFZuvQjF++k0V4hRfHB/fw35M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r68f06hotvZrwxmfjHIG20dqYPMLIgbZ0wcX6/wuRSevfcimFTcMeAYr7Kd5dUgYYpdp1DqB33nk3/2mufrX/aatRgQThBFgzc9pTk631iSdo0QrU4ZSVi/5orGpTOmt0SszfWBiYYfpLYB4HED9HNyUsaHXg+QJeN3WH6wkF0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJmFEruu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJmFEruu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD4EC4CED2;
	Thu,  9 Jan 2025 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736459963;
	bh=wgnrueW2KTz/YQ+8VSZFZuvQjF++k0V4hRfHB/fw35M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJmFEruuS18XlHojvNRsvfu05DzusjPKTiqxa95ABq5Hb/bDkM3449/ao+uN7YB8d
	 cgGAqow3s71G5fvs+vZ00sLUuHT12AprpXKc1hUq+GT0+mjICKu1sf04Hp+84X8gHo
	 pbb9B28Bh9EdFchvxzmJ+C5wYITqjCz1IeLAnVVdG2QoMcQFY00jKHsJMQ35mRPRJo
	 6BoZZJ97dfyuw7gYXKEilDtaeczPR7HRXeLWZuDxQS5sMGGuo4l85/MoeyQax8qfKE
	 LZLUdIHYqtvKc72Hb3UFUZm6SlnL3EH7DriA3A0LRcZR1bso8/XUpM3MEM8P8JZYJg
	 C4Z95qp+tc6mg==
Date: Thu, 9 Jan 2025 13:59:21 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf hist: Fix bogus profiles when filters are
 enabled
Message-ID: <Z4BGuYG-V9H4wk9i@google.com>
References: <cover.1736321686.git.dvyukov@google.com>
 <177603055d58e3d82e38f236f3be9fa52dc2d2c5.1736321686.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177603055d58e3d82e38f236f3be9fa52dc2d2c5.1736321686.git.dvyukov@google.com>

On Wed, Jan 08, 2025 at 08:36:54AM +0100, Dmitry Vyukov wrote:
> When a filtered column is not present in the sort order, profiles become
> arbitrary broken. Filtered and non-filtered entries are collapsed
> together, and the filtered-by field ends up with a random value (either
> from a filtered or non-filtered entry). If we end up with filtered
> entry/value, then the whole collapsed entry will be filtered out and will
> be missing in the profile. If we end up with non-filtered entry/value,
> then the overhead value will be wrongly larger (include some subset
> of filtered out samples).
> 
> This leads to very confusing profiles. The problem is hard to notice,
> and if noticed hard to understand. If the filter is for a single value,
> then it can be fixed by adding the corresponding field to the sort order
> (provided user understood the problem). But if the filter is for multiple
> values, it's impossible to fix b/c there is no concept of binary sorting
> based on filter predicate (we want to group all non-filtered values in
> one bucket, and all filtered values in another).
> 
> Examples of affected commands:
> perf report --tid=123
> perf report --sort overhead,symbol --comm=foo,bar
> 
> Fix this by considering filtered status as the highest priority
> sort/collapse predicate.

Do you mean when you specify filters not in a sort list?

I guess it's an undefined behavior.. probably better to warn users not
to do that and exit.  The hist entries are built using only the fields
in the sort list.  Filtering by unspecified fields would be meaningless
and won't work well IMHO.

> 
> As a side effect this effectively adds a new feature of showing profile
> where several lines are combined based on arbitrary filtering predicate.
> For example, showing symbols from binaries foo and bar combined together,
> but not from other binaries; or showing combined overhead of several
> particular threads.

I'm not sure I'm following.  I'm seeing this even with your change.

Without filters:

  $ ./perf report -s dso --stdio -q
      98.41%  perf                
       1.11%  [kernel.kallsyms]   
       0.41%  ld-linux-x86-64.so.2
       0.05%  libLLVM-16.so.1     
       0.03%  libc.so.6           
  
  
With filter:

  $ ./perf report -s dso -d '[kernel.kallsyms],libc.so.6' --stdio -q
       1.11%  [kernel.kallsyms]
       0.03%  libc.so.6        

You said you want to have them combined together, right?
But I think the current behavior makes more sense.

Thanks,
Namhyung

> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/perf/util/hist.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 8e4e844425370..b70170d854a0c 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -1303,9 +1303,18 @@ hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
>  	typedef int64_t (*fn_t)(struct perf_hpp_fmt *, struct hist_entry *, struct hist_entry *);
>  	struct hists *hists = left->hists;
>  	struct perf_hpp_fmt *fmt;
> -	int64_t cmp = 0;
> +	int64_t cmp;
>  	fn_t fn;
>  
> +	/*
> +	 * Never collapse filtered and non-filtered entries.
> +	 * Note this is not the same as having an extra (invisible) fmt
> +	 * that corresponds to the filtered status.
> +	 */
> +	cmp = (int64_t)!!left->filtered - (int64_t)!!right->filtered;
> +	if (cmp)
> +		return cmp;
> +
>  	perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
>  		if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
>  		    !perf_hpp__defined_dynamic_entry(fmt, hists))
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
