Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60470D299;
	Fri, 11 Apr 2025 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332667; cv=none; b=QACQcGdn3Bk43aOjQ2orGNS1wvCBJxb5Gt3bkHJdfJEL9Ej6ZXl/jwejSsBubo1u92I2kNl193UQlV2StfXv2iGuWfoIOQ0Isf3FMTCyXdn7n1b3lBvR88yD3dvLZDYCt/ZF2+/zgbKiwumkkyx/cxlzp8P4R7y//MHQ2kcgZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332667; c=relaxed/simple;
	bh=8jUKttA0WGjH625GBehJZiCW47VN5WUkEqmYv2Hv3To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeGFVuoqacHt5D6zB/cXrUYagtau9310Wg5ysC0YWiccZtvDeblhER9NnRmjzPiWZXMwj5RAtVEiFKcqaxMuB+2bVgi+EkhSixNtspAb3URsaYnoJva2/gs2+QFbGjkE9RczgPttreJAbhrrkyaY8VmCJB6ieGfqrv01ycfJrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRwYkc27; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRwYkc27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FAAC4CEDD;
	Fri, 11 Apr 2025 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744332664;
	bh=8jUKttA0WGjH625GBehJZiCW47VN5WUkEqmYv2Hv3To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRwYkc273Ozvh2HU49qhorCHituvXuokFEnextwxcYAobE8SCIYfQnQUTq3PjMBGV
	 zLVnD+WcNFAEx0FBYBaN/v3XMBk2szSY+JwbqQE6AOr3YEYsNlE8rUsarAQLACM7Tq
	 SCRQIOIeklThUXrgwRh28X+2QeUXcRD7W+mPr7StAQuJ1QcSY5siFlK0stknWA7EQB
	 l3XR1wxiOp0r1dO4aRuHyGEhjbw+kQz4Di3a25UnKr2ALeJEFjPjuWzhxPY4SNUe/s
	 EfAlfdFpwWRm4IvhMkuA5rcORysDxqZj2BwPtDY5idm9Mjrw5SHu+7S9g3P+Qy6MuW
	 KJVF5AeAK8d9Q==
Date: Thu, 10 Apr 2025 17:51:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 v6.15-rc1] perf libunwind arm64: Fix missing close
 parens in an if statement
Message-ID: <Z_hndlFEnn5DHjvL@google.com>
References: <Z_Z3o8KvB2i5c6ab@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z_Z3o8KvB2i5c6ab@x1>

On Wed, Apr 09, 2025 at 10:35:31AM -0300, Arnaldo Carvalho de Melo wrote:
> While testing building with libunwind (using LIBUNWIND=1) in various
> arches I noticed a problem on arm64, on an rpi5 system, a missing close
> parens in a change related to dso__data_get_fd() usage, fix it.
> 
> Fixes: 5ac22c35aa8519f1 ("perf dso: Use lock annotations to fix asan deadlock")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks for fixing this.  For some reason the build test couldn't detect
it on my system (I have libunwind-dev installed).

I'll add it to perf-tools tree.

Thanks,
Namhyung


> ---
>  tools/perf/util/unwind-libunwind-local.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index 9fb2c1343c7fe205..0b037e7389a009f5 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -371,7 +371,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
>  	 *    has to be pointed by symsrc_filename
>  	 */
>  	if (ofs == 0) {
> -		if (dso__data_get_fd(dso, machine, &fd) {
> +		if (dso__data_get_fd(dso, machine, &fd)) {
>  			ofs = elf_section_offset(fd, ".debug_frame");
>  			dso__data_put_fd(dso);
>  		}
> -- 
> 2.48.1
> 
