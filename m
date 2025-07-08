Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF81E231E;
	Tue,  8 Jul 2025 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963793; cv=none; b=c8q4iA/7bHojxJ5m1emvxUB5LDoPOMuGuGcAdzWv2yMjXSj46fac5DBWCLSngJ88qnQefc9uR7DvDFJ8/ibSoj5lsR53OGhtqxBBfAGsZHdsLmcPP5zySh/SgHErN7HYf7xNX2JARhMHhMEG9QFCRCvz6DB9rWOTJ+97YWxucbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963793; c=relaxed/simple;
	bh=+8yY2enQfCExqPNzs6aFkaOEm+G9mEhU3L0C7FCYfcc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fA3d7jsig96w34QhMMajF0ushC7irbmNOYwIl9n8+MU87eMUJPlqY5AfKrOp0kuGnOb5nRFCJ5Nt8epUCgfvvJWPqa4dqC1yiswg5ygA+uEsn3VgfIHKAt7y2eg1vFd+BmpkZ1R8mgV3tCvFu+3VBjTNe4dPo4qQUa4F+nwyl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbvWc5xZwz6GDJX;
	Tue,  8 Jul 2025 16:33:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DEF74140144;
	Tue,  8 Jul 2025 16:36:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Jul
 2025 10:36:25 +0200
Date: Tue, 8 Jul 2025 09:36:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <mark.rutland@arm.com>, <robh@kernel.org>, <coresight@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linuxarm@huawei.com>,
	<mike.leach@linaro.org>, <ruanjinjie@huawei.com>, <saravanak@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <suzuki.poulose@arm.com>
Subject: Re: [PATCH 3/5] coresight: cti: Use of_cpu_phandle_to_id for
 grabbing CPU id
Message-ID: <20250708093623.0000363e@huawei.com>
In-Reply-To: <20250707150414.620-4-alireza.sanaee@huawei.com>
References: <20250707150414.620-1-alireza.sanaee@huawei.com>
	<20250707150414.620-4-alireza.sanaee@huawei.com>
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

On Mon, 7 Jul 2025 16:04:12 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Use the newly created API to grab CPU id.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Here is the justification for allowing the node parameter to be null.

> ---
>  .../hwtracing/coresight/coresight-cti-platform.c  | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index d0ae10bf6128..cd821e926792 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -41,21 +41,12 @@
>   */
>  static int of_cti_get_cpu_at_node(const struct device_node *node)
>  {
> +	struct device_node *dn = NULL;
>  	int cpu;
> -	struct device_node *dn;
>  
> -	if (node == NULL)
> -		return -1;
> -
> -	dn = of_parse_phandle(node, "cpu", 0);
> -	/* CTI affinity defaults to no cpu */
> -	if (!dn)
> -		return -1;
> -	cpu = of_cpu_node_to_id(dn);
> +	cpu = of_cpu_phandle_to_id(node, &dn, 0);
>  	of_node_put(dn);

With change suggested on patch 1 this becomes

static int of_cti_get_cpu_at_node(const struct device_node *node)
{
	int cpu = of_cpu_phandle_to_id(node, NULL, 0);

	return (cpu < 0) ? -1 : cpu;
}

> -
> -	/* No Affinity  if no cpu nodes are found */
> -	return (cpu < 0) ? -1 : cpu;
> +	return cpu;

This an result in -ENODEV hence juggle above.  No idea
why the caller will care but I guess it does or this code
would not be here!

>  }
>  
>  #else

