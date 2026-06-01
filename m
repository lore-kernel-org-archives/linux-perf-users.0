Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39F030C34A;
	Mon,  1 Jun 2026 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338242; cv=none; b=oZZTo+AntvrdnC+JOWSIpvoX8wGxcc/PWr8WdafC9S+FmBY9dTej3W33plZ8+TVspl2fAIbDkQiXDtVyF4o5b13iwz43OXgJ/1Y2EDUKHbBnF+7yV+Kj4ROlvw4DK375MWAs04GVO25jYvUz1QGwAAaof88mBqczzJwvMlPSczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338242; c=relaxed/simple;
	bh=1F7fg/tEvp/FvUfG5iI5KCJsJYyIJR+YYPZox5LYG2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3eB6O/LiWxrvjhWE97Ei5pUMRWODWv7cn5ykc2pXwuxXjlojjBcrgbHTg4Ownz6CEVUIQRbH3ro9kS8OdORkJfDIVjK+W4jnE5FCd8Ubxqs3oGldP+/odsb2a+aYrBQZIBIv8MybpXOC0PkeKFftGqE3LjLZGxC1Xb+dOWHvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GbcxeAij; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GbcxeAij"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CD3B1BA8;
	Mon,  1 Jun 2026 11:23:55 -0700 (PDT)
Received: from [10.57.36.65] (unknown [10.57.36.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6FDB3F632;
	Mon,  1 Jun 2026 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780338240; bh=1F7fg/tEvp/FvUfG5iI5KCJsJYyIJR+YYPZox5LYG2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GbcxeAijqdZzVNCpLR680yLf2eIORskdf2ZWNmSznuwe2cL4sHhHTSwhNZujK0+Tf
	 LlOTv0A4LCBDYfnxgOqK3q3M0iT7a815YxMCqQlVzf8Fk/ZpumH5oUiHVvwprigKi3
	 j4Z8Emw1016utYplgyLgfP++/S2TsYfurtHZIxyU=
Message-ID: <3dd451b2-6d80-4636-a832-35b24411df2b@arm.com>
Date: Mon, 1 Jun 2026 19:23:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] perf/arm-cmn: Move DTM index data out of
 hw_perf_event
To: Aviv Bakal <avivb@amazon.com>, will@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, zeev@amazon.com, blakgeof@amazon.com,
 ilkka@os.amperecomputing.com
References: <20260524153848.16334-1-avivb@amazon.com>
 <20260531110447.10095-1-avivb@amazon.com>
 <20260531110447.10095-2-avivb@amazon.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260531110447.10095-2-avivb@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-31 12:04 pm, Aviv Bakal wrote:
> The amount of data we need to store all the per-DTM counter and
> watchpoint allocations is already testing the limits of hw_perf_event,
> and future CMNs are only likely to keep growing larger, so move these
> arrays out to separate memory allocations. As part of that we can use
> an explicit union for allocating cycle counters to dtc_cycles events,
> which is arguably nicer anyway.

Nit: not that I'm particularly precious about it, but this has lost my 
original authorship - I really should leave the technically-redundant 
"From:" line in when I post inline patches, as frankly even I prefer to 
just copy-paste the patch part rather than export the whole mail with 
its original headers for `git am --scissors`...

Thanks,
Robin.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Aviv Bakal <avivb@amazon.com>
> ---
>   drivers/perf/arm-cmn.c | 89 ++++++++++++++++++++++++++++--------------
>   1 file changed, 59 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f5305c8fdca4..f1978a53d1c1 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -597,17 +597,14 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
>   
>   struct arm_cmn_hw_event {
>   	struct arm_cmn_node *dn;
> -	u64 dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];
> +	union {
> +		u64 *dtm_idx;
> +		int cc_idx;
> +	};
> +	unsigned long *wp_idx;
>   	s8 dtc_idx[CMN_MAX_DTCS];
>   	u8 num_dns;
>   	u8 dtm_offset;
> -
> -	/*
> -	 * WP config registers are divided to UP and DOWN events. We need to
> -	 * keep to track only one of them.
> -	 */
> -	DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);
> -
>   	bool wide_sel;
>   	enum cmn_filter_select filter_sel;
>   };
> @@ -625,25 +622,42 @@ static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
>   	return (struct arm_cmn_hw_event *)&event->hw;
>   }
>   
> -static void arm_cmn_set_index(u64 x[], unsigned int pos, unsigned int val)
> +static void arm_cmn_set_dtm_idx(struct arm_cmn_hw_event *hw, unsigned int pos, unsigned int val)
>   {
> -	x[pos / 32] |= (u64)val << ((pos % 32) * 2);
> +	hw->dtm_idx[pos / 32] |= (u64)val << ((pos % 32) * 2);
>   }
>   
> -static unsigned int arm_cmn_get_index(u64 x[], unsigned int pos)
> +static unsigned int arm_cmn_get_dtm_idx(struct arm_cmn_hw_event *hw, unsigned int pos)
>   {
> -	return (x[pos / 32] >> ((pos % 32) * 2)) & 3;
> +	return (hw->dtm_idx[pos / 32] >> ((pos % 32) * 2)) & 3;
>   }
>   
> -static void arm_cmn_set_wp_idx(unsigned long *wp_idx, unsigned int pos, bool val)
> +static u64 *arm_cmn_alloc_dtm_idx(void)
> +{
> +	return kzalloc(DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64) * sizeof(u64), GFP_KERNEL);
> +}
> +
> +static void arm_cmn_set_wp_idx(struct arm_cmn_hw_event *hw, unsigned int pos, bool val)
>   {
>   	if (val)
> -		set_bit(pos, wp_idx);
> +		set_bit(pos, hw->wp_idx);
> +}
> +
> +static unsigned int arm_cmn_get_wp_idx(struct arm_cmn_hw_event *hw, unsigned int pos)
> +{
> +	return test_bit(pos, hw->wp_idx);
> +}
> +
> +static unsigned long *arm_cmn_alloc_wp_idx(void)
> +{
> +	return bitmap_zalloc(CMN_MAX_XPS, GFP_KERNEL);
>   }
>   
> -static unsigned int arm_cmn_get_wp_idx(unsigned long *wp_idx, unsigned int pos)
> +static void arm_cmn_clear_idx(struct arm_cmn_hw_event *hw)
>   {
> -	return test_bit(pos, wp_idx);
> +	memset(hw->dtm_idx, 0, DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64) * sizeof(u64));
> +	if (hw->wp_idx)
> +		bitmap_zero(hw->wp_idx, CMN_MAX_XPS);
>   }
>   
>   struct arm_cmn_event_attr {
> @@ -1376,7 +1390,7 @@ static int arm_cmn_get_assigned_wp_idx(struct perf_event *event,
>   				       struct arm_cmn_hw_event *hw,
>   				       unsigned int pos)
>   {
> -	return CMN_EVENT_EVENTID(event) + arm_cmn_get_wp_idx(hw->wp_idx, pos);
> +	return CMN_EVENT_EVENTID(event) + arm_cmn_get_wp_idx(hw, pos);
>   }
>   
>   static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
> @@ -1387,7 +1401,7 @@ static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
>   	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
>   
>   	dtm->wp_event[wp_idx] = hw->dtc_idx[dtc];
> -	arm_cmn_set_wp_idx(hw->wp_idx, pos, wp_idx - CMN_EVENT_EVENTID(event));
> +	arm_cmn_set_wp_idx(hw, pos, wp_idx - CMN_EVENT_EVENTID(event));
>   }
>   
>   static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
> @@ -1458,7 +1472,7 @@ static u64 arm_cmn_read_dtm(struct arm_cmn *cmn, struct arm_cmn_hw_event *hw,
>   			dtm = &cmn->dtms[dn->dtm] + hw->dtm_offset;
>   			reg = readq_relaxed(dtm->base + offset);
>   		}
> -		dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
> +		dtm_idx = arm_cmn_get_dtm_idx(hw, i);
>   		count += (u16)(reg >> (dtm_idx * 16));
>   	}
>   	return count;
> @@ -1505,7 +1519,7 @@ static void arm_cmn_event_read(struct perf_event *event)
>   	unsigned long flags;
>   
>   	if (CMN_EVENT_TYPE(event) == CMN_TYPE_DTC) {
> -		delta = arm_cmn_read_cc(cmn->dtc + hw->dtc_idx[0]);
> +		delta = arm_cmn_read_cc(cmn->dtc + hw->cc_idx);
>   		local64_add(delta, &event->count);
>   		return;
>   	}
> @@ -1572,7 +1586,7 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
>   	int i;
>   
>   	if (type == CMN_TYPE_DTC) {
> -		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
> +		struct arm_cmn_dtc *dtc = cmn->dtc + hw->cc_idx;
>   
>   		writel_relaxed(CMN_DT_DTC_CTL_DT_EN | CMN_DT_DTC_CTL_CG_DISABLE,
>   			       dtc->base + CMN_DT_DTC_CTL);
> @@ -1590,7 +1604,7 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
>   			writeq_relaxed(mask, base + CMN_DTM_WPn_MASK(wp_idx));
>   		}
>   	} else for_each_hw_dn(hw, dn, i) {
> -		int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
> +		int dtm_idx = arm_cmn_get_dtm_idx(hw, i);
>   
>   		arm_cmn_set_event_sel_lo(dn, dtm_idx, CMN_EVENT_EVENTID(event),
>   					 hw->wide_sel);
> @@ -1606,7 +1620,7 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
>   	int i;
>   
>   	if (type == CMN_TYPE_DTC) {
> -		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
> +		struct arm_cmn_dtc *dtc = cmn->dtc + hw->cc_idx;
>   
>   		dtc->cc_active = false;
>   		writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
> @@ -1619,7 +1633,7 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
>   			writeq_relaxed(~0ULL, base + CMN_DTM_WPn_VAL(wp_idx));
>   		}
>   	} else for_each_hw_dn(hw, dn, i) {
> -		int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
> +		int dtm_idx = arm_cmn_get_dtm_idx(hw, i);
>   
>   		arm_cmn_set_event_sel_lo(dn, dtm_idx, 0, hw->wide_sel);
>   	}
> @@ -1763,6 +1777,14 @@ static enum cmn_filter_select arm_cmn_filter_sel(const struct arm_cmn *cmn,
>   }
>   
>   
> +static void arm_cmn_event_destroy(struct perf_event *event)
> +{
> +	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
> +
> +	kfree(hw->dtm_idx);
> +	bitmap_free(hw->wp_idx);
> +}
> +
>   static int arm_cmn_event_init(struct perf_event *event)
>   {
>   	struct arm_cmn *cmn = to_cmn(event->pmu);
> @@ -1787,6 +1809,11 @@ static int arm_cmn_event_init(struct perf_event *event)
>   	if (type == CMN_TYPE_DTC)
>   		return arm_cmn_validate_group(cmn, event);
>   
> +	event->destroy = arm_cmn_event_destroy;
> +	hw->dtm_idx = arm_cmn_alloc_dtm_idx();
> +	if (!hw->dtm_idx)
> +		return -ENOMEM;
> +
>   	eventid = CMN_EVENT_EVENTID(event);
>   	/* For watchpoints we need the actual XP node here */
>   	if (type == CMN_TYPE_WP) {
> @@ -1797,6 +1824,9 @@ static int arm_cmn_event_init(struct perf_event *event)
>   		/* ...but the DTM may depend on which port we're watching */
>   		if (cmn->multi_dtm)
>   			hw->dtm_offset = CMN_EVENT_WP_DEV_SEL(event) / 2;
> +		hw->wp_idx = arm_cmn_alloc_wp_idx();
> +		if (!hw->wp_idx)
> +			return -ENOMEM;
>   	} else if (type == CMN_TYPE_XP &&
>   		   (cmn->part == PART_CMN700 || cmn->part == PART_CMN_S3)) {
>   		hw->wide_sel = true;
> @@ -1847,7 +1877,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
>   
>   	while (i--) {
>   		struct arm_cmn_dtm *dtm = &cmn->dtms[hw->dn[i].dtm] + hw->dtm_offset;
> -		unsigned int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
> +		unsigned int dtm_idx = arm_cmn_get_dtm_idx(hw, i);
>   
>   		if (type == CMN_TYPE_WP) {
>   			int wp_idx = arm_cmn_get_assigned_wp_idx(event, hw, i);
> @@ -1861,8 +1891,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
>   		dtm->pmu_config_low &= ~CMN__PMEVCNT_PAIRED(dtm_idx);
>   		writel_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
>   	}
> -	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
> -	memset(hw->wp_idx, 0, sizeof(hw->wp_idx));
> +	arm_cmn_clear_idx(hw);
>   
>   	for_each_hw_dtc_idx(hw, j, idx)
>   		cmn->dtc[j].counters[idx] = NULL;
> @@ -1882,7 +1911,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
>   				return -ENOSPC;
>   
>   		cmn->dtc[i].cycles = event;
> -		hw->dtc_idx[0] = i;
> +		hw->cc_idx = i;
>   
>   		if (flags & PERF_EF_START)
>   			arm_cmn_event_start(event, 0);
> @@ -1947,7 +1976,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
>   				goto free_dtms;
>   		}
>   
> -		arm_cmn_set_index(hw->dtm_idx, i, dtm_idx);
> +		arm_cmn_set_dtm_idx(hw, i, dtm_idx);
>   
>   		dtm->input_sel[dtm_idx] = input_sel;
>   		shift = CMN__PMEVCNTn_GLOBAL_NUM_SHIFT(dtm_idx);
> @@ -1980,7 +2009,7 @@ static void arm_cmn_event_del(struct perf_event *event, int flags)
>   	arm_cmn_event_stop(event, PERF_EF_UPDATE);
>   
>   	if (type == CMN_TYPE_DTC)
> -		cmn->dtc[hw->dtc_idx[0]].cycles = NULL;
> +		cmn->dtc[hw->cc_idx].cycles = NULL;
>   	else
>   		arm_cmn_event_clear(cmn, event, hw->num_dns);
>   }

