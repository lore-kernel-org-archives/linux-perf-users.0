Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F54221FB5;
	Tue,  8 Jul 2025 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963937; cv=none; b=YRE+UlVUbtz53GYjbkHDUovmmTd2Ko4+/cpdQIcNF5Kt6dkkoEg+5qgBVemUCk/OdxooipC0FC2k6hr4t8oPlF/KS0HQLzXTbDFLrDJmQ24I+CfI8qqJptp0CRsjqIwQ+u/UxyNPkA8XWgf6u66VXXfLNTCNMxk9sXfE8KIYCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963937; c=relaxed/simple;
	bh=yuo9m78iKpoMj/RpIVGZtv0+pn0ZYjPqp/GNs1PSc5g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQm66U7GNw+koXEu/l8iJih9GvTZxa72jfUQEEI/fvctOC9SaudhqepZrRiIJlcFOd4IOOcwhe5okvOgNP27nRBynsOJU/Ejy9g6ZJUOsIXo5dFt604CBzDxiF3o273y7aqPIioNt6YdMLBD/M5TJdMuZzCc8dDfnMr71F2EUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbvdF258Cz6GCZG;
	Tue,  8 Jul 2025 16:38:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A7FF140144;
	Tue,  8 Jul 2025 16:38:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Jul
 2025 10:38:53 +0200
Date: Tue, 8 Jul 2025 09:38:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <mark.rutland@arm.com>, <robh@kernel.org>, <coresight@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linuxarm@huawei.com>,
	<mike.leach@linaro.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: Re: [PATCH 5/5] perf/arm-dsu: refactor cpu id retrieval via new API
 of_cpu_phandle_to_id
Message-ID: <20250708093851.000030e3@huawei.com>
In-Reply-To: <20250707150414.620-6-alireza.sanaee@huawei.com>
References: <20250707150414.620-1-alireza.sanaee@huawei.com>
	<20250707150414.620-6-alireza.sanaee@huawei.com>
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

On Mon, 7 Jul 2025 16:04:14 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Update arm-dsu to use the new API, where both "cpus" and "cpu"
> properties are supported.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  drivers/perf/arm_dsu_pmu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index cb4fb59fe04b..7ef204d39173 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -596,11 +596,9 @@ static int dsu_pmu_dt_get_cpus(struct device *dev, cpumask_t *mask)
>  	n = of_count_phandle_with_args(dev->of_node, "cpus", NULL);
>  	if (n <= 0)
>  		return -ENODEV;
> +
>  	for (; i < n; i++) {
> -		cpu_node = of_parse_phandle(dev->of_node, "cpus", i);
> -		if (!cpu_node)
> -			break;
> -		cpu = of_cpu_node_to_id(cpu_node);
> +		cpu = of_cpu_phandle_to_id(dev->of_node, &cpu_node, i);
Same again. 
Does any code actually use the cpu_node?

If not you need a strong justification for ever letting it out of the new
helper.
>  		of_node_put(cpu_node);
>  		/*
>  		 * We have to ignore the failures here and continue scanning

