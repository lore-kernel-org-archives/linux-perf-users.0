Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588037262A;
	Tue, 10 Feb 2026 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686645; cv=none; b=uYzzJu/rxHogP+eG5+Elt0c1n+YS+W2KRluYusMog44iLtlcG9tWLjyqSIt+Lg6Gz6vku0wbPeuk7gTXYflRxplgfwfVfZefsiXIZGK1sYlnKEfoGXsnyn5+l4lKrsN65H7lL25qoZqs16oLS0swcIn+o0MlIuMs6XSs7x+A7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686645; c=relaxed/simple;
	bh=RKizkRBGdj7J2DBOmUW7/xw+ZJPCDspJfhVCZ0TbyzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKH2bCkmXKh42NwyCfsLX8Ku+JI8Ny6310+cg3Ei2rZBVbgNO59GCI9uRs39TMpxzXBA7MwK2rXcTru8Xl1+nUohi/66W/MHC6oluKI0F6s4/IACbPSIpIPf/6FEBUl38IW3gSEdzHSbsM3elKT1e3EEsF7FeF+4qvkzcxS2exM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYqIke8o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYqIke8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868C4C116C6;
	Tue, 10 Feb 2026 01:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770686644;
	bh=RKizkRBGdj7J2DBOmUW7/xw+ZJPCDspJfhVCZ0TbyzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYqIke8oHmBX1tMVlzZSQvKNU8UQ3+1twZFM+HboQnHDm25r9AV+R0BmosdN7rcJH
	 DxUmSmhMCW2oh+LBQWYMNP1Q3BGTAyag1HMSpZw8fuqDS8CxcDvaTogzkDP56rbAZL
	 D92999osRYGDweAW20envokd5YJ5/XA6VrdgU3ZYrJsaspqSFq6D8z1lh5osJkCMTK
	 Prbt9ndyNVFy2U1zV33aJRM5AUyks7IwukLFzgqoAqW+7U6LJNxDfcuiYedKvYQgX9
	 CzBK1RzMtD9UBZZgkFCienhN1CRptPQ88Mx7ubsgN8XX3i5FhsVIUrhy3O0lUEIe9M
	 1zUITynyFzWyw==
Date: Mon, 9 Feb 2026 17:24:03 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf test code_with_type.sh: Skip test if rust
 wasn't available at build time
Message-ID: <aYqIs-eJeyItVUOm@google.com>
References: <aYor-0BmwjNvKs1N@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYor-0BmwjNvKs1N@x1>

On Mon, Feb 09, 2026 at 03:48:27PM -0300, Arnaldo Carvalho de Melo wrote:
>   $ perf test 'perf data type profiling tests'
>    83: perf data type profiling tests                         : Skip
>   $ perf test -vv 'perf data type profiling tests'
>    83: perf data type profiling tests:
>   --- start ---
>   test child forked, pid 977213
>   Skip: code_with_type workload not built in 'perf test'
>   ---- end(-2) ----
>    83: perf data type profiling tests                         : Skip
>   $
> 
> Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/shell/data_type_profiling.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
> index a230f5d4c42c3e6a..3ef72a10850d0734 100755
> --- a/tools/perf/tests/shell/data_type_profiling.sh
> +++ b/tools/perf/tests/shell/data_type_profiling.sh
> @@ -4,6 +4,11 @@
>  
>  set -e
>  
> +if ! perf test --list-workloads | grep -qw code_with_type ; then

It could be 'perf check feature -q rust'.

But IIUC this test also covers C code.  We may want to skip Rust parts
only.

Thanks,
Namhyung


> +	echo "Skip: code_with_type workload not built in 'perf test'"
> +	exit 2
> +fi
> +
>  # The logic below follows the same line as the annotate test, but looks for a
>  # data type profiling manifestation
>  
> -- 
> 2.53.0
> 
