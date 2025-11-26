Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AFB188596;
	Wed, 26 Nov 2025 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138788; cv=none; b=gV8rexrvKCl99+wq29qHNNXzu1odS/Vtz42aqmfR+13ik7xYeHWV7oZWZpiu6wfI/SGhVFc1JVevF3uE2gAsK9k0wD2uJtujBGEviPrO5olqo0OADhMMPz7ua7S5T/1O/avZEFcofxd4suEY/FIwK307XHqL18CkEAoFt8x1eOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138788; c=relaxed/simple;
	bh=y0hKEClQ93wu8zqTRP307Yn5Ng9e+aXP2QH9EB2DheM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHyl4mkKOUQeTT/LN4VO8yrHKEz/hhsiJhjjEKCvAiXQZNSw2zFCkjYXlMKkWll3BLp1mUrTx1swshi2UTkAs2zuCUpkrr0tIUlXG8zKUaRAoucU46DTpZWY42CCI5XKYu5RzEEPZ6UYCaLe9wvK/e9Ae19aIJfqypjloMKni2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWeJRDAg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWeJRDAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31926C113D0;
	Wed, 26 Nov 2025 06:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764138785;
	bh=y0hKEClQ93wu8zqTRP307Yn5Ng9e+aXP2QH9EB2DheM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWeJRDAgM125bwy84MDwwX08iPVRSZWIDZdUt0TwQtXjXpMrNjYZ900HU7kz70Z3Q
	 mGBhFQctOueE2ki7ayWYePK7N14/KSdAYtP2Atopr/FdkIje0BNgs3y9B7Z6ne0VOH
	 O8s6rdc9QpFr2xe97YzeFQDC3XU/BN8RjwXoLHjoXa9+1pSDaIPPKvZLmkgbagH8vR
	 4/7OZinu+TS3okAiejKXMSn4pJ1Vzs4BtcHUsF6aoWMF4PYnIuQ7hq0RVHAXjE178r
	 fOoRdWHErDA/2/HELGMwiZjxm34wpdWLj02z4MhRUZ7MRcO1hkc1otV83MtYiTJMyJ
	 PGz2VvG9jMJLw==
Date: Tue, 25 Nov 2025 22:33:02 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 01/17] perf kvm: Fix debug assertion
Message-ID: <aSafHle-4bTjCGY6@google.com>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251122081929.7588-2-irogers@google.com>

On Sat, Nov 22, 2025 at 12:19:13AM -0800, Ian Rogers wrote:
> There are 2 slots left for kvm_add_default_arch_event, fix the
> assertion so that debug builds don't fail the assert and to agree with
> the comment.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Fixes: 45ff39f6e70aa55d0 ("perf tools kvm: Fix the potential out of range memory access issue")

Thanks,
Namhyung

> ---
>  tools/perf/builtin-kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index f0f285763f19..c61369d54dd9 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2014,7 +2014,7 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
>  	for (j = 1; j < argc; j++, i++)
>  		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
>  
> -	BUG_ON(i != rec_argc);
> +	BUG_ON(i + 2 != rec_argc);
>  
>  	ret = kvm_add_default_arch_event(&i, rec_argv);
>  	if (ret)
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 
