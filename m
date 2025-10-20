Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BBB366;
	Mon, 20 Oct 2025 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760933521; cv=none; b=jIT4+zNKLwpam7mLgR1d2Ae0um3S55m3rVKTtq10sthh3ac9diFVe29iDpC2CxMifCWMQL/lgDjXVsHV7ftYeyMQTe5dNNBPi3/KrMe2LSZiYDPtAWUmk5N91Ym4Fp8xR8azwy7iEcgc1Al0YXaAwh4xqQAyRCvsXdlp/g9lp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760933521; c=relaxed/simple;
	bh=lW1EUarsi+lQKzZYt0u3FCHmZdYcduwi+4t9syHNhkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDMxkJizTxD7mEmIVUPkoNmaIvCVzaJ/AaJAV+KKpQZ9mdWHmQyMccp6x3ekKlCg9uG0zZy3CvXrMW769REGxR+sotNtTV5A32S69QPYl0gRG1aHxQrlsAvMbuw6aqIryjzVacpLNONaBWjr6QxiiF0xDMgZoWLZsNVQKRCUXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+1ohk/g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+1ohk/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5609C4CEF9;
	Mon, 20 Oct 2025 04:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760933520;
	bh=lW1EUarsi+lQKzZYt0u3FCHmZdYcduwi+4t9syHNhkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+1ohk/gRau5Z1+hRnPxN7iR8RYgBBzl+fMbsl/6q3N4PPAWDLCDQF2+dnYjM3Ins
	 u4KxhvqCWKXNB4Xfx1uGVHqO8vifxLH0KrWNVrXjEFMdSx0DneDfaTcyAJ6s/UJZz2
	 Z0tW39iYXN+L5j8qYoC8b90BFoSeaLzGEOxxGBy/6Stz8ngZ7sSNM2DoaP4drgmcIc
	 dWUxjZmlSj37eEm7UyoPNGiHoB0U/dwV8TETHj+WRa7JM77JCDS21lisWvdiSpVQ4v
	 iXfzK6HfesO0ButD/DRNiYYhlunPOCz7Q41XUDbX+Ja0A1NnF7pv8i+cnAbi+fursR
	 st/+uGW13PSqQ==
Date: Mon, 20 Oct 2025 13:11:54 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Tianyou Li <tianyou.li@intel.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, wangyang.guo@intel.com,
	pan.deng@intel.com, zhiguo.zhou@intel.com, jiebin.sun@intel.com,
	thomas.falcon@intel.com, dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] perf tools annotate: Align the symbol_annotate
 return code
Message-ID: <aPW2iiNeheOxDGw8@google.com>
References: <aPRbfdU92XRLR-2N@google.com>
 <20251020021434.29082-2-tianyou.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020021434.29082-2-tianyou.li@intel.com>

On Mon, Oct 20, 2025 at 10:14:34AM +0800, Tianyou Li wrote:
> Return error code from the symbol_annotate previously checks the
> evsel__get_arch from '<0', now to '!=0'.
> 
> Suggested-by: James Clark <james.clark@linaro.org>
> Tested-by: Namhyung Kim <namhyung@kernel.org>

This 'Tested-by' tag belongs to the patch 1 instead of this.  And you
can add my ack here.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 39d6594850f1..859e802a1e5e 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1021,7 +1021,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>  	int err, nr;
>  
>  	err = evsel__get_arch(evsel, &arch);
> -	if (err < 0)
> +	if (err)
>  		return err;
>  
>  	if (parch)
> -- 
> 2.47.1
> 
