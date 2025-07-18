Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7428B41A;
	Fri, 18 Jul 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837264; cv=none; b=c5eCY6v4Qz42YfvLBF2WMS02YHmDvNlEGpAFOfxjNY0pC6QRu5df3DyRj45VPuHp9PiA6zIKubTco98EWATwVNVmSOBKEro5x1RbzwKnukKF6MBKK0qIVDj7saufPeZrvkrG4D0JAnc9FqM23GXy8GpI9vmwf3gpD8AFLovG5+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837264; c=relaxed/simple;
	bh=505uU5/GOKHyCEFjYTy9TVCU027IBUc4d7fzdeRjoqc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSPCTw++fdSf9fqHNMoXQVSP3p+HlVq6fhqSJaTFqglBsZtAMht7OX7N4NszpNNL7N0XddLm3KYxh52bW1R4DGeva0tbrfmKKnR0hktIH37CeCPZcaVsm9UoZKLJZRBNJaHEoTAoC1HMy8i0xFEzJFRq7REUBpaQPDCqQpQ9Elc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bk6bN1449z689xS;
	Fri, 18 Jul 2025 19:13:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 377B214033C;
	Fri, 18 Jul 2025 19:14:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Jul
 2025 13:14:20 +0200
Date: Fri, 18 Jul 2025 12:14:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<coresight@lists.linaro.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: Re: [PATCH v3 3/6] arch_topology: update CPU map to use
 of_cpu_phandle_to_id
Message-ID: <20250718121419.00007bfe@huawei.com>
In-Reply-To: <20250718094848.587-4-alireza.sanaee@huawei.com>
References: <20250718094848.587-1-alireza.sanaee@huawei.com>
	<20250718094848.587-4-alireza.sanaee@huawei.com>
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

On Fri, 18 Jul 2025 10:48:45 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Refactor get_cpu_for_node to use of_cpu_phandle_to_id instead of
> of_cpu_node_to_id.

If respinning, perhaps link this to the fact it's enabled by
the cpu_node no longer being used if we fail to get the related
cpu id as enabled by previous patch.

> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/base/arch_topology.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 6fafd86f608a..72bf23cdf469 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -474,20 +474,19 @@ static unsigned int max_smt_thread_num = 1;
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
>  	int cpu;
> -	struct device_node *cpu_node __free(device_node) =
> -		of_parse_phandle(node, "cpu", 0);
> +	struct device_node *cpu_node = NULL;
>  
> -	if (!cpu_node)
> -		return -1;
> -
> -	cpu = of_cpu_node_to_id(cpu_node);
> -	if (cpu < 0) {
> +	cpu = of_cpu_phandle_to_id(node, &cpu_node, 0);
> +	if (cpu == -ENODEV) {
>  		pr_info("CPU node exist but the possible cpu range is :%*pbl\n",
>  			cpumask_pr_args(cpu_possible_mask));
>  		return cpu;
> +	} else if (cpu < 0) {
> +		return -1;
>  	}
>  
>  	topology_parse_cpu_capacity(cpu_node, cpu);
> +	of_node_put(cpu_node);
>  	return cpu;
>  }
>  

