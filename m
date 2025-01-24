Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B615733A;
	Fri, 24 Jan 2025 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737701325; cv=none; b=o/+4meykekc3Hat/ETYCCxsG7v2NfFUZoZjHoHYEamHoFR38S1AETnyjmWkh1dyMHfZY6o1ivBva15hCcdemGNUsrnsyPAoJbJw+mLmlwWt8vLw0FekxgIuL+4L8kRbHY2Fv1yjFSbjIOPEyruJAuErzkzRYw5GJIUqcfk3xeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737701325; c=relaxed/simple;
	bh=lNmruJHwZ6KRuIvz2tJ/mGhSxK1fRJJEyvW2O83QYn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmqJoXlHy0YIiphYZu44dvZsVj9kW/4cJQG2Ouj3TNNhxLPohv5vnIoxOFLOfsPUeq1dtlsmkDg0Ch6DeDPPg6tKo15fGsOrD4TsFjCJ+aOZlMtsR+se2+8OsFxPP2y0hGS4fRv60onN+ub78kXXBGdbht39qtSy+mSNVskPSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cSpwT7mQ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cSpwT7mQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737701312; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UUWDcgHyAFM18RO3R6oc8J3erVbUv0Ng/r++00YFCrU=;
	b=cSpwT7mQazfThEg/luWP0X+hTwXpZ6X59LU71Ca76jDRRtXSZWwGyy3z6el+2mRY3XpCXZaSMi/Dz0MNzSLMGSw7crfb/YuWY0mMrWm7WY/klbR5GuY2ji97iVsUop2e2WMI2Z7GZ8t2A4zscLF1IMbYFUotRzH7DebMqxV3ITc=
Received: from 30.246.161.230(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WODip5B_1737701310 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jan 2025 14:48:31 +0800
Message-ID: <31e00081-8695-4ca6-a1ef-af5a007a7565@linux.alibaba.com>
Date: Fri, 24 Jan 2025 14:48:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] perf/dwc_pcie: fix duplicate pci_dev
 devices
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250123074830.90923-1-cuiyunhui@bytedance.com>
 <344c53cd-d856-4c03-9deb-743b65acd8aa@linux.alibaba.com>
 <CAEEQ3wmDej9bbPUmkx-ZrD4FG9Z7gTHMeCrVszx64g90O0RyiQ@mail.gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CAEEQ3wmDej9bbPUmkx-ZrD4FG9Z7gTHMeCrVszx64g90O0RyiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/24 10:56, yunhui cui 写道:
> Hi Shuai,
> 
> On Thu, Jan 23, 2025 at 5:50 PM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2025/1/23 15:48, Yunhui Cui 写道:
>>> During platform_device_register, wrongly using struct device
>>> pci_dev as platform_data caused a kmemdup copy of pci_dev. Worse
>>> still, accessing the duplicated device leads to list corruption as its
>>> mutex content (e.g., list, magic) remains the same as the original.
>>>
>>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>>> ---
>>>    drivers/perf/dwc_pcie_pmu.c | 25 ++++++++++++++++++-------
>>>    1 file changed, 18 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
>>> index cccecae9823f..8b208f287a1f 100644
>>> --- a/drivers/perf/dwc_pcie_pmu.c
>>> +++ b/drivers/perf/dwc_pcie_pmu.c
>>> @@ -565,9 +565,7 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
>>>        u32 sbdf;
>>>
>>>        sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
>>> -     plat_dev = platform_device_register_data(NULL, "dwc_pcie_pmu", sbdf,
>>> -                                              pdev, sizeof(*pdev));
>>> -
>>> +     plat_dev = platform_device_register_simple("platform_dwc_pcie", sbdf, NULL, 0);
>>>        if (IS_ERR(plat_dev))
>>>                return PTR_ERR(plat_dev);
>>>
>>> @@ -614,19 +612,32 @@ static struct notifier_block dwc_pcie_pmu_nb = {
>>>
>>>    static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>>>    {
>>> -     struct pci_dev *pdev = plat_dev->dev.platform_data;
>>> +     struct pci_dev *pdev = NULL;
>>>        struct dwc_pcie_pmu *pcie_pmu;
>>> +     bool found = false;
>>>        char *name;
>>>        u32 sbdf;
>>>        u16 vsec;
>>>        int ret;
>>>
>>> +     for_each_pci_dev(pdev) {
>>> +             sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
>>> +             if (sbdf == plat_dev->id) {
>>> +                     found = true;
>>> +                     break;
>>> +             }
>>> +     }
>>> +     if (!found) {
>>> +             pr_err("The plat_dev->id does not match the sbdf");
>>> +             return -ENODEV;
>>> +     }
>>> +
>>
>> How about using pci_get_domain_bus_and_slot() to find pci_dev?
> It's not necessary. pci_get_domain_bus_and_slot also invokes
> for_each_pci_dev, and it further requires splitting the sbdf.

Compose sbdf from domain, bus number, and devfn is almost essentially
corresponding opposite operation. And I think we should grab a reference
count of pdev and handle it properly.

Personally speaking, I prefer pci_get_domain_bus_and_slot() because it is
simple and robust.

> 
>>
>>>        vsec = dwc_pcie_des_cap(pdev);
>>>        if (!vsec)
>>>                return -ENODEV;
>>>
>>>        sbdf = plat_dev->id;
>>> -     name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
>>> +     name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%d_pmu", sbdf);
>>
>> A new name will break previous user tools.
> This name isn't suitable. It can't clearly show which is the PMU
> device. Userspace tools don't have binding relationships, like perf.
> Tools must traverse PMU devices before use.

The device is under /sys/bus/event_source/ which indates it is PMU device.
As far as I know, most of PMU devices do not endup with a '_pmu' prefix.

Thanks.

Shuai

