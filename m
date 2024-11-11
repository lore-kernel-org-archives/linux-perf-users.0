Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5F1AB51B;
	Mon, 11 Nov 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346966; cv=none; b=pIz6LWeBv5HyAQ5++dzlsARWIYogEA4N5wFUVrGHrkV+wpwDeqf0aXd2MpykDhVj9mGWMskIRnLbVbAlmsFYFMBtvE39jKTC67tFOWeGq9JN99l+vY52OHfoLhQSbaOz0sx7txiYUPAczuRAsFHcREBw4wDBcFlAJP+dR7a72OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346966; c=relaxed/simple;
	bh=5ptcc5MIydhLzQAXgmvEu3z1MN0JDB5Z53Q2+6ufP8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUTXJuDIQrEdSnxN2xHs+0UwXOSVIG2LwYY8EBbz+Ea5KF7cC/XvbFcToLg76dkR/8U52Gvj+l+j2ImDpsPv0xHu9gZY0tVo+J67E/jqcpzSSYeBjdLERv1ZOouF8666ewS8XPaDaS3SzPutOvGA59JFefRZlWEbigaqzR3Y2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3dKoCQR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3dKoCQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D6FC4CECF;
	Mon, 11 Nov 2024 17:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731346966;
	bh=5ptcc5MIydhLzQAXgmvEu3z1MN0JDB5Z53Q2+6ufP8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3dKoCQRVx5RI0fsldVpchG+QqNjEfXSBIWw/pTkAnmal0KcctOFRTWeNDH5lmKy7
	 pyI/k9GL2GNiJY90RhmC76ekQXuoEcUDtUwL7dk/9VagyBKyepXqk3gH4Ki6tBw+Fj
	 xIwMKCI8HTKm+3CGAIR3XNkZXsgyCQ1sjGUtlBTezBmwe3JnXoq8qd2N+4xx/dbpt3
	 YBgiE+J4PHKHK87ErlE2rvPoFXH7JgCuAKXPGIt8RW4XCG5FqNOx9LEdx/xXwhDURl
	 9U8dhwlnNHzV1haplEMA+G4TFOX809ozF8DkgzBgATr/7ZWhYX3jAB1PMtHbyFTC2S
	 5Lol5n7EWB9EA==
Date: Mon, 11 Nov 2024 14:42:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove redundant variable assignment
Message-ID: <ZzJCEadEKi8LiSTm@x1>
References: <20241111082713.274761-1-luoyifan@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111082713.274761-1-luoyifan@cmss.chinamobile.com>

On Mon, Nov 11, 2024 at 04:27:13PM +0800, Luo Yifan wrote:
> This patch makes a minor change that removes the redundant assignment
> to the variable ret, simplifying the code.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> ---
>  tools/perf/jvmti/jvmti_agent.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> index 526dcaf9f..751219143 100644
> --- a/tools/perf/jvmti/jvmti_agent.c
> +++ b/tools/perf/jvmti/jvmti_agent.c
> @@ -408,9 +408,7 @@ jvmti_write_code(void *agent, char const *sym,
>  
>  	funlockfile(fp);
>  
> -	ret = 0;
> -
> -	return ret;
> +	return 0;
>  }
>  
>  int
> -- 
> 2.27.0
> 
> 
