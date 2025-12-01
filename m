Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190AC21CC4F;
	Mon,  1 Dec 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608737; cv=none; b=N0I5DBaXOQe0Voeq67qxIS4ZLqyz7bWLCkpOf2S9RSO5ZDuc7A/DYaIZVZMUhcOpAja/k1yl7P796imXuTge9DmTJ6VOzI4tJbFhauAzgq0D9gZMaNSeUS7ee7NurnmqiaRw2EUZ6xy3YIrAhIuEt7R4+4XQF6KWJyl/yZDR+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608737; c=relaxed/simple;
	bh=DDxpwuLF06Gfy57oEvUhVKW6teXyjsVAbvLpu4cwAoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k85W3FHEw5qG1LKRu3KYN+S4s8DJXpGdAEZdRNj3437QQJ4slBNpArd23nlQ4sdGfClDoosIYWQMGMf99Cvw8nr3WVW68ueeOi9qznp1gWXqwUBgLEoEHGsz5X611uARE/XYi2c/A+OX2DYd7kZVQ9wEdTGfKRMYND0Jnn+zqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNDG/Ev9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNDG/Ev9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22801C4CEF1;
	Mon,  1 Dec 2025 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764608734;
	bh=DDxpwuLF06Gfy57oEvUhVKW6teXyjsVAbvLpu4cwAoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNDG/Ev95cxt42ASLD1Mdn2o5pGTmQ1w8lrYa4N5pKqtkTHZozVX2CdZMTUhMss3p
	 8sWOBvrvdmPS6wN1m0F1VBDYFZhVobznnWeC0kNm1nd77cOHxPDqTJ1LHIyfy+MVEc
	 71GSCjJAN28RA1igOFWxBp6xrcwiVcIn4WnNFb+zHU1DpuquxnVEusRoJd+GKyjn6a
	 OOH8ZbwY+f44HR3Dc1YE5LeEweAyAhSx9P0pzl6epYZhtAaOUmU9LLJvHxP7cjKo+3
	 j6stzrkNwCPCWrt6g9KcLpqEB8tTWLmvab49JWIG++xBNl+Zsz6r2kCsdeplB8C17s
	 nf1l+9L/3kK/A==
Date: Mon, 1 Dec 2025 14:05:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 06/17] perf hist: In init, ensure mem_info is put on
 error paths
Message-ID: <aS3K0zgkQlUzMIhe@x1>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122081929.7588-7-irogers@google.com>

On Sat, Nov 22, 2025 at 12:19:18AM -0800, Ian Rogers wrote:
> Rather than exit the internal map_symbols directly, put the mem-info
> that does this and also lowers the reference count on the mem-info
> itself otherwise the mem-info is being leaked.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/hist.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 64ff427040c3..ef4b569f7df4 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -608,10 +608,8 @@ static int hist_entry__init(struct hist_entry *he,
>  		map_symbol__exit(&he->branch_info->to.ms);
>  		zfree(&he->branch_info);
>  	}
> -	if (he->mem_info) {
> -		map_symbol__exit(&mem_info__iaddr(he->mem_info)->ms);
> -		map_symbol__exit(&mem_info__daddr(he->mem_info)->ms);
> -	}
> +	if (he->mem_info)
> +		mem_info__zput(he->mem_info);
>  err:
>  	map_symbol__exit(&he->ms);
>  	zfree(&he->stat_acc);
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 
