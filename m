Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C4336403F;
	Wed, 17 Dec 2025 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985268; cv=none; b=cQ5goYwkxGzCE00kkJRd87rgO4bYHSaREr/yxyrQEyt+Tr84FI9ishVMX+0EFpuqY5wMkuISfiLTlk9ptL2REvxdYVGpw5ECSz5pK0wyuNsT63ovRRQcz/9o0DG06uciLXCpvTc0zikxPQHB9FjhMhH06PiGpHS0c+ynSa0/4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985268; c=relaxed/simple;
	bh=B8wA+8nfD+gltTXk/Kl0y8cBQSP5PKZ/u7nH/ieM6uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQT6O++b1f09z8G5kt9PNvVAl8XZ9SHxL8Jm5hXUvuO8NlFgdWgAzq5+ZqqA5lGxTUAoY4QEitJgtBo6HvUp04YCqZzoXm/S/QHhab2nQy7pjPZ1yncxw2RJImgjFeozUElDwquCSb5DxaAR9RGaTrDjEkSguloYLkuT1fdad3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD8tcRaZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD8tcRaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC0CC4CEF5;
	Wed, 17 Dec 2025 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765985267;
	bh=B8wA+8nfD+gltTXk/Kl0y8cBQSP5PKZ/u7nH/ieM6uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CD8tcRaZgHlUZF5SfMhTsyE+fiaOmfBD1Bl5dtKpnhaIcJNVcoolgoSFLEc1EMr9O
	 qmeH7Ey5cWSMqqZ5ip8X7PwSQ1efS3pBDL2oTu86GKObMKdBp9ZvmHdGiY93bJdTAB
	 +dXg2FYxbtACH7i0d45GLSnUDqs1dOizZAdYFb0vlxEbQ7Z+ms9vDbRpK+TargW1oQ
	 olLg+z5sy1/fvpMYfLRsUTd4edWCIvbSlGfDJfMwrkeIPVSdNbEislQIlKBb6NHSZ0
	 co8XY8Zmd3r7V9NamQOGONCCBgblDDvZ6dmVKzlRJ+chwY5UigJQKAzLqPuAFHrkwJ
	 cdeBrkU6cMNgA==
Date: Wed, 17 Dec 2025 07:27:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf symbol: Fix ENOENT case for
 filename__read_build_id
Message-ID: <aULL8e1VFaaHs0aP@google.com>
References: <20251207022345.909535-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251207022345.909535-1-irogers@google.com>

Hi Ian,

On Sat, Dec 06, 2025 at 06:23:45PM -0800, Ian Rogers wrote:
> Some callers of filename__read_build_id assume the error value must be
> -1, fix by making them handle all < 0 values.
> 
> If is_regular_file fails in filename__read_build_id then it could be
> the file is missing (ENOENT) and it would be wrong to return
> -EWOULDBLOCK in that case. Fix the logic so -EWOULDBLOCK is only
> reported if other errors with stat haven't occurred.
> 
> Fixes: 834ebb5678d7 ("perf tools: Don't read build-ids from non-regular files")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Note, a shorter version of this patch appeared in a series
> cleaning/refactoring the build id reading code:
> https://lore.kernel.org/lkml/20251201205509.195451-11-irogers@google.com/
> It is sent without the refactor for the sake of fixing the bug in an
> earlier release.

Thanks for the fix, I'll apply this to perf-tools for v6.19.

Namhyung

> ---
>  tools/perf/builtin-buildid-cache.c | 6 ++++--
>  tools/perf/util/libbfd.c           | 4 +++-
>  tools/perf/util/symbol-elf.c       | 4 +++-
>  tools/perf/util/symbol-minimal.c   | 4 +++-
>  4 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index c98104481c8a..539e779e3268 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -276,12 +276,14 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
>  {
>  	char filename[PATH_MAX];
>  	struct build_id bid = { .size = 0, };
> +	int err;
>  
>  	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
>  		return true;
>  
> -	if (filename__read_build_id(filename, &bid) == -1) {
> -		if (errno == ENOENT)
> +	err = filename__read_build_id(filename, &bid);
> +	if (err < 0) {
> +		if (err == -ENOENT)
>  			return false;
>  
>  		pr_warning("Problems with %s file, consider removing it from the cache\n",
> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index 0099b415decc..edf0829e9635 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -391,8 +391,10 @@ int libbfd__read_build_id(const char *filename, struct build_id *bid)
>  
>  	if (!filename)
>  		return -EFAULT;
> +
> +	errno = 0;
>  	if (!is_regular_file(filename))
> -		return -EWOULDBLOCK;
> +		return errno == 0 ? -EWOULDBLOCK : -errno;
>  
>  	fd = open(filename, O_RDONLY);
>  	if (fd < 0)
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 957143fbf8a0..d1dcafa4b3b8 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -902,8 +902,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>  
>  	if (!filename)
>  		return -EFAULT;
> +
> +	errno = 0;
>  	if (!is_regular_file(filename))
> -		return -EWOULDBLOCK;
> +		return errno == 0 ? -EWOULDBLOCK : -errno;
>  
>  	err = kmod_path__parse(&m, filename);
>  	if (err)
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
> index c6b17c14a2e9..8221dc9868f7 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -104,8 +104,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>  
>  	if (!filename)
>  		return -EFAULT;
> +
> +	errno = 0;
>  	if (!is_regular_file(filename))
> -		return -EWOULDBLOCK;
> +		return errno == 0 ? -EWOULDBLOCK : -errno;
>  
>  	fd = open(filename, O_RDONLY);
>  	if (fd < 0)
> -- 
> 2.52.0.223.gf5cc29aaa4-goog
> 
