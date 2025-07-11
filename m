Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7C27A440;
	Fri, 11 Jul 2025 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226624; cv=none; b=sXJfBOx+hyboKM6xBfA5wadKu8BJwGCVRRQkYlG/z/sLgfe1oepJUOfpfjO/EtsL6POeHr6cEsXueVZgrjgM8NEwVEN+Yb5TwDKCk3q8ifbVxq30Cl3RUIJfs9BcR5s2gRlae5j30ChOzm9+gbybble/JYJA/KRnOtEypOnK7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226624; c=relaxed/simple;
	bh=azFqSl+rwP6HQPg9/Q0Rq21ARBUHwm/gLzKRnhAV+HA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFFleNgfPAk8FGwyo0n29WGxouZ8Zg4QE4cZCpeYnq5uuP5jmcZAPc2gidElwD7UgOBONW7aRm/+vA3tGrywkDO9Z5nHU1wgh1c1H/u5N5S9uDANXoDsE4kjw10IkPv71RAxuPUs4lrZ5gS8aUb/ebCAwEhb78eupSN4FzhTisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdmmj4y7Fz67kgS;
	Fri, 11 Jul 2025 17:36:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 288A71402E9;
	Fri, 11 Jul 2025 17:37:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 11:36:59 +0200
Date: Fri, 11 Jul 2025 10:36:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <krzk@kernel.org>, <robh@kernel.org>, <coresight@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 5/5] perf/arm-dsu: refactor cpu id retrieval via new
 API of_cpu_phandle_to_id
Message-ID: <20250711103657.0000059c@huawei.com>
In-Reply-To: <20250708151502.561-6-alireza.sanaee@huawei.com>
References: <20250708151502.561-1-alireza.sanaee@huawei.com>
	<20250708151502.561-6-alireza.sanaee@huawei.com>
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

On Tue, 8 Jul 2025 16:15:02 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Update arm-dsu to use the new API, where both "cpus" and "cpu"
> properties are supported.

I'd gloss over that and just not mention support of "cpu" as
it never applies here and we just queried the number of phandles
for cpus a few lines up.

> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  drivers/perf/arm_dsu_pmu.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index cb4fb59fe04b..1014b92c0fd2 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -591,17 +591,13 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
>  static int dsu_pmu_dt_get_cpus(struct device *dev, cpumask_t *mask)
>  {
>  	int i = 0, n, cpu;
> -	struct device_node *cpu_node;
>  
>  	n = of_count_phandle_with_args(dev->of_node, "cpus", NULL);
>  	if (n <= 0)
>  		return -ENODEV;
> +
Stray change - it's a valid one for readability but not in this patch.

>  	for (; i < n; i++) {
> -		cpu_node = of_parse_phandle(dev->of_node, "cpus", i);
> -		if (!cpu_node)
> -			break;
> -		cpu = of_cpu_node_to_id(cpu_node);
> -		of_node_put(cpu_node);
> +		cpu = of_cpu_phandle_to_id(dev->of_node, NULL, i);
>  		/*
>  		 * We have to ignore the failures here and continue scanning
>  		 * the list to handle cases where the nr_cpus could be capped

