Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5670CC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Oct 2022 11:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJRLTH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Oct 2022 07:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJRLTF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Oct 2022 07:19:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28AA1BE99;
        Tue, 18 Oct 2022 04:19:04 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MsBB2298Sz686Hq;
        Tue, 18 Oct 2022 19:15:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 18 Oct 2022 13:19:02 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 12:19:02 +0100
Date:   Tue, 18 Oct 2022 12:19:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-perf-users@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v2 2/4] cxl/pci: Find and register CXL PMU devices
Message-ID: <20221018121900.00004ff8@huawei.com>
In-Reply-To: <b3be74ca-aa5e-e3d7-5337-0254d5f42a84@intel.com>
References: <20220824103617.21781-1-Jonathan.Cameron@huawei.com>
        <20220824103617.21781-3-Jonathan.Cameron@huawei.com>
        <b3be74ca-aa5e-e3d7-5337-0254d5f42a84@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 1 Sep 2022 15:36:23 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 8/24/2022 3:36 AM, Jonathan Cameron wrote:
> > CXL PMU devices can be found from entries in the Register
> > Locator DVSEC.
> >
> > In order to register the minimum number of IRQ vectors necessary
> > to support all CPMUs found, separate the registration into two
> > steps.  First find the devices, and query the IRQs used and then
> > register the devices. Between these two steps, request the
> > IRQ vectors necessary and enable bus master support.
> >
> > Future IRQ users for CXL type 3 devices (e.g. DOEs) will need to
> > follow a similar pattern the number of vectors necessary is known
> > before any parts of the driver stack rely on their availability.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >


> > +static int cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds, int vectors)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int rc;
> > +
> > +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
> > +				   PCI_IRQ_MSI | PCI_IRQ_MSIX);
> > +	if (rc < 0)
> > +		return rc;
> > +	if (rc != vectors) {  
> 
> I don't think you'll hit here since you passed in vectors for min and 
> max. You'll get -ENOSPC and return from the earlier check.
> 
> https://elixir.bootlin.com/linux/v6.0-rc3/source/drivers/pci/msi/msi.c#L1005
> 
> DJ
> 

Good point.  This also applies to the version of the same function in
Davidlohr's patch set, so I've cut and paste your comment to there.

Jonathan
