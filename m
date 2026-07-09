Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F383EDE76;
	Thu,  9 Jul 2026 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611066; cv=none; b=SZpgqKHVaFB7HuDEvfgx4GxOvfkSSF/pTocnmEUy64z0IqY1o0ofk/UxnshFHRqOuP5fH+Mq4CztbpyQ10Uf3kENmuDu/IoNlVxV1EpIHULwi2rvWMcmM0gj/dUL5mV37WWL29PtVRXUbt8rI0WtLZPZ8C/uST/R2YiQ7ZYwNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611066; c=relaxed/simple;
	bh=LGskLhmxYfvHzHuCkKOj7Dy/A6cwneAsqkt5alVmAzI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K5O15zBI8DtRP91ChqxkSAJDin3PfjvKH80MFuE/bj4yGTBjZYZAJwswApwTKqSBs6AQrvklWrpP2yxNas9pz5D3Mf3pCUnNha+3zCHq9oKONgE/j3kg68e9rF6y1MIalf1QZwgP/05Q6Ed/Jf+QQP3awoIGUAn21/mVK9LPGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FCSV/iR7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FCSV/iR7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC481570;
	Thu,  9 Jul 2026 08:31:00 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFBC23F85F;
	Thu,  9 Jul 2026 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783611064; bh=LGskLhmxYfvHzHuCkKOj7Dy/A6cwneAsqkt5alVmAzI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FCSV/iR7WdzNJ8q/yUAXRNzxwp9D4CwI1WTaNrC+TlkDFXavtgvXkcrnyIlB1e69f
	 pHkoqAoeEgd6f7iDa9lTzLCa3FXz5nKErmi8YY0ZAa+EYHvujBHZIpFNBjyyMiEN7Z
	 dD2iWqsc4bXfsNedkgJ0oF5ci98ZA2jFQh0yU0a0=
Message-ID: <2a1ed630-3f88-400e-85cc-596b4dd5f5a8@arm.com>
Date: Thu, 9 Jul 2026 16:31:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ACPI/APMT: Use stable device ID
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com
Cc: ilkka@os.amperecomputing.com, bwicaksono@nvidia.com,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>
References: <cover.1783605641.git.robin.murphy@arm.com>
 <c113eff51124250fc5798589ce905052046b43b3.1783605641.git.robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <c113eff51124250fc5798589ce905052046b43b3.1783605641.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2026 3:39 pm, Robin Murphy wrote:
> The APMT node format includes a unique identifier, so we can use this as
> the platform device ID to give userspace stable and identifiable device
> names, rather than auto numbering dependent on how the table is parsed.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@kernel.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/acpi/arm64/apmt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> index bb010f6164e5..ba48fcb26d52 100644
> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -79,7 +79,7 @@ static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
>   	int ret, count;
>   	struct resource res[DEV_MAX_RESOURCE_COUNT];
>   
> -	pdev = platform_device_alloc(DEV_NAME, PLATFORM_DEVID_AUTO);
> +	pdev = platform_device_alloc(DEV_NAME, node->id);

Per the Sashiko comment, while I really wouldn't expect it to be an 
issue in practice, I guess we could explicitly check and truncate 
node->id to INT_MAX (probably with some degree of warning) here just in 
case.

Cheers,
Robin.

>   	if (!pdev)
>   		return -ENOMEM;
>   

