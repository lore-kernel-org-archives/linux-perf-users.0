Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0362279DAB;
	Fri, 11 Jul 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225948; cv=none; b=aGwVjFLI53P9GNp0+LDrF2L8QjO//BoeqMMBLc1ad7X8Y8fn0+ZB4amjdBoleEw0ZbFNRcVckiIsvYImW2PvdCV2FiPN+l/RXyK8sYzuJaE1QG1aegZU/oaNX0cbD39aLPZbeXw+IFLWISzPGpjmn8B+JLomOL/BOM1d2gbmP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225948; c=relaxed/simple;
	bh=pZXe7EaL9faZo/4DiGm0OMVMrkmDlydKZaceJn88f/k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBd75gJ01zkjMccvMNWBQhXhvLhjrkMeNS+GUmdHjYMYL/8f+T4H7nPN6j3pbroX3ppCX4SO+M7pqbn8mBGj5JqUUjZ8WnN6MU7h9otKMGMeBiBjCL3MwHL3Je06bDwP4zbtbbJq5sW8zthKMNmJ4VMrhfIK8UhVzHn+5sNSEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdmSw4Xb7z6L4yC;
	Fri, 11 Jul 2025 17:22:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 546F21402CB;
	Fri, 11 Jul 2025 17:25:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 11:25:41 +0200
Date: Fri, 11 Jul 2025 10:25:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <krzk@kernel.org>, <robh@kernel.org>, <coresight@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 2/5] arch_topology: update CPU map to use the new API
Message-ID: <20250711102539.000065b6@huawei.com>
In-Reply-To: <20250708151502.561-3-alireza.sanaee@huawei.com>
References: <20250708151502.561-1-alireza.sanaee@huawei.com>
	<20250708151502.561-3-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Jul 2025 16:14:59 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Cleans up the cpu-map generation using the created API.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  drivers/base/arch_topology.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1037169abb45..ccc73bfae90d 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -473,19 +473,19 @@ static unsigned int max_smt_thread_num = 1;
>   */
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
> +	struct device_node *cpu_node;

Initialize to NULL.  Whilst we can see that it will always be initalized
static analysis tools and compilers probably can't.

>  	int cpu;
> -	struct device_node *cpu_node __free(device_node) =
> -		of_parse_phandle(node, "cpu", 0);
>  
> -	if (!cpu_node)
> -		return -1;
> -
> -	cpu = of_cpu_node_to_id(cpu_node);
> -	if (cpu >= 0)
> +	cpu = of_cpu_phandle_to_id(node, &cpu_node, 0);
> +	if (cpu >= 0) {
>  		topology_parse_cpu_capacity(cpu_node, cpu);
> -	else
> +		of_node_put(cpu_node);
> +	} else if (cpu == -ENODEV) {
>  		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
>  			cpu_node, cpumask_pr_args(cpu_possible_mask));
> +		of_node_put(cpu_node);
> +	} else
> +		return -1;

I'd be tempted to make this more conventional with error path out of line.

	cpu = of_cpu_phandle_to_id(node, &cpu_node, 0);
	if (cpu == -ENODEV) {
  		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
  			cpu_node, cpumask_pr_args(cpu_possible_mask));
		return -ENODEV;
	} else if (cpu < 0) {
`		return -1;  /* to keep ABI - it's odd but not something we should touch! */
// note this avoids need for the helper to return -1, it can return -EINVAL to indicate
// an invalid parameter.
	}

	topology_parse_cpu_capacity(cpu_node, cpu);
	of_node_put(cpu_node);

	return cpu;
	

>  
>  	return cpu;
>  }

