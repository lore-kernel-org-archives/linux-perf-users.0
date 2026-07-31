Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDBC478859;
	Fri, 31 Jul 2026 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515724; cv=none; b=mDTpDRr/FIEmBTex2FXf0jia/45ddf42apB1D2v/wYaXLlmW+3e5zqUHU29ig8C0zvIl53KY6YX3iJyZEOZdzf9IBVviIPaKKkmihFC8b5cjf9EtzCm9AaamYg+OhzLlowCl/tmpbazerQDOB4a+Bm5Q755km4ht1uoZ4ZOKxQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515724; c=relaxed/simple;
	bh=ACql2o2gpCtqZRUv9RK7iJLVg7TVMysxVvqq8bOkcqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebM2nxFJeT4g1Shp0jSrwAa6ehdDqASvopUyxMqGNgZZ4ioi/VK2f7muAyVQ15/tsjSCkTbVUnvRnEHvWw8BlG4My/Hp4kqCw76z7NryxU7PGC4YIRbzf8pJR7V76OCF8+QQI1DG7z4E6IanEgiLEN7sykGwb2qRxctiosozIrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A75PPhhw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A75PPhhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC961F00AC4;
	Fri, 31 Jul 2026 16:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515722;
	bh=NkJZ/CLZCqrrJVmZ4sECvr3Rls1mh0jRbdD02aNgAP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A75PPhhwpQaQO1MR4bQFB86B67cl9Du8EZ1Xs2WEtHdMutTxU+0Lc50ZJPBJqzw8J
	 1UNF48HNreF5AtlLk/4BY0KIAPGB4Q0zm5g2iHoqX0QrFZQqzHTN8m7CL6MQTKpw+h
	 G2/16erPLT5/yeSSFD+aDiheTZvg2gZIrAifgi8pM231HlNWC+QenXEzwKWTGAfiCM
	 NGIjdrRlK1NbnBcdgcSJKzUr49awU4W5kMfP9O49zRTq8HwZKhgvYwzb7WfHD95w9h
	 15ExuDiPNnl+iHo31rYuk7pd188fMU9OmC+Iix0kisOzgVKAMbQ0GGU1ApyghRH/S4
	 //0iVOsWCP1nw==
Date: Fri, 31 Jul 2026 17:35:16 +0100
From: Will Deacon <will@kernel.org>
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] drivers/perf: riscv: handle legacy fallback in event
 check
Message-ID: <amzOxPgM2v6O9XqD@google.com>
References: <20260710100837.1362558-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710100837.1362558-1-geomatsi@gmail.com>

On Fri, Jul 10, 2026 at 01:08:35PM +0300, Sergey Matyukevich wrote:
> Common events PERF_COUNT_HW_CPU_CYCLES and PERF_COUNT_HW_INSTRUCTIONS
> can fall back to the legacy counters. So do not mark them as invalid
> if OpenSBI reports that they are not mapped to sampling counters
> in PMU DT node.
> 
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index dfc886dee5ad..8f7aa71dc96f 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -335,7 +335,8 @@ static int pmu_sbi_check_event_info(void)
>  		goto free_mem;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++) {
> +	/* skip check for cycles and instructions as they can fall back to legacy counters */
> +	for (i = 2; i < ARRAY_SIZE(pmu_hw_event_map); i++) {
>  		if (!(event_info_shmem[i].output & RISCV_PMU_EVENT_INFO_OUTPUT_MASK))
>  			pmu_hw_event_map[i].event_idx = -ENOENT;
>  	}

I'm assuming the riscv tree are handling perf patches to the riscv driver,
but please shout if not.

Will
