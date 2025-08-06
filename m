Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60A238D42;
	Wed,  6 Aug 2025 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754524433; cv=none; b=DsZG0i91yHXoMRfi+Jj3EuW0vmxh/TRtm0KxiFnNW1IgwhAllZjMwIShliRF3wyl2gQ10aLZ6vBMa/WNIQRLB0AKDcGH/cmmXaHVk0sWNFoZpM28gtj2ZXVmtSTWMe7t5cfEkiMGVXOI3hGePmtw8P7Iv842E9KgZeH4YKdt4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754524433; c=relaxed/simple;
	bh=nn5NMCG9KETlNvQE55zq+XT8CpiKNCvGrGTY3zvnsvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEcYBWw0uMGf0XqvfnMMJ6u4hloEplujNnkjIVIeHFWy6EgTetOuwNORcIz71kOLJZPphGH5VYmYGdUlLM6gJLj1MAXADINFznbVQmIyH3h+4xrSUhPIf3pii3bBmzuGBXf6nRUrNL6ndxMP0Mks7f/+u5dn3b7eWe5UqeFD9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYBZnEve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYBZnEve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8A7C4CEE7;
	Wed,  6 Aug 2025 23:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754524433;
	bh=nn5NMCG9KETlNvQE55zq+XT8CpiKNCvGrGTY3zvnsvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYBZnEve9CXR0DxBDHRjMdPEyhqANYgBn9MKBAwvEqtPyAr9QKB4qQRkPDiEbDcnC
	 Yyu5oOzoKBVPkgrTyleMEUOnYLs6qK7wrViWVLqK/5SPwK1hJezgvvrmd9AhUWza8y
	 LQT5BqutGQCf4OY0tmx+yCGARNVY/CN259KnLCnxTEp/+DPjZ66lNeeFmIJj+g7BAu
	 WXbh2fdqzFQs2kmnMk8atxhUMgDVr94BW8u+GLPP6l/v1h4vAq4X9SuppL3QDYJUJG
	 94RJrc7iyYsZET41LgUODaWXoCXepHJqtgvbPz3ZHy627dec4PQ4/ZKUGZWCZOEiWj
	 eRnSGKMhLzQ2g==
Date: Wed, 6 Aug 2025 16:53:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 2/5] perf tools kvm: Fix the potential out of range
 memory access issue
Message-ID: <aJPrD_9J0SLiLFh9@google.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
 <20250805004633.135904-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805004633.135904-3-dapeng1.mi@linux.intel.com>

On Tue, Aug 05, 2025 at 08:46:30AM +0800, Dapeng Mi wrote:
> kvm_add_default_arch_event() helper may add 2 extra options but it
> directly modifies the original argv[] array. This may cause out of range
> memory access. Fix this issue.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/builtin-kvm.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index f78a67a199ff..7e48d2437710 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2002,12 +2002,12 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
>  	int rec_argc, i = 0, j, ret;
>  	const char **rec_argv;
>  
> -	ret = kvm_add_default_arch_event(&argc, argv);
> -	if (ret)
> -		return -EINVAL;
> -
>  	rec_argc = argc + 2;

While at it, can we add a comment for this too?  I believe it's for "-o"
and filename.

Thanks,
Namhyung


> -	rec_argv = calloc(rec_argc + 1, sizeof(char *));
> +	/*
> +	 * kvm_add_default_arch_event() may add 2 extra options, so
> +	 * allocate 2 more pointers in adavance.
> +	 */
> +	rec_argv = calloc(rec_argc + 2 + 1, sizeof(char *));
>  	if (!rec_argv)
>  		return -ENOMEM;
>  
> @@ -2019,6 +2019,10 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
>  
>  	BUG_ON(i != rec_argc);
>  
> +	ret = kvm_add_default_arch_event(&i, rec_argv);
> +	if (ret)
> +		return -EINVAL;
> +
>  	ret = cmd_record(i, rec_argv);
>  	free(rec_argv);
>  	return ret;
> -- 
> 2.34.1
> 
