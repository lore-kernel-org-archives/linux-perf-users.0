Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2816DC3D;
	Fri, 30 Aug 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014321; cv=none; b=Y/p8WDGknpj/imGnSvO+B62hzKvrvU6x9fJzO5Q76PEHQ/KDBgNasdiSEYMmwIJbZTSn18Dc8Y8vevbxji9iDzvtrSfq0D1CI6LZZ1ixGtNQkJ3aRy9bTOYRLQwG+KY7IzZhKWWvYsj3Sz8XkkLBaCxCur/yduHjRmOkPGV9ahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014321; c=relaxed/simple;
	bh=GAeIC74l96iRabcZuiiGMaXKEqc6GeEolRNrnRRbe2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNzv9rflNEoEaYx700ubJFbxZ/yv7PlCn4dqMCG3XXT6qx9TKYxkMyblJ6ghYpPyDUTkFwqOBTWT90wkOXjiKxJSy6ueaL/m6QhcCdsZjMaDZItVrjoa040/YVcpufsLlqeXQxa4wgvFyCWhW8EzIXWkjNOhlbgQ317zsRWiSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqGO9PSq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqGO9PSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A2AC4CEC6;
	Fri, 30 Aug 2024 10:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725014320;
	bh=GAeIC74l96iRabcZuiiGMaXKEqc6GeEolRNrnRRbe2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqGO9PSqbI4Yflj4w4+Q6amN5f4Ub2zApg3Di9Cxykn83M0UByHYZcV0ivVCqt7um
	 UnX+FkINMp2HbLgP5Qclr0QR5O4ItpPcWCK31Vc1RODJYOnCdFpLy4NIuUK6lUEBbg
	 Ti1azcdENtqg9GWstucjduCkvoAOiN6D1vLpyYNJjCmgXEZ+5ShMiDcHnckIUAnwoL
	 qIvMjqwX6e9SiP7APHzCpMU4DbFKuz0GEuW0MxDD3NYttoxexmELXQlPmO+guWvhyR
	 KfRisrQS8ZVIzV0gcCk0Aw0r3G8cPrmKCSKHSLF0pXPBvhN0mRoyrQd+u7B8MtJxiu
	 xjAeH/QfrGXTA==
Date: Fri, 30 Aug 2024 11:38:34 +0100
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/9] perf: arm_spe: Introduce 'lds' capacity
Message-ID: <20240830103834.GA8000@willie-the-truck>
References: <20240827164417.3309560-1-leo.yan@arm.com>
 <20240827164417.3309560-2-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827164417.3309560-2-leo.yan@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Aug 27, 2024 at 05:44:09PM +0100, Leo Yan wrote:
> This commit adds a new entry 'lds' in the capacity folder. 'lds' stands
> for "loaded data source". When its value is 1, it indicates the data
> source implemented, and data source packets will be recorded in the
> trace data.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 9100d82bfabc..81c1e7627721 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -110,6 +110,7 @@ enum arm_spe_pmu_buf_fault_action {
>  /* This sysfs gunk was really good fun to write. */
>  enum arm_spe_pmu_capabilities {
>  	SPE_PMU_CAP_ARCH_INST = 0,
> +	SPE_PMU_CAP_LDS,
>  	SPE_PMU_CAP_ERND,
>  	SPE_PMU_CAP_FEAT_MAX,
>  	SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
> @@ -118,6 +119,7 @@ enum arm_spe_pmu_capabilities {
>  
>  static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
>  	[SPE_PMU_CAP_ARCH_INST]	= SPE_PMU_FEAT_ARCH_INST,
> +	[SPE_PMU_CAP_LDS]	= SPE_PMU_FEAT_LDS,
>  	[SPE_PMU_CAP_ERND]	= SPE_PMU_FEAT_ERND,
>  };
>  
> @@ -160,6 +162,7 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
>  
>  static struct attribute *arm_spe_pmu_cap_attr[] = {
>  	SPE_CAP_EXT_ATTR_ENTRY(arch_inst, SPE_PMU_CAP_ARCH_INST),
> +	SPE_CAP_EXT_ATTR_ENTRY(lds, SPE_PMU_CAP_LDS),
>  	SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
>  	SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
>  	SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),

What will userspace do with this? I don't think you can turn LDS on/off,
so either you'll get the data source packet or you won't.

Will
