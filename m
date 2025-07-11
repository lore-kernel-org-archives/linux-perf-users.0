Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C227A461;
	Fri, 11 Jul 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226250; cv=none; b=dE4bKL8ig1i9UsZNXfxv+itUm5KuoYXfigMc5UBhDyQJNRpBIbsSISmH7rsNqc0+DEEiWsi93leWwMSyEQUvjU5ilh0x88SOiRH9E+VhqspiurueHAy9B2MGSmZeSlqeOOyd/ZI5ZGN2lazQXgflPI10N/7WjThlYbfAKHcGxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226250; c=relaxed/simple;
	bh=oHSkqonOAsDtx1SKkt+1nQIG/xW65Zx1yJ6/UVVszXE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUl/HUcBSyYqA+AkWxpEtaNLEF1KwKedQinycgFm+2gNCWMJYa9L1BdP9MFei7AiV0EGHMnc2cPJsD0hhQvOz6n3fjjKSq340jQ6o7GJxeoruCfltbNQ9FXqTyKQcsmRv+aDV4vTQJJIf+61PI9rOJtJ2oAJR+dTCTlGgU7OVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdmdX0nZxz6GBQk;
	Fri, 11 Jul 2025 17:29:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 970991402EF;
	Fri, 11 Jul 2025 17:30:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 11:30:45 +0200
Date: Fri, 11 Jul 2025 10:30:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <krzk@kernel.org>, <robh@kernel.org>, <coresight@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 4/5] coresight: Use of_cpu_phandle_to_id for grabbing
 CPU id
Message-ID: <20250711103044.000024f0@huawei.com>
In-Reply-To: <20250708151502.561-5-alireza.sanaee@huawei.com>
References: <20250708151502.561-1-alireza.sanaee@huawei.com>
	<20250708151502.561-5-alireza.sanaee@huawei.com>
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

On Tue, 8 Jul 2025 16:15:01 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Use the newly created API to grab CPU id.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

We could just squash this to the call site, however it is in
an if / else if with the much larger acpi equivalent call so
probably worth keeping this trivial helper.
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 0db64c5f4995..95d46ea08936 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -167,20 +167,7 @@ of_coresight_get_output_ports_node(const struct device_node *node)
>  
>  static int of_coresight_get_cpu(struct device *dev)
>  {
> -	int cpu;
> -	struct device_node *dn;
> -
> -	if (!dev->of_node)
> -		return -ENODEV;
> -
> -	dn = of_parse_phandle(dev->of_node, "cpu", 0);
> -	if (!dn)
> -		return -ENODEV;
> -
> -	cpu = of_cpu_node_to_id(dn);
> -	of_node_put(dn);
> -
> -	return cpu;
> +	return of_cpu_phandle_to_id(dev->of_node, NULL, 0);
>  }
>  
>  /*

