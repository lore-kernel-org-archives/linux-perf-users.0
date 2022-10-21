Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9948FFA373F
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 17:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJUR0y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJUR0v (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2022 13:26:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828872498A7;
        Fri, 21 Oct 2022 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666373198; x=1697909198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wtXgXABX03UjxiDLcsHFgZveW+3WXgnLLx/+XNeHUEA=;
  b=i5at2Zfxk0vwcRaTVp547ZxU1n6RFQD2k9KExrEfH1kvFbuWKFbpLrWX
   NJOZm7wOfMDCR5EUVvK7DKo4kIeIpeNcPiCJDraJ4F8p6hTVA2ZUY/EvY
   zVaqs5Y+KLT2F5cy7QJry7tVzoZv9cS2PyHqoCfvemL4uOMyl/gQ5kd+b
   KbzpwMrrrLnzSEaLx3RylvzAAU5bo1TqkiU09Dttx7fTM/QBHUxSxc9qt
   xu+Ne4X8u/CpNOWpfFZp4LfYoWfYRz8oDhcb/ofT0tLBSRrS4p/9OYfzX
   GpEAssZJ/ZYlzJDXbybWDL0d9Nd+tes/Fzp/iVM/NfaFt5fdeHls9ncpE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369108970"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="369108970"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 10:26:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="875770040"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="875770040"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.30.144]) ([10.212.30.144])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 10:26:36 -0700
Message-ID: <d48acad7-9805-2f5e-842e-5af9afae00fa@intel.com>
Date:   Fri, 21 Oct 2022 10:26:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [RFC PATCH v2 2/4] cxl/pci: Find and register CXL PMU devices
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linuxarm@huawei.com
References: <20220824103617.21781-1-Jonathan.Cameron@huawei.com>
 <20220824103617.21781-3-Jonathan.Cameron@huawei.com>
 <b3be74ca-aa5e-e3d7-5337-0254d5f42a84@intel.com>
 <20221018121900.00004ff8@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221018121900.00004ff8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 10/18/2022 4:19 AM, Jonathan Cameron wrote:
> On Thu, 1 Sep 2022 15:36:23 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> On 8/24/2022 3:36 AM, Jonathan Cameron wrote:
>>> CXL PMU devices can be found from entries in the Register
>>> Locator DVSEC.
>>>
>>> In order to register the minimum number of IRQ vectors necessary
>>> to support all CPMUs found, separate the registration into two
>>> steps.  First find the devices, and query the IRQs used and then
>>> register the devices. Between these two steps, request the
>>> IRQ vectors necessary and enable bus master support.
>>>
>>> Future IRQ users for CXL type 3 devices (e.g. DOEs) will need to
>>> follow a similar pattern the number of vectors necessary is known
>>> before any parts of the driver stack rely on their availability.
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>
>>> +static int cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds, int vectors)
>>> +{
>>> +	struct device *dev = cxlds->dev;
>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>> +	int rc;
>>> +
>>> +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
>>> +				   PCI_IRQ_MSI | PCI_IRQ_MSIX);
>>> +	if (rc < 0)
>>> +		return rc;
>>> +	if (rc != vectors) {
>> I don't think you'll hit here since you passed in vectors for min and
>> max. You'll get -ENOSPC and return from the earlier check.
>>
>> https://elixir.bootlin.com/linux/v6.0-rc3/source/drivers/pci/msi/msi.c#L1005
>>
>> DJ
>>
> Good point.  This also applies to the version of the same function in
> Davidlohr's patch set, so I've cut and paste your comment to there.

Somehow I totally missed that reviewing his set. Ooops. Thanks!


>
> Jonathan
