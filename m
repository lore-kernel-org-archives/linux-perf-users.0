Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B33054C7;
	Tue, 10 Mar 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154234; cv=none; b=VsbE6ks+dAZ73jvZDmJjpOf4TnFgu44j7MOLpYiOgU19uDgULkrOgD14B8Hrpbdfd3M7XLMdf2m37Da9IMFVa1B7q6RbnWPBRqVURyTN1U6yq+FXvi0pLLyJYETvpKlgja9iUaA+KtQ5Tfg3z+l0Vdg11hLlJj2C9qNQs7uYajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154234; c=relaxed/simple;
	bh=qE2FCm8GbQIy/5Bhcj1naoefctbWX1bIvoJQuD+KAPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTPK6wncXfms+X+A+HYDWyumDOYslNKEFnB277s8LA2cFIXVSz41Up+Rge6StFHZFmQN48ftkfjOwPc/co9Zb882FlP8uqgLkKHKU3cCZ1OEBf1ETTd3kkY8x+5AAQRqllNAxQg9lxBIy6yPdRwTEsF5WlLHQZL42nbzjDo1CBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/lFCUxQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/lFCUxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363F4C2BCB1;
	Tue, 10 Mar 2026 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773154233;
	bh=qE2FCm8GbQIy/5Bhcj1naoefctbWX1bIvoJQuD+KAPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/lFCUxQ0TKbtKz9Uo9fcRQCOIMbNq6Yj/ka429O45m2M7owqqLQGT3Ur5Sm3pS2c
	 VNRBlvj95lAA45OltR2yv0kPBU6wh0KQosysP0RSRgJFXR35EBE5r/z0M/z83fqHxU
	 E0qebJ/8Bsh6qB5UsReBbV+QEdfva33bwGFVwCbru8+jXxL7a10RczLrBBALB/22gU
	 ITWe3Xf4ufziEmIqZTwfzVNvQirh2dQUHZvchRCzD+0qH6aORlYkxRvqHplOZBp8AN
	 01hQBHJHIg8D/xKvy0yH4KhbLUp8tzI7h783N0KAqcm+otVgvCjY4EruJ0RNXeomT+
	 E34RoPVKxE3MQ==
Date: Tue, 10 Mar 2026 11:50:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf ftrace: Fix hashmap__new() error checking
Message-ID: <abAvtphCy_MWy7Br@x1>
References: <20260306041052.1266836-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306041052.1266836-1-nichen@iscas.ac.cn>

On Fri, Mar 06, 2026 at 12:10:52PM +0800, Chen Ni wrote:
> The hashmap__new() function never returns NULL, it returns error
> pointers. Fix the error checking to match.
> 
> Additionally, set ftrace->profile_hash to NULL on error, and return the
> exact error code from hashmap__new().

Thanks, applied to perf-tools, for v7.0.

- Arnaldo
 
> Fixes: 0f223813edd0 ("perf ftrace: Add 'profile' command")
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changes in v2:
> - Set ftrace->profile_hash to NULL on error
> - Return PTR_ERR(ftrace->profile_hash) instead of -ENOMEM
> - Update commit message
> ---
>  tools/perf/builtin-ftrace.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 6b6eec65f93f..4cc33452d79b 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -18,6 +18,7 @@
>  #include <poll.h>
>  #include <ctype.h>
>  #include <linux/capability.h>
> +#include <linux/err.h>
>  #include <linux/string.h>
>  #include <sys/stat.h>
>  
> @@ -1209,8 +1210,12 @@ static int prepare_func_profile(struct perf_ftrace *ftrace)
>  	ftrace->graph_verbose = 0;
>  
>  	ftrace->profile_hash = hashmap__new(profile_hash, profile_equal, NULL);
> -	if (ftrace->profile_hash == NULL)
> -		return -ENOMEM;
> +	if (IS_ERR(ftrace->profile_hash)) {
> +		int err = PTR_ERR(ftrace->profile_hash);
> +
> +		ftrace->profile_hash = NULL;
> +		return err;
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.25.1
