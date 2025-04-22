Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207C1D799D
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2025 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317800; cv=none; b=d0VnLFUrfYCQUcw5RktZlRoRgHqY1w+6SLLLIV3OlNAFYuZKRx5ZAGLtyjGriN2jU8CjxMfLxu2JblI0E6Sa252FugfirBIz2xqGyWtkC/FaPMavSuCpcXfS/kxW+UoiBOP/fqpSrMrv8mWZnyY6vZWpVN274ZwZfN6WPsFP28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317800; c=relaxed/simple;
	bh=JMSgKVULcC02OVaBReNIfOLNeuj8R4Zj4JGhc/RBKoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqbgsCV+Tz8GVPBXolqxk1pQ35OnMiDLxWkpINnzlys0BMzR2R0Y/SY+p4Awnq1/uNO4wXxZIiAMYDIOXc1gybDj/N6/BgSW4eWNebM85Ytk+mpIHx7fOwa2izeqN9+tsXC5Gs1Ss5cjZLoNdZ+WFF3jEnT4jJlS0UOAuSFYe5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4045B152B;
	Tue, 22 Apr 2025 03:29:53 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C6AA3F66E;
	Tue, 22 Apr 2025 03:29:57 -0700 (PDT)
Date: Tue, 22 Apr 2025 11:29:52 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Yicong Yang <yangyicong@huawei.com>, jonathan.cameron@huawei.com,
	hejunhao3@huawei.com, linuxarm@huawei.com, wangyushan12@huawei.com,
	caijingtao@huawei.com, xueshan2@huawei.com,
	prime.zeng@hisilicon.com, yangyicong@hisilicon.com, acme@kernel.org,
	namhyung@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	jolsa@kernel.org, john.g.garry@oracle.com, leo.yan@linux.dev,
	irogers@google.com, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Add support for SPE Data Source packet on
 HiSilicon HIP12
Message-ID: <20250422102952.GD28953@e132581.arm.com>
References: <20250408122809.37884-1-yangyicong@huawei.com>
 <89741897-6c8f-4b75-8ec3-675111ea60a1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89741897-6c8f-4b75-8ec3-675111ea60a1@linaro.org>

On Tue, Apr 22, 2025 at 10:16:40AM +0100, James Clark wrote:
> > 
> > Add data source encoding for HiSilicon HIP12 and coresponding mapping
> > to the perf's memory data source. This will help to synthesize the data
> > and support upper layer tools like perf-mem and perf-c2c.
> > 
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >   arch/arm64/include/asm/cputype.h              |   2 +
> >   tools/arch/arm64/include/asm/cputype.h        |   2 +

Please split into two patches.  One is a kernel patch and another is a
tool patch.

[...]

> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > @@ -82,6 +82,23 @@ enum arm_spe_ampereone_data_source {
> >   	ARM_SPE_AMPEREONE_L2D                           = 0x9,
> >   };
> > +enum arm_spe_hisi_hip_data_source {
> > +	ARM_SPE_HISI_HIP_PEER_CPU		= 0,
> > +	ARM_SPE_HISI_HIP_PEER_CPU_HITM		= 1,
> > +	ARM_SPE_HISI_HIP_L3			= 2,
> > +	ARM_SPE_HISI_HIP_L3_HITM		= 3,
> > +	ARM_SPE_HISI_HIP_PEER_CLUSTER		= 4,
> > +	ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM	= 5,
> > +	ARM_SPE_HISI_HIP_REMOTE_SOCKET		= 6,
> > +	ARM_SPE_HISI_HIP_REMOTE_SOCKET_HITM	= 7,
> > +	ARM_SPE_HISI_HIP_LOCAL			= 8,
> > +	ARM_SPE_HISI_HIP_REMOTE			= 9,
> > +	ARM_SPE_HISI_HIP_NC_DEV			= 13,
> > +	ARM_SPE_HISI_HIP_L2			= 16,
> > +	ARM_SPE_HISI_HIP_L2_HITM		= 17,
> > +	ARM_SPE_HISI_HIP_L1			= 18,
> > +};
> > +
> >   struct arm_spe_record {
> >   	enum arm_spe_sample_type type;
> >   	int err;
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index 2a9775649cc2..eceae4219601 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -571,6 +571,11 @@ static const struct midr_range ampereone_ds_encoding_cpus[] = {
> >   	{},
> >   };
> > +static const struct midr_range hisi_hip_ds_encoding_cpus[] = {
> > +	MIDR_ALL_VERSIONS(MIDR_HISI_HIP12),
> > +	{},
> > +};
> > +
> >   static void arm_spe__sample_flags(struct arm_spe_queue *speq)
> >   {
> >   	const struct arm_spe_record *record = &speq->decoder->record;
> > @@ -718,9 +723,105 @@ static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *re
> >   	arm_spe__synth_data_source_common(&common_record, data_src);
> >   }
> > +static void arm_spe__synth_data_source_hisi_hip(const struct arm_spe_record *record,
> > +						union perf_mem_data_src *data_src)
> > +{
> > +	/* Use common synthesis method to handle store operations */
> > +	if (record->op & ARM_SPE_OP_ST) {
> > +		arm_spe__synth_data_source_common(record, data_src);
> > +		return;
> > +	}
> > +
> > +	switch (record->source) {
> > +	case ARM_SPE_HISI_HIP_PEER_CPU:
> > +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> > +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> > +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;

Seems it is conflict to set both 'PERF_MEM_SNOOP_NONE' and
'PERF_MEM_SNOOPX_PEER'.

Remove setting 'PERF_MEM_SNOOP_NONE' in this case?

> > +		break;
> > +	case ARM_SPE_HISI_HIP_PEER_CPU_HITM:
> > +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> > +		break;
> > +	case ARM_SPE_HISI_HIP_L3:
> > +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> > +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> > +		break;
> > +	case ARM_SPE_HISI_HIP_L3_HITM:
> > +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> > +		break;
> > +	case ARM_SPE_HISI_HIP_PEER_CLUSTER:
> > +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;

Seems to me, a CPU has L3 cache, would the cluster has a higher level's
cache?

> > +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> > +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;

Ditto for the confliction for the two flags 'SNOOP_NONE' and
'SNOOPX_PEER'.

> > +		break;
> > +	case ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM:
> > +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> > +		break;
> > +	case ARM_SPE_HISI_HIP_REMOTE_SOCKET:
> > +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> > +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> > +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> 
> Hi Yicong,
> 
> Is the mem_snoop setting missing from this one?

The field 'mem_snoopx' is an extension to the field 'mem_snoop'.

If the field 'mem_snoopx' is set, it is no need to set 'mem_snoop'.

Thanks,
Leo
