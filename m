Received: from mail-m21471.qiye.163.com (mail-m21471.qiye.163.com [117.135.214.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C321361
	for <linux-perf-users@vger.kernel.org>; Fri, 16 May 2025 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396928; cv=none; b=j5KZSrZymaCQ4qUbn3e14LVXtfhA8uewbEwc9OGhu3zE5EeQJaEYYnC3cvyH5okDvEgVDQyZm5d+eSKA9pCLvXcdIDeBm6wOwq2d743H7dNAY5rC/mZs1j5QAFPLLErDXfhYqXtlOKcYYQdBrTThUK6pAMBKb/EBOYM1vckgzrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396928; c=relaxed/simple;
	bh=s0mcS95IhHkIExxaG9LoapkL121UuKY5L5gdpgnaaeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJBKLyn/DeUurXfEmxvUUn30g/Re/owlaVCoQSbOqRTKhw5VrKcslEF4/3wLQ7qBUiZYZoVsjLv1k7BwoxxtE/KRLz9ihMi4kn4fKUsRKuzM2pZjy9jTR39mrOup0VQoHORJBTaJPzZHmLVvb/ocYD3QAuIN2dSLHiogILDWiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; arc=none smtp.client-ip=117.135.214.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Received: from [127.0.0.1] (unknown [122.224.241.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 154cedd92;
	Fri, 16 May 2025 19:46:37 +0800 (GMT+08:00)
Message-ID: <448a316c-3101-431c-b108-f2656283c06a@hj-micro.com>
Date: Fri, 16 May 2025 19:46:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf/arm-ni: IRQ improvements
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, peter.du@hj-micro.com,
 andy.xu@hj-micro.com, allen.wang@hj-micro.com
References: <cover.1747149165.git.robin.murphy@arm.com>
Content-Language: en-US
From: Shouping Wang <allen.wang@hj-micro.com>
In-Reply-To: <cover.1747149165.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHUpDVh1LTk5LTRkfTktIHVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUlPSlVIT1lXWRYaDxIVHRRZQVlPS0hVSktISk5MSlVKS0
	tVSkJLS1kG
X-HM-Tid: 0a96d8eaee4709d9kunm6f5b345b23a9be
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQw6CRw6KjE5NjQxKh8jURke
	SglPCgtVSlVKTE9MSEJOQkJDSk1OVTMWGhIXVRoXFx4VVQwaFRw7ExFWFhIYCRRVGBQWRVlXWRIL
	WUFZSklJVUlJT1VJT0pVSE9ZV1kIAVlBSkxCSzcG

Tested this patch set in the scenario of PMU shared interruption within
an individual NI instance, and no issues were found.

Tested-by: Shouping Wang <allen.wang@hj-micro.com>

On 5/13/2025 11:38 PM, Robin Murphy wrote:
> Hi all,
> 
> While the previous attempt[1] was missing some important aspects, it's
> a valid problem to solve, so I figured I'd take a look myself. This
> ended up turning into a slightly wider cleanup, but I think the end
> result is nice enough.
> 
> As usual I don't have anything to test this on, so if there are any
> silly mistakes left that the compiler couldn't catch please do let me
> know.
> 
> Thanks,
> Robin.
> 
> [1] https://lore.kernel.org/all/20250410114214.1599777-3-allen.wang@hj-micro.com/
> 
> 
> Robin Murphy (2):
>   perf/arm-ni: Set initial IRQ affinity
>   perf/arm-ni: Consolidate CPU affinity handling
> 
> Shouping Wang (1):
>   perf/arm-ni: Support sharing IRQs within an NI instance
> 
>  drivers/perf/arm-ni.c | 148 ++++++++++++++++++++++++------------------
>  1 file changed, 84 insertions(+), 64 deletions(-)
> 

