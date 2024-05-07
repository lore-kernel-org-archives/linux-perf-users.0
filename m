Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2B1649DF;
	Tue,  7 May 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096476; cv=none; b=IX9ylult48YYZHr9uYAT43lOPY8EsCTGjabTmrMC3vQqgDoWu0xOcuEqywzeXwdNx5/aWOzA51S/QAo+b3XdErvQv5YLZzYuaD/to0sNYZSUPpolosqMkBEij3StR1Ii1OcvfFWJooPFBFmgkTwtCOe3+ci0HWBHPRVXF7nPJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096476; c=relaxed/simple;
	bh=Fm3kzqfwbL20dUiZTvcEiKVme7HzjtZRBfeFTPuMJ8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCZ0Tam7t19fw8PLuM0MqUytgl1IUm8dIXdaeMajwcshfQj8UnWzS9LitLdUwfXeu3tQeFwVhR8vfstHwgkyX2bj3LYnP72ZEdgtBrScR9Ul1Y3JtZnDPEVG/eWpW5PMf8CuxEosvSMr4EpENptpKLRECk71gTN3+V4Lqv0tZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNJl3sa4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNJl3sa4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7435C4AF18;
	Tue,  7 May 2024 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715096475;
	bh=Fm3kzqfwbL20dUiZTvcEiKVme7HzjtZRBfeFTPuMJ8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNJl3sa4vGVlw395QkltOVW2lIldb+PH66bS4OinhXTuYU5MP2ykg4k6unw0iW9yO
	 gSRhQYUQSBQMOmilwSbIa4j5MuVAHVKxThfb8my9DqwyiecolW4ZnUYf7MS1OL78pX
	 j9Clsv1fWMwjB5JPWx1tcoy1HAG/Xh8YxjJcwgcL4Ud2HQw5jxpjdDnJnHZCtDlKhy
	 6MsuIvG9xCOxFfOj7lgj6i6u6XEzuBmZbgwxAeExR7UjiJKk4v0XaWrovPxJwDPzXb
	 ieuIftMXY1TJZEbZfnDDTtzrJs7OG8DVQD2tl78NxyHSNbjH3koXQ+AvWPaghB1S2+
	 63pFKzU5uEkTQ==
Date: Tue, 7 May 2024 12:41:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: He Zhe <zhe.he@windriver.com>
Cc: namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench: Fix trap divide error of perf bench
 internals inject-build-id
Message-ID: <ZjpLmBvW0LqZET3U@x1>
References: <20240507065026.2652929-1-zhe.he@windriver.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507065026.2652929-1-zhe.he@windriver.com>

On Tue, May 07, 2024 at 02:50:26PM +0800, He Zhe wrote:
> perf bench internals inject-build-id suffers from the following error when
> only one DSO is collected.
> 
> perf bench internals inject-build-id -v
>   Collected 1 DSOs
> traps: internals-injec[2305] trap divide error
> ip:557566ba6394 sp:7ffd4de97fe0 error:0 in perf[557566b2a000+23d000]
>   Build-id injection benchmark
>   Iteration #1
> Floating point exception
> 
> This patch removes the unnecessary minus one from the divisor which also
> corrects the randomization range.

Thanks, applied to perf-tools-next, and added:

Fixes: 0bf02a0d80427f26 ("perf bench: Add build-id injection benchmark")

To make sure this ends up being picked by the stable guys and
backporters.

- Arnaldo
 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  tools/perf/bench/inject-buildid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
> index 49331743c743..a759eb2328be 100644
> --- a/tools/perf/bench/inject-buildid.c
> +++ b/tools/perf/bench/inject-buildid.c
> @@ -362,7 +362,7 @@ static int inject_build_id(struct bench_data *data, u64 *max_rss)
>  		return -1;
>  
>  	for (i = 0; i < nr_mmaps; i++) {
> -		int idx = rand() % (nr_dsos - 1);
> +		int idx = rand() % nr_dsos;
>  		struct bench_dso *dso = &dsos[idx];
>  		u64 timestamp = rand() % 1000000;
>  
> -- 
> 2.25.1
> 
