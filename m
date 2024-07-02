Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129681DA32A;
	Tue,  2 Jul 2024 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964296; cv=none; b=pNXU74MwmJfPO4IC1ZqIkzIvU/czMrGwpeUdx+VgqFum1JkWlJ/OCZkj2UvBUxiO4QNX5q04gFIsz44kSyqGYBWPtcZsfCU2j2vkIEllt35nwU+i6Byu+U8FsmoaMzqC0aZr1yW9voNf4bs+E/sJY5JhscEIMgn8B1jBvEIOn4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964296; c=relaxed/simple;
	bh=nHz1v+q1b/0YjOK5wXThuki6AqlPU0j88B9fgnPTwbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3k/kcsn1vg045ygX7VK5FnZD8WeAR4XUus5DEBI/XACRffchWLSJz4Fu79jjgQRNhvLXhCA86+I4UyNPFBBb3GtK4ZqRyHzhisjfkSjWS7CLejGeTxMkAYqH7UeaBKSArqmq2x6d5AU/nwcTaQTynk4U9lhZW16qZyLmVWrrfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POYSzhvo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POYSzhvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774DEC116B1;
	Tue,  2 Jul 2024 23:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964295;
	bh=nHz1v+q1b/0YjOK5wXThuki6AqlPU0j88B9fgnPTwbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POYSzhvokRm1+Seu5OWbvFI0887OQO7wkAHLFB/bs4uT40FVL4m73PGnZMuyKFTAH
	 xlclxCPB7hqAXTgg9lKYpmY435GWUvmlic7us6q4mARf4fa5+iKTNbmRWs6m63kqKz
	 wvnzjA3kT4VuKGDwZxHBM7P3uZY0apDhujjz9BAOlLkgPJ8SKPVgF7AIc2jcBG1aW8
	 nvHbfCl/+NGo3CL3V75Wy/E9R+6weH7Ets50R7wV4oZnznnEzJQjyIajwD2EIoyzRI
	 GjZ3RkF/21nG4WC54eCTzYS3vOVtXD7lQijB3VJ205Hz6CPZcK/IRaxI0kddm7bQNm
	 4LLLlzocB+TtA==
Date: Tue, 2 Jul 2024 16:51:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] perf pmu: remove one dupliacte ';'
Message-ID: <ZoSShvCcFSQPQvzJ@google.com>
References: <20240701030339.56424-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701030339.56424-1-xu.yang_2@nxp.com>

Hello,

On Mon, Jul 01, 2024 at 11:03:39AM +0800, Xu Yang wrote:
> Remove one dupliacte ';' in function perf_pmu__num_events().
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Thanks for the fix but it's already fixed.

https://lore.kernel.org/linux-perf-users/20240628053049.44521-1-yang.lee@linux.alibaba.com/

Namhyung

> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 888ce9912275..d8726ec5368d 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1765,7 +1765,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>  	size_t nr;
>  
>  	pmu_aliases_parse(pmu);
> -	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;;
> +	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
>  
>  	if (pmu->cpu_aliases_added)
>  		 nr += pmu->cpu_json_aliases;
> -- 
> 2.34.1
> 
