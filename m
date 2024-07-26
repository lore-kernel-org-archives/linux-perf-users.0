Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DDDA2A
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721952428; cv=none; b=JbYcRtsYHUDa51y4DstwS1unh2zT+sG2Yt2WMOzTPzqm0X3WahjxbRpVKRaF67bxTO2BcM29/IK8/e8E8ErA27PkfiuQXZiebysLjAWI/9V4JbXVNPgo5N8bnNizt364sIuOR2eqErC9pY9oz95jf48trODziJxOPOdKs6BVeRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721952428; c=relaxed/simple;
	bh=JH0iDTX01213pRWQd3Q4rXYsu2blNK2m66+m9Ftbypc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4l3aPMzGgWDlH4GYYpDsxI6eb/8GK2szwr7A4usE5+B+ZDFuzIddQmjFyMiCHi2SMmRYrncfNw8qLeRjYZs7+PFp5iOO10QGeicrwJLVw7AP2d4IXM/eeyslIS1iXdLrty/gSuvUJ/uf+9mI6/hqoVffxk4REnm/Lrx8pkTl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4PUFD08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4PUFD08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C01C116B1;
	Fri, 26 Jul 2024 00:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721952428;
	bh=JH0iDTX01213pRWQd3Q4rXYsu2blNK2m66+m9Ftbypc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4PUFD08botxjtgz6loBI0+5/W1jukULnvhS6zsP+fBzMjbqWBkiZltjwW0bWiH9H
	 IsoZ22KJQ0EowPyunWc0OBYQuWZFoHEld5qVADQVi3wRQRIwz61sHq1YNea+wE32gm
	 AWnfrFlqDBTXmyAsfRH15jsfXdoQRqFhJZBV57DmqkRrsbtyLQSWtCKslz1TzIXD0t
	 l6svXWoW31Jg/AcCqsu4g7POzcwURVATPWEykcMoSNWmDpdRudCCJT02RvN/iERxz7
	 naysYcIwtXP4oirjWer9mF36ckOGd9dsTCM46DHDu6xa/rrNkUEjTz4AGdzAolLHjT
	 Wy9S5IBuUVIEw==
Date: Thu, 25 Jul 2024 17:07:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 2/4] perf test: Support external tests for separate
 objdir
Message-ID: <ZqLoqqV92Ol5dlF4@google.com>
References: <20240724190137.3810429-1-ak@linux.intel.com>
 <20240724190137.3810429-2-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240724190137.3810429-2-ak@linux.intel.com>

Hi Andi,

On Wed, Jul 24, 2024 at 12:01:35PM -0700, Andi Kleen wrote:
> Extend the searching for the test files so that it works
> when running perf from a separate objdir, and also when
> the perf executable is symlinked.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/tests/tests-scripts.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
> index e2042b368269..63be17289ac3 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -29,16 +29,41 @@
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
> +	if (*p)

Wouldn't it be 'if (p)' ?

Thanks,
Namhyung

> +		p[1] = 0;
> +	scnprintf(path, sizeof(path), "%s/tests/shell", path2);
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
