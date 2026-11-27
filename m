Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804962;
	b=MzJnHaDpu4YBKKHnQFxx4RJO7flIy8vxezxvaYffIidrlD77I/HAORMu8+X60VCiPJR7
	 OaU4IFQ+zkyGDJXiY7G1ERFkBiL33dOnpeIbkuNCVytQevEsYbSqCMv4rQimcnqdnxSC6
	 VNcA/qGQiXf9fS1NGmHi0+vvsOrymcuBhQBg/Nh35/Y44QQQycb3kgEuQyAcsOaNgNQYW
	 CtrhmioWoesrCLUVAyOErHOO64eE56LkTBrMuLQJL3eTIcYel/JOUnu6nO1FxzoEmcY8d
	 ynhJh9hoSwSAi1wRPeFKiOjRGRMoeY6Z8zU1h61MhMb/Q+D3xdZKTZzv3y2vgyP4SDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804962;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uTqOBQx0vgXwv13YeoLejNYHejF6xrAHQ5+KN1ozPjA=;
	b=TFaKt0RLuL2LoRqzyplJywlTNRoDUYd4+uh5b3FRZtI4a4419WBDXzOkFCyhZRmNT/uu
	 h0ENsd8Q0rCqcisTDD3Cg4BZw6PprXkMlPIgJDW9Vz/NfaMaWwku1OsoQSxFC+rn1X2w1
	 RMmaeQdhYqzx0m5KtwNd3ztHHKoHXQ1HXJ3Wqv2g6xAyu5hpzEoK89YIi69XngofTPevW
	 /C42DdUkD8q5cIl9CHoSipYiCxSfrD1u0R8ielHO2TTBaRpzia0JsPgoiStYEIixVE/ac
	 VM28XV+XUgOL607JoZ8T1D2gxDCKbfN+vqxWNbeUvEGYgx+C7AAEhML99OsbVBVuQcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRVKjS51;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D44606A32D;
	Fri, 27 Nov 2026 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRVKjS51
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329241F0092B;
	Fri, 27 Nov 2026 18:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804961;
	bh=uTqOBQx0vgXwv13YeoLejNYHejF6xrAHQ5+KN1ozPjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LRVKjS51t9MIhg2Gdqh8Xm/yZ71TJqurLZdEHmLcUEEKJuvdnR57wwUZJZSipiFXQ
	 EVqAwGDzGvilud6FHXhzB5NPktTp72SbeUpb9hzctFan2HEY3nTd4OnNZP/T2i4tVS
	 OBxLiX9v1O0/SyTVErbbEb9PZsgF9yTc743l3zzCT+poL59q1we+sb1+qrmLanvzWn
	 AkwUGU1gHTnbGOC7T6e6S4g8EbKadStJSlntrWU6HG6z+aeovdYWmTZr2aL8lupFbb
	 2yUWqaiFWDmFS7tUXtK49QAKeaf8kWnOMO6boUMpL9l3np5rn8fM+JXOoLGBo4d5w7
	 YIAjV9R/tBDcA==
Date: Fri, 27 Nov 2026 18:42:35 +0000
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org
Subject: Re: [PATCH 1/2] perf: arm_spe: Order padding before publishing AUX
 head
Message-ID: <awnPG6QADpRAgEzx@willie-the-truck>
References: <20261015-add_barriers_for_perf_aux_output_skip-v1-0-5847d0578859@arm.com>
 <20261015-add_barriers_for_perf_aux_output_skip-v1-1-5847d0578859@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-add_barriers_for_perf_aux_output_skip-v1-1-5847d0578859@arm.com>

On Thu, Oct 15, 2026 at 04:51:58PM +0100, Leo Yan wrote:
> The driver fills alignment gaps and calls perf_aux_output_skip(), which
> publishes the new aux_head without a memory barrier. A userspace
> consumer on another CPU can therefore observe the new head before the
> padding stores become visible.
> 
> Add smp_wmb() between the padding stores and perf_aux_output_skip().
> 
> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> Assisted-by: LLM
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index b70f3fedf0282baba1395ce1116272ec5f961ea8..e105462ec5f38eab4776b0a654ba7c8a84f70f71 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -487,8 +487,11 @@ static void arm_spe_pmu_pad_buf(struct perf_output_handle *handle, int len)
>  	u64 head = PERF_IDX2OFF(handle->head, buf);
>  
>  	memset(buf->base + head, ARM_SPE_BUF_PAD_BYTE, len);
> -	if (!buf->snapshot)
> +	if (!buf->snapshot) {
> +		/* Order the padding stores before publishing the new aux_head. */
> +		smp_wmb();
>  		perf_aux_output_skip(handle, len);
> +	}

This looks correct to me, but I wonder if it should be handled by
perf_aux_output_skip() instead? arm_spe_pmu_pad_buf() is called from a
bunch of places in the driver, including in conjunction with
perf_aux_output_end(), which looks like it already has the necessary
memory barrier. So doing it here seems weird inconsistent to me.

Will
