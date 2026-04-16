Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8938F64A
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334238; cv=none; b=HRv1AcChh4Sg/ezmTiuRYHXTDrwQ1f/lj0+DM+6uWvbqT4AJBSohf6UzR6GfHVkWI8+lg6oKEfbArqgsyxpb9+jVQQ7bp4Tk9y4Pray5Q/prWia2JKwW0/v7B+G7WHzh2mFvRjnoNxN6nszciXNDu9pzr6M4N7b+e2Ap/p91d/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334238; c=relaxed/simple;
	bh=fUW1Nks1X2mTcovG/s8cOh6BnWk2+vNCjZ3XdZZTfY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C02JaPo0YCjKIJhpkEbfke0bcGPa16FTwSWNBKPM4RVtn75xtfH1rFT6nL3eJjm7VJz8CH1LZ1yL0jxwiQb3CVUfvJRm+BYfUOrMbajg9CGHihMSVyB/RelCXRDVZmnpigalKJTZ9eOiWJnHbgkOD+j7ynAUvfn+fgYy7gv+pZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WDQ0QxS6; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WDQ0QxS6"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fUW1Nks1X2mTcovG/s8cOh6BnWk2+vNCjZ3XdZZTfY0=;
	b=WDQ0QxS6T7NkPy+9kx2flk3wLyKKbm4eyRmRmAVTv7vvDRafi87K9po7ZU/8gX7nmhFdvFG5+
	ED2/aKfPLAq0GVnEJnPDAljA0MkjGXuR14Vd7WRf5vc6H3/OtuI6PDTgqaKmiEfzGYKitvxVGu+
	bLVCVZxurlXak+Ax7ehhWN4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fxDBQ6cfhzRhVL;
	Thu, 16 Apr 2026 18:04:14 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id E1AEB4056D;
	Thu, 16 Apr 2026 18:10:33 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 18:10:33 +0800
Received: from [10.67.120.139] (10.67.120.139) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Apr 2026 18:10:33 +0800
Message-ID: <81cde3ab-8349-4672-a806-4cba480c853f@huawei.com>
Date: Thu, 16 Apr 2026 18:10:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PMU driver maintainer to
 Yushan Wang
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Jie Zhan <zhanjie9@hisilicon.com>, Will Deacon
	<will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
CC: <jic23@kernel.org>, Linuxarm <linuxarm@huawei.com>
References: <20260416095110.25612-1-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Yushan Wang <wangyushan12@huawei.com>
In-Reply-To: <20260416095110.25612-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)

On 4/16/2026 5:51 PM, Jonathan Cameron wrote:
> Replace myself with Yushan Wang who is very familiar with the HiSilicon PMU
> drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It's privileged to have your guidance, thanks a lot!

Acked-by: Yushan Wang <wangyushan12@huawei.com>

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f..8b95a43527fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11563,7 +11563,7 @@ F:    Documentation/devicetree/bindings/net/hisilicon*.txt
>  F:   drivers/net/ethernet/hisilicon/
>
>  HISILICON PMU DRIVER
> -M:   Jonathan Cameron <jonathan.cameron@huawei.com>
> +M:   Yushan Wang <wangyushan12@huawei.com>
>  S:   Supported
>  W:   http://www.hisilicon.com
>  F:   Documentation/admin-guide/perf/hisi-pcie-pmu.rst


