Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E732E12E;
	Thu, 26 Mar 2026 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565010; cv=none; b=nEmHUziCLNZs7NGkGcMOOQQ4++QnPBYdIIG6GyKHY85BqX/VpEs99pEDDWPmUu62z7r5v9K/vWNrKvxaKlSS6FqiLx2sUK9onoHTF2HwrHhCTADMcNQ1DYeFyl6UcGaupcnIH/zj371sJjADsd8YOyvuoTCk4TPawQKi1XITK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565010; c=relaxed/simple;
	bh=U4bc+g9K/SDkafvPL1137CUd6thaGktSBphqe64Zir0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWuFFekaMtDPBw3YB13J9NZ+xYmIG2RiHJvo2GaoHtxOxqL2qHTj4hecs5avNHl39cds/RsiVvQf3zUzcLSkqlVKLBOV5w+gEAMVNSL0HvfQjl03l41RPfM4bKdBVzy6+s7qOo13/js9VIfpzI+XRrP4uSeXkWbuiUBGfw9QD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST0v4VOf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST0v4VOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBE8C116C6;
	Thu, 26 Mar 2026 22:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774565009;
	bh=U4bc+g9K/SDkafvPL1137CUd6thaGktSBphqe64Zir0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ST0v4VOf9DN6R0/RhaUJbpjDv5+dxGZz1QZ7x/iX2tdjkLmqzW8ChEZXdm5HzKsYJ
	 SfqRe2vztffafJizRonM3KJTIl3n2CO/lbHdjAxx/ltowvRcDg4BPQENN1DZ3G5Uxx
	 navlI6T8scUJnflLMrcAkUAJi1teBEJksC8N1BDBVsMkJuogzDdDk+zIpinx7SiAmO
	 mzIk/LkpRTAAlyjwXA6bIn4FA8uO8vy2HQ2mJl21ToLN5QV08RHl1YXB2F1QWaCvfJ
	 nPhYQyLm4Mgz4hFcqHsk+Eq5RscW3m6pZAqZyHZ9g6YGD3odaweHOAwBo49wp2Asii
	 nwulzL9g0qshw==
Date: Thu, 26 Mar 2026 15:43:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ricky Ringler <ricky.ringler@proton.me>
Cc: irogers@google.com, mingo@redhat.com, acme@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4] perf utilities: cln_size header
Message-ID: <acW2j7hki-u50YYz@google.com>
References: <20260214040659.168769-2-ricky.ringler@proton.me>
 <aaeKBOolC3AyHAFa@google.com>
 <20260305235655.40779-1-ricky.ringler@proton.me>
 <THyJLu3kRy_7q7V6-XpKu2hIZsSzkadNwnZ6YIOUSSTS2if2u3OWv6ROm_MtvBWVQVOJ03FVWw0POxzhU0LpeSBhoKSxTwKVV-JhZFJNCvg=@proton.me>
 <20260308172037.123654-1-ricky.ringler@proton.me>
 <CAP-5=fVk22oOxLSN-2_MioJ3RKUpQwD2TWK9sA=WcegUc_dj1w@mail.gmail.com>
 <20260321204145.26359-1-ricky.ringler@proton.me>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260321204145.26359-1-ricky.ringler@proton.me>

Hello,

On Sat, Mar 21, 2026 at 08:41:55PM +0000, Ricky Ringler wrote:
> Store cacheline size during perf record in header, so
> that cacheline size can be used for other features, like
> sort.
> 
> V4: Ian feedback
> V3: Rebase off perf-tools-next round two
> V2: Rebase off perf-tools-next
> 
> Follow-up patch from message ID "aYZiQk6Uftzlb_JV@x1"

Please squash the patches into a single change and send it again.

> 
> Testing:
> - Built perf
> - Ran record + report with feat enabled
> - Ran record + report with feat disabled
> 
> Tested-by: Ricky Ringler <ricky.ringler@proton.me>

Tested-by tag from the author may not be meaningful.  We always expect
authors to test their patches. :)

> Signed-off-by: Ricky Ringler <ricky.ringler@proton.me>
> ---
>  tools/perf/builtin-inject.c |  2 +-
>  tools/perf/util/header.c    | 11 ++++++++---
>  tools/perf/util/sort.c      |  8 ++++++--
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 2675d32f88cf..11ac7c8c4be3 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2134,7 +2134,7 @@ static bool keep_feat(struct perf_inject *inject, int feat)
>  	case HEADER_HYBRID_TOPOLOGY:
>  	case HEADER_PMU_CAPS:
>  	case HEADER_CPU_DOMAIN_INFO:
> -	case HEADER_CLNq_SIZE:
> +	case HEADER_CLN_SIZE:
>  		return true;
>  	/* Information that can be updated */
>  	case HEADER_BUILD_ID:
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 4f65faafe75d..2d39da470267 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1310,8 +1310,13 @@ static int write_cln_size(struct feat_fd *ff,
>  {
>  	int cln_size = cacheline_size();
>  
> -	if (!cln_size)
> -		cln_size = 0;
> +
> +	if (!cln_size) {
> +		int default_cacheline_size = 64;

Let's get rid of the local variable.

Thanks,
Namhyung

> +
> +		cln_size = default_cacheline_size;
> +	}
> +
>  	ff->ph->env.cln_size = cln_size;
>  
>  	return do_write(ff, &cln_size, sizeof(cln_size));
> @@ -2274,7 +2279,7 @@ static void print_cache(struct feat_fd *ff, FILE *fp __maybe_unused)
>  	}
>  }
>  
> -static void print_cln_size(struct feat_fd *ff, FILE *fp __maybe_unused)
> +static void print_cln_size(struct feat_fd *ff, FILE *fp)
>  {
>  	fprintf(fp, "# cacheline size: %u\n", ff->ph->env.cln_size);
>  }
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 13287ade784e..5f617cf03d5d 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -2483,8 +2483,12 @@ hist_entry__cln_size(struct hist_entry *he)
>  	if (he && he->hists) {
>  		struct evsel *evsel = hists_to_evsel(he->hists);
>  
> -		if (evsel && evsel->evlist->session && evsel->evlist->session)
> -			ret = evsel->evlist->session->header.env.cln_size;
> +
> +		if (evsel) {
> +			struct perf_session *session = evsel__session(evsel);
> +
> +			ret = session->header.env.cln_size;
> +		}
>  	}
>  
>  	if (!ret || ret < 1) {
> -- 
> 2.53.0
> 
> 
