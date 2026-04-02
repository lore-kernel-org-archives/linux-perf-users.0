Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1553AD51E;
	Thu,  2 Apr 2026 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123221; cv=none; b=io73uWpZN/oYPgUzJUoQS7av+dh6hsDxAQYANIstXwIs4rewUjWON+vaFMncM6+3Q06uVYPqFZdJGvTKbNnXd0/GPaIGCelaw6junWzAc50LMPmCuo5/IXpWX6PP4Fa32UI92OM8UtkvnFZBlBgwxeka3EiMvNKcQ1did9aIXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123221; c=relaxed/simple;
	bh=FvUKH05X0Vg8xw6hf+KesUtG3wgK7luuKEGYXj3pxpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXxp+qokfyMW9pgLW3D5fYUD/n+B/PTPRpE46gp081ZncFUmvvBrLUFfAYCt3ulpYNcQP8dD9SOTWsjqJEh+qxyADYs51LzMF7TmRcmMrRS23C493KW5N9XJKtyvBEnYlTfWIlpUbz22WUz8/0YQLGixVt4ywtbuJmvfJTHwwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r/Z6duT8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r/Z6duT8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 461452C43;
	Thu,  2 Apr 2026 02:46:47 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB1A13F641;
	Thu,  2 Apr 2026 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775123213; bh=FvUKH05X0Vg8xw6hf+KesUtG3wgK7luuKEGYXj3pxpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/Z6duT8MDcjgpam0RoaorFrpr24ywBdCO2b+95yCIt6TV2ncESJSWqXFv2cQgS7O
	 7sh4nx9VvyflgkMsPvloj+EVZ+rdAe3eMP5+G4JnewXwAvCSIoRp2sJgVG9FfASKtz
	 KE2/CjPVM2cCypGJ2IuFuyhuADdg/uEOpwObIwjo=
Date: Thu, 2 Apr 2026 10:46:50 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] perf arm_spe: Print remaining IMPDEF event numbers
Message-ID: <20260402094650.GH356832@e132581.arm.com>
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
 <20260401-james-spe-impdef-decode-v1-4-ad0d372c220c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-james-spe-impdef-decode-v1-4-ad0d372c220c@linaro.org>

On Wed, Apr 01, 2026 at 03:25:52PM +0100, James Clark wrote:
> Any IMPDEF events not printed out from a known core's IMPDEF list or for
> a completely unknown core will still not be shown to the user. Fix this
> by printing the remaining bits as comma separated raw numbers, e.g.
> "IMPDEF:1,2,3,4".
> 
> Suggested-by: Al Grant <al.grant@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 42a7501d4dfe..b93712ce0aca 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -364,6 +364,24 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>  						   payload);
>  	}
>  
> +	/*
> +	 * Print remaining IMPDEF bits that weren't printed above as raw
> +	 * "IMPDEF:1,2,3,4" etc.
> +	 */
> +	if (payload) {
> +		arm_spe_pkt_out_string(&err, &buf, &buf_len, " IMPDEF:",
> +				       payload);
> +		for (int i = 0; i < 64; i++) {

Nitpick: use for_each_set_bit(i, &payload, 64) instead.

> +			const char *sep = payload & (payload - 1) ? "," : "";
> +
> +			if (payload & BIT(i)) {
> +				arm_spe_pkt_out_string(&err, &buf, &buf_len,
> +						       "%d%s", i, sep);
> +				payload &= ~BIT(i);
> +			}
> +		}
> +	}
> +
>  	return err;
>  }
>  
> 
> -- 
> 2.34.1
> 
> 
