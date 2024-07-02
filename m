Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276841DA32A;
	Tue,  2 Jul 2024 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964318; cv=none; b=gE98a3dScspoVxzvu1a3n5/cDwvy9umxzgjC6XCL58wlpz1ATRgCMAv1tGNDvS+jI4nl1TawDoOe96YKPFkZ+7lZ78UbBakOI1nMsLTpYng+UuSjWkNL0zHON+Gj4+0ZhG+m2z2Ijui8a7fj4no3MapUwZ1LfeeoW/Ruq2VkVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964318; c=relaxed/simple;
	bh=xtGEMklBASK9K0okBDOej3qK+gT+9/BIodo+1smdjCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVf8p3JKjVVbzrjJMPJAjaPKsI/ILbSPd2Q1zH/d5G1YWpfDhiST2HSAzYpPriGFZsNcPpuhWzvC9zYiHfpckA9JKgSd73Dqjg77UIy5x4UuOl/J5WR/Y7/a+fSKOoQs8/O5kIujD+KKJNLqZwawSNKyakwtzrjSXiJ91EP1Tok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb/HnJBB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb/HnJBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1AEC116B1;
	Tue,  2 Jul 2024 23:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964318;
	bh=xtGEMklBASK9K0okBDOej3qK+gT+9/BIodo+1smdjCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jb/HnJBBDEdpZiTmtQAk61Kx2Ohuufbxox3fv5JTpJ+v0sJ/RcZt7JCWNKfXROERb
	 A2/Sf1N9tG8rdadPsCJO6FESq5C286nF+7jyy+NV8inVWbENWPIGSz+U7sKpv7Rmel
	 THBM98c0ZjSVR/MZYoBcljxNHV2apRXtAqDdjhTLAs/VgmverZYLo0lAc3QwWTYW2/
	 hE/CC2emDPLEBn8T4ntA1ju+NMPbBr1L6m+QIRWgkGr+2EhzNEn+xkPYyQ9DNKwVFZ
	 3F/RaWeRTrlHqS+HiK4SsgS+6XJ/uWS63EcEsd05SqzzfhXzxKWA6uifikbsnOc1eJ
	 VK8CqhOMLVnuw==
Date: Tue, 2 Jul 2024 16:51:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf pmu: Remove unneeded semicolon
Message-ID: <ZoSSnBBXr5kb_zv3@google.com>
References: <20240701034300.558886-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701034300.558886-1-nichen@iscas.ac.cn>

Hello,

On Mon, Jul 01, 2024 at 11:43:00AM +0800, Chen Ni wrote:
> Remove unneeded semicolon.
> This is detected by coccinelle.
> 
> Fixes: d9c5f5f94c2d ("perf pmu: Count sys and cpuid JSON events separately")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Thanks for the fix but it's already fixed.

https://lore.kernel.org/linux-perf-users/20240628053049.44521-1-yang.lee@linux.alibaba.com/

Namhyung

> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index c94a91645b21..884eb23445e4 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1773,7 +1773,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>  	size_t nr;
>  
>  	pmu_aliases_parse(pmu);
> -	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;;
> +	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
>  
>  	if (pmu->cpu_aliases_added)
>  		 nr += pmu->cpu_json_aliases;
> -- 
> 2.25.1
> 
