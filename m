Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66D28FF
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829673; cv=none; b=nwbC9xq7HVhaSCPgUM+l6HCeUmQVUEqyuVUdpX0R5aVzCM+N1a+k4r5m0PT+vEHqbRYh+a7W+dYVW/MnpJoWb5Ok+zW4c5xK/3/UgDDkB5gQTyZoD0r6DFwkQGvX9FqJlmS6GRykO8f0QJ/AG7rICuBbLC3PRwrpHJuPLs0mktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829673; c=relaxed/simple;
	bh=ySv9KWm67fLRgy9afTLLmtjFqVvhVKRqNxE62mu23gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtqZzHaK70awsP/6vlybWN1TryyaLNz9u2FpXnhLTvdQ5K19J88qum2nBprEmt7tHAVg+2COOg0kRSrO9YOTAgBU1Bimco2HAxob2RvvbdG8+hsLKd6zM2PZXHWs30WRupTdn7cq4OIPE4Bi1tkhLIc3CWb9g3gxoKYvLvBQoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM77EWG/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM77EWG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB1EC32782;
	Fri, 16 Aug 2024 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723829671;
	bh=ySv9KWm67fLRgy9afTLLmtjFqVvhVKRqNxE62mu23gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mM77EWG/wbwWo/XVp/mP29vYwkt+nuzb/zbs2iZN2CWBv9L0e7wlJffKMPDjNXwhg
	 FYi62ini0dPiOjXtJodT0/px23ZDG3SgxOmjL59I/W2uFtskkhUlHLZsM4IyYyXVFN
	 FMeMkVqJo6TZsht2BAX4qLQaa5b5tc+L4jQ0oiwbIGLsJtgaidradKJpU6YHpB9Kxm
	 jfKnO4TEpbjTUXCaA8zJp1j2P0nu4VV65lH+uyJioTZ1Erg7E1p59J81O0UsT16Spd
	 IvJSrEllymeD71xda7WsENJXeKTrtaxbjVkWB1EmqVoniKyD1w/BpLtOAcEzRybhln
	 Wz5nffZ9vpfZA==
Date: Fri, 16 Aug 2024 10:34:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: acme@kernel.org, mark.rutland@arm.com, mingo@redhat.com,
	peterz@infradead.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxarm@huawei.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, hejunhao3@huawei.com,
	prime.zeng@hisilicon.com
Subject: Re: [PATCH] perf stat: Display iostat headers correctly
Message-ID: <Zr-Npc3oKa5juMr3@google.com>
References: <20240802065800.48774-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240802065800.48774-1-yangyicong@huawei.com>

On Fri, Aug 02, 2024 at 02:58:00PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently we'll only print metric headers for metric leader in
> aggregration mode. This will make `perf iostat` header not shown
> since it'll aggregrated globally but don't have metric events:
> root@ubuntu204:/home/yang/linux/tools/perf# ./perf stat --iostat --timeout 1000
>  Performance counter stats for 'system wide':
>     port
> 0000:00                    0                    0                    0                    0
> 0000:80                    0                    0                    0                    0
> [...]
> 
> Fix this by excluding the iostat in the check of printing metric
> headers. Then we can see the headers:
> root@ubuntu204:/home/yang/linux/tools/perf# ./perf stat --iostat --timeout 1000
>  Performance counter stats for 'system wide':
>     port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
> 0000:00                    0                    0                    0                    0
> 0000:80                    0                    0                    0                    0
> [...]
> 
> Fixes: 193a9e30207f ("perf stat: Don't display metric header for non-leader uncore events")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/stat-display.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index c38bcb6f4c78..ea96e4ebad8c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1237,7 +1237,8 @@ static void print_metric_headers(struct perf_stat_config *config,
>  
>  	/* Print metrics headers only */
>  	evlist__for_each_entry(evlist, counter) {
> -		if (config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
> +		if (!config->iostat_run &&
> +		    config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
>  			continue;
>  
>  		os.evsel = counter;
> -- 
> 2.24.0
> 
