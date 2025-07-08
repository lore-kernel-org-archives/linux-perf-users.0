Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049A219A97;
	Tue,  8 Jul 2025 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963838; cv=none; b=hBl+sia7BoO5myZgu7K1cxWoyp6BbHFehVTGJIUIeMCWzWFmyA6G5M+1RPv6apGdEsYZfEKM4hnHBnB7iRJRNGDsRHdw4u1TUilA4XTHhW5xOcO1fqMo81JAXtDhihSIqO5zVWebesXPa6GP5BZTJcaw6fluAOjbd4Uzr7tEGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963838; c=relaxed/simple;
	bh=wFDxQyPXL6g3MFe3QXSf3Z855OPz+p2schpO6F/9y6g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+kIkP5c6eg3j5DjZGMMhRr5O+8UWQGvZRNdYd8if4KjeqypM9kK/R1Ch/IVCJrwO8+tgaxiFCtZjx/RtWpsqsJ/wwRrzzBP3Ux9sL6lHngSp8t9xf4+YTw35A7TH7oNHIxNHIOK/hrjMwtVY0he0ZwWwDbVmL9quhVqu56HS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbvbK3p00z6GCjV;
	Tue,  8 Jul 2025 16:36:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 54F2E140144;
	Tue,  8 Jul 2025 16:37:14 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Jul
 2025 10:37:13 +0200
Date: Tue, 8 Jul 2025 09:37:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <mark.rutland@arm.com>, <robh@kernel.org>, <coresight@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linuxarm@huawei.com>,
	<mike.leach@linaro.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: Re: [PATCH 4/5] coresight: Use of_cpu_phandle_to_id for grabbing
 CPU id
Message-ID: <20250708093711.0000295d@huawei.com>
In-Reply-To: <20250707150414.620-5-alireza.sanaee@huawei.com>
References: <20250707150414.620-1-alireza.sanaee@huawei.com>
	<20250707150414.620-5-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 7 Jul 2025 16:04:13 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Use the newly created API to grab CPU id.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 8192ba3279f0..f032fdbe959b 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -167,19 +167,9 @@ of_coresight_get_output_ports_node(const struct device_node *node)
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
> +	struct device_node *dn = NULL;
> +	int cpu = of_cpu_phandle_to_id(dev->of_node, &dn, 0);
>  	of_node_put(dn);
> -
	Again, allowing for NULL parameter gives you simply

	return of_cpu_phandle_to_id(dev->of_node, NULL, 0);

>  	return cpu;
>  }
>  

