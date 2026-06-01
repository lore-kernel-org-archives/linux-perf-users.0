Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B01D3E121E
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335926; cv=none; b=FIpouDzq1tw0bFvVHYZuHwt7e2JY2WNMRzIfVLFLG9NCtuxcgSCteRbJAZ76bfJJQIJfuylJMXlOG6w1A+w4RR2nQK3RNjqYnThP1o9FE7I/9KSPdRplXNd6I+CBud5uYykD87SopT36dS1kS7RIzZdmi5OKH8pim9X2O8IWnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335926; c=relaxed/simple;
	bh=obYPMTqCpdo/P+LHqGirODUwR9JZ1tIrVLU26guOo8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uq2hrGODIDHO7+clPBF/B+pqhaWSlF3AJevvwvr7BTQe1fS3dYuB0dBw1RnYM8LVEdXxbEexM/c4gO7+YyrXl+aIz//YyTh9WRmjvwvHLIEuLqngML7lqN79dIx5qUe3b8oEXG2dXricWl+vEGJPD4AQgjGlio/79KSnT54J1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KCmIEnUF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KCmIEnUF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D1CC1BA8;
	Mon,  1 Jun 2026 10:45:18 -0700 (PDT)
Received: from [10.57.36.65] (unknown [10.57.36.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D15F83F7D8;
	Mon,  1 Jun 2026 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780335923; bh=obYPMTqCpdo/P+LHqGirODUwR9JZ1tIrVLU26guOo8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KCmIEnUFWAUQXcvMZMdCzSlKsbbtQkS6c1Abuonbl/C0OjFv/SBoltrTJPjgVk8gW
	 4ilL2RIbAj+bKkRKE5MdIozqB8fqgGvx7986/zvZ37TQG9nfnIdWn7E5r8aH13o1/L
	 M7Tm0m7zw3+f/EaNW0eM4rKClvodJI5Bc/9/4w+A=
Message-ID: <59893923-0faa-4cfd-b062-16df596637c2@arm.com>
Date: Mon, 1 Jun 2026 18:45:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf/arm-cmn: Add workarounds for CMN-S3 on
 Graviton5
To: sashiko-reviews@lists.linux.dev, Aviv Bakal <avivb@amazon.com>
Cc: linux-perf-users@vger.kernel.org
References: <20260531110447.10095-3-avivb@amazon.com>
 <20260531113259.5B0F71F00893@smtp.kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260531113259.5B0F71F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

For the benefit of any humans...

On 2026-05-31 12:32 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Setting the DTC node's logical ID to the parent XP's logical ID causes DTC nodes to be sorted out of domain order, breaking PMU event routing.
> - [High] The hardcoded bit-shifts in arm_cmn_graviton5_dtc_domain() can produce DTC domains >= 4, leading to out-of-bounds writes in arm_cmn_event_init().
> 
> Pre-existing issues:
> - [High] Memory allocated for `hw->dtm_idx` and `hw->wp_idx` is leaked if `arm_cmn_event_init` fails.
> --
> 
> commit c34c59523c8b94745143d1d1114415bb33c12d3e
> Author: Aviv Bakal <avivb@amazon.com>
> 
> perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
> 
> Graviton5 uses a customised CMN-S3 implementation where certain discovery
> registers report zeroed fields. This patch adds workarounds to identify the
> variant, derive the DTC domain from the XP node ID, and set the DTC logical
> ID from the XP's logical ID.
> 
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index f1978a53d1c19..3fb71d9a57eb5 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -2250,6 +2253,18 @@ static unsigned int arm_cmn_dtc_domain(struct arm_cmn *cmn, void __iomem *xp_reg
>>   	return FIELD_GET(CMN_DTM_UNIT_INFO_DTC_DOMAIN, readl_relaxed(xp_region + offset));
>>   }
>>   
>> +static unsigned int arm_cmn_graviton5_dtc_domain(u16 xp_id)
>> +{
>> +	unsigned int x = (xp_id >> 7) & 0xf;
>> +	unsigned int y = (xp_id >> 3) & 0xf;
>> +
>> +	/*
>> +	 * The unit info register reads as zero; derive the DTC domain from
>> +	 * the XP's mesh coordinates over the 10x14 mesh.
>> +	 */
>> +	return (x / 5) + (y / 7) * 2;
>> +}
> 
> [Severity: High]
> Can the hardcoded bit-shifts extract overlapping bits if the mesh dimensions
> are smaller than 10x14?

No, because this code path is specific to things which firmware claims 
to be the Graviton5 CMN, and as such it hard-codes the known topology of 
the Graviton5 CMN. We have to assume we can trust what firmware tells us 
about the platform, or we wouldn't even be able to boot.

> If the system describes a smaller mesh (e.g., 8x8), arm_cmn_xyidbits
> evaluates to 3. This would cause the hardcoded shifts (xp_id >> 7) and
> (xp_id >> 3) to extract overlapping bits that inflate y (e.g., y = 15),
> yielding a domain of 5.
> 
> If a 14x10 mesh is used, the x coordinate can natively reach 13, yielding
> a domain index of 4 ((13 / 5) + (9 / 7) * 2).
> 
> When an unvalidated domain index >= 4 is assigned to dn->dtc, does it
> cause an out-of-bounds write in arm_cmn_event_init()?

No, because there is no such thing. The maximum possible number of DTC 
domains is 4. Even when correctly generated, the ID field in the 
register is only 2 bits:

https://developer.arm.com/documentation/107858/0205/Programmers-model/Register-summary/MXP-register-summary/por-dtm-unit-info?lang=en

> drivers/perf/arm-cmn.c:arm_cmn_event_init() {
>      ...
>      hw->dtc_idx[dn->dtc] = 0;
>      ...
> }
> 
> Since hw->dtc_idx is a fixed 4-byte array (s8 dtc_idx[CMN_MAX_DTCS]), an
> index >= 4 would write past its bounds and corrupt adjacent fields like
> hw->num_dns.
> 
> [ ... ]
> 
>> @@ -2472,6 +2497,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>>   
>>   			switch (dn->type) {
>>   			case CMN_TYPE_DTC:
>> +				if (graviton5_workaround) {
>> +					/* Node info logical ID is zeroed; use the XP's */
>> +					dn->logid = xp->logid;
>> +				}
> 
> [Severity: High]
> Does overriding the DTC logical ID with the parent XP's logical ID cause
> DTC nodes to be sorted out of domain order?
> 
> In arm_cmn_init_dtcs(), CMN_TYPE_DTC nodes are sorted by their logical ID
> (dn->logid), which determines their index in the dynamically allocated
> cmn->dtc array. Standard CMN parts have their logid read from hardware as
> the exact domain index (0-3).

No, the DTC logical ID is read from the logical_id field in 
por_dt_node_info, and while the main HN-D DTC always has an ID of 0, 
additional HN-T sub-DTCs should normally inherit the logical ID of their 
parent XP.

> Because the domain index here is a 2D block distribution, the physical XP IDs
> do not monotonically increase with the domain index. For example, an XP at
> x=7, y=0 belongs to domain 1 but has a smaller logid than an XP at
> x=2, y=3 which belongs to domain 0.

That is true, but since neither of those XPs has a DTC in this 
configuration, it is also entirely irrelevant.

> If cmn->dtc[0] points to the hardware base of domain 1 instead of domain 0,
> will events programmed for domain 0 be routed to domain 1's hardware, breaking
> PMU event counting?
> 
> Would it be better to explicitly set this as:
> 
>      dn->logid = arm_cmn_graviton5_dtc_domain(xp->id);

No, because that would then be inconsistent with how the driver works 
normally on non-Graviton5 systems, and as Aviv already confirmed, it 
doesn't change the outcome in this case anyway.

> [Severity: High]
> This is a pre-existing issue, but does arm_cmn_event_init() leak memory
> if initialization fails?
> 
> drivers/perf/arm-cmn.c:arm_cmn_event_init() {
>      ...
>      if (arm_cmn_is_watchpoint(event))
>          if (eventid != CMN_WP_UP && eventid != CMN_WP_DOWN)
>              return -EINVAL;
>      ...
>      return arm_cmn_validate_group(cmn, event);
> }
> 
> The driver dynamically allocates memory using arm_cmn_alloc_dtm_idx() and
> arm_cmn_alloc_wp_idx(). If the initialization subsequently encounters an
> error, such as an invalid eventid for a watchpoint or a failure in
> arm_cmn_validate_group(), it returns an error code without freeing the
> allocated memory.
> 
> The core perf code perf_try_init_event() does not call the driver's
> event->destroy() callback if pmu->event_init() fails, expecting the driver
> to clean up its own resources. Could this allow memory leaks if invalid events
> are repeatedly created?

No, __free_event() invokes event->destroy(), and if perf_alloc_event() 
could fail without freeing the event then that would be a much greater 
memory leak anyway.

Robin.
