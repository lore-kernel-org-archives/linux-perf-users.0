Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407121B90B;
	Mon, 19 May 2025 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690197; cv=none; b=OaYNt83jlfZzKuHvmL9L4rdSaT1OTf0PTIz/BkWcN7/TfM1iNrPKx3SK/YrsGKItOosavbktGnmquXwDN0M43GD81HSOREVhL0TGETtEjyUMtMujyU7fsUVs9Q8BvrXjIWcBZSrjnthDIM8hxCrEmOxuia/qRj/jnkcJprNyLjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690197; c=relaxed/simple;
	bh=6l1+foseQkfqqrpdmpS8Wj/Q1b5T2b7yzzZECfXaLos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsxIOmYac29fFxpmGiVykJoTyNZduoTogucTYG0AX5l7HQ2ty0wgjcmHgH3aPqwd8U++dw8jPkoCgSv4cUn4Yx5UDTs7Sh5Wp0Mn3IrQ5jBxCshdueuGMqs/9i624sL+IMLzXXRgkQGHxfKY+2LUzBpZ03eLYMF42M6wdUIeqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKgQsChE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKgQsChE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D5AC4CEE9;
	Mon, 19 May 2025 21:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690195;
	bh=6l1+foseQkfqqrpdmpS8Wj/Q1b5T2b7yzzZECfXaLos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKgQsChEBoqABS7s9IE8MKm3xz0wGq2Rp7cENpiRrpiqX/hTnDO2qDYOGKMjm7qJX
	 ihVlLkeJ6Ifkb8hcAb2JyuBMa+E3ffg2wdc/ATioHLS6IZRXrO5A3kaKNsZnBI/WZ+
	 IKhILPwEox0flqJFSpGFy1GkeqLgLmOc2ZbItUDm3ZbGjE88gMUVHL+X780Ini+7Hx
	 AIZebhMD+65Bg/ROld30IbQAJDrMqQz3VmuVJtFlEmwMD135AjhC8QEJvcFcXOZF2R
	 WlrzwjO7slSxFSnXBmFCZ8zGf1nbf9VcDzwrm728QSL19JtkfLhIcpuORpHCT+ZKtf
	 EdLLxdsGzScAQ==
Date: Mon, 19 May 2025 18:29:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jakub Brnak <jbrnak@redhat.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test probe_vfs_getname: Add regex for searching
 probe line
Message-ID: <aCui0LRXwy3Vx9Io@x1>
References: <20250519082755.1669187-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519082755.1669187-1-leo.yan@arm.com>

On Mon, May 19, 2025 at 09:27:55AM +0100, Leo Yan wrote:
> Since commit 611851010c74 ("fs: dedup handling of struct filename init
> and refcounts bumps"), the kernel has been refactored to use a new
> inline function initname(), moving name initialization into it.
> 
> As a result, the perf probe test can no longer find the source line that
> matches the defined regular expressions. This causes the script to fail
> when attempting to add probes.
> 
> Add a regular expression to search for the call site of initname(). This
> provides a valid source line number for adding the probe. Keeps the
> older regular expressions for passing test on older kernels.

Thanks, tested and applied.

- Arnaldo

> 
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Fixes: 611851010c74 ("fs: dedup handling of struct filename init and refcounts bumps")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> 
> Changes from v1:
> - Keep old regexps to be compatible with older kernels (Arnaldo)
> 
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 89f72a4c818c..58debce9ab42 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -13,8 +13,16 @@ cleanup_probe_vfs_getname() {
>  add_probe_vfs_getname() {
>  	add_probe_verbose=$1
>  	if [ $had_vfs_getname -eq 1 ] ; then
> -		result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
> -		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re" | sed -r "s/$result_filename_re/\1/")
> +		result_initname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+initname.*"
> +		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_initname_re" | sed -r "s/$result_initname_re/\1/")
> +
> +		# Search the old regular expressions so that this will
> +		# pass on older kernels as well.
> +		if [ -z "$line" ] ; then
> +			result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
> +			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re" | sed -r "s/$result_filename_re/\1/")
> +		fi
> +
>  		if [ -z "$line" ] ; then
>  			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
>  			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
> -- 
> 2.34.1
> 
