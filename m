Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E513A4F54;
	Tue,  3 Feb 2026 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130334; cv=none; b=NKBQwgP125KT4KOFfvd9BTrWvqynnzcCZ0nxmqANg0KUGSc/zVLZFjxHAfIPkaVy9Senj82A9QadH9mQyF0ry4HB0m5Mi1CQgDkziEFXtwhuMu0yaWWueHzJKcMtgPuzW3/blZSStSh59gQItCgktxQTvwz/y3Uwqo6BcRnsiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130334; c=relaxed/simple;
	bh=6Qbf5k0nSdxGNOhUkND730pQ86YHY9Kt60Rtveo9feA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5QqBAQlm4zPtdzD053HIm/UdXPN6ojDx0sLi9I+tsUDGPwzh9fmNuqMKzwUwAAGt21Jo47rICfqt5ktui82CT9XoyXMLum7gUrpfmVbADNNLvssuakfA8ZOOOIuoP46+S82jafFzxA+dTLMFWCRmy0U81gaxXWbPFNEFzPRrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFGAcKOG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFGAcKOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6B6C116D0;
	Tue,  3 Feb 2026 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770130333;
	bh=6Qbf5k0nSdxGNOhUkND730pQ86YHY9Kt60Rtveo9feA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFGAcKOG+wIhcuAvOx9yOSIuFdSBvnoo/mCZRcaxy42hVBrCmXJeE5G4ZMI6N0Pzg
	 lt5PigXUf3ajynWKaGzxbJyxD/N6ZMKO/BucIIqYAuSbSnI4K4cEsEJddvTsHZ98wa
	 7QKEjsYu57Ym6rXGRr43gMgXkMz4UDJbCFQoia8sMA96Bzvd90ikvCBsDoYSwvmjTS
	 nx30RJ7m4bqEFi7RIi+sxasmbwJeUhMImws9sORpaIMN0rLg45sdJVlb5H6MusGbZW
	 iTy1xHfGOpTzqg3rnaUFjppN+hu4p1HDoci2vXvXvcBbydBfhZHumAba+7DGoE36vW
	 YSnQ67tKw4jKA==
Date: Tue, 3 Feb 2026 11:52:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] libperf build: Always place libperf includes first
Message-ID: <aYILmgJfsgrQ06Jq@x1>
References: <20260203060918.3137059-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203060918.3137059-1-irogers@google.com>

On Mon, Feb 02, 2026 at 10:09:18PM -0800, Ian Rogers wrote:
> When building tools/perf the CFLAGS can contain a directory for the
> installed headers. As the headers may be being installed while
> building libperf.a this can cause headers to be partially installed
> and found in the include path while building an object file for
> libperf.a. The installed header may reference other installed headers
> that are missing given the partial nature of the install and then the
> build fails with a missing header file. Avoid this by ensuring the
> libperf source headers are always first in the CFLAGS.
> 
> Fixes: 314350491810 ("libperf: Make libperf.a part of the perf build")
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
> ---
> I started seeing these build failures in build-test post
> commit c3030995f23b ("perf sched stats: Add record and rawdump support")
> which increased the number of libperf header files and their
> dependencies. It isn't correct that this patch fixes that patch, the
> problem has existed as long as libperf which is why a much earlier
> commit is in the Fixes tag.
> ---
>  tools/lib/perf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 9692d0742ed0..32301a1d8f0c 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -50,9 +50,9 @@ INCLUDES = \
>  -I$(srctree)/tools/include/uapi
>  
>  # Append required CFLAGS
> +override CFLAGS := $(INCLUDES) $(CFLAGS)
>  override CFLAGS += -g -Werror -Wall
>  override CFLAGS += -fPIC
> -override CFLAGS += $(INCLUDES)
>  override CFLAGS += -fvisibility=hidden
>  override CFLAGS += $(EXTRA_WARNINGS)
>  override CFLAGS += $(EXTRA_CFLAGS)
> -- 
> 2.53.0.rc1.225.gd81095ad13-goog
> 
