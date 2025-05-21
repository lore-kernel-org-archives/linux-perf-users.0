Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14C1F869E
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823866; cv=none; b=EkYdFxZz3JOMPcLEEB0ocfFKPvdYjpeBhJWAdOZNJ3vjmrsQtt0YfHdhmEtISYRSjtNJQ9528kAWqDRDnraOZvC0chpE+7UbCLnw9HFd3Noy8HmlMInL3Jm0PtlcO4AMGclTcBpQcI5htpCFgMqhf1SCiATlQ2obNMNuQr1zuz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823866; c=relaxed/simple;
	bh=QmA7o86tCPZCqCRSF5OpfGMLtc//K5RKA9NTXyVQhaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERcsoNzfjI4MpUcQf1kC4PXxGumtizpIpQNar7NlHImBMaOhYa3YciocNNdwLb73W/3T69Ya581Be44gfk6zUYSTthH5WIBtvtVUSHYNnWHBd5kmuaixww94Fte035ykruP6f2/bgRPOXbq2Blatan3O5qE1tWgwRmbXzthTKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E68C1515;
	Wed, 21 May 2025 03:37:30 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 039463F6A8;
	Wed, 21 May 2025 03:37:44 -0700 (PDT)
Date: Wed, 21 May 2025 11:37:42 +0100
From: Leo Yan <leo.yan@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: acme@kernel.org, namhyung@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, jolsa@kernel.org, john.g.garry@oracle.com,
	james.clark@linaro.org, leo.yan@linux.dev, irogers@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, jonathan.cameron@huawei.com,
	hejunhao3@huawei.com, linuxarm@huawei.com, wangyushan12@huawei.com,
	caijingtao@huawei.com, xueshan2@huawei.com,
	prime.zeng@hisilicon.com, yangyicong@hisilicon.com
Subject: Re: [PATCH v2 3/3] perf mem: Count L2 HITM for c2c statistic
Message-ID: <20250521103742.GB2565659@e132581.arm.com>
References: <20250425033845.57671-1-yangyicong@huawei.com>
 <20250425033845.57671-4-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425033845.57671-4-yangyicong@huawei.com>

On Fri, Apr 25, 2025 at 11:38:45AM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> L2 HITM is not counted in c2c statistic decoding. Count it for lcl_hitm
> like how we handle L2 Peer snoop.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/perf/util/mem-events.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 884d9aebce91..a384a866a562 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -680,7 +680,10 @@ do {				\
>  			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
>  			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
>  			if (lvl & P(LVL, L2)) {
> -				stats->ld_l2hit++;
> +				if (snoop & P(SNOOP, HITM))
> +					HITM_INC(lcl_hitm);
> +				else
> +					stats->ld_l2hit++;
>  
>  				if (snoopx & P(SNOOPX, PEER))
>  					PEER_INC(lcl_peer);
> 
> -- 
> 2.24.0
> 
