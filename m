Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DD1BDABD
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926815; cv=none; b=hoy/CClJeGemCTDT0kWOwjfEvvAWEDKNlQL6NwUbYYJmVHBoeslmhumCKdivB348qYXNqIjV2oDfoB/oeWTH+8Y1A2YaE4BazGXwDCZZIURDX38uLrprHS9o5Qwr9klKdkVzHqICi6i7KSW2PbTC3v20MykvxAti02HxEbCB1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926815; c=relaxed/simple;
	bh=o1rjkEu1OGNo0DCwbiGzMRnRqL92c2F6IPRuk5P+kYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmGEhfgObtnBgnmlqEKIx5qO0PlKvdaUwDBtJkYl4wUsMErN5vhI3Rmlp5HvO9lKl37T+TFkhs6kzIGKmsHpSVc5NBOzK8lKo44WuJQ/HC7cNwpVnUxtFd9VCUNFGiewSjxhu5ubbn9A8m6YMAFmodLtrTvZTllBxNa8xnL+5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7O31Ti9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7O31Ti9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A484C4CEC3;
	Mon, 14 Oct 2024 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728926814;
	bh=o1rjkEu1OGNo0DCwbiGzMRnRqL92c2F6IPRuk5P+kYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7O31Ti9eMr88M6/7zPqFgYBm5yjpoanS9A0kpH2OjmlW5H2jGTFzE4ls51BY8bpw
	 v2NQIb60Ht9p/NfWK68TPNYK8XGZ0RjUSnvnM8NrFd1aNHPfdp05RAq354w+IGBQ0p
	 6ul39tDy02EYi7JaF0d0WFVWgecvBIlqutqi7Y2HnYxFoTPtBQOJJY1ZUTylva1HUm
	 XIfHhYJbw/fzpxxFwkEmbWgtyi8d2+qcoHLbGgQNs2UXXEmDINkuGzHgat1rdTfTb5
	 XI+uPb0vBxnQWgVc7ujGG0+xTXfRwexaUTDnHH8vpj+HUB5MK67a2p38rkQY0Zzori
	 QI3vM3BRRmG9A==
Date: Mon, 14 Oct 2024 10:26:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
	maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Subject: Re: [PATCH] tools/perf/tests: Fix compilation error with strncpy in
 tests/tool_pmu
Message-ID: <Zw1UXbWTS9Gk3lmw@google.com>
References: <20241013173742.71882-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241013173742.71882-1-atrajeev@linux.vnet.ibm.com>

Hello Athira,

On Sun, Oct 13, 2024 at 11:07:42PM +0530, Athira Rajeev wrote:
> perf fails to compile on systems with GCC version11
> as below:
> 
> In file included from /usr/include/string.h:519,
>                  from /home/athir/perf-tools-next/tools/include/linux/bitmap.h:5,
>                  from /home/athir/perf-tools-next/tools/perf/util/pmu.h:5,
>                  from /home/athir/perf-tools-next/tools/perf/util/evsel.h:14,
>                  from /home/athir/perf-tools-next/tools/perf/util/evlist.h:14,
>                  from tests/tool_pmu.c:3:
> In function ‘strncpy’,
>     inlined from ‘do_test’ at tests/tool_pmu.c:25:3:
> /usr/include/bits/string_fortified.h:95:10: error: ‘__builtin_strncpy’ specified bound 128 equals destination size [-Werror=stringop-truncation]
>    95 |   return __builtin___strncpy_chk (__dest, __src, __len,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    96 |                                   __glibc_objsize (__dest));
>       |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The compile error is from strncpy refernce in do_test:
> 	strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
> 
> This behaviour is not observed with GCC version 8, but observed
> with GCC version 11 . This is message from gcc for detecting
> truncation while using strncpu. Use snprintf instead of strncpy
> here to be safe.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

I found this issue now and thanks for the quick fix.  I will push to
perf-tools-next soon.

Thanks,
Namhyung

> ---
>  tools/perf/tests/tool_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> index 94d0dd8fd3cb..297cc8c55579 100644
> --- a/tools/perf/tests/tool_pmu.c
> +++ b/tools/perf/tests/tool_pmu.c
> @@ -22,7 +22,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
>  	if (with_pmu)
>  		snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to_str(ev));
>  	else
> -		strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
> +		snprintf(str, sizeof(str), "%s", tool_pmu__event_to_str(ev));
>  
>  	parse_events_error__init(&err);
>  	ret = parse_events(evlist, str, &err);
> -- 
> 2.43.5
> 
