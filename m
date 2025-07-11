Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561C20C010;
	Fri, 11 Jul 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226130; cv=none; b=aJG8St9Ss8fJkGCqEh0uiJ/cStfdJbxFKyEQTBWW+izQsrGQKBPKmroAhP/Ot7dKlJrHRc5zRpg+TeS/TTS1XUOujlRD+IRsCLJqOpEcYbg+RlouMFVcxKKFG5iXf3tNNoRWDvnrb8R3+J/K7vqjdJyus/WId58y9slE9Uw/WYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226130; c=relaxed/simple;
	bh=rSprIdGWjTHC6TnfIZNhTFnPYKw6H5+iYgR4s9jbKWo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNhJyHLlllY0Whp7BDg+C77dlY7bLn8LckC8GEI4qam53wI1L8aIQhshKcYDAxmJuaeuBY+chYMG+D8UaCpaFu7JpocG0PdmlQ17nkQWxm7HTo95CsUJSLCHiAdwpz6BhkkbWziMg4ch2wqOlFEdah72JC1TKf0NnGJaVjVmKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdmXS37K6z6L4yR;
	Fri, 11 Jul 2025 17:25:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2177D14020C;
	Fri, 11 Jul 2025 17:28:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 11:28:45 +0200
Date: Fri, 11 Jul 2025 10:28:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <krzk@kernel.org>, <robh@kernel.org>, <coresight@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mark.rutland@arm.com>, <mike.leach@linaro.org>,
	<ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 3/5] coresight: cti: Use of_cpu_phandle_to_id for
 grabbing CPU id
Message-ID: <20250711102843.000003e6@huawei.com>
In-Reply-To: <20250708151502.561-4-alireza.sanaee@huawei.com>
References: <20250708151502.561-1-alireza.sanaee@huawei.com>
	<20250708151502.561-4-alireza.sanaee@huawei.com>
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

On Tue, 8 Jul 2025 16:15:00 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Use the newly created API to grab CPU id.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  .../hwtracing/coresight/coresight-cti-platform.c   | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index d0ae10bf6128..e1dc559d54aa 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -41,20 +41,8 @@
>   */
>  static int of_cti_get_cpu_at_node(const struct device_node *node)
>  {
> -	int cpu;
> -	struct device_node *dn;
> +	int cpu = of_cpu_phandle_to_id(node, NULL, 0);

Could do a single line - kind of down to coresight maintainers preference though!

	return (of_cpu_phandle_to_id(node, NULL, 0) < 0) ? -1; cpu;

+CC Suzuki (you got the two reviewers in the +CC but not the maintainer)


>  
> -	if (node == NULL)
> -		return -1;
> -
> -	dn = of_parse_phandle(node, "cpu", 0);
> -	/* CTI affinity defaults to no cpu */
> -	if (!dn)
> -		return -1;
> -	cpu = of_cpu_node_to_id(dn);
> -	of_node_put(dn);
> -
> -	/* No Affinity  if no cpu nodes are found */
>  	return (cpu < 0) ? -1 : cpu;
>  }
>  

