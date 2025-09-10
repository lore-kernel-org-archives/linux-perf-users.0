Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8B13375B1;
	Wed, 10 Sep 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521718; cv=none; b=gZzVW1p6eETeBOY3WNQDIc+DsK2BeDlhEQkickqUhqxMYk5pUYFeInfLrSDBc2wDYIBIv82dLV8TJhDCFx2j27UaYrj16QVxPWKlmZaDjPZijC8ZzZkATxfBpRb5yZGv166JeMk7dMeJ5FB6inIXWAkAA7MdvgpufvUbuis+SLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521718; c=relaxed/simple;
	bh=kN31Jd5Gb7ixPmlsVylf4ZIzZx4FKcpzJLV1GiMFb5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyu08slBeh58WCVL0McjzYXoVzhsqVi53jWdgAOwlzD2wfr23PCwF86+UVd/u+6NVQgjtunySgb5HAt51KGMZTPGYwFTu0LaLEy/WOys4JtNS8M4w2gcDwhuccc6sW4fNWBN6wnzHcHCeu34Ru8jVYeM0UoAKigtUsf5voo/nIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B95F16F2;
	Wed, 10 Sep 2025 09:28:28 -0700 (PDT)
Received: from [10.57.5.181] (unknown [10.57.5.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D1B73F63F;
	Wed, 10 Sep 2025 09:28:33 -0700 (PDT)
Message-ID: <0c04e952-0b11-4249-9588-85edd0859bfd@arm.com>
Date: Wed, 10 Sep 2025 17:28:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] coresight: cti: Use of_cpu_phandle_to_id for
 grabbing CPU id
Content-Language: en-GB
To: Alireza Sanaee <alireza.sanaee@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org, dianders@chromium.org,
 james.clark@linaro.org, jonathan.cameron@huawei.com, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linuxarm@huawei.com, mark.rutland@arm.com, mike.leach@linaro.org,
 robh@kernel.org, ruanjinjie@huawei.com, saravanak@google.com
References: <20250905161830.37-1-alireza.sanaee@huawei.com>
 <20250905161830.37-5-alireza.sanaee@huawei.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250905161830.37-5-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2025 17:18, Alireza Sanaee wrote:
> Use the newly created API (of_cpu_phandle_to_id) to grab CPU ID.
> 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   .../hwtracing/coresight/coresight-cti-platform.c    | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index d0ae10bf6128..2629962dbe3e 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -41,18 +41,7 @@
>    */
>   static int of_cti_get_cpu_at_node(const struct device_node *node)
>   {
> -	int cpu;
> -	struct device_node *dn;
> -
> -	if (node == NULL)
> -		return -1;
> -
> -	dn = of_parse_phandle(node, "cpu", 0);
> -	/* CTI affinity defaults to no cpu */
> -	if (!dn)
> -		return -1;
> -	cpu = of_cpu_node_to_id(dn);
> -	of_node_put(dn);
> +	int cpu = of_cpu_phandle_to_id(node, NULL, 0);
>   
>   	/* No Affinity  if no cpu nodes are found */
>   	return (cpu < 0) ? -1 : cpu;

Assuming this is going in via DT tree:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki

