Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19600333759;
	Tue, 11 Nov 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873244; cv=none; b=DFmq4nGB5lKCJqqNfQRJHIuTtnkqnLrowePfgAHKzSIccYLWsz482dfLWvv/eZKZr/qv96cpZ0A7F/smX/G6Q3xGJZbsHRRP90SY7EdLn91NsMocsbokZtR7iZD2dctBJmnIVNV5ieDDYf2FnHyu8nGgViplPwrtFAhXnYKwCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873244; c=relaxed/simple;
	bh=HrCGAnADA84tzQ5+Lo3+CayeuJ+LB8eFol9AnK+Ndrk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlG0+iglS2+KIGjEn2IC2/kMKxpYxKxQFHTd6aUXeBn6UgzH0GZl9uwm7X/CEsQyqUoAZUY2XEJMGar9w4mcJl16RqP3MARf0u/OxnXXhGLbQsyddyRYr9i5kj28Q+hVGhiSZ9t9IMdC1KUN/7wRmHUvTK3bCIRiBxjDyrrgXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5V863PSQzHnGhS;
	Tue, 11 Nov 2025 23:00:22 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id BB289140136;
	Tue, 11 Nov 2025 23:00:39 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Nov
 2025 15:00:38 +0000
Date: Tue, 11 Nov 2025 15:00:33 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <coresight@lists.linaro.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <jonathan.cameron@huawei.com>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<mark.rutland@arm.com>, <mike.leach@linaro.org>, <robh@kernel.org>,
	<ruanjinjie@huawei.com>, <saravanak@google.com>, <suzuki.poulose@arm.com>,
	<sudeep.holla@arm.com>
Subject: Re: [PATCH v4 2/6] arch_topology: drop the use of cpu_node in the
 pr_info
Message-ID: <20251111150033.00002254.alireza.sanaee@huawei.com>
In-Reply-To: <20250905161830.37-3-alireza.sanaee@huawei.com>
References: <20250905161830.37-1-alireza.sanaee@huawei.com>
	<20250905161830.37-3-alireza.sanaee@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 5 Sep 2025 17:18:25 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

Hi everyone,

+CC Sudeep.

I checked the patchset related to this patch and it still applies.

Just a reminder if case you think it is ready.

Thanks,
Alireza

> Remove the use of cpu_node in the pr_info(). When of_cpu_node_to_id() fails,
> it may set a pointer, cpu_node, and the get_cpu_for_node() function uses that
> pointer to log further in the fail scenario.
> 
> Also, change the structure to exit early in fail scenarios which will
> help enabling code unification that follows in this series.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  drivers/base/arch_topology.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1037169abb45..6fafd86f608a 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -481,12 +481,13 @@ static int __init get_cpu_for_node(struct device_node *node)
>  		return -1;
>  
>  	cpu = of_cpu_node_to_id(cpu_node);
> -	if (cpu >= 0)
> -		topology_parse_cpu_capacity(cpu_node, cpu);
> -	else
> -		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
> -			cpu_node, cpumask_pr_args(cpu_possible_mask));
> +	if (cpu < 0) {
> +		pr_info("CPU node exist but the possible cpu range is :%*pbl\n",
> +			cpumask_pr_args(cpu_possible_mask));
> +		return cpu;
> +	}
>  
> +	topology_parse_cpu_capacity(cpu_node, cpu);
>  	return cpu;
>  }
>  

