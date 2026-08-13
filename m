Received: from va-2-28.ptr.blmpb.com (va-2-28.ptr.blmpb.com [209.127.231.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECF353EDF
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601104; cv=none; b=sFCc6Q+QqOWfTS/wKUjeRak7YYPdu8YkYzkPJJP3m51aivAESttsoSxDwMp02thsOcXXI3Qv9GKPS2925NKibOuc264s46iFEY3VoXfI1XAII/ULsfhQQ7//YGkBVyTGRi4e/godYHesdTsJ0Gp3X6VKhsB+vdz/d5NFCDi9kzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601104; c=relaxed/simple;
	bh=mmUsEZupYWgEv1ikSwloPPRqj3CGchfagBbsXsVrsNk=;
	h=Subject:Message-Id:In-Reply-To:To:From:Mime-Version:References:Cc:
	 Date:Content-Type; b=PI4T/R8n8V/1Fer83u9Dd7u+gt2z/IAbiXYBRFauY+rJflVyyxUYX0ZgnYQ8H+hP05gqulLdEFlQuwOtgNGwdwjijHATA3iXEwtx4ibaJwVJzMdJr4ftwZEf8V7wEoKV14XBn9U+7G6XIo7lEDyNyhxokz+K0MKv+4uSJ6KpVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=UtvrOEZO; arc=none smtp.client-ip=209.127.231.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="UtvrOEZO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1786601090; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wy7JTPz+xuFrPRklb+y4gtwQ+LyjInDrwDQ324LLPGk=;
 b=UtvrOEZO8ZTfzCPy++o+RWirTYyRzYlfrq1miGh/SoYwYTWL1Xp+HMISlakHGmJ8XQMfcD
 mWsjddcldXtnXtaEOdVjwDCRMKbZXLSKxaRTs8XU8GZDTuaan4J6GK9VeEELNIKcoK/On/
 SC0FbJOoisMSq8LEzWkoRo6FIRym3PyzS61zS9nKI3gwPPU6/PdpLDZZcrNX+Swvi35AhU
 yPDnHcSeqg0hzcEkt0v/SHHAw/kBBO9EIu5rqXxCbb5OXr2DuF4vsg4N1gMrtKHxr4G7pQ
 lsfGzVW57Lh+DfnfEo7L61Hjk//RSJY5ZXXgzu/twUarfLN7cGeaHYGjvlfEzA==
Subject: Re: [PATCH v2 1/2] perf/dwc_pcie: Avoid nested bus notifier locking
Message-Id: <d7ccd4f5-5804-4c0f-992e-48fe6f0efcb0@picoheart.com>
In-Reply-To: <20260811160649.28255-1-zhangzhanpeng.jasper@bytedance.com>
Content-Transfer-Encoding: 7bit
Received: from [100.86.210.149] ([120.234.91.243]) by smtp.feishu.cn with ESMTPS; Thu, 13 Aug 2026 14:04:47 +0800
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811131714.12779-1-zhangzhanpeng.jasper@bytedance.com> <20260811160649.28255-1-zhangzhanpeng.jasper@bytedance.com>
User-Agent: Mozilla Thunderbird
Cc: "Shuai Xue" <xueshuai@linux.alibaba.com>, 
	"Jing Zhang" <renyu.zj@linux.alibaba.com>, <yang.yicong@picoheart.com>, 
	"Will Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, 
	"Baolin Wang" <baolin.wang@linux.alibaba.com>, 
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>, 
	<linux-arm-kernel@lists.infradead.org>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Language: en-US
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
X-Lms-Return-Path: <lba+26a7d5e80+e28c57+vger.kernel.org+yang.yicong@picoheart.com>
Date: Thu, 13 Aug 2026 14:04:45 +0800
Content-Type: text/plain; charset=UTF-8

On 8/12/26 12:06 AM, Zhanpeng Zhang wrote:
> dwc_pcie_pmu_notifier() registers a synthetic platform device directly from
> the BUS_NOTIFY_ADD_DEVICE callback. Bus notifier callbacks run with the
> bus_notifier rwsem held, so platform_device_register_data() enters the
> platform bus notifier chain before the PCI bus notifier returns. When PCI
> host bridges are registered during late init, lockdep reports this as
> possible recursive locking.
> 
> Move platform device reconciliation to a work item that runs after the PCI
> notifier returns. Serialize it with PCI rescan and removal, and parent each
> synthetic device to its Root Port so their lifetimes remain coupled.
> 
> During removal, unregister the perf PMU and its CPU hotplug instance before
> PCI resources disappear, then defer only platform device destruction.
> Disable manual bind controls to preserve that ordering.
> 
> Fixes: af9597adc2f1 ("drivers/perf: add DesignWare PCIe PMU driver")
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

please attach the lockdep warning/trace in the commit for better
understanding the issue..

> ---
> Tested on a RISC-V system with CONFIG_KASAN, CONFIG_PROVE_LOCKING,
> CONFIG_DEBUG_LOCK_ALLOC and CONFIG_LOCKDEP enabled. Late-init PCI discovery
> no longer triggers the nested bus notifier warning.
> 
>  drivers/perf/dwc_pcie_pmu.c | 149 +++++++++++++++++++++++++++---------
>  1 file changed, 113 insertions(+), 36 deletions(-)
> 

[...]

>  
> @@ -815,7 +891,11 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
>  
>  static struct platform_driver dwc_pcie_pmu_driver = {
>  	.probe = dwc_pcie_pmu_probe,
> -	.driver = {.name = "dwc_pcie_pmu",},
> +	.driver = {
> +		.name = "dwc_pcie_pmu",
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,

this looks irrelevant to the issue to resolve. need description here.

I suppose this issue is because both the PMU and the PCIe controller
are on the platform bus, right? If we switch the PMU to the faux device
interface [1] this could be solved?

thanks.

[1] https://lore.kernel.org/all/20260708084507.98242-4-yang.yicong@picoheart.com/
