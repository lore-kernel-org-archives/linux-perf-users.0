Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBBB2AD13
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Aug 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884551; cv=none; b=EWz+kynZnAufD7FeTf8XtZn+TC/xfJt2ftyZ2o2wkinJ55728bAF/Sa6tkGMbQUhQ3gF02wUFd511zrkZ81FxlzCiMMUUaX6cOqdcn2CO52BgQDBSo26arAuObA67QlaZzOt4/uSfskf6dxpC+9mButbiXdZxNGA5XPWOhn6KWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884551; c=relaxed/simple;
	bh=P95BFV/ATpsWtWmUHxLLWO/gd3tYn5btHHMUbnZoK1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eV8B8wLf561ewk4oa0EtKRgxFNCIeTZ6z3giR2s2u8Q/ZgLe6ZN03i9jxFOk5zpq45YR06Nr/pDEU7KmF+6Bv+5UUzifCjt+xqIMS9BOhBG6Qein4CitMdXcEtxipgcAVndH3Ni05iHykClu1eu8R6muqVAhr/ndCwBUpi2ctnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6OZpDPr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6OZpDPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D98C4AF0C;
	Mon,  5 Aug 2024 19:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722884550;
	bh=P95BFV/ATpsWtWmUHxLLWO/gd3tYn5btHHMUbnZoK1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6OZpDPrXWLa6gjg90Qr7N0X9HKEum9d6uswzIn0Yk0WYMBPVF+DugX/bN2k0XokX
	 eZRrI3lmJlyRwKWu05tDB1J05Q+3VMpsQvXnBsffG9x5i+zN1hkffKDVFo9iRAyW6t
	 59Lb0dHr9NkIgim6SKJmrwCakR08o18gwilmGBFEYHk9Af5zQ981qyK/Sq3EfPnZ97
	 GJfdWq3qno+R5o9VI/NNyrn+V9wtj9A4FKeXjSZvaTXHsL7k1CNT6Gf7r5iUbSb2vN
	 l+jJd8hA8ocnjLsBcEy5R9j1e9FhDty1QO77SChB7Si1tB8md0H1XwrFjDWVh+GQsR
	 LHThg9hQ9JKig==
Date: Mon, 5 Aug 2024 12:02:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 2/4] perf test: Support external tests for separate
 objdir
Message-ID: <ZrEhxdS3XGTke4xn@google.com>
References: <20240801212844.677895-1-ak@linux.intel.com>
 <20240801212844.677895-2-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801212844.677895-2-ak@linux.intel.com>

On Thu, Aug 01, 2024 at 02:28:42PM -0700, Andi Kleen wrote:
> Extend the searching for the test files so that it works
> when running perf from a separate objdir, and also when
> the perf executable is symlinked.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ----
> 
> v2: Fix string test (Namhyung)
> Handle both in source and out of source builds.
> ---
>  tools/perf/tests/tests-scripts.c | 37 +++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
> index e2042b368269..9f71ffed702c 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -29,16 +29,47 @@
>  
>  static int shell_tests__dir_fd(void)
>  {
> -	char path[PATH_MAX], *exec_path;
> -	static const char * const devel_dirs[] = { "./tools/perf/tests/shell", "./tests/shell", };
> +	struct stat st;
> +	char path[PATH_MAX], path2[PATH_MAX], *exec_path;
> +	static const char * const devel_dirs[] = {
> +		"./tools/perf/tests/shell",
> +		"./tests/shell",
> +		"./source/tests/shell"
> +	};
> +	int fd;
> +	char *p;
>  
>  	for (size_t i = 0; i < ARRAY_SIZE(devel_dirs); ++i) {
> -		int fd = open(devel_dirs[i], O_PATH);
> +		fd = open(devel_dirs[i], O_PATH);
>  
>  		if (fd >= 0)
>  			return fd;
>  	}
>  
> +	/* Use directory of executable */
> +	if (readlink("/proc/self/exe", path2, sizeof path2) < 0)
> +		return -1;
> +	/* Follow another level of symlink if there */
> +	if (lstat(path2, &st) == 0 && (st.st_mode & S_IFMT) == S_IFLNK) {
> +		scnprintf(path, sizeof(path), path2);
> +		if (readlink(path, path2, sizeof path2) < 0)
> +			return -1;
> +	}
> +	/* Get directory */
> +	p = strrchr(path2, '/');
> +	if (p)
> +		*p = 0;
> +	scnprintf(path, sizeof(path), "%s/tests/shell", path2);
> +	fd = open(path, O_PATH);
> +	if (fd >= 0)
> +		return fd;
> +	if (p)
> +		*p = 0;

This part looks unnecessary.

Thanks,
Namhyung


> +	scnprintf(path, sizeof(path), "%s/source/tests/shell", path2);
> +	fd = open(path, O_PATH);
> +	if (fd >= 0)
> +		return fd;
> +
>  	/* Then installed path. */
>  	exec_path = get_argv_exec_path();
>  	scnprintf(path, sizeof(path), "%s/tests/shell", exec_path);
> -- 
> 2.45.2
> 
