Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339A4C43217
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 08:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJUIxd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Oct 2022 04:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJUIx3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2022 04:53:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189852505F1;
        Fri, 21 Oct 2022 01:53:23 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MtyH851RTz67ww1;
        Fri, 21 Oct 2022 16:26:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:29:46 +0200
Received: from localhost (10.81.215.159) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 09:29:45 +0100
Date:   Fri, 21 Oct 2022 09:29:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-perf-users@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v3 3/5] cxl/pci: Find and register CXL PMU devices
Message-ID: <20221021092942.000050f5@huawei.com>
In-Reply-To: <20221020224424.xj4onq44rqlbxk23@offworld>
References: <20221018121318.22385-1-Jonathan.Cameron@huawei.com>
        <20221018121318.22385-4-Jonathan.Cameron@huawei.com>
        <20221020224424.xj4onq44rqlbxk23@offworld>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.215.159]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 20 Oct 2022 15:44:24 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Tue, 18 Oct 2022, Jonathan Cameron wrote:
> 
> > static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > {
> >+	struct cxl_cpmu_regs *cpmu_regs_array = NULL;
> >	struct cxl_register_map map;
> >	struct cxl_memdev *cxlmd;
> >	struct cxl_dev_state *cxlds;
> >-	int rc;
> >+	int i, rc, cpmu_count;
> >
> >	/*
> >	 * Double check the anonymous union trickery in struct cxl_regs
> >@@ -561,11 +567,54 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >	if (rc)
> >		return rc;
> >
> >+	/*
> >+	 * Before registering sub devices that use interrupts, the maximum
> >+	 * interrupt used on the device should be established to allow the correct
> >+	 * number of irq vectors to be requested. Separate the registration process
> >+	 * into before / after interrupt vector request.
> >+	 */
> >+	cpmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_CPMU);
> >+	if (cpmu_count) {
> >+		cpmu_regs_array = kmalloc_array(cpmu_count, sizeof(cpmu_regs_array),
> >+						GFP_KERNEL);
> >+		if (!cpmu_regs_array)
> >+			return -ENOMEM;  
> 
> I don't think failure specific to the cpmu stuff should fail the general pci probing.
> That includes memory allocation, which can then fail again somewhere else and properly
> handle it.
> 

So we've had several discussions about this and differing opinions.

To restate my view...

Partial failure is extremely fragile and leads to lots of complex error
paths each of which needs to be tested.  Right now about 50% of the time that
I hit an error path in testing (due to kernel or emulation bugs) the
kernel driver goes splat because of a wrong assumption around the fallout
of those errors. So far I haven't even bothered figuring most of those
out - focusing instead on the root cause.

I may have been involved in a bias sample of kernel drivers
but my experience is only time you'd normally muddle on is over strictly
debug features (debugfs etc). Otherwise you are just hiding bugs that should
have been fixed.

Anyhow, sure I'll change this for next version.

This series isn't going anywhere until we resolve the interrupt
registration question.  Is the hack in here bad enough to imply that
unified registration is a bad idea or not?

My view is the below makes it clear that generic approach doesn't make sense
as it met reality which turned out to be more complex than we were
thinking it was!

Jonathan

p.s. Good to get review of other aspects in meantime though!



> Thanks,
> Davidlohr
> 
> >+	}
> >+
> >+	/* Pass one - just enough to find out what interrupts are used */
> >+	cxlds->cpmu_max_vector = -1;
> >+	for (i = 0; i < cpmu_count; i++) {
> >+		int irq;
> >+
> >+		rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_CPMU, &map, i);
> >+		if (rc) {
> >+			kfree(cpmu_regs_array);
> >+			return rc;
> >+		}
> >+
> >+		rc = cxl_map_cpmu_regs(pdev, &cpmu_regs_array[i], &map);
> >+		if (rc) {
> >+			kfree(cpmu_regs_array);
> >+			return rc;
> >+		}
> >+
> >+		irq = cxl_cpmu_get_irq(&cpmu_regs_array[i]);
> >+		cxlds->cpmu_max_vector = max(cxlds->cpmu_max_vector, irq);
> >+	}
> >+
> >	if (!cxl_pci_alloc_irq_vectors(cxlds)) {
> >		cxlds->has_irq = true;
> >+		pci_set_master(pdev);
> >	} else
> >		cxlds->has_irq = false;
> >
> >+	/* Pass 2 - register the CPMU instances, currently no support without interrupts */
> >+	if (cxlds->has_irq) {
> >+		for (i = 0; i < cpmu_count; i++)
> >+			devm_cxl_cpmu_add(cxlds->dev, &cpmu_regs_array[i], i);
> >+	}
> >+	kfree(cpmu_regs_array);
> >+
> >	cxlmd = devm_cxl_add_memdev(cxlds);
> >	if (IS_ERR(cxlmd))
> >		return PTR_ERR(cxlmd);
> >--
> >2.37.2
> >  

