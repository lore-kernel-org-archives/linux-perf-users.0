Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DDA367287;
	Thu, 21 May 2026 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379364; cv=none; b=ZAYjdz7mWsABNZvR3QpNPXIV8cFXd5usBcjAV/Bc9t/NXP6fkiibK33yc+zZKSUP6paUadeG8qWg8j9UzdfZ3EgVOY4qhWp+NQ86HVPSxWiCtgl+hx2Fs6Ra+26Yev65bp4x0M9bgFAP/BHXcKk2zhgOK/birtg7Jt8Gb9Fjbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379364; c=relaxed/simple;
	bh=XM29D7iPUunyxNUrBD0yY0EWuJn4Z+yCZPfjI3A0bwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njN+fGUceBtdOXwuANx8TUNmbuECQBEwwJUM2bGnjKNlSBHgaYGJqiNTO1RM1cgb7a1A9NfirWmqOuDlPy3tFuBqsg5hFufH82ty8FdTLxGSd2HB3Diu0uXLXO0Sj4uDXWUQyuTRRrBxyq3LzlTPUrpyqmkjb8ufCrkm5j0RbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VCraftv2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VCraftv2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C971168F;
	Thu, 21 May 2026 09:02:37 -0700 (PDT)
Received: from [10.57.33.205] (unknown [10.57.33.205])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C816C3F632;
	Thu, 21 May 2026 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779379362; bh=XM29D7iPUunyxNUrBD0yY0EWuJn4Z+yCZPfjI3A0bwQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VCraftv2925M7X6jExStT/wSW5s5JX0NWpAiBizlmsBSFQP1dLO0EEXjldGprAiTA
	 j74scLLrDd1tQrCydJ7Mm1PggCuIZ2DWHlu66eMzw+ajFhtHbWCMZAFqcmoI/wHiVW
	 VD26xbG6VTfBt9dQd4i1e2kGg61pFYIt5M3JgIb4=
Message-ID: <dd188101-5edd-4787-8217-4edf4bde094a@arm.com>
Date: Thu, 21 May 2026 17:02:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
To: Aviv Bakal <avivb@amazon.com>, will@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, zeev@amazon.com, blakgeof@amazon.com
References: <20260503155118.16191-1-avivb@amazon.com>
 <20260504133923.23373-1-avivb@amazon.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260504133923.23373-1-avivb@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-04 2:39 pm, Aviv Bakal wrote:
> Graviton5 uses a customised CMN-S3 implementation where certain
> discovery registers report zeroed fields. Add the following workarounds:
> 
>   - Introduce a dedicated ACPI HID to identify the Graviton5 CMN variant.
>   - Derive the DTC domain from the XP node ID, since the unit info
>     register reports it as zero.
>   - Set the DTC logical ID from the computed domain ID, since the node
>     info register's logical ID field is also zeroed.
> 
> Signed-off-by: Aviv Bakal <avivb@amazon.com>
> ---
> v2:
>   - Use computed domain ID (xp->dtc) instead of XP logical ID for DTC
>     logical ID assignment.
> 
>   drivers/perf/arm-cmn.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f5305c8fdca4..8ee3f8638602 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -31,7 +31,8 @@
>   #define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
>   #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
>   
> -#define CMN_MAX_DIMENSION		12
> +/* Some implementations use a mesh larger than the architectural max of 12 */
> +#define CMN_MAX_DIMENSION		14
>   #define CMN_MAX_XPS			(CMN_MAX_DIMENSION * CMN_MAX_DIMENSION)
>   #define CMN_MAX_DTMS			(CMN_MAX_XPS + (CMN_MAX_DIMENSION - 1) * 4)
>   
> @@ -214,6 +215,8 @@ enum cmn_part {
>   	PART_CMN700 = 0x43c,
>   	PART_CI700 = 0x43a,
>   	PART_CMN_S3 = 0x43e,
> +	/* Synthetic part number, overridden to PART_CMN_S3 during discovery */
> +	PART_GRAVITON5 = 0xa5,
>   };
>   
>   /* CMN-600 r0px shouldn't exist in silicon, thankfully */
> @@ -2221,6 +2224,18 @@ static unsigned int arm_cmn_dtc_domain(struct arm_cmn *cmn, void __iomem *xp_reg
>   	return FIELD_GET(CMN_DTM_UNIT_INFO_DTC_DOMAIN, readl_relaxed(xp_region + offset));
>   }
>   
> +static unsigned int arm_cmn_graviton5_dtc_domain(u16 xp_id)
> +{
> +	unsigned int x = (xp_id >> 7) & 0xf;
> +	unsigned int y = (xp_id >> 3) & 0xf;
> +
> +	/*
> +	 * The unit info register reads as zero; derive the DTC domain from
> +	 * the XP's mesh coordinates over the 10x14 mesh.
> +	 */
> +	return (x / 5) + (y / 7) * 2;
> +}
> +
>   static void arm_cmn_init_node_info(struct arm_cmn *cmn, u32 offset, struct arm_cmn_node *node)
>   {
>   	int level;
> @@ -2266,6 +2281,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>   	u64 reg;
>   	int i, j;
>   	size_t sz;
> +	bool graviton5_workaround = false;
>   
>   	arm_cmn_init_node_info(cmn, rgn_offset, &cfg);
>   	if (cfg.type != CMN_TYPE_CFG)
> @@ -2276,6 +2292,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>   	reg = readq_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_01);
>   	part = FIELD_GET(CMN_CFGM_PID0_PART_0, reg);
>   	part |= FIELD_GET(CMN_CFGM_PID1_PART_1, reg) << 8;
> +
> +	/* Graviton5 has a customised CMN-S3 which needs some fixups */
> +	if (cmn->part == PART_GRAVITON5) {
> +		cmn->part = PART_CMN_S3;
> +		graviton5_workaround = true;
> +	}
> +
>   	/* 600AE is close enough that it's not really worth more complexity */
>   	if (part == PART_CMN600AE)
>   		part = PART_CMN600;
> @@ -2365,6 +2388,8 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>   
>   		if (cmn->part == PART_CMN600)
>   			xp->dtc = -1;
> +		else if (graviton5_workaround)
> +			xp->dtc = arm_cmn_graviton5_dtc_domain(xp->id);
>   		else
>   			xp->dtc = arm_cmn_dtc_domain(cmn, xp_region);
>   
> @@ -2443,6 +2468,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>   
>   			switch (dn->type) {
>   			case CMN_TYPE_DTC:
> +				if (graviton5_workaround) {
> +					/* Node info logical ID is zeroed; use the domain ID */
> +					dn->logid = xp->dtc;

No, this really should be xp->logid - other than DTC0 whose logical ID 
is always forced to 0, but if it naturally lines up that way anyway then 
all the better - since that is consistent with how the tooling generates 
a regular hardware configuration. The cmn->dtc array ends up sorted by 
logical ID as that is a guaranteed stable order for all CMN versions (as 
the domain numbers themselves aren't always known), and it is the 
interrupt order defined by the firmware bindings which we need to match. 
If it's not guaranteed that the actual domain numbers are in the same 
order then we have an existing bug in general (I'll have to check...)

Otherwise, this looks OK to me - in fact surprisingly pleasant and 
unobtrusive given that it's a pretty horrible hardware issue to work 
around. I guess we get lucky that it's an easy topology to compute.

Thanks,
Robin.

> +				}
>   				cmn->num_dtcs++;
>   				dn++;
>   				break;
> @@ -2658,6 +2687,7 @@ static const struct acpi_device_id arm_cmn_acpi_match[] = {
>   	{ "ARMHC650" },
>   	{ "ARMHC700" },
>   	{ "ARMHC003" },
> +	{ "AMZN0070", PART_GRAVITON5 },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);

