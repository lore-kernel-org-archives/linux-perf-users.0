Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3766A3DA5CE;
	Thu,  2 Apr 2026 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152767; cv=none; b=bXZMvdNfgUEn3BkUix8DpOvUTPeb+YisjiJdH7dfljStb2ElWA68WZ2aBX4KUrjvCTd+UUspogJhwuzzHm4EIFnUwJJTPzWsRivQoH81ZNccTDk/qtNbGI6lNnC/zZnUj4SO5rpdyi8Wd79GEqVgeIOMT0gh6lDtSJgXn3RkdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152767; c=relaxed/simple;
	bh=vPgWeEtXaTLBNLyKSrj7f5vCm/g8wZd2nttvJgASbVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8VEHT2GRL0FtwwuTvKZ1pkQtwl/zBFxCQC2wgqw66AxC7v1fxuSf+mrT95X1YekfVJEwDuYprcLS8GjhvmkXc8MP8093D+x5LmKXp7Rk7IUBT9Tn21AfsCAj4avkeTVwTUBfkknlQO8U/RHwHtTeVwvMxVmm3KzpbtWO02QDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aELXh7+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aELXh7+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CDFC116C6;
	Thu,  2 Apr 2026 17:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775152766;
	bh=vPgWeEtXaTLBNLyKSrj7f5vCm/g8wZd2nttvJgASbVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aELXh7+6l4vkHmbybFtH/RAlkl5+QAr0g7soTnkz0MVaHIjdfmOSAEpbyrqF7UwnJ
	 /KJH1HI0USssgKIQchmSm0DjcgEMIxk+BIAR2ihKyzpFN3Vp+BtMxc1F01c8yIwSa/
	 2zME/yMLeHrFCl3drckcfkXdv783uX3JuwfxGkHmjSMHwy6NGVgJmv6dBM1lab3eBq
	 +ftkxXUVa/1t+HnpZyexIaJFx63fp3HLNnc2awe6JBIR/07FJMXGijnI+eS8lRAvIT
	 eGIiBiltNjcGfP0NoFe0KCvLrITs2iskIaY/3kRsgk0kxdrOL9NNf3qCKnz7q0waej
	 yiz3/bUNf5VWw==
Date: Thu, 2 Apr 2026 10:59:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	brcampbell@google.com, shuah@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf header: Validate build_id filename length to
 prevent buffer overflow
Message-ID: <ac6ufPHfHR_L0ze-@google.com>
References: <20260401215310.348463-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401215310.348463-1-suunj1331@gmail.com>

Hello,

On Thu, Apr 02, 2026 at 06:53:10AM +0900, SeungJu Cheon wrote:
> The build_id parsing functions calculate a filename length from the
> event header size and read directly into a stack buffer of PATH_MAX
> bytes without bounds checking. A malformed perf.data file with a
> crafted header.size can cause the length to be negative or exceed
> PATH_MAX, resulting in a stack buffer overflow.
> 
> Add bounds checking for the filename length in both
> perf_header__read_build_ids() and the ABI quirk variant. Print a
> warning message when invalid length is detected.
> 
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---
> v2:
>  - Add warning message when invalid filename length detected
> ---
>  tools/perf/util/header.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9142a8ba4019..132d360d716a 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2545,6 +2545,11 @@ static int perf_header__read_build_ids_abi_quirk(struct perf_header *header,
>  			perf_event_header__bswap(&old_bev.header);
>  
>  		len = old_bev.header.size - sizeof(old_bev);
> +		if (len < 0 || len >= PATH_MAX) {
> +			pr_warning("invalid build_id filename length %d\n", len);
> +			return -1;

I got this errors:

  In file included from util/header.c:38:                                         
  util/header.c: In function 'perf_header__read_build_ids_abi_quirk':             
  util/header.c:2549:36: error: format '%d' expects argument of type 'int', but argument 4 has type 'ssize_t' {aka 'long int'} [-Werror=format
  =]
   2549 |                         pr_warning("invalid build_id filename length %d\n", len);
        |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  util/debug.h:20:21: note: in definition of macro 'pr_fmt'                       
     20 | #define pr_fmt(fmt) fmt                                                 
        |                     ^~~                                                 
  util/header.c:2549:25: note: in expansion of macro 'pr_warning'                 
   2549 |                         pr_warning("invalid build_id filename length %d\n", len);
        |                         ^~~~~~~~~~                                      
  util/header.c:2549:71: note: format string is defined here                      
   2549 |                         pr_warning("invalid build_id filename length %d\n", len);
        |                                                                      ~^ 
        |                                                                       | 
        |                                                                       int
        |                                                                      %ld

Please make sure it builds before sending patches.  Hopefully we can run
perf test before and after your changes to see if there's anything
broken.

I'll fix it up this time.

Thanks,
Namhyung

> +		}
> +
>  		if (readn(input, filename, len) != len)
>  			return -1;
>  
> @@ -2587,6 +2592,11 @@ static int perf_header__read_build_ids(struct perf_header *header,
>  			perf_event_header__bswap(&bev.header);
>  
>  		len = bev.header.size - sizeof(bev);
> +		if (len < 0 || len >= PATH_MAX) {
> +			pr_warning("invalid build_id filename length %d\n", len);
> +			goto out;
> +		}
> +
>  		if (readn(input, filename, len) != len)
>  			goto out;
>  		/*
> -- 
> 2.52.0
> 
