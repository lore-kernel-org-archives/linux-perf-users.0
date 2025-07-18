Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBB2D837C;
	Fri, 18 Jul 2025 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837346; cv=none; b=E8PWuIrJPlTpJCW5ajVnG3aKIaBDFrhmp7OqyYZQc8cybidHv21cObvS0qzTt2JLIp4wJLwuNPzM+/INPhfigTeLIXfZPveJ+RstzkvrF2JSBnFtcl+LKMNYKzQdWUR2wBkCz8dh2UMOqER94+yPEXpJfFS+/E/o7PoOmCVkRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837346; c=relaxed/simple;
	bh=IOFvSqzzVt1U1sxWQqxPec/Jz/EmyALt3ORS2Kd6Tgo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lftd7wgTlHoYj2c0S4qC1TlO9YVg+QEhlp6CG2eoQXMADOD4gR7eOtnG6VZjJmMa07efYmD7RmkpfO0kCo43DdiwB4W/1RD53QX8bdEca9pLcZnzok/WOdILz32IGC7ISjYqTK4KK7/6D04ynldF4h99qZQw15xq/GLN/mugaFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bk6cx5j1Xz6L5SD;
	Fri, 18 Jul 2025 19:14:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D83941402F6;
	Fri, 18 Jul 2025 19:15:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Jul
 2025 13:15:42 +0200
Date: Fri, 18 Jul 2025 12:15:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<coresight@lists.linaro.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<robh@kernel.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: Re: [PATCH v3 6/6] perf/arm-dsu: refactor cpu id retrieval via new
 API of_cpu_phandle_to_id
Message-ID: <20250718121540.000008d4@huawei.com>
In-Reply-To: <20250718094848.587-7-alireza.sanaee@huawei.com>
References: <20250718094848.587-1-alireza.sanaee@huawei.com>
	<20250718094848.587-7-alireza.sanaee@huawei.com>
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

On Fri, 18 Jul 2025 10:48:48 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Update arm-dsu to use the new API (of_cpu_phandle_to_id).
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/perf/arm_dsu_pmu.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index cb4fb59fe04b..8f76bd94349c 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -591,17 +591,12 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
>  static int dsu_pmu_dt_get_cpus(struct device *dev, cpumask_t *mask)
>  {
>  	int i = 0, n, cpu;
> -	struct device_node *cpu_node;
>  
>  	n = of_count_phandle_with_args(dev->of_node, "cpus", NULL);
>  	if (n <= 0)
>  		return -ENODEV;
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

