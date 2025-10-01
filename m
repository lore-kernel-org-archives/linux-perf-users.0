Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27E32EF673;
	Wed,  1 Oct 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327947; cv=none; b=sHOytMioe0jGH0DOli7WRl8LpGVhFRbq8aH1HwNJt3Hnfi28iub2WjAdSdAfw0/WSWl2Ci7tlHzNVylpNyIQUwi5H5F4ebzK2NbKITcDj0CFDUkpVEbHLlIX7usjpRW44+GPic9jcBkpXe9i0bFjiSbUAJEq3/TncNT9sAMyMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327947; c=relaxed/simple;
	bh=Dagdj+pBkU5b35TssFwjm1mScGAsUNjKJeP8NfuSdOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDrJ2HL2MITb7dyLhi5brHkV3Hlx4yRWk0pMFGUxeDaW2YV2DpCsVnx0SUf8B31oJiMiKZQGAfEVK4dhESNvTkIbYUVrz9+CEa2CUqTriTbDjCjryQ7zFjCP8IFD3SY81fZmAvifZl7ZCKt5VTJgJFpSXEAYIjevwLCEjOmnVFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsuwt1em; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsuwt1em"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E00C4CEF1;
	Wed,  1 Oct 2025 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327946;
	bh=Dagdj+pBkU5b35TssFwjm1mScGAsUNjKJeP8NfuSdOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tsuwt1emZB1OiUoepyGEFrxBJJZLMm48v+IgBtFG2KzMHXQuoKVfSqPQWwsHyQ2Lg
	 XMigxHoeSCNe4X3f6W1pqhp8J4Emu4noDDx+AEQgrQxZ96KHd+FEpoeJjU/KAGrMYN
	 CVxW3hcQ+tWzbhN137ZbWBif5GBVNNi/BsnqluXmsx9xx5HBGx3aYOPh4d7eCMiHLv
	 HEAybwfeUj4y4TrJuMwyMkZlLb5ZxBirjvJOhq0Glqvh0N2sD3q7H8lUraNopk0mW7
	 BWRsKNz3pmFV0shR/T0/lP0+6V3MBbvCk4q7QdELW3bpxROQ7IQcGq0DS/u/+F/feN
	 yIOEQjnoAgEYA==
Date: Wed, 1 Oct 2025 11:12:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, jolsa@kernel.org,
	alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH] MAINTAINERS: Remove myself from perf_events subsystem
Message-ID: <aN02x4MxhK3YjI35@x1>
References: <20250925162428.3516894-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925162428.3516894-1-kan.liang@linux.intel.com>

On Thu, Sep 25, 2025 at 09:24:28AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> I'm stepping down as the Reviewer of perf_events subsystem.
> It has been an honor and a pleasure to work with everyone to improve the
> perf_events subsystem. However, due to personal reasons, I have to leave
> Intel. I believe it would be difficult for me to continue in this role
> any further.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

I'm sorry to see you go, best wishes for your next endeavour!

Thanks, applied to perf-tools-next,

- Arnaldo

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..2c788294cf84 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19759,7 +19759,6 @@ R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
>  R:	Jiri Olsa <jolsa@kernel.org>
>  R:	Ian Rogers <irogers@google.com>
>  R:	Adrian Hunter <adrian.hunter@intel.com>
> -R:	"Liang, Kan" <kan.liang@linux.intel.com>
>  L:	linux-perf-users@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
> -- 
> 2.38.1
