Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1385E2F25F3
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216029; cv=none; b=TQrxPfUd0Zwo3Dr6vsRi4uVh53fTm+ykcg/Bl27qcuMTgR9k0vrD/z5Eut679jtYSyOfuAsdlOjbz+cBC5rzzAoNkHusi1cAEmQI/a+wkE9Y+QSkhB/Cz4UO3nUEjZftnSIDw3EM6g98aRlFbMt+2snSvGlvxaEX7pOOh0veU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216029; c=relaxed/simple;
	bh=j4sjfTFJQWsw6I5QPM3QBvOXr4cCV40hB6IYbma6f58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgScgGeNCTdM0uBUe6bgwZi6nV6tXRJNHfErCSIqsDmokTSScS6QGk8tFgLyipokTtQZWk57idrJQ9xHvncSydQL77cKnqagEtJLoA7OgvzoMIYy7CtlkuYS6IL0qv6Yi76GSysaQpMzBFSYC6p1/O70cXgz2Xzb4c9XzIsjT+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pswSQB1U; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pswSQB1U"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B8A21477;
	Thu, 16 Jul 2026 08:33:41 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EB353F66F;
	Thu, 16 Jul 2026 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784216025; bh=j4sjfTFJQWsw6I5QPM3QBvOXr4cCV40hB6IYbma6f58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pswSQB1Up5eNY1UWIjPcTMvREiFmUxZIzQcH6wpD47XLPUoXa14/NfOfvZwfKrvPG
	 u5ibZYqWxY+GlJ4oq6sGjwXhs3flWVaYqkXz0YylQl6O6t3K5G/GUzz4m9eRY5va5I
	 MJlSHInfv6xPv/7Qc89yBU8cambDP2QpmdWNY0Zc=
Message-ID: <b76a6102-5b27-44fe-9d94-4d7e79d9094e@arm.com>
Date: Thu, 16 Jul 2026 16:33:43 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ACPI/APMT: Use stable device ID
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1784213435.git.robin.murphy@arm.com>
 <f7eb9a4cfea4cd6f8d87f3c2501438d484807d27.1784213435.git.robin.murphy@arm.com>
 <20260716151706.B13061F000E9@smtp.kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260716151706.B13061F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2026 4:17 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Platform device ID collision causing APMT parsing abort and subsequent UAF.
> 
> Pre-existing issues:
> - [High] Missing rollback on failure leaves previously registered platform devices holding dangling pointers to an unmapped ACPI table.
> - [High] Missing bounds check on `apmt_node->length` allows out-of-bounds memory read.
> - [Medium] GSI IRQ mapping is leaked on platform device registration error paths.
> --
> 
> --- Patch [1]: [PATCH v2 1/4] ACPI/APMT: Use stable device ID ---
> commit 895c0eb864a4218fbb99620f4fa9efb2dc4e091c
> Author: Robin Murphy <robin.murphy@arm.com>
> 
> ACPI/APMT: Use stable device ID
> 
> The APMT node format includes a unique identifier, so we can use this as
> the platform device ID to give userspace stable and identifiable device
> names.
> 
>> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
>> index bb010f6164e52..91fcdd289e637 100644
>> --- a/drivers/acpi/arm64/apmt.c
>> +++ b/drivers/acpi/arm64/apmt.c
>> @@ -76,10 +76,12 @@ static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
>>   					   struct fwnode_handle *fwnode)
>>   {
>>   	struct platform_device *pdev;
>> -	int ret, count;
>> +	int ret, count, uid = node->id & INT_MAX;
>>   	struct resource res[DEV_MAX_RESOURCE_COUNT];
>>   
>> -	pdev = platform_device_alloc(DEV_NAME, PLATFORM_DEVID_AUTO);
>> +	if (uid != node->id)
>> +		pr_warn("Unexpectedly large UID 0x%x, truncated to 0x%x\n", node->id, uid);
>> +	pdev = platform_device_alloc(DEV_NAME, uid);
> 
> [Severity: High]
> Does this newly introduced truncation create a risk of ID collisions if two
> unique 32-bit APMT node IDs differ only in the sign bit?

In theory, yes. Hopefully the warning here and subsequent sysfs 
explosion will alert the firmware developers that they've done something 
very silly when they first try to boot to test their newly-written APMT.

Robin.
