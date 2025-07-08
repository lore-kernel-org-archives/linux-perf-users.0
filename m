Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C61223DC6;
	Tue,  8 Jul 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962962; cv=none; b=hLcu4XRUrePxnhNK624E8gtc5YISERZukPG/vgZqNkRFQxNiKFk2UgKs+ASi6kNqyEUbedn4Z/fixEdBfiHrEPjj/k5jMoQ4+dLin6iYohyxbq7xruSVMQksLZTuRzdaeuGdlmc2NVNEQ9YtieuqT7XwwnpM5yTpoi/lhqDRIYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962962; c=relaxed/simple;
	bh=K45xL/e5RcHsYP2b7YztImc3yubWmYwPqOvKCVSyuxk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3wDHmFFhJqsNAXcLMAq0nDADrwSidcxE2iSrW5NkhnbTThEK3Ezjwi/CNgadkuMfxLHmE4LNm2WsR+OCzrCoWldnOAe/PWRTOYDCM2ninL78DBDCweVgqVlaWg0bIeM4cfjH5+L7xE75u8Utq0AvEaYbWMD8VUJpwzxXSlS7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbvGR4w7yz6GCk0;
	Tue,  8 Jul 2025 16:21:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 762A41404C5;
	Tue,  8 Jul 2025 16:22:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Jul
 2025 10:22:35 +0200
Date: Tue, 8 Jul 2025 09:22:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Alireza Sanaee <alireza.sanaee@huawei.com>, <mark.rutland@arm.com>,
	<robh@kernel.org>, <coresight@lists.linaro.org>,
	<devicetree@vger.kernel.org>, <dianders@chromium.org>,
	<james.clark@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linuxarm@huawei.com>, <mike.leach@linaro.org>, <ruanjinjie@huawei.com>,
	<saravanak@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<suzuki.poulose@arm.com>
Subject: Re: [PATCH 2/5] arch_topology: update CPU map to use the new API
Message-ID: <20250708092234.00006fd5@huawei.com>
In-Reply-To: <ca58608c-c147-45a7-910f-41a7c312fd5a@kernel.org>
References: <20250707150414.620-1-alireza.sanaee@huawei.com>
	<20250707150414.620-3-alireza.sanaee@huawei.com>
	<ca58608c-c147-45a7-910f-41a7c312fd5a@kernel.org>
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

On Tue, 8 Jul 2025 08:29:43 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 07/07/2025 17:04, Alireza Sanaee wrote:
> > Cleans up the cpu-map generation using the created API.
> > 
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > ---
> >  drivers/base/arch_topology.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 3ebe77566788..88970f13f684 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -518,23 +518,23 @@ core_initcall(free_raw_capacity);
> >   */
> >  static int __init get_cpu_for_node(struct device_node *node)
> >  {
> > +	struct device_node *cpu_node __free(device_node) = NULL;  
> 
> 
> That's not a correct style anymore. What's more it is not really
> explained anywhere. Follow standard cleanup.h rules (constructor).

There isn't a good solution in this case as the constructor is via
a pointer passed as an argument. I'd just fall back to not using
__free here and instead doing a manual put of the node in the
paths where it is set.   That might just be the final successful
return path - I've not checked closely.

> 
> 
> Best regards,
> Krzysztof

