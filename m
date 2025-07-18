Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538932BEC23;
	Fri, 18 Jul 2025 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837165; cv=none; b=fuooK7wgcpJ4/R1th7pZkIHX6525KL111zstc6lqdTTMkNr+eRzTZv9HKRC6GhEjtRTGvZzdQdCAl1zZFP4mFJIoMz7o8sJ27TovnI/VuXS4FYSrF7OiDRgEMdDJnPX/+qCQbDOjz8vSlKPwI5+HjxJKq069B8SHF+NSf50qv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837165; c=relaxed/simple;
	bh=FFB3OWSH77pgVw2sukp0UOuTzgd9s4ZkgJsJbCCcchc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLuTQv+Uvf9tTbDhASyy9m/6Jq+HTZJvnDD2vkbexYgzTHU7ZXqoVGDnQ8nH3/vgVdmwZL1bSd5uHcWi0nCIXjiaZdNB7vJ+UttHNGjoe28YWp7Ma9a9udVgn6iMmzs3J7zmcKZzNZKbAVdEyfyhhRPTABzNehAxT5Td+i6VSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bk6Vk6JhGz6L5Gj;
	Fri, 18 Jul 2025 19:09:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0953E140142;
	Fri, 18 Jul 2025 19:12:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Jul
 2025 13:12:40 +0200
Date: Fri, 18 Jul 2025 12:12:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<coresight@lists.linaro.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: Re: [PATCH v3 2/6] arch_topology: drop the use of cpu_node in the
 pr_info
Message-ID: <20250718121238.00005121@huawei.com>
In-Reply-To: <20250718094848.587-3-alireza.sanaee@huawei.com>
References: <20250718094848.587-1-alireza.sanaee@huawei.com>
	<20250718094848.587-3-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Jul 2025 10:48:44 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Remove the use of cpu_node in the pr_info. When of_cpu_node_to_id fails,
> it may set a pointer, cpu_node, and the get_cpu_for_node function uses that
> pointer to log further in the fail scenario.
> 
> Also, change the structure to exit early in fail scenarios which will
> help enabling code unification that follows in this series.

So this patch is the trade off to the unification.   Some small
amount of info in the info message is lost.  To me that looks
fine, but others may disagree!

I assume the motivation for not just leaving this one alone is
we ultimately need the flexible handler for the SMT series?

> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

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

